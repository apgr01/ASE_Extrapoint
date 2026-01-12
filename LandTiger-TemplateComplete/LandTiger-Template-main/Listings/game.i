# 1 "Source/game.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 404 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "Source/game.c" 2
# 1 "Source\\game.h" 1



# 1 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdint.h" 1 3
# 56 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdint.h" 3
typedef signed char int8_t;
typedef signed short int int16_t;
typedef signed int int32_t;
typedef signed long long int int64_t;


typedef unsigned char uint8_t;
typedef unsigned short int uint16_t;
typedef unsigned int uint32_t;
typedef unsigned long long int uint64_t;





typedef signed char int_least8_t;
typedef signed short int int_least16_t;
typedef signed int int_least32_t;
typedef signed long long int int_least64_t;


typedef unsigned char uint_least8_t;
typedef unsigned short int uint_least16_t;
typedef unsigned int uint_least32_t;
typedef unsigned long long int uint_least64_t;




typedef signed int int_fast8_t;
typedef signed int int_fast16_t;
typedef signed int int_fast32_t;
typedef signed long long int int_fast64_t;


typedef unsigned int uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned int uint_fast32_t;
typedef unsigned long long int uint_fast64_t;






typedef signed int intptr_t;
typedef unsigned int uintptr_t;



typedef signed long long intmax_t;
typedef unsigned long long uintmax_t;
# 5 "Source\\game.h" 2
# 1 "Source\\GLCD/GLCD.h" 1
# 26 "Source\\GLCD/GLCD.h"
# 1 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\LPC17xx.h" 1
# 41 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\LPC17xx.h"
typedef enum IRQn
{

  Reset_IRQn = -15,
  NonMaskableInt_IRQn = -14,
  HardFault_IRQn = -13,
  MemoryManagement_IRQn = -12,
  BusFault_IRQn = -11,
  UsageFault_IRQn = -10,
  SVCall_IRQn = -5,
  DebugMonitor_IRQn = -4,
  PendSV_IRQn = -2,
  SysTick_IRQn = -1,


  WDT_IRQn = 0,
  TIMER0_IRQn = 1,
  TIMER1_IRQn = 2,
  TIMER2_IRQn = 3,
  TIMER3_IRQn = 4,
  UART0_IRQn = 5,
  UART1_IRQn = 6,
  UART2_IRQn = 7,
  UART3_IRQn = 8,
  PWM1_IRQn = 9,
  I2C0_IRQn = 10,
  I2C1_IRQn = 11,
  I2C2_IRQn = 12,
  SPI_IRQn = 13,
  SSP0_IRQn = 14,
  SSP1_IRQn = 15,
  PLL0_IRQn = 16,
  RTC_IRQn = 17,
  EINT0_IRQn = 18,
  EINT1_IRQn = 19,
  EINT2_IRQn = 20,
  EINT3_IRQn = 21,
  ADC_IRQn = 22,
  BOD_IRQn = 23,
  USB_IRQn = 24,
  CAN_IRQn = 25,
  DMA_IRQn = 26,
  I2S_IRQn = 27,
  ENET_IRQn = 28,
  RIT_IRQn = 29,
  MCPWM_IRQn = 30,
  QEI_IRQn = 31,
  PLL1_IRQn = 32,
  USBActivity_IRQn = 33,
  CANActivity_IRQn = 34,
} IRQn_Type;
# 106 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\LPC17xx.h"
# 1 "./Source/CMSIS_core\\core_cm3.h" 1
# 29 "./Source/CMSIS_core\\core_cm3.h" 3
# 63 "./Source/CMSIS_core\\core_cm3.h" 3
# 1 "./Source/CMSIS_core\\cmsis_version.h" 1 3
# 29 "./Source/CMSIS_core\\cmsis_version.h" 3
# 64 "./Source/CMSIS_core\\core_cm3.h" 2 3
# 115 "./Source/CMSIS_core\\core_cm3.h" 3
# 1 "./Source/CMSIS_core\\cmsis_compiler.h" 1 3
# 47 "./Source/CMSIS_core\\cmsis_compiler.h" 3
# 1 "./Source/CMSIS_core\\cmsis_armclang.h" 1 3
# 31 "./Source/CMSIS_core\\cmsis_armclang.h" 3
# 64 "./Source/CMSIS_core\\cmsis_armclang.h" 3
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

  struct __attribute__((packed)) T_UINT32 { uint32_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

  struct __attribute__((packed, aligned(1))) T_UINT16_WRITE { uint16_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

  struct __attribute__((packed, aligned(1))) T_UINT16_READ { uint16_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

  struct __attribute__((packed, aligned(1))) T_UINT32_WRITE { uint32_t v; };
#pragma clang diagnostic pop



#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wpacked"

  struct __attribute__((packed, aligned(1))) T_UINT32_READ { uint32_t v; };
#pragma clang diagnostic pop
# 260 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __ROR(uint32_t op1, uint32_t op2)
{
  op2 %= 32U;
  if (op2 == 0U)
  {
    return op1;
  }
  return (op1 >> op2) | (op1 << (32U - op2));
}
# 295 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint8_t __CLZ(uint32_t value)
{
# 306 "./Source/CMSIS_core\\cmsis_armclang.h" 3
  if (value == 0U)
  {
    return 32U;
  }
  return __builtin_clz(value);
}
# 425 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __RRX(uint32_t value)
{
  uint32_t result;

  __asm volatile ("rrx %0, %1" : "=r" (result) : "r" (value) );
  return(result);
}
# 440 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint8_t __LDRBT(volatile uint8_t *ptr)
{
  uint32_t result;

  __asm volatile ("ldrbt %0, %1" : "=r" (result) : "Q" (*ptr) );
  return ((uint8_t) result);
}
# 455 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint16_t __LDRHT(volatile uint16_t *ptr)
{
  uint32_t result;

  __asm volatile ("ldrht %0, %1" : "=r" (result) : "Q" (*ptr) );
  return ((uint16_t) result);
}
# 470 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __LDRT(volatile uint32_t *ptr)
{
  uint32_t result;

  __asm volatile ("ldrt %0, %1" : "=r" (result) : "Q" (*ptr) );
  return(result);
}
# 485 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __STRBT(uint8_t value, volatile uint8_t *ptr)
{
  __asm volatile ("strbt %1, %0" : "=Q" (*ptr) : "r" ((uint32_t)value) );
}
# 497 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __STRHT(uint16_t value, volatile uint16_t *ptr)
{
  __asm volatile ("strht %1, %0" : "=Q" (*ptr) : "r" ((uint32_t)value) );
}
# 509 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __STRT(uint32_t value, volatile uint32_t *ptr)
{
  __asm volatile ("strt %1, %0" : "=Q" (*ptr) : "r" (value) );
}
# 737 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __enable_irq(void)
{
  __asm volatile ("cpsie i" : : : "memory");
}
# 750 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __disable_irq(void)
{
  __asm volatile ("cpsid i" : : : "memory");
}
# 762 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_CONTROL(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, control" : "=r" (result) );
  return(result);
}
# 792 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_CONTROL(uint32_t control)
{
  __asm volatile ("MSR control, %0" : : "r" (control) : "memory");
  __builtin_arm_isb(0xF);
}
# 818 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_IPSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, ipsr" : "=r" (result) );
  return(result);
}







__attribute__((always_inline)) static __inline uint32_t __get_APSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, apsr" : "=r" (result) );
  return(result);
}







__attribute__((always_inline)) static __inline uint32_t __get_xPSR(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, xpsr" : "=r" (result) );
  return(result);
}







__attribute__((always_inline)) static __inline uint32_t __get_PSP(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, psp" : "=r" (result) );
  return(result);
}
# 890 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_PSP(uint32_t topOfProcStack)
{
  __asm volatile ("MSR psp, %0" : : "r" (topOfProcStack) : );
}
# 914 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_MSP(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, msp" : "=r" (result) );
  return(result);
}
# 944 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_MSP(uint32_t topOfMainStack)
{
  __asm volatile ("MSR msp, %0" : : "r" (topOfMainStack) : );
}
# 995 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline uint32_t __get_PRIMASK(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, primask" : "=r" (result) );
  return(result);
}
# 1025 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_PRIMASK(uint32_t priMask)
{
  __asm volatile ("MSR primask, %0" : : "r" (priMask) : "memory");
}
# 1053 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __enable_fault_irq(void)
{
  __asm volatile ("cpsie f" : : : "memory");
}







__attribute__((always_inline)) static __inline void __disable_fault_irq(void)
{
  __asm volatile ("cpsid f" : : : "memory");
}







__attribute__((always_inline)) static __inline uint32_t __get_BASEPRI(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, basepri" : "=r" (result) );
  return(result);
}
# 1105 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_BASEPRI(uint32_t basePri)
{
  __asm volatile ("MSR basepri, %0" : : "r" (basePri) : "memory");
}
# 1130 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_BASEPRI_MAX(uint32_t basePri)
{
  __asm volatile ("MSR basepri_max, %0" : : "r" (basePri) : "memory");
}







