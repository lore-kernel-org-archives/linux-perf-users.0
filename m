From: Harald Servat <harald.servat@bsc.es>
Subject: Re: unable to get load latency info
Date: Fri, 28 Feb 2014 11:43:25 +0100
Message-ID: <5310684D.7000001@bsc.es>
References: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:57908 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407AbaB1Kn3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 05:43:29 -0500
In-Reply-To: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Muthusamy <muthu9283@yahoo.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>


On 28/02/14 07:24, Muthusamy wrote:
> Hi,
>
> I am trying to get the memory load latency info using perf, but I am always getting 0.
> Can you please help me in understanding what I am missing. Below are the details
>
> [root@rafa tmp]# ./perf --version
> perf version 3.12.11
> [root@rafa tmp]# ./perf stat -e r100b pwd  ### (I have tried with other data intensive programs too)
> /tmp/cms/tmp
>
>   Performance counter stats for 'pwd':
>
>                   0 r100b
>
>         0.000846849 seconds time elapsed
>
> [root@rafa tmp]# uname -a
> Linux rafa 2.6.32-431.el6.x86_64 #1 SMP Sun Nov 10 22:19:54 EST 2013 x86_64 x86_64 x86_64 GNU/Linux
>
> [root@rafa tmp]# cat /proc/cpuinfo
> processor: 0
> vendor_id: GenuineIntel
> cpu family: 6
> model: 26
> model name: Intel(R) Xeon(R) CPU           X5550  @ 2.67GHz
> stepping
> : 5
> cpu MHz: 1600.000
> cache size: 8192 KB
> physical id: 0
> siblings: 1
> core id: 0
> cpu cores: 1
> apicid: 0
> initial apicid: 0
> fpu: yes
> fpu_exception: yes
> cpuid level: 11
> wp: yes
> flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
> bogomips: 5333.09
> clflush size: 64
> cache_alignment: 64
> address sizes: 40 bits physical, 48 bits virtual
> power management:
>
> processor: 1
> vendor_id
> : GenuineIntel
> cpu family: 6
> model: 26
> model name: Intel(R) Xeon(R) CPU           X5550  @ 2.67GHz
> stepping: 5
> cpu MHz: 1600.000
> cache size: 8192 KB
> physical id
> : 1
> siblings: 1
> core id: 0
> cpu cores: 1
> apicid: 16
> initial apicid: 16
> fpu: yes
> fpu_exception: yes
> cpuid level: 11
> wp: yes
> flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority ept vpid
> bogomips: 5332.56
> clflush size: 64
> cache_alignment: 64
> address sizes: 40 bits physical, 48 bits virtual
> power management:
>
> [root@rafa tmp]#
>
> Let me know if any other details are also required and steps on how to get them.
>
> Thanks,
> Muthusamy C

Hello Muthusamy,

   I have obtained load latency info through perf record + perf report, 
but never used perf stat to do that. I don't know if this is what you're 
looking for, but maybe you can give this a try.

   To capture the latency for an app (say /bin/ls)

   # perf mem record /bin/ls

   Then, to show the summary of the results (which part of the cache 
hierarchy provided the data for the references) you can use:

   # perf mem report

   Additionally, if you want to know the cost in cycles of every memory 
reference captured by PEBS, execute:

   # perf mem report -D

   in that output, each PERF_RECORD_SAMPLE reflects a sample, and its 
weight is the latency in cycles that the CPU was waiting for that reference.

   Hope that helps.

Regards.






WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
