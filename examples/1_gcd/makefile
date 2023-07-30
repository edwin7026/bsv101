# always out of date
.PHONY: generate_verilog
.PHONY: clean

generate_verilog:
	if [ ! -d "build" ]; then mkdir build ; fi
	cd build; if [ ! -d "intermediates" ]; then mkdir intermediates; fi
	cd build; if [ ! -d "verilog" ]; then mkdir verilog; fi
	bsc -verilog -bdir ./build/intermediates/ -vdir ./build/verilog/ src/gcd.bsv;

sim:
	bsc -o sim -e mkGCD ./build/mkGCD.v;

clean:
	rm -rf ./build/
	rm -rf *.bo *.v sim	