__attribute__((always_inline)) static __inline uint32_t __get_FAULTMASK(void)
{
  uint32_t result;

  __asm volatile ("MRS %0, faultmask" : "=r" (result) );
  return(result);
}
# 1171 "./Source/CMSIS_core\\cmsis_armclang.h" 3
__attribute__((always_inline)) static __inline void __set_FAULTMASK(uint32_t faultMask)
{
  __asm volatile ("MSR faultmask, %0" : : "r" (faultMask) : "memory");
}
# 48 "./Source/CMSIS_core\\cmsis_compiler.h" 2 3
# 116 "./Source/CMSIS_core\\core_cm3.h" 2 3
# 211 "./Source/CMSIS_core\\core_cm3.h" 3
typedef union
{
  struct
  {
    uint32_t _reserved0:27;
    uint32_t Q:1;
    uint32_t V:1;
    uint32_t C:1;
    uint32_t Z:1;
    uint32_t N:1;
  } b;
  uint32_t w;
} APSR_Type;
# 245 "./Source/CMSIS_core\\core_cm3.h" 3
typedef union
{
  struct
  {
    uint32_t ISR:9;
    uint32_t _reserved0:23;
  } b;
  uint32_t w;
} IPSR_Type;
# 263 "./Source/CMSIS_core\\core_cm3.h" 3
typedef union
{
  struct
  {
    uint32_t ISR:9;
    uint32_t _reserved0:1;
    uint32_t ICI_IT_1:6;
    uint32_t _reserved1:8;
    uint32_t T:1;
    uint32_t ICI_IT_2:2;
    uint32_t Q:1;
    uint32_t V:1;
    uint32_t C:1;
    uint32_t Z:1;
    uint32_t N:1;
  } b;
  uint32_t w;
} xPSR_Type;
# 314 "./Source/CMSIS_core\\core_cm3.h" 3
typedef union
{
  struct
  {
    uint32_t nPRIV:1;
    uint32_t SPSEL:1;
    uint32_t _reserved1:30;
  } b;
  uint32_t w;
} CONTROL_Type;
# 345 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile uint32_t ISER[8U];
        uint32_t RESERVED0[24U];
  volatile uint32_t ICER[8U];
        uint32_t RESERVED1[24U];
  volatile uint32_t ISPR[8U];
        uint32_t RESERVED2[24U];
  volatile uint32_t ICPR[8U];
        uint32_t RESERVED3[24U];
  volatile uint32_t IABR[8U];
        uint32_t RESERVED4[56U];
  volatile uint8_t IP[240U];
        uint32_t RESERVED5[644U];
  volatile uint32_t STIR;
} NVIC_Type;
# 379 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile const uint32_t CPUID;
  volatile uint32_t ICSR;
  volatile uint32_t VTOR;
  volatile uint32_t AIRCR;
  volatile uint32_t SCR;
  volatile uint32_t CCR;
  volatile uint8_t SHP[12U];
  volatile uint32_t SHCSR;
  volatile uint32_t CFSR;
  volatile uint32_t HFSR;
  volatile uint32_t DFSR;
  volatile uint32_t MMFAR;
  volatile uint32_t BFAR;
  volatile uint32_t AFSR;
  volatile const uint32_t PFR[2U];
  volatile const uint32_t DFR;
  volatile const uint32_t ADR;
  volatile const uint32_t MMFR[4U];
  volatile const uint32_t ISAR[5U];
        uint32_t RESERVED0[5U];
  volatile uint32_t CPACR;
} SCB_Type;
# 660 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
        uint32_t RESERVED0[1U];
  volatile const uint32_t ICTR;



        uint32_t RESERVED1[1U];

} SCnSCB_Type;
# 706 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile uint32_t CTRL;
  volatile uint32_t LOAD;
  volatile uint32_t VAL;
  volatile const uint32_t CALIB;
} SysTick_Type;
# 758 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile union
  {
    volatile uint8_t u8;
    volatile uint16_t u16;
    volatile uint32_t u32;
  } PORT [32U];
        uint32_t RESERVED0[864U];
  volatile uint32_t TER;
        uint32_t RESERVED1[15U];
  volatile uint32_t TPR;
        uint32_t RESERVED2[15U];
  volatile uint32_t TCR;
        uint32_t RESERVED3[32U];
        uint32_t RESERVED4[43U];
  volatile uint32_t LAR;
  volatile const uint32_t LSR;
        uint32_t RESERVED5[6U];
  volatile const uint32_t PID4;
  volatile const uint32_t PID5;
  volatile const uint32_t PID6;
  volatile const uint32_t PID7;
  volatile const uint32_t PID0;
  volatile const uint32_t PID1;
  volatile const uint32_t PID2;
  volatile const uint32_t PID3;
  volatile const uint32_t CID0;
  volatile const uint32_t CID1;
  volatile const uint32_t CID2;
  volatile const uint32_t CID3;
} ITM_Type;
# 846 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile uint32_t CTRL;
  volatile uint32_t CYCCNT;
  volatile uint32_t CPICNT;
  volatile uint32_t EXCCNT;
  volatile uint32_t SLEEPCNT;
  volatile uint32_t LSUCNT;
  volatile uint32_t FOLDCNT;
  volatile const uint32_t PCSR;
  volatile uint32_t COMP0;
  volatile uint32_t MASK0;
  volatile uint32_t FUNCTION0;
        uint32_t RESERVED0[1U];
  volatile uint32_t COMP1;
  volatile uint32_t MASK1;
  volatile uint32_t FUNCTION1;
        uint32_t RESERVED1[1U];
  volatile uint32_t COMP2;
  volatile uint32_t MASK2;
  volatile uint32_t FUNCTION2;
        uint32_t RESERVED2[1U];
  volatile uint32_t COMP3;
  volatile uint32_t MASK3;
  volatile uint32_t FUNCTION3;
} DWT_Type;
# 993 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile const uint32_t SSPSR;
  volatile uint32_t CSPSR;
        uint32_t RESERVED0[2U];
  volatile uint32_t ACPR;
        uint32_t RESERVED1[55U];
  volatile uint32_t SPPR;
        uint32_t RESERVED2[131U];
  volatile const uint32_t FFSR;
  volatile uint32_t FFCR;
  volatile const uint32_t FSCR;
        uint32_t RESERVED3[759U];
  volatile const uint32_t TRIGGER;
  volatile const uint32_t FIFO0;
  volatile const uint32_t ITATBCTR2;
        uint32_t RESERVED4[1U];
  volatile const uint32_t ITATBCTR0;
  volatile const uint32_t FIFO1;
  volatile uint32_t ITCTRL;
        uint32_t RESERVED5[39U];
  volatile uint32_t CLAIMSET;
  volatile uint32_t CLAIMCLR;
        uint32_t RESERVED7[8U];
  volatile const uint32_t DEVID;
  volatile const uint32_t DEVTYPE;
} TPI_Type;
# 1155 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile const uint32_t TYPE;
  volatile uint32_t CTRL;
  volatile uint32_t RNR;
  volatile uint32_t RBAR;
  volatile uint32_t RASR;
  volatile uint32_t RBAR_A1;
  volatile uint32_t RASR_A1;
  volatile uint32_t RBAR_A2;
  volatile uint32_t RASR_A2;
  volatile uint32_t RBAR_A3;
  volatile uint32_t RASR_A3;
} MPU_Type;
# 1251 "./Source/CMSIS_core\\core_cm3.h" 3
typedef struct
{
  volatile uint32_t DHCSR;
  volatile uint32_t DCRSR;
  volatile uint32_t DCRDR;
  volatile uint32_t DEMCR;
} CoreDebug_Type;
# 1477 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void __NVIC_SetPriorityGrouping(uint32_t PriorityGroup)
{
  uint32_t reg_value;
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);

  reg_value = ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR;
  reg_value &= ~((uint32_t)((0xFFFFUL << 16U) | (7UL << 8U)));
  reg_value = (reg_value |
                ((uint32_t)0x5FAUL << 16U) |
                (PriorityGroupTmp << 8U) );
  ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR = reg_value;
}







