library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_of_top is
port(btnT: in std_logic;
     btnL: in std_logic;
     btnC: in std_logic;
     btnR: in std_logic;
     mclk: in std_logic;
     sw : in std_logic_vector(7 downto 0);
     seg: out  std_logic_vector(0 to 6);
     ld : out std_logic_vector(1 downto 0);
     an : out std_logic_vector(3 downto 0));
end top_of_top;

architecture Behavioral of top_of_top is


component clkdiv
port(rst: in std_logic;
     clk: in std_logic;
     clkout: out std_logic);
end component;

component clkdiv2
port(rst: in std_logic;
     clk: in std_logic;
     clkout: out std_logic);
end component;

component compteur4
port(rst: in std_logic;
     clk: in std_logic;
     sortie: out std_logic_vector( 1 downto 0));
end component;

component gestion_an 
port( rst : in std_logic;
      cmpt : in std_logic_vector(1 downto 0);
      an: out std_logic_vector(3 downto 0) );
end component;

component multiplex4
port( E1: in std_logic_vector(3 downto 0);
      E2: in std_logic_vector(3 downto 0);
      E3: in std_logic_vector(3 downto 0);
      E4: in std_logic_vector(3 downto 0);
      entree: in std_logic_vector(1 downto 0);
      sortie: out std_logic_vector(3 downto 0));
end component;

component hex7seg
  port(
    hex: in std_logic_vector(3 downto 0);
    a_to_g: out std_logic_vector(6 downto 0));
end component;

component digicode_top
port( btn : in std_logic_vector(3 downto 0);
      mclk: in std_logic;
      sw : in std_logic_vector(7 downto 0);
      ld : out std_logic_vector(1 downto 0);
      clock_pulse_out: out std_logic;
      en_etat : out std_logic_vector(3 downto 0));
end component;

component reg_saisie
port(en : in std_logic_vector(3 downto 0);
     btn : in std_logic_vector(2 downto 0);
     clk: in std_logic;
     E1_reg:out std_logic_vector(3 downto 0);
     E2_reg:out std_logic_vector(3 downto 0);
     E3_reg:out std_logic_vector(3 downto 0);
     E4_reg:out std_logic_vector(3 downto 0));
end component;

component reg_64
port(reset: in std_logic;
    clk: in std_logic;
     en : in std_logic_vector(3 downto 0);
     ld : in std_logic_vector(1 downto 0);
     C: out std_logic_vector(15 downto 0));
end component;

signal clk190,clk3,pulse: std_logic;
signal sortie_c,ld_S: std_logic_vector( 1 downto 0);
signal sortie_m : std_logic_vector( 3 downto 0);
signal E1_s,E2_s,E3_s,E4_s,en_S:std_logic_vector(3 downto 0);
signal mess:std_logic_vector(15 downto 0);


begin

uut1: clkdiv port map(rst=>btnT,clk=>mclk,clkout=>clk190);
uut2: compteur4 port map(clk=>clk190,rst=>btnT, sortie=>sortie_c);
uut3: gestion_an port map(cmpt=>sortie_c,rst=>btnT,an=>an);
uut4: hex7seg port map(hex=>sortie_m,a_to_g=>seg);
uut5: multiplex4 port map (E1=>E1_S,E2=>E2_S,E3=>E3_S,E4=>E4_S,entree=>sortie_c,sortie=>sortie_m);
uut6: digicode_top port map(btn(0)=>btnL,btn(1)=>btnC,btn(2)=>btnR,btn(3)=>btnT,mclk=>mclk, sw=>sw, ld=>ld_S, clock_pulse_out=>pulse,en_etat=>en_S);
uut7: reg_saisie port map (en=>en_S,btn(0)=>btnT,btn(1)=>btnC,btn(2)=>btnR,clk=>pulse,E1_reg=>E1_S,E2_reg=>E2_S,E3_reg=>E3_S,E4_reg=>E4_S);
uut8: clkdiv2 port map(rst=>btnT,clk=>mclk,clkout=>clk3);
uut9: reg_64 port map(reset=>btnT,en=>en_S,ld=>ld_S,clk=>clk3,C=>mess);


end Behavioral;
