library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity invMix1Column_tb is
    end invMix1Column_tb;
    
    architecture invMix1Column_tb_arch of invMix1Column_tb is
    
     -----------------------------------------------------------------------------
     -- Component declarations
     -----------------------------------------------------------------------------
    
        component invMix1Column
            port(
                column_i: in column_state;
                column_o: out column_state
            ); 
        end component;
        
        signal column_i_s:column_state;
        signal column_o_s:column_state;
        
     -----------------------------------------------------------------------------
     -- Component instantiations
     -----------------------------------------------------------------------------
        begin
            DUT : invMix1Column port map(
                    column_i => column_i_s,
                    column_o => column_o_s
                );
    
            column_i_s <= (x"09", x"37", x"9f", x"a4");
    
    end invMix1Column_tb_arch;
    
    configuration invMix1Column_tb_conf of invMix1Column_tb is
        for invMix1Column_tb_arch
            for DUT : invMix1Column
                use entity source.invMix1Column(invMix1Column_arch);
            end for;
        end for;
    end invMix1Column_tb_conf;
    