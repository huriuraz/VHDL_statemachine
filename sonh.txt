Library ieee;
use ieee.std_logic_1164.all;

entity uyg8 is
	port(
				rst:in std_logic:='1';
				clk:in std_logic;
				c:out std_logic
			);
end entity;

architecture dene of uyg8 is
	component fp_mul
	PORT
	(
		aclr			: IN 	STD_LOGIC ;
		clk_en		: IN 	STD_LOGIC ;
		clock			: IN 	STD_LOGIC ;
		dataa			: IN 	STD_LOGIC_VECTOR (31 DOWNTO 0);
		datab			: IN 	STD_LOGIC_VECTOR (31 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
	end component;
	
	signal aclr						:	std_logic;
	signal clock					:	std_logic;
	
	signal	clk_en_mul00	:	std_logic;
	signal	dataa_mul00		:	std_logic_vector(31 downto 0);
	signal	datab_mul00		:	std_logic_vector(31 downto 0);
	signal	result_mul00	:	std_logic_vector(31 downto 0);

	signal	clk_en_mul01	:	std_logic;
	signal	dataa_mul01		:	std_logic_vector(31 downto 0);
	signal	datab_mul01		:	std_logic_vector(31 downto 0);
	signal	result_mul01	:	std_logic_vector(31 downto 0);

	type durumlar is (veri_hazirla, islem_yap, sonuc_uret);
	signal durum:durumlar;
	
	signal	say:integer:=0;
	
begin

	clock<=clk;
	
	process (clk,rst)
	begin
		if rst='1' then
			aclr<='1';
			clk_en_mul00<='0';
			clk_en_mul01<='0';
			durum<=veri_hazirla;
			
			say<=0;
		elsif rising_edge(clk) then
			case durum is
				when veri_hazirla=>
					aclr<='0';
					clk_en_mul00<='0';
					clk_en_mul01<='0';
					
					dataa_mul00<=x"3FC00000";
					datab_mul00<=x"40000000";

					
					durum<=islem_yap;
					
				when islem_yap=>
					clk_en_mul00<='1';
					clk_en_mul01<='1';
					
					if say<5 then
						say<=say+1;
					else
						durum<=sonuc_uret;
					end if;
				when sonuc_uret=>
					say<=0;
					dataa_mul01<=result_mul00;
					datab_mul01<=x"40200000";
			end case;
		

			

		end if;
	end process;


fpmul_inst00 : fp_mul PORT MAP (
		aclr	 		=> aclr,
		clk_en	 	=> clk_en_mul00,
		clock	 		=> clock,
		dataa	 		=> dataa_mul00,
		datab	 		=> datab_mul00,
		result	 	=> result_mul00
	);

fpmul_inst01 : fp_mul PORT MAP (
		aclr	 		=> aclr,
		clk_en	 	=> clk_en_mul01,
		clock	 		=> clock,
		dataa	 		=> dataa_mul01,
		datab	 		=> datab_mul01,
		result	 	=> result_mul01
	);

end architecture;



