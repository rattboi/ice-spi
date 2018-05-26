PROJ = ice-spi

SRC_FILES = top.v SPI_slave.v pll.v

PIN_DEF = icestick.pcf
DEVICE = hx1k

all: $(PROJ).rpt $(PROJ).bin

%.blif: $(SRC_FILES)
	yosys -p 'synth_ice40 -top top -blif $@' $^

%.asc: $(PIN_DEF) %.blif
	arachne-pnr -d $(subst hx,,$(subst lp,,$(DEVICE))) -o $@ -p $^

%.bin: %.asc
	icepack $< $@

%.rpt: %.asc
	icetime -d $(DEVICE) -mtr $@ $<

prog: $(PROJ).bin
	iceprog $<

sudo-prog: $(PROJ).bin
	@echo 'Executing prog as root!!!'
	sudo iceprog $<

clean:
	rm -f *.blif *.asc *.rpt *.bin

.SECONDARY:
.PHONY: all prog clean
