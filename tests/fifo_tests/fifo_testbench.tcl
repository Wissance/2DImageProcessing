#module enable
add_force {/fifo_testbench/enable} -radix hex {0} {1 20us} 
#add_force {/fifo_testbench/enable} -radix hex {0} {1 20us} {0 450us} 

add_force {/fifo_testbench/in_data} -radix hex {0x10 1us} {0x20 5us} {0x40 7us} {0 10us} {0x80 25us} {0 35us} {0xA0 50us} {0 60us} {0xF0 150us} {0 160us} {0xF2 180us} {0 190us} {0xF4 220us} {0 230us} {0x11 350us} {0 360us} {0x22 380us} {0 390us} {0x33 420us} {0 430us}
add_force {/fifo_testbench/push_clock} -radix hex {0} {1 2us} {0 4us} {1 6us} {0 7us} {1 8us} {0 10us} {1 26us} {0 30us} {1 52us} {0 60us} {1 150us} {0 160us} {1 180us} {0 190us} {1 220us} {0 230us} {1 351us} {0 360us} {1 381us} {0 390us} {1 421us} {0 430us}
add_force {/fifo_testbench/pop_clock} -radix hex {0} {1 11us} {0 12us} {1 70us} {0 75us} {1 80us} {0 85us} {1 90us} {0 95us} {1 240us} {0 250us} {1 450us} {0 460us} {1 470us} {0 480us} {1 490us} {0 500us}

add_force {/fifo_testbench/clear} -radix hex {0} {1 300us} {0 320us} 
