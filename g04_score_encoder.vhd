--entity name: g04_score_encoder
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483; pei.wu@mail.mcgill.ca
--Date: 30th November, 2015

Library ieee;
Library lpm;
Use ieee.std_logic_1164.all; 
Use lpm.lpm_components.all;

Entity g04_score_encoder IS 
	port (num_exact_matches : in std_logic_vector (2 downto 0);
			num_color_matches : in std_logic_vector (2 downto 0);
			score_code : out std_logic_vector (3 downto 0));
End g04_score_encoder;

Architecture behaviour of g04_score_encoder IS
	signal X : std_logic_vector (5 downto 0);
	
	begin
		X <= num_exact_matches & num_color_matches;
		with X select
			score_code <= "1110" when "100000", --14 when (4,0)
							  "1101" when "011000", --13 when (3,0) 
							  "1100" when "010010", --12 when (2,2)
							  "1011" when "010001", --11 when (2,1)
							  "1010" when "010000", --10 when (2,0)
							  "1001" when "001011", --9 when (1,3)
							  "1000" when "001010", --8 when (1,2)
							  "0111" when "001001", --7 when (1,1)
							  "0110" when "001000", --6 when (1,0)
							  "0101" when "000100", --5 when (0,4)
							  "0100" when "000011", --4 when (0,3)
							  "0011" when "000010", --3 when (0,2)
							  "0010" when "000001", --2 when (0,1)
							  "0001" when "000000", --1 when (0,0)
							  "0000" when others;
End behaviour;