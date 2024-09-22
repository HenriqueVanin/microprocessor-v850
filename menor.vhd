library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity menor is
    port(
        x, y : in unsigned(15 downto 0);
        resultado  : out unsigned(15 downto 0)
    );
end entity menor;

architecture a_menor of menor is
begin
    resultado <= "0000000000000001" when (x < y) else 
                 "0000000000000000" when (x >= y) else 
                 "0000000000000000";
end architecture a_menor;