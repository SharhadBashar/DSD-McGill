--project name: g04_lab5
--entity name: g04_random_gen
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 7th December, 2015

Library ieee;
Use ieee.std_logic_1164.all;

Entity g04_random_gen IS
	Port(Button, Resetn, Clock   : IN std_logic;
		  Random_num              : OUT std_logic_vector (11 downto 0);
		  Seg1, Seg2, Seg3, Seg4  : OUT std_logic_vector (6 downto 0));
End g04_random_gen;

Architecture behaviour of g04_random_gen IS

	Component g04_possibility_table IS
		Port(TC_EN 	 : in std_logic;
			  TC_RST  : in std_logic;
			  TM_IN 	 : in std_logic;
			  TM_EN 	 : in std_logic;
			  CLK 	 : in std_logic;
			  TC_LAST : out std_logic;
			  TM_ADDR : out std_logic_vector (11 downto 0);
			  TM_OUT  : out std_logic);
	End Component;
	
	Component g04_7_segment_decoder IS
			Port (code            : in std_logic_vector(3 downto 0);
					RippleBlank_In  : in std_logic;
					RippleBlank_Out : out std_logic;
					segments        : out std_logic_vector(6 downto 0));
	End Component;
	
	Signal RS, RB, NI,  LA, OT, NE : std_logic;
	Signal AD : std_logic_vector (11 downto 0);
	
	Signal code1, code2, code3, code4 : std_logic_vector (3 downto 0);
	
	Begin		
	
		values_table: g04_possibility_table PORT MAP(TC_EN => '1', TC_RST => RS, TM_IN => '0', TM_EN => '0', CLK => Clock, TC_LAST => LA, TM_ADDR => AD, TM_OUT => OT);
		
		num1: g04_7_segment_decoder PORT MAP (code => code1, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg1);
		num2: g04_7_segment_decoder PORT MAP (code => code2, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg2);
		num3: g04_7_segment_decoder PORT MAP (code => code3, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg3);
		num4: g04_7_segment_decoder PORT MAP (code => code4, RippleBlank_In => '1', RippleBlank_Out => RB, segments => Seg4);
		
		Process (Button, Clock, Resetn)
			Begin
				If (Resetn = '0') Then				
					Random_num <= "000000000000"; 
						code1 <= "0000";
						code2 <= "0000";
						code3 <= "0000";
						code4 <= "0000";						
					ElsIf (Button = '0')Then  
						Random_num <= AD;
						code1 <= '0'&AD(2)&AD(1)&AD(0);
						code2 <= '0'&AD(5)&AD(4)&AD(3);
						code3 <= '0'&AD(8)&AD(7)&AD(6);
						code4 <= '0'&AD(11)&AD(10)&AD(9);		
				End If;
		End Process;		
End behaviour;  