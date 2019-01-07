library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity RTL_mux is
	port(
        initial_text_i: in type_state; --état en entrée d'invAES
        cipher_text_i: in type_state; --état à la ronde actuelle
        get_cipher_text_i: in std_logic; --sélection de la sortie
        data_o: out type_state
	);
end RTL_mux;

architecture RTL_mux_arch of RTL_mux is
    begin
        data_o <= cipher_text_i when get_cipher_text_i = '1' else initial_text_i;
end RTL_mux_arch;
