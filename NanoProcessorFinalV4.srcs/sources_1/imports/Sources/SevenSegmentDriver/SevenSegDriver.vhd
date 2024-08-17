----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2024 04:14:18 PM
-- Design Name: 
-- Module Name: SevenSegDriver - Behavioral
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

ENTITY SevenSegDriver IS
    PORT (
        Clk : IN STD_LOGIC;
        Data : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        Reset : IN STD_LOGIC;
        Address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        Anode : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END SevenSegDriver;

ARCHITECTURE Behavioral OF SevenSegDriver IS

    COMPONENT LUT_Digit IS
        PORT (
            Address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
            LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));

    END COMPONENT;

    COMPONENT LUT_Sign IS
        PORT (
            Address : IN STD_LOGIC;
            LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;

    COMPONENT LUT_Address IS
        PORT (
            Address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
            LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
    END COMPONENT;

    SIGNAL digit_counter : INTEGER := 0;
    SIGNAL anode_data : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
    SIGNAL num_0_data : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL num_1_data : STD_LOGIC_VECTOR(6 DOWNTO 0);
    SIGNAL num_3_data : STD_LOGIC_VECTOR(6 DOWNTO 0);
    signal slow_clk : std_logic := '0';
    signal clk_count : integer := 1;

BEGIN

    Anode <= anode_data;
    LUT0 : LUT_Digit PORT MAP(
        Address => Data,
        LightOut => num_0_data);

    LUT1 : LUT_Sign PORT MAP(
        Address => Data(3),
        LightOut => num_1_data);

    LUT2 : LUT_Address PORT MAP(
        Address => Address,
        LightOut => num_3_data);

    PROCESS (slow_clk, Reset)
    BEGIN
        IF Reset = '1' THEN
            digit_counter <= 0;
            anode_data <= "0000";
            LightOut <= "0000000";
        ELSIF rising_edge(slow_clk) THEN
            digit_counter <= (digit_counter + 1) MOD 3;
            IF digit_counter = 0 THEN
                anode_data <= "1110";
                LightOut <= num_0_data;
            ELSIF digit_counter = 1 THEN
                anode_data <= "1101";
                LightOut <= num_1_data;
            ELSE
                anode_data <= "0111";
                LightOut <= num_3_data;
            END IF;
        END IF;
    END PROCESS;

    --Clock_Slowing Process
    PROCESS (Clk) BEGIN
        IF (rising_edge(Clk)) THEN
            clk_count <= clk_count + 1;
--             IF (clk_count = 250000) THEN -- For Board
            IF (clk_count = 2) THEN -- For simulation
                slow_clk <= NOT slow_clk;
                clk_count <= 1;
            END IF;
        END IF;
    END PROCESS;


END Behavioral;