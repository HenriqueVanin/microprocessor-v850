library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity subtracao_tb is
end;

architecture a_subtracao_tb of subtracao_tb is
    component subtracao is
        port
        (
            x    : IN unsigned (15 downto 0);
            y    : IN unsigned (15 downto 0);
            sub  : OUT unsigned (15 downto 0)
        );
    end component;
    signal x, y, sub : unsigned(15 downto 0);
begin
    uut: subtracao port map(x => x, y => y, sub => sub);
    process
    begin
        x <= "0000000000000110";
        y <= "0000100000001001";
        wait for 50 ns;
        x <= "0000111100000000";
        y <= "0000101000000000";
        wait for 50 ns;
        x <= "0110010000000000";
        y <= "0110010000000000";
        wait for 50 ns;
        x <= "1111111111001110";
        y <= "0000000000101000";
        wait for 50 ns;
        wait;
    end process;
end architecture;