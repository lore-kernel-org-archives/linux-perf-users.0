From: sahil aggarwal <sahil.agg15@gmail.com>
Subject: Re: Sampling on sched:sched_switch
Date: Tue, 14 Apr 2015 18:00:17 +0530
Message-ID: <CAGAANTUAJJmBBSRijursj2VxCg=1kbEP90BRMW2-J0S83tzRug@mail.gmail.com>
References: <CAGAANTU3HMoZCNsN=PAWCb8Pqx89ZyO3aQcibXKN+ZxMx1MAOA@mail.gmail.com>
	<20150413151148.GI3200@kernel.org>
	<CAGAANTXY8UiP2yRUg5tVBB+PQdH8=X27MKUj=nSHvWHk-x5MJQ@mail.gmail.com>
	<20150414121559.GD16027@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:35187 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243AbbDNMaS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 14 Apr 2015 08:30:18 -0400
Received: by oign205 with SMTP id n205so563040oig.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2015 05:30:17 -0700 (PDT)
In-Reply-To: <20150414121559.GD16027@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: linux-perf-users@vger.kernel.org

> So, there are some critical pieces of information missing here:
>
> - perf --version

bash-4.1# perf --version
perf version 3.2.17

> - cat /proc/cpuinfo

processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 45
model name : Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz
stepping : 7
microcode : 0x70d
cpu MHz : 3299.897
cache size : 10240 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 4
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln
pts dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 6599.79
clflush size : 64
cache_alignment : 64
address sizes : 46 bits physical, 48 bits virtual
power management:

processor : 1
vendor_id : GenuineIntel
cpu family : 6
model : 45
model name : Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz
stepping : 7
microcode : 0x70d
cpu MHz : 3299.897
cache size : 10240 KB
physical id : 0
siblings : 4
core id : 3
cpu cores : 4
apicid : 6
initial apicid : 6
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx
pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl
xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl
vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca sse4_1 sse4_2 x2apic
popcnt tsc_deadline_timer aes xsave avx lahf_lm ida arat xsaveopt pln
pts dtherm tpr_shadow vnmi flexpriority ept vpid
bogomips : 6600.30
clflush size : 64
cache_alignment : 64
address sizes : 46 bits physical, 48 bits virtual
power management:

> - uname -a
bash-4.1# uname -a
Linux ops-es2 3.2.66-amd64 #1 SMP Wed Mar 4 16:29:30 IST 2015 x86_64 GNU/Linux

> [root@zoo ~]# cat /sys/kernel/debug/events/sched/sched_switch/format
> name: sched_switch
> ID: 263

bash-4.1# cat /sys/kernel/debug/tracing/events/sched/sched_switch/id
87

> So you have two counters, one in each CPU, for the same thread? What is
> the intent?
I have multiple tracepoints(say ~20-25), i tried it to enable them for
all CPU's but when i do attr->inherit = 1, it doesnt mmap the FD(
Gives EINVAL). When i digged the perf code a bit, i found :

if (evlist->cpus->map[0] < 0)
                no_inherit = true;

So, i thought may be it doesn't allow trace on all CPU's when i
inherit. Does that make sense.?
