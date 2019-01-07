library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invMixColumns_tb is
end invMixColumns_tb;
    
    architecture invMixColumns_tb_arch of invMixColumns_tb is
    
     -----------------------------------------------------------------------------
     -- Component declarations
     -----------------------------------------------------------------------------
    
        component invMixColumns
            port(
                data_i: in type_state;
                data_o: out type_state
            ); 
        end component;
        
        signal type_i_s:type_state;
        signal type_o_s:type_state;
        
     -----------------------------------------------------------------------------
     -- Component instantiations
     -----------------------------------------------------------------------------
        begin
            DUT : invMixColumns port map(
                    data_i => type_i_s,
                    data_o => type_o_s
                );
    
            type_i_s <= (   (x"09", x"7e", x"ed", x"8f"), --résultat de l'opération addRoundKey de la Round 9
                            (x"37", x"99", x"74", x"a1"),
                            (x"9f", x"01", x"ad", x"10"),
                            (x"a4", x"c7", x"f8", x"a4")
                        );
    
    end invMixColumns_tb_arch;
    
    configuration invMixColumns_tb_conf of invMixColumns_tb is
        for invMixColumns_tb_arch
            for DUT : invMixColumns
                use entity source.invMixColumns(invMixColumns_arch);
            end for;
        end for;
    end invMixColumns_tb_conf;
    