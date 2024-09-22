library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PC_tb is
end entity PC_tb;

architecture rtl of PC_tb is
    component PC is
        port
        (
            clk      : IN STD_LOGIC ;
            rst      : IN STD_LOGIC ;
            wr_en    : IN STD_LOGIC ;
            data_in  : OUT unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    constant period_time        : time         := 100 ns;
    signal finished             : std_logic    := '0';
    signal clk, rst, wr_en      : std_logic;
    signal data_in, data_out    : unsigned(15 downto 0);
    
begin
    ut: PC
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en,
        data_in  => data_in,
        data_out => data_out
    );
    
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
        wr_en <= '1';
        data_in <= "0000000000000000";
        wait for 100 ns;
        data_in <= "0000000000000001";
        wait for 100 ns;
        data_in <= "0000000000001001";
        wait for 100 ns;
        wait;
    end process;
    
end architecture rtl;