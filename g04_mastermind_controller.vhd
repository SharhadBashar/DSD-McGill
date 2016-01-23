--project name: g04_lab5
--entity name: g04_mastermind_controller
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483; pei.wu@mail.mcgill.ca
--Date: 7th December, 2015

Library ieee;
Use ieee.std_logic_1164.all;

Entity g04_mastermind_controller IS
	Port(SC_CMP, TC_LAST, START, READY, CLK, TM_OUT, RESETN 								: IN std_logic;
		  SR_SEL, P_SEL, GR_SEL, GR_LD, SR_LD, TM_IN, TM_EN, TC_EN, TC_RST, SOLVED : OUT std_logic;
		  OUTPUT 																						: OUT std_logic_vector (3 downto 0));
End g04_mastermind_controller;

Architecture behaviour of g04_mastermind_controller IS
	Type State_type IS (A,B,C,D,E,F,G,H,I,DONE,J,K);
	Signal Current_State : State_type;

	Begin
		Process (CLK,RESETN)
			Begin
			If (RESETN = '1') Then
				Current_State <= A;
				TM_IN <= '0';
				TM_EN <= '0';
				TC_EN <= '0';
				TC_RST <= '1';
				GR_LD <= '0';
				GR_SEL <= '0';
				P_SEL <= '0';
				SR_LD <= '0';
				SR_SEL <= '0';
				SOLVED <= '0';

			ElsIf (CLK'EVENT AND CLK = '1') Then
				Case Current_State IS
					When A =>
						SOLVED <= '0';
						TC_RST <= '1';	
							If (START = '0') Then
								TC_RST <= '0';
								Current_State <= B;
							Else
					 
							Current_State <= A;
							End If;
						
					When B =>
						If (START = '1') Then
							TM_EN <= '1';
							TM_IN <= '1';
							TC_RST <= '0';
							TC_EN <= '1';
							GR_SEL <= '1';
							GR_LD <= '1';
							Current_State <= C;
						ElsIf (START = '0') Then
							Current_State <= B;
						End If;
						
					When C =>
						If (TC_LAST = '0') Then
							Current_State <= C;
						ElsIf (TC_LAST = '1') Then
							GR_LD <= '0';
							SR_LD <= '1';
							P_SEL <= '0';
							TC_RST <= '1';
							Current_State <= D;
						End If;
					
					When D =>
						--TC_RST <= '0';
						If (READY = '1') Then
							SR_SEL <= '1';
							SR_LD <= '0';
							P_SEL <= '1';
							GR_LD <= '0';
							Current_State <= E;
						ElsIf (READY <= '0') Then
							Current_State <= D;
						End If;
						
					When E =>
						If (SC_CMP = '1') Then
							SOLVED <= '1';
							Current_State <= DONE;
						ElsIf(SC_CMP = '0')Then
							SR_LD <= '0';
							TC_RST <= '1';
							GR_SEL <= '0';
							P_SEL <= '1';
							GR_LD <= '1';
							TC_EN <= '1';
							TM_IN <= SC_CMP;
							TM_EN <= '1';
							Current_State <= F;
						End If;
					
					When F =>
						If (TC_LAST = '1') Then
							TC_RST <= '1';
							Current_State <= G;
						ElsIf (TC_LAST ='0') Then
							Current_State <= F;
						End If;
					
					When G =>
						TC_RST <= '0';
						GR_LD <= '0';	
						TC_EN <= '1';
						Current_State <= H;
						
					When H =>
						If (TM_OUT = '0')Then
							Current_State <= H;
						ElsIf (TM_OUT = '1') Then
							GR_LD <= '1';
							GR_SEL <= '0';
							TC_EN <= '0';
							Current_State <=I;
						End If;
					
					
						
					When DONE =>
						SOLVED <= '1';
						TC_RST <= '1';
						Current_State <= A;
						
					When Others =>
						TM_IN <= '0';
						TM_EN <= '0';
						TC_EN <= '0';
						TC_RST <= '1';
						Current_State <= A;
				End Case;		
			End If;
		End Process;

	WITH Current_State SELECT OUTPUT <=
		"0001" When A,
		"0010" When B,
		"0011" When C,
		"0100" When D,
		"0101" When E,
		"0110" When F,
		"0111" When G,
		"1000" When H,
		"1001" When I,
		"1111" When DONE,
		"0000" When Others;
		
End behaviour; 