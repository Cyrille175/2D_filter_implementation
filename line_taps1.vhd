----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2025 16:19:49
-- Design Name: 
-- Module Name: line_taps - Behavioral
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

entity line_taps1 is
    Port ( clk : in STD_LOGIC;
           rst: in std_logic;
           en: in std_logic;
           din: in std_logic_vector(7 downto 0);          
           dout1, dout2, dout3 : out STD_LOGIC_VECTOR (7 downto 0));
end line_taps1;

architecture Behavioral of line_taps1 is

component generic_DFF is
  generic (N: integer := 8);
  Port (clk: in std_logic;
        rst:in std_logic;
        en: in std_logic;
        d: in std_logic_vector(N-1 downto 0);
        q: out std_logic_vector(N-1 downto 0)  );
end component;

signal dout1r , dout2r, dout3r: std_logic_vector(7 downto 0);

begin

dff1: generic_dff 
generic map( N => 8)
port map (clk => clk,
          rst => rst,
          en => en ,
          d => din,
          q => dout3r);

dff2: generic_dff 
generic map( N => 8)
port map (clk => clk,
          rst => rst,
          en => en ,
          d => dout3r,
          q => dout2r);
          
dff3: generic_dff 
generic map( N => 8)
port map (clk => clk,
          rst => rst,
          en => en ,
          d => dout2r,
          q => dout1r);
          

    dout1 <= dout1r;
    dout2 <= dout2r;
    dout3 <= dout3r;

          


end Behavioral;
