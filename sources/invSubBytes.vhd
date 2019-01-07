library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity invSubBytes is
	port(
		data_i: in type_state;
		data_o: out type_state
	);
end invSubBytes;


architecture invSubBytes_arch of invSubBytes is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------
	component Sbox is --composant sbox.vhd
		port(
			data_i: in bit8;
			data_o: out bit8);
	end component Sbox;

	signal data_o_s : type_state;

 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
	gen_SboxRow: for i in 0 to 3 generate
		gen_SboxColumn: for j in 0 to 3 generate
			SboxColumn : Sbox port map(
				data_i => data_i(i)(j),
				data_o => data_o_s(i)(j)
			);	
		end generate gen_SboxColumn;
	end generate gen_SboxRow;
	data_o <= data_o_s;
end invSubBytes_arch;


