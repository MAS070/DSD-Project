`timescale 1ns / 1ps

///////////////////////////////////////////////////////////////////////////////
//
// Record/playback
//
///////////////////////////////////////////////////////////////////////////////


module recorder(
  input logic clk_in,              // 100MHz system clock
  input logic rst_in,               // 1 to reset to initial state
  input logic record_in,            // 0 for playback, 1 for record
  input logic ready_in,             // 1 when data is available
  input logic filter_in,            // 1 when using low-pass filter
  input logic signed [7:0] mic_in,         // 8-bit PCM data from mic
  output logic signed [7:0] data_out       // 8-bit PCM data to headphone
); 
    logic [7:0] tone_750;
    logic [7:0] tone_440;
    //generate a 750 Hz tone
    sine_generator  tone750hz (   .clk_in(clk_in), .rst_in(rst_in), 
                                 .step_in(ready_in), .amp_out(tone_750));
    //generate a 440 Hz tone
//    sine_generator  #(.PHASE_INCR(32'd39370534)) tone440hz(.clk_in(clk_in), .rst_in(rst_in), 
//                               .step_in(ready_in), .amp_out(tone_440));                          
    logic [7:0] data_to_bram;
    logic [7:0] data_from_bram;
    logic [15:0] addr_wr;
    logic [15:0] addr_r;
    logic [15:0] addr;
    logic wea;
    logic [7:0]Filtered_data;
    logic [23:0]final_filtered_data;
    
    
    initial 
    begin addr_wr = 0; addr_r = 0; addr = 0; end
    
    always@(posedge clk_in)
    begin
        if (record_in == 1)
        addr_wr = addr_wr + 1;
        else if (record_in == 0 )
        addr_r = addr + 1;
    end
    
    initial 
    begin
        if (record_in == 1)
            addr = addr_wr;
        else 
            addr = addr_r;
    end 
    
    
//     fir31 FIR( .clk_in(clk_100mhz), .rst_in(rst_in), .x_in(mic_in), .y_out(filtered_data));
   

//    assign   final_filtered_data = filtered_data/3;
      
    
    
      blk_mem_gen_0(.addra(addr), .clka(clk_in), .dina(mic_in), .douta(data_from_bram), 
                    .ena(1), .wea(record_in));                                  
    
    FIR_Filter FIR(.Clk(clk_100mhz), .In(mic_in), .Out(Out));
    
    
    
    always_ff @(posedge clk_in)begin
        data_out = filter_in?Out:mic_in;
        //data_out = filter_in?tone_440:tone_750; //send tone immediately to output
    end                            
endmodule                              
          