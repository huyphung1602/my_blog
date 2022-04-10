---
title: "Reading Note: Stack and Heap of the Process"
tags: software operating-system
---
## The Process

A program can do nothing unless its instructions are executed by a CPU. A program in execution is a process.

The status of the current activity of a process is represented by the value of the **program counter** and the contents of the processor's registers.

![layout-of-a-process-in-memory](https://i.imgur.com/qQo2n2S.png)

<sub>Layout of a process in memory</sub>

- **Text section**: The executable code
- **Data section**: global variables
- **Heap section**: memory that is dynamically allocated during program run time
- **Stack section**: temporary data storage when invoking functions (such as function parameters, return addresses, and local variables)

The size of text and data sections are fixed. Their size does not change during the program run time.

The stack and heap sections shrink and grow dynamically during program execution.

## Stack

A stack is a simple last-in, first-out (**LIFO**) data structure.

The structure of the stacks is rigid and they only allow access at the top level. But this rigid also makes the stacks easy to implement. The push and pop operations are fast and efficient.

The stacks are used for function calls. Each time a function is called, the parameters, local variables, and the return address are pushed onto the stack. Returning from the function call pops those items off the stack. The variables that are declared and initialized **before** runtime are stored in the stack.

## Heap

The heap is more flexible than the stack. The stack only allows allocation and deallocation at the top. The heap allows the program to allocate or deallocate the memory anywhere in a heap.

So, the advantage is that the program can store the data on the heap in any order.

The disadvantages are:

- The code containing the allocation operation must scan the heap until it finds a contiguous block of memory that is large enough to satisfy the allocation request.
- When the memory is returned to the stack, adjacent freed blocks must be coalesced to free the space for the future requests for large blocks of memory.

The heap is used for memory that is dynamically allocated during program run time. All the variables created or initialized **at** runtime are stored in the heap.

![layout-of-a-c-program-in-memory](https://i.imgur.com/hF2U50i.png)

<sub>Layout of a C program in memory</sub>

## References

- [Operating System Concepts](https://www.amazon.com/Operating-System-Concepts-Abraham-Silberschatz/dp/1119800366)
- <https://icarus.cs.weber.edu/~dab/cs1410/textbook/4.Pointers/memory.html>
- <http://www.maxi-pedia.com/what+is+heap+and+stack>
