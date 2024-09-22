library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity soma is
    port(
        x, y : in unsigned(15 downto 0);
        sum  : out unsigned(15 downto 0)
    );
end entity soma;

architecture a_soma of soma is
begin
    sum <= x+y;

end architecture a_soma;