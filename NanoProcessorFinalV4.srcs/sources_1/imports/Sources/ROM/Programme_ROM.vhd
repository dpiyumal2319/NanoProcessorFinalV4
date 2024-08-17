----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 06:10:59 PM
-- Design Name: 
-- Module Name: Programme_ROM - Behavioral
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

ENTITY Programme_ROM IS
    PORT (
        PC_out : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        ROM_out : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END Programme_ROM;

ARCHITECTURE Behavioral OF Programme_ROM IS
    TYPE rom_type IS ARRAY (0 TO 7) OF STD_LOGIC_VECTOR(11 DOWNTO 0);
    SIGNAL nanoprocessor_ROM : rom_type := (
        -- MOVI A, D 10 AAA 000 DDDD
        -- ADD A, B 00 AAA BBB 0000
        -- NEG A 01 AAA 0000000
        -- JZR A, P 11 AAA 0000 PPP

        -- --Simple Add 1 + 2 + 3
        -- "101110000001", -- MOV R7, 1   << 0
        -- "100100001000", -- MOV R2, 2   << 1
        -- "001110100000", -- ADD R7, R2  << 2
        -- "100110000011", -- MOV R3, 3   << 3
        -- "001110110000", -- ADD R7, R3  << 4
        -- "010110000000", -- NEG R3      << 5
        -- "101010000000", -- MOV R5, 0   << 6
        -- "111010000000" -- JZR R5, 0    << 7

         -- Add 1 + 2 + 3 By loop
         "100100000001", -- MOV R2, 1     << 0
         "010100000000", -- NEG R2        << 1
         "100010000011", -- MOV R1, 3     << 2
         "001110010000", -- ADD R7, R1    << 3 
         "000010100000", -- ADD R1, R2    << 4
         "110010000111", -- JZR R1, 7     << 5
         "110000000011", -- JZR R0, 3     << 6
         "110000000111" -- JZR R0, 7      << 7

        -- --Count from -8 to 7
        --"100010000001", -- MOV R1, 1    << 0
        --"101110001000", -- MOV R7, -8   << 1
        --"001110010000", -- ADD R7, R1   << 2
        --"110000000010", -- JZR R0, 2    << 3
        -- --Some NOPs
        --"100000000000", -- MOV R0, 0    << 4
        --"100000000000", -- MOV R0, 0    << 5
        --"100000000000", -- MOV R0, 0    << 6
        --"100000000000" -- MOV R0, 0     << 7
    );
BEGIN
    ROM_out <= nanoprocessor_ROM(to_integer(unsigned(PC_out)));
END Behavioral;