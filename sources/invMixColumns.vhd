library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity invMixColumns is 
	port(
		data_i:in type_state;
		data_o:out type_state
	);
end invMixColumns;

architecture invMixColumns_arch of invMixColumns is
 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------
	component invMix1Column is 
		port(
			column_i: in column_state;
			column_o: out column_state);
		end component invMix1Column;

	signal column0_s, column1_s, column2_s, column3_s:column_state;


 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		column0_s <= (data_i(0)(0), data_i(1)(0), data_i(2)(0), data_i(3)(0));
		column1_s <= (data_i(0)(1), data_i(1)(1), data_i(2)(1), data_i(3)(1));
		column2_s <= (data_i(0)(2), data_i(1)(2), data_i(2)(2), data_i(3)(2));
		column3_s <= (data_i(0)(3), data_i(1)(3), data_i(2)(3), data_i(3)(3));

		column0_operation: invMix1Column port map(
			column_i => column0_s,
			column_o(0) => data_o(0)(0),
			column_o(1) => data_o(1)(0),
			column_o(2) => data_o(2)(0),
			column_o(3) => data_o(3)(0)
		);

		column1_operation: invMix1Column port map(
			column_i => column1_s,
			column_o(0) => data_o(0)(1),
			column_o(1) => data_o(1)(1),
			column_o(2) => data_o(2)(1),
			column_o(3) => data_o(3)(1)
		);

		column2_operation: invMix1Column port map(
			column_i => column2_s,
			column_o(0) => data_o(0)(2),
			column_o(1) => data_o(1)(2),
			column_o(2) => data_o(2)(2),
			column_o(3) => data_o(3)(2)
		);

		column3_operation: invMix1Column port map(
			column_i => column3_s,
			column_o(0) => data_o(0)(3),
			column_o(1) => data_o(1)(3),
			column_o(2) => data_o(2)(3),
			column_o(3) => data_o(3)(3)
		);

end invMixColumns_arch;
