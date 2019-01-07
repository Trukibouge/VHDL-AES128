library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

library source;

entity fsm_invAES_tb is
end fsm_invAES_tb;

architecture fsm_invAES_tb_arch of fsm_invAES_tb is

 -----------------------------------------------------------------------------
 -- Component declarations
 -----------------------------------------------------------------------------

	component counter
		port(
            init_i:in std_logic;
            ce_i:in std_logic;
            resetb_i:in std_logic;
            clk_i:in std_logic;
            cpt_o:out bit4
		); 
	end component;

	component fsm_invAES
		port(
			round_i:in bit4;
			clk_i:in std_logic;
			resetb_i:in std_logic;
			start_i:in std_logic;
	
			done_o:out std_logic;
			enableCounter_o:out std_logic;
			initCounter_o: out std_logic;
			enableMixColumns_o:out std_logic;
			enableOutput_o:out std_logic;
			enableRoundComputing_o:out std_logic;
			getCipherText_o:out std_logic;
			resetCounter_o:out std_logic
		); 
	end component;
	
	signal initCounter_s : std_logic;
	signal enableCounter_s : std_logic;
	signal resetCounter_s : std_logic;
    signal clk_s: std_logic := '0';
	signal round_s: bit4;
	
	signal reset_fsm_s : std_logic;
	signal start_fsm_s : std_logic;
	signal done_s : std_logic;
	signal enableMixColumns_s : std_logic;
	signal enableOutput_s : std_logic;
	signal enableRoundComputing_s : std_logic;
	signal getCipherText_s : std_logic;
	
 -----------------------------------------------------------------------------
 -- Component instantiations
 -----------------------------------------------------------------------------
	begin
		cpt : counter
			port map(
				init_i => initCounter_s,
				ce_i => enableCounter_s,
                resetb_i => resetCounter_s,
                clk_i => clk_s,
                cpt_o => round_s
			);

		DUT: fsm_invAES
			port map(
				round_i => round_s,
				clk_i => clk_s,
				resetb_i => reset_fsm_s,
				start_i => start_fsm_s,
		
				done_o => done_s,
				enableCounter_o => enableCounter_s,
				initCounter_o => initCounter_s,
				enableMixColumns_o => enableMixColumns_s,
				enableOutput_o => enableOutput_s,
				enableRoundComputing_o => enableRoundComputing_s,
				getCipherText_o => getCipherText_s,
				resetCounter_o => resetCounter_s
			);

	start_fsm_s <= '0', '1' after 12 ns, '0' after 17 ns, '1' after 33 ns;
	reset_fsm_s <= '0', '1' after 22 ns, '0' after 27 ns;
	clk_s <= not clk_s after 5 ns;
    
end fsm_invAES_tb_arch;

configuration fsm_invAES_tb_conf of fsm_invAES_tb is
	for fsm_invAES_tb_arch
		for DUT : fsm_invAES
			use entity source.fsm_invAES(fsm_invAES_arch);
		end for;
	end for;
end fsm_invAES_tb_conf;