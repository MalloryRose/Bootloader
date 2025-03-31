#Bootloader Development for x86 and ARM

##Overview

This project focuses on developing custom bootloaders for both x86 and ARM architectures. The bootloaders are designed to load and display a message from an external binary file via the UART protocol. This required low-level assembly programming, memory-mapped I/O, and system initialization techniques.

##Key Features

Cross-Platform Support: Implemented bootloaders for both x86 and ARM architectures.

UART Communication: Used port-mapped I/O for x86 and memory-mapped registers for ARM (Akita platform).

Automated Build System: Developed a Makefile to streamline compilation and execution for each architecture.

QEMU Emulation: Used QEMU to test bootloader functionality without physical hardware.

##Why I Built This

I undertook this project to deepen my understanding of bootloader development and compare the boot process between x86 and ARM architectures. While I had prior experience with ARM, I wanted to explore x86-specific aspects such as real mode, port-mapped I/O, and legacy system boot processes. Through this project, I strengthened my low-level programming skills and enhanced my knowledge of system-level development across different hardware platforms.

##Implementation Details

x86 Bootloader

Implemented in assembly with port-mapped I/O for UART communication.

Operates in real mode and loads lemon_log.bin from memory.

Displays message via UART in the terminal.

ARM Bootloader

Uses memory-mapped I/O specific to the Akita platform.

Configures UART registers for communication.

Tested on both Akita and Raspberry Pi 2 to analyze hardware-specific differences.

Build System

A Makefile automates assembly, linking, and binary generation.

Supports both x86 and ARM architectures.

##Testing

Testing was performed using QEMU, allowing simulation of both x86 and ARM platforms:

x86 Testing

Loaded bootloader and lemon_log.bin into memory.

Verified correct message display via UART.

Used instruction tracing (-d in_asm) to debug execution flow.

ARM Testing

Ran the bootloader on the Akita platform and Raspberry Pi 2.

Examined register interactions and hardware-specific behavior.

Ensured proper UART communication and message output.

How to Build and Run

# Clone the repository
git clone https://github.com/yourusername/bootloader-project.git
cd bootloader-project

# Build the bootloader for x86
make x86

# Run the x86 bootloader in QEMU
qemu-system-i386 -drive format=raw,file=bootloader_x86.bin -serial stdio

# Build the bootloader for ARM
make arm

# Run the ARM bootloader in QEMU
qemu-system-arm -M versatilepb -kernel bootloader_arm.bin -serial stdio

Future Enhancements

Expand testing to more ARM platforms.

Implement support for loading larger files.

Optimize UART communication routines for better efficiency.

License

This project is open-source and available under the MIT License.

Developed by Your Name

