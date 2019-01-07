library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invSubBytes_tb is
end invSubBytes_tb;

architecture invSubBytes_tb_arch of invSubBytes_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------
	component invSubBytes
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
		DUT : invSubBytes
			port map(
				data_i => data_i_s,
				data_o => data_o_s
			);

		data_i_s <= (	(x"06",x"85",x"a6",x"61"), --Résultat de l'opération invShiftRows de la Round 9
						(x"09",x"fb",x"06",x"54"),
						(x"99",x"c1",x"5f",x"ca"),
						(x"5b",x"8e",x"56",x"74")); 
end invSubBytes_tb_arch;

configuration invSubBytes_tb_conf of invSubBytes_tb is
	for invSubBytes_tb_arch
		for DUT : invSubBytes
			use entity source.invSubBytes(invSubBytes_arch);
		end for;
	end for;
end invSubBytes_tb_conf;
