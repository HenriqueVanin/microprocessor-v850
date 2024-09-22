library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_2 is
    port(
        op : in std_logic;
        reg0, reg1 : in unsigned(15 downto 0);
        reg_saida : out unsigned(15 downto 0)
    );
end entity mux_2;

architecture a_mux_2 of mux_2 is
begin
    reg_saida <= reg0 when op = '0' else
                 reg1 when op = '1' else
                 "0000000000000000";
end architecture a_mux_2;