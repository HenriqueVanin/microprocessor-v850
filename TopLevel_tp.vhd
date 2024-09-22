library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_level_tb is
end entity top_level_tb;

architecture rtl of top_level_tb is
    component top_level is
        port
        (
            clk : in std_logic ;
            rst : in std_logic
        );
    end component;
    
    signal clk,rst : std_logic;
    
    constant periodo       : time         := 100 ns;
    signal finalizado      : std_logic    := '0';
begin

    uut: top_level
    port map
    (
        clk => clk,
        rst => rst
    );
    
    reset_global: process
    begin
        rst <= '1';
        wait for periodo*2;
        rst <= '0';
        wait;
    end process reset_global;
    
    t_simulacao_proc: process
    begin
        wait for 10000 ns;
        finalizado <= '1';
        wait;
    end process t_simulacao_proc;
    
    clk_proc: process
    begin
        while finalizado /= '1' loop
            clk <= '0';
            wait for periodo/2;
            clk <= '1';
            wait for periodo/2;
        end loop;
        wait;
    end process clk_proc;

end architecture rtl;