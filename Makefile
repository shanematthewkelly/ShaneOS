kernel_impl_files := $(shell find src/impl/kernel -name *.c)
kernel_obj_files := $(patsubst src/impl/kernel/%.c, build/kernel/%.o, $(kernel_impl_files))

x86_64_c_impl_files := $(shell find src/impl/x86_64 -name *.c)
x86_64_c_obj_files := $(patsubst src/impl/x86_64/%.c, build/x86_64/%.o, $(x86_64_c_impl_files))

x86_64_asm_impl_files := $(shell find src/impl/x86_64 -name *.asm)
x86_64_asm_obj_files := $(patsubst src/impl/x86_64/%.asm, build/x86_64/%.o, $(x86_64_asm_impl_files))

x86_64_obj_files := $(x86_64_c_obj_files) $(x86_64_asm_obj_files)

$(kernel_obj_files): build/kernel/%.o : src/impl/kernel/%.c
	mkdir -p $(dir $@) &&  \
	x86_64-elf-gcc -c -I src/interface -ffreestanding $(patsubst build/kernel/%.o, src/impl/kernel/%.c, $@) -o $@

$(x86_64_c_obj_files): build/x86_64/%.o : src/impl/x86_64/%.c
	mkdir -p $(dir $@) &&  \
	x86_64-elf-gcc -c -I src/interface -ffreestanding $(patsubst build/x86_64/%.o, src/impl/x86_64/%.c, $@) -o $@

$(x86_64_asm_obj_files): build/x86_64/%.o : src/impl/x86_64/%.asm
	mkdir -p $(dir $@) &&  \
	nasm -f elf64 $(patsubst build/x86_64/%.o, src/impl/x86_64/%.asm, $@) -o $@

.PHONY: build-x86_64
build-x86_64: $(kernel_obj_files) $(x86_64_obj_files)
	mkdir -p dist/x86_64 && .
	x86_64-elf-ld -n -o dist/x86_64/kernel.bin -T platforms/x86_64/linkos.ld $(kernel_obj_files) $(x86_64_obj_files) && \
	cp dist/x86_64/kernel.bin platforms/x86_64/iso/boot/kernel.bin && \
	grub-mkrescue /usr/lib/grub/i386-pc -o dist/x86_64/kernel.iso platforms/x86_64/iso

