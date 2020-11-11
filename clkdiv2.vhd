library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity clkdiv2 is
port(rst: in std_logic;
     clk: in std_logic;
     clkout: out std_logic);
end clkdiv2;

architecture Behavioral of clkdiv2 is
signal compt: std_logic_vector(1 downto 0);
begin

process(rst,clk)
begin
    if rst ='1' then
      compt <= (others => '0');
    elsif rising_edge(clk) then
        compt<=compt +1;
    end if;
end process;

clkout<=compt(1);
end Behavioral;