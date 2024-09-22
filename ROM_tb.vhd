library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM_tb is
end entity ROM_tb;

architecture rtl of ROM_tb is
    component ROM is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (6 downto 0);
            dado     : OUT unsigned (16 downto 0)
        );
    end component;
    
    signal endereco:    unsigned(6 downto 0);
    signal dado:        unsigned(16 downto 0);
    constant period_time : time         := 100 ns;
    signal finished      : std_logic    := '0';
    signal clk, rst      : std_logic;
    
begin
    ut: ROM port map(clk => clk, endereco => endereco, dado => dado);
    
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
    
    process
    begin
        wait for 200 ns;
        endereco <= "0000000";   -- 0
        wait for 100 ns;
        endereco <= "0000001";   -- 1
        wait for 100 ns;
        endereco <= "0000010";   -- 2
        wait for 100 ns;
        endereco <= "0000011";   -- 3
        wait for 100 ns;
        endereco <= "0000100";   -- 4
        wait for 100 ns;
        endereco <= "0000101";   -- 5
        wait for 100 ns;
        endereco <= "0000110";   -- 6
        wait for 100 ns;
        endereco <= "0000111";   -- 7
        wait for 100 ns;
        endereco <= "0001000";   -- 8
        wait for 100 ns;
        endereco <= "0001001";   -- 9
        wait for 100 ns;
        endereco <= "0001010";   -- 10
        wait for 100 ns;
        endereco <= "1000010";   -- qualquer
        wait;
    end process;
end architecture rtl;