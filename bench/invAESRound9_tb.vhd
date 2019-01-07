library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invAESRound9_tb is
end invAESRound9_tb;

architecture invAESRound9_tb_arch of invAESRound9_tb is

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
	current_key_i_s <= x"ac7766f319fadc2128d12941575c006e"; --clé de la round 9
	current_text_i_s <= (	(x"06",x"85",x"a6",x"61"), --état d'entrée de la round 9
						(x"fb",x"06",x"54",x"09"),
						(x"5f",x"ca",x"99",x"c1"),
						(x"74",x"5b",x"8e",x"56"));
	enableInvMixColumns_i_s <= '1';
	enableRoundComputing_i_s <= '1';
    
end invAESRound9_tb_arch;

configuration invAESRound9_tb_conf of invAESRound9_tb is
	for invAESRound9_tb_arch
		for DUT : invAESRound
			use entity source.invAESRound(invAESRound_arch);
		end for;
	end for;
end invAESRound9_tb_conf;