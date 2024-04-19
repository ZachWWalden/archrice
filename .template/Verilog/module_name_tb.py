#*==================================================================================
# *Testbench - <++> testbench
# *Author - Zach Walden
# *Created - DATE
# *Last Changed - DATE
# *Description -
# *Parameters -
#====================================================================================*/

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import FallingEdge
from cocotb.triggers import RisingEdge

@cocotb.test()
async def test_<++>(dut):
    clock = Clock(dut.clock, 10, units="ns")
    cocotb.start_soon(clock.start())
