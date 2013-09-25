From: Luke Gorrie <luke@snabb.co>
Subject: Re: First time user, problem with toplev.py levels (-l)
Date: Wed, 25 Sep 2013 17:29:49 +0200
Message-ID: <CAA2XHbfK5qkf6UERFu_zLK5NEA+ZSs3=2QCeZ3MvkSceY9bxqg@mail.gmail.com>
References: <CAA2XHbcy6qSvm_s=XPdp3GuXHgTAQqtiDZ1cgvM5rZMF9f00RQ@mail.gmail.com>
	<87ob7gsz42.fsf@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:62683 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3IYP3u (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 25 Sep 2013 11:29:50 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so2308340bkg.36
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Sep 2013 08:29:49 -0700 (PDT)
In-Reply-To: <87ob7gsz42.fsf@tassilo.jf.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 25 September 2013 17:24, Andi Kleen <andi@firstfloor.org> wrote:
> What CPU do you have (head -n20 /proc/cpuinfo) ?

$ head -n20 /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 45
model name      : Intel(R) Xeon(R) CPU E5-2650 0 @ 2.00GHz
stepping        : 7
microcode       : 0x70d
cpu MHz         : 1200.000
cache size      : 20480 KB
physical id     : 0
siblings        : 16
core id         : 0
cpu cores       : 8
apicid          : 0
initial apicid  : 0
fpu             : yes
fpu_exception   : yes
cpuid level     : 13
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe
syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts
rep_good nopl xtopology nonstop_tsc aperfmperf eagerfpu pni pclmulqdq
dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm pcid dca
sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx lahf_lm
ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept
vpid