static __inline uint32_t __NVIC_GetPriorityGrouping(void)
{
  return ((uint32_t)((((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR & (7UL << 8U)) >> 8U));
}
# 1508 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void __NVIC_EnableIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    __asm volatile("":::"memory");
    ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ISER[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
    __asm volatile("":::"memory");
  }
}
# 1527 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t __NVIC_GetEnableIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    return((uint32_t)(((((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ISER[(((uint32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
  }
  else
  {
    return(0U);
  }
}
# 1546 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void __NVIC_DisableIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ICER[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
    __builtin_arm_dsb(0xF);
    __builtin_arm_isb(0xF);
  }
}
# 1565 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t __NVIC_GetPendingIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    return((uint32_t)(((((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ISPR[(((uint32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
  }
  else
  {
    return(0U);
  }
}
# 1584 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void __NVIC_SetPendingIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ISPR[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
  }
}
# 1599 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void __NVIC_ClearPendingIRQ(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->ICPR[(((uint32_t)IRQn) >> 5UL)] = (uint32_t)(1UL << (((uint32_t)IRQn) & 0x1FUL));
  }
}
# 1616 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t __NVIC_GetActive(IRQn_Type IRQn)
{
  if ((int32_t)(IRQn) >= 0)
  {
    return((uint32_t)(((((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->IABR[(((uint32_t)IRQn) >> 5UL)] & (1UL << (((uint32_t)IRQn) & 0x1FUL))) != 0UL) ? 1UL : 0UL));
  }
  else
  {
    return(0U);
  }
}
# 1638 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void __NVIC_SetPriority(IRQn_Type IRQn, uint32_t priority)
{
  if ((int32_t)(IRQn) >= 0)
  {
    ((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->IP[((uint32_t)IRQn)] = (uint8_t)((priority << (8U - 5)) & (uint32_t)0xFFUL);
  }
  else
  {
    ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->SHP[(((uint32_t)IRQn) & 0xFUL)-4UL] = (uint8_t)((priority << (8U - 5)) & (uint32_t)0xFFUL);
  }
}
# 1660 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t __NVIC_GetPriority(IRQn_Type IRQn)
{

  if ((int32_t)(IRQn) >= 0)
  {
    return(((uint32_t)((NVIC_Type *) ((0xE000E000UL) + 0x0100UL) )->IP[((uint32_t)IRQn)] >> (8U - 5)));
  }
  else
  {
    return(((uint32_t)((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->SHP[(((uint32_t)IRQn) & 0xFUL)-4UL] >> (8U - 5)));
  }
}
# 1685 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t NVIC_EncodePriority (uint32_t PriorityGroup, uint32_t PreemptPriority, uint32_t SubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7UL - PriorityGroupTmp) > (uint32_t)(5)) ? (uint32_t)(5) : (uint32_t)(7UL - PriorityGroupTmp);
  SubPriorityBits = ((PriorityGroupTmp + (uint32_t)(5)) < (uint32_t)7UL) ? (uint32_t)0UL : (uint32_t)((PriorityGroupTmp - 7UL) + (uint32_t)(5));

  return (
           ((PreemptPriority & (uint32_t)((1UL << (PreemptPriorityBits)) - 1UL)) << SubPriorityBits) |
           ((SubPriority & (uint32_t)((1UL << (SubPriorityBits )) - 1UL)))
         );
}
# 1712 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void NVIC_DecodePriority (uint32_t Priority, uint32_t PriorityGroup, uint32_t* const pPreemptPriority, uint32_t* const pSubPriority)
{
  uint32_t PriorityGroupTmp = (PriorityGroup & (uint32_t)0x07UL);
  uint32_t PreemptPriorityBits;
  uint32_t SubPriorityBits;

  PreemptPriorityBits = ((7UL - PriorityGroupTmp) > (uint32_t)(5)) ? (uint32_t)(5) : (uint32_t)(7UL - PriorityGroupTmp);
  SubPriorityBits = ((PriorityGroupTmp + (uint32_t)(5)) < (uint32_t)7UL) ? (uint32_t)0UL : (uint32_t)((PriorityGroupTmp - 7UL) + (uint32_t)(5));

  *pPreemptPriority = (Priority >> SubPriorityBits) & (uint32_t)((1UL << (PreemptPriorityBits)) - 1UL);
  *pSubPriority = (Priority ) & (uint32_t)((1UL << (SubPriorityBits )) - 1UL);
}
# 1735 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline void __NVIC_SetVector(IRQn_Type IRQn, uint32_t vector)
{
  uint32_t *vectors = (uint32_t *)((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->VTOR;
  vectors[(int32_t)IRQn + 16] = vector;

}
# 1751 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t __NVIC_GetVector(IRQn_Type IRQn)
{
  uint32_t *vectors = (uint32_t *)((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->VTOR;
  return vectors[(int32_t)IRQn + 16];
}






__attribute__((__noreturn__)) static __inline void __NVIC_SystemReset(void)
{
  __builtin_arm_dsb(0xF);

  ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR = (uint32_t)((0x5FAUL << 16U) |
                           (((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->AIRCR & (7UL << 8U)) |
                            (1UL << 2U) );
  __builtin_arm_dsb(0xF);

  for(;;)
  {
    __builtin_arm_nop();
  }
}
# 1784 "./Source/CMSIS_core\\core_cm3.h" 3
# 1 "./Source/CMSIS_core\\mpu_armv7.h" 1 3
# 29 "./Source/CMSIS_core\\mpu_armv7.h" 3
# 183 "./Source/CMSIS_core\\mpu_armv7.h" 3
typedef struct {
  uint32_t RBAR; //!< The region base address register value (RBAR)
  uint32_t RASR; //!< The region attribute and size register value (RASR) \ref MPU_RASR
} ARM_MPU_Region_t;




static __inline void ARM_MPU_Enable(uint32_t MPU_Control)
{
  __builtin_arm_dmb(0xF);
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->CTRL = MPU_Control | (1UL );

  ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->SHCSR |= (1UL << 16U);

  __builtin_arm_dsb(0xF);
  __builtin_arm_isb(0xF);
}



static __inline void ARM_MPU_Disable(void)
{
  __builtin_arm_dmb(0xF);

  ((SCB_Type *) ((0xE000E000UL) + 0x0D00UL) )->SHCSR &= ~(1UL << 16U);

  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->CTRL &= ~(1UL );
  __builtin_arm_dsb(0xF);
  __builtin_arm_isb(0xF);
}




static __inline void ARM_MPU_ClrRegion(uint32_t rnr)
{
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RNR = rnr;
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RASR = 0U;
}





static __inline void ARM_MPU_SetRegion(uint32_t rbar, uint32_t rasr)
{
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RBAR = rbar;
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RASR = rasr;
}






static __inline void ARM_MPU_SetRegionEx(uint32_t rnr, uint32_t rbar, uint32_t rasr)
{
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RNR = rnr;
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RBAR = rbar;
  ((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RASR = rasr;
}






static __inline void ARM_MPU_OrderedMemcpy(volatile uint32_t* dst, const uint32_t* __restrict src, uint32_t len)
{
  uint32_t i;
  for (i = 0U; i < len; ++i)
  {
    dst[i] = src[i];
  }
}





static __inline void ARM_MPU_Load(ARM_MPU_Region_t const* table, uint32_t cnt)
{
  const uint32_t rowWordSize = sizeof(ARM_MPU_Region_t)/4U;
  while (cnt > 4U) {
    ARM_MPU_OrderedMemcpy(&(((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RBAR), &(table->RBAR), 4U*rowWordSize);
    table += 4U;
    cnt -= 4U;
  }
  ARM_MPU_OrderedMemcpy(&(((MPU_Type *) ((0xE000E000UL) + 0x0D90UL) )->RBAR), &(table->RBAR), cnt*rowWordSize);
}
# 1785 "./Source/CMSIS_core\\core_cm3.h" 2 3
# 1805 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t SCB_GetFPUType(void)
{
    return 0U;
}
# 1836 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t SysTick_Config(uint32_t ticks)
{
  if ((ticks - 1UL) > (0xFFFFFFUL ))
  {
    return (1UL);
  }

  ((SysTick_Type *) ((0xE000E000UL) + 0x0010UL) )->LOAD = (uint32_t)(ticks - 1UL);
  __NVIC_SetPriority (SysTick_IRQn, (1UL << 5) - 1UL);
  ((SysTick_Type *) ((0xE000E000UL) + 0x0010UL) )->VAL = 0UL;
  ((SysTick_Type *) ((0xE000E000UL) + 0x0010UL) )->CTRL = (1UL << 2U) |
                   (1UL << 1U) |
                   (1UL );
  return (0UL);
}
# 1866 "./Source/CMSIS_core\\core_cm3.h" 3
extern volatile int32_t ITM_RxBuffer;
# 1878 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline uint32_t ITM_SendChar (uint32_t ch)
{
  if (((((ITM_Type *) (0xE0000000UL) )->TCR & (1UL )) != 0UL) &&
      ((((ITM_Type *) (0xE0000000UL) )->TER & 1UL ) != 0UL) )
  {
    while (((ITM_Type *) (0xE0000000UL) )->PORT[0U].u32 == 0UL)
    {
      __builtin_arm_nop();
    }
    ((ITM_Type *) (0xE0000000UL) )->PORT[0U].u8 = (uint8_t)ch;
  }
  return (ch);
}
# 1899 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline int32_t ITM_ReceiveChar (void)
{
  int32_t ch = -1;

  if (ITM_RxBuffer != ((int32_t)0x5AA55AA5U))
  {
    ch = ITM_RxBuffer;
    ITM_RxBuffer = ((int32_t)0x5AA55AA5U);
  }

  return (ch);
}
# 1919 "./Source/CMSIS_core\\core_cm3.h" 3
static __inline int32_t ITM_CheckChar (void)
{

  if (ITM_RxBuffer == ((int32_t)0x5AA55AA5U))
  {
    return (0);
  }
  else
  {
    return (1);
  }
}
# 107 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\LPC17xx.h" 2
# 1 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\system_LPC17xx.h" 1
# 49 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\system_LPC17xx.h"
extern uint32_t SystemCoreClock;






extern void SystemInit (void);







extern void SystemCoreClockUpdate (void);
# 108 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\LPC17xx.h" 2
# 120 "C:/Users/aproi/AppData/Local/Arm/Packs/Keil/LPC1700_DFP/2.7.2/Device/Include\\LPC17xx.h"
typedef struct
{
  volatile uint32_t FLASHCFG;
       uint32_t RESERVED0[31];
  volatile uint32_t PLL0CON;
  volatile uint32_t PLL0CFG;
  volatile const uint32_t PLL0STAT;
  volatile uint32_t PLL0FEED;
       uint32_t RESERVED1[4];
  volatile uint32_t PLL1CON;
  volatile uint32_t PLL1CFG;
  volatile const uint32_t PLL1STAT;
  volatile uint32_t PLL1FEED;
       uint32_t RESERVED2[4];
  volatile uint32_t PCON;
  volatile uint32_t PCONP;
       uint32_t RESERVED3[15];
  volatile uint32_t CCLKCFG;
  volatile uint32_t USBCLKCFG;
  volatile uint32_t CLKSRCSEL;
  volatile uint32_t CANSLEEPCLR;
  volatile uint32_t CANWAKEFLAGS;
       uint32_t RESERVED4[10];
  volatile uint32_t EXTINT;
       uint32_t RESERVED5;
  volatile uint32_t EXTMODE;
  volatile uint32_t EXTPOLAR;
       uint32_t RESERVED6[12];
  volatile uint32_t RSID;
       uint32_t RESERVED7[7];
  volatile uint32_t SCS;
  volatile uint32_t IRCTRIM;
  volatile uint32_t PCLKSEL0;
  volatile uint32_t PCLKSEL1;
       uint32_t RESERVED8[4];
  volatile uint32_t USBIntSt;
  volatile uint32_t DMAREQSEL;
  volatile uint32_t CLKOUTCFG;
 } LPC_SC_TypeDef;



typedef struct
{
  volatile uint32_t PINSEL0;
  volatile uint32_t PINSEL1;
  volatile uint32_t PINSEL2;
  volatile uint32_t PINSEL3;
  volatile uint32_t PINSEL4;
  volatile uint32_t PINSEL5;
  volatile uint32_t PINSEL6;
  volatile uint32_t PINSEL7;
  volatile uint32_t PINSEL8;
  volatile uint32_t PINSEL9;
  volatile uint32_t PINSEL10;
       uint32_t RESERVED0[5];
  volatile uint32_t PINMODE0;
  volatile uint32_t PINMODE1;
  volatile uint32_t PINMODE2;
  volatile uint32_t PINMODE3;
  volatile uint32_t PINMODE4;
  volatile uint32_t PINMODE5;
  volatile uint32_t PINMODE6;
  volatile uint32_t PINMODE7;
  volatile uint32_t PINMODE8;
  volatile uint32_t PINMODE9;
  volatile uint32_t PINMODE_OD0;
  volatile uint32_t PINMODE_OD1;
  volatile uint32_t PINMODE_OD2;
  volatile uint32_t PINMODE_OD3;
  volatile uint32_t PINMODE_OD4;
  volatile uint32_t I2CPADCFG;
} LPC_PINCON_TypeDef;



typedef struct
{
  union {
    volatile uint32_t FIODIR;
    struct {
      volatile uint16_t FIODIRL;
      volatile uint16_t FIODIRH;
    };
    struct {
      volatile uint8_t FIODIR0;
      volatile uint8_t FIODIR1;
      volatile uint8_t FIODIR2;
      volatile uint8_t FIODIR3;
    };
  };
  uint32_t RESERVED0[3];
  union {
    volatile uint32_t FIOMASK;
    struct {
      volatile uint16_t FIOMASKL;
      volatile uint16_t FIOMASKH;
    };
    struct {
      volatile uint8_t FIOMASK0;
      volatile uint8_t FIOMASK1;
      volatile uint8_t FIOMASK2;
      volatile uint8_t FIOMASK3;
    };
  };
  union {
    volatile uint32_t FIOPIN;
    struct {
      volatile uint16_t FIOPINL;
      volatile uint16_t FIOPINH;
    };
    struct {
      volatile uint8_t FIOPIN0;
      volatile uint8_t FIOPIN1;
      volatile uint8_t FIOPIN2;
      volatile uint8_t FIOPIN3;
    };
  };
  union {
    volatile uint32_t FIOSET;
    struct {
      volatile uint16_t FIOSETL;
      volatile uint16_t FIOSETH;
    };
    struct {
      volatile uint8_t FIOSET0;
      volatile uint8_t FIOSET1;
      volatile uint8_t FIOSET2;
      volatile uint8_t FIOSET3;
    };
  };
  union {
    volatile uint32_t FIOCLR;
    struct {
      volatile uint16_t FIOCLRL;
      volatile uint16_t FIOCLRH;
    };
    struct {
      volatile uint8_t FIOCLR0;
      volatile uint8_t FIOCLR1;
      volatile uint8_t FIOCLR2;
      volatile uint8_t FIOCLR3;
    };
  };
} LPC_GPIO_TypeDef;


typedef struct
{
  volatile const uint32_t IntStatus;
  volatile const uint32_t IO0IntStatR;
  volatile const uint32_t IO0IntStatF;
  volatile uint32_t IO0IntClr;
  volatile uint32_t IO0IntEnR;
  volatile uint32_t IO0IntEnF;
       uint32_t RESERVED0[3];
  volatile const uint32_t IO2IntStatR;
  volatile const uint32_t IO2IntStatF;
  volatile uint32_t IO2IntClr;
  volatile uint32_t IO2IntEnR;
  volatile uint32_t IO2IntEnF;
} LPC_GPIOINT_TypeDef;



typedef struct
{
  volatile uint32_t IR;
  volatile uint32_t TCR;
  volatile uint32_t TC;
  volatile uint32_t PR;
  volatile uint32_t PC;
  volatile uint32_t MCR;
  volatile uint32_t MR0;
  volatile uint32_t MR1;
  volatile uint32_t MR2;
  volatile uint32_t MR3;
  volatile uint32_t CCR;
  volatile const uint32_t CR0;
  volatile const uint32_t CR1;
       uint32_t RESERVED0[2];
  volatile uint32_t EMR;
       uint32_t RESERVED1[12];
  volatile uint32_t CTCR;
} LPC_TIM_TypeDef;



typedef struct
{
  volatile uint32_t IR;
  volatile uint32_t TCR;
  volatile uint32_t TC;
  volatile uint32_t PR;
  volatile uint32_t PC;
  volatile uint32_t MCR;
  volatile uint32_t MR0;
  volatile uint32_t MR1;
  volatile uint32_t MR2;
  volatile uint32_t MR3;
  volatile uint32_t CCR;
  volatile const uint32_t CR0;
  volatile const uint32_t CR1;
  volatile const uint32_t CR2;
  volatile const uint32_t CR3;
       uint32_t RESERVED0;
  volatile uint32_t MR4;
  volatile uint32_t MR5;
  volatile uint32_t MR6;
  volatile uint32_t PCR;
  volatile uint32_t LER;
       uint32_t RESERVED1[7];
  volatile uint32_t CTCR;
} LPC_PWM_TypeDef;



typedef struct
{
  union {
  volatile const uint8_t RBR;
  volatile uint8_t THR;
  volatile uint8_t DLL;
       uint32_t RESERVED0;
  };
  union {
  volatile uint8_t DLM;
  volatile uint32_t IER;
  };
  union {
  volatile const uint32_t IIR;
  volatile uint8_t FCR;
  };
  volatile uint8_t LCR;
       uint8_t RESERVED1[7];
  volatile const uint8_t LSR;
       uint8_t RESERVED2[7];
  volatile uint8_t SCR;
       uint8_t RESERVED3[3];
  volatile uint32_t ACR;
  volatile uint8_t ICR;
       uint8_t RESERVED4[3];
  volatile uint8_t FDR;
       uint8_t RESERVED5[7];
  volatile uint8_t TER;
       uint8_t RESERVED6[3];
} LPC_UART_TypeDef;


typedef struct
{
  union {
  volatile const uint8_t RBR;
  volatile uint8_t THR;
  volatile uint8_t DLL;
       uint32_t RESERVED0;
  };
  union {
  volatile uint8_t DLM;
       uint8_t RESERVED1[3];
  volatile uint32_t IER;
  };
  union {
  volatile const uint32_t IIR;
  volatile uint8_t FCR;
  };
  volatile uint8_t LCR;
       uint8_t RESERVED2[3];
  volatile uint8_t MCR;
       uint8_t RESERVED3[3];
  volatile const uint8_t LSR;
       uint8_t RESERVED4[3];
  volatile const uint8_t MSR;
       uint8_t RESERVED5[3];
  volatile uint8_t SCR;
       uint8_t RESERVED6[3];
  volatile uint32_t ACR;
       uint32_t RESERVED7;
  volatile uint32_t FDR;
       uint32_t RESERVED8;
  volatile uint8_t TER;
       uint8_t RESERVED9[27];
  volatile uint8_t RS485CTRL;
       uint8_t RESERVED10[3];
  volatile uint8_t ADRMATCH;
       uint8_t RESERVED11[3];
  volatile uint8_t RS485DLY;
       uint8_t RESERVED12[3];
} LPC_UART1_TypeDef;



typedef struct
{
  volatile uint32_t SPCR;
  volatile const uint32_t SPSR;
  volatile uint32_t SPDR;
  volatile uint32_t SPCCR;
       uint32_t RESERVED0[3];
  volatile uint32_t SPINT;
} LPC_SPI_TypeDef;



typedef struct
{
  volatile uint32_t CR0;
  volatile uint32_t CR1;
  volatile uint32_t DR;
  volatile const uint32_t SR;
  volatile uint32_t CPSR;
  volatile uint32_t IMSC;
  volatile uint32_t RIS;
  volatile uint32_t MIS;
  volatile uint32_t ICR;
  volatile uint32_t DMACR;
} LPC_SSP_TypeDef;



typedef struct
{
  volatile uint32_t I2CONSET;
  volatile const uint32_t I2STAT;
  volatile uint32_t I2DAT;
  volatile uint32_t I2ADR0;
  volatile uint32_t I2SCLH;
  volatile uint32_t I2SCLL;
  volatile uint32_t I2CONCLR;
  volatile uint32_t MMCTRL;
  volatile uint32_t I2ADR1;
  volatile uint32_t I2ADR2;
  volatile uint32_t I2ADR3;
  volatile const uint32_t I2DATA_BUFFER;
  volatile uint32_t I2MASK0;
  volatile uint32_t I2MASK1;
  volatile uint32_t I2MASK2;
  volatile uint32_t I2MASK3;
} LPC_I2C_TypeDef;



typedef struct
{
  volatile uint32_t I2SDAO;
  volatile uint32_t I2SDAI;
  volatile uint32_t I2STXFIFO;
  volatile const uint32_t I2SRXFIFO;
  volatile const uint32_t I2SSTATE;
  volatile uint32_t I2SDMA1;
  volatile uint32_t I2SDMA2;
  volatile uint32_t I2SIRQ;
  volatile uint32_t I2STXRATE;
  volatile uint32_t I2SRXRATE;
  volatile uint32_t I2STXBITRATE;
  volatile uint32_t I2SRXBITRATE;
  volatile uint32_t I2STXMODE;
  volatile uint32_t I2SRXMODE;
} LPC_I2S_TypeDef;



typedef struct
{
  volatile uint32_t RICOMPVAL;
  volatile uint32_t RIMASK;
  volatile uint8_t RICTRL;
       uint8_t RESERVED0[3];
  volatile uint32_t RICOUNTER;
} LPC_RIT_TypeDef;



typedef struct
{
  volatile uint8_t ILR;
       uint8_t RESERVED0[7];
  volatile uint8_t CCR;
       uint8_t RESERVED1[3];
  volatile uint8_t CIIR;
       uint8_t RESERVED2[3];
  volatile uint8_t AMR;
       uint8_t RESERVED3[3];
  volatile const uint32_t CTIME0;
  volatile const uint32_t CTIME1;
  volatile const uint32_t CTIME2;
  volatile uint8_t SEC;
       uint8_t RESERVED4[3];
  volatile uint8_t MIN;
       uint8_t RESERVED5[3];
  volatile uint8_t HOUR;
       uint8_t RESERVED6[3];
  volatile uint8_t DOM;
       uint8_t RESERVED7[3];
  volatile uint8_t DOW;
       uint8_t RESERVED8[3];
  volatile uint16_t DOY;
       uint16_t RESERVED9;
  volatile uint8_t MONTH;
       uint8_t RESERVED10[3];
  volatile uint16_t YEAR;
       uint16_t RESERVED11;
  volatile uint32_t CALIBRATION;
  volatile uint32_t GPREG0;
  volatile uint32_t GPREG1;
  volatile uint32_t GPREG2;
  volatile uint32_t GPREG3;
  volatile uint32_t GPREG4;
  volatile uint8_t RTC_AUXEN;
       uint8_t RESERVED12[3];
  volatile uint8_t RTC_AUX;
       uint8_t RESERVED13[3];
  volatile uint8_t ALSEC;
       uint8_t RESERVED14[3];
  volatile uint8_t ALMIN;
       uint8_t RESERVED15[3];
  volatile uint8_t ALHOUR;
       uint8_t RESERVED16[3];
  volatile uint8_t ALDOM;
       uint8_t RESERVED17[3];
  volatile uint8_t ALDOW;
       uint8_t RESERVED18[3];
  volatile uint16_t ALDOY;
       uint16_t RESERVED19;
  volatile uint8_t ALMON;
       uint8_t RESERVED20[3];
  volatile uint16_t ALYEAR;
       uint16_t RESERVED21;
} LPC_RTC_TypeDef;



typedef struct
{
  volatile uint8_t WDMOD;
       uint8_t RESERVED0[3];
  volatile uint32_t WDTC;
  volatile uint8_t WDFEED;
       uint8_t RESERVED1[3];
  volatile const uint32_t WDTV;
  volatile uint32_t WDCLKSEL;
} LPC_WDT_TypeDef;



typedef struct
{
  volatile uint32_t ADCR;
  volatile uint32_t ADGDR;
       uint32_t RESERVED0;
  volatile uint32_t ADINTEN;
  volatile const uint32_t ADDR0;
  volatile const uint32_t ADDR1;
  volatile const uint32_t ADDR2;
  volatile const uint32_t ADDR3;
  volatile const uint32_t ADDR4;
  volatile const uint32_t ADDR5;
  volatile const uint32_t ADDR6;
  volatile const uint32_t ADDR7;
  volatile const uint32_t ADSTAT;
  volatile uint32_t ADTRM;
} LPC_ADC_TypeDef;



typedef struct
{
  volatile uint32_t DACR;
  volatile uint32_t DACCTRL;
  volatile uint16_t DACCNTVAL;
       uint16_t RESERVED;
} LPC_DAC_TypeDef;



typedef struct
{
  volatile const uint32_t MCCON;
  volatile uint32_t MCCON_SET;
  volatile uint32_t MCCON_CLR;
  volatile const uint32_t MCCAPCON;
  volatile uint32_t MCCAPCON_SET;
  volatile uint32_t MCCAPCON_CLR;
  volatile uint32_t MCTIM0;
  volatile uint32_t MCTIM1;
  volatile uint32_t MCTIM2;
  volatile uint32_t MCPER0;
  volatile uint32_t MCPER1;
  volatile uint32_t MCPER2;
  volatile uint32_t MCPW0;
  volatile uint32_t MCPW1;
  volatile uint32_t MCPW2;
  volatile uint32_t MCDEADTIME;
  volatile uint32_t MCCCP;
  volatile uint32_t MCCR0;
  volatile uint32_t MCCR1;
  volatile uint32_t MCCR2;
  volatile const uint32_t MCINTEN;
  volatile uint32_t MCINTEN_SET;
  volatile uint32_t MCINTEN_CLR;
  volatile const uint32_t MCCNTCON;
  volatile uint32_t MCCNTCON_SET;
  volatile uint32_t MCCNTCON_CLR;
  volatile const uint32_t MCINTFLAG;
  volatile uint32_t MCINTFLAG_SET;
  volatile uint32_t MCINTFLAG_CLR;
  volatile uint32_t MCCAP_CLR;
} LPC_MCPWM_TypeDef;



typedef struct
{
  volatile uint32_t QEICON;
  volatile const uint32_t QEISTAT;
  volatile uint32_t QEICONF;
  volatile const uint32_t QEIPOS;
  volatile uint32_t QEIMAXPOS;
  volatile uint32_t CMPOS0;
  volatile uint32_t CMPOS1;
  volatile uint32_t CMPOS2;
  volatile const uint32_t INXCNT;
  volatile uint32_t INXCMP;
  volatile uint32_t QEILOAD;
  volatile const uint32_t QEITIME;
  volatile const uint32_t QEIVEL;
  volatile const uint32_t QEICAP;
  volatile uint32_t VELCOMP;
  volatile uint32_t FILTER;
       uint32_t RESERVED0[998];
  volatile uint32_t QEIIEC;
  volatile uint32_t QEIIES;
  volatile const uint32_t QEIINTSTAT;
  volatile const uint32_t QEIIE;
  volatile uint32_t QEICLR;
  volatile uint32_t QEISET;
} LPC_QEI_TypeDef;



typedef struct
{
  volatile uint32_t mask[512];
} LPC_CANAF_RAM_TypeDef;


typedef struct
{
  volatile uint32_t AFMR;
  volatile uint32_t SFF_sa;
  volatile uint32_t SFF_GRP_sa;
  volatile uint32_t EFF_sa;
  volatile uint32_t EFF_GRP_sa;
  volatile uint32_t ENDofTable;
  volatile const uint32_t LUTerrAd;
  volatile const uint32_t LUTerr;
  volatile uint32_t FCANIE;
  volatile uint32_t FCANIC0;
  volatile uint32_t FCANIC1;
} LPC_CANAF_TypeDef;


typedef struct
{
  volatile const uint32_t CANTxSR;
  volatile const uint32_t CANRxSR;
  volatile const uint32_t CANMSR;
} LPC_CANCR_TypeDef;


typedef struct
{
  volatile uint32_t MOD;
  volatile uint32_t CMR;
  volatile uint32_t GSR;
  volatile const uint32_t ICR;
  volatile uint32_t IER;
  volatile uint32_t BTR;
  volatile uint32_t EWL;
  volatile const uint32_t SR;
  volatile uint32_t RFS;
  volatile uint32_t RID;
  volatile uint32_t RDA;
  volatile uint32_t RDB;
  volatile uint32_t TFI1;
  volatile uint32_t TID1;
  volatile uint32_t TDA1;
  volatile uint32_t TDB1;
  volatile uint32_t TFI2;
  volatile uint32_t TID2;
  volatile uint32_t TDA2;
  volatile uint32_t TDB2;
  volatile uint32_t TFI3;
  volatile uint32_t TID3;
  volatile uint32_t TDA3;
  volatile uint32_t TDB3;
} LPC_CAN_TypeDef;



typedef struct
{
  volatile const uint32_t DMACIntStat;
  volatile const uint32_t DMACIntTCStat;
  volatile uint32_t DMACIntTCClear;
  volatile const uint32_t DMACIntErrStat;
  volatile uint32_t DMACIntErrClr;
  volatile const uint32_t DMACRawIntTCStat;
  volatile const uint32_t DMACRawIntErrStat;
  volatile const uint32_t DMACEnbldChns;
  volatile uint32_t DMACSoftBReq;
  volatile uint32_t DMACSoftSReq;
  volatile uint32_t DMACSoftLBReq;
  volatile uint32_t DMACSoftLSReq;
  volatile uint32_t DMACConfig;
  volatile uint32_t DMACSync;
} LPC_GPDMA_TypeDef;


typedef struct
{
  volatile uint32_t DMACCSrcAddr;
  volatile uint32_t DMACCDestAddr;
  volatile uint32_t DMACCLLI;
  volatile uint32_t DMACCControl;
  volatile uint32_t DMACCConfig;
} LPC_GPDMACH_TypeDef;



typedef struct
{
  volatile const uint32_t HcRevision;
  volatile uint32_t HcControl;
  volatile uint32_t HcCommandStatus;
  volatile uint32_t HcInterruptStatus;
  volatile uint32_t HcInterruptEnable;
  volatile uint32_t HcInterruptDisable;
  volatile uint32_t HcHCCA;
  volatile const uint32_t HcPeriodCurrentED;
  volatile uint32_t HcControlHeadED;
  volatile uint32_t HcControlCurrentED;
  volatile uint32_t HcBulkHeadED;
  volatile uint32_t HcBulkCurrentED;
  volatile const uint32_t HcDoneHead;
  volatile uint32_t HcFmInterval;
  volatile const uint32_t HcFmRemaining;
  volatile const uint32_t HcFmNumber;
  volatile uint32_t HcPeriodicStart;
  volatile uint32_t HcLSTreshold;
  volatile uint32_t HcRhDescriptorA;
  volatile uint32_t HcRhDescriptorB;
  volatile uint32_t HcRhStatus;
  volatile uint32_t HcRhPortStatus1;
  volatile uint32_t HcRhPortStatus2;
       uint32_t RESERVED0[40];
  volatile const uint32_t Module_ID;

  volatile const uint32_t OTGIntSt;
  volatile uint32_t OTGIntEn;
  volatile uint32_t OTGIntSet;
  volatile uint32_t OTGIntClr;
  volatile uint32_t OTGStCtrl;
  volatile uint32_t OTGTmr;
       uint32_t RESERVED1[58];

  volatile const uint32_t USBDevIntSt;
  volatile uint32_t USBDevIntEn;
  volatile uint32_t USBDevIntClr;
  volatile uint32_t USBDevIntSet;

  volatile uint32_t USBCmdCode;
  volatile const uint32_t USBCmdData;

  volatile const uint32_t USBRxData;
  volatile uint32_t USBTxData;
  volatile const uint32_t USBRxPLen;
  volatile uint32_t USBTxPLen;
  volatile uint32_t USBCtrl;
  volatile uint32_t USBDevIntPri;

  volatile const uint32_t USBEpIntSt;
  volatile uint32_t USBEpIntEn;
  volatile uint32_t USBEpIntClr;
  volatile uint32_t USBEpIntSet;
  volatile uint32_t USBEpIntPri;

  volatile uint32_t USBReEp;
  volatile uint32_t USBEpInd;
  volatile uint32_t USBMaxPSize;

  volatile const uint32_t USBDMARSt;
  volatile uint32_t USBDMARClr;
  volatile uint32_t USBDMARSet;
       uint32_t RESERVED2[9];
  volatile uint32_t USBUDCAH;
  volatile const uint32_t USBEpDMASt;
  volatile uint32_t USBEpDMAEn;
  volatile uint32_t USBEpDMADis;
  volatile const uint32_t USBDMAIntSt;
  volatile uint32_t USBDMAIntEn;
       uint32_t RESERVED3[2];
  volatile const uint32_t USBEoTIntSt;
  volatile uint32_t USBEoTIntClr;
  volatile uint32_t USBEoTIntSet;
  volatile const uint32_t USBNDDRIntSt;
  volatile uint32_t USBNDDRIntClr;
  volatile uint32_t USBNDDRIntSet;
  volatile const uint32_t USBSysErrIntSt;
  volatile uint32_t USBSysErrIntClr;
  volatile uint32_t USBSysErrIntSet;
       uint32_t RESERVED4[15];

  union {
  volatile const uint32_t I2C_RX;
  volatile uint32_t I2C_TX;
  };
  volatile const uint32_t I2C_STS;
  volatile uint32_t I2C_CTL;
  volatile uint32_t I2C_CLKHI;
  volatile uint32_t I2C_CLKLO;
       uint32_t RESERVED5[824];

  union {
  volatile uint32_t USBClkCtrl;
  volatile uint32_t OTGClkCtrl;
  };
  union {
  volatile const uint32_t USBClkSt;
  volatile const uint32_t OTGClkSt;
  };
} LPC_USB_TypeDef;



typedef struct
{
  volatile uint32_t MAC1;
  volatile uint32_t MAC2;
  volatile uint32_t IPGT;
  volatile uint32_t IPGR;
  volatile uint32_t CLRT;
  volatile uint32_t MAXF;
  volatile uint32_t SUPP;
  volatile uint32_t TEST;
  volatile uint32_t MCFG;
  volatile uint32_t MCMD;
  volatile uint32_t MADR;
  volatile uint32_t MWTD;
  volatile const uint32_t MRDD;
  volatile const uint32_t MIND;
       uint32_t RESERVED0[2];
  volatile uint32_t SA0;
  volatile uint32_t SA1;
  volatile uint32_t SA2;
       uint32_t RESERVED1[45];
  volatile uint32_t Command;
  volatile const uint32_t Status;
  volatile uint32_t RxDescriptor;
  volatile uint32_t RxStatus;
  volatile uint32_t RxDescriptorNumber;
  volatile const uint32_t RxProduceIndex;
  volatile uint32_t RxConsumeIndex;
  volatile uint32_t TxDescriptor;
  volatile uint32_t TxStatus;
  volatile uint32_t TxDescriptorNumber;
  volatile uint32_t TxProduceIndex;
  volatile const uint32_t TxConsumeIndex;
       uint32_t RESERVED2[10];
  volatile const uint32_t TSV0;
  volatile const uint32_t TSV1;
  volatile const uint32_t RSV;
       uint32_t RESERVED3[3];
  volatile uint32_t FlowControlCounter;
  volatile const uint32_t FlowControlStatus;
       uint32_t RESERVED4[34];
  volatile uint32_t RxFilterCtrl;
  volatile uint32_t RxFilterWoLStatus;
  volatile uint32_t RxFilterWoLClear;
       uint32_t RESERVED5;
  volatile uint32_t HashFilterL;
  volatile uint32_t HashFilterH;
       uint32_t RESERVED6[882];
  volatile const uint32_t IntStatus;
  volatile uint32_t IntEnable;
  volatile uint32_t IntClear;
  volatile uint32_t IntSet;
       uint32_t RESERVED7;
  volatile uint32_t PowerDown;
       uint32_t RESERVED8;
  volatile uint32_t Module_ID;
} LPC_EMAC_TypeDef;
# 27 "Source\\GLCD/GLCD.h" 2
# 90 "Source\\GLCD/GLCD.h"
void LCD_Initialization(void);
void LCD_Clear(uint16_t Color);
uint16_t LCD_GetPoint(uint16_t Xpos,uint16_t Ypos);
void LCD_SetPoint(uint16_t Xpos,uint16_t Ypos,uint16_t point);
void LCD_DrawLine( uint16_t x0, uint16_t y0, uint16_t x1, uint16_t y1 , uint16_t color );
void PutChar( uint16_t Xpos, uint16_t Ypos, uint8_t ASCI, uint16_t charColor, uint16_t bkColor );
void GUI_Text(uint16_t Xpos, uint16_t Ypos, uint8_t *str,uint16_t Color, uint16_t bkColor);
# 6 "Source\\game.h" 2


// Modifica questi valori per testare rapidamente
# 24 "Source\\game.h"
typedef enum {
    GAME_OVER,
    GAME_RUNNING,
    GAME_PAUSED
} GameStatus;

// Nuovo Enum per i PowerUp
typedef enum {
    POWER_NONE = 0,
    POWER_CLEAR, // Identificato dalla lettera 'C'
    POWER_SLOW // Identificato dalla lettera 'S'
} PowerUpType;

typedef enum {
    I_BLOCK, J_BLOCK, L_BLOCK, O_BLOCK, S_BLOCK, T_BLOCK, Z_BLOCK
} BlockType;
# 54 "Source\\game.h"
typedef struct {
    int row;
    int col;
} Point;

typedef struct {
    Point cells[4];
    Point position;
    uint16_t color;
    BlockType type;
    int rotation;
} Block;


extern uint16_t board[20][10];
// Nuova matrice parallela per tracciare dove sono i powerup
extern uint8_t board_powers[20][10];

extern Block currentBlock;
extern Block nextBlock;
extern volatile GameStatus status;
extern volatile int hard_drop_mode;
extern int score;

// Contatori per la logica extrapoints
extern int total_lines_cleared;


void game_init(void);
void game_update(void);
// Aggiungeremo queste funzioni dopo, per ora le dichiaro
void apply_powerup(PowerUpType type, int row);
void spawn_random_powerup(void);
void apply_malus(void);
# 2 "Source/game.c" 2

# 1 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 1 3
# 71 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
    typedef unsigned int size_t;
# 91 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
    typedef unsigned short wchar_t;




typedef struct div_t { int quot, rem; } div_t;

typedef struct ldiv_t { long int quot, rem; } ldiv_t;
# 139 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) int __aeabi_MB_CUR_MAX(void);
# 158 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) double atof(const char * ) __attribute__((__nonnull__(1)));





extern __attribute__((__nothrow__)) int atoi(const char * ) __attribute__((__nonnull__(1)));





extern __attribute__((__nothrow__)) long int atol(const char * ) __attribute__((__nonnull__(1)));
# 185 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) double strtod(const char * __restrict , char ** __restrict ) __attribute__((__nonnull__(1)));
# 212 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) long int strtol(const char * __restrict ,
                        char ** __restrict , int ) __attribute__((__nonnull__(1)));
# 243 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) unsigned long int strtoul(const char * __restrict ,
                                       char ** __restrict , int ) __attribute__((__nonnull__(1)));
# 275 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) long long strtoll(const char * __restrict ,
                                  char ** __restrict , int )
                          __attribute__((__nonnull__(1)));






extern __attribute__((__nothrow__)) unsigned long long strtoull(const char * __restrict ,
                                            char ** __restrict , int )
                                   __attribute__((__nonnull__(1)));






extern __attribute__((__nothrow__)) int rand(void);
# 303 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) void srand(unsigned int );
# 313 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
struct _rand_state { int __x[57]; };
extern __attribute__((__nothrow__)) int _rand_r(struct _rand_state *);
extern __attribute__((__nothrow__)) void _srand_r(struct _rand_state *, unsigned int);
struct _ANSI_rand_state { int __x[1]; };
extern __attribute__((__nothrow__)) int _ANSI_rand_r(struct _ANSI_rand_state *);
extern __attribute__((__nothrow__)) void _ANSI_srand_r(struct _ANSI_rand_state *, unsigned int);





extern __attribute__((__nothrow__)) void *calloc(size_t , size_t );





extern __attribute__((__nothrow__)) void free(void * );







extern __attribute__((__nothrow__)) void *malloc(size_t );





extern __attribute__((__nothrow__)) void *realloc(void * , size_t );
# 374 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
typedef int (*__heapprt)(void *, char const *, ...);
extern __attribute__((__nothrow__)) void __heapstats(int (* )(void * ,
                                           char const * , ...),
                        void * ) __attribute__((__nonnull__(1)));
# 390 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) int __heapvalid(int (* )(void * ,
                                           char const * , ...),
                       void * , int ) __attribute__((__nonnull__(1)));
# 411 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) __attribute__((__noreturn__)) void abort(void);
# 422 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) int atexit(void (* )(void)) __attribute__((__nonnull__(1)));
# 444 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) __attribute__((__noreturn__)) void exit(int );
# 460 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) __attribute__((__noreturn__)) void _Exit(int );
# 471 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) char *getenv(const char * ) __attribute__((__nonnull__(1)));
# 484 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) int system(const char * );
# 497 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern void *bsearch(const void * , const void * ,
              size_t , size_t ,
              int (* )(const void *, const void *)) __attribute__((__nonnull__(1,2,5)));
# 532 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern void qsort(void * , size_t , size_t ,
           int (* )(const void *, const void *)) __attribute__((__nonnull__(1,4)));
# 560 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) __attribute__((__const__)) int abs(int );






extern __attribute__((__nothrow__)) __attribute__((__const__)) div_t div(int , int );
# 579 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) __attribute__((__const__)) long int labs(long int );
# 589 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) __attribute__((__const__)) ldiv_t ldiv(long int , long int );
# 644 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
typedef struct __sdiv32by16 { long quot, rem; } __sdiv32by16;
typedef struct __udiv32by16 { unsigned long quot, rem; } __udiv32by16;

typedef struct __sdiv64by32 { long rem, quot; } __sdiv64by32;

__attribute__((__value_in_regs__)) extern __attribute__((__nothrow__)) __attribute__((__const__)) __sdiv32by16 __rt_sdiv32by16(
     int ,
     short int );



__attribute__((__value_in_regs__)) extern __attribute__((__nothrow__)) __attribute__((__const__)) __udiv32by16 __rt_udiv32by16(
     unsigned int ,
     unsigned short );



__attribute__((__value_in_regs__)) extern __attribute__((__nothrow__)) __attribute__((__const__)) __sdiv64by32 __rt_sdiv64by32(
     int , unsigned int ,
     int );







extern __attribute__((__nothrow__)) unsigned int __fp_status(unsigned int , unsigned int );
# 705 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) int mblen(const char * , size_t );
# 720 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) int mbtowc(wchar_t * __restrict ,
                   const char * __restrict , size_t );
# 739 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) int wctomb(char * , wchar_t );
# 761 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) size_t mbstowcs(wchar_t * __restrict ,
                      const char * __restrict , size_t ) __attribute__((__nonnull__(2)));
# 779 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) size_t wcstombs(char * __restrict ,
                      const wchar_t * __restrict , size_t ) __attribute__((__nonnull__(2)));
# 798 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdlib.h" 3
extern __attribute__((__nothrow__)) void __use_realtime_heap(void);
extern __attribute__((__nothrow__)) void __use_realtime_division(void);
extern __attribute__((__nothrow__)) void __use_two_region_memory(void);
extern __attribute__((__nothrow__)) void __use_no_heap(void);
extern __attribute__((__nothrow__)) void __use_no_heap_region(void);

extern __attribute__((__nothrow__)) char const *__C_library_version_string(void);
extern __attribute__((__nothrow__)) int __C_library_version_number(void);
# 4 "Source/game.c" 2
# 1 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 1 3
# 68 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
    typedef __builtin_va_list __va_list;
# 87 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
typedef struct __fpos_t_struct {
    unsigned long long int __pos;





    struct {
        unsigned int __state1, __state2;
    } __mbstate;
} fpos_t;
# 108 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
typedef struct __FILE FILE;
# 119 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
struct __FILE {
    union {
        long __FILE_alignment;



        char __FILE_size[84];

    } __FILE_opaque;
};
# 138 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern FILE __stdin, __stdout, __stderr;
extern FILE *__aeabi_stdin, *__aeabi_stdout, *__aeabi_stderr;
# 224 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int remove(const char * ) __attribute__((__nonnull__(1)));







extern __attribute__((__nothrow__)) int rename(const char * , const char * ) __attribute__((__nonnull__(1,2)));
# 243 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) FILE *tmpfile(void);






extern __attribute__((__nothrow__)) char *tmpnam(char * );
# 265 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fclose(FILE * ) __attribute__((__nonnull__(1)));
# 275 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fflush(FILE * );
# 285 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) FILE *fopen(const char * __restrict ,
                           const char * __restrict ) __attribute__((__nonnull__(1,2)));
# 329 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) FILE *freopen(const char * __restrict ,
                    const char * __restrict ,
                    FILE * __restrict ) __attribute__((__nonnull__(2,3)));
# 342 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) void setbuf(FILE * __restrict ,
                    char * __restrict ) __attribute__((__nonnull__(1)));






extern __attribute__((__nothrow__)) int setvbuf(FILE * __restrict ,
                   char * __restrict ,
                   int , size_t ) __attribute__((__nonnull__(1)));
# 370 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
#pragma __printf_args
extern __attribute__((__nothrow__)) int fprintf(FILE * __restrict ,
                    const char * __restrict , ...) __attribute__((__nonnull__(1,2)));
# 393 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
#pragma __printf_args
extern __attribute__((__nothrow__)) int _fprintf(FILE * __restrict ,
                     const char * __restrict , ...) __attribute__((__nonnull__(1,2)));





#pragma __printf_args
extern __attribute__((__nothrow__)) int printf(const char * __restrict , ...) __attribute__((__nonnull__(1)));






#pragma __printf_args
extern __attribute__((__nothrow__)) int _printf(const char * __restrict , ...) __attribute__((__nonnull__(1)));





#pragma __printf_args
extern __attribute__((__nothrow__)) int sprintf(char * __restrict , const char * __restrict , ...) __attribute__((__nonnull__(1,2)));








#pragma __printf_args
extern __attribute__((__nothrow__)) int _sprintf(char * __restrict , const char * __restrict , ...) __attribute__((__nonnull__(1,2)));






#pragma __printf_args
extern __attribute__((__nothrow__)) int __ARM_snprintf(char * __restrict , size_t ,
                     const char * __restrict , ...) __attribute__((__nonnull__(3)));
# 460 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
#pragma __printf_args
extern __attribute__((__nothrow__)) int _snprintf(char * __restrict , size_t ,
                      const char * __restrict , ...) __attribute__((__nonnull__(3)));





#pragma __scanf_args
extern __attribute__((__nothrow__)) int fscanf(FILE * __restrict ,
                    const char * __restrict , ...) __attribute__((__nonnull__(1,2)));
# 503 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
#pragma __scanf_args
extern __attribute__((__nothrow__)) int _fscanf(FILE * __restrict ,
                     const char * __restrict , ...) __attribute__((__nonnull__(1,2)));





#pragma __scanf_args
extern __attribute__((__nothrow__)) int scanf(const char * __restrict , ...) __attribute__((__nonnull__(1)));








#pragma __scanf_args
extern __attribute__((__nothrow__)) int _scanf(const char * __restrict , ...) __attribute__((__nonnull__(1)));





#pragma __scanf_args
extern __attribute__((__nothrow__)) int sscanf(const char * __restrict ,
                    const char * __restrict , ...) __attribute__((__nonnull__(1,2)));
# 541 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
#pragma __scanf_args
extern __attribute__((__nothrow__)) int _sscanf(const char * __restrict ,
                     const char * __restrict , ...) __attribute__((__nonnull__(1,2)));
# 555 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int _vfscanf(FILE * __restrict , const char * __restrict , __va_list) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) int _vscanf(const char * __restrict , __va_list) __attribute__((__nonnull__(1)));
extern __attribute__((__nothrow__)) int _vsscanf(const char * __restrict , const char * __restrict , __va_list) __attribute__((__nonnull__(1,2)));
extern __attribute__((__nothrow__)) int __ARM_vsscanf(const char * __restrict , const char * __restrict , __va_list) __attribute__((__nonnull__(1,2)));

extern __attribute__((__nothrow__)) int vprintf(const char * __restrict , __va_list ) __attribute__((__nonnull__(1)));







extern __attribute__((__nothrow__)) int _vprintf(const char * __restrict , __va_list ) __attribute__((__nonnull__(1)));





extern __attribute__((__nothrow__)) int vfprintf(FILE * __restrict ,
                    const char * __restrict , __va_list ) __attribute__((__nonnull__(1,2)));
# 584 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int vsprintf(char * __restrict ,
                     const char * __restrict , __va_list ) __attribute__((__nonnull__(1,2)));
# 594 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int __ARM_vsnprintf(char * __restrict , size_t ,
                     const char * __restrict , __va_list ) __attribute__((__nonnull__(3)));
