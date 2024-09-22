library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity banco_reg is
    port(
        re_reg1, re_reg2, wr_reg: in unsigned(2 downto 0);
        wr_value: in unsigned(15 downto 0);
        wr_en: in std_logic;
        clk, rst : in std_logic;
        re_dado1, re_dado2 : out unsigned(15 downto 0)
    );
end entity;
architecture a_banco_reg of banco_reg is
    component reg16bits is
        port( clk : in std_logic;
            rst, wr_en : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    signal wr_en1,wr_en2,wr_en3,wr_en4,wr_en5,wr_en6,wr_en7 : std_logic := '0';
    signal out0,out1,out2,out3,out4,out5,out6,out7 : unsigned(15 downto 0) := "0000000000000000";
    
begin
    reg0: reg16bits port map(clk=>clk,rst=>rst,wr_en=>'0',data_in=>wr_value,data_out=>out0);
    reg1: reg16bits port map(clk=>clk,rst=>rst,wr_en=>wr_en1,data_in=>wr_value,data_out=>out1);
    reg2: reg16bits port map(clk=>clk,rst=>rst,wr_en=>wr_en2,data_in=>wr_value,data_out=>out2);
    reg3: reg16bits port map(clk=>clk,rst=>rst,wr_en=>wr_en3,data_in=>wr_value,data_out=>out3);
    reg4: reg16bits port map(clk=>clk,rst=>rst,wr_en=>wr_en4,data_in=>wr_value,data_out=>out4);
    reg5: reg16bits port map(clk=>clk,rst=>rst,wr_en=>wr_en5,data_in=>wr_value,data_out=>out5);
    reg6: reg16bits port map(clk=>clk,rst=>rst,wr_en=>wr_en6,data_in=>wr_value,data_out=>out6);
    reg7: reg16bits port map(clk=>clk,rst=>rst,wr_en=>wr_en7,data_in=>wr_value,data_out=>out7);
    
    re_dado1 <= out0 when re_reg1 = "000" else
    out1 when re_reg1 = "001" else
    out2 when re_reg1 = "010" else
    out3 when re_reg1 = "011" else
    out4 when re_reg1 = "100" else
    out5 when re_reg1 = "101" else
    out6 when re_reg1 = "110" else
    out7 when re_reg1 = "111" else
    out0;
    
    re_dado2 <= out0 when re_reg2 = "000" else
    out1 when re_reg2 = "001" else
    out2 when re_reg2 = "010" else
    out3 when re_reg2 = "011" else
    out4 when re_reg2 = "100" else
    out5 when re_reg2 = "101" else
    out6 when re_reg2 = "110" else
    out7 when re_reg2 = "111" else
    out0;
    
    wr_en1 <= wr_en when wr_reg = "001" else
    '0';
    wr_en2 <= wr_en when wr_reg = "010" else
    '0';
    wr_en3 <= wr_en when wr_reg = "011" else
    '0';
    wr_en4 <= wr_en when wr_reg = "100" else
    '0';
    wr_en5 <= wr_en when wr_reg = "101" else
    '0';
    wr_en6 <= wr_en when wr_reg = "110" else
    '0';
    wr_en7 <= wr_en when wr_reg = "111" else
    '0';
    
end architecture;