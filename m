Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EEC15B573;
	Wed, 29 May 2024 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717011685; cv=none; b=B1yrifc3MDblkp6fa2qIyJhEFniBR4bGiUuNh9QJ7p/on6qQ62a7TDOdJxvh6KwmF+jgldGdHxrZTZLFFxHn6RKtzboxAR+xCDEPsis2Fs7ppm9WylVMFyMHF6agYBD5dR9mLAICKJ4lzJh+7deVR1TLIWmzGcSs+P/RvLlgNqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717011685; c=relaxed/simple;
	bh=Qdp6pufV0uRIRc6fZhOYLW2CNvhYtmWBwEBfeNDyVug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D+k/58eCQjaAETYGO3V+towwfoamBdvUGRuN8ZbCs24pFyTLy/YdT+ig7NsXlWrtzEBe+xS7Xpp/HWj+TaCc28jW/DwOvW0xttbNNzPC2+34sZkengw8g2NabUHvVO17WuqN28GnbU4GMNOd2ln53XuG2KeF2KVxaFzVneoEYbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lrADXn7n; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lrADXn7n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717011684; x=1748547684;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qdp6pufV0uRIRc6fZhOYLW2CNvhYtmWBwEBfeNDyVug=;
  b=lrADXn7nTbTs+RwyAsHfMbszr8oQsCjqJzAwrbXT/dgQfElZzbNjoo+y
   0hHpqzc/HN+oGPYDgugSbvs1z20B16BJqw5MmHvf+G0aFxmqn1WPOYLMA
   LpGXnVf6m6AHAGTsyilWowgyJ0K5DXj9DNQiRRgA46CLFjADHtvbyp8Cf
   +SFgrLqLEFn1JqWjAIThj24rpcX/G8J1UnadA29ZJZjTm2P7o775n3Fov
   EKAF2rPYyDp0iaVxgzQMwjrqw+mSrhQ8Z4SejRMJuT7CI9tXLLZtXxLgU
   SBuIo7tDxmpMdoKOH4wXbPFQcm373zTNuk8ALoiWs6aUZzZZX8jaDQPJe
   Q==;
X-CSE-ConnectionGUID: t3n35JQiTEGHoNmh/Alcow==
X-CSE-MsgGUID: 4glfzX48SgmKO0Kpi3vjhA==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="13622358"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="13622358"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 12:41:23 -0700
X-CSE-ConnectionGUID: jKo0jS8GTICLbiRD9Fp/Hw==
X-CSE-MsgGUID: WaAvQoDERe+Daeh7lGtuTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="66740836"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2024 12:41:22 -0700
Received: from [10.212.55.153] (kliang2-mobl1.ccr.corp.intel.com [10.212.55.153])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 82B5C2078A10;
	Wed, 29 May 2024 12:41:20 -0700 (PDT)
Message-ID: <956e1c32-c4c4-4626-8b5d-b523575e643e@linux.intel.com>
Date: Wed, 29 May 2024 15:41:19 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf record: add a shortcut for metrics
To: Guilherme Amadio <amadio@cern.ch>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Artem Savkov <asavkov@redhat.com>, Ian Rogers <irogers@google.com>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andi Kleen <ak@linux.intel.com>
References: <20240527101519.356342-1-asavkov@redhat.com> <ZlS8pc39t2c1WFye@x1>
 <ZlS9M1vcxZ3Qsx_B@x1> <ZlTCvelaGVb6lCia@x1> <ZlTG-kPuYUyHLQZ2@x1>
 <CAP-5=fWmmtagTVfacFZgdhughvU--Dz0=jkoqFB8CP1Qd3o3Yw@mail.gmail.com>
 <20240528115703.GB449511@alecto.usersys.redhat.com>
 <97818e63-051f-4fcf-8c20-75730c08e98a@linux.intel.com> <ZlYgVYI6ABqmwb-d@x1>
 <ZldGrKGQzGikxgqL@cern.ch>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZldGrKGQzGikxgqL@cern.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 2024-05-29 11:15 a.m., Guilherme Amadio wrote:
> Hi Arnaldo,
>=20
> On Tue, May 28, 2024 at 08:20:05PM +0200, Arnaldo Carvalho de Melo wrot=
e:
>> On Tue, May 28, 2024 at 11:55:00AM -0400, Liang, Kan wrote:
>>> On 2024-05-28 7:57 a.m., Artem Savkov wrote:
>>>> On Mon, May 27, 2024 at 10:01:37PM -0700, Ian Rogers wrote:
>>>>> On Mon, May 27, 2024 at 10:46=E2=80=AFAM Arnaldo Carvalho de Melo
>>>>> <acme@kernel.org> wrote:
>>>>>>
>>>>>> On Mon, May 27, 2024 at 02:28:32PM -0300, Arnaldo Carvalho de Melo=
 wrote:
>>>>>>> On Mon, May 27, 2024 at 02:04:54PM -0300, Arnaldo Carvalho de Mel=
o wrote:
>>>>>>>> On Mon, May 27, 2024 at 02:02:33PM -0300, Arnaldo Carvalho de Me=
lo wrote:
>>>>>>>>> On Mon, May 27, 2024 at 12:15:19PM +0200, Artem Savkov wrote:
>>>>>>>>>> Add -M/--metrics option to perf-record providing a shortcut to=
 record
