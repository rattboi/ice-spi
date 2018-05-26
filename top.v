module top (
	input  CLK,
  output D1,
  output D2,
  output D3,
  output D4,
  output D5,
  output reg PMOD1,
  input TR7,
  input TR8,
  output TR9,
  input TR10
);

wire       sysclk;							
wire       locked;							
pll myPLL (.clock_in(CLK), .clock_out(sysclk), .locked(locked));	
		
SPI_slave spi(
  sysclk, 
  TR7, 
  TR8, 
  TR9, 
  TR10, 
  PMOD1,
  D1,
  D2,
  D3,
  D4);

assign D5 = locked;

endmodule
