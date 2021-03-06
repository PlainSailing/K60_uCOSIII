///////////////////////////////////////////////////////////////////////////////
//                                                                            /
//                                                      03/Nov/2015  20:45:50 /
// IAR ANSI C/C++ Compiler V6.30.6.23336/W32 EVALUATION for ARM               /
// Copyright 1999-2012 IAR Systems AB.                                        /
//                                                                            /
//    Cpu mode     =  thumb                                                   /
//    Endian       =  little                                                  /
//    Source file  =  C:\Users\WangChangan\Desktop\K10小板定稿\KinetisDrivers /
//                    \KinetisOperate.c                                       /
//    Command line =  C:\Users\WangChangan\Desktop\K10小板定稿\KinetisDrivers /
//                    \KinetisOperate.c -D COMPILER_IAR -lCN                  /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\FLASH\List\" -lB "C:\Users\WangChangan\Desktop\K1 /
//                    0小板定稿\IAR Files\FLASH\List\" -o                     /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\FLASH\Obj\" --no_cse --no_unroll --no_inline      /
//                    --no_code_motion --no_tbaa --no_clustering              /
//                    --no_scheduling --debug --endian=little                 /
//                    --cpu=Cortex-M4 -e --fpu=None --dlib_config             /
//                    "C:\Program Files\IAR Systems\Embedded Workbench 6.0    /
//                    Evaluation\arm\INC\c\DLib_Config_Normal.h" -I           /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\Project_Headers\" -I                           /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\KinetisDrivers\" -I                            /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\ExtraFunction\" -I                             /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\Hardware_Interface\" -I                        /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\Make_Decision\" -I                             /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\Math\" -I "C:\Users\WangChangan\Desktop\K10小� /
//                    宥ǜ錦IAR Files\..\Original_Process\" -I                /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\Platform\" -I "C:\Users\WangChangan\Desktop\K1 /
//                    0小板定稿\IAR Files\..\SD_System\" -I                   /
//                    "C:\Users\WangChangan\Desktop\K10小板定稿\IAR           /
//                    Files\..\Source\" -I "C:\Users\WangChangan\Desktop\K10� /
//                    “宥ǜ錦IAR Files\..\System_Init\" -Ol                  /
//    List file    =  C:\Users\WangChangan\Desktop\K10小板定稿\IAR            /
//                    Files\FLASH\List\KinetisOperate.s                       /
//                                                                            /
//                                                                            /
///////////////////////////////////////////////////////////////////////////////

        NAME KinetisOperate

        #define SHT_PROGBITS 0x1

        PUBLIC EnableInt_Kinetis
        PUBLIC NullFun_Kinetis
        PUBLIC SetIntPri_Kinetis

