----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 06:21:31 PM
-- Design Name: 
-- Module Name: AddSubUnit - Behavioral
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

ENTITY AddSubUnit IS
    PORT (
        R1 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        R2 : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        SubSel : IN STD_LOGIC;
        S : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
        OverFlow : OUT STD_LOGIC;
        Zero : OUT STD_LOGIC;
        Carry : OUT STD_LOGIC);
END AddSubUnit;

ARCHITECTURE Behavioral OF AddSubUnit IS

    COMPONENT RCA_4
        PORT (
            A : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            B : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            C_in : IN STD_LOGIC;
            S : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
            C_out : OUT STD_LOGIC;
            Overflow : OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL R2_2sComp : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL overflow_sgl, carry_sgl : STD_LOGIC;

BEGIN

    R2_2sComp(0) <= R2(0) XOR SubSel;
    R2_2sComp(1) <= R2(1) XOR SubSel;
    R2_2sComp(2) <= R2(2) XOR SubSel;
    R2_2sComp(3) <= R2(3) XOR SubSel;

    RCA_4_0 : RCA_4
    PORT MAP(
        A => R1,
        B => R2_2sComp,
        C_in => SubSel,
        S => S,
        C_out => carry_sgl,
        Overflow => overflow_sgl
    );

    Zero <= NOT (S(0) OR S(1) OR S(2) OR S(3)) AND (overflow_sgl NAND carry_sgl);

    OverFlow <= overflow_sgl;
    Carry <= carry_sgl;
END Behavioral;