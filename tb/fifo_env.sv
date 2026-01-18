class fifo_env #(parameter DATA_WIDTH = 8) extends uvm_env;
    `uvm_component_param_utils(fifo_env #(DATA_WIDTH))
    
    fifo_agent #(DATA_WIDTH) agt;
    fifo_scoreboard #(DATA_WIDTH) scb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt = fifo_agent#(DATA_WIDTH)::type_id::create("agt", this);
        scb = fifo_scoreboard#(DATA_WIDTH)::type_id::create("scb",this);
    endfunction

endclass