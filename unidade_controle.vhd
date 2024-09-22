library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity unidade_controle is
    port(
        clk                                          : in std_logic;
        uc_en                                        : in std_logic;
        instr_entrada                                : in unsigned(15 downto 0);
        
        op_mux_ula, op_mux_pc                        : out std_logic;
        op_ula                                       : out unsigned(1 downto 0);
        
        wr_en_pc, wr_en_banco_reg, wr_en_reg         : out std_logic;
        reg_entrada_1, reg_entrada_2, reg_entrada_wr : out unsigned(2 downto 0)
    );
end entity unidade_controle;

architecture a_unidade_controle of unidade_controle is
    component maq_estado_2bits is
        port
        (
            clk   : in std_logic ;
            rst   : in std_logic ;
            estado : out unsigned (1 downto 0)
        );
    end component;
    
    signal opcode             : unsigned(3 downto 0);
    signal const              : unsigned(11 downto 0);
    signal reg_wr,reg_1,reg_2 : unsigned(2 downto 0);
    
    signal reset_processador  : std_logic;
    signal estado_processador : unsigned(1 downto 0);
    
    signal r1_en, r2_en       : std_logic;
    
begin
    estado_proc: maq_estado_2bits
    port map
    (
        clk   => clk,
        rst   => reset_processador,
        estado => estado_processador
    );
    
    -- Estado processador ---
    -- 00 : fetch
    -- 01 : decode
    -- 10 : execute/reset
    
    --- Opcodes ---
    -- 0000 : nop
    -- 0001 : salto
    -- 0010 : soma
    -- 0011 : subtração
    -- 0100 : menor
    -- 0101 : igual
    -- 0110 : carregar
    -- 0111 : copiar
    
    --- Controle de estado do processador ---
    reset_processador <= '1' when estado_processador = "10" or uc_en = '0' else '0';
    
    --- Mapeamento da instrução ---
    opcode <= instr_entrada(15 downto 12);  -- Opcode da instrução
    reg_wr <= instr_entrada(10 downto 8);   -- Registrador de escrita
    reg_1  <= instr_entrada(6 downto 4);    -- Primeiro registrador de leitura
    reg_2  <= instr_entrada(2 downto 0);    -- Segundo registrador de leitura

    --- Controle de Enables ---
    wr_en_pc  <= '1' when estado_processador="01" else '0'; -- Estado de decode
    wr_en_reg <= '1' when estado_processador="00" else '0'; -- Estado de fetch
    wr_en_banco_reg <= '1' when estado_processador="01" and not (opcode="0000" or opcode="0001") else '0'; -- Todas instruções exceto nop e jump
    
    --- Controle de Mux ---
    op_mux_ula <= '1' when opcode="0110" else '0'; -- Passa constante para ULA
    op_mux_pc  <= '1' when opcode="0001" else '0'; -- Habilita endereço de pulo
    
    --- Controle de operação da ULA ---
    op_ula <= "00" when opcode="0010" -- Soma
         else "01" when opcode="0011" -- Subtração
         else "10" when opcode="0100" -- Igual
         else "11" when opcode="0101" -- Menor
         else "00";               
    
    --- Mapeamento de registradores ---
    r1_en <= '1' when (opcode="0010" or opcode="0011" or opcode="0100" or opcode="0101" or opcode="0111") else '0';
    r2_en <= '1' when (opcode="0010" or opcode="0011" or opcode="0100" or opcode="0101") else '0';
    
    --- Controle de endereçamento de registradores ---
    reg_entrada_1 <= reg_1 when r1_en = '1' else "000";
    reg_entrada_2 <= reg_2 when r2_en = '1' else "000";
    reg_entrada_wr <= reg_wr;

end architecture a_unidade_controle;