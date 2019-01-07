library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity RTL_mux_tb is
end RTL_mux_tb;

architecture RTL_mux_tb_arch of RTL_mux_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------

 component RTL_mux is
	port(
        initial_text_i: in type_state;
        cipher_text_i: in type_state;
        get_cipher_text_i: in std_logic;
        data_o: out type_state
	);
end component;
	
	signal initial_text_i_s : type_state; 
	signal cipher_text_i_s : type_state;
	signal get_cipher_text_i_s : std_logic;
	signal data_o_s : type_state;
	
 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		DUT : RTL_mux
			port map(
                initial_text_i => initial_text_i_s,
                cipher_text_i => cipher_text_i_s,
                get_cipher_text_i => get_cipher_text_i_s,
                data_o => data_o_s
			);

	initial_text_i_s(0)(0) <= x"11";
	cipher_text_i_s(0)(0) <= x"22";	
	
	get_cipher_text_i_s <= '0', '1' after 10 ns, '0' after 20 ns;
    
end RTL_mux_tb_arch;

configuration RTL_mux_tb_conf of RTL_mux_tb is
	for RTL_mux_tb_arch
		for DUT : RTL_mux
			use entity source.RTL_mux(RTL_mux_arch);
		end for;
	end for;
end RTL_mux_tb_conf;