----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2024 06:23:33 PM
-- Design Name: 
-- Module Name: RegBankv2 - Behavioral
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

ENTITY RegBankv2 IS
  PORT (
    reg_en : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    clk : IN STD_LOGIC;
    reset_bank : IN STD_LOGIC;
    data_in : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_0 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_3 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_4 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_5 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_6 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    data_out_7 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0)
  );

END RegBankv2;

ARCHITECTURE Behavioral OF RegBankv2 IS

  COMPONENT Decoder_3_to_8 IS
    PORT (
      I : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      En : IN STD_LOGIC;
      Y : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
    );
  END COMPONENT Decoder_3_to_8;

  COMPONENT Reg IS
    PORT (
      D : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      En : IN STD_LOGIC;
      Reset : IN STD_LOGIC;
      Clk : IN STD_LOGIC;
      Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT Reg;

  SIGNAL En_Y : STD_LOGIC_VECTOR (7 DOWNTO 0);

BEGIN


  Decoder3_8 : Decoder_3_to_8
  PORT MAP(
    EN => '1',
    I => reg_en,
    Y => En_Y);

  Reg_0 : Reg
  PORT MAP(
    En => En_Y(0),
    Reset => reset_bank,
    D => "0000",
    Clk => clk,
    Q => data_out_0);

  Reg_1 : Reg
  PORT MAP(
    En => En_Y(1),
    Reset => reset_bank,
    D => data_in,
    Clk => clk,
    Q => data_out_1);

  Reg_2 : Reg
  PORT MAP(
    En => En_Y(2),
    Reset => reset_bank,
    D => data_in,
    Clk => clk,
    Q => data_out_2);

  Reg_3 : Reg
  PORT MAP(
    En => En_Y(3),
    Reset => reset_bank,
    D => data_in,
    Clk => clk,
    Q => data_out_3);

  Reg_4 : Reg
  PORT MAP(
    En => En_Y(4),
    Reset => reset_bank,
    D => data_in,
    Clk => clk,
    Q => data_out_4);

  Reg_5 : Reg
  PORT MAP(
    En => En_Y(5),
    Reset => reset_bank,
    D => data_in,
    Clk => clk,
    Q => data_out_5);

  Reg_6 : Reg
  PORT MAP(
    En => En_Y(6),
    Reset => reset_bank,
    D => data_in,
    Clk => clk,
    Q => data_out_6);

  Reg_7 : Reg
  PORT MAP(
    En => En_Y(7),
    Reset => reset_bank,
    D => data_in,
    Clk => clk,
    Q => data_out_7);
END Behavioral;