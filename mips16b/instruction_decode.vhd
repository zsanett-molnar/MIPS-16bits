library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_decode is
    Port ( clk : in STD_LOGIC;
           instruction : in STD_LOGIC_VECTOR (15 downto 0);
           reg_write : in STD_LOGIC;
           reg_dest : in STD_LOGIC;
           mpg_en : in STD_LOGIC;
           wd : in STD_LOGIC_VECTOR (15 downto 0);
           ext_op : in STD_LOGIC;
           rd1 : out STD_LOGIC_VECTOR (15 downto 0);
           rd2 : out STD_LOGIC_VECTOR (15 downto 0);
           ext_imm : out STD_LOGIC_VECTOR (15 downto 0);
           func : out STD_LOGIC_VECTOR (2 downto 0);
           sa : out STD_LOGIC);
end instruction_decode;

architecture Behavioral of instruction_decode is

component REG_FILE is
    Port ( clk : in STD_LOGIC;
       ra1 : in STD_LOGIC_VECTOR (2 downto 0);
       ra2 : in STD_LOGIC_VECTOR (2 downto 0);
       wa : in STD_LOGIC_VECTOR (2 downto 0);
       wd : in STD_LOGIC_VECTOR (15 downto 0);
       reg_write : in STD_LOGIC;
       mpg_en : in STD_LOGIC;
       rd1 : out STD_LOGIC_VECTOR (15 downto 0);
       rd2 : out STD_LOGIC_VECTOR (15 downto 0));
end component;

signal wa : STD_LOGIC_VECTOR(2 downto 0) := "000";
--signal to_be_ext : STD_LOGIC_VECTOR(6 downto 0) := "0000000";

begin

    wa <= instruction(9 downto 7) when reg_dest='0' else instruction(6 downto 4);
    func <= instruction(2 downto 0);
    sa <= instruction(3);
    
    ext_imm <= "000000000" & instruction(6 downto 0) when ext_op = '0' 
        else instruction(6)& instruction(6) & instruction(6)& instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6) & instruction(6 downto 0);
            
    reg_file_comp : REG_FILE port map ( clk => clk, ra1 => instruction(12 downto 10), ra2 => instruction(9 downto 7),
            wa => wa, wd => wd, reg_write => reg_write, mpg_en => mpg_en, rd1 => rd1, rd2 => rd2);

end Behavioral;