# 609 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int _vsprintf(char * __restrict ,
                      const char * __restrict , __va_list ) __attribute__((__nonnull__(1,2)));





extern __attribute__((__nothrow__)) int _vfprintf(FILE * __restrict ,
                     const char * __restrict , __va_list ) __attribute__((__nonnull__(1,2)));





extern __attribute__((__nothrow__)) int _vsnprintf(char * __restrict , size_t ,
                      const char * __restrict , __va_list ) __attribute__((__nonnull__(3)));
# 635 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
#pragma __printf_args
extern __attribute__((__nothrow__)) int __ARM_asprintf(char ** , const char * __restrict , ...) __attribute__((__nonnull__(2)));
extern __attribute__((__nothrow__)) int __ARM_vasprintf(char ** , const char * __restrict , __va_list ) __attribute__((__nonnull__(2)));
# 649 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fgetc(FILE * ) __attribute__((__nonnull__(1)));
# 659 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) char *fgets(char * __restrict , int ,
                    FILE * __restrict ) __attribute__((__nonnull__(1,3)));
# 673 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fputc(int , FILE * ) __attribute__((__nonnull__(2)));
# 683 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fputs(const char * __restrict , FILE * __restrict ) __attribute__((__nonnull__(1,2)));






extern __attribute__((__nothrow__)) int getc(FILE * ) __attribute__((__nonnull__(1)));
# 704 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
    extern __attribute__((__nothrow__)) int (getchar)(void);
