library IEEE;
use IEEE.std_logic_1164.all;

entity mux_8 is
    port(
        op0, op1, op2 : in std_logic;
        instr2, instr4, instr6 : in std_logic;
        instr_out : out std_logic
    );
end entity;

architecture a_mux_8 of mux_8 is
    signal instr0, instr1, instr5 : std_logic := '0';
    signal instr3, instr7 : std_logic := '1';
begin
    instr_out <= instr0 when op2 = '0' and op1 = '0' and op0 = '0' else
                 instr1 when op2 = '0' and op1 = '0' and op0 = '1' else
                 instr2 when op2 = '0' and op1 = '1' and op0 = '0' else
                 instr3 when op2 = '0' and op1 = '1' and op0 = '1' else
                 instr4 when op2 = '1' and op1 = '0' and op0 = '0' else
                 instr5 when op2 = '1' and op1 = '0' and op0 = '1' else
                 instr6 when op2 = '1' and op1 = '1' and op0 = '0' else
                 instr7 when op2 = '1' and op1 = '1' and op0 = '1' else
                 '0';
end architecture a_mux_8;


