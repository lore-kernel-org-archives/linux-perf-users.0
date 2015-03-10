From: Nan Xiao <xiaonan830818@gmail.com>
Subject: Why "perf stat" output more memory load/store counts?
Date: Tue, 10 Mar 2015 17:46:45 +0800
Message-ID: <CA+MhoaMshSNRS1RD0Dq6dXY_XZtEnryfRq6Hvm+Ntf_Gs67h=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35948 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858AbbCJJqq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 10 Mar 2015 05:46:46 -0400
Received: by wiwh11 with SMTP id h11so18198346wiw.1
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2015 02:46:45 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi all,

Greetings from me!

I want to use "perf stat" command to do a statistic of
"MEM_UOP_RETIRED.ALL_LOADS" and "MEM_UOP_RETIRED.ALL_STORES" of the
program:

#include <stdio.h>

#define MAX_ARRAY_SIZE  (10000000)

double a[MAX_ARRAY_SIZE];
double b[MAX_ARRAY_SIZE];
double c[MAX_ARRAY_SIZE];
int main(void)
{

    ssize_t i = 0;

    for (i = 0; i < MAX_ARRAY_SIZE; i++)
    {
       c[i] = a[i] + b[i];
    }
   return 0;
}

The disassemble code of the program (no Optimization):

Dump of assembler code for function main:
  0x00000000004004f0 <+0>:     push   %rbp
  0x00000000004004f1 <+1>:     mov    %rsp,%rbp
  0x00000000004004f4 <+4>:     movq   $0x0,-0x8(%rbp)
  0x00000000004004fc <+12>:    movq   $0x0,-0x8(%rbp)
  0x0000000000400504 <+20>:    jmp    0x400536 <main+70>
  0x0000000000400506 <+22>:    mov    -0x8(%rbp),%rax
  0x000000000040050a <+26>:    movsd  0x9e97860(,%rax,8),%xmm1
  0x0000000000400513 <+35>:    mov    -0x8(%rbp),%rax
  0x0000000000400517 <+39>:    movsd  0x601060(,%rax,8),%xmm0
  0x0000000000400520 <+48>:    addsd  %xmm1,%xmm0
  0x0000000000400524 <+52>:    mov    -0x8(%rbp),%rax
  0x0000000000400528 <+56>:    movsd  %xmm0,0x524c460(,%rax,8)
  0x0000000000400531 <+65>:    addq   $0x1,-0x8(%rbp)
  0x0000000000400536 <+70>:    cmpq   $0x98967f,-0x8(%rbp)
  0x000000000040053e <+78>:    jle    0x400506 <main+22>
  0x0000000000400540 <+80>:    mov    $0x0,%eax
  0x0000000000400545 <+85>:    pop    %rbp
  0x0000000000400546 <+86>:    retq
End of assembler dump.

The loop statement code is:
  0x0000000000400506 <+22>:    mov    -0x8(%rbp),%rax
  0x000000000040050a <+26>:    movsd  0x9e97860(,%rax,8),%xmm1
  0x0000000000400513 <+35>:    mov    -0x8(%rbp),%rax
  0x0000000000400517 <+39>:    movsd  0x601060(,%rax,8),%xmm0
  0x0000000000400520 <+48>:    addsd  %xmm1,%xmm0
  0x0000000000400524 <+52>:    mov    -0x8(%rbp),%rax
  0x0000000000400528 <+56>:    movsd  %xmm0,0x524c460(,%rax,8)
  0x0000000000400531 <+65>:    addq   $0x1,-0x8(%rbp)
  0x0000000000400536 <+70>:    cmpq   $0x98967f,-0x8(%rbp)

The number of load operations is 7:
  0x0000000000400506 <+22>:    mov    -0x8(%rbp),%rax
  0x000000000040050a <+26>:    movsd  0x9e97860(,%rax,8),%xmm1
  0x0000000000400513 <+35>:    mov    -0x8(%rbp),%rax
  0x0000000000400517 <+39>:    movsd  0x601060(,%rax,8),%xmm0
  0x0000000000400524 <+52>:    mov    -0x8(%rbp),%rax
  0x0000000000400531 <+65>:    addq   $0x1,-0x8(%rbp)
  0x0000000000400536 <+70>:    cmpq   $0x98967f,-0x8(%rbp)

The number of store operations is 2:
  0x0000000000400528 <+56>:    movsd  %xmm0,0x524c460(,%rax,8)
  0x0000000000400531 <+65>:    addq   $0x1,-0x8(%rbp)

So the number of total load operations is about 70,000,000, and the
number of total store operations is about 20,000,000.

After executing "perf stat" command, the output is:

[root@Linux test]# perf stat -a -e "r81d0","r82d0" ./a

Performance counter stats for './a':

        71,779,954 r81d0
         [100.00%]
        26,601,675 r82d0

       0.036929715 seconds time elapsed

I can see there are about 1,779,954(71,779,954 - 70,000,000) more load
operations and 6,601,675(26,601,675 - 20,000,000) more store
operations.

I can't understand why there are so many more load/store operations
from "perf stat" output. Could anyone can explain this? Thanks very
much in advance!

-- 
Best Regards
Nan Xiao
