----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 02:00:03 AM
-- Design Name: 
-- Module Name: LUT_16_7_sign - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LUT_Sign is
    Port ( Address : in STD_LOGIC;
           LightOut : out STD_LOGIC_VECTOR (6 downto 0));
end LUT_Sign;

architecture Behavioral of LUT_Sign is
begin
    process(address) 
    begin
        if address = '0' then
            LightOut <= "1111111";
        else
            LightOut <= "0111111";
        end if;
    end process;
end Behavioral;
