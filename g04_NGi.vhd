--entity name: g04_NGi
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 16th October, 2015

library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

Entity g04_NGi IS
	Port (G1, G2, G3, G4 		  				  : in std_logic_vector (2 downto 0);
			NGi1, NGi2, NGi3, NGi4, NGi5, NGi6 : out std_logic_vector (2 downto 0));
End Entity;

Architecture behaviour of g04_NGi IS
	signal EQ1, EQ2, EQ3, EQ4 		: std_logic_vector (7 downto 0);
	signal X0, X1, X2, X3, X4, X5 : std_logic_vector (3 downto 0);
	
	Component g04_num1s
		Port( X : in std_logic_vector(3 downto 0);
				N : out std_logic_vector(2 downto 0));
	End Component;
	
	Component lpm_decode
		GENERIC (LPM_WIDTH: INTEGER := 3;
					LPM_DECODES: INTEGER := 8;
					LPM_PIPELINE: INTEGER := 0;
					LPM_TYPE: STRING := "LPM_DECODE";
					LPM_HINT: STRING := "UNUSED");
		PORT (data: IN STD_LOGIC_VECTOR(2 DOWNTO 0);
				aclr, clock: IN STD_LOGIC := '0';
				clken, enable: IN STD_LOGIC := '1';
				eq: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	End component;
	
	Begin 
		X0 <= EQ1(0) & EQ2(0) & EQ3(0) & EQ4(0);
		X1 <= EQ1(1) & EQ2(1) & EQ3(1) & EQ4(1);
		X2 <= EQ1(2) & EQ2(2) & EQ3(2) & EQ4(2);
		X3 <= EQ1(3) & EQ2(3) & EQ3(3) & EQ4(3);
		X4 <= EQ1(4) & EQ2(4) & EQ3(4) & EQ4(4);
		X5 <= EQ1(5) & EQ2(5) & EQ3(5) & EQ4(5);
		
		lpm_decode1 : lpm_decode port map (data => G1, eq => EQ1);
		lpm_decode2 : lpm_decode port map (data => G2, eq => EQ2);
		lpm_decode3 : lpm_decode port map (data => G3, eq => EQ3);
		lpm_decode4 : lpm_decode port map (data => G4, eq => EQ4);
		
		num1s1 : g04_num1s port map(X => X0, N => NGi1);
		num1s2 : g04_num1s port map(X => X1, N => NGi2);
		num1s3 : g04_num1s port map(X => X2, N => NGi3);
		num1s4 : g04_num1s port map(X => X3, N => NGi4);
		num1s5 : g04_num1s port map(X => X4, N => NGi5);
		num1s6 : g04_num1s port map(X => X5, N => NGi6);
End behaviour;
		
	