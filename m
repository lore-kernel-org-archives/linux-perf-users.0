From: "H. Taheri" <rezato@gmail.com>
Subject: Not getting PMC events on Broadwell-EX
Date: Mon, 7 Aug 2017 21:37:19 -0700
Message-ID: <B10BA2E5-3BC7-481F-8EC7-DFEB229526EC@vmware.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:34636 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750801AbdHHEhb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 8 Aug 2017 00:37:31 -0400
Received: by mail-pg0-f52.google.com with SMTP id u185so9957749pgb.1
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Aug 2017 21:37:31 -0700 (PDT)
Received: from [192.168.1.158] (c-24-130-222-229.hsd1.ca.comcast.net. [24.130.222.229])
        by smtp.gmail.com with ESMTPSA id o15sm528922pgf.22.2017.08.07.21.37.29
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Aug 2017 21:37:29 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi experts,
I am getting 0s, or <not supported>, or <not counted>  for events that =
are supposed to work on this processor. For example, according to Intel =
documentation, L2_RQSTS.MISS and L2_RQSTS.REFERENCES are supported on =
this processor with event code 0x24 and unit masks 0x3f and 0xff. But =
when I run perf stat (also with -d -d -d to see if the built-in command =
options can get the cache stats), I get:

[root@prme-perf-broadwell-2 intel]# perf stat -d -d -d -e cycles -e =
instructions -e r24ff -e r243f sleep 10

Performance counter stats for 'sleep 10':

          295,132      cycles                                            =
        =20
          676,801      instructions              #    2.29  insn per =
cycle       =20
                0      r24ff                                             =
        =20
                0      r243f                                             =
        =20
          175,865      L1-dcache-loads                                   =
        =20
           12,686      L1-dcache-load-misses     #    7.21% of all =
L1-dcache hits    (67.93%)
    <not counted>      LLC-loads                                         =
            (0.00%)
    <not counted>      LLC-load-misses                                   =
            (0.00%)
  <not supported>      L1-icache-loads                                   =
        =20
    <not counted>      L1-icache-load-misses                             =
            (0.00%)
    <not counted>      dTLB-loads                                        =
            (0.00%)
    <not counted>      dTLB-load-misses                                  =
            (0.00%)
    <not counted>      iTLB-loads                                        =
            (0.00%)
    <not counted>      iTLB-load-misses                                  =
            (0.00%)
  <not supported>      L1-dcache-prefetches                              =
        =20
  <not supported>      L1-dcache-prefetch-misses                         =
        =20

     10.001308205 seconds time elapsed


This is the /proc/cpuinfo from the guest:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 79
model name      : Intel(R) Xeon(R) CPU E7-8890 v4 @ 2.20GHz
stepping        : 1
microcode       : 0xb00001d
cpu MHz         : 1200.031
cache size      : 30720 KB
physical id     : 0
siblings        : 48
core id         : 0
cpu cores       : 24
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge =
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe =
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good =
nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 =
monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid dca sse4_1 =
sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand =
lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm intel_pt =
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle avx2 =
smep bmi2 erms invpcid rtm cqm rdseed adx smap xsaveopt cqm_llc =
cqm_occup_llc cqm_mbm_total cqm_mbm_local
bogomips        : 4388.87
clflush size    : 64
cache_alignment : 64
address sizes   : 46 bits physical, 48 bits virtual
power management:

Thanks,
Reza
