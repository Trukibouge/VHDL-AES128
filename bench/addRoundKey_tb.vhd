library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity addRoundKey_tb is
end addRoundKey_tb;

architecture addRoundKey_tb_arch of addRoundKey_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------

	component addRoundKey
		port(
			data_i: in type_state;
			key_i: in bit128;
			data_o: out type_state
		); 
	end component;

	component KeyExpansion_table
		port(
			round_i : in bit4;
			expansion_key_o : out bit128
		);
	end component;
	
	signal data_i_s : type_state;
	signal key_s : bit128;
	signal data_o_s : type_state;
	signal round_s : bit4;
	
 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		key_expansion: KeyExpansion_table
			port map(
				round_i => round_s,
				expansion_key_o => key_s 
			);

		DUT : addRoundKey
			port map(
				data_i => data_i_s,
				key_i => key_s,
				data_o => data_o_s
			);

		data_i_s <= (	(x"a5",x"67",x"c5",x"d8"), -- Résultat de l'opération invSubBytes de la Round 9
						(x"40",x"63",x"a5",x"fd"),
						(x"f9",x"dd",x"84",x"10"),
						(x"57",x"e6",x"b9",x"ca"));

		round_s <= x"9";

end addRoundKey_tb_arch;

configuration addRoundKey_tb_conf of addRoundKey_tb is
	for addRoundKey_tb_arch
		for DUT : addRoundKey
			use entity source.addRoundKey(addRoundKey_arch);
		end for;
	end for;
end addRoundKey_tb_conf;
