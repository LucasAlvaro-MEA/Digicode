library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_64_2 is
port(reset: in std_logic;
     clk: in std_logic;
     C: out std_logic_vector(15 downto 0));
end reg_64_2;

architecture Behavioral of reg_64_2 is

signal init,erreur,ok: std_logic_vector(63 downto 0);

begin
process(clk,reset)
    begin
    if reset='1' then
    init<=x"80F8880F8880F888";
    elsif rising_edge(clk)then 
          init(63 downto 4) <= init(59 downto 0) ;
          init(3 downto 0) <= init(63 downto 60) ;
          else 
              init <= init;
     end if;
    end process;
    C <= init(63 downto 48);
end Behavioral; 
