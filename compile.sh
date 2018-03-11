nasm -g -f elf64 -l hello_world.lst hello_world.asm
ld -o hello_world hello_world.o
nasm -g -f elf64 -l print_args.lst print_args.asm
ld -o print_args print_args.o
nasm -g -f elf64 -l read_file.lst read_file.asm
ld -o read_file read_file.o
nasm -g -f elf64 -l main.lst main.asm
ld -o main main.o
nasm -g -f elf64 -l test.lst test.asm
ld -o test test.o
