--project name: g04_lab4
--entity name: g04_minimum3
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 30th November, 2015

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;

entity g04_minimum3 is
	Port (N, M : IN std_logic_vector(2 downto 0);
			min  : OUT std_logic_vector (2 downto 0));
			-- n = a and m = b 
End g04_minimum3;

Architecture behaviour of g04_minimum3 IS
	signal i0, i1, i2, i3, i4, i5, i6, i7, i8 : std_logic;
	begin
		i0 <= N(0) XNOR M(0);
		i1 <= N(1) XNOR M(1);
		i2 <= N(2) XNOR M(2);
		
		i6 <= i0 AND i1 AND i2;
		
		i3 <= N(0) AND (NOT M(0)) AND i1 AND i2;
		i4 <= N(1) AND (NOT M(1)) AND i2;
		i5 <= N(2) AND (NOT M(2));
		
		i7 <= i3 OR i4 OR i5;
		
		i8 <= i6 NOR i7;
		
		min <= N when i8 = '1' else
				 M when i8 = '0';
End behaviour;