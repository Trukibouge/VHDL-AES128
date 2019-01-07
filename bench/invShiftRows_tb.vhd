library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invShiftRows_tb is
end invShiftRows_tb;

architecture invShiftRows_tb_arch of invShiftRows_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------

	component invShiftRows
		port(
			data_i: in type_state;
			data_o: out type_state
		); 
	end component;
	
	signal data_i_s : type_state;
	signal data_o_s : type_state;
	
 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		DUT : invShiftRows
			port map(
				data_i => data_i_s,
				data_o => data_o_s
			);

		data_i_s <= (	(x"06",x"85",x"a6",x"61"), --résultat de l'opération AddRoundKey de la Round 10
						(x"fb",x"06",x"54",x"09"),
						(x"5f",x"ca",x"99",x"c1"),
						(x"74",x"5b",x"8e",x"56"));
end invShiftRows_tb_arch;

configuration invShiftRows_tb_conf of invShiftRows_tb is
	for invShiftRows_tb_arch
		for DUT : invShiftRows
			use entity source.invShiftRows(invShiftRows_arch);
		end for;
	end for;
end invShiftRows_tb_conf;
