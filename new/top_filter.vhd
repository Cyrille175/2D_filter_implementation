----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2025 09:24:06
-- Design Name: 
-- Module Name: top_filter - Behavioral
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

entity top_filter is
generic(
    largeur_pixel   : integer := 8;    
    largeur_image      : integer := 128;   
    largeur_coef  : integer := 8  
  );
 --Port ( clk, rst : in std_logic;
       -- start: in  );
end top_filter;

architecture Behavioral of top_filter is

begin


end Behavioral;
