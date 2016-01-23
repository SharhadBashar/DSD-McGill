----project name: g04_lab5
--entity name: g04_2-1_mux
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 7th December, 2015

Library ieee;
Use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity g04_2to1_mux IS
	Port(A, B, sel : IN std_logic;
		  C : OUT std_logic);
End g04_2to1_mux;

Architecture behaviour of g04_2to1_mux IS
	begin
		with sel Select C <=
			A When '0',
			B When '1',
			'0' When Others;
End behaviour;