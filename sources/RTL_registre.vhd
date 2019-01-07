library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity RTL_registre is
	port(
        enable_output_i : in std_logic; --active l'écriture de la sortie d'invAES
        clk_i : in std_logic;
        data_i : in type_state; --état à mémoriser 
        resetb_i : in std_logic; --reset du registre
		q_o : inout type_state --sortie bouclée à l'entrée du registre
	);
end RTL_registre;

architecture RTL_registre_arch of RTL_registre is
    signal q_s : type_state;
    begin
        q_o <= q_s;
        seq_o : process(clk_i, resetb_i)
            begin

                if (resetb_i = '1') then --reset actif à l'é'tat haut
                    loop_ligne_state: for i in 0 to 3 loop
                        loop_colonne_state: for j in 0 to 3 loop
                        q_s(i)(j) <= (others => '0'); -- affecte tous les bits à 0
                        end loop loop_colonne_state;
                    end loop loop_ligne_state;

                elsif (clk_i'event and clk_i = '1') then
                    if enable_output_i = '0' then --enable output actif à l'état bas
                        q_s <= data_i; --écriture
                    else
                        q_s <= q_s; --mémorisation
                    end if;

                else q_s <= q_s; --mémorisation en dehors des fronts d'horloge

                end if;
        end process;		
end RTL_registre_arch;
