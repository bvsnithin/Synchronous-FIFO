class fifo_scoreboard #(parameter DATA_WIDTH = 8) extends uvm_scoreboard;
    `uvm_component_param_utils(fifo_scoreboard #(DATA_WIDTH))

    // The "Radio Receiver" (Analysis Imp)
    // Note: The second argument must be THIS class name
    uvm_analysis_imp #(fifo_seq_item #(DATA_WIDTH), fifo_scoreboard #(DATA_WIDTH)) scb_export;

    // Our Golden Reference Model (A simple queue)
    bit [DATA_WIDTH-1:0] ref_queue [$];

    function new(string name, uvm_component parent);
        super.new(name, parent);
        scb_export = new("scb_export", this);
    endfunction

    // This function is called AUTOMATICALLY whenever the monitor calls .write()
    function void write(fifo_seq_item #(DATA_WIDTH) item);
        bit [DATA_WIDTH-1:0] expected_data;

        // 1. Handle Writes
        if (item.wr_en) begin
            // Depending on your FIFO design, you might check 'full' here too.
            // For now, assume if wr_en is high, we push.
            ref_queue.push_back(item.din);
            `uvm_info("SCB", $sformatf("Store Data: %0h. Queue Size: %0d", item.din, ref_queue.size()), UVM_LOW)
        end

        // 2. Handle Reads
        if (item.rd_en) begin
            if (ref_queue.size() == 0) begin
                `uvm_error("SCB", "DUT read data, but Golden Model is empty!")
            end 
            else begin
                expected_data = ref_queue.pop_front();
                
                // THE CHECK
                if (item.dout !== expected_data) begin
                    `uvm_error("SCB", $sformatf("MISMATCH! Expected: %0h, Got: %0h", expected_data, item.dout))
                end else begin
                    `uvm_info("SCB", $sformatf("MATCH! Read: %0h", item.dout), UVM_LOW)
                end
            end
        end
    endfunction

endclass