library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity StateMachine_tb is
end entity StateMachine_tb;

architecture rtl of StateMachine_tb is
    component StateMachine is
        port
        (
            clk    : IN std_logic ;
            rst    : IN std_logic ;
            dado_o : OUT std_logic
        );
    end component;
    
    constant period_time : time         := 100 ns;
    signal finished      : std_logic    := '0';
    signal clk, rst, dado_o      : std_logic;
begin
    
    ut: StateMachine port map(clk => clk, rst => rst, dado_o => dado_o);
    
    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc : process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;
    
    clk_proc : process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
    

end architecture rtl;