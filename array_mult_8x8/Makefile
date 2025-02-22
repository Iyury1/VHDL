all: target

target:
	ghdl -a -fsynopsys *.vhdl
	ghdl -e -fsynopsys array_mult_top

clean:
	ghdl clean