library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is
    port(
        clk         : in std_logic;
        endereco    : in unsigned(6 downto 0);
        dado        : out unsigned(15 downto 0)
    );
end entity ROM;

architecture a_ROM of ROM is
    type mem is array (0 to 255) of unsigned(15 downto 0);
    constant conteudo_rom : mem := (
        
        -- 0000 : nop
        -- 0001 : jump cte
        -- 0010 : add $a,$b,$c
        -- 0011 : sub $a,$b,$c
        -- 0100 : < $a,$b,$c
        -- 0101 : == $a,$b,$c
        -- 0110 : load $a,cte
        -- 0111 : copy $a,$b
        
        0  => B"0110_0011_0000_0101",  -- carrega reg3 com 5
        1  => B"0110_0100_0000_1000",  -- carrega reg4 com 8
        2  => B"0010_0101_0011_0100",  -- soma reg4 com reg3
        3  => B"0110_0001_0000_0001",  -- armazena em r5
        4  => B"0011_0101_0101_0001",  -- subtrai 1 de r5
        5  => B"0001_0000_0001_0100",  -- salta para endereço 20
        20 => B"0111_0011_0101_0000",  -- copia r5 para r3
        21 => B"0001_0000_0000_0010",  -- salta para a terceira instrucao da lista (2)
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
        dado <= conteudo_rom(to_integer(endereco));
    end if;
end process;
end architecture a_ROM;