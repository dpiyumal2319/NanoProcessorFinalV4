----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 02:00:03 AM
-- Design Name: 
-- Module Name: LUT_Digit - Behavioral
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
USE IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY LUT_Digit IS
    PORT (
        Address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        LightOut : OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
END LUT_Digit;

ARCHITECTURE Behavioral OF LUT_Digit IS
    TYPE ROM_TYPE IS ARRAY (0 TO 15) OF STD_LOGIC_VECTOR(6 DOWNTO 0);
    CONSTANT sevenSegment_ROM : ROM_TYPE := (
        "1000000", -- 0
        "1111001", -- 1
        "0100100", -- 2
        "0110000", -- 3
        "0011001", -- 4
        "0010010", -- 5
        "0000010", -- 6
        "1111000", -- 7
        "0000000", -- 8
        "1111000", -- 7
        "0000010", -- 6
        "0010010", -- 5
        "0011001", -- 4
        "0110000", -- 3
        "0100100", -- 2
        "1111001" -- 1
    );
BEGIN
    LightOut <= sevenSegment_ROM(to_integer(unsigned(Address)));
END Behavioral;