library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity reg16bits_tb is
end entity reg16bits_tb;

architecture a_reg16bits_tb of reg16bits_tb is
    component reg16bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (15 downto 0);
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    constant period_time            : time         := 100 ns;
    signal   finished               : std_logic    := '0';
    signal   clk, reset, wr_en      : std_logic;
    signal   data_in, data_out      : unsigned(15 downto 0);
begin

    uut: reg16bits port map (clk => clk, rst => reset, wr_en => wr_en, data_in => data_in, data_out => data_out);

    reset_global: process
    begin
        reset <= '1';
        wait for period_time*2;
        reset <= '0';
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
        wr_en <= '0';
        data_in <= "1111111111111111";
        wait for 100 ns;
        wr_en <= '1';
        data_in <= "1111111110001101";
        wait;
    end process;
    
end architecture;