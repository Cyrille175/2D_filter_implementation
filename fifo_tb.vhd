----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.10.2025 09:15:18
-- Design Name: 
-- Module Name: fifo_tb - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_tb is
 -- Port ( );
end fifo_tb;

architecture Behavioral of fifo_tb is

constant TCLK : time := 10 ns;
signal din : std_logic_vector(7 downto 0);
signal wr_en:  std_logic := '0';
signal  rd_en: std_logic := '0';
signal dout : std_logic_vector(7 downto 0);
signal clk: std_logic := '0';
signal rst: std_logic;
signal prog_full, full, empty , wr_rst_busy, rd_rst_busy: std_logic;
signal prog_full_tresh : std_logic_vector(9 downto 0) := (others => '0');

component fifo_generator_1 IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC := '0';
    rd_en : IN STD_LOGIC := '0';
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
END component;

 signal a : integer := 0;
begin

clk <= not clk after TCLK/2;
prog_full_tresh <= std_logic_vector(to_unsigned(10, 10));

instance: fifo_generator_1 
port map ( clk => clk,
           rst => rst,
           din => din,
           wr_en => wr_en,
           rd_en => rd_en,
           prog_full_thresh => prog_full_tresh,
            dout => dout,
            full => full,
            empty=> empty,
            prog_full=> prog_full,
            wr_rst_busy=> wr_rst_busy,
            rd_rst_busy => rd_rst_busy
  );
  
   
  process
 
  begin
  rst <= '1';
  wait for 50 ns;
  rst <= '0';
  wait until( rd_rst_busy = '0' and wr_rst_busy = '0');
  wait for TCLK;
  
  --je commence a ecrire les datas dans la fifo que je vais commencer a lire a partir de la 10e valeur
  for i in 0 to 14 loop
  din <= std_logic_vector(to_unsigned(i, 8));
  if full = '0' then wr_en <= '1';
  end if;
  a <= i;
  wait for TCLK;
  end loop;
  din <= (others => '0');
  wait;
  end process;
  
  
  process(a)
  begin
    if (a >= 9) then 
    if empty = '0' then rd_en <= '1';
    end if;
    end if;
  end process;

  
end Behavioral;
