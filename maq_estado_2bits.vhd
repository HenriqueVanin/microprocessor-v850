library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity maq_estados_2bits is
    port(
        clk       : in std_logic;
        rst       : in std_logic;
        estado : out unsigned(1 downto 0)
    );
end entity maq_estados_2bits;


architecture a_maq_estados_2bits of maq_estados_2bits is
    signal estado_interno : unsigned(1 downto 0);
begin

    process(clk,rst)
    begin
        if rst='1' then
            estado_interno <= "00";
        elsif rising_edge(clk) then
            if estado_interno="11" then
                estado_interno <= "00";
            else
                estado_interno <= estado_interno+1;
            end if;
        end if;
    end process;
    
    estado <= estado_interno;
end architecture a_maq_estados_2bits;