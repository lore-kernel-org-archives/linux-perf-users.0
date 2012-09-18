From: ulrik@kristnet.org
Subject: PEBS not supported even if CPU microcode is updated to  =?UTF-8?Q?=30x=32=38=3F?=
Date: Tue, 18 Sep 2012 08:48:48 +0200
Message-ID: <ca97dbdf5dd407af0aad762f63916959@kristnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from smtprelay-b21.telenor.se ([195.54.99.212]:45022 "EHLO
	smtprelay-b21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261Ab2IRGsv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 18 Sep 2012 02:48:51 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b21.telenor.se (Postfix) with ESMTP id D3074EA0DE
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Sep 2012 08:48:49 +0200 (CEST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

Perf does not seem to be able to handle PEBS, even with the new CPU 
0x28 microcode.

     sudo ./perf stat -e branches:pp "true"


  Performance counter stats for 'true':

    <not supported> branches:pp

        0.000717042 seconds time elapsed

The output from dmsg write "PEBS is disabled due to CPU errata" BEFORE 
the microcode is updated during the boot processs later. I guess that 
may be the problem?

What can I try more to get support for PEBS?

Thanks.

/Ulrik


...
[    0.003839] ACPI: Core revision 20120320
[    0.012024] ftrace: allocating 23614 entries in 93 pages
[    0.020716] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.120589] CPU0: Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz stepping 
07
[    0.237328] Performance Events: PEBS fmt1+, 16-deep LBR, SandyBridge 
events, Intel PMU driver.
[    0.237332] PEBS disabled due to CPU errata.
[    0.237333] ... version:                3
[    0.237334] ... bit width:              48
[    0.237334] ... generic registers:      4
[    0.237335] ... value mask:             0000ffffffffffff
[    0.237336] ... max period:             000000007fffffff
[    0.237336] ... fixed-purpose events:   3
[    0.237337] ... event mask:             000000070000000f
[    0.237434] Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 Ok.
[    0.329982] Brought up 8 CPUs
...
[   15.144230] microcode: CPU0 updated to revision 0x28, date = 
2012-04-24
[   15.144554] microcode: CPU1 updated to revision 0x28, date = 
2012-04-24
[   15.144897] microcode: CPU2 updated to revision 0x28, date = 
2012-04-24
[   15.145245] microcode: CPU3 updated to revision 0x28, date = 
2012-04-24
[   15.145573] microcode: CPU4 updated to revision 0x28, date = 
2012-04-24
[   15.145923] microcode: CPU5 updated to revision 0x28, date = 
2012-04-24
[   15.146269] microcode: CPU6 updated to revision 0x28, date = 
2012-04-24
[   15.146615] microcode: CPU7 updated to revision 0x28, date = 
2012-04-24

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 42
model name      : Intel(R) Core(TM) i7-2600 CPU @ 3.40GHz
stepping        : 7
microcode       : 0x28
cpu MHz         : 1600.000
cache size      : 8192 KB
physical id     : 0
siblings        : 8
core id         : 0
cpu cores       : 4
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl 
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx 
smx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt 
tsc_deadline_timer aes xsave avx lahf_lm ida arat epb xsaveopt pln pts 
dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips        : 7004.38
clflush size    : 64
cache_alignment : 64
address sizes   : 36 bits physical, 48 bits virtual
power management:

I'm running Kernel 3.5.4 with the patch 
https://patchwork.kernel.org/patch/1329691/
