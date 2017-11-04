#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  int status;
  argptr(0, (char **) &status, 4);
  exit(status);
  return 0;  // not reached
}

int
sys_wait(void)
{
  int size = 4;
  int val;
  int * value = &val;

  if(argptr(0, (char**) value, size) < 0)
  { return -1; }

  int* status = (int*)(&value);
  return wait(status);
}

//CS153 Edited Code~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
int
sys_waitpid()
{
	int pid;
	int *status;
	int opts;
	
	argint(0,&pid);
	argptr(0,(char**) &pid, 4);
	argptr(1,(char**) &status, 4);
	argptr(2, (char**) &opts, 4);

	return waitpid(pid, status, opts);
	return 0; //should never reach this point
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);

}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

void
sys_change_priority(int priority)
{
	//int priority;

	argptr(0,(char**)&priority,4);
	return change_priority(priority);
}

/*int
sys_setpriority(void)
{
  int priority;
  //first value      
  //argptr saves the pointer variable to the second argument
  //4 bytes 
  argptr(0,(char**)&priority,4);
  return setpriority(priority);
}*/
