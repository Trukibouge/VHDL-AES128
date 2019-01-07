library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invAESRound0_tb is
end invAESRound0_tb;

architecture invAESRound0_tb_arch of invAESRound0_tb is

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
	current_key_i_s <= x"2b7e151628aed2a6abf7158809cf4f3c"; --clé de la round 0
	current_text_i_s <= (	(x"b6",x"a0",x"3d",x"4d"), --état d'entrée du round 0
							(x"19",x"0c",x"ac",x"af"),
							(x"10",x"a8",x"33",x"a9"),
							(x"7b",x"aa",x"e8",x"69"));
	enableInvMixColumns_i_s <= '0';
	enableRoundComputing_i_s <= '1';
    
end invAESRound0_tb_arch;

configuration invAESRound0_tb_conf of invAESRound0_tb is
	for invAESRound0_tb_arch
		for DUT : invAESRound
			use entity source.invAESRound(invAESRound_arch);
		end for;
	end for;
end invAESRound0_tb_conf;