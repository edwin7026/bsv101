/** This file describes a hardware that computes the GCD of two integers
 * Euclid's method is used to do this
 * The following demonstrates an example where a and b are the inputs
 * Iteration        a        b
 *    0             15       6
 *    1             9        6          // subract
 *    2             3        6          // subtract
 *    3             6        3          // a < b; swap
 *    4             3        3          // subtract
 *    5             0        3          // a == 0; b is the result
 **/

// packages are like namespaces and it is compulsory
// package name should be same as that of file name
package GCD;

    // here is the interface for the gcd module
    interface GCD_Ifc;
        method Action start(Bit#(32) a, Bit#(32) b);
        method ActionValue#(Bit#(32)) getResult;
    endinterface

    (* synthesize *)
    module mkGCD(GCD_Ifc);

        // First let's go ahead and define all the states
        Reg#(Bit#(32)) x <- mkReg(0);                       // input
        Reg#(Bit#(32)) y <- mkReg(0);                       // output
        Reg#(Bool) busy_flag <- mkReg(False);               // flag to show GCD computation in process
        
        // core computation of gcd. This happens repeatedly
        rule gcd;
            if (x < y) begin
                x <= y; y <= x;
            end
            else begin
                x <= x - y;
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