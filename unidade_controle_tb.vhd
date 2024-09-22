library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity unidade_controle_tb is
end entity unidade_controle_tb;

architecture a_unidade_controle_tb of unidade_controle_tb is
    component unidade_controle is
        port
        (
            clk             : in std_logic ;
            uc_en           : in std_logic ;
            instr_entrada   : in unsigned (15 downto 0);
            op_mux_ula      : out std_logic ;
            op_mux_pc       : out std_logic ;
            op_ula          : out unsigned (1 downto 0);
            wr_en_pc        : out std_logic ;
            wr_en_banco_reg : out std_logic ;
            wr_en_reg       : out std_logic ;
            reg_entrada_1   : out unsigned (2 downto 0);
            reg_entrada_2   : out unsigned (2 downto 0);
            reg_entrada_wr  : out unsigned (2 downto 0)
        );
    end component;
    
    constant tempo_periodo : time         := 100 ns;
    
    signal finalizado      : std_logic    := '0';
    
    signal clk : std_logic;
    
    signal uc_en, wr_en_pc, wr_en_banco_reg, wr_en_reg : std_logic;
    
    signal op_mux_ula, op_mux_pc  : std_logic;
    signal instr_entrada: unsigned(15 downto 0);
    
    signal reg_entrada_1, reg_entrada_2, reg_entrada_wr : unsigned(2 downto 0);
    signal op_ula : unsigned(1 downto 0);
    
begin
    u_uc: unidade_controle
    port map
    (
        clk             => clk,
        uc_en           => uc_en,
        instr_entrada   => instr_entrada,
        op_mux_ula      => op_mux_ula,
        op_mux_pc       => op_mux_pc,
        op_ula          => op_ula,
        wr_en_pc        => wr_en_pc,
        wr_en_banco_reg => wr_en_banco_reg,
        wr_en_reg       => wr_en_reg,
        reg_entrada_1   => reg_entrada_1,
        reg_entrada_2   => reg_entrada_2,
        reg_entrada_wr  => reg_entrada_wr
    );
    
    t_simulacao_proc: process
    begin
        wait for 3800 ns;
        finalizado <= '1';
        wait;
    end process t_simulacao_proc;
    
    clk_proc: process
    begin
        while finalizado /= '1' loop
            clk <= '0';
            wait for tempo_periodo/2;
            clk <= '1';
            wait for tempo_periodo/2;
        end loop;
        wait;
    end process clk_proc;
    
    process
    begin
        uc_en <='0';
        wait for 300 ns;
        
        uc_en <='1';
        
        instr_entrada <= "0000000000000000";  -- NOP
        wait for 400 ns;
        
        instr_entrada <= "0001000001100101";  -- JUMP 0x65
        wait for 400 ns;
        
        instr_entrada <= "0010000100101000";  -- ADD $1,$2,$4
        wait for 400 ns;
        
        instr_entrada <= "00110011001000001"; -- SUB $3,$2,$1
        wait for 400 ns;
        
        instr_entrada <= "0100001000110001";  -- LESS THAN $2,$3,$1
        wait for 400 ns;
        
        instr_entrada <= "0101001010010000";  -- EQUAL TO $2,$5,$0
        wait for 400 ns;
        
        instr_entrada <= "0110000111001110";  -- LOAD $1,0xAA
        wait for 400 ns;
        
        instr_entrada <= "0111011001000000";  -- COPY $3,$4
        wait for 400 ns;

        wait;
    end process;
    

end architecture a_unidade_controle_tb;
