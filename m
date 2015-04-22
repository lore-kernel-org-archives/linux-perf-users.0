From: Daniel Ortiz <daniel.ortiz@tum.de>
Subject: "precise" not supported when executing perf mem
Date: Wed, 22 Apr 2015 15:33:18 +0000 (UTC)
Message-ID: <mh8evt$ean$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44548 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932241AbbDWHzH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Apr 2015 03:55:07 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1YlByS-0001GN-3z
	for linux-perf-users@vger.kernel.org; Thu, 23 Apr 2015 09:55:04 +0200
Received: from host198-2.natpool.mwn.de ([138.246.2.198])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2015 09:55:04 +0200
Received: from daniel.ortiz by host198-2.natpool.mwn.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2015 09:55:04 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hello

When I try to run perf mem I obtain the following error:

do@nux:~/perf$ sudo perf mem record ls
Error:
'precise' request may not be supported. Try removing 'p' modifier.

This happens despite cpuinfo reporting that the processor supports
PEBS. What could I be missing here that does not allow perf mem to work?

I am running a 64 bit system on Xubuntu with 4GB Ram, I am building perf
myself, but the error also appears with the precompiled version.

Regards

Daniel

My kernel: Linux nux 3.16.0-34-generic #47-Ubuntu SMP 
perf: perf version 3.16.7-ckt8


Some cpuinfo output:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 42
model name	: Intel(R) Core(TM) i3-2367M CPU @ 1.40GHz
stepping	: 7
microcode	: 0x23
cpu MHz		: 848.039
cache size	: 3072 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 2
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer xsave avx lahf_lm arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid
