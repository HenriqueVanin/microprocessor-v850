library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity soma_tb is
end;

architecture a_soma_tb of soma_tb is
    component soma is
        port
        (
            x    : IN unsigned (15 downto 0);
            y    : IN unsigned (15 downto 0);
            sum  : OUT unsigned (15 downto 0)
        );
    end component;
    signal x, y, sum : unsigned(15 downto 0);
begin
    uut: soma port map(x => x, y => y, sum => sum);
    process
    begin
        x <= "0000000000000000";
        y <= "0000100000000000";
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