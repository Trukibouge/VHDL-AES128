library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity fsm_invAES is 
	port(
		round_i:in bit4; --numéro de ronde
		clk_i:in std_logic;
		resetb_i:in std_logic; --réinitialisation de la fsm
		start_i:in std_logic; --bit de start d'invAES

		done_o:out std_logic; --indique qu'invAES est terminé
		enableCounter_o:out std_logic; --active le compteur
		initCounter_o: out std_logic; --initialise le compteur
		enableMixColumns_o:out std_logic; --active l'opération MixColumns
		enableOutput_o:out std_logic; --active l'écriture des états de sortie d'invAESRound dans le registre
		enableRoundComputing_o:out std_logic; --active invSubBytes et invShiftRows
		getCipherText_o:out std_logic; --Sélectionne la sortie du multiplexeur RTL_mux
		resetCounter_o:out std_logic --réinitialise le compteur
	);
	end fsm_invAES;

architecture fsm_invAES_arch of fsm_invAES is --FSM de Moore

	type etat is (idle, first, init, middle1, middle2, middle3, middle4, middle5, middle6, middle7, middle8, middle9, last, finished, display);
	signal current_etat_s, next_etat_s: etat;

	begin
		clk_process: process (clk_i, resetb_i) --processus séquentiel de changement d'état
				begin
				if resetb_i = '1' then --actif à l'état haut
						current_etat_s <= idle;
					elsif (clk_i'event and clk_i='1') then
						current_etat_s <= next_etat_s;
					end if;
		end process;

		next_state_process: process (current_etat_s, next_etat_s, round_i, start_i) --définition des conditions de transition aux états suivants
			begin
				case current_etat_s is 
					when idle =>
						if start_i = '1' then
							next_etat_s <= init;
						else
							next_etat_s <= idle;
						end if;

					when init =>
						next_etat_s <= first;

					when first =>
						if round_i = x"A" then
							next_etat_s <= middle1;
						else
							next_etat_s <= first;
						end if;

					when middle1 =>
						if round_i = x"9" then
							next_etat_s <= middle2;
						else
							next_etat_s <= middle1;
						end if;

					when middle2 =>
						if round_i = x"8" then
							next_etat_s <= middle3;
						else
							next_etat_s <= middle2;
						end if;

					when middle3 =>
						if round_i = x"7" then
							next_etat_s <= middle4;
						else
							next_etat_s <= middle3;
						end if;

					when middle4 =>
						if round_i = x"6" then
							next_etat_s <= middle5;
						else
							next_etat_s <= middle4;
						end if;

					when middle5 =>
						if round_i = x"5" then
							next_etat_s <= middle6;
						else
							next_etat_s <= middle5;
					end if;

					when middle6 =>
						if round_i = x"4" then
							next_etat_s <= middle7;
						else
							next_etat_s <= middle6;
					end if;

					when middle7 =>
						if round_i = x"3" then
							next_etat_s <= middle8;
						else
							next_etat_s <= middle7;
					end if;

					when middle8 =>
						if round_i = x"2" then
							next_etat_s <= middle9;
						else
							next_etat_s <= middle8;
					end if;


					when middle9 =>
						if round_i = x"1" then
							next_etat_s <= last;
						else
							next_etat_s <= middle9;
					end if;

					when last =>
						if round_i = x"0" then
							next_etat_s <= finished;
						else
							next_etat_s <= last;
					end if;

					when finished =>
						next_etat_s <= display;

					when display =>
						next_etat_s <= display;
				end case;
		end process;
			
		-- Détermination de la sortie (Moore)
		done_o <= '1' when (current_etat_s = display) else '0';
		enableCounter_o <= '1' when (current_etat_s = idle or current_etat_s = init or current_etat_s = first or current_etat_s = middle1 or current_etat_s = middle2 or current_etat_s = middle3 or current_etat_s = middle4 or current_etat_s = middle5 or current_etat_s = middle6 or current_etat_s = middle7 or current_etat_s = middle8 or current_etat_s = middle9) else '0';
		initCounter_o <= '1' when (current_etat_s = idle or current_etat_s = init) else '0';
		enableMixColumns_o <= '1' when (current_etat_s = middle1 or current_etat_s = middle2 or current_etat_s = middle3 or current_etat_s = middle4 or current_etat_s = middle5 or current_etat_s = middle6 or current_etat_s = middle7 or current_etat_s = middle8 or current_etat_s = middle9) else '0';
		enableOutput_o <= '0' when (current_etat_s = init or current_etat_s = first or current_etat_s = middle1 or current_etat_s = middle2 or current_etat_s = middle3 or current_etat_s = middle4 or current_etat_s = middle5 or current_etat_s = middle6 or current_etat_s = middle7 or current_etat_s = middle8 or current_etat_s = middle9 or current_etat_s = finished) else '1'; --actif à l'état bas
		enableRoundComputing_o <= '1' when (current_etat_s = middle1 or current_etat_s = middle2 or current_etat_s = middle3 or current_etat_s = middle4 or current_etat_s = middle5 or current_etat_s = middle6 or current_etat_s = middle7 or current_etat_s = middle8 or current_etat_s = middle9 or current_etat_s = last) else '0';
		getCipherText_o <= '0' when (current_etat_s = first or current_etat_s = init) else '1';
		resetCounter_o <= '0' when (current_etat_s = finished) else '1'; --actif à l'état bas

end fsm_invAES_arch;


