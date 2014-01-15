From: Andre Richter <andre.o.richter@gmail.com>
Subject: Re: Counting PCIe / MMIO traffic per core
Date: Wed, 15 Jan 2014 23:30:56 +0100
Message-ID: <CAKqeN2-BnL5cL9d9Xppf3wm69-BGL2pLWkBVcZ7-kaPiwPcqHQ@mail.gmail.com>
References: <CAKqeN2875RCqC9iwt=HJgFCnEmLWeuMma=RPxLX948AYsSRk2Q@mail.gmail.com>
	<CAGz0_-3S0kTWs4iyGov1SkAxpqQv0UNoWMk6jsTmo9DLDEy1zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:38348 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbaAOWa5 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 15 Jan 2014 17:30:57 -0500
Received: by mail-pd0-f177.google.com with SMTP id x10so415018pdj.22
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jan 2014 14:30:57 -0800 (PST)
In-Reply-To: <CAGz0_-3S0kTWs4iyGov1SkAxpqQv0UNoWMk6jsTmo9DLDEy1zA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: linux-perf-users@vger.kernel.org

Hi Andreas,

thank you for your help!

I found OFFCORE_RESPONSE_0:OTHER:NON_DRAM to correlate quite well with
what I see from uncore CBoxes when counting PCIe traffic. At least
optically the plots show a similar behavior, I did not yet try to
convert the raw counter values to meaningful metrics like Bytes/sec
and see if they still somehow correlate.

OFFCORE_RESPONSE has a lot of Request and Response types to choose
from, so that it is difficult for me to tell which are best suited for
counting PCIe/MMIO transactions. OTHER and NON_DRAM are my closest
guess right now.

Figure 18-26 in the SDM shows a MSR_UNCORE_ADDR_OPCODE_MATCH register
where I can use the uncore PMUs to filter transactions for specific
physical addresses. If it could filter address ranges, I could filter
for the pysical address space of a specific PCIe device, which would
take me where I want to go. But it does look like I only can filter
for specific addresses.

I need to have a closer look at it tomorrow, maybe there still is a way :)

Cheers,
Andre

