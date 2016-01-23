--project name: g04_lab5
--entity name: g04_7_segment_decoder
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 30th November, 2015

Library ieee;
Use ieee.std_logic_1164.all;

Entity g04_7_segment_decoder IS 
	Port (code            : in std_logic_vector(3 downto 0);
			RippleBlank_In  : in std_logic;
			RippleBlank_Out : out std_logic;
			segments        : out std_logic_vector(6 downto 0));
End g04_7_segment_decoder;

Architecture behaviour of g04_7_segment_decoder IS
	signal temp : std_logic_vector (6 downto 0);
	begin 
	
	segments <= "1000000" when (code = "0000") and (RippleBlank_In = '1') else temp;
	RippleBlank_Out <= '1' when ((code = "0000") and (RippleBlank_In = '1')) else '0';
	with code select temp <=  "1000000" when "0000",
				  "1111001" when "0001", 
									  "0100100" when "0010",
									  "0110000" when "0011", 
									  "0011001" when "0100", 
									  "0010010" when "0101", 
									  "0000010" when "0110", 
									  "1111000" when "0111", 
									  "0000000" when "1000",
									  "0010000" when "1001",
									  "0001000" when "1010",
									  "0000011" when "1011", 
									  "1000110" when "1100", 
									  "0100001" when "1101", 
									  "0000110" when "1110", 
									  "0001110" when "1111",
									  "1111111" when others;
									 													
End behaviour;