// C:\Users\WangChangan\Desktop\K10小板定稿\KinetisDrivers\KinetisOperate.c
//    1 /************************************************************************************
//    2 
//    3 * KinetisOperate.c
//    4 
//    5 * 定义Kinetis的基本底层操作函数(中断的设置与CPU模式的设置)。
//    6 
//    7 * 所支持的芯片:   K10系列与K60系列
//    8 * 所支持的编译器: CodeWarrior 10.x or IAR 6.30
//    9 
//   10 * 该底层驱动由编译器自动生成的启动代码和飞思卡尔官方例程整理、修改而成。
//   11 
//   12 * 版权所有: 山东大学智能车工作室
//   13 * 作者:     孙文健       (第六届摄像头)
//   14 * 特别鸣谢: 纪成         (第四届摄像头)
//   15 * PS: 该底层驱动是在技术大神、四朝元老——伟大的纪师兄的指导与帮助下完成的，故在此特别鸣谢。
//   16 *     欲深入学习Kinetis，可以登录纪师兄的博客http://blog.chinaaet.com/jihceng0622
//   17 
//   18 * 程序版本: V1.02 
//   19 * 更新时间: 2012-05-01
//   20 
//   21 *************************************************************************************/
//   22 
//   23 #include "./KinetisConfig.h"
//   24 
//   25 /* 声明中断向量表 */
//   26 extern K_int32u_t __Sword_Vector__[]; 
//   27 
//   28 /************************************************************************************************ 
//   29 * EnableInt_Kinetis
//   30 * 开启某中断
//   31 * 入口参数: irq 中断标号(注意不是向量表中的向量号,是向量号-16)
//   32 * 返回参数: 设定结果,设定成功返回NOERR_Kinetis
//   33 ************************************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   34 Kinetis_Error_t EnableInt_Kinetis(K_int32u_t irq)
//   35 {
//   36   K_int32u_t div;
//   37 
//   38 #if EN_CheckOpt_Kinetis != 0
//   39   Kinetis_Error_t err = NOERR_Kinetis;
//   40   
//   41   if (irq > 91)
//   42   {
//   43     err |= ERR_IntNum_Kinetis;  
//   44   }
//   45   if(__Sword_Vector__[irq + 16] == (K_int32u_t)NullFun_Kinetis)
//   46   {
//   47     err |= ERR_IntISR_Kinetis;
//   48   }
//   49   
//   50   if(err != NOERR_Kinetis)
//   51   {
//   52     return err;
//   53   }
//   54 #endif
//   55 
//   56   /* Determine which of the NVICISERs corresponds to the irq */
//   57   div = irq >> 5;
EnableInt_Kinetis:
        LSRS     R1,R0,#+5
//   58 
//   59   if(div == 0)
        CMP      R1,#+0
        BNE.N    ??EnableInt_Kinetis_0
