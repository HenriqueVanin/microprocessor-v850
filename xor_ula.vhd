library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity xor_ula is
    port(
        x, y : in unsigned(15 downto 0);
        saida : out unsigned(15 downto 0)
    );
end entity xor_ula;

architecture a_xor_ula of xor_ula is
begin
    saida <= x xor y;
end architecture;