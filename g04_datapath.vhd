--project name: g04_lab5
--entity name: g04_datapath
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483; pei.wu@mail.mcgill.ca
--Date: 7th December, 2015

Library ieee;
Use ieee.std_logic_1164.all;

Entity g04_datapath IS
	Port (P_SEL, SR_LD, GR_SEL, GR_LD, TM_IN, TM_EN, TC_RST, TC_EN, SR_SEL, CLK  : IN std_logic;
			Mode, Ready, Resetn, Button, Cheat 												  : IN std_logic;
			LD 																						  : IN std_logic_vector(3 downto 0);
			EXT_PATTERN 																			  : IN std_logic_vector(11 downto 0);
		   SC_CMP, TC_LAST, TM_OUT 															  : OUT std_logic;
			Seg1, Seg2, Seg3, Seg4, Seg5, Seg6 												  : OUT std_logic_vector(6 downto 0));
End g04_datapath;

Architecture behaviour of g04_datapath IS
------------------------------------------------------------------------------------------	
	Component g04_mastermind_score IS
	port(	P1, P2, P3, P4   	: in std_logic_vector(2 downto 0);
			G1, G2, G3, G4    : in std_logic_vector(2 downto 0);
			exact_match_score : out std_logic_vector(2 downto 0);
			color_match_score : out std_logic_vector(2 downto 0);
			score_code 	    	: out std_logic_vector(3 downto 0));
	End Component;

	Component g04_possibility_table IS
	Port (TC_EN  : in std_logic;
		  TC_RST  : in std_logic;
		  TM_IN 	 : in std_logic;
		  TM_EN 	 : in std_logic;
		  CLK 	 : in std_logic;
		  TC_LAST : out std_logic;
		  TM_ADDR : out std_logic_vector (11 downto 0);
		  TM_OUT  : out std_logic);
	End Component;
	
	Component g04_random_gen IS
	Port(Button, Resetn, Clock   : IN std_logic;
		  Random_num              : OUT std_logic_vector (11 downto 0);
		  Seg1, Seg2, Seg3, Seg4  : OUT std_logic_vector (6 downto 0));
	End Component;
	
	Component g04_user_input IS
	Port(LD 							 : IN std_logic_vector (3 downto 0);
		  Resetn, Clock, Button	 : IN std_logic;	
		  User_input_num 			 : OUT std_logic_vector (11 downto 0);
		  Seg1, Seg2, Seg3, Seg4 : OUT std_logic_vector (6 downto 0));
	End Component;
	
	Component g04_7_segment_decoder IS
			Port (code            : in std_logic_vector(3 downto 0);
					RippleBlank_In  : in std_logic;
					RippleBlank_Out : out std_logic;
					segments        : out std_logic_vector(6 downto 0));
	End Component;
--------------------------------------------------------------------------------------	
	Signal Random_num, User_input_num, TM_ADDR, HIDDEN_PAT, HIDDEN_PAT_PRE, GUESS_PAT, GUESS_PAT_PRE, GUESS_RES : std_logic_vector (11 downto 0);
	Signal SegR1, SegR2, SegR3, SegR4, SegR5, SegR6 : std_logic_vector (6 downto 0);
	Signal SegU1, SegU2, SegU3, SegU4, SegU5, SegU6 : std_logic_vector (6 downto 0);
	Signal SCORE_RES, A, B, code5, code6 : std_logic_vector (3 downto 0);
	Signal User_Ready : std_logic_vector (1 downto 0);
	Signal RB :std_logic;
---------------------------------------------------------------------------------------
	Begin
		User_Ready <= Mode & Ready;
		
		Segment5: g04_7_segment_decoder PORT MAP (code => code5, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg5);
		Segment6: g04_7_segment_decoder PORT MAP (code => code6, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg6);
		
		MasterMind_Score : g04_mastermind_score
			Port Map (P1 => HIDDEN_PAT (11 downto 9), P2 => HIDDEN_PAT (8 downto 6), P3 => HIDDEN_PAT (5 downto 3), P4 => HIDDEN_PAT (2 downto 0),
						 G1 => GUESS_PAT (11 downto 9), G2 => GUESS_PAT (8 downto 6), G3 => GUESS_PAT (5 downto 3), G4 => GUESS_PAT (2 downto 0),
						 score_code => SCORE_RES);
		
		Possibility_Table :	g04_possibility_table
			Port Map (TC_EN => TC_EN, TC_RST => TC_RST, TM_EN => TM_EN, TM_IN => TM_IN, CLK => CLK, 
						 TC_LAST => TC_LAST, TM_OUT => TM_OUT, TM_ADDR => TM_ADDR);
						 
		Random_gen : g04_random_gen 
			Port Map (Button => Ready , Resetn => Resetn, Clock => CLK, Random_num => Random_num, Seg1 => SegR1, Seg2 => SegR2, Seg3 => SegR3, Seg4 => SegR4);				 
		
		User_guess: g04_user_input
			Port Map (LD => LD, Resetn => Resetn, Clock => CLK, Button => Button, User_input_num => User_input_num, Seg1 => SegU1, Seg2 => SegU2, Seg3 => SegU3, Seg4 => SegU4);
		
		--Multiplexers
----------------------------------------------------------
		With Cheat Select Seg1 <=
			SegU1 When '0',
			SegR1 When '1';
			
		With Cheat Select Seg2 <=
			SegU2 When '0',
			SegR2 When '1';
			
		With Cheat Select Seg3 <=
			SegU3 When '0',
			SegR3 When '1';
			
		With Cheat Select Seg4 <=
			SegU4 When '0',
			SegR4 When '1';
			
----------------------------------------------------------		
		With P_SEL Select HIDDEN_PAT_PRE <=
			EXT_PATTERN When '0',
			TM_ADDR When Others;
		
		With GR_SEL Select GUESS_RES <=
			TM_ADDR When '0',
			"000000000011" When Others; -- input provided to us in the diagram 
		
		With Mode Select HIDDEN_PAT <=
			HIDDEN_PAT_PRE When '0',
			Random_num When '1';
			
		With User_Ready Select GUESS_PAT <=
			User_input_num When "11",
			GUESS_PAT_PRE When Others;
		
		With SR_SEL Select B <=
			SCORE_RES When '0',
			"1110" When Others; -- 1110 is the score encoder for a score of (4,0)
		
		--Registers
		Process (CLK, A, B, Mode, Resetn, Cheat, Ready, Button)
			Begin					
				If (Mode = '1') Then
					Code6 <= "0001";			
				ElsIf (Ready ='1') Then	
					Code5 <= "0001";
				End If;
				If (Ready = '1') Then 	
					If (CLK'EVENT AND CLK = '1') Then
						If (GR_LD = '1') Then
							GUESS_PAT_PRE <= GUESS_RES;
						End If;
						
						If (SR_LD = '1') Then
							A <= SCORE_RES;
						End If;
					End If;
					If (A = B) Then
						SC_CMP <= '1';
					Else
						SC_CMP <= '0';
					End If;
				ElsIf	(Mode = '0' OR Ready = '0') Then
					Code5 <= "0000";
					Code6 <= "0000";
				End If;	
		End Process;			
End behaviour;	
