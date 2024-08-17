----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2024 11:50:32 PM
-- Design Name: 
-- Module Name: RISC - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY PROCESSOR IS
    PORT (
        Clk : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Overflow : OUT STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Carry : OUT STD_LOGIC;
        LED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        SumLED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
    );
END PROCESSOR;

ARCHITECTURE Behavioral OF PROCESSOR IS

    COMPONENT ProgramCounter IS
        PORT (
            AddressIn : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            AddressOut : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            Clk : IN STD_LOGIC;
            Reset : IN STD_LOGIC);
    END COMPONENT;

    COMPONENT Programme_ROM IS
        PORT (
            PC_out : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            ROM_out : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
    END COMPONENT;

    COMPONENT Mux_2_1_3 IS
        PORT (
            IN_0 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            IN_1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            SEL : IN STD_LOGIC;
            O : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    COMPONENT Mux_8_1_4 IS
        PORT (
            RegSel : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            Reg_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_3 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_4 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_5 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_6 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Reg_7 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT Mux_2_1_4 IS
        PORT (
            IN_0 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            IN_1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            SEL : IN STD_LOGIC;
            O : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    COMPONENT PCAdder IS
        PORT (
            I1 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            I2 : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            S : OUT STD_LOGIC_VECTOR (2 DOWNTO 0));
    END COMPONENT;

    COMPONENT AddSubUnit IS
        PORT (
            R1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            R2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            SubSel : IN STD_LOGIC;
            S : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            OverFlow : OUT STD_LOGIC;
            Zero : OUT STD_LOGIC;
            Carry : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT RegBankv2 IS
        PORT (
            reg_en : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            clk : IN STD_LOGIC;
            reset_bank : IN STD_LOGIC;
            data_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            data_out_7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT InstructionDecoder IS
        PORT (
            Ins : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
            RegEn : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            LoadSel : OUT STD_LOGIC;
            ImVal : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            RegSel1 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            RegSel2 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            AddSubSel : OUT STD_LOGIC;
            RegChk : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            JumpFlg : OUT STD_LOGIC;
            JumpAdd : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Slow_Clk IS
        PORT (
            Clk_in : IN STD_LOGIC;
            Clk_out : OUT STD_LOGIC);
    END COMPONENT;

    COMPONENT SevenSegDriver IS
        PORT (
            Clk : IN STD_LOGIC;
            Data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            Address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
            Reset : IN STD_LOGIC;
            Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
    END COMPONENT;

    SIGNAL clk_sgl, jump_flag_sgl, load_sel_sgl, add_sub_sel_sgl : STD_LOGIC;
    SIGNAL Ins_sgl : STD_LOGIC_VECTOR (11 DOWNTO 0);
    SIGNAL PC_adder_sgl, jump_adr_sgl, PC_out_sgl, PC_in_sgl, reg_en_sgl, reg_sel1_sgl, reg_sel2_sgl : STD_LOGIC_VECTOR (2 DOWNTO 0);
    SIGNAL im_val_sgl, reg_chk_sgl, Data_in_sgl, reg0_out_sgl, reg1_out_sgl, reg2_out_sgl, reg3_out_sgl, reg4_out_sgl, reg5_out_sgl, reg6_out_sgl, reg7_out_sgl, mux_8_1_4_two_out_sgl, mux_8_1_4_one_out_sgl, sum_out_sgl : STD_LOGIC_VECTOR (3 DOWNTO 0);
BEGIN

    Instruction_dec : InstructionDecoder PORT MAP(
        Ins => Ins_sgl,
        RegEn => reg_en_sgl,
        LoadSel => load_sel_sgl,
        ImVal => im_val_sgl,
        RegSel1 => reg_sel1_sgl,
        RegSel2 => reg_sel2_sgl,
        AddSubSel => add_sub_sel_sgl,
        RegChk => reg_chk_sgl,
        JumpFlg => jump_flag_sgl,
        JumpAdd => jump_adr_sgl
    );

    slow_clock : Slow_Clk PORT MAP(
        Clk_in => Clk,
        Clk_out => clk_sgl
    );

    pc : ProgramCounter PORT MAP(
        Clk => clk_sgl,
        Reset => Reset,
        AddressIn => PC_in_sgl,
        AddressOut => PC_out_sgl
    );

    PC_Adder : PCAdder PORT MAP(
        I1 => PC_out_sgl,
        I2 => "001",
        S => PC_adder_sgl
    );

    mux_2_to_3 : Mux_2_1_3 PORT MAP(
        IN_0 => PC_adder_sgl,
        IN_1 => jump_adr_sgl,
        SEL => jump_flag_sgl,
        O => PC_in_sgl
    );

    reg_bank : RegBankv2 PORT MAP(
        reg_en => reg_en_sgl,
        clk => clk_sgl,
        reset_bank => Reset,
        data_in => Data_in_sgl,
        data_out_0 => reg0_out_sgl,
        data_out_1 => reg1_out_sgl,
        data_out_2 => reg2_out_sgl,
        data_out_3 => reg3_out_sgl,
        data_out_4 => reg4_out_sgl,
        data_out_5 => reg5_out_sgl,
        data_out_6 => reg6_out_sgl,
        data_out_7 => reg7_out_sgl
    );

    programme_rom_0 : Programme_ROM PORT MAP(
        PC_out => PC_out_sgl,
        ROM_out => Ins_sgl
    );

    mux_8_to_4_one : Mux_8_1_4 PORT MAP(
        RegSel => reg_sel1_sgl,
        Reg_0 => reg0_out_sgl,
        Reg_1 => reg1_out_sgl,
        Reg_2 => reg2_out_sgl,
        Reg_3 => reg3_out_sgl,
        Reg_4 => reg4_out_sgl,
        Reg_5 => reg5_out_sgl,
        Reg_6 => reg6_out_sgl,
        Reg_7 => reg7_out_sgl,
        O => mux_8_1_4_one_out_sgl
    );

    mux_8_to_4_two : Mux_8_1_4 PORT MAP(
        RegSel => reg_sel2_sgl,
        Reg_0 => reg0_out_sgl,
        Reg_1 => reg1_out_sgl,
        Reg_2 => reg2_out_sgl,
        Reg_3 => reg3_out_sgl,
        Reg_4 => reg4_out_sgl,
        Reg_5 => reg5_out_sgl,
        Reg_6 => reg6_out_sgl,
        Reg_7 => reg7_out_sgl,
        O => mux_8_1_4_two_out_sgl
    );

    reg_chk_sgl <= mux_8_1_4_one_out_sgl;

    add_sub_unit : AddSubUnit PORT MAP(
        R1 => mux_8_1_4_one_out_sgl,
        R2 => mux_8_1_4_two_out_sgl,
        SubSel => add_sub_sel_sgl,
        S => sum_out_sgl,
        OverFlow => Overflow,
        Zero => Zero,
        Carry => Carry
    );

    SUMLED <= sum_out_sgl;

    mux_2_to_4 : Mux_2_1_4 PORT MAP(
        IN_0 => sum_out_sgl,
        IN_1 => im_val_sgl,
        SEL => load_sel_sgl,
        O => Data_in_sgl
    );

    seven_seg_driver : SevenSegDriver PORT MAP(
        Clk => Clk,
        Data => reg7_out_sgl,
        Address => PC_out_sgl,
        LightOut => LightOut,
        Reset => Reset,
        Anode => Anode
    );

    LED <= reg7_out_sgl;
END Behavioral;