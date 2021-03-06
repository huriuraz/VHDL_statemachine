library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity alusimulasyon is
  port(
  a: in signed(3 downto 0);
  b: in signed(3 downto 0); 
  sel : in STD_LOGIC_VECTOR (3 downto 0);
   y: out signed(3 downto 0)
  );
end alusimulasyon;
architecture alu of alusimulasyon is
begin
process(a, b,  sel) 
begin

		 if sel="0000" then 
		 y <= a ; 
		elsif sel="0001" then 
		 y<= a+1; 
		 elsif sel="0010" then
		 y<= a - 1; 
		 elsif sel="0011" then 
		 y<= b;    
		 elsif sel="0100" then
		 y<= b+1; 
		 elsif sel="0101" then 
		 y<=b-1 ; 
		 elsif sel="0110" then 
		 y<= a+b; 
		 elsif sel="1000" then
		 y<= not a;
		 elsif sel="1001" then
		 y<= not b;
		 elsif sel="1010" then
		 y<= a and b;
		 elsif sel="1011" then
		 y<= a or b;
		 elsif sel="1100" then
		 y<= a nand b;
		 elsif sel="1101" then
		 y<= a nor b;
		 elsif sel="1110" then
		 y<= a xor b;
		 elsif sel="1111" then
		 y<= a xnor b;
		 else 
		 y<="ZZZZ";
		 end if; 
  
end process; 
 
end alu;
