library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity multiplex_mess is
port (clk : in std_logic;
      led : in std_logic_vector(1 downto 0);
      init: in std_logic_vector(3 downto 0);
      c_init: in std_logic_vector(15 downto 0);
      c_erreur:in std_logic_vector(15 downto 0);
      c_ok:in std_logic_vector(15 downto 0);
      E1_saisie: in std_logic_vector(3 downto 0);
      E2_saisie: in std_logic_vector(3 downto 0);
      E3_saisie: in std_logic_vector(3 downto 0);
      E4_saisie: in std_logic_vector(3 downto 0);
      E1: out std_logic_vector(3 downto 0);
      E2: out std_logic_vector(3 downto 0);
      E3: out std_logic_vector(3 downto 0);
      E4: out std_logic_vector(3 downto 0));
end multiplex_mess;


architecture Behavioral of multiplex_mess is

signal mess_s : std_logic_vector(15 downto 0);
signal compteur: std_logic_vector(2 downto 0);
begin

cbn: PROCESS(led,init)
begin
    if led(0)='1' then
    mess_s<=c_ok;
    elsif led(1)='1' then
    mess_s<=c_erreur;
    elsif init="0000" then
    mess_s<=c_init;
    end if;
end process;


sqt: PROCESS(led,init,E1_saisie,E2_saisie,E3_saisie,E4_saisie)
begin
    if ((led(0)='1' or led(1)='1') and compteur="100") then
    E1<=mess_s(3 downto 0);
    E2<=mess_s(7 downto 4);
    E3<=mess_s(11 downto 8);
    E4<=mess_s(15 downto 12);
    elsif init="0000" then
    E1<=mess_s(3 downto 0);
    E2<=mess_s(7 downto 4);
    E3<=mess_s(11 downto 8);
    E4<=mess_s(15 downto 12);
    else
    E1<=E1_saisie;
    E2<=E2_saisie;
    E3<=E3_saisie;
    E4<=E4_saisie;
    end if;
end process;


compteur_p: PROCESS(clk)
begin
    
  if rising_edge(clk) then
    if not (led(0)='1' or led(1)='1') then 
    compteur<=(others=>'0');
    elsif compteur="100" then
    compteur<="100";
    else compteur<=compteur+1;
    end if;
  end if;
end process;

end Behavioral;
