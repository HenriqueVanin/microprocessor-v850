library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_level is
    port(
        clk, rst : IN std_logic
    );
end entity top_level;

architecture a_top_level of top_level is
    
    component Ula is
        port
        (
            dado1             : IN unsigned (15 downto 0);
            dado2             : IN unsigned (15 downto 0);
            seletor_op        : IN unsigned (1 downto 0);
            saida_dado        : OUT unsigned (15 downto 0)
        );
    end component;
    
    component banco_reg is
        port
        (
            re_reg1, re_reg2, wr_reg: in unsigned(2 downto 0);
            wr_value: in unsigned(15 downto 0);
            clk, rst : in std_logic;
            wr_en: in std_logic;
            re_dado1, re_dado2 : out unsigned(15 downto 0)
        );
    end component;
    
    component mux_2 is
        port
        (
            op        : IN std_logic ;
            reg0      : IN unsigned (15 downto 0) ;
            reg1      : IN unsigned (15 downto 0) ;
            reg_saida : OUT unsigned (15 downto 0)
        );
    end component;
    
    component PC is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : INOUT unsigned (15 downto 0) ;
            data_out : INOUT unsigned (15 downto 0)
        );
    end component;
    
    component ROM is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (6 downto 0) ;
            dado     : OUT unsigned (15 downto 0)
        );
    end component;
    
    component reg16bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_in  : IN unsigned (15 downto 0) ;
            data_out : OUT unsigned (15 downto 0)
        );
    end component;
    
    component unidade_controle is
        port
        (
            clk             : IN std_logic ;
            uc_en           : IN std_logic ;
            instr_entrada   : IN unsigned (15 downto 0) ;
            wr_en_pc        : OUT std_logic ;
            wr_en_banco_reg : OUT std_logic ;
            wr_en_reg       : OUT std_logic ;
            op_mux_ula      : OUT std_logic ;
            op_mux_pc       : OUT std_logic ;
            op_ula          : OUT unsigned (1 downto 0) ;
            reg_entrada_1   : OUT unsigned (2 downto 0) ;
            reg_entrada_2   : OUT unsigned (2 downto 0) ;
            reg_entrada_wr  : OUT unsigned (2 downto 0)
        );
    end component;
    
    -- ULA ---
    signal data_entrada_ula_mux                   : unsigned(15 downto 0);   -- Dado vindo do mux ligado à ULA
    signal saida_ula                              : unsigned(15 downto 0);   -- Saída da ULA
    signal op_mux_ula                             : std_logic;               -- Seletor do mux ligado à ULA
    signal seletor_op_ula                         : unsigned(1 downto 0);    -- Seletor de operações da ULA
    signal const                                  : unsigned(15 downto 0);   -- Constante a ser mandada para o mux ligado à ULA
    
    -- Banco de Registradores ---
    signal seletor_wr_reg                         : unsigned(2 downto 0);    -- Seletor do registrador a ser gravado o dado
    signal re_dado1, re_dado2                     : unsigned(15 downto 0);   -- Dados de leitura do banco de registradores
    signal re_reg1, re_reg2                       : unsigned(2 downto 0);    -- Registradores a serem lidos no banco de registradores
    
    --- PC ---
    signal data_in_pc, data_out_pc                : unsigned(15 downto 0);   -- Dados de entrada e saída do pc
    signal endereco                               : unsigned(6 downto 0);    -- Endereço da linha de execução
    signal op_mux_pc                              : std_logic;               -- Seletor do mux do pc para próximo endereço ou jump
    
    --- ROM ---
    signal instr_rom                              : unsigned(15 downto 0);   -- Instrução da saída da ROM
    signal instr_entrada                          : unsigned(15 downto 0);   -- Instrução da saída do registrador ligado à ROM
    
    --- Enables ---
    signal wr_en_uc, wr_en_banco_reg, wr_en_pc, wr_en_reg   : std_logic;               -- Enables dos componentes
    
    
    signal endereco_next, endereco_jump           : unsigned(15 downto 0);   -- Controle de endereco


begin
    u_pc: PC
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en_pc,
        data_in  => data_in_pc,
        data_out => data_out_pc
    );
    
    u_pc_mux: mux_2
    port map
    (
        op => op_mux_pc,
        reg0 => endereco_next,
        reg1 => endereco_jump,
        reg_saida => data_in_pc
    );
    
    -- Próximo endereço
    endereco_next <= data_out_pc + "0000000000000001";
    
    -- Jump
    endereco_jump <= '0' & instr_rom(14 downto 0);
    
    -- Armazena opcode da instrução de entrada
    endereco <= data_out_pc (6 downto 0);
    
    br: banco_reg
    port map
    (
        re_reg1 => re_reg1,
        re_reg2 => re_reg2,
        wr_reg => seletor_wr_reg,
        wr_en => wr_en_banco_reg,
        wr_value => saida_ula,
        re_dado1 => re_dado1,
        re_dado2 => re_dado2,
        clk => clk,
        rst => rst
    );
   
    uut: Ula
    port map
    (
        dado1 => re_dado1,
        dado2 => data_entrada_ula_mux,
        saida_dado => saida_ula,
        seletor_op => seletor_op_ula
    );
    
    -- Mux que controla a segunda entrada da ULA : 1 - Retorna registrador, 2 - Retorna Constante arbitrária
    const <= "00000000" & instr_entrada(7 downto 0);
    
    u_ula_mux : mux_2
    port map(
        op => op_mux_ula,
        reg0 => re_dado2,
        reg1 => const,
        reg_saida => data_entrada_ula_mux
    );

    u_rom: ROM
    port map
    (
        clk      => clk,
        endereco => endereco,
        dado     => instr_rom
    );
    
    -- Registrador para armazenar a instrução vinda da ROM
    u_ir: reg16bits
    port map
    (
        clk      => clk,
        rst      => rst,
        wr_en    => wr_en_reg,
        data_in  => instr_rom,
        data_out => instr_entrada
    );
    
    u_uc: unidade_controle
    port map
    (
        clk             => clk,
        uc_en           => wr_en_uc,
        instr_entrada   => instr_entrada,
        wr_en_pc        => wr_en_pc,
        wr_en_banco_reg => wr_en_banco_reg,
        wr_en_reg       => wr_en_reg,
        op_mux_ula      => op_mux_ula,
        op_mux_pc       => op_mux_pc,
        op_ula          => seletor_op_ula,
        reg_entrada_1   => re_reg1,
        reg_entrada_2   => re_reg2,
        reg_entrada_wr  => seletor_wr_reg
    );   
    
end architecture a_top_level;