package GCD;

    // here is the interface for the gcd module
    interface GCD;
        method Action start(Bit#(32) a, Bit#(32) b);
        method ActionValue#(Bit#(32)) getResult;
    endinterface

    module mkGCD(GCD);

        // First let's go ahead and define all the states
        Reg#(Bit#(32)) x <- mkReg(0);                       // input
        Reg#(Bit#(32)) y <- mkReg(0);                       // output
        Reg#(Bool) busy_flag <- mkReg(False);               // flag to show GCD computation in process
        
        // gcd rule will execute repeatedly until x becomes 0
        rule gcd;
            if (x >= y) begin
                x <= x - y;             // subtract
            end
            else if (x != 0) begin
                x <= y;
                y <= x;                 // swap
            end
        endrule

        // define start method
        // the start method should execute only when the module is not busy
        // this method when fired will take inputs a and b and set busy_flag as true
        method Action start(Bit#(32) a, Bit#(32) b) if (!busy_flag);
            x <= a;
            y <= b;
            busy_flag <= True;
        endmethod

        // define getResult method
        // this method should execute when the module is busy and when x is 0
        // this method when fired will return y and set busy_flag as false
        method ActionValue#(Bit#(32)) getResult if (busy_flag && (x==0));
            busy_flag <= False;
            return y;
        endmethod

    endmodule
endpackage : GCD