From: Dennis <daodennis@gmail.com>
Subject: kernel panic w/ __get_user_pages_fast in 2.6.32-358.6.2
Date: Tue, 14 Jan 2014 19:54:45 -0800
Message-ID: <CANqRL=Q0nwjGadhkQVQgmM8tqcf+4K2QCukSVui5cXWAWcjakg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:35286 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbaAODyp (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Jan 2014 22:54:45 -0500
Received: by mail-oa0-f54.google.com with SMTP id o6so618854oag.41
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2014 19:54:45 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

(x86_64 / Xeon / perf-2.6.32-358.6.2)

The "-a" flag with perf record (and most friends except top) on RHEL
6.1 and 6.3 seems to cause a kernel panic on Intel Xeon- 12 and 24
core systems (only ones I tried so far).

After about 1 second workstation completely freezes and then after
maybe 10 seconds I see a panic.

Since I realize I am probably using an ancient version of perf I am
more trying to solicit some speculation or gather whether this is
already a known issue with this particular software/hardware,
backtrace combination?

In the back trace the RIP points to __get_user_pages_fast, but I am
unsure how to go further.

Neither the perf-user archives or the git commit logs seem too helpful
to me about this function as a keyword to search for.
(http://article.gmane.org/gmane.linux.kernel.perf.user/665/match=__get_user_pages_fast
-returns a thread but on PPC not x86.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=__get_user_pages_fast
I can't tell if any of the commit messages would fix this.  However, I
don't know what, "this" actually is or what's broken really.

This is a back trace (of the 3 cores the RIP is in
__get_user_pages_fast, different process every time.

crash > log | grep BUG

"BUG: unable to handle kernel NULL pointer dereference at 0000000000000050"

crash> bt
PID: 7558   TASK: ffff8801993614c0  CPU: 1   COMMAND: "fprintd"
 #0 [ffff88020bbef720] machine_kexec at ffffffff810310cb
 #1 [ffff88020bbef780] crash_kexec at ffffffff810b6312
 #2 [ffff88020bbef850] oops_end at ffffffff814de190
 #3 [ffff88020bbef880] no_context at ffffffff81040c9b
 #4 [ffff88020bbef8d0] __bad_area_nosemaphore at ffffffff81040f25
 #5 [ffff88020bbef920] bad_area_nosemaphore at ffffffff81040ff3
 #6 [ffff88020bbef930] __do_page_fault at ffffffff810416cd
 #7 [ffff88020bbefa50] do_page_fault at ffffffff814e017e
 #8 [ffff88020bbefa80] page_fault at ffffffff814dd525
    [exception RIP: __get_user_pages_fast+156]
    RIP: ffffffff810464dc  RSP: ffff88020bbefb38  RFLAGS: 00010046
    RAX: 0000000000000006  RBX: 0000000000000000  RCX: ffff88020bbeffd8
    RDX: 0000000000000000  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffff88020bbefb98   R8: ffff880028220000   R9: ffff88020bbefcf8
    R10: ffff88020bbefde8  R11: 0000000000000001  R12: 0000000000000000
    R13: 0000000000001000  R14: 0000008000000000  R15: 0000000000000fff
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #9 [ffff88020bbefba0] copy_from_user_nmi at ffffffff8101ae31
#10 [ffff88020bbefc00] perf_callchain_user at ffffffff8101b008
#11 [ffff88020bbefc50] perf_prepare_sample at ffffffff81106420
#12 [ffff88020bbefca0] __perf_event_overflow at ffffffff81108b38
#13 [ffff88020bbefd40] perf_swevent_overflow at ffffffff81108cd4
#14 [ffff88020bbefd80] do_perf_sw_event at ffffffff81108ee0
#15 [ffff88020bbefde0] perf_tp_event at ffffffff81108f94
#16 [ffff88020bbefe60] ftrace_profile_templ_sched_process_template at
ffffffff8104d66a
#17 [ffff88020bbefeb0] ftrace_profile_sched_process_exit at ffffffff8104d6d3
#18 [ffff88020bbefec0] do_exit at ffffffff8106c34d
#19 [ffff88020bbeff40] do_group_exit at ffffffff8106c4b8
#20 [ffff88020bbeff70] sys_exit_group at ffffffff8106c547
#21 [ffff88020bbeff80] system_call_fastpath at ffffffff8100b172
    RIP: 000000324eeabd98  RSP: 00007fff4b3a55c8  RFLAGS: 00010246
    RAX: 00000000000000e7  RBX: ffffffff8100b172  RCX: 0000000000000000
    RDX: 0000000000000000  RSI: 000000000000003c  RDI: 0000000000000000
    RBP: 0000000000000000   R8: 00000000000000e7   R9: ffffffffffffffa8
    R10: 000000324f18e7e8  R11: 0000000000000246  R12: ffffffff8106c547
    R13: ffff88020bbeff78  R14: 00000032504e4970  R15: 00000000020a1750
    ORIG_RAX: 00000000000000e7  CS: 0033  SS: 002b



"0xffffffff810464dc <__get_user_pages_fast+156>: add
0x50(%rdx),%r12" << what is this doing?

> disassemble __get_user_pages_fast:

0xffffffff81046440 <__get_user_pages_fast+0>:   push   %rbp
0xffffffff81046441 <__get_user_pages_fast+1>:   mov    %rsp,%rbp
0xffffffff81046444 <__get_user_pages_fast+4>:   push   %r15
0xffffffff81046446 <__get_user_pages_fast+6>:   push   %r14
0xffffffff81046448 <__get_user_pages_fast+8>:   push   %r13
0xffffffff8104644a <__get_user_pages_fast+10>:  push   %r12
0xffffffff8104644c <__get_user_pages_fast+12>:  push   %rbx
0xffffffff8104644d <__get_user_pages_fast+13>:  sub    $0x38,%rsp
0xffffffff81046451 <__get_user_pages_fast+17>:  nopl   0x0(%rax,%rax,1)
0xffffffff81046456 <__get_user_pages_fast+22>:  mov    %gs:0xcc00,%rax
0xffffffff8104645f <__get_user_pages_fast+31>:  and    $0xfffffffffffff000,%rdi
0xffffffff81046466 <__get_user_pages_fast+38>:  movslq %esi,%r13
0xffffffff81046469 <__get_user_pages_fast+41>:  mov    %rcx,-0x50(%rbp)
0xffffffff8104646d <__get_user_pages_fast+45>:  mov    %edx,-0x44(%rbp)
0xffffffff81046470 <__get_user_pages_fast+48>:  shl    $0xc,%r13
0xffffffff81046474 <__get_user_pages_fast+52>:  mov    0x480(%rax),%rdx
0xffffffff8104647b <__get_user_pages_fast+59>:  mov    %gs:0xcc08,%rcx
0xffffffff81046484 <__get_user_pages_fast+68>:  movl   $0x0,-0x34(%rbp)
0xffffffff8104648b <__get_user_pages_fast+75>:  mov    %rdi,%rax
0xffffffff8104648e <__get_user_pages_fast+78>:  add    %r13,%rax
0xffffffff81046491 <__get_user_pages_fast+81>:  sbb    %rbx,%rbx
0xffffffff81046494 <__get_user_pages_fast+84>:  cmp    %rax,-0x1fb8(%rcx)
0xffffffff8104649b <__get_user_pages_fast+91>:  sbb    $0x0,%rbx
0xffffffff8104649f <__get_user_pages_fast+95>:  test   %rbx,%rbx
0xffffffff810464a2 <__get_user_pages_fast+98>:  jne
0xffffffff8104654d <__get_user_pages_fast+269>
0xffffffff810464a8 <__get_user_pages_fast+104>: add    %rdi,%r13
0xffffffff810464ab <__get_user_pages_fast+107>: pushfq
0xffffffff810464ac <__get_user_pages_fast+108>: pop    %rax
0xffffffff810464ad <__get_user_pages_fast+109>: nopl   0x0(%rax,%rax,1)
0xffffffff810464b2 <__get_user_pages_fast+114>: mov    %rax,-0x58(%rbp)
0xffffffff810464b6 <__get_user_pages_fast+118>: cli
0xffffffff810464b7 <__get_user_pages_fast+119>: nopw   0x0(%rax,%rax,1)
0xffffffff810464bd <__get_user_pages_fast+125>: mov    %rdi,%r12
0xffffffff810464c0 <__get_user_pages_fast+128>: lea    -0x1(%r13),%r15
0xffffffff810464c4 <__get_user_pages_fast+132>: mov    %rdi,%rsi
0xffffffff810464c7 <__get_user_pages_fast+135>: shr    $0x24,%r12
0xffffffff810464cb <__get_user_pages_fast+139>: mov    $0x8000000000,%r14
0xffffffff810464d5 <__get_user_pages_fast+149>: and    $0xff8,%r12d
0xffffffff810464dc <__get_user_pages_fast+156>: add    0x50(%rdx),%r12
0xffffffff810464e0 <__get_user_pages_fast+160>: jmp
0xffffffff810464ef <__get_user_pages_fast+175>
0xffffffff810464e2 <__get_user_pages_fast+162>: nopw   0x0(%rax,%rax,1)
0xffffffff810464e8 <__get_user_pages_fast+168>: add    $0x8,%r12
0xffffffff810464ec <__get_user_pages_fast+172>: mov    %rbx,%rsi
0xffffffff810464ef <__get_user_pages_fast+175>: lea    (%rsi,%r14,1),%rbx
0xffffffff810464f3 <__get_user_pages_fast+179>: mov    $0xffffff8000000000,%rax
0xffffffff810464fd <__get_user_pages_fast+189>: mov    (%r12),%rdi
0xffffffff81046501 <__get_user_pages_fast+193>: and    %rax,%rbx
0xffffffff81046504 <__get_user_pages_fast+196>: lea    -0x1(%rbx),%rax
0xffffffff81046508 <__get_user_pages_fast+200>: cmp    %r15,%rax
0xffffffff8104650b <__get_user_pages_fast+203>: cmovae %r13,%rbx
0xffffffff8104650f <__get_user_pages_fast+207>: test   %rdi,%rdi
0xffffffff81046512 <__get_user_pages_fast+210>: je
0xffffffff81046530 <__get_user_pages_fast+240>
0xffffffff81046514 <__get_user_pages_fast+212>: mov    -0x50(%rbp),%r8
0xffffffff81046518 <__get_user_pages_fast+216>: mov    -0x44(%rbp),%ecx
0xffffffff8104651b <__get_user_pages_fast+219>: lea    -0x34(%rbp),%r9
0xffffffff8104651f <__get_user_pages_fast+223>: mov    %rbx,%rdx
0xffffffff81046522 <__get_user_pages_fast+226>: callq
0xffffffff810460b0 <gup_pud_range>
0xffffffff81046527 <__get_user_pages_fast+231>: test   %eax,%eax
0xffffffff81046529 <__get_user_pages_fast+233>: je
0xffffffff81046530 <__get_user_pages_fast+240>
0xffffffff8104652b <__get_user_pages_fast+235>: cmp    %r13,%rbx
0xffffffff8104652e <__get_user_pages_fast+238>: jne
0xffffffff810464e8 <__get_user_pages_fast+168>
0xffffffff81046530 <__get_user_pages_fast+240>: mov    -0x58(%rbp),%rdi
0xffffffff81046534 <__get_user_pages_fast+244>: push   %rdi
0xffffffff81046535 <__get_user_pages_fast+245>: popfq
0xffffffff81046536 <__get_user_pages_fast+246>: nopl   0x0(%rax,%rax,1)
0xffffffff8104653b <__get_user_pages_fast+251>: mov    -0x34(%rbp),%eax
0xffffffff8104653e <__get_user_pages_fast+254>: add    $0x38,%rsp
0xffffffff81046542 <__get_user_pages_fast+258>: pop    %rbx
0xffffffff81046543 <__get_user_pages_fast+259>: pop    %r12
0xffffffff81046545 <__get_user_pages_fast+261>: pop    %r13
0xffffffff81046547 <__get_user_pages_fast+263>: pop    %r14
0xffffffff81046549 <__get_user_pages_fast+265>: pop    %r15
0xffffffff8104654b <__get_user_pages_fast+267>: leaveq
0xffffffff8104654c <__get_user_pages_fast+268>: retq
0xffffffff8104654d <__get_user_pages_fast+269>: xor    %eax,%eax
0xffffffff8104654f <__get_user_pages_fast+271>: jmp
0xffffffff8104653e <__get_user_pages_fast+254>
End of assembler dump.
crash>

> whatis __get_user_pages_fast
int __get_user_pages_fast(long unsigned int, int, int, struct page **);

Thank you,

Dennis O.
