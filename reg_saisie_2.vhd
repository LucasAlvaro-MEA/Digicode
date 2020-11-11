library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity reg_saisie_2 is
port(en : in std_logic_vector(3 downto 0);
     btn : in std_logic_vector(2 downto 0);
     clk: in std_logic;
     C_mess: in std_logic_vector(15 downto 0);
     E1_reg:out std_logic_vector(3 downto 0);
     E2_reg:out std_logic_vector(3 downto 0);
     E3_reg:out std_logic_vector(3 downto 0);
     E4_reg:out std_logic_vector(3 downto 0));
end reg_saisie_2;

architecture Behavioral of reg_saisie_2 is

begin
seq: PROCESS( clk, btn, en)
    BEGIN
    if rising_edge(clk) THEN
    if C_mess=x"0000" then        
        if en="0001" then
        E3_reg<="1000";
        E2_reg<="1000";
        E1_reg<="1000";
            if btn(1)='1' then
            E4_reg<="0001";
            elsif btn(2)='1' then
            E4_reg<="0010";
            else E4_reg<="0000";
            end if;
        end if;
        if en="0010" then
            if btn(1)='1' then
             E3_reg<="0001";
             elsif btn(2)='1' then
             E3_reg<="0010";
             else E3_reg<="0000";
             end if;
         end if;
         if en="0100" then
             if btn(1)='1' then
             E2_reg<="0001";
             elsif btn(2)='1' then
             E2_reg<="0010";
             else E2_reg<="0000";
             end if;
          end if;
          if en="1000" then
             if btn(1)='1' then
             E1_reg<="0001";
             elsif btn(2)='1' then
             E1_reg<="0010";
             else E1_reg<="0000";
             end if;
          end if;     
       end if;
    end if;
end process;

end Behavioral;
