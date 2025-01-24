.code16
.global _main

# constants
.set UART_TXB_ADDR, 0x3F8
.set UART_LSR_ADDR, 0x3FE
.set UART_LSR_TX_BIT, 0x20
.set TTY_MODE, 0x0E
.set TTY_INT, 0x10
.set MEM_MAP_ADDR, 0x0500

.text
# entry point

_main:
    jmp _uart_start


_uart_start:
    mov $MEM_MAP_ADDR, %bx

_uart_tx:
    mov (%bx), %al
    cmp $0, %al
    je _end
    mov $UART_TXB_ADDR, %dx
    out %al, (%dx)

_uart_tx_poll:
    in $UART_LSR_ADDR, %al
    and $UART_LSR_TX_BIT, %al
    jz _uart_tx_poll
    inc %bx
    jmp _uart_tx

_end:
    hlt


.fill 510-(.-_main), 1, 0
.word 0xAA55
