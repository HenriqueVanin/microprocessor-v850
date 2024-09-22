library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity maq_estado_2bits is
    port(
        clk       : in std_logic;
        rst       : in std_logic;
        dado_o    : out std_logic
    );
end entity maq_estado_2bits;

architecture a_maq_estado_2bits of maq_estado_2bits is
    signal  estado: std_logic;
begin
    process(clk, rst)   -- acionado se houver mudança em clk, rst ou wr_en
    begin
        if rst = '1' then
            estado <= '0';
        elsif rising_edge(clk) then
            estado <= not estado;
        end if;
    end process;

    dado_o <= estado;
end architecture a_maq_estado_2bits;