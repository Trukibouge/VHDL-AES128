library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity invShiftRows is
	port(	
		data_i: in type_state;
		data_o: out type_state);
end invShiftRows;

architecture invShiftRows_arch of invShiftRows is
	begin
		data_o(0) <= data_i(0);
		data_o(1)(0) <= data_i(1)(3);
		data_o(1)(1) <= data_i(1)(0);
		data_o(1)(2) <= data_i(1)(1);
		data_o(1)(3) <= data_i(1)(2);

		data_o(2)(0) <= data_i(2)(2);
		data_o(2)(1) <= data_i(2)(3);
		data_o(2)(2) <= data_i(2)(0);
		data_o(2)(3) <= data_i(2)(1);

		data_o(3)(0) <= data_i(3)(1);
		data_o(3)(1) <= data_i(3)(2);
		data_o(3)(2) <= data_i(3)(3);
		data_o(3)(3) <= data_i(3)(0);
end invShiftRows_arch;
