
class fifo_random_seq #(parameter DATA_WIDTH = 8) extends uvm_sequence #(fifo_seq_item #(DATA_WIDTH));

    `uvm_object_param_utils(fifo_random_seq #(DATA_WIDTH))

    function new(string name = "fifo_random_seq");
        super.new(name);
    endfunction

    task body();
        fifo_seq_item #(DATA_WIDTH) req;
        
        `uvm_info("SEQ", "Starting generation of 20 items...", UVM_LOW)

        repeat(20) begin

            `uvm_do_with(req, {
                (wr_en && rd_en) == 0;
                
                (wr_en || rd_en) == 1;
            })

        end
        
        `uvm_info("SEQ", "Generation Done!", UVM_LOW)
    endtask

endclass