----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.10.2025 09:53:18
-- Design Name: 
-- Module Name: memoire_cache - Behavioral
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

entity memoire_cache is
  generic(
    LARGEUR_IMAGE : integer := 128;
    HAUTEUR_IMAGE : integer := 128
  );
  port(
    clk, rst   : in  std_logic;
    wr_en_fifo1, wr_en_fifo2, en_milieu, en_haut : in std_logic;
    pixel_entree     : in  std_logic_vector(7 downto 0);
    pixel_valide     : in  std_logic;

    p00, p01, p02 : out std_logic_vector(7 downto 0);
    p10, p11, p12 : out std_logic_vector(7 downto 0);
    p20, p21, p22 : out std_logic_vector(7 downto 0);

    fenetre_valide  : out std_logic
  );
end memoire_cache;

architecture rtl of memoire_cache is

  component fifo_generator_1 
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    prog_full_thresh : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dout : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC;
    prog_full : OUT STD_LOGIC;
    wr_rst_busy : OUT STD_LOGIC;
    rd_rst_busy : OUT STD_LOGIC
  );
    END component;

  component ligne_retard
    port(
      clk   : in  std_logic;
      rst   : in  std_logic;
      en    : in  std_logic;
      din   : in  std_logic_vector(7 downto 0);
      dout1 : out std_logic_vector(7 downto 0);
      dout2 : out std_logic_vector(7 downto 0);
      dout3 : out std_logic_vector(7 downto 0)
    );
  end component;

  constant prog_full_tresh_int : integer := LARGEUR_IMAGE - 4;
  signal prog_full_tresh : std_logic_vector (9 downto 0);
  signal ligne_actuelle, ligne_moins1, ligne_moins2 : std_logic_vector(7 downto 0);

  signal bas_gauche, bas_milieu, bas_droite : std_logic_vector(7 downto 0);
  signal milieu_gauche, milieu_milieu, milieu_droite : std_logic_vector(7 downto 0);
  signal haut_gauche, haut_milieu, haut_droite : std_logic_vector(7 downto 0);

  signal fenetre_valide_interne : std_logic := '0';
  signal full, empty, prog_full_fifo1, prog_full_fifo2 : std_logic ;
  
  signal wr_rst_busy, rd_rst_busy : std_logic ;

begin
  prog_full_tresh <= std_logic_vector(to_unsigned(prog_full_tresh_int, 10));
  ligne_actuelle <= pixel_entree;
  
    u_ligne_bas : ligne_retard
    port map(
      clk   => clk,
      rst   => rst,
      en    => pixel_valide,
      din   => ligne_actuelle,
      dout1 => bas_droite,
      dout2 => bas_milieu,
      dout3 => bas_gauche
    );
    
    
    u_fifo1 : fifo_generator_1
    port map(
      clk   => clk,
      rst  => rst,
      din   => bas_gauche,
      wr_en => wr_en_fifo1,
      rd_en => prog_full_fifo1,
      prog_full_thresh => prog_full_tresh,
      dout  => ligne_moins1,
      full  => full,
      empty => empty,
      prog_full => prog_full_fifo1,
      wr_rst_busy=> wr_rst_busy,
      rd_rst_busy => rd_rst_busy
    );
    
     u_ligne_milieu : ligne_retard
     port map(
      clk   => clk,
      rst   => rst,
      en    => en_milieu,
      din   => ligne_moins1,
      dout1 => milieu_droite,
      dout2 => milieu_milieu,
      dout3 => milieu_gauche
    );


u_fifo2 : fifo_generator_1
    port map(
      clk   => clk,
      rst  => rst,
      din   => milieu_gauche,
      wr_en => wr_en_fifo2,
      rd_en => prog_full_fifo2,
      prog_full_thresh => prog_full_tresh,
      dout  => ligne_moins2,
      full  => full,
      empty => empty,
      prog_full => prog_full_fifo2,
      wr_rst_busy=> wr_rst_busy,
      rd_rst_busy => rd_rst_busy
    );


  u_ligne_haut : ligne_retard
    port map(
      clk   => clk,
      rst   => rst,
      en    => en_haut,
      din   => ligne_moins2,
      dout1 => haut_droite,
      dout2 => haut_milieu,
      dout3 => haut_gauche
    );

  p00 <= haut_gauche;  p01 <= haut_milieu;  p02 <= haut_droite;
  p10 <= milieu_gauche; p11 <= milieu_milieu; p12 <= milieu_droite;
  p20 <= bas_gauche;    p21 <= bas_milieu;   p22 <= bas_droite;


  fenetre_valide <= fenetre_valide_interne;


end rtl;


