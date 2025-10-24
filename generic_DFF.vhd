----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2025 08:37:58
-- Design Name: 
-- Module Name: generic_DFF - Behavioral
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

entity generic_DFF is
  generic (N: integer := 8);
  Port (clk: in std_logic;
        rst:in std_logic;
        en: in std_logic;
        d: in std_logic_vector(N-1 downto 0);
        q: out std_logic_vector(N-1 downto 0)  );
end generic_DFF;

architecture Behavioral of generic_DFF is
    signal r: std_logic_vector(N-1 downto 0);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if rst='1' then
                r <= (others => '0');
            elsif en='1' then
                r <= d;
            end if;
        end if;
    end process;
q <= r;
end Behavioral;
