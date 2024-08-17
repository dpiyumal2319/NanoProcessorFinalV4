----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/22/2024 02:35:19 AM
-- Design Name: 
-- Module Name: TB_RISC - Behavioral
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

ENTITY TB_PROCESSOR IS
    --  Port ( );
END TB_PROCESSOR;

ARCHITECTURE Behavioral OF TB_PROCESSOR IS
    COMPONENT PROCESSOR IS
        PORT (
                Clk : IN STD_LOGIC;
                Reset : IN STD_LOGIC;
                Overflow : OUT STD_LOGIC;
                Zero : OUT STD_LOGIC;
                Carry : OUT STD_LOGIC;
                LED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                SumLED : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
                LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
                );

    END COMPONENT;

    SIGNAL Clk : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '0';
    SIGNAL Overflow : STD_LOGIC;
    SIGNAL Zero : STD_LOGIC;
    SIGNAL Carry : STD_LOGIC;
    SIGNAL LED : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL Anode : STD_LOGIC_VECTOR (3 DOWNTO 0);
    SIGNAL LightOut : STD_LOGIC_VECTOR (6 DOWNTO 0);
    SIGNAL SumLED : STD_LOGIC_VECTOR (3 DOWNTO 0);
    


BEGIN
    UUT : PROCESSOR PORT MAP(
        Clk => Clk,
        Reset => Reset,
        Overflow => Overflow,
        Zero => Zero,
        Carry => Carry,
        LED => LED,
        Anode => Anode,
        SumLED => SumLED,
        LightOut => LightOut);

    --Clock Process 1000Hz
    Clk_Process : PROCESS
    BEGIN
        WAIT FOR 5 ns;
        Clk <= NOT Clk;
    END PROCESS;

    --Reset Process
    Reset_Process : PROCESS
    BEGIN
        Reset <= '1';
        WAIT FOR 50 ns;
        Reset <= '0';
        WAIT;
    END PROCESS;
END Behavioral;