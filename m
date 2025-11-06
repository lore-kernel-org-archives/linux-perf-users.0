Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304430AAD0
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762466956; cv=none; b=tDyaU10wVrcrFdgi5/ba15Yk/EewnKspU+GDgqwZcm3HrtqCgYt4rOYN/69KgtiLa3cUMKGBKQLj/T5W4/9CW9FYrbdGJ+oir2mMVnVnAV1OOJ8O7GtrAVrD0XEsx1/LeYNGStC3+hUqyJ5CeqDphMWlcemiuZruXXPktnrRsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762466956; c=relaxed/simple;
	bh=Oakkwjagl1iN6czhk7SufHfvTiu4s0CPiWMDW4Nm+Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d11P1DSmZe69iUHr7NBPDPctT4cmVR/eX+GyJxQ/PPp6qSQm2KNQmN86dhifeggHmBF6OeUGB5IpouV7lBMUApO+boqvDyvmxdtezgVFg5CMDEj7M1z7nAcI+j15BfzPC/xzK4eJrtnhm/eF9lfTBZt7DRnkmQvEsyjjak7NR04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jMC7lY2b; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMC7lY2b"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-294f3105435so21355ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 14:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762466952; x=1763071752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvepIFfLd/7+PDdi2hLQJxhb6y4fYw15NXovg4p75tQ=;
        b=jMC7lY2bW/T/NboUGvAJiAtj6xYUXC/nZmZLmde68yYyjqtU8oe53eJobcQkftKpNy
         SV/iwpnoc1X3+S88jAEg7U3sl9TnTLQxUgeaTfFgPWnpnKuYUlKuD2dkCYlAFl1Lcgvh
         L2LQhlIvtwBVwYDSX+ARTNJbjYolU824QQfwpBrgT7tKVyZBfwekkjFDrWWKCyXXixuH
         BAZeaOdJI6ppxEyluVUu+GhSRsNVF8KOg6245BUpJoCwZ/sof+n7Oj8ApwDSLtJ2SSnA
         SjsbTo1Q/oXj18zmiptQkrVSHqmf1RuNmri8m89GxmBSKbKPRMIHXhZ7HyqAvEqf7xus
         VUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762466952; x=1763071752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lvepIFfLd/7+PDdi2hLQJxhb6y4fYw15NXovg4p75tQ=;
        b=S8Af7wXj/xEKSRwib63l4uQVInpz2GK+pwuYBaNkeUtmsk9Slo5d89oPIvDEUrRFG4
         AWSyfIOxFIegXpnHhTmLGLqMa0HtkJw2YRstYTa6bjga+pt1+oZP7CL+cfX0+M8sIv1n
         HFUbi0IJNLiHn0txQmDYLfnsx2usoyTh/PD+l8Ft1NrOnboV1afVuVSrUlXRQAg4kA0K
         X0SZXytXVsry6R5mtDB1WZzFSqc2PfHTq2lT/D3GN1TyVmVARnvogAJot9dFsu2vUkjX
         e7RB617T7Racn/C9cfwqYtgtSiJV3mA8KAGRXRKh4f9khgB1JenPpPKYA6pBz+31B1hU
         GFwg==
X-Forwarded-Encrypted: i=1; AJvYcCXB54uey22Xun7a+1uA276pT0zX0JoLsvVWDZkH2fbX7beTlzr2Gm5XbWdGyAbPFuo69QrGwsObDq/M3TMe6xir@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdlUXuCfOtX0ft7+rPC4vde23uB0g+6ofuB4sIbWxBnxo0BzS
	TsnisnPE/NSK20tzLOmCM935KmHdg/uIi5gELIoYq3Ytc+NVRjyWXTU4TsEDso2FiIzDU3xFqJ5
	In0TcVhuFWjnjLOcygITJ8WJz3LhBnzjFFYkRfhx8
X-Gm-Gg: ASbGnctrRF6Om0qfQwmoDXa7a76GwT8GCD0hDvXWFXxFOXQnfYx3MfiP+6hWP+1ZXNm
	duibvuLlJWT3O7VSLJBOltbyc/5wX7ffo+ONLAFrN1AHb3z72Gk+KkX3gxoKDb0n/13T+5H4gf3
	pJiFh08ug76ELQudSXYZalaOc3ak3WpOnTpZebfzbWibNF/xb9jGq8wiuQsE/+ftUQzVKGtnSED
	fYRx72D54UnmW+Fz54nEtkeaof/P7BNK32J4BbfKRSvYxdrggF1Uqx4oa1xabBxqlLNrksEBfUO
	h/3MP4RmJj+nnp35lTynJxEt1w==
X-Google-Smtp-Source: AGHT+IFw34vJZA1Pn5mym/NCU6Yn234rMWDmCSBYGOG4ZhKTUX2ZEQwBoEBTHX2WSwkR71U6Nnl6gESQhZ4RfEBl8WI=
X-Received: by 2002:a17:902:c401:b0:26d:72f8:8cfa with SMTP id
 d9443c01a7336-297c662adbcmr299885ad.13.1762466951539; Thu, 06 Nov 2025
 14:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106215350.1833191-1-namhyung@kernel.org>
