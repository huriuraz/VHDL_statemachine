library ieee;
use ieee.std_logic_1164.all;

entity otopark is

	port 
	(
--		reset	  						: in std_logic:='1';
		clock	  						: in std_logic;
		g							  		: in std_logic_vector(1 downto 0):="00";
		cikis         : out std_logic_vector(6 downto 0)
	);
	
end entity;

architecture rtl of otopark is
	type durumlar is (D1, D2, D3, D4);
	signal durum: durumlar;
		
  -- Constants
  CONSTANT clk_high                         : time := 5 ns;
  CONSTANT clk_low                          : time := 5 ns;
  CONSTANT clk_period                       : time := 10 ns;
  CONSTANT clk_hold                         : time := 2 ns;

	signal   clk:std_logic;
	signal   rst:std_logic:='1';
	
	signal   ileri:std_logic:='0';
	signal   geri:std_logic:='0';
	signal   giren:integer:=0;
	signal   cikan:integer:=0;
BEGIN

  clk_gen: PROCESS
  BEGIN
    clk <= '1';
    WAIT FOR clk_high;
    clk <= '0';
    WAIT FOR clk_low;
  END PROCESS clk_gen;
	
	process (clk,rst)
	begin
		if rst='1' then
			durum<=D1;
			giren<=0;
			cikan<=0;
			rst<='0';
		else
			if rising_edge(clk) then
				case durum is
					when D1 =>
						if g="00" then
							durum<=D1;
						elsif g="10" then
						  ileri<='1';
						  geri<='0';
							durum<=D2;
						elsif g="01" then
							durum<=D4;
							ileri<='0';
							geri<='1';
						end if;
					when D2 =>
						if g="10" then
							durum<=D2;
						elsif g="11" then
							durum<=D3;
						elsif g="00" then
							durum<=D1;
							if geri='1' then
							  cikan<=cikan+1;
							end if;
						end if;
					when D3 =>
						if g="11" then
							durum<=D3;
						elsif g="10" then
							durum<=D2;
						elsif g="01" then
							durum<=D4;
						end if;
					when D4 =>
						if g="01" then
							durum<=D4;
						elsif g="00" then
							durum<=D1;
							if ileri='1' then
							  giren<=giren+1;
							end if;
						elsif g="11" then
							durum<=D3;
						end if;
				end case;
			end if;
		end if;
	end process;
	
end rtl;
