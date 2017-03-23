From: Yilong Li <yilongl@cs.stanford.edu>
Subject: Need help in tracking down OS jitters using Intel PT
Date: Thu, 23 Mar 2017 02:28:31 -0700
Message-ID: <CAPJB79SqGQY-jb455rJXsyzF7cEkrLE653rwG+rPy6F4+-VQEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtp2.cs.stanford.edu ([171.64.64.26]:55679 "EHLO
        smtp2.cs.Stanford.EDU" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbdCWJ2d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Mar 2017 05:28:33 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36219)
        by smtp2.cs.Stanford.EDU with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.88)
        (envelope-from <yilongl@cs.stanford.edu>)
        id 1cqz2l-00051C-UC
        for linux-perf-users@vger.kernel.org; Thu, 23 Mar 2017 02:28:32 -0700
Received: by mail-pg0-f54.google.com with SMTP id g2so120087645pge.3
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2017 02:28:31 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello,

I have been trying to track down some OS jitters that take around
15~16us on my machine. I created a simple test program "user_loop"
which simply calls rdtscp in a tight loop, collects the first 100 gaps
that take more than 30000 cycles, and sends SIGUSR2 to the `perf
record -e intel_pt// --snapshot` process that is tracing the test
program. The output of the test program looks like this:
[snip]
jitter 88: 31656 cycles, timestamp 7135093048653524
jitter 89: 35714 cycles, timestamp 7135093052200982
jitter 90: 31508 cycles, timestamp 7135093052820884
jitter 91: 31183 cycles, timestamp 7135093068653931
jitter 92: 32813 cycles, timestamp 7135093088516264
[snip]

Then I used `perf script` to display the trace output hoping to see
what exactly get executed during the gap. I used Andi Kleen's
perf/xed-6 branch[1] to get the assembly. However, when I looked
around the last rdtscp instruction in the trace output, I saw nothing
from the kernel. The trace output looks like this:
[snip]
561650.137702631:                          40061b main  rdtscp
561650.137702631:                          40061e main  shl $0x20, %rdx
561650.137702631:                          400622 main  movl  %ecx, -0x1c(%rbp)
561650.137702631:                          400625 main  or %rdx, %rax
561650.137702631:                          400628 main  mov %rax, %rdx
561650.137702631:                          40062b main  sub %rsi, %rdx
561650.137702631:                          40062e main  cmp $0x7530, %rdx
561650.137702631:   jcc                    400635 main  jbe 0x400618 <main+0x88>
561650.137702631:                          400618 main  mov %rax, %rsi
561650.137702631:                          40061b main  rdtscp
561650.137702631:                          40061e main  shl $0x20, %rdx
561650.137702631:                          400622 main  movl  %ecx, -0x1c(%rbp)
561650.137702631:                          400625 main  or %rdx, %rax
561650.137702631:                          400628 main  mov %rax, %rdx
561650.137702631:                          40062b main  sub %rsi, %rdx
561650.137702631:                          40062e main  cmp $0x7530, %rdx
561650.137702631:   jcc                    400635 main  jbe 0x400618 <main+0x88>
561650.137702631:                          400618 main  mov %rax, %rsi
561650.137702631:                          40061b main  rdtscp
<===========LAST ITERATION
561650.137702631:                          40061e main  shl $0x20, %rdx
561650.137702631:                          400622 main  movl  %ecx, -0x1c(%rbp)
561650.137702631:                          400625 main  or %rdx, %rax
561650.137702631:                          400628 main  mov %rax, %rdx
561650.137702631:                          40062b main  sub %rsi, %rdx
561650.137702631:                          40062e main  cmp $0x7530, %rdx
561650.137702631:   jcc                    400635 main  jbe 0x400618 <main+0x88>
561650.137702631:                          400637 main  mov %r8d, %ecx
561650.137702631:                          40063a main  add $0x1, %r8d
561650.137702631:                          40063e main  cmp $0x63, %r8d
561650.137702631:                          400642 main  movq  %rdx,
0x6013a0(,%rcx,8)
561650.137702631:                          40064a main  movq  %rax,
0x601080(,%rcx,8)
561650.137702631:   jcc                    400652 main  jbe 0x400618 <main+0x88>
561650.137702631:                          400654 main  test %edi, %edi
561650.137702631:   jcc                    400656 main  jle 0x400662 <main+0xd2>
561650.137702631:                          400658 main  mov $0xc, %esi
561650.137702631:   call                   40065d main  callq
0x400550 <kill@plt>
561650.137702631:   jmp                    400550 kill@plt      jmpq
0x200ada(%rip)
561650.137702631:                          400556 kill@plt      pushq  $0x3
561650.137702631:   jmp                    40055b kill@plt      jmp
0x400510 <_init+0x20>
561650.137702631:                          400510 _init pushq  0x200af2(%rip)
561650.137702631:   jmp                    400516 _init jmpq  0x200af4(%rip)
561650.137702631:                    7f1b8882c6a0
_dl_runtime_resolve_avx       pushq  %rbx
561650.137702631:                    7f1b8882c6a1
_dl_runtime_resolve_avx       mov %rsp, %rbx
561650.137702631:                    7f1b8882c6a4
_dl_runtime_resolve_avx       and $0xffffffffffffffe0, %rsp
[snip]

Note: the cpu uarch on this machine is Broadwell, so the timestamps
are very crude.

What am I missing? Where does the 15us go? The program and the scripts
I used in the experiment can be found here:
https://github.com/yilongli/OSJitterTest.

Thanks,
Yilong

[1] https://lkml.org/lkml/2017/1/18/1125