# 713 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) char *gets(char * ) __attribute__((__nonnull__(1)));
# 725 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int putc(int , FILE * ) __attribute__((__nonnull__(2)));
# 737 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
    extern __attribute__((__nothrow__)) int (putchar)(int );






extern __attribute__((__nothrow__)) int puts(const char * ) __attribute__((__nonnull__(1)));







extern __attribute__((__nothrow__)) int ungetc(int , FILE * ) __attribute__((__nonnull__(2)));
# 778 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) size_t fread(void * __restrict ,
                    size_t , size_t , FILE * __restrict ) __attribute__((__nonnull__(1,4)));
# 794 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) size_t __fread_bytes_avail(void * __restrict ,
                    size_t , FILE * __restrict ) __attribute__((__nonnull__(1,3)));
# 810 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) size_t fwrite(const void * __restrict ,
                    size_t , size_t , FILE * __restrict ) __attribute__((__nonnull__(1,4)));
# 822 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fgetpos(FILE * __restrict , fpos_t * __restrict ) __attribute__((__nonnull__(1,2)));
# 833 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fseek(FILE * , long int , int ) __attribute__((__nonnull__(1)));
# 850 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int fsetpos(FILE * __restrict , const fpos_t * __restrict ) __attribute__((__nonnull__(1,2)));
# 863 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) long int ftell(FILE * ) __attribute__((__nonnull__(1)));
# 877 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) void rewind(FILE * ) __attribute__((__nonnull__(1)));
# 886 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) void clearerr(FILE * ) __attribute__((__nonnull__(1)));







