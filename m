Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAF6192D80
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Jan 2025 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735847406; cv=none; b=DNZls2nkP1tBn6PGVQIcVZs8xpEPIhlNnVVwp/G41qLTjSz3Poqnm+Y4Ghi03nBDi/5ss3jqtIfqTDblUdNwP6YTRMu1tQiDMbFGf2XSjmuSNP8xjXBL0qJVb7aFQSPUapLHJZTeIQ1Wi7xxuAKqQOw10z88Sx+mdfTyPl3vetM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735847406; c=relaxed/simple;
	bh=X5sw4PPdVXGZIQRjyDkzDEenHviXB9I41+vLR4/RFIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jloyx4J6odkhwXMQx/g1OPm0VwltT17mm0TPqiFPhXjrPs9oJBk10rGfXxR6tr8WBxhLUBLu4+yNt08n6EtAOcaoKSCMEDvSajwFtYFSqAYUUJ3d/MoTZdJUwCafEpWYA3YEhsP8g242tJxNO2TGIkJyk3obfG3nCYPSvMzAK1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YPHD36QfDz9sgV;
	Thu,  2 Jan 2025 20:42:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk9QnE-IXvT8; Thu,  2 Jan 2025 20:42:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YPHD34pBXz9sgJ;
	Thu,  2 Jan 2025 20:42:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8F5038B767;
	Thu,  2 Jan 2025 20:42:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xWRbwH8VNS4s; Thu,  2 Jan 2025 20:42:27 +0100 (CET)
Received: from [192.168.232.97] (unknown [192.168.232.97])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E87728B763;
	Thu,  2 Jan 2025 20:42:26 +0100 (CET)
