#include <stdio.h>
#include <stdint.h>
#include "csr.h"

#define ACCEL_BASE 0x00030000

// Define the calculator module's registers

#define ACCEL_GO_REG (*(volatile uint32_t *)(ACCEL_BASE))
#define ACCEL_PERF_COUNTER (*(volatile uint32_t *)(ACCEL_BASE + 0x4))
// A regs
#define ACCEL_A (*(volatile uint32_t *)(ACCEL_BASE + 0x8))
// B regs
#define ACCEL_B (*(volatile uint32_t *)(ACCEL_BASE + 0xC))
// C regs
#define ACCEL_C (*(volatile uint32_t *)(ACCEL_BASE + 0x10))

void subtract(int h_start, int l_start, int h_end, int l_end);
int main()
{
    
    ACCEL_A = 0x07020106;
    ACCEL_B = 0x01030A05;
    printf("ACCEL_A: %x, adress: %p \n", ACCEL_A, &ACCEL_A);
    printf("ACCEL_B: %x, adress: %p \n", ACCEL_B, &ACCEL_B);
    printf("ACCEL_C: %x, adress: %p \n", ACCEL_C, &ACCEL_C);
    printf("ACCEL_PERF_COUNTER: %p\n", ACCEL_PERF_COUNTER);


    printf("Start Calculator\n");    
    //Start cycle read
    unsigned int Scycle_h = csr_read(0xc80); 
    unsigned int Scycle_l = csr_read(0xc00);
    
    //Go for 4 cycles!
    ACCEL_GO_REG = 0x1;

    uint32_t x = ACCEL_GO_REG;
    //Check MSB- done bit if its 1
    while (((x)>>31)==0)
    {
        x=ACCEL_GO_REG;
    }
   //End cycle read
    unsigned int Fcycle_l = csr_read(0xc00);
    unsigned int Fcycle_h = csr_read(0xc80);
    printf("End Calculator\n");

    // Print the result
    printf("ACCEL_A: %x, adress: %p \n", ACCEL_A, &ACCEL_A);
    printf("ACCEL_B: %x, adress: %p \n", ACCEL_B, &ACCEL_B);
    printf("ACCEL_C: %x, adress: %p \n", ACCEL_C, &ACCEL_C);
    printf("ACCEL_PERF_COUNTER: %p\n", ACCEL_PERF_COUNTER);

    //Substract function
    subtract(Scycle_h,Scycle_l, Fcycle_h,Fcycle_l);
    return 0;
}

void subtract(int h_start, int l_start, int h_end, int l_end) {
    // Perform the subtraction
    int borrow = (l_end < l_start);
    int l_res = l_end - l_start;
    int h_res = h_end - h_start - borrow;
    
    // Print the result with zero-padding
	printf("\nThe duration of the clock cycles is: 0x%08x%08x\n",h_res,l_res);

}