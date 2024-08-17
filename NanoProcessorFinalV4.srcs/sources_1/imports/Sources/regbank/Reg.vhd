----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2024 01:28:36 PM
-- Design Name: 
-- Module Name: Reg - Behavioral
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

ENTITY Reg IS
    PORT (
        D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
        En : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        Clk : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0) := "0000"
    );
END Reg;

ARCHITECTURE Behavioral OF Reg IS

BEGIN

    PROCESS (Clk, Reset) BEGIN
        IF Reset = '1' THEN
            Q <= "0000";
        ELSE
            IF (rising_edge(Clk)) THEN
                IF En = '1' THEN
                    Q <= D;
                END IF;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;