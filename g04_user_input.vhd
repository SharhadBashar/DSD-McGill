--project name: g04_lab5
--entity name: g04_user_input
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 7th December, 2015

Library ieee;
Use ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity g04_user_input IS
	Port(LD 							 : IN std_logic_vector (3 downto 0);
		  Resetn, Clock, Button	 : IN std_logic;	
		  User_input_num 			 : OUT std_logic_vector (11 downto 0);
		  Seg1, Seg2, Seg3, Seg4 : OUT std_logic_vector (6 downto 0));
End g04_user_input;

Architecture behaviour of g04_user_input IS

	Signal Code1, Code2, Code3, Code4  : std_logic_vector (3 downto 0):= "0000";
	Signal Code5 : std_logic_vector (3 downto 0);
	Signal RB : std_logic;
	signal test : std_logic_vector(11 downto 0);
	
	Component g04_7_segment_decoder IS
		Port (code            : in std_logic_vector(3 downto 0);
				RippleBlank_In  : in std_logic;
				RippleBlank_Out : out std_logic;
				segments        : out std_logic_vector(6 downto 0));
	End Component;
	
	Begin
		User_input_num <= test;
		num1: g04_7_segment_decoder PORT MAP (code => Code1, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg1);
		num2: g04_7_segment_decoder PORT MAP (code => Code2, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg2);
		num3: g04_7_segment_decoder PORT MAP (code => Code3, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg3);
		num4: g04_7_segment_decoder PORT MAP (code => Code4, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg4);
		
		Process (Resetn, Button, Clock)
			Begin
				If (Resetn = '0') then
					Code1 <= "0000";
					Code2 <= "0000";
					Code3 <= "0000";
					Code4 <= "0000";
				
				ElsIf (LD(0) = '1' AND LD(1) = '0' AND LD(2) ='0' AND LD(3) = '0') Then	
					If (Button'Event and Button = '0') then	
						Code1 <= Code1 + 1;
--						If (LD(0) = '0') Then
--							test (2 downto 0) <= Code1 (2 downto 0);										
--						End If;
						If (Code1 = "0101") Then	
							Code1 <= "0000";
						End If;
					End If;	
					test (2 downto 0) <= Code1 (2 downto 0);
						
				ElsIf (LD(0) = '0' AND LD(1) = '1' AND LD(2) ='0' AND LD(3) = '0') Then	
					If (Button'Event and Button = '0') then	
						Code2 <= Code2 + 1;
--						If (LD(1) = '0') Then
--							test (5 downto 3) <= Code2 (2 downto 0);
--						End If;
						If (Code2 = "0101") Then	
							Code2 <= "0000";
						End If;
					End If;
					test (5 downto 3) <= Code2 (2 downto 0);
					
				ElsIf (LD(0) = '0' AND LD(1) = '0' AND LD(2) ='1' AND LD(3) = '0') Then	
					If (Button'Event and Button = '0') then	
						Code3 <= Code3 + 1;
--						If (LD(2) = '0') Then
--							test (8 downto 6) <= Code3 (2 downto 0);
--						End If;
						If (Code3 = "0101") Then	
							Code3 <= "0000";
						End If;
					End If;
					test (8 downto 6) <= Code3 (2 downto 0);
					
				ElsIf (LD(0) = '0' AND LD(1) = '0' AND LD(2) ='0' AND LD(3) = '1') Then	
					If (Button'Event and Button = '0') then	
						Code4 <= Code4 + 1;
--						If (LD(2) = '0') Then
--							test (11 downto 9) <= Code4 (2 downto 0);
--						End If;
						If (Code4 = "0101") Then	
							Code4 <= "0000";
						End If;
					End If;
					test (11 downto 9) <= Code4 (2 downto 0);
				End If;				
		End Process;			
End behaviour; 		  