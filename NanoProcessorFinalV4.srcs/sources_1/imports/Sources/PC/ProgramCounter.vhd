----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 06:48:07 PM
-- Design Name: 
-- Module Name: ProgramCounter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramCounter is
    Port ( AddressIn : in STD_LOGIC_VECTOR (2 downto 0);
           AddressOut : out STD_LOGIC_VECTOR (2 downto 0) := "000";
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC);
end ProgramCounter;

architecture Behavioral of ProgramCounter is

begin
    process(Clk, Reset)
    begin
        if Reset = '1' then
            AddressOut <= "000";
        elsif rising_edge(Clk) then
            AddressOut <= AddressIn;
        end if;
    end process;
end Behavioral;
