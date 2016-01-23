--project name: g04_lab5
--entity name: g04_possibility_table
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 7th December, 2015

Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
Use ieee.std_logic_unsigned.all;

Entity g04_possibility_table IS
	Port (TC_EN 	 : in std_logic;
		  TC_RST 	 : in std_logic;
		  TM_IN 		 : in std_logic;
		  TM_EN 		 : in std_logic;
		  CLK 	 	 : in std_logic;
		  TC_LAST    : out std_logic;
		  TM_ADDR    : out std_logic_vector (11 downto 0);
		  TM_OUT 	 : out std_logic);
End g04_possibility_table;

Architecture behaviour of g04_possibility_table IS
	signal table 			     		: std_logic_vector (4095 downto 0);
	signal TC 	 				  		: std_logic_vector (11 downto 0);
	signal Peg4, Peg3, Peg2, Peg1 : std_logic_vector (2 downto 0);
	signal holder : std_logic;
	
	begin
		Process(CLK, TC_RST)
			begin
			if (TC_RST = '1') THEN
				Peg1 <= "000";
			ELSIF (CLK'EVENT AND CLK = '1') THEN
				IF (TC_EN = '1' AND holder = '0') then
				Peg1 <= Peg1 + "001";
				if Peg1 = "101" then
					Peg1 <= "000";
				END IF;
				END IF;
			END IF;
		END Process;
		
		Process(CLK, TC_RST)
			begin
			if TC_RST = '1' THEN
				Peg2 <= "000";
				ELSIF (CLK'EVENT AND CLK = '1') THEN
					IF (TC_EN = '1' and holder = '0' and Peg1 = "101") then
					Peg2 <= Peg2 + "001";
					if Peg2="101" then
						Peg2 <= "000";
					END IF;
				END IF;
			END IF;
		END Process;
		
		Process(CLK, TC_RST)
			begin
			if TC_RST = '1' THEN
				Peg3 <= "000";
				ELSIF (CLK'EVENT AND CLK = '1') THEN
				IF (TC_EN = '1' AND holder = '0' AND Peg1 = "101" AND Peg2 = "101") then
				Peg3 <= Peg3 + "001";
				if Peg3 = "101" then
					Peg3 <= "000";
				END IF;
				END IF;
			END IF;
		END Process;
		
		Process(CLK, TC_RST)
			begin
			if TC_RST = '1' THEN
				Peg4 <= "000";
				holder <= '0';
				ELSIF (CLK'EVENT AND CLK = '1') THEN
				holder <= '0';
				IF (TC_EN = '1' AND holder = '0' AND Peg1 = "101" AND Peg2 = "101" AND Peg3 = "101") then
				Peg4 <= Peg4 + "001";
				if Peg4 = "101" then
					Peg4 <= "000";
					holder <= '1';
				END IF;
				END IF;
			END IF;
		END Process;
		
		TM_ADDR <= Peg4 & Peg3 & Peg2 & Peg1;

		TC_LAST <= holder;
		
		Process(CLK, TM_IN, TM_EN )
			begin
			if (CLK'EVENT AND CLK = '1') then
				if (TM_EN = '1') then
					table(to_integer(unsigned(TC)))<= TM_IN;
				END IF;
			END IF;
		END Process;
		TM_OUT <= table(to_integer(unsigned(TC)));
			
End behaviour;