//   60   {
//   61     NVICICPR0 = 1 << (irq & 0x1F);
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.N    R2,??DataTable1  ;; 0xe000e280
        STR      R1,[R2, #+0]
//   62     NVICISER0 = 1 << (irq & 0x1F);
        MOVS     R1,#+1
        ANDS     R0,R0,#0x1F
        LSLS     R0,R1,R0
        LDR.N    R1,??DataTable1_1  ;; 0xe000e100
        STR      R0,[R1, #+0]
        B.N      ??EnableInt_Kinetis_1
//   63   } 
//   64   else if(div == 1)
??EnableInt_Kinetis_0:
        CMP      R1,#+1
        BNE.N    ??EnableInt_Kinetis_2
//   65   {
//   66     NVICICPR1 = 1 << (irq & 0x1F);
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.N    R2,??DataTable1_2  ;; 0xe000e284
        STR      R1,[R2, #+0]
//   67     NVICISER1 = 1 << (irq & 0x1F);
        MOVS     R1,#+1
        ANDS     R0,R0,#0x1F
        LSLS     R0,R1,R0
        LDR.N    R1,??DataTable1_3  ;; 0xe000e104
        STR      R0,[R1, #+0]
        B.N      ??EnableInt_Kinetis_1
//   68   }
//   69   else
//   70   {
//   71     NVICICPR2 = 1 << (irq & 0x1F);
??EnableInt_Kinetis_2:
        MOVS     R1,#+1
        ANDS     R2,R0,#0x1F
        LSLS     R1,R1,R2
        LDR.N    R2,??DataTable1_4  ;; 0xe000e288
        STR      R1,[R2, #+0]
//   72     NVICISER2 = 1 << (irq & 0x1F);
        MOVS     R1,#+1
        ANDS     R0,R0,#0x1F
        LSLS     R0,R1,R0
        LDR.N    R1,??DataTable1_5  ;; 0xe000e108
        STR      R0,[R1, #+0]
//   73   }   
//   74   
//   75   return NOERR_Kinetis;
??EnableInt_Kinetis_1:
        MOVS     R0,#+0
        BX       LR               ;; return
//   76 }
//   77 /************************************************************************************************ 
//   78 * SetIntPri_Kinetis
//   79 * 设定中断优先级
//   80 * 入口参数: irq  中断标号(注意不是向量表中的向量号,是向量号-16)
//   81 *           prio 中断优先级(取值0-15,值越小优先级越高)
//   82 * 返回参数: 设定结果,设定成功返回NOERR_Kinetis
//   83 ************************************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//   84 Kinetis_Error_t SetIntPri_Kinetis(K_int32u_t irq, K_int32u_t prio)
//   85 {
//   86   /*irq priority pointer*/
//   87   K_int8u_t *prio_reg;
//   88 
//   89 #if EN_CheckOpt_Kinetis != 0
//   90   Kinetis_Error_t err = NOERR_Kinetis;
//   91   
//   92   if (irq > 91) 
//   93   {
//   94     err |= ERR_IntNum_Kinetis;  
//   95   }
//   96   if (prio > 15)
//   97   {
//   98     err |= ERR_IntPri_Kinetis;
//   99   }
//  100   if(__Sword_Vector__[irq + 16] == (K_int32u_t)NullFun_Kinetis)
//  101   {
//  102     err |= ERR_IntISR_Kinetis;
//  103   }
//  104   
//  105   if(err != NOERR_Kinetis)
//  106   {
//  107     return err;
//  108   }
//  109 #endif
//  110 
//  111   /* Determine which of the NVICIPx corresponds to the irq */
//  112   prio_reg = (K_int8u_t *)(((K_int32u_t)&NVICIP0) + irq);
SetIntPri_Kinetis:
        ADD      R0,R0,#-536870912
        ADDS     R0,R0,#+58368
//  113   /* Assign priority to IRQ */
//  114   *prio_reg = ( (prio & 0x000F) << (8 - ARM_INTERRUPT_LEVEL_BITS) );   
        LSLS     R1,R1,#+4
        STRB     R1,[R0, #+0]
//  115 
//  116   return NOERR_Kinetis;
        MOVS     R0,#+0
        BX       LR               ;; return
//  117 }
//  118 #if EN_DisableInt_Kinetis != 0
//  119 /************************************************************************************************ 
//  120 * DisableInt_Kinetis
//  121 * 禁用某中断
//  122 * 入口参数: irq 中断标号(注意不是向量表中的向量号,是向量号-16)
//  123 * 返回参数: 设定结果,设定成功返回NOERR_Kinetis
//  124 ************************************************************************************************/
//  125 Kinetis_Error_t DisableInt_Kinetis(K_int32u_t irq)
//  126 {
//  127   K_int32u_t div;
//  128     
//  129 #if EN_CheckOpt_Kinetis != 0
//  130   Kinetis_Error_t err = NOERR_Kinetis;
//  131     
//  132   if (irq > 91)
//  133   {
//  134     err |= ERR_IntNum_Kinetis;  
//  135   }
//  136     
//  137   if(err != NOERR_Kinetis)
//  138   {
//  139     return err;
//  140   }
//  141 #endif
//  142 
//  143   /* Determine which of the NVICICERs corresponds to the irq */
//  144   div = irq >> 5;
//  145 
//  146   if(div == 0)
//  147   {
//  148     NVICICER0 = 1 << (irq & 0x1F);
//  149   }
//  150   else if(div == 1)
//  151   {
//  152     NVICICER1 = 1 << (irq & 0x1F);
//  153   }
//  154   else
//  155   {
//  156     NVICICER2 = 1 << (irq & 0x1F);
//  157   } 
//  158 
//  159   return NOERR_Kinetis;
//  160 }
//  161 #endif
//  162 #if EN_StopFun_Kinetis != 0
//  163 /************************************************************************************************ 
//  164 * Stop_Kinetis
//  165 * 将Kinetis设置在Stop模式
//  166 ************************************************************************************************/
//  167 void Stop_Kinetis(void)
//  168 {
//  169   /* Set the SLEEPDEEP bit to enable deep sleep mode (STOP) */
//  170   SCB_SCR |= SCB_SCR_SLEEPDEEP_MASK;  
//  171 
//  172   /* WFI instruction will start entry into STOP mode */
//  173   asm("WFI");
//  174 }
//  175 #endif
//  176 #if EN_WaitFun_Kinetis != 0
//  177 /************************************************************************************************ 
//  178 * Wait_Kinetis
//  179 * 将Kinetis设置在Wait模式
//  180 ************************************************************************************************/
//  181 void Wait_Kinetis(void)
//  182 {
//  183   /* 
//  184    * Clear the SLEEPDEEP bit to make sure we go into WAIT (sleep) mode instead
//  185    * of deep sleep.
//  186    */
//  187   SCB_SCR &= ~SCB_SCR_SLEEPDEEP_MASK;  
//  188 
//  189   /* WFI instruction will start entry into WAIT mode */
//  190   asm("WFI");
//  191 }
//  192 #endif
//  193 /************************************************************************************************ 
//  194 * NullFun_Kinetis
//  195 * Kinetis的空操作函数
//  196 ************************************************************************************************/

        SECTION `.text`:CODE:NOROOT(1)
        THUMB
//  197 void NullFun_Kinetis(void)
//  198 { /* 进入空函数, 直接使车复位 */
//  199   UNLOCK_WatchDog;       /* 解锁开门狗 */
NullFun_Kinetis:
        LDR.N    R0,??DataTable1_6  ;; 0x4005200e
        MOVW     R1,#+50464
        STRH     R1,[R0, #+0]
        LDR.N    R0,??DataTable1_6  ;; 0x4005200e
        MOVW     R1,#+55592
        STRH     R1,[R0, #+0]
//  200 	
//  201   WDOG_PRESC = 0;        /* 设置时钟分频数为1 */
        LDR.N    R0,??DataTable1_7  ;; 0x40052016
        MOVS     R1,#+0
        STRH     R1,[R0, #+0]
//  202 	
//  203   WDOG_TOVALH = 0x000E;  /* 设置溢出周期 */
        LDR.N    R0,??DataTable1_8  ;; 0x40052004
        MOVS     R1,#+14
        STRH     R1,[R0, #+0]
//  204   WDOG_TOVALL = 0xA600;
        LDR.N    R0,??DataTable1_9  ;; 0x40052006
        MOV      R1,#+42496
        STRH     R1,[R0, #+0]
//  205 	
//  206   WDOG_STCTRLH = 0x4003; /* 关闭TestMode和WindowMode,选择时钟为总线时钟,并使能开门狗 */
        LDR.N    R0,??DataTable1_10  ;; 0x40052000
        MOVW     R1,#+16387
        STRH     R1,[R0, #+0]
//  207   
//  208   WDOG_UNLOCK = 0xC520;
        LDR.N    R0,??DataTable1_6  ;; 0x4005200e
        MOVW     R1,#+50464
        STRH     R1,[R0, #+0]
//  209   
//  210   for(;;) ;
??NullFun_Kinetis_0:
        B.N      ??NullFun_Kinetis_0
//  211 }

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1:
        DC32     0xe000e280

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_1:
        DC32     0xe000e100

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_2:
        DC32     0xe000e284

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_3:
        DC32     0xe000e104

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_4:
        DC32     0xe000e288

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_5:
        DC32     0xe000e108

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_6:
        DC32     0x4005200e

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_7:
        DC32     0x40052016

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_8:
        DC32     0x40052004

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_9:
        DC32     0x40052006

        SECTION `.text`:CODE:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
??DataTable1_10:
        DC32     0x40052000

        SECTION `.iar_vfe_header`:DATA:REORDER:NOALLOC:NOROOT(2)
        SECTION_TYPE SHT_PROGBITS, 0
        DATA
        DC32 0

        SECTION __DLIB_PERTHREAD:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        SECTION __DLIB_PERTHREAD_init:DATA:REORDER:NOROOT(0)
        SECTION_TYPE SHT_PROGBITS, 0

        END
// 
// 210 bytes in section .text
// 
// 210 bytes of CODE memory
//
//Errors: none
//Warnings: none
