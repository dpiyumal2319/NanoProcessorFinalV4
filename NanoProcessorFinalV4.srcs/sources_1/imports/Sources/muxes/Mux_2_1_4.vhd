----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 10:51:57 PM
-- Design Name: 
-- Module Name: Mux_2_1_4 - Behavioral
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

entity Mux_2_1_4 is
    Port ( IN_0 : in STD_LOGIC_VECTOR (3 downto 0);
           IN_1 : in STD_LOGIC_VECTOR (3 downto 0);
           SEL : in STD_LOGIC;
           O : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_2_1_4;

architecture Behavioral of Mux_2_1_4 is

begin
    O <= IN_0 when SEL = '0' else IN_1;


end Behavioral;
