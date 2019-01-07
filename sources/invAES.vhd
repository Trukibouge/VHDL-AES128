library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; 

library AESLibrary;
use AESLibrary.state_definition_package.all;

entity invAES is 
	port(
        start_i: in std_logic; --bit de start
        clk_i: in std_logic;
        resetb_i: in std_logic; --bit de reset 
        data_i: in type_state; --etat d'entree
        data_o: out type_state; --etat de sortie
        done_o: out std_logic --fin du déchiffrement
	);
	end invAES;

architecture invAES_arch of invAES is

    -----------------------------------------------------------------------------
    -- Component declarations
    -----------------------------------------------------------------------------

    signal clk_s: std_logic; 
    signal current_key_s: bit128; --clé courante
    signal current_text_s: type_state; --état à l'entrée de la ronde
    signal enableInvMixColumns_s: std_logic;
    signal enableRoundComputing_s: std_logic;
    signal resetb_s: std_logic; --reset fsm, calcul de ronde et registre
    signal cipher_text_s: type_state; --état à la sortie de la ronde

    signal initCounter_s: std_logic;
    signal enableCounter_s: std_logic;
    signal resetCounter_s: std_logic;
    signal round_s: bit4;

    signal start_s: std_logic;
    signal done_s: std_logic;
    signal enableOutput_s: std_logic; --affichage du résultat courant
    signal getCipherText_s: std_logic; --sélection multiplexeur

    signal initial_text_s: type_state; --état initial

    signal data_o_s: type_state; --état de sortie

    component invAESRound
    port(
        clk_i: in std_logic;
        current_key_i: in bit128;
        current_text_i: in type_state;
        enableInvMixColumns_i: in std_logic;
        enableRoundComputing_i: in std_logic;
        resetb_i: in std_logic;
        data_o: out type_state
    ); 
    end component;



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


    component KeyExpansion_table
    Port( 
        round_i : in bit4;
        expansion_key_o : out bit128);
    end component;

    component RTL_mux is
    port(
        initial_text_i: in type_state;
        cipher_text_i: in type_state;
        get_cipher_text_i: in std_logic;
        data_o: out type_state
    );
    end component;



    component RTL_registre is
    port(
        enable_output_i : in std_logic; 
        clk_i : in std_logic;
        data_i : in type_state;
        resetb_i : in std_logic;
        q_o : inout type_state
    );
    end component;

    -----------------------------------------------------------------------------
    -- Component instantiations
    -----------------------------------------------------------------------------
    begin
        initial_text_s <= data_i;
        start_s <= start_i;
        clk_s <= clk_i;
        initial_text_s <= data_i;
        resetb_s <= resetb_i;
        data_o <= data_o_s;
        done_o <= done_s;

    U2: invAESRound
        port map(
            clk_i => clk_s,
            current_key_i => current_key_s,
            current_text_i => current_text_s,
            enableInvMixColumns_i => enableInvMixColumns_s,
            enableRoundComputing_i => enableRoundComputing_s,
            resetb_i => resetb_s,
            data_o => cipher_text_s
        );

    U3: counter 
        port map(
            init_i => initCounter_s,
            ce_i => enableCounter_s,
            resetb_i => resetCounter_s,
            clk_i => clk_s,
            cpt_o => round_s
        );

    U1: fsm_invAES
        port map(
            round_i => round_s,
            clk_i => clk_s,
            resetb_i => resetb_s,
            start_i => start_s,

            done_o => done_s,
            enableCounter_o => enableCounter_s,
            initCounter_o => initCounter_s,
            enableMixColumns_o => enableInvMixColumns_s,
            enableOutput_o => enableOutput_s,
            enableRoundComputing_o => enableRoundComputing_s,
            getCipherText_o => getCipherText_s,
            resetCounter_o => resetCounter_s
        );

    U0: KeyExpansion_table
        port map(
            round_i => round_s,
            expansion_key_o => current_key_s
        );

    RTL_Multiplex: RTL_mux
        port map(
            initial_text_i => initial_text_s,
            cipher_text_i => cipher_text_s,
            get_cipher_text_i => getCipherText_s,
            data_o => current_text_s
        );

    RTL_reg: RTL_registre
        port map(
            enable_output_i => enableOutput_s,
            clk_i => clk_s,
            data_i => cipher_text_s,
            resetb_i => resetb_s,
            q_o => data_o_s
        );
            
end invAES_arch;