In-Reply-To: <20251106215350.1833191-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Nov 2025 14:09:00 -0800
X-Gm-Features: AWmQ_bmyOjkqc2SZbekFnzOip5_xB1daqPWDRQIRnwkWIsgINpUJyr7uZjumN-0
Message-ID: <CAP-5=fU6gyWb25Qd=U3wZiQ_6D72qVXPKvo6XKQpAu03tAPVUg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Add ScaleUnit to {cpu,task}-clock JSON description
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 1:53=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> This changes the output of the event like below.  In fact, that's the
> output it used to have before the JSON conversion.
>
> Before:
>   $ perf stat -e task-clock true
>
>    Performance counter stats for 'true':
>
>              313,848      task-clock                       #    0.290 CPU=
s utilized
>
>          0.001081223 seconds time elapsed
>
>          0.001122000 seconds user
>          0.000000000 seconds sys
>
> After:
>   $ perf stat -e task-clock true
>
>    Performance counter stats for 'true':
>
>                 0.36 msec task-clock                       #    0.297 CPU=
s utilized
>
>          0.001225435 seconds time elapsed
>
>          0.001268000 seconds user
>          0.000000000 seconds sys
>
> Fixes: 9957d8c801fe0cb90 ("perf jevents: Add common software event json")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../arch/common/common/software.json          |   6 +-
>  tools/perf/pmu-events/empty-pmu-events.c      | 312 +++++++++---------
>  2 files changed, 160 insertions(+), 158 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/common/common/software.json b/too=
ls/perf/pmu-events/arch/common/common/software.json
> index f2551f1107fd712c..e6819ae219bb581e 100644
> --- a/tools/perf/pmu-events/arch/common/common/software.json
> +++ b/tools/perf/pmu-events/arch/common/common/software.json
> @@ -3,13 +3,15 @@
>      "Unit": "software",
>      "EventName": "cpu-clock",
>      "BriefDescription": "Per-CPU high-resolution timer based event",
> -    "ConfigCode": "0"
> +    "ConfigCode": "0",
> +    "ScaleUnit": "1e-6msec"
>    },
>    {
>      "Unit": "software",
>      "EventName": "task-clock",
>      "BriefDescription": "Per-task high-resolution timer based event",
> -    "ConfigCode": "1"
> +    "ConfigCode": "1",
> +    "ScaleUnit": "1e-6msec"
>    },
>    {
>      "Unit": "software",
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index 83a01ecc625e9a59..d78c1857ac4bb816 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -1251,84 +1251,84 @@ static const char *const big_c_string =3D
>  /* offset=3D123247 */ "idle-cycles-backend\000legacy hardware\000Stalled=
 cycles during retirement [This event is an alias of stalled-cycles-backend=
]\000legacy-hardware-config=3D8\000\00000\000\000\000\000\000"
>  /* offset=3D123400 */ "ref-cycles\000legacy hardware\000Total cycles; no=
t affected by CPU frequency scaling\000legacy-hardware-config=3D9\000\00000=
\000\000\000\000\000"
>  /* offset=3D123512 */ "software\000"
> -/* offset=3D123521 */ "cpu-clock\000software\000Per-CPU high-resolution =
timer based event\000config=3D0\000\00000\000\000\000\000\000"
> -/* offset=3D123599 */ "task-clock\000software\000Per-task high-resolutio=
n timer based event\000config=3D1\000\00000\000\000\000\000\000"
> -/* offset=3D123679 */ "faults\000software\000Number of page faults [This=
 event is an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\=
000"
> -/* offset=3D123774 */ "page-faults\000software\000Number of page faults =
[This event is an alias of faults]\000config=3D2\000\00000\000\000\000\000\=
000"
> -/* offset=3D123869 */ "context-switches\000software\000Number of context=
 switches [This event is an alias of cs]\000config=3D3\000\00000\000\000\00=
0\000\000"
> -/* offset=3D123970 */ "cs\000software\000Number of context switches [Thi=
s event is an alias of context-switches]\000config=3D3\000\00000\000\000\00=
0\000\000"
> -/* offset=3D124071 */ "cpu-migrations\000software\000Number of times a p=
rocess has migrated to a new CPU [This event is an alias of migrations]\000=
config=3D4\000\00000\000\000\000\000\000"
> -/* offset=3D124203 */ "migrations\000software\000Number of times a proce=
ss has migrated to a new CPU [This event is an alias of cpu-migrations]\000=
config=3D4\000\00000\000\000\000\000\000"
> -/* offset=3D124335 */ "minor-faults\000software\000Number of minor page =
faults. Minor faults don't require I/O to handle\000config=3D5\000\00000\00=
0\000\000\000\000"
> -/* offset=3D124444 */ "major-faults\000software\000Number of major page =
faults. Major faults require I/O to handle\000config=3D6\000\00000\000\000\=
000\000\000"
> -/* offset=3D124547 */ "alignment-faults\000software\000Number of kernel =
handled memory alignment faults\000config=3D7\000\00000\000\000\000\000\000=
"
> -/* offset=3D124639 */ "emulation-faults\000software\000Number of kernel =
handled unimplemented instruction faults handled through emulation\000confi=
g=3D8\000\00000\000\000\000\000\000"
> -/* offset=3D124766 */ "dummy\000software\000A placeholder event that doe=
sn't count anything\000config=3D9\000\00000\000\000\000\000\000"
> -/* offset=3D124846 */ "bpf-output\000software\000An event used by BPF pr=
ograms to write to the perf ring buffer\000config=3D0xa\000\00000\000\000\0=
00\000\000"
> -/* offset=3D124948 */ "cgroup-switches\000software\000Number of context =
switches to a task in a different cgroup\000config=3D0xb\000\00000\000\000\=
000\000\000"
> -/* offset=3D125051 */ "tool\000"
> -/* offset=3D125056 */ "duration_time\000tool\000Wall clock interval time=
 in nanoseconds\000config=3D1\000\00000\000\000\000\000\000"
> -/* offset=3D125132 */ "user_time\000tool\000User (non-kernel) time in na=
noseconds\000config=3D2\000\00000\000\000\000\000\000"
> -/* offset=3D125202 */ "system_time\000tool\000System/kernel time in nano=
seconds\000config=3D3\000\00000\000\000\000\000\000"
> -/* offset=3D125270 */ "has_pmem\000tool\0001 if persistent memory instal=
led otherwise 0\000config=3D4\000\00000\000\000\000\000\000"
> -/* offset=3D125346 */ "num_cores\000tool\000Number of cores. A core cons=
ists of 1 or more thread, with each thread being associated with a logical =
Linux CPU\000config=3D5\000\00000\000\000\000\000\000"
> -/* offset=3D125491 */ "num_cpus\000tool\000Number of logical Linux CPUs.=
 There may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\=
