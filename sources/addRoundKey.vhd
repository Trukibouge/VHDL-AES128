library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity addRoundKey is
	port(
		data_i: in type_state;
		key_i: in bit128;
		data_o: out type_state
	);
	end entity;

architecture addRoundKey_arch of addRoundKey is

	signal key_matrix_s: type_key; --écriture matricielle de la clé entrée en paramètre
	begin
	
		key_matrix_s(0)(0) <= key_i(127 downto 120);
		key_matrix_s(1)(0) <= key_i(119 downto 112);
		key_matrix_s(2)(0) <= key_i(111 downto 104);
		key_matrix_s(3)(0) <= key_i(103 downto 96);

		key_matrix_s(0)(1) <= key_i(95 downto 88);
		key_matrix_s(1)(1) <= key_i(87 downto 80);
		key_matrix_s(2)(1) <= key_i(79 downto 72);
		key_matrix_s(3)(1) <= key_i(71 downto 64);

		key_matrix_s(0)(2) <= key_i(63 downto 56);
		key_matrix_s(1)(2) <= key_i(55 downto 48);
		key_matrix_s(2)(2) <= key_i(47 downto 40);
		key_matrix_s(3)(2) <= key_i(39 downto 32);

		key_matrix_s(0)(3) <= key_i(31 downto 24);
		key_matrix_s(1)(3) <= key_i(23 downto 16);
		key_matrix_s(2)(3) <= key_i(15 downto 8);
		key_matrix_s(3)(3) <= key_i(7 downto 0);

	gen_Row: for i in 0 to 3 generate
		gen_Column: for j in 0 to 3 generate
				data_o(i)(j) <= data_i(i)(j) xor key_matrix_s(i)(j);
		end generate gen_Column;
	end generate gen_Row;
end addRoundKey_arch;
