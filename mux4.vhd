library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity seletor is
    port(
        slt : in std_logic;
        data0,data1,data2,data3,data4,data5,data6,data : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
    );
end entity seletor;

architecture a_seletor of seletor is
begin
    instr_saida <= instr0 when op1 = '0' and op0 = '0' else
    instr1 when op1 = '0' and op0 = '1' else
    instr2 when op1 = '1' and op0 = '0' else
    instr3 when op1 = '1' and op0 = '1' else
                   "000";
end architecture a_mux_4;