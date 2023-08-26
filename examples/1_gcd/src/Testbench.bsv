package Testbench;

    import GCD::*;
    import LFSR::*;

    (* synthesize *)
    module mkTb(Empty);

        // Instantiate test module
        GCD_Ifc gcd <- mkGCD;

        rule put;
            gcd.start(15, 9);
        endrule: put

        rule get;
            let result = gcd.getResult();
            $display("Heyy");
        endrule: get

    endmodule: mkTb

endpackage: Testbench