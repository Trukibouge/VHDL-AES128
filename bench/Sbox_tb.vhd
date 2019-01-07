library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity Sbox_tb is
--empty
end Sbox_tb;

architecture Sbox_tb_arch of Sbox_tb is
	component Sbox
		port(
			data_i: in bit8;
			data_o: out bit8
		); 
	end component;
	
	signal data_i_s:bit8;
	signal data_o_s:bit8;
	
	begin --Sbox_tb_arch
		DUT : Sbox
			port map(
				data_i => data_i_s,
				data_o => data_o_s
			);

		data_i_s <= x"30", x"f0" after 50 ns;

end Sbox_tb_arch;

configuration Sbox_tb_conf of Sbox_tb is
	for Sbox_tb_arch
		for DUT : Sbox
			use entity source.Sbox(Sbox_arch);
		end for;
	end for;
end Sbox_tb_conf;

