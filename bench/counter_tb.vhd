library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity counter_tb is
end counter_tb;

architecture counter_tb_arch of counter_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------

	component counter
		port(
            init_i:in std_logic;
            ce_i:in std_logic;
            resetb_i:in std_logic;
            clk_i:in std_logic;
            cpt_o:out bit4
		); 
	end component;
	
	signal init_i_s : std_logic;
	signal ce_i_s : std_logic;
    signal resetb_i_s : std_logic;
    signal clk_i_s: std_logic := '0';
    signal cpt_o_s: bit4;
	
 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		DUT : counter
			port map(
				init_i => init_i_s,
				ce_i => ce_i_s,
                resetb_i => resetb_i_s,
                clk_i => clk_i_s,
                cpt_o => cpt_o_s
			);

	init_i_s <= '1', '0' after 7 ns, '1' after 67 ns, '0' after 77 ns;
	ce_i_s <= '1', '0' after 27 ns, '1' after 67 ns;
	resetb_i_s <= '1', '0' after 37 ns, '1' after 47 ns;
	clk_i_s <= not clk_i_s after 5 ns;
    
end counter_tb_arch;

configuration counter_tb_conf of counter_tb is
	for counter_tb_arch
		for DUT : counter
			use entity source.counter(counter_arch);
		end for;
	end for;
end counter_tb_conf;