2014/1/15 Andreas Hollmann <hollmann@in.tum.de>:
> Hi Andre,
>
> you could take a look at Offcore counters. This counter are
> per CPU and offer possibilities of filter certain events.
>
> I cannot tell you if they are really suited for you needs,
> but you could give them a try.
>
> The best documentation on Offcore counters I this:
> http://software.intel.com/sites/products/collateral/hpc/vtune/performance_analysis_guide.pdf
>
> and the Intel SDM Volume 3:
> https://www-ssl.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-software-developer-system-programming-manual-325384.pdf
>
> I would also advice you to use libpfm4 to translate event names like
>
> OFFCORE_RESPONSE_0:ANY_REQUEST:REMOTE_DRAM
>
> into raw events for perf. Here is some overview about howto use
> libpfm4 with perf
>
> http://www.bnikolic.co.uk/blog/hpc-prof-events.html
>
> It doesn't cover the use of offcore counters. But here is one example:
>
> check_events OFFCORE_RESPONSE_0:ANY_DATA:REMOTE_DRAM
> Supported PMU models:
>         [7, netburst, "Pentium4"]
>         [8, netburst_p, "Pentium4 (Prescott)"]
>         [11, core, "Intel Core"]
>         [14, atom, "Intel Atom"]
>         [15, nhm, "Intel Nehalem"]
>         [16, nhm_ex, "Intel Nehalem EX"]
>         [17, nhm_unc, "Intel Nehalem uncore"]
>         [18, ix86arch, "Intel X86 architectural PMU"]
>         [51, perf, "perf_events generic PMU"]
>         [52, wsm, "Intel Westmere (single-socket)"]
>         [53, wsm_dp, "Intel Westmere DP"]
>         [54, wsm_unc, "Intel Westmere uncore"]
>         [55, amd64_k7, "AMD64 K7"]
>         [56, amd64_k8_revb, "AMD64 K8 RevB"]
>         [57, amd64_k8_revc, "AMD64 K8 RevC"]
>         [58, amd64_k8_revd, "AMD64 K8 RevD"]
>         [59, amd64_k8_reve, "AMD64 K8 RevE"]
>         [60, amd64_k8_revf, "AMD64 K8 RevF"]
>         [61, amd64_k8_revg, "AMD64 K8 RevG"]
>         [62, amd64_fam10h_barcelona, "AMD64 Fam10h Barcelona"]
>         [63, amd64_fam10h_shanghai, "AMD64 Fam10h Shanghai"]
>         [64, amd64_fam10h_istanbul, "AMD64 Fam10h Istanbul"]
>         [68, snb, "Intel Sandy Bridge"]
>         [69, amd64_fam14h_bobcat, "AMD64 Fam14h Bobcat"]
>         [70, amd64_fam15h_interlagos, "AMD64 Fam15h Interlagos"]
>         [71, snb_ep, "Intel Sandy Bridge EP"]
>         [72, amd64_fam12h_llano, "AMD64 Fam12h Llano"]
>         [73, amd64_fam11h_turion, "AMD64 Fam11h Turion"]
>         [74, ivb, "Intel Ivy Bridge"]
>         [76, snb_unc_cbo0, "Intel Sandy Bridge C-box0 uncore"]
>         [77, snb_unc_cbo1, "Intel Sandy Bridge C-box1 uncore"]
>         [78, snb_unc_cbo2, "Intel Sandy Bridge C-box2 uncore"]
>         [79, snb_unc_cbo3, "Intel Sandy Bridge C-box3 uncore"]
>         [80, snbep_unc_cbo0, "Intel Sandy Bridge-EP C-Box 0 uncore"]
>         [81, snbep_unc_cbo1, "Intel Sandy Bridge-EP C-Box 1 uncore"]
>         [82, snbep_unc_cbo2, "Intel Sandy Bridge-EP C-Box 2 uncore"]
>         [83, snbep_unc_cbo3, "Intel Sandy Bridge-EP C-Box 3 uncore"]
>         [84, snbep_unc_cbo4, "Intel Sandy Bridge-EP C-Box 4 uncore"]
>         [85, snbep_unc_cbo5, "Intel Sandy Bridge-EP C-Box 5 uncore"]
>         [86, snbep_unc_cbo6, "Intel Sandy Bridge-EP C-Box 6 uncore"]
>         [87, snbep_unc_cbo7, "Intel Sandy Bridge-EP C-Box 7 uncore"]
>         [88, snbep_unc_ha, "Intel Sandy Bridge-EP HA uncore"]
>         [89, snbep_unc_imc0, "Intel Sandy Bridge-EP IMC0 uncore"]
>         [90, snbep_unc_imc1, "Intel Sandy Bridge-EP IMC1 uncore"]
>         [91, snbep_unc_imc2, "Intel Sandy Bridge-EP IMC2 uncore"]
>         [92, snbep_unc_imc3, "Intel Sandy Bridge-EP IMC3 uncore"]
>         [93, snbep_unc_pcu, "Intel Sandy Bridge-EP PCU uncore"]
>         [94, snbep_unc_qpi0, "Intel Sandy Bridge-EP QPI0 uncore"]
>         [95, snbep_unc_qpi1, "Intel Sandy Bridge-EP QPI1 uncore"]
>         [96, snbep_unc_ubo, "Intel Sandy Bridge-EP U-Box uncore"]
>         [97, snbep_unc_r2pcie, "Intel Sandy Bridge-EP R2PCIe uncore"]
>         [98, snbep_unc_r3qpi0, "Intel Sandy Bridge-EP R3QPI0 uncore"]
>         [99, snbep_unc_r3qpi1, "Intel Sandy Bridge-EP R3QPI1 uncore"]
>         [100, knc, "Intel Knights Corner"]
>         [103, ivb_ep, "Intel Ivy Bridge EP"]
>         [104, hsw, "Intel Haswell"]
>         [105, ivb_unc_cbo0, "Intel Ivy Bridge C-box0 uncore"]
>         [106, ivb_unc_cbo1, "Intel Ivy Bridge C-box1 uncore"]
>         [107, ivb_unc_cbo2, "Intel Ivy Bridge C-box2 uncore"]
>         [108, ivb_unc_cbo3, "Intel Ivy Bridge C-box3 uncore"]
> Detected PMU models:
>         [18, ix86arch, "Intel X86 architectural PMU"]
>         [51, perf, "perf_events generic PMU"]
>         [53, wsm_dp, "Intel Westmere DP"]
> Total events: 3042 available, 177 supported
> Requested Event: OFFCORE_RESPONSE_0:ANY_DATA:REMOTE_DRAM
> Actual    Event:
> wsm_dp::OFFCORE_RESPONSE_0:DMND_DATA_RD:DMND_RFO:PF_DATA_RD:PF_RFO:REMOTE_DRAM:k=1:u=1:e=0:i=0:c=0:t=0
> PMU            : Intel Westmere DP
> IDX            : 111149145
> Codes          : 0x5301b7 0x2033 <----|
>
>                                                                |---
> Codes are the configs for using them in perf
>
> Now you can use the these offcore counters with perf stat:
>
> First number config, second config1
>
> [hollmann@inwest format]$ perf stat -e
> cpu/config=0x5301b7,config1=0x2033,name=Remote_DRAM_Accesses/ ls
> any  cmask  edge  event  inv  ldlat  offcore_rsp  pc  umask
>
>  Performance counter stats for 'ls':
>
>                 46 Remote_DRAM_Accesses
>
>        0.001096052 seconds time elapsed
>
>
>
> [hollmann@inwest format]$ showevtinfo offcore
>
> returns the line
>
> Umask-20 : 0x8000 : PMU : [NON_DRAM] : None : Response: Non-DRAM
> requests that were serviced by IOH
>
> which could be useful in your case.
>
> Best regards,
> Andreas
>
> 2014/1/15 Andre Richter <andre.o.richter@gmail.com>:
>> Hello everyone,
>>
>> I am currently fiddling around with performance monitoring on a Xeon
>> Machine with an e5-2600 series CPU.
>>
>> What I understand from Intel's uncore performance monitoring guide and
>> from Andi Kleen's Readmes from his super useful pmu-tools, it is not
>> possible to differentiate PCIe traffic per core when using the uncore
>> PMUs (the CBo boxes to be precise). It is only possible per socket.
>>
>> I wonder, however, if it would be possible to at least make an
>> educated guess of which core is producing how much PCIe or MMIO
>> traffic.
>> Maybe by cross-correlating with some PMU evens from core-resident PMUs?
>> The amount of PMU events and configuration options is quite
>> overwhelming, that's why I would appreciate any hints I can get :)
>>
>> Cheers,
>> Andre
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
