From: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Subject: Re: What perf_event_paranoid can do?
Date: Tue, 22 Mar 2011 09:10:41 +0800
Message-ID: <20110322011041.GA73124@cs.nctu.edu.tw>
References: <20110321061435.GA52815@cs.nctu.edu.tw>
 <AANLkTimJ36H76Z77AmauMWtZ9hOM62X1Y2jJa5H6fxWa@mail.gmail.com>
 <20110321095643.GA57074@cs.nctu.edu.tw>
 <AANLkTik3FT02nBPoKRh66hGA+bT7dPe2Vc0DK9HNmu7C@mail.gmail.com>
 <AANLkTi=Z0Y6nsr-QOBCtLOJMJ_eQHyQ28CjTd4pUyujk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:39269 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754880Ab1CVBKq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Mar 2011 21:10:46 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTi=Z0Y6nsr-QOBCtLOJMJ_eQHyQ28CjTd4pUyujk@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Lin Ming <minggr@gmail.com>
Cc: linux-perf-users@vger.kernel.org, =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi, Lin

> > Does your CPU support PEBS? Please attach below output.
> >
> > dmesg |grep "Performance Events"
>
> And also "cat /proc/cpuinfo"

  The attachment are output of dmesg and cpuinfo. Thanks.

Regards,
chenwj

--=20
Wei-Ren Chen (=E9=99=B3=E9=9F=8B=E4=BB=BB)
Parallel Processing Lab, Institute of Information Science,
Academia Sinica, Taiwan (R.O.C.)
Tel:886-2-2788-3799 #1667

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="dmesg.txt"

Performance Events: PEBS fmt0+, Core2 events, Intel PMU driver.

--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="cpuinfo.txt"

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4657.13
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 1
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 4
initial apicid	: 4
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4656.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:

processor	: 2
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 1
initial apicid	: 1
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4656.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:

processor	: 3
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 1
siblings	: 4
core id		: 1
cpu cores	: 4
apicid		: 5
initial apicid	: 5
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4656.00
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:

processor	: 4
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 2
initial apicid	: 2
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4656.96
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:

processor	: 5
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 1
siblings	: 4
core id		: 2
cpu cores	: 4
apicid		: 6
initial apicid	: 6
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4656.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:

processor	: 6
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 3
initial apicid	: 3
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4509.06
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5410  @ 2.33GHz
stepping	: 6
cpu MHz		: 2327.585
cache size	: 6144 KB
physical id	: 1
siblings	: 4
core id		: 3
cpu cores	: 4
apicid		: 7
initial apicid	: 7
fpu		: yes
fpu_exception	: yes
cpuid level	: 10
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc arch_perfmon pebs bts rep_good nopl aperfmperf pni dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 lahf_lm dts tpr_shadow vnmi flexpriority
bogomips	: 4656.99
clflush size	: 64
cache_alignment	: 64
address sizes	: 38 bits physical, 48 bits virtual
power management:


--VS++wcV0S1rZb1Fb--
