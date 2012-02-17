From: Victor Jimenez <victor.javier@bsc.es>
Subject: reading performance counters from an interrupt context
Date: Fri, 17 Feb 2012 18:05:04 +0100
Message-ID: <4F3E88C0.10506@bsc.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:38999 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753480Ab2BQRPU (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 17 Feb 2012 12:15:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by opsmail01.bsc.es (Postfix) with ESMTP id 7F83FCFBB
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2012 18:05:06 +0100 (CET)
Received: from opsmail01.bsc.es ([127.0.0.1])
 by localhost (opswc01.bsc.es [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 05890-09 for <linux-perf-users@vger.kernel.org>;
 Fri, 17 Feb 2012 18:05:05 +0100 (CET)
Received: from opswc01.bsc.es (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPS id 719C931153
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2012 18:05:05 +0100 (CET)
Received: (from filter@localhost)
	by opswc01.bsc.es (8.13.6/8.13.6/Submit) id q1HH55kE007465
	for linux-perf-users@vger.kernel.org; Fri, 17 Feb 2012 18:05:05 +0100
Received: from [84.88.50.218] (unknown [84.88.50.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by opsmail01.bsc.es (Postfix) with ESMTPSA id 4A82B42968
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Feb 2012 18:05:05 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

I am developing an adaptive scheme in the linux kernel and I need to 
read performance counters for computing instructions per cycle (IPC).

In scheduler_tick() I call a function that performs an adaptive step and 
reads performance counters. Based on them it will take a decision. Next, 
I include a simplified scheme of the code.

void scheduler_tick(void)
{
     ...
     adaptive_scheme_tick();
     ...
}

void adaptive_scheme_tick(void) {
    ...
    cycles_value = perf_event_read_value(&cycles_event, ...);
    instrs_value = perf_event_read_value(&instrs_event, ...);
    /* take a decision based on PMCs values */
    ...
}

In a sense, the code actually works, since I am getting the expected 
values from the performance counters. However, the following warning is 
printed on the console:

------------[ cut here ]------------
WARNING: at kernel/smp.c:320
Modules linked in: adapt_module fuse dm_crypt
NIP: c0000000000cf960 LR: c00000000012f9f4 CTR: c00000000012fa00
REGS: c0000001dadff3f0 TRAP: 0700   Not tainted  (3.2.1-vjj)
MSR: 8000000000021032 <ME,CE,IR,DR>  CR: 42248822  XER: 20000018
CFAR: c0000000000cf880
TASK = c0000001dad08570[11403] 'leslie3d_base.X' THREAD: 
c0000001dadfc000 CPU: 4
GPR00: 0000000000000004 c0000001dadff670 c000000000bf0e10 0000000000000004
GPR04: c000000000b7e910 c0000003d0ca1800 0000000000000001 0000000000000001
GPR08: c000000000ce92b4 c00000000078eb00 0000000000000004 0000000000000001
GPR12: d000000004e117d8 c00000000edd0e00 000000000000000d 0000040007353d60
GPR16: 000001000f907e48 00000000001d11e0 0000000000000000 0000065e3112c049
GPR20: 0000000000000004 d000000004e127c0 c0000001dadff9b0 c0000001dadff9b8
GPR24: c0000003cfa1c000 c0000003d0ca1990 c0000003d0ca1800 c0000003d0ca1800
GPR28: c0000003cfa1c118 0000000000000000 c000000000b43280 c0000003d0ca1800
NIP [c0000000000cf960] .smp_call_function_single+0x120/0x1f0
LR [c00000000012f9f4] .perf_event_read+0x104/0x110
Call Trace:
[c0000001dadff670] [0000000000100100] 0x100100 (unreliable)
[c0000001dadff720] [c00000000012f9f4] .perf_event_read+0x104/0x110
[c0000001dadff7c0] [c00000000012fa54] .perf_event_read_value+0x54/0x120
[c0000001dadff940] [d000000004e10834] .adapt_scheme_tick+0xf4/0x360 
[adapt_module]
[c0000001dadff9e0] [c0000000000823c4] .scheduler_tick+0x194/0x460
[c0000001dadffab0] [c00000000009d65c] .update_process_times+0x6c/0xa0
[c0000001dadffb40] [c0000000000c899c] .tick_sched_timer+0x7c/0x100
[c0000001dadffbe0] [c0000000000b96ec] .__run_hrtimer+0xbc/0x270
[c0000001dadffc90] [c0000000000ba6c8] .hrtimer_interrupt+0x128/0x2c0
[c0000001dadffd90] [c00000000001df3c] .timer_interrupt+0xfc/0x290
[c0000001dadffe30] [c0000000000039a4] decrementer_common+0x124/0x180
Instruction dump:
7c0803a6 4e800020 60000000 60000000 e97e8020 816b0000 2f8b0000 409eff5c
e91e8028 89680000 696b0001 7d6707b4 <0b0b0000> 2fa70000 41feff40 39600001
---[ end trace cb6025f2b4bd27e8 ]---

At that point, I realized that perf_event_read_value() calls 
mutex_lock(), and therefore it is not safe to use that function in the 
context of the timer interrupt.

Is there any way to read PMCs from an interrupt context? If not, is it 
possible at all to build an adaptive scheme like the one I am trying to 
develop?

Thanks!
Victor

WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer.htm
