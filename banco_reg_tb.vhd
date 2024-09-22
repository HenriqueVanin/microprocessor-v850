library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity banco_reg_tb is
end entity banco_reg_tb;

architecture a_banco_reg_tb of banco_reg_tb is
    component banco_reg is
        port
        (
            re_reg1  : IN unsigned (2 downto 0);
            re_reg2  : IN unsigned (2 downto 0);
            wr_reg   : IN unsigned (2 downto 0);
            wr_value : IN unsigned (15 downto 0);
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            re_dado1 : OUT unsigned (15 downto 0);
            re_dado2 : OUT unsigned (15 downto 0)
        );
    end component;
    
    signal re_reg1, re_reg2, wr_reg: unsigned(2 downto 0);
    signal wr_value: unsigned(15 downto 0);
    signal clk, rst : std_logic;
    signal re_dado1, re_dado2 :  unsigned(15 downto 0);
    
begin
    br: banco_reg port map(re_reg1 => re_reg1,
        re_reg2 => re_reg2,
        wr_reg => wr_reg,
        wr_value => wr_value,
        re_dado1 => re_dado1,
        re_dado2 => re_dado2,
        clk => clk,
        rst => rst
    );
    process
    begin
        rst <= '0';
        re_reg1 <= "001";
        re_reg2 <= "010";
        wr_reg <= "011";
        wr_value <= "0000000000000010";
        wait for 50 ns;
        re_reg1 <= "011";
        re_reg2 <= "011";
        wr_reg <= "011";
        wr_value <= "0000000000001010";
        wait for 50 ns;
        
        re_reg1 <= "001";
        re_reg2 <= "011";
        wr_reg <= "111";
        wr_value <= "0000000010000010";
        wait for 50 ns;
        re_reg1 <= "111";
        re_reg2 <= "100";
        wr_reg <= "000";
        wr_value <= "0000000000000010";
        wait for 50 ns;
        wait;
    end process;
end architecture;