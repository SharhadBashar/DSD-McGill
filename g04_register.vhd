--project name: g04_lab5
--entity name: g04_register
--Copyright (C) 2015 Bashar; Wu
--Version 1.0
--Author: Sharhad Bashar; 260519664; sharhad.bashar@mail.mcgill.ca
--   	    Richard Wu; 260509483;pei.wu@mail.mcgill.ca
--Date: 7th December, 2015

Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity g04_register IS
	Port (Input, Clock, En : IN std_logic;
			Output : OUT std_logic);
End g04_register;

Architecture behaviour of g04_register IS
	Begin
		Process (clock)
		Begin	
			If (Clock'EVENT AND Clock = '1') Then
				If (En = '1') Then
					Output <= Input;
				End If;
			End If;
		End Process;
End behaviour;