>>>>>>>>>> metrics and metricgroups. This option mirrors the one in perf-=
stat.
>>>>>>>
>>>>>>>>>> Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>>>>>>>> Signed-off-by: Artem Savkov <asavkov@redhat.com>
>>>>>>
>>>>>>> How did you test this?
>>>>>>
>>>>>>> The idea, from my notes, was to be able to have extra columns in =
'perf
>>>>>>> report' with things like IPC and other metrics, probably not all =
metrics
>>>>>>> will apply. We need to find a way to find out which ones are OK f=
or that
>>>>>>> purpose, for instance:
>>>>>>
>>>>>> One that may make sense:
>>>>>>
>>>>>> root@number:~# perf record -M tma_fb_full
>>>>>> ^C[ perf record: Woken up 1 times to write data ]
>>>>>> [ perf record: Captured and wrote 3.846 MB perf.data (21745 sample=
s) ]
>>>>>>
>>>>>> root@number:~# perf evlist
>>>>>> cpu_core/CPU_CLK_UNHALTED.THREAD/
>>>>>> cpu_core/L1D_PEND_MISS.FB_FULL/
>>>>>> dummy:u
>>>>>> root@number:~#
>>>>>>
>>>>>> But then we need to read both to do the math, maybe something like=
:
>>>>>>
>>>>>> root@number:~# perf record -e '{cpu_core/CPU_CLK_UNHALTED.THREAD/,=
cpu_core/L1D_PEND_MISS.FB_FULL/}:S'
>>>>>> ^C[ perf record: Woken up 40 times to write data ]
>>>>>> [ perf record: Captured and wrote 14.640 MB perf.data (219990 samp=
les) ]
>>>>>>
>>>>>> root@number:~# perf script | head
>>>>>>     cc1plus 1339704 [000] 36028.995981:  2011389 cpu_core/CPU_CLK_=
UNHALTED.THREAD/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc=
-linux-gnu/13/cc1plus)
>>>>>>     cc1plus 1339704 [000] 36028.995981:    26231   cpu_core/L1D_PE=
ND_MISS.FB_FULL/:           1097303 [unknown] (/usr/libexec/gcc/x86_64-pc=
-linux-gnu/13/cc1plus)
>>>>>>     cc1plus 1340011 [001] 36028.996008:  2004568 cpu_core/CPU_CLK_=
UNHALTED.THREAD/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc=
-linux-gnu/13/cc1plus)
>>>>>>     cc1plus 1340011 [001] 36028.996008:    20113   cpu_core/L1D_PE=
ND_MISS.FB_FULL/:            8c23b4 [unknown] (/usr/libexec/gcc/x86_64-pc=
-linux-gnu/13/cc1plus)
>>>>>>       clang 1340462 [002] 36028.996043:  2007356 cpu_core/CPU_CLK_=
UNHALTED.THREAD/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms=
])
>>>>>>       clang 1340462 [002] 36028.996043:    23481   cpu_core/L1D_PE=
ND_MISS.FB_FULL/:  ffffffffb43b045d release_pages+0x3dd ([kernel.kallsyms=
])
>>>>>>     cc1plus 1339622 [003] 36028.996066:  2004148 cpu_core/CPU_CLK_=
UNHALTED.THREAD/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc=
-linux-gnu/13/cc1plus)
>>>>>>     cc1plus 1339622 [003] 36028.996066:    31935   cpu_core/L1D_PE=
ND_MISS.FB_FULL/:            760874 [unknown] (/usr/libexec/gcc/x86_64-pc=
-linux-gnu/13/cc1plus)
>>>>>>          as 1340513 [004] 36028.996097:  2005052 cpu_core/CPU_CLK_=
UNHALTED.THREAD/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.ka=
llsyms])
>>>>>>          as 1340513 [004] 36028.996097:    45084   cpu_core/L1D_PE=
ND_MISS.FB_FULL/:  ffffffffb4491d65 __count_memcg_events+0x55 ([kernel.ka=
llsyms])
>>>>>> root@number:~#
>>>>>>
>>>>>> root@number:~# perf report --stdio -F +period | head -20
>>>>>> # To display the perf.data header info, please use --header/--head=
er-only options.
>>>>>> #
>>>>>> #
>>>>>> # Total Lost Samples: 0
>>>>>> #
>>>>>> # Samples: 219K of events 'anon group { cpu_core/CPU_CLK_UNHALTED.=
THREAD/, cpu_core/L1D_PEND_MISS.FB_FULL/ }'
>>>>>> # Event count (approx.): 216528524863
>>>>>> #
>>>>>> #         Overhead                Period  Command    Shared Object=
      Symbol
>>>>>> # ................  ....................  .........  .............=
=2E...  ....................................
>>>>>> #
>>>>>>      4.01%   1.09%  8538169256  39826572  podman     [kernel.kalls=
yms]  [k] native_queued_spin_lock_slowpath
>>>>>>      1.35%   1.17%  2863376078  42829266  cc1plus    cc1plus      =
      [.] 0x00000000003f6bcc
