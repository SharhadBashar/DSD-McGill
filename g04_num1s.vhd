--project name: g04_lab4
--entity name: g04_num1s
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483; pei.wu@mail.mcgill.ca
--Date: 30 November, 2015


library ieee;
use ieee.std_logic_1164.all;

ENTITY g04_num1s is
	port( X     : in std_logic_vector(3 downto 0);
		N : out std_logic_vector(2 downto 0));
END g04_num1s;

ARCHITECTURE Behaviour of g04_num1s IS 
	BEGIN
		N(0) <= ((NOT X(0)) AND (NOT X(2)) AND (NOT X(3)) AND X(1)) OR
				((NOT X(1)) AND (NOT X(2)) AND (NOT X(3)) AND X(0)) OR 
				((NOT X(0)) AND (NOT X(1)) AND (NOT X(2)) AND X(3)) OR 
				((NOT X(0)) AND (NOT X(1)) AND (NOT X(3)) AND X(2)) OR 
				((NOT X(2)) AND X(0) AND X(1) AND X(3)) OR 
				((NOT X(0)) AND X(1) AND X(2) AND X(3)) OR 
				((NOT X(1)) AND X(0) AND X(2) AND X(3)) OR 
				((NOT X(3)) AND X(0) AND X(1) AND X(2));

		N(1) <= ((NOT X(3)) AND X(1) AND X(0)) OR (X(2) AND (NOT X(1)) AND X(0)) OR (X(2) AND X(1) AND (NOT X(0))) OR (X(3) AND (NOT X(2)) AND X(1)) OR (X(3) AND (NOT X(2)) AND X(1)) OR(X(3) AND X(2) AND (NOT X(1)));
		N(2) <= X(0) AND X(1) AND X(2) AND x(3);
END Behaviour;  