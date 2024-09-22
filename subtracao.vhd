library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity subtracao is
    port(
        x, y : in unsigned(15 downto 0);
        sub  : out unsigned(15 downto 0)
    );
end entity subtracao;

architecture a_subtracao of subtracao is
begin
    sub <= x-y;

end architecture a_subtracao;