>>>>>>      0.94%   0.78%  1990639149  28408591  cc1plus    cc1plus      =
      [.] 0x00000000003f6be4
>>>>>>      0.65%   0.17%  1375916283   6109515  podman     [kernel.kalls=
yms]  [k] _raw_spin_lock_irqsave
>>>>>>      0.61%   0.99%  1304418325  36198834  cc1plus    [kernel.kalls=
yms]  [k] get_mem_cgroup_from_mm
>>>>>>      0.52%   0.42%  1103054030  15427418  cc1plus    cc1plus      =
      [.] 0x0000000000ca6c69
>>>>>>      0.51%   0.17%  1094200572   6299289  podman     [kernel.kalls=
yms]  [k] psi_group_change
>>>>>>      0.42%   0.41%   893633315  14778675  cc1plus    cc1plus      =
      [.] 0x00000000018afafe
>>>>>>      0.42%   1.29%   887664793  47046952  cc1plus    [kernel.kalls=
yms]  [k] asm_exc_page_fault
>>>>>> root@number:~#
>>>>>>
>>>>>> That 'tma_fb_full' metric then would be another column, calculated=
 from
>>>>>> the sampled components of its metric equation:
>>>>>>
>>>>>> root@number:~# perf list tma_fb_full | head
>>>>>>
>>>>>> Metric Groups:
>>>>>>
>>>>>> MemoryBW: [Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet]
>>>>>>   tma_fb_full
>>>>>>        [This metric does a *rough estimation* of how often L1D Fil=
l Buffer
>>>>>>         unavailability limited additional L1D miss memory access r=
equests to
>>>>>>         proceed]
>>>>>>
>>>>>> TopdownL4: [Metrics for top-down breakdown at level 4]
>>>>>> root@number:~#
>>>>>>
>>>>>> This is roughly what we brainstormed, to support metrics in other =
tools
>>>>>> than 'perf stat' but we need to check the possibilities and limita=
tions
>>>>>> of such an idea, hopefully this discussion will help with that,
>>>>>
>>>>> Putting metrics next to code in perf report/annotate sounds good to=

>>>>> me, opening all events from a metric as if we want to sample on the=
m
>>>>> less so.
>>>>
>>>> The idea was to record whatever data was asked on record step and
>>>> provide the list of all metrics that can be calculated out of that d=
ata
>>>> in perf report, e.g. you could record tma_info_thread_ipc but report=

>>>> will suggest both it and tma_info_thread_cpi.
>>>>
>>>
>>> Do you mean that sample all the events in a metrics, and report both
>>> samples and its metrics calculation result in the report?
>>> That doesn't work for all the metrics.
>>
>> IIRC Guilherme was mentioning having extra metrics on report was
>> something he missed that is available on tools such as VTune, Guilherm=
e?
>=20
> Thanks for asking. I will try to explain the motivation behind metric
> sampling. VTune offers something called a Microarchitecture Analysis
> report, which will show a break down of all the TMA metrics per symbol:=

>=20
> https://www.intel.com/content/www/us/en/docs/vtune-profiler/cookbook/20=
23-0/top-down-microarchitecture-analysis-method.html
>=20
> The link above has a small screenshot showing function, instructions,
> CPI, and the metrics. This is much better than just counting, because i=
n
> a large detector simulation, for example, there are many different kind=
s
> of bottlenecks the code can have, and the break down per symbol helps t=
o
> identify which functions suffer from bad speculation, which suffer from=

> cache misses, etc. This allows one to choose what kind of change to mak=
e
> to the software to optimize it. So as a first step, having TMA level 0
> (i.e. a breakdown of the pipelines for Front-End Bound, Bad Speculation=
,
> Core Bound, and Memory Bound) would already be quite far towards the
> goal of understanding bottlenecks in specific parts of the code. VTune
> forces sampling without collecting call stacks for this, perf could do
> the same. Hotspots usually have lots of samples, which then allows
> computing metrics relatively accurately.=20

Yes, that's the assumption the VTune method relies on. Otherwise, the
result may be dubious.

> VTune uses multiplexing and
> very large sampling expression, which I am pasting at the end of this
> message=C2=B2. I extracted that command from the report file after usin=
g
> "vtune -collect uarch-exploration <command>" to produce a report. I
> tried that with standard perf record and it failed to parse, so likely
> amplxe-perf is required to be able to record that, but I thought it'd
> be useful information.

Actually, there is already a similar support for the perf script which
was provided by Andi.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D4bd1bef8bba2f99ff472ae3617864dda301f81bd

It should be able to be extended to other tools, e.g., annotate or report=
=2E

But it seems the feature is broken now. It's better to fix it first.
$ sudo perf script -I -F cpu,ip,sym,event,period,metric
Segmentation fault

The solution relies on the sample read feature. So you probably have to
divide the metrics into several groups if the metrics is too big.
For the leading event, the ref-cycles suggested in Andi's example should
be a good default choice, after all you want to measure time.

For example, the "perf record -M tma_info_thread_ipc"
may be interpreted to
perf record -e "{ref-cycles,INST_RETIRED.ANY,CPU_CLK_UNHALTED.THREAD}:S"

