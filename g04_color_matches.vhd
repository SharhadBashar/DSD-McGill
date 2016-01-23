--project name: g04_lab5
--entity name: g04_color_matches
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 16th October, 2015

library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity g04_color_matches is 
	port( P1, P2, P3, P4    : in std_logic_vector(2 downto 0);
			G1, G2, G3, G4    : in std_logic_vector(2 downto 0);
			num_exact_matches : in std_logic_vector(2 downto 0);
			num_color_matches : out std_logic_vector(2 downto 0)); 
end g04_color_matches;

Architecture behaviour of g04_color_matches is
	signal NGi1, NGi2, NGi3, NGi4, NGi5, NGi6, NPi1, Npi2, NPi3, NPi4, NPi5, NPi6 : std_logic_vector(2 downto 0); 
	signal min1, min2, min3, min4, min5, min6 												: std_logic_vector(2 downto 0);
	signal add1, add2, add3, add4, add5															: std_logic_vector(2 downto 0);
	
	Component g04_NPi
		Port (P1, P2, P3, P4 		  				  : in std_logic_vector (2 downto 0);
				NPi1, NPi2, NPi3, NPi4, NPi5, NPi6 : out std_logic_vector (2 downto 0));
	End Component;
	
	Component g04_NGi
		Port (G1, G2, G3, G4 		  				  : in std_logic_vector (2 downto 0);
				NGi1, NGi2, NGi3, NGi4, NGi5, NGi6 : out std_logic_vector (2 downto 0));
	End Component;
		
	Component g04_minimum3
		Port (N, M : IN std_logic_vector(2 downto 0);
				min  : OUT std_logic_vector (2 downto 0));
			-- N = A and M = B 
	End Component;
	
	COMPONENT lpm_add_sub
		GENERIC (LPM_WIDTH: integer := 3;
			LPM_DIRECTION: STRING := "UNUSED"
			);
		PORT (dataa, datab: IN STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0);
			
			result: OUT STD_LOGIC_VECTOR(LPM_WIDTH-1 DOWNTO 0)
			);
	END COMPONENT;
	
	begin
		NPi : g04_NPi port map (P1 => P1, P2 => P2, P3 => P3, P4 => P4, NPi1 => NPi1, NPi2 => NPi2, NPi3 => NPi3, NPi4 => NPi4, NPi5 => NPi5, NPi6 => NPi6);
		NGi : g04_NGi port map (G1 => G1, G2 => G2, G3 => G3, G4 => G4, NGi1 => NGi1, NGi2 => NGi2, NGi3 => NGi3, NGi4 => NGi4, NGi5 => NGi5, NGi6 => NGi6);
		
		min3_1 : g04_minimum3 port map (N => NPi1, M => NGi1, min => min1);
		min3_2 : g04_minimum3 port map (N => NPi2, M => NGi2, min => min2);
		min3_3 : g04_minimum3 port map (N => NPi3, M => NGi3, min => min3);
		min3_4 : g04_minimum3 port map (N => NPi4, M => NGi4, min => min4);
		min3_5 : g04_minimum3 port map (N => NPi5, M => NGi5, min => min5);
		min3_6 : g04_minimum3 port map (N => NPi6, M => NGi6, min => min6);
		
		add_sub1 : lpm_add_sub generic map (LPM_DIRECTION => "ADD") port map (dataa => min1, datab => min2, result => add1);
		add_sub2 : lpm_add_sub generic map (LPM_DIRECTION => "ADD") port map (dataa => add1, datab => min3, result => add2);
		add_sub3 : lpm_add_sub generic map (LPM_DIRECTION => "ADD") port map (dataa => add2, datab => min4, result => add3);
		add_sub4 : lpm_add_sub generic map (LPM_DIRECTION => "ADD") port map (dataa => add3, datab => min5, result => add4);
		add_sub5 : lpm_add_sub generic map (LPM_DIRECTION => "ADD") port map (dataa => add4, datab => min6, result => add5);
		
		add_sub6 : lpm_add_sub generic map (LPM_DIRECTION => "SUB") port map (dataa => add5, datab => num_exact_matches, result => num_color_matches);
		
End behaviour;