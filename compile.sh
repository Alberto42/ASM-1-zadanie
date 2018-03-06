nasm -f elf64 -o hello_world.o hello_world.asm
ld -o hello_world hello_world.o
nasm -f elf64 -o print_args.o print_args.asm
ld -o print_args print_args.o
