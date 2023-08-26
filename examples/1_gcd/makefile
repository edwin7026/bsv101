# always out of date
.PHONY: generate_verilog
.PHONY: clean

# top file name
TOP_FILE = Testbench.bsv
TOP_MODULE = mkTb

BSC_DIR = 
BSC_COMP_FLAGS = -elab -keep-fires -show-schedule
BSC_PATHS = -p src/:%/Prelude:%/Libraries
BSIM_EXE = $(TOP_MODULE)_bsim
BSIM_DIRS = -simdir build/intermediates/sim/

# always out of date
.PHONY: generate_verilog
.PHONY: gen_sim
.PHONY: clean

generate_verilog:
	if [ ! -d "build" ]; then mkdir build ; fi
	cd build; if [ ! -d "intermediates" ]; then mkdir intermediates; fi
	cd build; if [ ! -d "verilog" ]; then mkdir verilog; fi
	bsc -u -verilog -bdir ./build/intermediates/ -vdir ./build/verilog/  $(BSC_COMP_FLAGS) $(BSC_PATHS) -g $(TOP_MODULE)  src/$(TOP_FILE)

gen_sim:
	cd build; if [ ! -d "sim" ]; then mkdir sim; cd intermediates; mkdir sim; fi
	bsc -e $(TOP_MODULE) -sim -o build/sim/$(BSIM_EXE) $(BSIM_DIRS) -p build/intermediates

gen_sysc:
		bsc -u -systemc -p ./build/intermediates/ -e mkTb

sim:
	./build/sim/$(BSIM_EXE)

clean:
	rm -rf ./build/