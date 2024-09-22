library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Ula_tb is
end entity Ula_tb;

architecture a_Ula_tb of Ula_tb is
    component Ula is
        port
        (
            dado1             : IN unsigned (15 downto 0);
            dado2             : IN unsigned (15 downto 0);
            op0               : IN std_logic ;
            op1               : IN std_logic ;
            saida_dado        : OUT unsigned (15 downto 0)
           
        );
    end component;
    signal dado1, dado2, saida_dado : unsigned(15 downto 0);
    signal op0, op1, saida_sinalizacao : std_logic;
begin
    uut: Ula port map(dado1 => dado1, dado2 => dado2, saida_dado => saida_dado, op0 => op0, op1 => op1);
    process
    begin
        dado1 <= "0000000000000110";  -- 6
        dado2 <= "0000000000001001";  -- 9
        op0 <= '0';
        op1 <= '0';
        wait for 50 ns;
        op0 <= '1';
        op1 <= '0';
        wait for 50 ns;
        op0 <= '0';
        op1 <= '1';
        wait for 50 ns;
        op0 <= '1';
        op1 <= '1';
        wait for 50 ns;
        wait;
    end process;
end architecture;