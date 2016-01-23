--project name: g04_lab4
--entity name: g04_mastermind_score
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483; pei.wu@mail.mcgill.ca
--Date: 30h November, 2015

Library ieee;
Use ieee.std_logic_1164.all;
Library lpm;
Use lpm.lpm_components.all;

Entity g04_mastermind_score IS
	port( P1, P2, P3, P4 	: in std_logic_vector(2 downto 0);
			G1, G2, G3, G4 	: in std_logic_vector(2 downto 0);
			exact_match_score : out std_logic_vector(2 downto 0);
			color_match_score : out std_logic_vector(2 downto 0);
			score_code 			: out std_logic_vector(3 downto 0));
End g04_mastermind_score;

Architecture behaviour of g04_mastermind_score IS
----------------------------Components-------------------------------	
	Component g04_num_matches 
		Port( P1, P2, P3, P4 : IN std_logic_vector(2 downto 0);
				G1, G2, G3, G4 : IN std_logic_vector(2 downto 0);
				N    				: OUT std_logic_vector(2 downto 0)); 
	End Component;
	
	Component g04_color_matches is 
		Port( P1, P2, P3, P4    : in std_logic_vector(2 downto 0);
				G1, G2, G3, G4    : in std_logic_vector(2 downto 0);
				num_exact_matches : in std_logic_vector(2 downto 0);
				num_color_matches : out std_logic_vector(2 downto 0)); 
	End Component; 
	
	Component g04_score_encoder IS 
		port (num_exact_matches : in std_logic_vector (2 downto 0);
				num_color_matches : in std_logic_vector (2 downto 0);
				score_code : out std_logic_vector (3 downto 0));
	End Component;
----------------------------------------------------------------------
-------------------------------Signal---------------------------------	
	Signal num_matches_out, color_matches_out : std_logic_vector (2 downto 0);
----------------------------------------------------------------------
	Begin
		exact_match_score <= num_matches_out;
		color_match_score <= color_matches_out; 
		
		num_matches	  : g04_num_matches   port map (P1 => P1, P2 => P2, P3 => P3, P4 => P4, G1 => G1, G2 => G2, G3 => G3, G4 => G4, N => num_matches_out);
		color_matches : g04_color_matches port map (P1 => P1, P2 => P2, P3 => P3, P4 => P4, G1 => G1, G2 => G2, G3 => G3, G4 => G4, num_exact_matches => num_matches_out, num_color_matches => color_matches_out);
		score			  : g04_score_encoder port map (num_exact_matches => num_matches_out, num_color_matches=> color_matches_out, score_code=> score_code);
End behaviour;