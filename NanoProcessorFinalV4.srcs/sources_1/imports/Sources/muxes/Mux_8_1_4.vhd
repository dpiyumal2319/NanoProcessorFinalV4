----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/20/2024 11:45:19 PM
-- Design Name: 
-- Module Name: Mux_8_1_4 - Behavioral
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

entity Mux_8_1_4 is
    Port ( RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           Reg_0 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_1 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_2 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_3 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_4 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_5 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_6 : in STD_LOGIC_VECTOR (3 downto 0);
           Reg_7 : in STD_LOGIC_VECTOR (3 downto 0);
           O : out STD_LOGIC_VECTOR (3 downto 0));
end Mux_8_1_4;

architecture Behavioral of Mux_8_1_4 is

begin
    process(RegSel, Reg_0, Reg_1, Reg_2, Reg_3, Reg_4, Reg_5, Reg_6, Reg_7)
    begin
        case RegSel is
            when "000" =>
                O <= Reg_0;
            when "001" =>
                O <= Reg_1;
            when "010" =>
                O <= Reg_2;
            when "011" =>
                O <= Reg_3;
            when "100" =>
                O <= Reg_4;
            when "101" =>
                O <= Reg_5;
            when "110" =>
                O <= Reg_6;
            when "111" =>
                O <= Reg_7;
            when others =>
                O <= "ZZZZ"; --Set output to high impedance for undefined cases
        end case;
    end process;

end Behavioral;
