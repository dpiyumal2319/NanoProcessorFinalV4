----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 06:34:52 PM
-- Design Name: 
-- Module Name: PCAdder - Behavioral
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

entity PCAdder is
    Port ( I1 : in STD_LOGIC_VECTOR (2 downto 0);
           I2 : in STD_LOGIC_VECTOR (2 downto 0);
           S : out STD_LOGIC_VECTOR (2 downto 0));
end PCAdder;

architecture Behavioral of PCAdder is
    component FA is
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               C_in : in STD_LOGIC;
               S : out STD_LOGIC;
               C_out : out STD_LOGIC);
    end component;

    signal C : STD_LOGIC_VECTOR(2 downto 0);
begin
    FA0 : FA port map (
        A => I1(0),
        B => I2(0),
        C_in => '0',
        S => S(0),
        C_out => C(0)
    );

    FA1 : FA port map (
        A => I1(1),
        B => I2(1),
        C_in => C(0),
        S => S(1),
        C_out => C(1)
    );

    FA2 : FA port map (
        A => I1(2),
        B => I2(2),
        C_in => C(1),
        S => S(2),
        C_out => C(2)
    );

end Behavioral;