000\000\000"
> -/* offset=3D125594 */ "num_cpus_online\000tool\000Number of online logic=
al Linux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\=
00000\000\000\000\000\000"
> -/* offset=3D125711 */ "num_dies\000tool\000Number of dies. Each die has =
1 or more cores\000config=3D8\000\00000\000\000\000\000\000"
> -/* offset=3D125787 */ "num_packages\000tool\000Number of packages. Each =
package has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
> -/* offset=3D125873 */ "slots\000tool\000Number of functional units that =
in parallel can execute parts of an instruction\000config=3D0xa\000\00000\0=
00\000\000\000\000"
> -/* offset=3D125983 */ "smt_on\000tool\0001 if simultaneous multithreadin=
g (aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\=
000\000\000\000"
> -/* offset=3D126090 */ "system_tsc_freq\000tool\000The amount a Time Stam=
p Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\=
000\000"
> -/* offset=3D126189 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\=
000event=3D0x8a\000\00000\000\000\000\000\000"
> -/* offset=3D126251 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\=
000event=3D0x8b\000\00000\000\000\000\000\000"
> -/* offset=3D126313 */ "l3_cache_rd\000cache\000L3 cache access, read\000=
event=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, re=
ad\000"
> -/* offset=3D126411 */ "segment_reg_loads.any\000other\000Number of segme=
nt register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\0=
00\000\000\000"
> -/* offset=3D126513 */ "dispatch_blocked.any\000other\000Memory cluster s=
ignals to block micro-op dispatch for any reason\000event=3D9,period=3D2000=
00,umask=3D0x20\000\00000\000\000\000\000\000"
> -/* offset=3D126646 */ "eist_trans\000other\000Number of Enhanced Intel S=
peedStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\0=
00\00000\000\000\000\000\000"
> -/* offset=3D126764 */ "hisi_sccl,ddrc\000"
> -/* offset=3D126779 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC writ=
e commands\000event=3D2\000\00000\000\000\000\000\000"
> -/* offset=3D126849 */ "uncore_cbox\000"
> -/* offset=3D126861 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000=
A cross-core snoop resulted from L3 Eviction which misses in some processor=
 core\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
> -/* offset=3D127015 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
> -/* offset=3D127069 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000e=
vent=3D0xc0\000\00000\000\000\000\000\000"
> -/* offset=3D127127 */ "hisi_sccl,l3c\000"
> -/* offset=3D127141 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total r=
ead hits\000event=3D7\000\00000\000\000\000\000\000"
> -/* offset=3D127209 */ "uncore_imc_free_running\000"
> -/* offset=3D127233 */ "uncore_imc_free_running.cache_miss\000uncore\000T=
otal cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
> -/* offset=3D127313 */ "uncore_imc\000"
> -/* offset=3D127324 */ "uncore_imc.cache_hits\000uncore\000Total cache hi=
ts\000event=3D0x34\000\00000\000\000\000\000\000"
> -/* offset=3D127389 */ "uncore_sys_ddr_pmu\000"
> -/* offset=3D127408 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-c=
ycles event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
> -/* offset=3D127484 */ "uncore_sys_ccn_pmu\000"
> -/* offset=3D127503 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cyc=
les event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
> -/* offset=3D127580 */ "uncore_sys_cmn_pmu\000"
> -/* offset=3D127599 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts to=
tal cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> -/* offset=3D127742 */ "CPUs_utilized\000Default\000(software@cpu\\-clock=
\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\00001"
> -/* offset=3D127927 */ "cs_per_second\000Default\000software@context\\-sw=
itches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\=
\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\=
\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000=
\00001"
> -/* offset=3D128159 */ "migrations_per_second\000Default\000software@cpu\=
\-migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,n=
ame\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dt=
ask\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\000=
1migrations/sec\000\000\000\00001"
> -/* offset=3D128418 */ "page_faults_per_second\000Default\000software@pag=
e\\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
0001"
> -/* offset=3D128648 */ "insn_per_cycle\000Default\000instructions / cpu\\=
-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instruction=
s\000\000\000\00000"
> -/* offset=3D128760 */ "stalled_cycles_per_instruction\000Default\000max(=
stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000=
\000Max front or backend stalls per instruction\000\000\000\000\000\00000"
> -/* offset=3D128923 */ "frontend_cycles_idle\000Default\000stalled\\-cycl=
es\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stal=
ls per cycle\000\000\000\000\000\00000"
> -/* offset=3D129052 */ "backend_cycles_idle\000Default\000stalled\\-cycle=
s\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls p=
er cycle\000\000\000\000\000\00000"
> -/* offset=3D129177 */ "cycles_frequency\000Default\000cpu\\-cycles / (so=
ftware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@tas=
k\\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GH=
z\000\000\000\00001"
> -/* offset=3D129352 */ "branch_frequency\000Default\000branches / (softwa=
re@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-=
clock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K=
/sec\000\000\000\00001"
> -/* offset=3D129531 */ "branch_miss_rate\000Default\000branch\\-misses / =
branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000=
\000\00000"
> -/* offset=3D129634 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00=
000"
> -/* offset=3D129656 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhal=
ted.thread\000\000\000\000\000\000\000\00000"
> -/* offset=3D129719 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.=
core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread=
_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> -/* offset=3D129885 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / ins=
t_retired.any\000\000\000\000\000\000\000\00000"
> -/* offset=3D129949 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / =
inst_retired.any\000\000\000\000\000\000\000\00000"
> -/* offset=3D130016 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + =
icache_miss_cycles\000\000\000\000\000\000\000\00000"
> -/* offset=3D130087 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd=
_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000=
"
> -/* offset=3D130181 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand=
_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rf=
o_miss\000\000\000\000\000\000\000\00000"
> -/* offset=3D130315 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_=
L2_All_Miss\000\000\000\000\000\000\000\00000"
> -/* offset=3D130379 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
> -/* offset=3D130447 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Mis=
s, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> -/* offset=3D130517 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00=
000"
> -/* offset=3D130539 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00=
000"
> -/* offset=3D130561 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\0000=
0"
> -/* offset=3D130581 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1=
e9 / duration_time\000\000\000\000\000\000\000\00000"
> +/* offset=3D123521 */ "cpu-clock\000software\000Per-CPU high-resolution =
timer based event\000config=3D0\000\000001e-6msec\000\000\000\000\000"
> +/* offset=3D123607 */ "task-clock\000software\000Per-task high-resolutio=
n timer based event\000config=3D1\000\000001e-6msec\000\000\000\000\000"
> +/* offset=3D123695 */ "faults\000software\000Number of page faults [This=
 event is an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\=
000"
> +/* offset=3D123790 */ "page-faults\000software\000Number of page faults =
[This event is an alias of faults]\000config=3D2\000\00000\000\000\000\000\=
000"
> +/* offset=3D123885 */ "context-switches\000software\000Number of context=
 switches [This event is an alias of cs]\000config=3D3\000\00000\000\000\00=
0\000\000"
> +/* offset=3D123986 */ "cs\000software\000Number of context switches [Thi=
s event is an alias of context-switches]\000config=3D3\000\00000\000\000\00=
0\000\000"
> +/* offset=3D124087 */ "cpu-migrations\000software\000Number of times a p=
rocess has migrated to a new CPU [This event is an alias of migrations]\000=
config=3D4\000\00000\000\000\000\000\000"
> +/* offset=3D124219 */ "migrations\000software\000Number of times a proce=
ss has migrated to a new CPU [This event is an alias of cpu-migrations]\000=
config=3D4\000\00000\000\000\000\000\000"
> +/* offset=3D124351 */ "minor-faults\000software\000Number of minor page =
faults. Minor faults don't require I/O to handle\000config=3D5\000\00000\00=
0\000\000\000\000"
> +/* offset=3D124460 */ "major-faults\000software\000Number of major page =
faults. Major faults require I/O to handle\000config=3D6\000\00000\000\000\=
000\000\000"
> +/* offset=3D124563 */ "alignment-faults\000software\000Number of kernel =
handled memory alignment faults\000config=3D7\000\00000\000\000\000\000\000=
"
> +/* offset=3D124655 */ "emulation-faults\000software\000Number of kernel =
handled unimplemented instruction faults handled through emulation\000confi=
g=3D8\000\00000\000\000\000\000\000"
> +/* offset=3D124782 */ "dummy\000software\000A placeholder event that doe=
sn't count anything\000config=3D9\000\00000\000\000\000\000\000"
> +/* offset=3D124862 */ "bpf-output\000software\000An event used by BPF pr=
ograms to write to the perf ring buffer\000config=3D0xa\000\00000\000\000\0=
00\000\000"
> +/* offset=3D124964 */ "cgroup-switches\000software\000Number of context =
switches to a task in a different cgroup\000config=3D0xb\000\00000\000\000\=
000\000\000"
> +/* offset=3D125067 */ "tool\000"
> +/* offset=3D125072 */ "duration_time\000tool\000Wall clock interval time=
 in nanoseconds\000config=3D1\000\00000\000\000\000\000\000"
