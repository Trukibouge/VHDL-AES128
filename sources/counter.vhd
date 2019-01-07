library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity counter is
	port(
		init_i:in std_logic; --initialisation du compteur
		ce_i:in std_logic; --counter enable
		resetb_i:in std_logic; --reset 
		clk_i:in std_logic;
		cpt_o:out bit4 --numéro de ronde
	);
end counter;

architecture counter_arch of counter is

	signal q_s:integer range 0 to 15;

	begin
		seq_o:process(clk_i, resetb_i) begin
			if (resetb_i = '0') then -- reset asynchrone, actif à l'état bas
				q_s <= 0;
			elsif (clk_i'event and clk_i = '1') then --front montant de l'horloge
				if ce_i = '1' then
					if (init_i = '1') then --l'initialisation est obligatoire lorsque le compteur est activité
						q_s <= 10;
					else 
						q_s <= q_s - 1;
					end if;
				end if;
			end if;
		end process;
		cpt_o <= std_logic_vector(to_unsigned(q_s,4));
		
end counter_arch;
