library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux_4 is
    port(
        seletor_op : in unsigned(1 downto 0);
        instr0, instr1, instr2, instr3 : in unsigned(15 downto 0);
        instr_saida : out unsigned(15 downto 0)
    );
end entity mux_4;

architecture a_mux_4 of mux_4 is
begin
    instr_saida <= instr0 when seletor_op = "00" else
    instr1 when seletor_op = "01" else
    instr2 when seletor_op = "10" else
    instr3 when seletor_op = "11" else
                   "0000000000000000";
end architecture a_mux_4;