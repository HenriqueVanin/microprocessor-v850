library IEEE;
use IEEE.std_logic_1164.all;

entity mux_8_tb is
end;

architecture a_mux_8_tb of mux_8_tb is
    component mux_8 is
        port
        (
            op0    : IN std_logic ;
            op1    : IN std_logic ;
            op2    : IN std_logic ;
            instr2    : IN std_logic ;
            instr4    : IN std_logic ;
            instr6    : IN std_logic ;
            instr_out : OUT std_logic
        );
    end component;
    signal op0, op1, op2, instr2, instr4, instr6, instr_out : std_logic;
begin
    uut: mux_8 port map(op0 => op0, op1 => op1, op2 => op2, instr2 => instr2, instr4 => instr4, instr6 => instr6, instr_out => instr_out);
    process
    begin
        op0 <= '0';
        op1 <= '0';
        op2 <= '0';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        op0 <= '1';
        op1 <= '0';
        op2 <= '0';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        op0 <= '0';
        op1 <= '1';
        op2 <= '0';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        op0 <= '1';
        op1 <= '1';
        op2 <= '0';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        op0 <= '0';
        op1 <= '0';
        op2 <= '1';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        op0 <= '1';
        op1 <= '0';
        op2 <= '1';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        op0 <= '0';
        op1 <= '1';
        op2 <= '1';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        op0 <= '1';
        op1 <= '1';
        op2 <= '1';
        instr2 <= '0'; instr4 <= '0'; instr6 <= '0';
        wait for 50 ns;
        wait;
    end process;
end architecture;