Message-ID: <48724052-4003-4140-8106-f9ea098cedcb@csgroup.eu>
Date: Thu, 2 Jan 2025 20:42:26 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Perf doesn't display kernel symbols anymore (bisected commit
 659ad3492b91 ("perf maps: Switch from rbtree to lazily sorted array for
 addresses"))
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>
References: <719a89a5-8dff-48a0-ba8f-802c740a00a6@csgroup.eu>
 <53f3abe5-dd22-4a1a-82e6-bc88e91d1869@linaro.org> <Z217eBsXIaSgKuSs@x1>
 <5217124a-f033-4085-b9f5-a477c96728d6@csgroup.eu> <Z3bYltoidQpqtyJ_@x1>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Z3bYltoidQpqtyJ_@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 02/01/2025 à 19:19, Arnaldo Carvalho de Melo a écrit :
> On Thu, Jan 02, 2025 at 03:41:17PM +0100, Christophe Leroy wrote:
>> Le 26/12/2024 à 16:51, Arnaldo Carvalho de Melo a écrit :
>>> On Tue, Dec 17, 2024 at 02:18:07PM +0000, James Clark wrote:
>>>> On 16/12/2024 7:01 am, Christophe Leroy wrote:
>>>>> I noticed with 6.12 LTS Kernel that perf top and perf record/report
>>>>> don't display kernel symbols anymore, instead it displays the raw
>>>>> address with [unknown] as object.
> 
>>>>> After bisect I see that the problem appears with commit 659ad3492b91
>>>>> ("perf maps: Switch from rbtree to lazily sorted array for addresses").
>>>> You might want to try applying 0b90dfda222e3 as it claims to fix this
>>>> commit. I doubt that will fix your issue but it's worth being sure.
>>>> There was also another fix recently that could be related: 23c44f6c83
>>>> Did you try the perf-tools-next branch? Maybe something that's already fixed
>>>> needs to be backported.
> 
>>> Right, I tried reproducing this on perf-tools-next and couldn't, so
>>> please test it there.
>   
>> I tested it again on latest perf-tools-next (ed60738a9b7e ("perf stat:
>> Document and clarify outstate members")) and still have the same problem,
>> all kernel symbols appear as [unknown]:
>   
>>     PerfTop:    4163 irqs/sec  kernel:28.3%  exact:  0.0% lost: 0/0 drop:
>> 0/14199 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
> 
> So this seems to be on a virt environment? Or have you explicitely used
> '-e cpu-clock:ppp'?

It is a real HW and I have _not_ used -e cpu-clock:ppp

root@vgoippro:~# cat /proc/cpuinfo
processor       : 0
cpu             : e300c2
clock           : 333.333335MHz
revision        : 1.1 (pvr 8084 0011)
bogomips        : 66.66

timebase        : 33333333
platform        : CMPCPRO
model           : MIAE
Memory          : 512 MB


> 
> Also can you please run with -v or with -vv to see if we can get some
> more clues?

Sure, see at the end (first is the one that fails, followed by the one 
that works)

> 
> Maybe it is somehow not able to read kallsyms or find a suitable
> vmlinux?

There's no vmlinux but it should be able to read kallsyms as it does 
with earlier version

> 
> Also what distro is this?

No distro, it's raw embedded system built from scratch with gcc 12.3 and 
glibc 2.38

> 
> I did one more test, this time using --stdio on a raspberry pi and
> explicitely using '-e cycles:ppp' to get as close to your report as I
> could:
> 
> root@raspberrypi:~# uname -a
> Linux raspberrypi 6.6.51+rpt-rpi-v7 #1 SMP Raspbian 1:6.6.51-1+rpt3 (2024-10-08) armv7l GNU/Linux
> root@raspberrypi:~# ~acme/bin/perf --version
> perf version 6.13.rc2.ged60738a9b7e
> root@raspberrypi:~# timeout 5s ~acme/bin/perf top -e cpu-cycles:ppp --stdio
>     PerfTop:     926 irqs/sec  kernel:79.8%  exact:  0.0% lost: 0/0 drop: 0/0 [4000Hz cpu-cycles:ppp],  (all, 4 CPUs)

root@vgoippro:~# uname -a
Linux vgoippro 6.12.4-01797-g8ba9a9738762 #556 PREEMPT Sun Dec 15 
19:22:33 CET 2024 ppc GNU/Linux

root@vgoippro:~# ./perf --version
perf version 6.13.rc2.ged60738a9b7e

root@vgoippro:~# timeout 5s ./perf top --stdio

    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

    PerfTop:     524 irqs/sec  kernel:51.1%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

     17.18%  [unknown]      [k] 0xc0891c14
      7.63%  [unknown]      [k] 0xc005f11c
      4.48%  libc.so.6      [.] _nss_files_parse_servent
      4.10%  gau            [.] engine_loop.constprop.0.isra.0
      3.91%  libc.so.6      [.] memset
      3.24%  libc.so.6      [.] strcspn
      3.05%  libc.so.6      [.] __GI_____strtoul_l_internal
      2.48%  libc.so.6      [.] memcpy
      2.19%  libc.so.6      [.] memchr
      2.00%  libc.so.6      [.] _wordcopy_fwd_dest_aligned
      2.00%  [unknown]      [k] 0xc005f0f8
      1.81%  libc.so.6      [.] _IO_getline_info
      1.81%  libc.so.6      [.] strlen
      1.72%  libc.so.6      [.] strcmp
      1.62%  libc.so.6      [.] __ftello64
      1.62%  libc.so.6      [.] internal_getent
      1.53%  libc.so.6      [.] _IO_seekoff_unlocked
      1.15%  libc.so.6      [.] __nss_readline
      1.05%  libc.so.6      [.] _wordcopy_fwd_aligned
      1.05%  [unknown]      [k] 0xc01f82c8


As a comparison, the following one works:

root@vgoippro:~# ./perf-good --version
perf version 6.8.rc1.g39d14c0dd650

root@vgoippro:~# timeout 6s ./perf-good  top --stdio

    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

    PerfTop:     451 irqs/sec  kernel:31.7%  exact:  0.0% lost: 0/0 
drop: 7575/7575 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

      9.60%  perf-good      [.] io__get_char
      6.40%  perf-good      [.] __symbols__insert
      5.19%  gau            [.] engine_loop.constprop.0.isra.0
      4.08%  [kernel]       [k] finish_task_switch.isra.0
      3.64%  perf-good      [.] kallsyms__parse
      3.20%  libc.so.6      [.] memset
      2.98%  [kernel]       [k] kallsyms_expand_symbol.constprop.0
      2.65%  libc.so.6      [.] memcpy
      2.54%  [kernel]       [k] format_decode
      2.43%  libc.so.6      [.] __libc_calloc
      2.32%  libc.so.6      [.] _wordcopy_fwd_dest_aligned
      2.32%  perf-good      [.] io__get_hex
      1.99%  libc.so.6      [.] __GI_____strtoul_l_internal
      1.88%  libc.so.6      [.] _int_malloc
      1.88%  libc.so.6      [.] got_label
      1.77%  libc.so.6      [.] _nss_files_parse_servent
      1.66%  libc.so.6      [.] strcspn
      1.66%  perf-good      [.] strlist__node_cmp
      1.55%  [kernel]       [k] __copy_tofrom_user
      1.55%  [kernel]       [k] string


Here is the output with -vv of the one that fails:

Using CPUID 0x80840011
Problems creating module maps, continuing anyway...
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       3
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (2)
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       2
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (1)
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       1
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (0)
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Warning:
The cycles event is not supported, trying to fall back to cpu-clock
------------------------------------------------------------
perf_event_attr:
   type                             1 (software)
   size                             136
   config                           0 (PERF_COUNT_SW_CPU_CLOCK)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       3
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
mmap size 528384B
0x11b71568: mmap mask[0]:
Missing PLT entry size for /lib/libc.so.6
Missing PLT entry size for /usr/local/bin/gau
Missing PLT entry size for /root/perf
Missing PLT entry size for /lib/libelf-0.176.so
[H[2J
    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

[H[2J
    PerfTop:     259 irqs/sec  kernel:86.1%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

     35.33%  [unknown]           0xc0891c14 ! [k] 0xc0891c14
---------- end
     12.93%  [unknown]           0xc005f11c ! [k] 0xc005f11c
Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
Map: f900000-f909000 0 /lib/libcrypt.so.1
Map: f920000-f921000 10000 /lib/libcrypt.so.1
Map: f921000-f948000 0 /tmp/perf-863.map
Map: f950000-fb4f000 0 /lib/libc.so.6
Map: fb70000-fb74000 220000 /lib/libc.so.6
Map: fb74000-fb7e000 0 /tmp/perf-863.map
Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
Map: fdf1000-fdf7000 0 /tmp/perf-863.map
Map: fe00000-fe59000 0 /lib/libdw-0.176.so
Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
Map: ff10000-ffe0000 0 /lib/libm.so.6
Map: fff0000-fff1000 d0000 /lib/libm.so.6
Map: 10000000-10341000 0 /root/perf
Map: 10360000-1036a000 360000 /root/perf
Map: 1036a000-1036f000 0 /tmp/perf-863.map
Map: b77f2000-b77f9000 0 [vdso]
Map: b77fe000-b782e000 0 /lib/ld.so.1
Map: b783e000-b7840000 40000 /lib/ld.so.1
---------- end
      4.83%  /usr/local/bin/gau  0x7218c    d [.] 
engine_loop.constprop.0.isra.
      4.63%  [unknown]           0xc005f0f8 ! [k] 0xc005f0f8
Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
Map: f900000-f909000 0 /lib/libcrypt.so.1
Map: f920000-f921000 10000 /lib/libcrypt.so.1
Map: f921000-f948000 0 /tmp/perf-863.map
Map: f950000-fb4f000 0 /lib/libc.so.6
Map: fb70000-fb74000 220000 /lib/libc.so.6
Map: fb74000-fb7e000 0 /tmp/perf-863.map
Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
Map: fdf1000-fdf7000 0 /tmp/perf-863.map
Map: fe00000-fe59000 0 /lib/libdw-0.176.so
Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
Map: ff10000-ffe0000 0 /lib/libm.so.6
Map: fff0000-fff1000 d0000 /lib/libm.so.6
Map: 10000000-10341000 0 /root/perf
Map: 10360000-1036a000 360000 /root/perf
Map: 1036a000-1036f000 0 /tmp/perf-863.map
Map: b77f2000-b77f9000 0 [vdso]
Map: b77fe000-b782e000 0 /lib/ld.so.1
Map: b783e000-b7840000 40000 /lib/ld.so.1
---------- end
      1.93%  [unknown]           0xc0067d90 ! [k] 0xc0067d90
---------- end
      1.35%  [unknown]           0xc0011718 ! [k] 0xc0011718
Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
Map: f900000-f909000 0 /lib/libcrypt.so.1
Map: f920000-f921000 10000 /lib/libcrypt.so.1
Map: f921000-f948000 0 /tmp/perf-863.map
Map: f950000-fb4f000 0 /lib/libc.so.6
Map: fb70000-fb74000 220000 /lib/libc.so.6
Map: fb74000-fb7e000 0 /tmp/perf-863.map
Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
Map: fdf1000-fdf7000 0 /tmp/perf-863.map
Map: fe00000-fe59000 0 /lib/libdw-0.176.so
Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
Map: ff10000-ffe0000 0 /lib/libm.so.6
Map: fff0000-fff1000 d0000 /lib/libm.so.6
Map: 10000000-10341000 0 /root/perf
Map: 10360000-1036a000 360000 /root/perf
Map: 1036a000-1036f000 0 /tmp/perf-863.map
Map: b77f2000-b77f9000 0 [vdso]
Map: b77fe000-b782e000 0 /lib/ld.so.1
Map: b783e000-b7840000 40000 /lib/ld.so.1
------Missing PLT entry size for /lib/nof/libstdc++.so.6.0.30
---- end
      1.16%  [unknown]           0xc001a90c ! [k] 0xc001a90c
Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
Map: f900000-f909000 0 /lib/libcrypt.so.1
Map: f920000-f921000 10000 /lib/libcrypt.so.1
Map: f921000-f948000 0 /tmp/perf-863.map
Map: f950000-fb4f000 0 /lib/libc.so.6
Map: fb70000-fb74000 220000 /lib/libc.so.6
Map: fb74000-fb7e000 0 /tmp/perf-863.map
Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
Map: fdf1000-fdf7000 0 /tmp/perf-863.map
Map: fe00000-fe59000 0 /lib/libdw-0.176.so
Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
Map: ff10000-ffe0000 0 /lib/libm.so.6
Map: fff0000-fff1000 d0000 /lib/libm.so.6
Map: 10000000-10341000 0 /root/perf
Map: 10360000-1036a000 360000 /root/perf
Map: 1036a000-1036f000 0 /tmp/perf-863.map
Map: b77f2000-b77f9000 0 [vdso]
Map: b77fe000-b782e000 0 /lib/ld.so.1
Map: b783e000-b7840000 40000 /lib/ld.so.1
---------- end
      0.97%  [unknown]           0xc0067da0 ! [k] 0xc0067da0
---------- end
      0.97%  [unknown]           0xc0891c18 ! [k] 0xc0891c18
---------- end
      0.77%  [unknown]           0xc001a908 ! [k] 0xc001a908
Map: f8c0000-f8dc000 0 /lib/nof/libgcc_s.so.1
Map: f8f0000-f8f1000 20000 /lib/nof/libgcc_s.so.1
Map: f900000-f909000 0 /lib/libcrypt.so.1
Map: f920000-f921000 10000 /lib/libcrypt.so.1
Map: f921000-f948000 0 /tmp/perf-863.map
Map: f950000-fb4f000 0 /lib/libc.so.6
Map: fb70000-fb74000 220000 /lib/libc.so.6
Map: fb74000-fb7e000 0 /tmp/perf-863.map
Map: fb80000-fdd8000 0 /lib/nof/libstdc++.so.6.0.30
Map: fdf0000-fdf1000 260000 /lib/nof/libstdc++.so.6.0.30
Map: fdf1000-fdf7000 0 /tmp/perf-863.map
Map: fe00000-fe59000 0 /lib/libdw-0.176.so
Map: fe70000-fe71000 60000 /lib/libdw-0.176.so
Map: fe80000-fe9b000 0 /lib/libelf-0.176.so
Map: feb0000-feb1000 20000 /lib/libelf-0.176.so
Map: fec0000-fee2000 0 /lib/libz.so.1.2.12
Map: ff00000-ff01000 30000 /lib/libz.so.1.2.12
Map: ff10000-ffe0000 0 /lib/libm.so.6
Map: fff0000-fff1000 d0000 /lib/libm.so.6
Map: 10000000-10341000 0 /root/perf
Map: 10360000-1036a000 360000 /root/perf
Map: 1036a000-1036f000 0 /tmp/perf-863.map
Map: b77f2000-b77f9000 0 [vdso]
Map: b77fe000-b782e000 0 /lib/ld.so.1
Map: b783e000-b7840000 40000 /lib/ld.so.1
---------- end
      0.77%  [unknown]           0xc0067d54 ! [k] 0xc0067d54
---------- end
      0.77%  [unknown]           0xc0067d94 ! [k] 0xc0067d94
---------- end
      0.77%  [unknown]           0xc0891c10 ! [k] 0xc0891c10
---------- end
      0.58%  /lib/libc.so.6      0x94f3c    d [.] 
__GI___pthread_disable_asyncc
      0.58%  /lib/libc.so.6      0xaed94    d [.] malloc
      0.58%  /root/perf          0x143c00   d [.] ordered_events__queue
      0.58%  [unknown]           0xc002d720 ! [k] 0xc002d720
---------- end
      0.58%  [unknown]           0xc0067d4c ! [k] 0xc0067d4c
---------- end
      0.58%  [unknown]           0xc0067da4 ! [k] 0xc0067da4
---------- end
      0.58%  [unknown]           0xc00a781c ! [k] 0xc00a781c


Here is the output of the one that works:

Using CPUID 0x80840011
Problems creating module maps, continuing anyway...
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       3
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (2)
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       2
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (1)
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       1
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
decreasing precise_ip by one (0)
------------------------------------------------------------
perf_event_attr:
   type                             0 (PERF_TYPE_HARDWARE)
   size                             136
   config                           0 (PERF_COUNT_HW_CPU_CYCLES)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8
sys_perf_event_open failed, error -2
Warning:
The cycles event is not supported, trying to fall back to cpu-clock
------------------------------------------------------------
perf_event_attr:
   type                             1 (PERF_TYPE_SOFTWARE)
   size                             136
   config                           0 (PERF_COUNT_SW_CPU_CLOCK)
   { sample_period, sample_freq }   4000
   sample_type                      IP|TID|TIME|CPU|PERIOD
   read_format                      ID|LOST
   disabled                         1
   inherit                          1
   mmap                             1
   comm                             1
   freq                             1
   task                             1
   precise_ip                       3
   sample_id_all                    1
   mmap2                            1
   comm_exec                        1
   ksymbol                          1
   bpf_event                        1
------------------------------------------------------------
sys_perf_event_open: pid -1  cpu 0  group_fd -1  flags 0x8 = 3
mmap size 528384B
0x11ed8e18: mmap mask[0]:
Missing PLT entry size for /lib/libc.so.6
Looking at the vmlinux_path (8 entries long)
symsrc__init: cannot get elf header.
Using /proc/kallsyms for symbols
Missing PLT entry size for /usr/local/bin/gau
Missing PLT entry size for /root/perf-good
Failed to open /tmp/perf-887.map, continuing without symbols
[H[2J
    PerfTop:       0 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

[H[2J
    PerfTop:       1 irqs/sec  kernel: 0.0%  exact:  0.0% lost: 0/0 
drop: 0/0 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

    100.00%  /lib/libc.so.6  0x46e64    d [.] __libc_sigaction
[H[2J
    PerfTop:      99 irqs/sec  kernel:41.4%  exact:  0.0% lost: 0/0 
drop: 7841/7841 [4000Hz cpu-clock:ppp],  (all, 1 CPU)
-------------------------------------------------------------------------------

     13.51%  /root/perf-good     0x1e83f4   d [.] io__get_char
      8.01%  /root/perf-good     0xd6f7c    d [.] __symbols__insert
      6.50%  /usr/local/bin/gau  0x72194    d [.] 
engine_loop.constprop.0.isra.
      6.50%  [kernel.kallsyms]   0xc005f11c k [k] finish_task_switch.isra.0
      5.00%  /root/perf-good     0x1e8a24   d [.] kallsyms__parse
      5.00%  [kernel.kallsyms]   0xc0886ed0 k [k] number
      3.50%  [kernel.kallsyms]   0xc00c3644 k [k] 
kallsyms_expand_symbol.constp
      3.00%  /lib/libc.so.6      0xadc6c    d [.] _int_malloc
      3.00%  [kernel.kallsyms]   0xc088557c k [k] format_decode
      3.00%  [kernel.kallsyms]   0xc01f82c8 k [k] timerfd_read_iter
      3.00%  [kernel.kallsyms]   0xc088b920 k [k] vsnprintf
      2.50%  /lib/libc.so.6      0xb5d10    d [.] strcmp
      2.50%  [kernel.kallsyms]   0xc0888bc4 k [k] string
      2.00%  /root/perf-good     0xcc854    d [.] strlist__node_cmp
      2.00%  /root/perf-good     0xd6c10    d [.] symbol__new
      1.50%  /lib/libc.so.6      0xbcbb4    d [.] _wordcopy_fwd_aligned
      1.50%  /lib/libc.so.6      0xb4ae4    d [.] memset
      1.50%  /root/perf-good     0x1e8618   d [.] io__get_hex
      1.50%  [kernel.kallsyms]   0xc001a860 k [k] __copy_tofrom_user
      1.50%  [kernel.kallsyms]   0xc01f5248 k [k] do_epoll_wait


Thanks for your help
Christophe
