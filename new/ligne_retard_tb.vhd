----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2025 09:53:18
-- Design Name: 
-- Module Name: ligne_retard_tb - tb
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ligne_retard_tb is
end entity;

architecture tb of ligne_retard_tb is

component ligne_retard is
  generic (
    N : integer := 8 
  );
  port (
    clk  : in  std_logic;                     
    rst  : in  std_logic;                     
    en   : in  std_logic;                    
    din  : in  std_logic_vector(N-1 downto 0);
    dout1 : out std_logic_vector(N-1 downto 0);
    dout2 : out std_logic_vector(N-1 downto 0);
    dout3 : out std_logic_vector(N-1 downto 0)
  );
end component;

  constant N : integer := 8;

  signal clk        : std_logic := '0';
  signal rst        : std_logic := '1';
  signal en         : std_logic := '0';
  signal din        : std_logic_vector(N-1 downto 0) := (others => '0');
  signal dout1, dout2, dout3 : std_logic_vector(N-1 downto 0);

begin

  clk <= not clk after 5 ns;

  uut: ligne_retard
    generic map (N => N)
    port map (
      clk  => clk,
      rst  => rst,
      en   => en,
      din  => din,
      dout1 => dout1,
      dout2 => dout2,
      dout3 => dout3
    );

  stim: process
  begin
    rst <= '1'; 
    en <= '0'; 
    din <= (others => '0');
    wait for 40 ns;

    rst <= '0'; en <= '1';

    wait until rising_edge(clk); din <= x"01";
    wait until rising_edge(clk); din <= x"02";
    wait until rising_edge(clk); din <= x"03";
    wait until rising_edge(clk); din <= x"04";
    wait until rising_edge(clk); din <= x"05";
    wait until rising_edge(clk); din <= x"06";

    wait for 100 ns;
    wait; 
  end process;

end architecture;