extern __attribute__((__nothrow__)) int feof(FILE * ) __attribute__((__nonnull__(1)));




extern __attribute__((__nothrow__)) int ferror(FILE * ) __attribute__((__nonnull__(1)));




extern __attribute__((__nothrow__)) void perror(const char * );
# 917 "C:\\Users\\aproi\\AppData\\Local\\Keil_v5\\ARM\\ARMCLANG\\bin\\..\\include\\stdio.h" 3
extern __attribute__((__nothrow__)) int _fisatty(FILE * ) __attribute__((__nonnull__(1)));



extern __attribute__((__nothrow__)) void __use_no_semihosting_swi(void);
extern __attribute__((__nothrow__)) void __use_no_semihosting(void);
# 5 "Source/game.c" 2
# 16 "Source/game.c"
uint16_t board[20][10];
uint8_t board_powers[20][10];

Block currentBlock, nextBlock;
volatile GameStatus status = GAME_PAUSED;

int score = 0;
int lines_cleared_total = 0;
volatile int highScore = 0;


volatile int hard_drop_mode = 0;
volatile int restart_requested = 0;
static int drop_ticks = 0;


extern volatile int J_left, J_right, J_up, J_down;


const Point TETROMINO_SHAPES[7][4] = {
    {{0, -1}, {0, 0}, {0, 1}, {0, 2}},
    {{0, -1}, {0, 0}, {0, 1}, {1, 1}},
    {{0, -1}, {0, 0}, {0, 1}, {1, -1}},
    {{0, 0}, {0, 1}, {1, 0}, {1, 1}},
    {{0, -1}, {0, 0}, {1, 0}, {1, 1}},
    {{0, -1}, {0, 0}, {0, 1}, {1, 0}},
    {{0, 1}, {0, 0}, {1, 0}, {1, -1}}
};