The implementation should be simpler than the VTune method.

>=20
> As for the interface, I suggest adding a "perf mlist" similar to
> perf evlist, that would just print what metrics could be calculated
> from the events recorded in the input file. Then one could be selected
> for use with perf report or perf annotate.
>

The "perf mlist" looks good, since the metrics are used more widely.

Thanks,
Kan

> I hope this explains enough to clarify things for you. I am attaching a=

> screenshot example for the classic matrix multiplication with wrong
> indexing as well, which shows that only certain lines get the metric,
> whereas lines with low number of samples just get 0.0%.
>=20
> Best regards,
> -Guilherme
>=20
>>> - For the topdown related metrics, especially on ICL and later
>>> platforms, the perf metrics feature is used by default. It doesn't
>>> support sampling.
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/tools/perf/Documentation/topdown.txt?#n293
>>> - Some PMUs which doesn't support sampling as well, e.g., uncore, Pow=
er,
>>> MSR.
>>> - There are some SW events, e.g.,duration_time, you may don't want to=
 do
>>> sampling
>>>
>>> You probable need to introduce a flag to ignore those metrics in perf=

>>> record.
>>>
>>>>> We don't have metrics working with `perf stat record`, I
>>>>> think Kan may have volunteered for that, but it seems like somethin=
g
>>>>> more urgent than expanding `perf record`. Presumably the way the
>>>>> metric would be recorded for that could also benefit this effort.
>>>>>
>>>>> If you look at the tma metrics a number of them have a "Sample with=
".
>>>>> For example:
>>>>> ```
>>>>> $ perf list -v
>>>>> ...
>>>>>   tma_branch_mispredicts
>>>>>        [This metric represents fraction of slots the CPU has wasted=

>>>>> due to Branch Misprediction.
>>>>>         These slots are either wasted by uops fetched from an
>>>>> incorrectly speculated program path;
>>>>>         or stalls when the out-of-order part of the machine needs t=
o
>>>>> recover its state from a
>>>>>         speculative path. Sample with: BR_MISP_RETIRED.ALL_BRANCHES=
=2E
>>>>> Related metrics:
>>>>>         tma_info_bad_spec_branch_misprediction_cost,tma_info_bottle=
neck_mispredictions,
>>>>>         tma_mispredicts_resteers]
>>>>> ...
>>>>> ```
>>>>> It could be logical for `perf record -M tma_branch_mispredicts ...`=
 to
>>>>> be translated to `perf record -e BR_MISP_RETIRED.ALL_BRANCHES ...`
>>>>> rather than to do any form of counting.
>>>>
>>>> Thanks for the pointer, I'll see how this could be done.
>>>
>>> It sounds more reasonable to me that we can sample some typical event=
s,
>>> and read the other members in the metrics. So we can put metrics next=
 to
