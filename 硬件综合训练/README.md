# 硬件综合训练
2024级2026秋硬件综合训练课程,分为logisim和verilog两部分。
## Logisim
本人分到的CCAB指令号是2751,分别对应SRL,SLTIU,SB,BLT四条指令。
由标准测试文件和四条CCAB指令测试代码拼接成的个性化测试文件为
```
RISC-V汇编工具与测试用例5.0/mytest.asm
RISC-V汇编工具与测试用例5.0/mytest.hex
 ```
 本人完成的实验任务有:
- 单周期RISC-V
- 理想流水线
- 气泡流水线
- 重定向流水线
- 动态分支预测流水线(LED显示正常,但是最后停止时的周期计数和学长的参考代码不一致,故不清楚电路是否正确)
- 单周期+单级中断
单周期+多级中断电路存在严重问题，请勿参考。

最终的电路文件为
```
logisim/电路框架-cpu21-riscv/cpu21-riscv_flow.circ
```
# verilog
暂未开始verilog部分的开发。
