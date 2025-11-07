----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.11.2025 09:22:40
-- Design Name: 
-- Module Name: tb_memoire_cache_lena - Behavioral
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
use std.textio.all;
use ieee.std_logic_textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_memoire_cache_lena is
--  Port ( );
end tb_memoire_cache_lena;

architecture Behavioral of tb_memoire_cache_lena is

component memoire_cache is
  generic(
    LARGEUR_IMAGE : integer := 128;
    HAUTEUR_IMAGE : integer := 128
  );
  port(
    clk, rst   : in  std_logic;
    pixel_entree     : in  std_logic_vector(7 downto 0);
    pixel_valide     : in  std_logic;
    wr_en_fifo1, wr_en_fifo2, en_milieu, en_haut : in std_logic;
    p00, p01, p02 : out std_logic_vector(7 downto 0);
    p10, p11, p12 : out std_logic_vector(7 downto 0);
    p20, p21, p22 : out std_logic_vector(7 downto 0);

    fenetre_valide  : out std_logic
  );
  
end component;


  signal LARGEUR_IMAGE : integer := 128;
  signal HAUTEUR_IMAGE : integer := 128;
  signal I1 : std_logic_vector (7 downto 0);
  signal clk : std_logic := '0';
  signal O1 : std_logic_vector (7 downto 0); 
  signal DATA_AVAILABLE : std_logic;
  
  signal p00, p01, p02 : std_logic_vector(7 downto 0) := (others => '0');
  signal p10, p11, p12 : std_logic_vector(7 downto 0) := (others => '0');
  signal p20, p21, p22 : std_logic_vector(7 downto 0) := (others => '0');
  
  signal pixel_entree : std_logic_vector(7 downto 0):= x"00";
  signal fenetre_valide, rst: std_logic;
  signal wr_en_fifo1, wr_en_fifo2, en_milieu, en_haut : std_logic := '0';

begin

memoire: memoire_cache
    generic map( LARGEUR_IMAGE => LARGEUR_IMAGE,
                 HAUTEUR_IMAGE => HAUTEUR_IMAGE)
    port map ( clk => clk,
               rst => rst,
               pixel_entree => pixel_entree,
               pixel_valide => DATA_AVAILABLE,
               wr_en_fifo1 => wr_en_fifo1, 
               wr_en_fifo2 => wr_en_fifo2, 
               en_milieu => en_milieu, 
               en_haut => en_haut,
               p00 => p00,
               p01 => p01,
               p02 => p02,
               p10 => p10,
               p11 => p11,
               p12 => p12,
               p20 => p20,
               p21 => p21,
               p22 => p22,
               fenetre_valide => fenetre_valide);
               
        
clk <= not clk after 5 ns;
p_read: process
  FILE vectors : text;
  variable Iline : line;
  variable I1_var :std_logic_vector (7 downto 0);


begin
	DATA_AVAILABLE <= '0';
    file_open (vectors,"Lena128x128g_8bits.dat", read_mode);
    wait for 20 ns;
    
    while not endfile(vectors) loop
      readline (vectors,Iline);
      read (Iline,I1_var);
      pixel_entree <= I1_var;
      
	  DATA_AVAILABLE <= '1';
	  wait for 10 ns;
    end loop;
    DATA_AVAILABLE <= '0';
    wait for 10 ns;
    file_close (vectors);
    wait;
end process;

p_write: process
  file results : text;
  variable OLine : line;
  variable O1_var :std_logic_vector (7 downto 0);
    
    begin
    file_open (results,"Lena128x128g_8bits_matrice.dat", write_mode);
    wait for 10 ns;
    wait until DATA_AVAILABLE = '1';
    wait for 10 ns;
    while DATA_AVAILABLE ='1' loop
      write (Oline, O1, right, 2);
      writeline (results, Oline);
      wait for 10 ns;  
    end loop;
    file_close (results);
    wait;
 end process;
 
 O1 <= p12;
 
 process
begin
    wait until (DATA_AVAILABLE = '1');
    wait for 25 ns;
    wr_en_fifo1 <= '1';
    wait for 1240 ns ;
    en_milieu <= '1';
    wait for 25 ns;
    wr_en_fifo2 <= '1';
    wait for 1240 ns ;
    en_haut <= '1';
         

end process;
 
end Behavioral;