const uint16_t TETROMINO_COLORS[7] = {
    0x07FF, 0x001F, 0xFD20, 0xFFE0, 0x07E0, 0xF81F, 0xF800
};



static void update_label(int y, int value, uint16_t color) {
    char buf[12];
    sprintf(buf, "%d", value);
    GUI_Text(160, y, (uint8_t *)buf, color, 0x0000);
}

void draw_grid_cell(int row, int col, uint16_t color) {
    int i, j;
    int x0 = 5 + (col * 15);
    int y0 = 10 + (row * 15);

    // 1. Disegna il quadrato colorato (invariato)
    for (i = 0; i < 15; i++) {
        for (j = 0; j < 15; j++) {
            uint16_t p_color = (i == 15 - 1 || j == 15 - 1) ? 0x0000 : color;
            LCD_SetPoint(x0 + j, y0 + i, p_color);
        }
    }

    // 2. Overlay Lettera PowerUp (Modificato)
    if (color != 0x0000 && board_powers[row][col] != POWER_NONE) {
        char letter[2] = " ";
        if (board_powers[row][col] == POWER_CLEAR) letter[0] = 'C';
        else if (board_powers[row][col] == POWER_SLOW) letter[0] = 'S';

        // CORREZIONE POSIZIONE E COLORE
        // X: (15 - 8) / 2 = 3.5 -> Arrotondiamo a +4 per centrare orizzontalmente
        // Y: Mettiamo a 0. Il font è alto 16px, il blocco 15px.
        // Se mettiamo +4 sfora di 5px. A 0 sfora solo di 1px in basso (quasi invisibile).

        GUI_Text(x0 + 4, y0, (uint8_t *)letter, 0x0000, color);
    }
}

void draw_tetromino(Block block, uint16_t color) {
    int i, r, c;
    for (i = 0; i < 4; i++) {
        r = block.position.row + block.cells[i].row;
        c = block.position.col + block.cells[i].col;
        if (r >= 0 && r < 20 && c >= 0 && c < 10) {
            draw_grid_cell(r, c, color);
        }
    }
}

void draw_board(void) {
    int i;
    int w = 10 * 15 + 2;
    int h = 20 * 15 + 2;
    int x = 5 - 1;
    int y = 10 - 1;

    for (i = 0; i < w; i++) {
        LCD_SetPoint(x + i, y, 0xFFFF);
        LCD_SetPoint(x + i, y + h, 0xFFFF);
    }
    for (i = 0; i < h; i++) {
        LCD_SetPoint(x, y + i, 0xFFFF);
        LCD_SetPoint(x + w, y + i, 0xFFFF);
    }

    GUI_Text(160, 20, (uint8_t *)"SCORE", 0xFFFF, 0x0000);
    GUI_Text(160, 70, (uint8_t *)"LINES", 0xFFFF, 0x0000);
    GUI_Text(160, 120, (uint8_t *)"HI-SCORE", 0xFFFF, 0x0000);
    GUI_Text(160, 170, (uint8_t *)"NEXT", 0xFFFF, 0x0000);

    update_label(40, score, 0xFFFF);
    update_label(90, lines_cleared_total, 0xFFFF);
    update_label(140, highScore, 0xFFE0);

    if (status == GAME_PAUSED) {
        GUI_Text(160, 265, (uint8_t *)"PAUSED", 0xFFE0, 0x0000);
    }
}

void draw_block_preview(Block blok, uint16_t color) {
    int i, a, b, px, py;
    int start_x = 160, start_y = 190;

    for (i = 0; i < 4; i++) {
        px = start_x + ((blok.cells[i].col + 1) * 15);
        py = start_y + ((blok.cells[i].row + 1) * 15);
        for (a = 0; a < 15; a++) {
            for (b = 0; b < 15; b++) {
                uint16_t p_color = (a == 15 - 1 || b == 15 - 1) ? 0x0000 : color;
                LCD_SetPoint(px + b, py + a, p_color);
            }
        }
    }
}

void spawn_random_powerup(void) {
    int r, c;
    int occupied_count = 0;
    static Point occupied_blocks[20 * 10];

    // 1. Cerca blocchi candidati (Pieni e senza potere)
    for (r = 0; r < 20; r++) {
        for (c = 0; c < 10; c++) {
            if (board[r][c] != 0x0000 && board_powers[r][c] == POWER_NONE) {
                occupied_blocks[occupied_count].row = r;
                occupied_blocks[occupied_count].col = c;
                occupied_count++;
            }
        }
    }

    if (occupied_count == 0) return; // Nessun blocco disponibile

    // 2. Scegli a caso
    int rand_idx = rand() % occupied_count;
    Point target = occupied_blocks[rand_idx];

    // 3. Assegna potere (50% Clear, 50% Slow)
    PowerUpType new_power = (rand() % 2 == 0) ? POWER_CLEAR : POWER_SLOW;
    board_powers[target.row][target.col] = new_power;

    // 4. Ridisegna SOLO quella cella per mostrare la lettera
    draw_grid_cell(target.row, target.col, board[target.row][target.col]);
}

void apply_malus(void) {
    int i, r, c;

    // 1. Controllo Game Over: Se la riga 0 non è vuota, abbiamo perso
    for (c = 0; c < 10; c++) {
        if (board[0][c] != 0x0000) {
            status = GAME_OVER;
            GUI_Text(50, 150, (uint8_t *)" GAME OVER ", 0xF800, 0xFFFF);
            return;
        }
    }

    // 2. Shift verso l'ALTO (da riga 1 a riga 0, ecc.)
    for (r = 0; r < 20 - 1; r++) {
        for (c = 0; c < 10; c++) {
            board[r][c] = board[r+1][c];
            board_powers[r][c] = board_powers[r+1][c]; // Sposta anche i poteri
        }
    }

    // 3. Generazione Riga Sporca (Fondo)
    // Creiamo un array temporaneo con 7 blocchi (1) e 3 buchi (0)
    int row_pattern[10] = {1, 1, 1, 1, 1, 1, 1, 0, 0, 0};

    // Shuffle dell'array (Fisher-Yates semplificato) per mischiare buchi e pieni
    for (i = 0; i < 10; i++) {
        int swap_idx = rand() % 10;
        int temp = row_pattern[i];
        row_pattern[i] = row_pattern[swap_idx];
        row_pattern[swap_idx] = temp;
    }

    // Applica alla riga 19
    for (c = 0; c < 10; c++) {
        if (row_pattern[c] == 1) {
            board[20 - 1][c] = 0x8410; // Colore per i blocchi malus (Grigio)
            board_powers[20 - 1][c] = POWER_NONE;
        } else {
            board[20 - 1][c] = 0x0000;
            board_powers[20 - 1][c] = POWER_NONE;
        }
    }

    // 4. Ridisegna tutto il campo
    for (r = 0; r < 20; r++) {
        for (c = 0; c < 10; c++) draw_grid_cell(r, c, board[r][c]);
    }
}

