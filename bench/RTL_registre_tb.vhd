library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity RTL_registre_tb is
end RTL_registre_tb;

architecture RTL_registre_tb_arch of RTL_registre_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------

 component RTL_registre is
	port(
        enable_output_i : in std_logic; 
        clk_i : in std_logic;
        data_i : in type_state;
        resetb_i : in std_logic;
		q_o : inout type_state
	);
end component;
	
	signal enable_output_i_s : std_logic; 
	signal clk_i_s : std_logic := '0';
	signal data_i_s : type_state;
	signal resetb_i_s : std_logic;
	signal q_o_s : type_state;
	
 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		DUT : RTL_registre
			port map(
				enable_output_i => enable_output_i_s,
				clk_i => clk_i_s,
				data_i => data_i_s,
				resetb_i => resetb_i_s,
				q_o => q_o_s
			);

	data_i_s(0)(0) <= x"11", x"22" after 12 ns, x"33" after 32 ns;
	
	enable_output_i_s <= '0', '1' after 7 ns, '0' after 17 ns;
	resetb_i_s <= '0', '1' after 30 ns;
	clk_i_s <= not clk_i_s after 5 ns;
    
end  RTL_registre_tb_arch;

configuration RTL_registre_tb_conf of RTL_registre_tb is
	for RTL_registre_tb_arch
		for DUT : RTL_registre
			use entity source.RTL_registre(RTL_registre_arch);
		end for;
	end for;
end RTL_registre_tb_conf;