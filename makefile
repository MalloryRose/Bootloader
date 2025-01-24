# Variables for ARM
AS_ARM = arm-none-eabi-as
LD_ARM = arm-none-eabi-ld
OBJCPY_ARM = arm-none-eabi-objcopy
ARM_IMAGE_NAME = akita_image.bin

# Variables for x86
AS_X86 = as
LD_X86 = ld
X86_IMAGE_NAME = i386_image.bin

# Directories
OUTPUT_DIR = .
SRC_DIR = src

# Clean up build artifacts
clean:
	@echo 'Removing build files...'
	rm -rf $(OUTPUT_DIR)/*.bin
	rm -rf $(OUTPUT_DIR)/*.elf
	rm -rf $(OUTPUT_DIR)/*.o

# Build the ARM bootloader
arm_loader: $(SRC_DIR)/bootloader.s
	@echo 'Assembling bootloader code for ARM...'
	$(AS_ARM) -o $(OUTPUT_DIR)/bootloader_arm.o $(SRC_DIR)/bootloader.s
	$(LD_ARM) -Ttext=0x0000 -o $(OUTPUT_DIR)/bootloader_arm.elf $(OUTPUT_DIR)/bootloader_arm.o
	$(OBJCPY_ARM) -O binary --only-section=.text $(OUTPUT_DIR)/bootloader_arm.elf $(OUTPUT_DIR)/$(ARM_IMAGE_NAME)

# Build the x86 bootloader
x86_loader: $(SRC_DIR)/bootloader.s
	@echo 'Assembling bootloader code for x86...'
	$(AS_X86) --32 -o $(OUTPUT_DIR)/bootloader_x86.o $(SRC_DIR)/bootloader.s
	$(LD_X86) -m elf_i386 -Ttext=0x7c00 --oformat binary -o $(OUTPUT_DIR)/$(X86_IMAGE_NAME) $(OUTPUT_DIR)/bootloader_x86.o

# Run the bootloader in QEMU for ARM
qemu_arm: arm_loader
	@echo 'Running ARM bootloader in QEMU...'
	qemu-system-arm -M akita -nographic -device loader,file=assets/lemon_log.bin,addr=0x0500 -device loader,file=$(OUTPUT_DIR)/$(ARM_IMAGE_NAME),addr=0x0000

# Run the bootloader in QEMU for x86
qemu_x86: x86_loader
	@echo 'Running x86 bootloader in QEMU...'
	qemu-system-i386 -nographic -device loader,file=assets/lemon_log.bin,addr=0x0500 -drive file=$(OUTPUT_DIR)/$(X86_IMAGE_NAME),format=raw

# Default target to build both ARM and x86
all: arm_loader x86_loader
