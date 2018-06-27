BUILD_DIR = build
SRC_DIR = src
OBJ = $(BUILD_DIR)/boot.o $(BUILD_DIR)/kernel.o $(BUILD_DIR)/irq.o $(BUILD_DIR)/irq_high_level.o
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra -masm=intel

all:$(BUILD_DIR)/kernel


$(BUILD_DIR)/kernel:$(OBJ) linker.ld
	i686-elf-gcc -T linker.ld -o $(BUILD_DIR)/os.bin -ffreestanding -O2 -nostdlib $(OBJ) -lgcc

$(BUILD_DIR)/kernel.o:$(SRC_DIR)/kernel.c
	i686-elf-gcc -c $(SRC_DIR)/kernel.c -o $(BUILD_DIR)/kernel.o $(CFLAGS)

$(BUILD_DIR)/boot.o:$(SRC_DIR)/boot.asm
	nasm -felf32 $(SRC_DIR)/boot.asm -o $(BUILD_DIR)/boot.o

$(BUILD_DIR)/irq.o:$(SRC_DIR)/irq.asm
	nasm -felf32 $(SRC_DIR)/irq.asm -o $(BUILD_DIR)/irq.o

$(BUILD_DIR)/irq_high_level.o:$(SRC_DIR)/irq_high_level.c
	i686-elf-gcc -c $(SRC_DIR)/irq_high_level.c -o $(BUILD_DIR)/irq_high_level.o $(CFLAGS)


clean:
	rm build/*
