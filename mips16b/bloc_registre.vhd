library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity REG_FILE is
    Port ( clk : in STD_LOGIC;
       ra1 : in STD_LOGIC_VECTOR (2 downto 0);
       ra2 : in STD_LOGIC_VECTOR (2 downto 0);
       wa : in STD_LOGIC_VECTOR (2 downto 0);
       wd : in STD_LOGIC_VECTOR (15 downto 0);
       reg_write : in STD_LOGIC;
       mpg_en : in STD_LOGIC;
       rd1 : out STD_LOGIC_VECTOR (15 downto 0);
       rd2 : out STD_LOGIC_VECTOR (15 downto 0));
end REG_FILE;

architecture Behavioral of REG_FILE is

type reg_array is array(0 to 7) of STD_LOGIC_VECTOR(15 downto 0);
signal reg_file : reg_array := (
                x"0000", 
                x"0001", 
                x"0002", 
                x"0003", 
                x"0004", 
                x"0005", 
                x"0006", 
                others => x"0000");

begin
    rd1 <= reg_file(conv_integer(ra1));
    rd2 <= reg_file(conv_integer(ra2));
    
    process(clk)
    begin
        if rising_edge(clk) then
            if mpg_en = '1' then
                if reg_write = '1' then
                    reg_file(conv_integer(wa)) <= wd;
                end if;
            end if;
        end if;
    end process;
    
    

end Behavioral;