void apply_clear_half(void) {
    int i, r, c, k;
    int highest_row = 20; // Partiamo dal fondo+1 (vuoto)

    // 1. Calcola l'altezza effettiva della pila (Trova la prima riga occupata dall'alto)
    for (r = 0; r < 20; r++) {
        for (c = 0; c < 10; c++) {
            if (board[r][c] != 0x0000) {
                highest_row = r;
                goto found_height; // Esci dai due loop
            }
        }
    }
    found_height:;

    // Se il campo è vuoto, esci
    if (highest_row == 20) return;

    int stack_height = 20 - highest_row;
    int lines_to_remove = stack_height / 2;

    // Se c'è meno di 2 righe (es. 1 riga), 1/2 = 0. Non facciamo nulla o togliamo l'ultima?
    // Specifica: "Clear half". Se 1 riga, ne togliamo 0.
    if (lines_to_remove == 0) return;

    // 2. Rimuovi le 'lines_to_remove' righe PIÙ IN BASSO (dal fondo a salire)
    // Eseguiamo lo shift verso il basso per ogni riga rimossa
    for (i = 0; i < lines_to_remove; i++) {
        // Copiamo tutto verso il basso a partire dalla penultima riga in su
        // (Simile a quando si cancella una riga nel tetris classico)
        for (k = 20 - 1; k > 0; k--) {
            for (c = 0; c < 10; c++) {
                board[k][c] = board[k-1][c];
                board_powers[k][c] = board_powers[k-1][c];
            }
        }
        // Pulisci riga 0
        for (c = 0; c < 10; c++) {
            board[0][c] = 0x0000;
            board_powers[0][c] = POWER_NONE;
        }
    }

    // 3. Punteggio (come da specifica)
    // "award points in groups of 4"
    int temp_lines = lines_to_remove;
    while (temp_lines > 0) {
        if (temp_lines >= 4) {
            score += 600;
            temp_lines -= 4;
        } else {
            score += (temp_lines * 100);
            temp_lines = 0;
        }
    }
    update_label(40, score, 0xFFFF);

    // Nota: Ridisegneremo tutto alla fine di check_lines
}



int check_collision(Block b) {
    int i, r, c;
    for (i = 0; i < 4; i++) {
        r = b.position.row + b.cells[i].row;
        c = b.position.col + b.cells[i].col;
        if (r >= 20 || c < 0 || c >= 10) return 1;
        if (r >= 0 && board[r][c] != 0x0000) return 1;
    }
    return 0;
}

// Variabili globali per l'effetto Slow (le definiremo meglio dopo, ma servono qui)
volatile int slow_down_active = 0;
volatile int slow_down_timer = 0;

void check_lines(void) {
    int r, c, k, full, lines_found = 0;

    // Flag memorizzati PRIMA di cancellare le righe
    int trigger_clear_half = 0;
    int trigger_slow = 0;

    // --- STEP 1: Analisi e Pulizia Standard (La riga corrente viene eliminata) ---
    for (r = 20 - 1; r >= 0; r--) {
        full = 1;
        for (c = 0; c < 10; c++) {
            if (board[r][c] == 0x0000) { full = 0; break; }
        }

        if (full) {
            // Controlla se c'erano powerup su QUESTA riga specifica
            for (c = 0; c < 10; c++) {
                if (board_powers[r][c] == POWER_CLEAR) trigger_clear_half = 1;
                if (board_powers[r][c] == POWER_SLOW) trigger_slow = 1;
            }

            lines_found++;

            // Elimina la riga e fai scendere tutto (Tetris Standard)
            for (k = r; k > 0; k--) {
                for (c = 0; c < 10; c++) {
                    board[k][c] = board[k-1][c];
                    board_powers[k][c] = board_powers[k-1][c];
                }
            }
            // Pulisci riga 0
            for (c = 0; c < 10; c++) {
                board[0][c] = 0x0000;
                board_powers[0][c] = POWER_NONE;
            }
            r++; // Ricontrolla la stessa riga (ora occupata da quella sopra)
        }
    }

    // Se non abbiamo fatto righe, usciamo subito
    if (lines_found == 0) return;

    // --- Aggiornamento Punteggi Base ---
    lines_cleared_total += lines_found;
    score += (lines_found == 4) ? 600 : (lines_found * 100);
    update_label(90, lines_cleared_total, 0xFFFF);
    update_label(40, score, 0xFFFF);

    // --- STEP 2: Generazione Nuovi PowerUP ---
    // (Generiamo su ciò che è rimasto dopo la pulizia base)
    if (lines_cleared_total % 2 // Ogni quante righe genero un powerup (Debug: 1) == 0) {
         spawn_random_powerup();
    }

    // --- STEP 3: Attivazione Effetti PowerUP ---
    // Avvengono DOPO che la riga trigger è sparita
    if (trigger_clear_half) {
        apply_clear_half(); // Rimuove metà delle righe RESTANTI
    }

    if (trigger_slow) {
        slow_down_active = 1;
        slow_down_timer = 15; // Reset timer a 15s
        // Qui opzionalmente potresti mostrare un messaggio "SLOW!"
    }

    // --- STEP 4: Applicazione Malus ---
    // Avviene per ULTIMO. Se ClearHalf ha pulito tutto, il Malus aggiungerà
    // una riga in fondo senza uccidere il giocatore.
    if (lines_cleared_total % 10 // Ogni quante righe genero un malus (Debug: 2) == 0) {
         apply_malus();
    }

  // --- STEP 5: Ridisegno Finale OTTIMIZZATO ---
    // NON usiamo LCD_Clear o draw_board, perché ridisegnano la cornice inutilmente.
    // Ridisegniamo solo le celle della griglia di gioco.

    for (r = 0; r < 20; r++) {
        for (c = 0; c < 10; c++) {
            // Questo ridisegna il blocco colorato, la lettera (se c'è) 
            // oppure il nero se la cella è vuota, pulendo "sporcizia" precedente.
            draw_grid_cell(r, c, board[r][c]);
        }
    }
}

void spawn_block(void) {
    int i;
    if (currentBlock.type == 0 && nextBlock.type == 0) {
        nextBlock.type = (BlockType)(rand() % 7);
        nextBlock.color = TETROMINO_COLORS[nextBlock.type];
        for(i=0; i<4; i++) nextBlock.cells[i] = TETROMINO_SHAPES[nextBlock.type][i];
    }
    currentBlock = nextBlock;
    currentBlock.position.row = 1;
    currentBlock.position.col = 10 / 2;
    draw_block_preview(currentBlock, 0x0000);

    nextBlock.type = (BlockType)(rand() % 7);
    nextBlock.color = TETROMINO_COLORS[nextBlock.type];
    for(i=0; i<4; i++) nextBlock.cells[i] = TETROMINO_SHAPES[nextBlock.type][i];
    draw_block_preview(nextBlock, nextBlock.color);
}

void lock_block(void) {
    int i, r, c;
    for (i = 0; i < 4; i++) {
        r = currentBlock.position.row + currentBlock.cells[i].row;
        c = currentBlock.position.col + currentBlock.cells[i].col;
        if (r >= 0 && r < 20) board[r][c] = currentBlock.color;
    }
    score += 10;
    update_label(40, score, 0xFFFF);
    hard_drop_mode = 0;
    check_lines();
    spawn_block();

    if (check_collision(currentBlock)) {
        status = GAME_OVER;
        GUI_Text(50, 150, (uint8_t *)" GAME OVER ", 0xF800, 0xFFFF);
        if (score > highScore) {
            highScore = score;
            update_label(140, highScore, 0xFFE0);
            GUI_Text(50, 170, (uint8_t *)"NEW RECORD!", 0xFFE0, 0x0000);
        }
        GUI_Text(30, 190, (uint8_t *)"PRESS KEY1", 0xFFFF, 0x0000);
    } else {
        draw_tetromino(currentBlock, currentBlock.color);
    }
}

void rotate_block(void) {
    int i, tmp_r;
    Block temp;
    if (currentBlock.type == O_BLOCK) return;
    temp = currentBlock;
    for (i = 0; i < 4; i++) {
        tmp_r = temp.cells[i].row;
        temp.cells[i].row = temp.cells[i].col;
        temp.cells[i].col = -tmp_r;
    }
    if (!check_collision(temp)) {
        draw_tetromino(currentBlock, 0x0000);
        currentBlock = temp;
        draw_tetromino(currentBlock, currentBlock.color);
    }
}



void on_key1_pressed(void) {
    srand(((LPC_TIM_TypeDef *) ((0x40000000UL) + 0x04000) )->TC);
    if (status == GAME_OVER) {
        restart_requested = 1;
    } else if (status == GAME_PAUSED) {
        status = GAME_RUNNING;
        GUI_Text(160, 265, (uint8_t *)"      ", 0x0000, 0x0000);
    } else {
        status = GAME_PAUSED;
        GUI_Text(160, 265, (uint8_t *)"PAUSED", 0xFFE0, 0x0000);
    }
}

void game_init(void) {
    int i, j;
    __NVIC_SetPriority(RIT_IRQn, 1);
    __NVIC_SetPriority(TIMER0_IRQn, 2);
    for (i = 0; i < 20; i++) {
        for (j = 0; j < 10; j++) board[i][j] = 0x0000;
    }
    score = 0;
    lines_cleared_total = 0;
    status = GAME_PAUSED;
  // Pulizia Board e Board Powers
    for (i = 0; i < 20; i++) {
        for (j = 0; j < 10; j++) {
            board[i][j] = 0x0000;
            board_powers[i][j] = POWER_NONE;
        }
    }
    currentBlock.type = nextBlock.type = 0;
    LCD_Clear(0x0000);
    draw_board();
    spawn_block();
}

void game_update(void) {
    Block temp;
    int threshold;

    if (restart_requested) {
        restart_requested = 0;
        game_init();
        return;
    }
    if (status != GAME_RUNNING) return;

    if (hard_drop_mode) {
        draw_tetromino(currentBlock, 0x0000);
        while (!check_collision(currentBlock)) currentBlock.position.row++;
        currentBlock.position.row--;
        draw_tetromino(currentBlock, currentBlock.color);
        lock_block();
        return;
    }

    if (J_up) { rotate_block(); J_up = 0; }
    if (J_left || J_right) {
        temp = currentBlock;
        if (J_left) temp.position.col--;
        if (J_right) temp.position.col++;
        if (!check_collision(temp)) {
            draw_tetromino(currentBlock, 0x0000);
            currentBlock = temp;
            draw_tetromino(currentBlock, currentBlock.color);
        }
        J_left = J_right = 0;
    }

    drop_ticks++;
    threshold = (J_down) ? 2 : 40;
    if (drop_ticks >= threshold) {
        drop_ticks = 0;
        temp = currentBlock;
        temp.position.row++;
        if (check_collision(temp)) {
            lock_block();
        } else {
            draw_tetromino(currentBlock, 0x0000);
            currentBlock.position.row++;
            draw_tetromino(currentBlock, currentBlock.color);
        }
    }
}
