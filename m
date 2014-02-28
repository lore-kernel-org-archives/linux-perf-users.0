From: Muthusamy <muthu9283@yahoo.com>
Subject: unable to get load latency info
Date: Thu, 27 Feb 2014 22:24:39 -0800 (PST)
Message-ID: <1393568679.86476.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Reply-To: Muthusamy <muthu9283@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from nm17-vm6.bullet.mail.ne1.yahoo.com ([98.138.91.110]:43412 "EHLO
	nm17-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750795AbaB1Gbm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 28 Feb 2014 01:31:42 -0500
References: 
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Hi,

I am trying to get the memory load latency info using perf, but I am al=
ways getting 0.
Can you please help me in understanding what I am missing. Below are th=
e details

[root@rafa tmp]# ./perf --version
perf version 3.12.11
[root@rafa tmp]# ./perf stat -e r100b pwd =A0### (I have tried with oth=
er data intensive programs too)
/tmp/cms/tmp

=A0Performance counter stats for 'pwd':

=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 r100b =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0=A0

=A0 =A0 =A0 =A00.000846849 seconds time elapsed

[root@rafa tmp]# uname -a
Linux rafa 2.6.32-431.el6.x86_64 #1 SMP Sun Nov 10 22:19:54 EST 2013 x8=
6_64 x86_64 x86_64 GNU/Linux

[root@rafa tmp]# cat /proc/cpuinfo
processor: 0
vendor_id: GenuineIntel
cpu family: 6
model: 26
model name: Intel(R) Xeon(R) CPU =A0 =A0 =A0 =A0 =A0 X5550 =A0@ 2.67GHz
stepping
: 5
cpu MHz: 1600.000
cache size: 8192 KB
physical id: 0
siblings: 1
core id: 0
cpu cores: 1
apicid: 0
initial apicid: 0
fpu: yes
fpu_exception: yes
cpuid level: 11
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdts=
cp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc=
 aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm =
dca sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority e=
pt vpid
bogomips: 5333.09
clflush size: 64
cache_alignment: 64
address sizes: 40 bits physical, 48 bits virtual
power management:

processor: 1
vendor_id
: GenuineIntel
cpu family: 6
model: 26
model name: Intel(R) Xeon(R) CPU =A0 =A0 =A0 =A0 =A0 X5550 =A0@ 2.67GHz
stepping: 5
cpu MHz: 1600.000
cache size: 8192 KB
physical id
: 1
siblings: 1
core id: 0
cpu cores: 1
apicid: 16
initial apicid: 16
fpu: yes
fpu_exception: yes
cpuid level: 11
wp: yes
flags: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pa=
t pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdts=
cp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc=
 aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm =
dca sse4_1 sse4_2 popcnt lahf_lm ida dts tpr_shadow vnmi flexpriority e=
pt vpid
bogomips: 5332.56
clflush size: 64
cache_alignment: 64
address sizes: 40 bits physical, 48 bits virtual
power management:

[root@rafa tmp]#

Let me know if any other details are also required and steps on how to =
get them.

Thanks,
Muthusamy C
