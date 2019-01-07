library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invAES_tb is
end invAES_tb;

architecture invAES_tb_arch of invAES_tb is

    -----------------------------------------------------------------------------
    -- Component declarations
    -----------------------------------------------------------------------------

	component invAES is 
		port(
			start_i: in std_logic;
			clk_i: in std_logic;
			resetb_i: in std_logic;
			data_i: in type_state;
			data_o: out type_state;
			done_o: out std_logic
		);
	end component;

	signal start_s: std_logic;
	signal clk_s: std_logic := '0';
	signal resetb_s: std_logic;
	signal data_i_s: type_state;
	signal data_o_s: type_state;
	signal done_o_s: std_logic;

	-----------------------------------------------------------------------------
    -- Component instantiations
    -----------------------------------------------------------------------------

	begin

		DUT: invAES
			port map(
				start_i => start_s,
				clk_i => clk_s,
				resetb_i => resetb_s,
				data_i => data_i_s,

				data_o => data_o_s,
				done_o => done_o_s
			);

		start_s <= '0', '1' after 12 ns;
		clk_s <= not clk_s after 1 ns;
		resetb_s <= '0';
		data_i_s <= (	(x"d6",x"4c",x"47",x"d7"),
						(x"ef",x"e8",x"6b",x"6a"),
						(x"a6",x"ef",x"95",x"cd"),
						(x"dc",x"d2",x"46",x"f0"));
		

end invAES_tb_arch;

configuration invAES_tb_conf of invAES_tb is
	for invAES_tb_arch
		for DUT : invAES
			use entity source.invAES(invAES_arch);
		end for;
	end for;
end invAES_tb_conf;