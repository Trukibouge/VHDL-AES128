library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity invAESRound is 
	port(
        clk_i: in std_logic; 
        current_key_i: in bit128; --clé actuelle
        current_text_i: in type_state; --état d'entrée de la ronde
        enableInvMixColumns_i: in std_logic;
        enableRoundComputing_i: in std_logic;
        resetb_i: in std_logic;
        data_o: out type_state
	);
	end invAESRound;

architecture invAESRound_arch of invAESRound is

    -----------------------------------------------------------------------------
    -- Component declarations
    -----------------------------------------------------------------------------
    signal initial_text_s: type_state; --état initial
    signal calculated_state1_s, calculated_state2_s, calculated_state3_s: type_state; --état calculé par les opérations autorisées des rondes 1 à 9, 0 et 10 respectivement
    signal shifted_state1_s, shifted_state2_s: type_state; --états issus de l'opération invShiftRows
    signal added_key_state1_s, added_key_state2_s: type_state; --états issus de l'opération addRoundKey
    signal subbed_state1_s, subbed_state2_s: type_state; --états issus de l'opération invSubBytes
    signal mixed_state_s: type_state; --état issu de l'opération invMixColumn
    signal current_key_s: bit128; --clé actuellement utilisée

    component addRoundKey is
        port(
            data_i: in type_state;
            key_i: in bit128;
            data_o: out type_state
        );
	end component;

    component invShiftRows is
        port(	
            data_i: in type_state;
            data_o: out type_state);
    end component;

    component invSubBytes is
        port(
            data_i: in type_state;
            data_o: out type_state
        );
    end component;

    component invMixColumns is 
        port(
            data_i:in type_state;
            data_o:out type_state
        );
    end component;

    
    -----------------------------------------------------------------------------
    -- Component instantiations
    -----------------------------------------------------------------------------
    begin

        initial_text_s <= current_text_i;
        current_key_s <= current_key_i;


        -----------------------------------------------------------------------------
        -- Round 9-1
        -----------------------------------------------------------------------------
        ShiftRows1: invShiftRows port map(
                    data_i => initial_text_s,
                    data_o => shifted_state1_s
                );
                
        SubBytes1: invSubBytes port map(
            data_i => shifted_state1_s,
            data_o => subbed_state1_s
        );

        AddRoundKey1: addRoundKey port map(
            data_i => subbed_state1_s,
            key_i => current_key_s,
            data_o => added_key_state1_s
        );

        MixColumns1: invMixColumns port map(
            data_i => added_key_state1_s,
            data_o => calculated_state1_s
        );
        

        -----------------------------------------------------------------------------
        -- Round 0
        -----------------------------------------------------------------------------
        ShiftRows2: invShiftRows port map(
            data_i => initial_text_s,
            data_o => shifted_state2_s
        );
        
        SubBytes2: invSubBytes port map(
            data_i => shifted_state2_s,
            data_o => subbed_state2_s
        );

        AddRoundKey2: addRoundKey port map(
            data_i => subbed_state2_s,
            key_i => current_key_s,
            data_o => calculated_state2_s
        );

        -----------------------------------------------------------------------------
        -- Round 10
        -----------------------------------------------------------------------------

        AddRoundKey3: addRoundKey port map(
            data_i => initial_text_s,
            key_i => current_key_s,
            data_o => calculated_state3_s
        );

        -----------------------------------------------------------------------------
        -- Round Output process
        -----------------------------------------------------------------------------
        Round_calculation: process(clk_i, enableInvMixColumns_i, enableRoundComputing_i, resetb_i)
            begin

                if resetb_i = '1' then
                    loop_ligne_state: for i in 0 to 3 loop
                        loop_colonne_state: for j in 0 to 3 loop
                            data_o(i)(j) <= (others => '0'); -- affecte tous les bits à 0
                        end loop loop_colonne_state;
                    end loop loop_ligne_state;
                    
                elsif (clk_i'event and clk_i='1') then
                        if (enableRoundComputing_i = '1' and enableInvMixColumns_i = '1') then 
                            data_o <= calculated_state1_s;
                        elsif (enableRoundComputing_i = '1' and enableInvMixColumns_i = '0') then --last round
                            data_o <= calculated_state2_s;
                        elsif (enableRoundComputing_i = '0' and enableInvMixColumns_i = '0') then
                            data_o <= calculated_state3_s;
                        end if;

                end if;

        end process;

        
end invAESRound_arch;


