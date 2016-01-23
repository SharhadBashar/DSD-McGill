--project name: g04_lab4
--exact match counting part of the scoring circuit for the Mastermind game
--entity name: g04_num_matches
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 30th November, 2015

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;

entity g04_num_matches IS
	Port( P1, P2, P3, P4 : IN std_logic_vector(2 downto 0);
		   G1, G2, G3, G4 : IN std_logic_vector(2 downto 0);
		   N    				: OUT std_logic_vector(2 downto 0)); 
end g04_num_matches;

architecture behaviour of g04_num_matches is
	signal X1, X2, X3, X4								 : std_logic;
	signal X_append										 : std_logic_vector (3 DOWNTO 0);
	signal P_1, P_2, P_3, P_4, G_1, G_2, G_3, G_4 : std_logic_vector(5 DOWNTO 0);
	
	Component g04_comp6
		PORT(A 			:  IN  std_logic_vector(5 DOWNTO 0);
			  B 			:  IN  std_logic_vector(5 DOWNTO 0);
			  pin_name3 :  OUT  std_logic);
	End Component;
	
	Component g04_num1s
		port( X : in std_logic_vector(3 downto 0);
				N : out std_logic_vector(2 downto 0));
	End Component;
	
	Begin
		P_1 <= "000" & P1;
		P_2 <= "000" & P2;
		P_3 <= "000" & P3; 
		P_4 <= "000" & P4;
		
		G_1 <= "000" & G1;
		G_2 <= "000" & G2;
		G_3 <= "000" & G3;
		G_4 <= "000" & G4;
		
		X_append <= X4 & X3 & X2 & X1;
		
		comp61: g04_comp6 port map (A => P_1, B => G_1, pin_name3 => X1);
		comp62: g04_comp6 port map (A => P_2, B => G_2, pin_name3 => X2);
		comp63: g04_comp6 port map (A => P_3, B => G_3, pin_name3 => X3);
		comp64: g04_comp6 port map (A => P_4, B => G_4, pin_name3 => X4);
		
		num1s : g04_num1s port map (X => X_append , N=> N);
End behaviour;