> +/* offset=3D125148 */ "user_time\000tool\000User (non-kernel) time in na=
noseconds\000config=3D2\000\00000\000\000\000\000\000"
> +/* offset=3D125218 */ "system_time\000tool\000System/kernel time in nano=
seconds\000config=3D3\000\00000\000\000\000\000\000"
> +/* offset=3D125286 */ "has_pmem\000tool\0001 if persistent memory instal=
led otherwise 0\000config=3D4\000\00000\000\000\000\000\000"
> +/* offset=3D125362 */ "num_cores\000tool\000Number of cores. A core cons=
ists of 1 or more thread, with each thread being associated with a logical =
Linux CPU\000config=3D5\000\00000\000\000\000\000\000"
> +/* offset=3D125507 */ "num_cpus\000tool\000Number of logical Linux CPUs.=
 There may be multiple such CPUs on a core\000config=3D6\000\00000\000\000\=
000\000\000"
> +/* offset=3D125610 */ "num_cpus_online\000tool\000Number of online logic=
al Linux CPUs. There may be multiple such CPUs on a core\000config=3D7\000\=
00000\000\000\000\000\000"
> +/* offset=3D125727 */ "num_dies\000tool\000Number of dies. Each die has =
1 or more cores\000config=3D8\000\00000\000\000\000\000\000"
> +/* offset=3D125803 */ "num_packages\000tool\000Number of packages. Each =
package has 1 or more die\000config=3D9\000\00000\000\000\000\000\000"
> +/* offset=3D125889 */ "slots\000tool\000Number of functional units that =
in parallel can execute parts of an instruction\000config=3D0xa\000\00000\0=
00\000\000\000\000"
> +/* offset=3D125999 */ "smt_on\000tool\0001 if simultaneous multithreadin=
g (aka hyperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\=
000\000\000\000"
> +/* offset=3D126106 */ "system_tsc_freq\000tool\000The amount a Time Stam=
p Counter (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\=
000\000"
> +/* offset=3D126205 */ "bp_l1_btb_correct\000branch\000L1 BTB Correction\=
000event=3D0x8a\000\00000\000\000\000\000\000"
> +/* offset=3D126267 */ "bp_l2_btb_correct\000branch\000L2 BTB Correction\=
000event=3D0x8b\000\00000\000\000\000\000\000"
> +/* offset=3D126329 */ "l3_cache_rd\000cache\000L3 cache access, read\000=
event=3D0x40\000\00000\000\000\000\000Attributable Level 3 cache access, re=
ad\000"
> +/* offset=3D126427 */ "segment_reg_loads.any\000other\000Number of segme=
nt register loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\0=
00\000\000\000"
> +/* offset=3D126529 */ "dispatch_blocked.any\000other\000Memory cluster s=
ignals to block micro-op dispatch for any reason\000event=3D9,period=3D2000=
00,umask=3D0x20\000\00000\000\000\000\000\000"
> +/* offset=3D126662 */ "eist_trans\000other\000Number of Enhanced Intel S=
peedStep(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\0=
00\00000\000\000\000\000\000"
> +/* offset=3D126780 */ "hisi_sccl,ddrc\000"
> +/* offset=3D126795 */ "uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC writ=
e commands\000event=3D2\000\00000\000\000\000\000\000"
> +/* offset=3D126865 */ "uncore_cbox\000"
> +/* offset=3D126877 */ "unc_cbo_xsnp_response.miss_eviction\000uncore\000=
A cross-core snoop resulted from L3 Eviction which misses in some processor=
 core\000event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000"
> +/* offset=3D127031 */ "event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=
=3D0xe0\000\00000\000\000\000\000\000"
> +/* offset=3D127085 */ "event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000e=
vent=3D0xc0\000\00000\000\000\000\000\000"
> +/* offset=3D127143 */ "hisi_sccl,l3c\000"
> +/* offset=3D127157 */ "uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total r=
ead hits\000event=3D7\000\00000\000\000\000\000\000"
> +/* offset=3D127225 */ "uncore_imc_free_running\000"
> +/* offset=3D127249 */ "uncore_imc_free_running.cache_miss\000uncore\000T=
otal cache misses\000event=3D0x12\000\00000\000\000\000\000\000"
> +/* offset=3D127329 */ "uncore_imc\000"
> +/* offset=3D127340 */ "uncore_imc.cache_hits\000uncore\000Total cache hi=
ts\000event=3D0x34\000\00000\000\000\000\000\000"
> +/* offset=3D127405 */ "uncore_sys_ddr_pmu\000"
> +/* offset=3D127424 */ "sys_ddr_pmu.write_cycles\000uncore\000ddr write-c=
ycles event\000event=3D0x2b\000v8\00000\000\000\000\000\000"
> +/* offset=3D127500 */ "uncore_sys_ccn_pmu\000"
> +/* offset=3D127519 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-cyc=
les event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
> +/* offset=3D127596 */ "uncore_sys_cmn_pmu\000"
> +/* offset=3D127615 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts to=
tal cache misses in first lookup result (high priority)\000eventid=3D1,type=
=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> +/* offset=3D127758 */ "CPUs_utilized\000Default\000(software@cpu\\-clock=
\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\00=
0\0001CPUs\000\000\000\00001"
> +/* offset=3D127943 */ "cs_per_second\000Default\000software@context\\-sw=
itches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\=
\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\=
\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000=
\00001"
> +/* offset=3D128175 */ "migrations_per_second\000Default\000software@cpu\=
\-migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,n=
ame\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dt=
ask\\-clock@)\000\000Process migrations to a new CPU per CPU second\000\000=
1migrations/sec\000\000\000\00001"
> +/* offset=3D128434 */ "page_faults_per_second\000Default\000software@pag=
e\\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\0=
0001"
> +/* offset=3D128664 */ "insn_per_cycle\000Default\000instructions / cpu\\=
-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instruction=
s\000\000\000\00000"
> +/* offset=3D128776 */ "stalled_cycles_per_instruction\000Default\000max(=
stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000=
\000Max front or backend stalls per instruction\000\000\000\000\000\00000"
> +/* offset=3D128939 */ "frontend_cycles_idle\000Default\000stalled\\-cycl=
es\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stal=
ls per cycle\000\000\000\000\000\00000"
> +/* offset=3D129068 */ "backend_cycles_idle\000Default\000stalled\\-cycle=
s\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls p=
er cycle\000\000\000\000\000\00000"
> +/* offset=3D129193 */ "cycles_frequency\000Default\000cpu\\-cycles / (so=
ftware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@tas=
k\\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GH=
z\000\000\000\00001"
> +/* offset=3D129368 */ "branch_frequency\000Default\000branches / (softwa=
re@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-=
clock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K=
/sec\000\000\000\00001"
> +/* offset=3D129547 */ "branch_miss_rate\000Default\000branch\\-misses / =
branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000=
\000\00000"
> +/* offset=3D129650 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\00=
000"
> +/* offset=3D129672 */ "IPC\000group1\000inst_retired.any / cpu_clk_unhal=
ted.thread\000\000\000\000\000\000\000\00000"
> +/* offset=3D129735 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivered.=
core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread=
_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> +/* offset=3D129901 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / ins=
t_retired.any\000\000\000\000\000\000\000\00000"
> +/* offset=3D129965 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses / =
inst_retired.any\000\000\000\000\000\000\000\00000"
> +/* offset=3D130032 */ "cache_miss_cycles\000group1\000dcache_miss_cpi + =
icache_miss_cycles\000\000\000\000\000\000\000\00000"
> +/* offset=3D130103 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd=
_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000=
"
> +/* offset=3D130197 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand=
_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rf=
o_miss\000\000\000\000\000\000\000\00000"
> +/* offset=3D130331 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCache_=
L2_All_Miss\000\000\000\000\000\000\000\00000"
> +/* offset=3D130395 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits,=
 DCache_L2_All)\000\000\000\000\000\000\000\00000"
> +/* offset=3D130463 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Mis=
s, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> +/* offset=3D130533 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\00=
000"
> +/* offset=3D130555 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\00=
000"
> +/* offset=3D130577 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\0000=
0"
> +/* offset=3D130597 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1=
e9 / duration_time\000\000\000\000\000\000\000\00000"
>  ;
>
>  static const struct compact_pmu_event pmu_events__common_default_core[] =
=3D {
> @@ -2564,35 +2564,35 @@ static const struct compact_pmu_event pmu_events_=
_common_default_core[] =3D {
>  { 122795 }, /* stalled-cycles-frontend\000legacy hardware\000Stalled cyc=
les during issue [This event is an alias of idle-cycles-frontend]\000legacy=
-hardware-config=3D7\000\00000\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__common_software[] =3D =
{
> -{ 124547 }, /* alignment-faults\000software\000Number of kernel handled =
memory alignment faults\000config=3D7\000\00000\000\000\000\000\000 */
> -{ 124846 }, /* bpf-output\000software\000An event used by BPF programs t=
o write to the perf ring buffer\000config=3D0xa\000\00000\000\000\000\000\0=
00 */
> -{ 124948 }, /* cgroup-switches\000software\000Number of context switches=
 to a task in a different cgroup\000config=3D0xb\000\00000\000\000\000\000\=
000 */
> -{ 123869 }, /* context-switches\000software\000Number of context switche=
s [This event is an alias of cs]\000config=3D3\000\00000\000\000\000\000\00=
0 */
> -{ 123521 }, /* cpu-clock\000software\000Per-CPU high-resolution timer ba=
sed event\000config=3D0\000\00000\000\000\000\000\000 */
> -{ 124071 }, /* cpu-migrations\000software\000Number of times a process h=
as migrated to a new CPU [This event is an alias of migrations]\000config=
=3D4\000\00000\000\000\000\000\000 */
> -{ 123970 }, /* cs\000software\000Number of context switches [This event =
is an alias of context-switches]\000config=3D3\000\00000\000\000\000\000\00=
0 */
> -{ 124766 }, /* dummy\000software\000A placeholder event that doesn't cou=
nt anything\000config=3D9\000\00000\000\000\000\000\000 */
> -{ 124639 }, /* emulation-faults\000software\000Number of kernel handled =
unimplemented instruction faults handled through emulation\000config=3D8\00=
0\00000\000\000\000\000\000 */
> -{ 123679 }, /* faults\000software\000Number of page faults [This event i=
s an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\000 */
> -{ 124444 }, /* major-faults\000software\000Number of major page faults. =
Major faults require I/O to handle\000config=3D6\000\00000\000\000\000\000\=
000 */
> -{ 124203 }, /* migrations\000software\000Number of times a process has m=
igrated to a new CPU [This event is an alias of cpu-migrations]\000config=
=3D4\000\00000\000\000\000\000\000 */
> -{ 124335 }, /* minor-faults\000software\000Number of minor page faults. =
Minor faults don't require I/O to handle\000config=3D5\000\00000\000\000\00=
0\000\000 */
> -{ 123774 }, /* page-faults\000software\000Number of page faults [This ev=
ent is an alias of faults]\000config=3D2\000\00000\000\000\000\000\000 */
> -{ 123599 }, /* task-clock\000software\000Per-task high-resolution timer =
based event\000config=3D1\000\00000\000\000\000\000\000 */
> +{ 124563 }, /* alignment-faults\000software\000Number of kernel handled =
memory alignment faults\000config=3D7\000\00000\000\000\000\000\000 */
> +{ 124862 }, /* bpf-output\000software\000An event used by BPF programs t=
o write to the perf ring buffer\000config=3D0xa\000\00000\000\000\000\000\0=
00 */
> +{ 124964 }, /* cgroup-switches\000software\000Number of context switches=
 to a task in a different cgroup\000config=3D0xb\000\00000\000\000\000\000\=
000 */
> +{ 123885 }, /* context-switches\000software\000Number of context switche=
s [This event is an alias of cs]\000config=3D3\000\00000\000\000\000\000\00=
0 */
> +{ 123521 }, /* cpu-clock\000software\000Per-CPU high-resolution timer ba=
sed event\000config=3D0\000\000001e-6msec\000\000\000\000\000 */
> +{ 124087 }, /* cpu-migrations\000software\000Number of times a process h=
as migrated to a new CPU [This event is an alias of migrations]\000config=
=3D4\000\00000\000\000\000\000\000 */
> +{ 123986 }, /* cs\000software\000Number of context switches [This event =
is an alias of context-switches]\000config=3D3\000\00000\000\000\000\000\00=
0 */
> +{ 124782 }, /* dummy\000software\000A placeholder event that doesn't cou=
nt anything\000config=3D9\000\00000\000\000\000\000\000 */
> +{ 124655 }, /* emulation-faults\000software\000Number of kernel handled =
unimplemented instruction faults handled through emulation\000config=3D8\00=
0\00000\000\000\000\000\000 */
> +{ 123695 }, /* faults\000software\000Number of page faults [This event i=
s an alias of page-faults]\000config=3D2\000\00000\000\000\000\000\000 */
> +{ 124460 }, /* major-faults\000software\000Number of major page faults. =
Major faults require I/O to handle\000config=3D6\000\00000\000\000\000\000\=
000 */
> +{ 124219 }, /* migrations\000software\000Number of times a process has m=
igrated to a new CPU [This event is an alias of cpu-migrations]\000config=
=3D4\000\00000\000\000\000\000\000 */
> +{ 124351 }, /* minor-faults\000software\000Number of minor page faults. =
Minor faults don't require I/O to handle\000config=3D5\000\00000\000\000\00=
0\000\000 */
> +{ 123790 }, /* page-faults\000software\000Number of page faults [This ev=
ent is an alias of faults]\000config=3D2\000\00000\000\000\000\000\000 */
> +{ 123607 }, /* task-clock\000software\000Per-task high-resolution timer =
based event\000config=3D1\000\000001e-6msec\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__common_tool[] =3D {
> -{ 125056 }, /* duration_time\000tool\000Wall clock interval time in nano=
seconds\000config=3D1\000\00000\000\000\000\000\000 */
> -{ 125270 }, /* has_pmem\000tool\0001 if persistent memory installed othe=
rwise 0\000config=3D4\000\00000\000\000\000\000\000 */
> -{ 125346 }, /* num_cores\000tool\000Number of cores. A core consists of =
1 or more thread, with each thread being associated with a logical Linux CP=
U\000config=3D5\000\00000\000\000\000\000\000 */
> -{ 125491 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There m=
ay be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\=
000 */
> -{ 125594 }, /* num_cpus_online\000tool\000Number of online logical Linux=
 CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000\00=
0\000\000\000\000 */
> -{ 125711 }, /* num_dies\000tool\000Number of dies. Each die has 1 or mor=
e cores\000config=3D8\000\00000\000\000\000\000\000 */
> -{ 125787 }, /* num_packages\000tool\000Number of packages. Each package =
has 1 or more die\000config=3D9\000\00000\000\000\000\000\000 */
> -{ 125873 }, /* slots\000tool\000Number of functional units that in paral=
lel can execute parts of an instruction\000config=3D0xa\000\00000\000\000\0=
00\000\000 */
> -{ 125983 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka h=
yperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\000\=
000\000 */
> -{ 125202 }, /* system_time\000tool\000System/kernel time in nanoseconds\=
000config=3D3\000\00000\000\000\000\000\000 */
> -{ 126090 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counte=
r (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\000 =
*/
> -{ 125132 }, /* user_time\000tool\000User (non-kernel) time in nanosecond=
s\000config=3D2\000\00000\000\000\000\000\000 */
> +{ 125072 }, /* duration_time\000tool\000Wall clock interval time in nano=
seconds\000config=3D1\000\00000\000\000\000\000\000 */
> +{ 125286 }, /* has_pmem\000tool\0001 if persistent memory installed othe=
rwise 0\000config=3D4\000\00000\000\000\000\000\000 */
> +{ 125362 }, /* num_cores\000tool\000Number of cores. A core consists of =
1 or more thread, with each thread being associated with a logical Linux CP=
U\000config=3D5\000\00000\000\000\000\000\000 */
> +{ 125507 }, /* num_cpus\000tool\000Number of logical Linux CPUs. There m=
ay be multiple such CPUs on a core\000config=3D6\000\00000\000\000\000\000\=
000 */
> +{ 125610 }, /* num_cpus_online\000tool\000Number of online logical Linux=
 CPUs. There may be multiple such CPUs on a core\000config=3D7\000\00000\00=
0\000\000\000\000 */
> +{ 125727 }, /* num_dies\000tool\000Number of dies. Each die has 1 or mor=
e cores\000config=3D8\000\00000\000\000\000\000\000 */
> +{ 125803 }, /* num_packages\000tool\000Number of packages. Each package =
has 1 or more die\000config=3D9\000\00000\000\000\000\000\000 */
> +{ 125889 }, /* slots\000tool\000Number of functional units that in paral=
lel can execute parts of an instruction\000config=3D0xa\000\00000\000\000\0=
00\000\000 */
> +{ 125999 }, /* smt_on\000tool\0001 if simultaneous multithreading (aka h=
yperthreading) is enable otherwise 0\000config=3D0xb\000\00000\000\000\000\=
000\000 */
> +{ 125218 }, /* system_time\000tool\000System/kernel time in nanoseconds\=
000config=3D3\000\00000\000\000\000\000\000 */
> +{ 126106 }, /* system_tsc_freq\000tool\000The amount a Time Stamp Counte=
r (TSC) increases per second\000config=3D0xc\000\00000\000\000\000\000\000 =
*/
> +{ 125148 }, /* user_time\000tool\000User (non-kernel) time in nanosecond=
s\000config=3D2\000\00000\000\000\000\000\000 */
>
>  };
>
> @@ -2610,22 +2610,22 @@ static const struct pmu_table_entry pmu_events__c=
ommon[] =3D {
>  {
>       .entries =3D pmu_events__common_tool,
>       .num_entries =3D ARRAY_SIZE(pmu_events__common_tool),
> -     .pmu_name =3D { 125051 /* tool\000 */ },
> +     .pmu_name =3D { 125067 /* tool\000 */ },
>  },
>  };
>
>  static const struct compact_pmu_event pmu_metrics__common_default_core[]=
 =3D {
> -{ 127742 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\=
\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\=
\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CP=
Us\000\000\000\00001 */
> -{ 129052 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-back=
end / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle=
\000\000\000\000\000\00000 */
> -{ 129352 }, /* branch_frequency\000Default\000branches / (software@cpu\\=
-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,=
name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000=
\000\000\00001 */
> -{ 129531 }, /* branch_miss_rate\000Default\000branch\\-misses / branches=
\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000=
00 */
> -{ 127927 }, /* cs_per_second\000Default\000software@context\\-switches\\=
,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\=
\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@=
)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 *=
/
> -{ 129177 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@c=
pu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cloc=
k\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\00=
0\000\00001 */
> -{ 128923 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-fro=
ntend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per c=
ycle\000\000\000\000\000\00000 */
> -{ 128648 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\=
000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\00=
0\000\00000 */
> -{ 128159 }, /* migrations_per_second\000Default\000software@cpu\\-migrat=
ions\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3D=
cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cl=
ock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrati=
ons/sec\000\000\000\00001 */
> -{ 128418 }, /* page_faults_per_second\000Default\000software@page\\-faul=
ts\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\=
-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)=
\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
> -{ 128760 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\=
\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max =
front or backend stalls per instruction\000\000\000\000\000\00000 */
> +{ 127758 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,name\=
\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\=
\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001CP=
Us\000\000\000\00001 */
> +{ 129068 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-back=
end / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cycle=
\000\000\000\000\000\00000 */
> +{ 129368 }, /* branch_frequency\000Default\000branches / (software@cpu\\=
-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,=
name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000K/sec\000=
\000\000\00001 */
> +{ 129547 }, /* branch_miss_rate\000Default\000branch\\-misses / branches=
\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\000=
00 */
> +{ 127943 }, /* cs_per_second\000Default\000software@context\\-switches\\=
,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\=
\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@=
)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001 *=
/
> +{ 129193 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software@c=
pu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cloc=
k\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\00=
0\000\00001 */
> +{ 128939 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-fro=
ntend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per c=
ycle\000\000\000\000\000\00000 */
> +{ 128664 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycles\=
000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\00=
0\000\00000 */
> +{ 128175 }, /* migrations_per_second\000Default\000software@cpu\\-migrat=
ions\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=3D=
cpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cl=
ock@)\000\000Process migrations to a new CPU per CPU second\000\0001migrati=
ons/sec\000\000\000\00001 */
> +{ 128434 }, /* page_faults_per_second\000Default\000software@page\\-faul=
ts\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu\\=
-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)=
\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 */
> +{ 128776 }, /* stalled_cycles_per_instruction\000Default\000max(stalled\=
\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Max =
front or backend stalls per instruction\000\000\000\000\000\00000 */
>
>  };
>
> @@ -2638,29 +2638,29 @@ static const struct pmu_table_entry pmu_metrics__=
common[] =3D {
>  };
>
>  static const struct compact_pmu_event pmu_events__test_soc_cpu_default_c=
ore[] =3D {
> -{ 126189 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
> -{ 126251 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
> -{ 126513 }, /* dispatch_blocked.any\000other\000Memory cluster signals t=
o block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
> -{ 126646 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep=
(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000=
\000\000\000\000\000 */
> -{ 126313 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D=
0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 *=
/
> -{ 126411 }, /* segment_reg_loads.any\000other\000Number of segment regis=
ter loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\0=
00\000 */
> +{ 126205 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000event=
=3D0x8a\000\00000\000\000\000\000\000 */
> +{ 126267 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000event=
=3D0x8b\000\00000\000\000\000\000\000 */
> +{ 126529 }, /* dispatch_blocked.any\000other\000Memory cluster signals t=
o block micro-op dispatch for any reason\000event=3D9,period=3D200000,umask=
=3D0x20\000\00000\000\000\000\000\000 */
> +{ 126662 }, /* eist_trans\000other\000Number of Enhanced Intel SpeedStep=
(R) Technology (EIST) transitions\000event=3D0x3a,period=3D200000\000\00000=
\000\000\000\000\000 */
> +{ 126329 }, /* l3_cache_rd\000cache\000L3 cache access, read\000event=3D=
0x40\000\00000\000\000\000\000Attributable Level 3 cache access, read\000 *=
/
> +{ 126427 }, /* segment_reg_loads.any\000other\000Number of segment regis=
ter loads\000event=3D6,period=3D200000,umask=3D0x80\000\00000\000\000\000\0=
00\000 */
>  };
>  static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl=
_ddrc[] =3D {
> -{ 126779 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write comman=
ds\000event=3D2\000\00000\000\000\000\000\000 */
> +{ 126795 }, /* uncore_hisi_ddrc.flux_wcmd\000uncore\000DDRC write comman=
ds\000event=3D2\000\00000\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__test_soc_cpu_hisi_sccl=
_l3c[] =3D {
> -{ 127141 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits=
\000event=3D7\000\00000\000\000\000\000\000 */
> +{ 127157 }, /* uncore_hisi_l3c.rd_hit_cpipe\000uncore\000Total read hits=
\000event=3D7\000\00000\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_cb=
ox[] =3D {
> -{ 127015 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\=
000\00000\000\000\000\000\000 */
> -{ 127069 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0=
xc0\000\00000\000\000\000\000\000 */
> -{ 126861 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-=
core snoop resulted from L3 Eviction which misses in some processor core\00=
0event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
> +{ 127031 }, /* event-hyphen\000uncore\000UNC_CBO_HYPHEN\000event=3D0xe0\=
000\00000\000\000\000\000\000 */
> +{ 127085 }, /* event-two-hyph\000uncore\000UNC_CBO_TWO_HYPH\000event=3D0=
xc0\000\00000\000\000\000\000\000 */
> +{ 126877 }, /* unc_cbo_xsnp_response.miss_eviction\000uncore\000A cross-=
core snoop resulted from L3 Eviction which misses in some processor core\00=
0event=3D0x22,umask=3D0x81\000\00000\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_im=
c[] =3D {
> -{ 127324 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000ev=
ent=3D0x34\000\00000\000\000\000\000\000 */
> +{ 127340 }, /* uncore_imc.cache_hits\000uncore\000Total cache hits\000ev=
ent=3D0x34\000\00000\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__test_soc_cpu_uncore_im=
c_free_running[] =3D {
> -{ 127233 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cac=
he misses\000event=3D0x12\000\00000\000\000\000\000\000 */
> +{ 127249 }, /* uncore_imc_free_running.cache_miss\000uncore\000Total cac=
he misses\000event=3D0x12\000\00000\000\000\000\000\000 */
>
>  };
>
> @@ -2673,46 +2673,46 @@ static const struct pmu_table_entry pmu_events__t=
est_soc_cpu[] =3D {
>  {
>       .entries =3D pmu_events__test_soc_cpu_hisi_sccl_ddrc,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_ddrc=
),
> -     .pmu_name =3D { 126764 /* hisi_sccl,ddrc\000 */ },
> +     .pmu_name =3D { 126780 /* hisi_sccl,ddrc\000 */ },
>  },
>  {
>       .entries =3D pmu_events__test_soc_cpu_hisi_sccl_l3c,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_hisi_sccl_l3c)=
,
> -     .pmu_name =3D { 127127 /* hisi_sccl,l3c\000 */ },
> +     .pmu_name =3D { 127143 /* hisi_sccl,l3c\000 */ },
>  },
>  {
>       .entries =3D pmu_events__test_soc_cpu_uncore_cbox,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_cbox),
> -     .pmu_name =3D { 126849 /* uncore_cbox\000 */ },
> +     .pmu_name =3D { 126865 /* uncore_cbox\000 */ },
>  },
>  {
>       .entries =3D pmu_events__test_soc_cpu_uncore_imc,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc),
> -     .pmu_name =3D { 127313 /* uncore_imc\000 */ },
> +     .pmu_name =3D { 127329 /* uncore_imc\000 */ },
>  },
>  {
>       .entries =3D pmu_events__test_soc_cpu_uncore_imc_free_running,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_cpu_uncore_imc_fre=
e_running),
> -     .pmu_name =3D { 127209 /* uncore_imc_free_running\000 */ },
> +     .pmu_name =3D { 127225 /* uncore_imc_free_running\000 */ },
>  },
>  };
>
>  static const struct compact_pmu_event pmu_metrics__test_soc_cpu_default_=
core[] =3D {
> -{ 129634 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> -{ 130315 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_M=
iss\000\000\000\000\000\000\000\00000 */
> -{ 130087 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l=
2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> -{ 130181 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd=
 - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\0=
00\000\000\000\000\000\000\00000 */
> -{ 130379 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
> -{ 130447 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCach=
e_L2_All)\000\000\000\000\000\000\000\00000 */
> -{ 129719 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (=
4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active =
/ cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> -{ 129656 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thre=
ad\000\000\000\000\000\000\000\00000 */
> -{ 130581 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / dur=
ation_time\000\000\000\000\000\000\000\00000 */
> -{ 130517 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> -{ 130539 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> -{ 130561 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> -{ 130016 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\00000 */
> -{ 129885 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\00000 */
> -{ 129949 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\00000 */
> +{ 129650 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> +{ 130331 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All_M=
iss\000\000\000\000\000\000\000\00000 */
> +{ 130103 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit + l=
2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> +{ 130197 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_rd=
 - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss\0=
00\000\000\000\000\000\000\00000 */
> +{ 130395 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCache_=
L2_All)\000\000\000\000\000\000\000\00000 */
> +{ 130463 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCach=
e_L2_All)\000\000\000\000\000\000\000\00000 */
> +{ 129735 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core / (=
4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_active =
/ cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> +{ 129672 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.thre=
ad\000\000\000\000\000\000\000\00000 */
> +{ 130597 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / dur=
ation_time\000\000\000\000\000\000\000\00000 */
> +{ 130533 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> +{ 130555 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> +{ 130577 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> +{ 130032 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache_m=
iss_cycles\000\000\000\000\000\000\000\00000 */
> +{ 129901 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_retire=
d.any\000\000\000\000\000\000\000\00000 */
> +{ 129965 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_ret=
ired.any\000\000\000\000\000\000\000\00000 */
>
>  };
>
> @@ -2725,13 +2725,13 @@ static const struct pmu_table_entry pmu_metrics__=
test_soc_cpu[] =3D {
>  };
>
>  static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sy=
s_ccn_pmu[] =3D {
> -{ 127503 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles even=
t\000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
> +{ 127519 }, /* sys_ccn_pmu.read_cycles\000uncore\000ccn read-cycles even=
t\000config=3D0x2c\0000x01\00000\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sy=
s_cmn_pmu[] =3D {
> -{ 127599 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cach=
e misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000=
(434|436|43c|43a).*\00000\000\000\000\000\000 */
> +{ 127615 }, /* sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts total cach=
e misses in first lookup result (high priority)\000eventid=3D1,type=3D5\000=
(434|436|43c|43a).*\00000\000\000\000\000\000 */
>  };
>  static const struct compact_pmu_event pmu_events__test_soc_sys_uncore_sy=
s_ddr_pmu[] =3D {
> -{ 127408 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles ev=
ent\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
> +{ 127424 }, /* sys_ddr_pmu.write_cycles\000uncore\000ddr write-cycles ev=
ent\000event=3D0x2b\000v8\00000\000\000\000\000\000 */
>
>  };
>
> @@ -2739,17 +2739,17 @@ static const struct pmu_table_entry pmu_events__t=
est_soc_sys[] =3D {
>  {
>       .entries =3D pmu_events__test_soc_sys_uncore_sys_ccn_pmu,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ccn=
_pmu),
> -     .pmu_name =3D { 127484 /* uncore_sys_ccn_pmu\000 */ },
> +     .pmu_name =3D { 127500 /* uncore_sys_ccn_pmu\000 */ },
>  },
>  {
>       .entries =3D pmu_events__test_soc_sys_uncore_sys_cmn_pmu,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_cmn=
_pmu),
> -     .pmu_name =3D { 127580 /* uncore_sys_cmn_pmu\000 */ },
> +     .pmu_name =3D { 127596 /* uncore_sys_cmn_pmu\000 */ },
>  },
>  {
>       .entries =3D pmu_events__test_soc_sys_uncore_sys_ddr_pmu,
>       .num_entries =3D ARRAY_SIZE(pmu_events__test_soc_sys_uncore_sys_ddr=
_pmu),
> -     .pmu_name =3D { 127389 /* uncore_sys_ddr_pmu\000 */ },
> +     .pmu_name =3D { 127405 /* uncore_sys_ddr_pmu\000 */ },
>  },
>  };
>
> --
> 2.51.2.1041.gc1ab5b90ca-goog
>
