library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invAESRound10_tb is
end invAESRound10_tb;

architecture invAESRound10_tb_arch of invAESRound10_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------

	component invAESRound
		port(
			clk_i: in std_logic;
			current_key_i: in bit128;
			current_text_i: in type_state;
			enableInvMixColumns_i: in std_logic;
			enableRoundComputing_i: in std_logic;
			resetb_i: in std_logic;
			data_o: out type_state
		); 
	end component;
	
	signal clk_i_s: std_logic := '0';
	signal current_key_i_s: bit128;
	signal current_text_i_s: type_state;
	signal enableInvMixColumns_i_s: std_logic;
	signal enableRoundComputing_i_s: std_logic;
	signal resetb_i_s: std_logic;
	signal data_o_s: type_state;
	
 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		DUT: invAESRound
			port map(
				clk_i => clk_i_s,
				current_key_i => current_key_i_s,
				current_text_i => current_text_i_s,
				enableInvMixColumns_i => enableInvMixColumns_i_s,
				enableRoundComputing_i => enableRoundComputing_i_s,
				resetb_i => resetb_i_s,
				data_o => data_o_s
			);

	resetb_i_s <= '0', '1' after 20 ns, '0' after 30 ns;
	clk_i_s <= not clk_i_s after 5 ns;
	current_key_i_s <= x"d014f9a8c9ee2589e13f0cc8b6630ca6";
	current_text_i_s <= (	(x"d6",x"4c",x"47",x"d7"), --clé de la round 10
							(x"ef",x"e8",x"6b",x"6a"),
							(x"a6",x"ef",x"95",x"cd"),
							(x"dc",x"d2",x"46",x"f0"));
	enableInvMixColumns_i_s <= '0';
	enableRoundComputing_i_s <= '0';
    
end invAESRound10_tb_arch;

configuration invAESRound10_tb_conf of invAESRound10_tb is
	for invAESRound10_tb_arch
		for DUT : invAESRound
			use entity source.invAESRound(invAESRound_arch);
		end for;
	end for;
end invAESRound10_tb_conf;