>>> the code in perf report/annotate as Ian mentioned. It could also addr=
ess
>>> limits of some metrics, especially for the topdown related metrics.
>>> (But I'm not sure if the "Sample with" can give you the right hints. =
I
>>> will ask around internally.)
>>>
>>> But there is also some limits for the sampling read. Everything has t=
o
>>> be in a group. That could be a problem for some big metrics.
>>> Thanks,
>>> Kan
>=20
> 2. runCmd: amplxe-perf record -v --control=3Dfd:21,24 -o system-wide.pe=
rf -N -B -T --sample-cpu -d -a --compression-level=3D1 --threads --clocki=
d=3DCLOCK_MONOTONIC_RAW -e cpu/period=3D0xa037a0,event=3D0x3c,name=3D'CPU=
_CLK_UNHALTED.THREAD'/Duk,cpu/period=3D0xa037a0,umask=3D0x3,name=3D'CPU_C=
LK_UNHALTED.REF_TSC'/Duk,cpu/period=3D0xa037a0,event=3D0xc0,name=3D'INST_=
RETIRED.ANY'/Duk,cpu/period=3D0x7a12f,event=3D0x3c,umask=3D0x1,name=3D'CP=
U_CLK_UNHALTED.REF_XCLK'/uk,cpu/period=3D0x7a12f,event=3D0x3c,umask=3D0x2=
,name=3D'CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE'/uk,cpu/period=3D0x98968f,eve=
nt=3D0x3c,name=3D'CPU_CLK_UNHALTED.THREAD_P'/uk,cpu/period=3D0x98968f,eve=
nt=3D0xa3,umask=3D0x14,cmask=3D0x14,name=3D'CYCLE_ACTIVITY.STALLS_MEM_ANY=
'/uk,cpu/period=3D0x98968f,event=3D0xa3,umask=3D0x4,cmask=3D0x4,name=3D'C=
YCLE_ACTIVITY.STALLS_TOTAL'/uk,cpu/period=3D0x98968f,event=3D0xa6,umask=3D=
0x2,name=3D'EXE_ACTIVITY.1_PORTS_UTIL'/uk,cpu/period=3D0x98968f,event=3D0=
xa6,umask=3D0x4,name=3D'EXE_ACTIVITY.2_PORTS_UTIL'/uk,cpu/period=3D0x9896=
8f,event=3D0xa6,umask=3D0x40,name=3D'EXE_ACTIVITY.BOUND_ON_STORES'/uk,cpu=
/period=3D0x7a143,event=3D0xc6,umask=3D0x1,frontend=3D0x400406,name=3D'FR=
ONTEND_RETIRED.LATENCY_GE_4_PS'/ukpp,cpu/period=3D0x98968f,event=3D0x9c,u=
mask=3D0x1,name=3D'IDQ_UOPS_NOT_DELIVERED.CORE'/uk,cpu/period=3D0x98968f,=
event=3D0xd,umask=3D0x1,name=3D'INT_MISC.RECOVERY_CYCLES'/uk,cpu/period=3D=
0x98968f,event=3D0xe,umask=3D0x1,name=3D'UOPS_ISSUED.ANY'/uk,cpu/period=3D=
0x98968f,event=3D0xc2,umask=3D0x2,name=3D'UOPS_RETIRED.RETIRE_SLOTS'/uk,c=
pu/period=3D0x7a12f,event=3D0xe6,umask=3D0x1,name=3D'BACLEARS.ANY'/uk,cpu=
/period=3D0x1e84ad,event=3D0xc5,name=3D'BR_MISP_RETIRED.ALL_BRANCHES'/uk,=
cpu/period=3D0x98968f,event=3D0xab,umask=3D0x2,name=3D'DSB2MITE_SWITCHES.=
PENALTY_CYCLES'/uk,cpu/period=3D0x7a143,event=3D0xc6,umask=3D0x1,frontend=
=3D0x1,name=3D'FRONTEND_RETIRED.ANY_DSB_MISS'/uk,cpu/period=3D0x7a143,eve=
nt=3D0xc6,umask=3D0x1,frontend=3D0x11,name=3D'FRONTEND_RETIRED.DSB_MISS_P=
S'/ukpp,cpu/period=3D0x7a143,event=3D0xc6,umask=3D0x1,frontend=3D0x13,nam=
e=3D'FRONTEND_RETIRED.L2_MISS_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xc6,=
umask=3D0x1,frontend=3D0x401006,name=3D'FRONTEND_RETIRED.LATENCY_GE_16_PS=
'/ukpp,cpu/period=3D0x7a143,event=3D0xc6,umask=3D0x1,frontend=3D0x100206,=
name=3D'FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS'/ukpp,cpu/period=3D=
0x7a143,event=3D0xc6,umask=3D0x1,frontend=3D0x15,name=3D'FRONTEND_RETIRED=
=2ESTLB_MISS_PS'/ukpp,cpu/period=3D0x98968f,event=3D0x80,umask=3D0x4,name=
=3D'ICACHE_16B.IFDATA_STALL'/uk,cpu/period=3D0x98968f,event=3D0x80,edge=3D=
0x1,umask=3D0x4,cmask=3D0x1,name=3D'ICACHE_16B.IFDATA_STALL:cmask=3D1:e=3D=
yes'/uk,cpu/period=3D0xf424f,event=3D0x83,umask=3D0x4,name=3D'ICACHE_64B.=
IFTAG_STALL'/uk,cpu/period=3D0x98968f,event=3D0x79,umask=3D0x18,cmask=3D0=
x4,name=3D'IDQ.ALL_DSB_CYCLES_4_UOPS'/uk,cpu/period=3D0x98968f,event=3D0x=
79,umask=3D0x18,cmask=3D0x1,name=3D'IDQ.ALL_DSB_CYCLES_ANY_UOPS'/uk,cpu/p=
eriod=3D0x98968f,event=3D0x79,umask=3D0x24,cmask=3D0x4,name=3D'IDQ.ALL_MI=
TE_CYCLES_4_UOPS'/uk,cpu/period=3D0x98968f,event=3D0x79,umask=3D0x24,cmas=
k=3D0x1,name=3D'IDQ.ALL_MITE_CYCLES_ANY_UOPS'/uk,cpu/period=3D0x98968f,ev=
ent=3D0x79,umask=3D0x8,name=3D'IDQ.DSB_UOPS'/uk,cpu/period=3D0x98968f,eve=
nt=3D0x79,umask=3D0x4,name=3D'IDQ.MITE_UOPS'/uk,cpu/period=3D0x98968f,eve=
nt=3D0x79,edge=3D0x1,umask=3D0x30,cmask=3D0x1,name=3D'IDQ.MS_SWITCHES'/uk=
,cpu/period=3D0x98968f,event=3D0x79,umask=3D0x30,name=3D'IDQ.MS_UOPS'/uk,=
cpu/period=3D0x98968f,event=3D0x9c,umask=3D0x1,cmask=3D0x4,name=3D'IDQ_UO=
PS_NOT_DELIVERED.CYCLES_0_UOPS_DELIV.CORE'/uk,cpu/period=3D0x98968f,event=
=3D0x87,umask=3D0x1,name=3D'ILD_STALL.LCP'/uk,cpu/period=3D0x98968f,event=
=3D0x55,umask=3D0x1,cmask=3D0x1,name=3D'INST_DECODED.DECODERS:cmask=3D1'/=
uk,cpu/period=3D0x98968f,event=3D0x55,umask=3D0x1,cmask=3D0x2,name=3D'INS=
T_DECODED.DECODERS:cmask=3D2'/uk,cpu/period=3D0x98968f,event=3D0xd,umask=3D=
0x80,name=3D'INT_MISC.CLEAR_RESTEER_CYCLES'/uk,cpu/period=3D0x7a12f,event=
=3D0xc3,edge=3D0x1,umask=3D0x1,cmask=3D0x1,name=3D'MACHINE_CLEARS.COUNT'/=
uk,cpu/period=3D0x1e84ad,event=3D0xc5,umask=3D0x4,name=3D'BR_MISP_RETIRED=
=2EALL_BRANCHES_PS'/ukpp,cpu/period=3D0x98968f,event=3D0xa3,umask=3D0x8,c=
mask=3D0x8,name=3D'CYCLE_ACTIVITY.CYCLES_L1D_MISS'/uk,cpu/period=3D0x9896=
8f,event=3D0xa3,umask=3D0x10,cmask=3D0x10,name=3D'CYCLE_ACTIVITY.CYCLES_M=
EM_ANY'/uk,cpu/period=3D0x98968f,event=3D0xa3,umask=3D0xc,cmask=3D0xc,nam=
e=3D'CYCLE_ACTIVITY.STALLS_L1D_MISS'/uk,cpu/period=3D0x98968f,event=3D0xa=
3,umask=3D0x5,cmask=3D0x5,name=3D'CYCLE_ACTIVITY.STALLS_L2_MISS'/uk,cpu/p=
eriod=3D0x98968f,event=3D0xa3,umask=3D0x6,cmask=3D0x6,name=3D'CYCLE_ACTIV=
ITY.STALLS_L3_MISS'/uk,cpu/period=3D0x98968f,event=3D0x8,umask=3D0x20,cma=
sk=3D0x1,name=3D'DTLB_LOAD_MISSES.STLB_HIT:cmask=3D1'/uk,cpu/period=3D0x7=
a12f,event=3D0x8,umask=3D0x10,cmask=3D0x1,name=3D'DTLB_LOAD_MISSES.WALK_A=
CTIVE'/uk,cpu/period=3D0x7a12f,event=3D0x49,umask=3D0x20,cmask=3D0x1,name=
=3D'DTLB_STORE_MISSES.STLB_HIT:cmask=3D1'/uk,cpu/period=3D0x7a12f,event=3D=
0x49,umask=3D0x10,cmask=3D0x1,name=3D'DTLB_STORE_MISSES.WALK_ACTIVE'/uk,c=
pu/period=3D0x98968f,event=3D0x48,umask=3D0x2,cmask=3D0x1,name=3D'L1D_PEN=
D_MISS.FB_FULL:cmask=3D1'/uk,cpu/period=3D0x98968f,event=3D0x48,umask=3D0=
x1,name=3D'L1D_PEND_MISS.PENDING'/uk,cpu/period=3D0xf424f,event=3D0x24,um=
ask=3D0xe2,name=3D'L2_RQSTS.ALL_RFO'/uk,cpu/period=3D0xf424f,event=3D0x24=
,umask=3D0xc2,name=3D'L2_RQSTS.RFO_HIT'/uk,cpu/period=3D0x7a12f,event=3D0=
x3,umask=3D0x8,name=3D'LD_BLOCKS.NO_SR'/uk,cpu/period=3D0x7a12f,event=3D0=
x3,umask=3D0x2,name=3D'LD_BLOCKS.STORE_FORWARD'/uk,cpu/period=3D0x7a12f,e=
vent=3D0x7,umask=3D0x1,name=3D'LD_BLOCKS_PARTIAL.ADDRESS_ALIAS'/uk,cpu/pe=
riod=3D0x98968f,event=3D0xd0,umask=3D0x82,name=3D'MEM_INST_RETIRED.ALL_ST=
ORES_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd0,umask=3D0x21,name=3D'MEM_=
INST_RETIRED.LOCK_LOADS_PS'/ukpp,cpu/period=3D0x7a12f,event=3D0xd0,umask=3D=
0x41,name=3D'MEM_INST_RETIRED.SPLIT_LOADS_PS'/ukpp,cpu/period=3D0x7a12f,e=
vent=3D0xd0,umask=3D0x42,name=3D'MEM_INST_RETIRED.SPLIT_STORES_PS'/ukpp,c=
pu/period=3D0x7a12f,event=3D0xd0,umask=3D0x11,name=3D'MEM_INST_RETIRED.ST=
LB_MISS_LOADS_PS'/ukpp,cpu/period=3D0x7a12f,event=3D0xd0,umask=3D0x12,nam=
e=3D'MEM_INST_RETIRED.STLB_MISS_STORES_PS'/ukpp,cpu/period=3D0x186d7,even=
t=3D0xd2,umask=3D0x4,name=3D'MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS'/ukpp,c=
pu/period=3D0x186d7,event=3D0xd2,umask=3D0x2,name=3D'MEM_LOAD_L3_HIT_RETI=
RED.XSNP_HIT_PS'/ukpp,cpu/period=3D0x186d7,event=3D0xd2,umask=3D0x1,name=3D=
'MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS'/ukpp,cpu/period=3D0x7a143,event=3D=
0xd3,umask=3D0x1,name=3D'MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM_PS'/ukpp,cpu=
/period=3D0x7a143,event=3D0xd3,umask=3D0x2,name=3D'MEM_LOAD_L3_MISS_RETIR=
ED.REMOTE_DRAM_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd3,umask=3D0x8,nam=
e=3D'MEM_LOAD_L3_MISS_RETIRED.REMOTE_FWD'/uk,cpu/period=3D0x7a143,event=3D=
0xd3,umask=3D0x4,name=3D'MEM_LOAD_L3_MISS_RETIRED.REMOTE_HITM_PS'/ukpp,cp=
u/period=3D0x7a143,event=3D0xd3,umask=3D0x10,name=3D'MEM_LOAD_L3_MISS_RET=
IRED.REMOTE_PMM_PS'/ukpp,cpu/period=3D0x7a12f,event=3D0xd1,umask=3D0x40,n=
ame=3D'MEM_LOAD_RETIRED.FB_HIT_PS'/ukpp,cpu/period=3D0x98968f,event=3D0xd=
1,umask=3D0x1,name=3D'MEM_LOAD_RETIRED.L1_HIT_PS'/ukpp,cpu/period=3D0x7a1=
2f,event=3D0xd1,umask=3D0x8,name=3D'MEM_LOAD_RETIRED.L1_MISS_PS'/ukpp,cpu=
/period=3D0x7a12f,event=3D0xd1,umask=3D0x2,name=3D'MEM_LOAD_RETIRED.L2_HI=
T_PS'/ukpp,cpu/period=3D0x3d0f9,event=3D0xd1,umask=3D0x4,name=3D'MEM_LOAD=
_RETIRED.L3_HIT_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd1,umask=3D0x20,n=
ame=3D'MEM_LOAD_RETIRED.L3_MISS_PS'/ukpp,cpu/period=3D0x7a143,event=3D0xd=
1,umask=3D0x80,name=3D'MEM_LOAD_RETIRED.LOCAL_PMM_PS'/ukpp,cpu/period=3D0=
x98968f,event=3D0xb2,umask=3D0x1,name=3D'OFFCORE_REQUESTS_BUFFER.SQ_FULL'=
/uk,cpu/period=3D0x98968f,event=3D0x60,umask=3D0x8,cmask=3D0x4,name=3D'OF=
FCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD:cmask=3D4'/uk,cpu/period=3D0x98968=
f,event=3D0x60,umask=3D0x8,cmask=3D0x1,name=3D'OFFCORE_REQUESTS_OUTSTANDI=
NG.CYCLES_WITH_DATA_RD'/uk,cpu/period=3D0x98968f,event=3D0x60,umask=3D0x4=
,cmask=3D0x1,name=3D'OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO'=
/uk,cpu/period=3D0x98968f,event=3D0x14,umask=3D0x1,cmask=3D0x1,name=3D'AR=
ITH.DIVIDER_ACTIVE'/uk,cpu/period=3D0x98968f,event=3D0xa6,umask=3D0x1,nam=
e=3D'EXE_ACTIVITY.EXE_BOUND_0_PORTS'/uk,cpu/period=3D0x98968f,event=3D0xc=
7,name=3D'FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE:umask=3D0xfc'/uk,cpu/p=
eriod=3D0x98968f,event=3D0xc7,name=3D'FP_ARITH_INST_RETIRED.SCALAR_SINGLE=
:umask=3D0x03'/uk,cpu/period=3D0x98968f,event=3D0x59,umask=3D0x1,name=3D'=
PARTIAL_RAT_STALLS.SCOREBOARD'/uk,cpu/period=3D0x98968f,event=3D0xc0,umas=
k=3D0x1,name=3D'INST_RETIRED.PREC_DIST'/ukpp,cpu/period=3D0x98968f,event=3D=
0xcc,umask=3D0x40,name=3D'ROB_MISC_EVENTS.PAUSE_INST'/uk,cpu/period=3D0x9=
8968f,event=3D0xa1,umask=3D0x1,name=3D'UOPS_DISPATCHED_PORT.PORT_0'/uk,cp=
u/period=3D0x98968f,event=3D0xa1,umask=3D0x2,name=3D'UOPS_DISPATCHED_PORT=
=2EPORT_1'/uk,cpu/period=3D0x98968f,event=3D0xa1,umask=3D0x4,name=3D'UOPS=
_DISPATCHED_PORT.PORT_2'/uk,cpu/period=3D0x98968f,event=3D0xa1,umask=3D0x=
8,name=3D'UOPS_DISPATCHED_PORT.PORT_3'/uk,cpu/period=3D0x98968f,event=3D0=
xa1,umask=3D0x10,name=3D'UOPS_DISPATCHED_PORT.PORT_4'/uk,cpu/period=3D0x9=
8968f,event=3D0xa1,umask=3D0x20,name=3D'UOPS_DISPATCHED_PORT.PORT_5'/uk,c=
pu/period=3D0x98968f,event=3D0xa1,umask=3D0x40,name=3D'UOPS_DISPATCHED_PO=
RT.PORT_6'/uk,cpu/period=3D0x98968f,event=3D0xa1,umask=3D0x80,name=3D'UOP=
S_DISPATCHED_PORT.PORT_7'/uk,cpu/period=3D0x98968f,event=3D0xb1,umask=3D0=
x2,cmask=3D0x1,name=3D'UOPS_EXECUTED.CORE_CYCLES_GE_1'/uk,cpu/period=3D0x=
98968f,event=3D0xb1,umask=3D0x2,cmask=3D0x2,name=3D'UOPS_EXECUTED.CORE_CY=
CLES_GE_2'/uk,cpu/period=3D0x98968f,event=3D0xb1,umask=3D0x2,cmask=3D0x3,=
name=3D'UOPS_EXECUTED.CORE_CYCLES_GE_3'/uk,cpu/period=3D0x98968f,event=3D=
0xb1,inv=3D0x1,umask=3D0x2,cmask=3D0x1,name=3D'UOPS_EXECUTED.CORE_CYCLES_=
NONE'/uk,cpu/period=3D0x98968f,event=3D0xb1,umask=3D0x1,name=3D'UOPS_EXEC=
UTED.THREAD'/uk,cpu/period=3D0x98968f,event=3D0xb1,umask=3D0x10,name=3D'U=
OPS_EXECUTED.X87'/uk,cpu/period=3D0x98968f,event=3D0xe,umask=3D0x2,name=3D=
'UOPS_ISSUED.VECTOR_WIDTH_MISMATCH'/uk,cpu/period=3D0x98968f,event=3D0xc2=
,umask=3D0x4,name=3D'UOPS_RETIRED.MACRO_FUSED'/uk,cpu/period=3D0x1e84ad,e=
vent=3D0xc4,name=3D'BR_INST_RETIRED.ALL_BRANCHES'/uk,cpu/period=3D0x98968=
f,event=3D0xc7,umask=3D0x4,name=3D'FP_ARITH_INST_RETIRED.128B_PACKED_DOUB=
LE'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x8,name=3D'FP_ARITH_IN=
ST_RETIRED.128B_PACKED_SINGLE'/uk,cpu/period=3D0x98968f,event=3D0xc7,umas=
k=3D0x10,name=3D'FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE'/uk,cpu/period=3D=
0x98968f,event=3D0xc7,umask=3D0x20,name=3D'FP_ARITH_INST_RETIRED.256B_PAC=
KED_SINGLE'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x40,name=3D'FP=
_ARITH_INST_RETIRED.512B_PACKED_DOUBLE'/uk,cpu/period=3D0x98968f,event=3D=
0xc7,umask=3D0x80,name=3D'FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE'/uk,cp=
u/period=3D0x7a12f,event=3D0xca,umask=3D0x1e,cmask=3D0x1,name=3D'FP_ASSIS=
T.ANY'/uk,cpu/period=3D0x98968f,event=3D0xc0,umask=3D0x2,name=3D'INST_RET=
IRED.NOP'/uk,cpu/period=3D0x98968f,event=3D0xd0,umask=3D0x83,name=3D'MEM_=
INST_RETIRED.ANY'/uk,cpu/period=3D0x7a12f,event=3D0xc1,umask=3D0x3f,name=3D=
'OTHER_ASSISTS.ANY'/uk,cpu/period=3D0x7a12f,event=3D0xb7,offcore_rsp=3D0x=
8003c0001,umask=3D0x1,name=3D'OCR.DEMAND_DATA_RD.L3_HIT.HIT_OTHER_CORE_FW=
D'/uk,cpu/period=3D0x7a12f,event=3D0xbb,offcore_rsp=3D0x10003c0002,umask=3D=
0x1,name=3D'OCR.DEMAND_RFO.L3_HIT.HITM_OTHER_CORE'/uk,cpu/period=3D0x7a12=
f,event=3D0xb7,offcore_rsp=3D0x103fc00020,umask=3D0x1,name=3D'OCR.PF_L2_R=
FO.L3_MISS.REMOTE_HITM'/uk,cpu/period=3D0x7a12f,event=3D0xbb,offcore_rsp=3D=
0x10003c0001,umask=3D0x1,name=3D'OCR.DEMAND_DATA_RD.L3_HIT.HITM_OTHER_COR=
E'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x2,name=3D'FP_ARITH_INS=
T_RETIRED.SCALAR_SINGLE'/uk,cpu/period=3D0x98968f,event=3D0xc7,umask=3D0x=
1,name=3D'FP_ARITH_INST_RETIRED.SCALAR_DOUBLE'/uk,cpu/period=3D0x7a12f,ev=
ent=3D0xb7,offcore_rsp=3D0x103fc00002,umask=3D0x1,name=3D'OCR.DEMAND_RFO.=
L3_MISS.REMOTE_HITM'/uk,cpu/period=3D0x7a12f,event=3D0xbb,offcore_rsp=3D0=
x10003c0020,umask=3D0x1,name=3D'OCR.PF_L2_RFO.L3_HIT.HITM_OTHER_CORE'/uk =
amplxe-perf-sync sync sys
