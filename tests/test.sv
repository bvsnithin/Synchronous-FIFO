class fifo_test extends uvm_test;

    `uvm_component_utils(fifo_test);

    function new(String name = "fifo_test", uvm_component parent = null);
        super.new(name,parent);
    endfunction: new

    function run_phase(uvm_phase phase);
        phase.raise_objection(this);
        `uvm_info("TEST","Hello! The UVM env is running.",UVM_LOW)
        #100;
        phase.drop_obejction(this);
    endfunction run_phase
endclass: test