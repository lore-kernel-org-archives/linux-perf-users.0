Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65482942A
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 03:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738119831; cv=none; b=T88bgplV7pSVF4eKGsiBQvwCF2/dH7HtBD7xLlD/+kl7Hfh3voln9TxKJ02F0yvImFTd0WP2zmurFaeS4hsMtzMKS1ju4LGXuq3YgToYVSzC4XO0wYcoC9Io69Ntw7cJ96lZJoae00Yisn2BB+IY7lHlCkgyjW9LNXdJlGoOQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738119831; c=relaxed/simple;
	bh=AG5OlExz4VXOPwBgVubZCEeyevAQ6Igf5nw4lkm77XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiL31Hh3XLTQZeFiuRmEZChpXqpT8Cx3/DqGIXG6qggptNIqwK47WvXG7rhclTDgLyBTJzEHoc4tsAANtt0WlDyoK6N91/5O4uGjzB66AhL++KmQReviQ4RmcpUBcMjZW/WhzQOWZVmUsXWvFOvQv073gfpyaNzStu+dBZnlQUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=W/hZAn8k; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="W/hZAn8k"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EE7453F2F0
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jan 2025 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1738119820;
	bh=f0+1dVCY6CplcArHxeRGoDAYBHrIUsJeyQ9yXX6fdl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=W/hZAn8kQN07HJi6+HyjcC7fkRAMxvYR0zB7zEPtH+yn0jfMkJCcMMRBHZKEOBsH1
	 cPrJHdn0tAbM1XvO4tC0tSf//Tx+/7vDhJF/5l/jETYWi4L/2fPNOCVxIZDc6dxp3C
	 psymNxXnXtk3gBuAOXruLd3vFDTR/G92ZBJizZZQSrcs5u3dHnKCbA4DgSUvZ0jC91
	 WA0FkFG6B+yHYmo/1pbKKwVbXNcLv4x5eFrBwXu66BfsjabkNaY2PinCyyLotHB5N1
	 RLtyqcMOZPBjgfRyr8druGcrAjyTXEDDZ/WuyfuvccjQ0XzkvH5r1rot77K8CCaYi+
	 UHDBk2ZB4lF6g==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f550d28f7dso12283666a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Jan 2025 19:03:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738119818; x=1738724618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0+1dVCY6CplcArHxeRGoDAYBHrIUsJeyQ9yXX6fdl4=;
        b=AdM+rzwlkGe4wDGc/YQiMl2qQMW+tcfNUoY4dPNAP/ABEacQZj6TYO2ZVZvlyLC420
         KErMszoKpGQWyuVnLyb0lZHaLlul8sg5ee4aqsBM6yURO7vty2/+eRdNsEcv1VuiRZIe
         laR5f6iM172YaHBPqphm3qFHg/NbQaYpOXLeYbYsk4nTm4IFYJouKSWGmn/nj6w6OHIV
         /va3xLOta3kalrhQY6ZMFhcuS7GtSRO7p5VMFDcUWl3gBuLffI+GHjtvYrE/zbf6gHPb
         uRB1PQjRK83av/95xVLQ2MAB8OYeg8y/rD8FyTBQhq2xubBL5EWcHAT8f2nWDD1c/PGG
         9I8g==
X-Forwarded-Encrypted: i=1; AJvYcCXB3KyNN0E1hH96/AWCuYN+ODky+GgJFBH1J/Wzt+5+MDNL59Ir3RSrHBquFktqAINwTEy5QanOlSs/MZ932iz5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xZkm42rC1Oq1Dgn053sUVd9BP775mHqSfiDEPgxPsDd9HBda
	w9moCpS7tQyk4ShLzKbO/XgyoUgWHMtClKIIT3ymyB+fY0HCDAt1KzwMqAUbR51eNAku+mLk/oF
	YWkkmCgDEuh9f37OAFEUpCviaIL/ojQGWqJKVDOJMjWEEL+2f3/JOyzetFM54popn/myZTzkA4b
	ENTofE/M0=
X-Gm-Gg: ASbGnct/B1EAcMpoQsYVXdTy/tyUYyL5hEgjaXPrfE+1xDMUY6UC1M1iBqlt7SbBuml
	5W72KKXnJvXFQPH40ndoiGDmDWOShRDwoNFHJjGrA+LGNTBgEA5iYYa1n3Q3sqzcPFK8GKOJrq2
	hAkF3MRdUw95U/HqPWsq3y5JPk9pPuvwW3ZbMv8SyYaOK6jLi2Kor87sozgtlFw97oqJyPMaZsD
	xBlErOag453r5GcGoFL1zU5ERrJCkWFZhF83Zhja+yA72xbk9AsyCZ4ma8W+nFbyYw8zMfOC0++
	f/zoMKo=
X-Received: by 2002:a17:90a:d006:b0:2f2:a664:df33 with SMTP id 98e67ed59e1d1-2f83abab731mr2085273a91.1.1738119818296;
        Tue, 28 Jan 2025 19:03:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS4pjpy3HNlsZXhaZE88VRh85Dj78+AH9Go9ytng4oGw28iUeNvCzeprTzFhEZyqwN+nSOoQ==
X-Received: by 2002:a17:90a:d006:b0:2f2:a664:df33 with SMTP id 98e67ed59e1d1-2f83abab731mr2085230a91.1.1738119817815;
        Tue, 28 Jan 2025 19:03:37 -0800 (PST)
Received: from localhost ([240f:74:7be:1:daf2:7ab4:ebc3:f450])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83be338fasm334741a91.47.2025.01.28.19.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 19:03:37 -0800 (PST)
Date: Wed, 29 Jan 2025 12:03:35 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com, 
	irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.dei, 
	gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
Message-ID: <o6lskhkmwehl4snhpx6j7zlgv3npz3ckp6npnjizqphtmyh7dn@e4ige74hbqau>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
 <uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk>
 <98f6108a-3a4f-4ad1-8f0a-a03264f7a2d7@amd.com>
 <6ljdgok5zostmu4uxixwh3idgrrtodul4bjvujvwjfda427snu@3vxczriucb6m>
 <1276efa0-488c-448b-adf8-b002c77179f6@amd.com>
 <73fbc810-6666-4997-8f0b-75d2eab8a943@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73fbc810-6666-4997-8f0b-75d2eab8a943@amd.com>

On Tue, Jan 28, 2025 at 01:41:51PM GMT, Dhananjay Ugwekar wrote:
> On 1/20/2025 5:12 PM, Dhananjay Ugwekar wrote:
> > On 1/15/2025 7:53 PM, Koichiro Den wrote:
> >> On Mon, Jan 13, 2025 at 12:04:43PM GMT, Dhananjay Ugwekar wrote:
> >>> On 1/12/2025 7:12 PM, Koichiro Den wrote:
> >>>> On Fri, Nov 15, 2024 at 06:08:06AM GMT, Dhananjay Ugwekar wrote:
> >>>>> Add a new "power_core" PMU and "energy-core" event for monitoring
> >>>>> energy consumption by each individual core. The existing energy-cores
> >>>>> event aggregates the energy consumption of CPU cores at the package level.
> >>>>> This new event aligns with the AMD's per-core energy counters.
> >>>>>
> >>>>> Tested the package level and core level PMU counters with workloads
> >>>>> pinned to different CPUs.
> >>>>>
> >>>>> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
> >>>>> machine:
> >>>>>
> >>>>> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
> >>>>> stress-ng: info:  [21250] setting to a 5 second run per stressor
> >>>>> stress-ng: info:  [21250] dispatching hogs: 1 matrix
> >>>>> stress-ng: info:  [21250] successful run completed in 5.00s
> >>>>>
> >>>>>  Performance counter stats for 'system wide':
> >>>>>
> >>>>> S0-D0-C0              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D0-C1              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D0-C2              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D0-C3              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D0-C4              1               8.43 Joules power_core/energy-core/
> >>>>> S0-D0-C5              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D0-C6              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D0-C7              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D1-C8              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D1-C9              1               0.00 Joules power_core/energy-core/
> >>>>> S0-D1-C10             1               0.00 Joules power_core/energy-core/
> >>>>>
> >>>>> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> >>>>> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> >>>>> ---
> >>>>>  arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
> >>>>>  1 file changed, 152 insertions(+), 33 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> >>>>> index 6e51386ff91f..e9be1f31163d 100644
> >>>>> --- a/arch/x86/events/rapl.c
> >>>>> +++ b/arch/x86/events/rapl.c
> >>>>> @@ -39,6 +39,10 @@
> >>>>>   *	  event: rapl_energy_psys
> >>>>>   *    perf code: 0x5
> >>>>>   *
> >>>>> + *  core counter: consumption of a single physical core
> >>>>> + *	  event: rapl_energy_core (power_core PMU)
> >>>>> + *    perf code: 0x1
> >>>>> + *
> >>>>>   * We manage those counters as free running (read-only). They may be
> >>>>>   * use simultaneously by other tools, such as turbostat.
> >>>>>   *
> >>>>> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
> >>>>>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
> >>>>>  };
> >>>>>  
> >>>>> +#define PERF_RAPL_CORE			0		/* single core */
> >>>>> +#define PERF_RAPL_CORE_EVENTS_MAX	1
> >>>>> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
> >>>>> +
> >>>>>  static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
> >>>>>  	"pp0-core",
> >>>>>  	"package",
> >>>>> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
> >>>>>  	"psys",
> >>>>>  };
> >>>>>  
> >>>>> +static const char *const rapl_core_domain_name __initconst = "core";
> >>>>> +
> >>>>>  /*
> >>>>>   * event code: LSB 8 bits, passed in attr->config
> >>>>>   * any other bit is reserved
> >>>>> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
> >>>>>  
> >>>>>  struct rapl_model {
> >>>>>  	struct perf_msr *rapl_pkg_msrs;
> >>>>> +	struct perf_msr *rapl_core_msrs;
> >>>>>  	unsigned long	pkg_events;
> >>>>> +	unsigned long	core_events;
> >>>>>  	unsigned int	msr_power_unit;
> >>>>>  	enum rapl_unit_quirk	unit_quirk;
> >>>>>  };
> >>>>>  
> >>>>>   /* 1/2^hw_unit Joule */
> >>>>>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
> >>>>> +static int rapl_core_hw_unit __read_mostly;
> >>>>>  static struct rapl_pmus *rapl_pmus_pkg;
> >>>>> +static struct rapl_pmus *rapl_pmus_core;
> >>>>>  static u64 rapl_timer_ms;
> >>>>>  static struct rapl_model *rapl_model;
> >>>>>  
> >>>>> @@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
> >>>>>   * Helper function to get the correct topology id according to the
> >>>>>   * RAPL PMU scope.
> >>>>>   */
> >>>>> -static inline unsigned int get_rapl_pmu_idx(int cpu)
> >>>>> -{	/*
> >>>>> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
> >>>>> +{
> >>>>> +	/*
> >>>>>  	 * Returns unsigned int, which converts the '-1' return value
> >>>>>  	 * (for non-existent mappings in topology map) to UINT_MAX, so
> >>>>>  	 * the error check in the caller is simplified.
> >>>>>  	 */
> >>>>> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> >>>>> -					     topology_logical_die_id(cpu);
> >>>>> +	switch (scope) {
> >>>>> +	case PERF_PMU_SCOPE_PKG:
> >>>>> +		return topology_logical_package_id(cpu);
> >>>>> +	case PERF_PMU_SCOPE_DIE:
> >>>>> +		return topology_logical_die_id(cpu);
> >>>>> +	case PERF_PMU_SCOPE_CORE:
> >>>>> +		return topology_logical_core_id(cpu);
> >>>>> +	default:
> >>>>> +		return -EINVAL;
> >>>>> +	}
> >>>>>  }
> >>>>>  
> >>>>>  static inline u64 rapl_read_counter(struct perf_event *event)
> >>>>> @@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
> >>>>>  	return raw;
> >>>>>  }
> >>>>>  
> >>>>> -static inline u64 rapl_scale(u64 v, int cfg)
> >>>>> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
> >>>>>  {
> >>>>> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
> >>>>> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
> >>>>> -		return v;
> >>>>> -	}
> >>>>> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
> >>>>> +
> >>>>> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
> >>>>> +		hw_unit = rapl_core_hw_unit;
> >>>>> +
> >>>>>  	/*
> >>>>>  	 * scale delta to smallest unit (1/2^32)
> >>>>>  	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
> >>>>>  	 * or use ldexp(count, -32).
> >>>>>  	 * Watts = Joules/Time delta
> >>>>>  	 */
> >>>>> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
> >>>>> +	return v << (32 - hw_unit);
> >>>>>  }
> >>>>>  
> >>>>>  static u64 rapl_event_update(struct perf_event *event)
> >>>>> @@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
> >>>>>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
> >>>>>  	delta >>= shift;
> >>>>>  
> >>>>> -	sdelta = rapl_scale(delta, event->hw.config);
> >>>>> +	sdelta = rapl_scale(delta, event);
> >>>>>  
> >>>>>  	local64_add(sdelta, &event->count);
> >>>>>  
> >>>>> @@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
> >>>>>  static int rapl_pmu_event_init(struct perf_event *event)
> >>>>>  {
> >>>>>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
> >>>>> -	int bit, ret = 0;
> >>>>> +	int bit, rapl_pmus_scope, ret = 0;
> >>>>>  	struct rapl_pmu *rapl_pmu;
> >>>>>  	unsigned int rapl_pmu_idx;
> >>>>> +	struct rapl_pmus *rapl_pmus;
> >>>>>  
> >>>>> -	/* only look at RAPL events */
> >>>>> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
> >>>>> -		return -ENOENT;
> >>>>> +	/* unsupported modes and filters */
> >>>>> +	if (event->attr.sample_period) /* no sampling */
> >>>>> +		return -EINVAL;
> >>>>
> >>>> Hi Dhananjay,
> >>>>
> >>>> On linux-next, since this commit, it seems that simple sampling with 'perf
> >>>> record -- <command>' (i.e. the default event), 'perf top' etc. can
> >>>> unexpectedly fail because rapl_pmu_event_init() now returns -EINVAL instead
> >>>> of -ENOENT even in such cases of a type mismatch. I observed that this
> >>>> prevents evsel__fallback() from falling back to cpu-clock or task-clock.
> >>>>
> >>>> Should we reorder the checks in rapl_pmu_event_init() to allow an early
> >>>> return with -ENOENT in such cases, as shown below? I'm not very familiar
> >>>> with this area and I might be missing something. I'd appreciate it if you
> >>>> could share your thoughts.
> >>>>
> >>>> --- a/arch/x86/events/rapl.c
> >>>> +++ b/arch/x86/events/rapl.c
> >>>> @@ -370,17 +370,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
> >>>>         unsigned int rapl_pmu_idx;
> >>>>         struct rapl_pmus *rapl_pmus;
> >>>>
> >>>> -       /* unsupported modes and filters */
> >>>> -       if (event->attr.sample_period) /* no sampling */
> >>>> -               return -EINVAL;
> >>>> -
> >>>> -       /* check only supported bits are set */
> >>>> -       if (event->attr.config & ~RAPL_EVENT_MASK)
> >>>> -               return -EINVAL;
> >>>> -
> >>>> -       if (event->cpu < 0)
> >>>> -               return -EINVAL;
> >>>> -
> >>>>         rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
> >>>>         if (!rapl_pmus)
> >>>>                 return -EINVAL;
> >>>> @@ -411,6 +400,17 @@ static int rapl_pmu_event_init(struct perf_event *event)
> >>>>         } else
> >>>>                 return -EINVAL;
> >>>>
> >>>> +       /* unsupported modes and filters */
> >>>> +       if (event->attr.sample_period) /* no sampling */
> >>>> +               return -EINVAL;
> >>>> +
> >>>> +       /* check only supported bits are set */
> >>>> +       if (event->attr.config & ~RAPL_EVENT_MASK)
> >>>> +               return -EINVAL;
> >>>> +
> >>>> +       if (event->cpu < 0)
> >>>> +               return -EINVAL;
> >>>> +
> >>>>         /* check event supported */
> >>>>         if (!(rapl_pmus->cntr_mask & (1 << bit)))
> >>>>                 return -EINVAL;
> >>>>
> >>>> Thanks.
> >>>>
> >>>> -Koichiro
> >>>
> >>> Hello Koichiro,
> >>>
> >>> I tried reproducing the issue you mentioned using "sudo perf record -- sleep 2" and 
> >>> "sudo perf top" commands on an AMD EPYC system, the commands worked successfully. 
> >>> Can you please mention which system and which exact commands you're 
> >>> running that reproduced the issue?
> >>>
> >>> My analysis is, if we are running "perf record/top" with the default event, we would 
> >>> not enter the rapl_pmu_event_init() function, which renders the reordering of the type 
> >>> checks irrelevant. Regardless, please let me know how I can reproduce the issue.
> >>>
> >>> Thanks,
> >>> Dhananjay
> >>
> >> Hi,
> >>
> >> Apologies for the delayed response, and thank you for your comment. I
> >> confirmed that just running "perf top" on a qemu instance reproduces it.
> >> The host CPU model is Intel Core i9-13900K, which is passed through to
> >> the guest.
> >>
> >> In my case, no pmu for PERF_TYPE_RAW is registered, but the rapl pmu is
> >> present. Then, perf_init_event() reaches the line marked "---->" below, and
> >> rapl_pmu_event_init() run, which returns -EINVAL before the type check.
> >>
> >>   static struct pmu *perf_init_event(struct perf_event *event)
> >>   {
> >>           [...]
> >>           if (pmu) {
> >>                   [...]
> >>                   goto unlock;
> >>           }
> >>     
> >>           list_for_each_entry_rcu(pmu, &pmus, entry, lockdep_is_held(&pmus_srcu)) {
> >>   ---->           ret = perf_try_init_event(pmu, event);
> >>                   if (!ret)
> >>                           goto unlock;
> >>     
> >>                   if (ret != -ENOENT) {
> >>                           pmu = ERR_PTR(ret);
> >>                           goto unlock;
> >>                   }
> >>           }
> >>
> >> I'll look into this a bit more on my side later and get back to you if
> >> something becomes clear.
> > 
> > Sorry for the delayed response, can you please try the below diff and let me know 
> > if it fixes the issue?
> 
> Hello Koichiro,
> 
> Gentle ping, please let me know once you try out the below fix.

Sorry to be late. Yes it works.
Early return with -ENOENT when event->attr.type != event->pmu->type seems
like a common approach used in other pmu implementations as well.

Thanks,
Koichiro

> 
> Thanks,
> Dhananjay
> 
> > 
> > diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> > index d3bb3865c1b1..4952faf03e82 100644
> > --- a/arch/x86/events/rapl.c
> > +++ b/arch/x86/events/rapl.c
> > @@ -370,6 +370,10 @@ static int rapl_pmu_event_init(struct perf_event *event)
> >         unsigned int rapl_pmu_idx;
> >         struct rapl_pmus *rapl_pmus;
> > 
> > +       /* only look at RAPL events */
> > +       if (event->attr.type != event->pmu->type)
> > +               return -ENOENT;
> > +
> >         /* unsupported modes and filters */
> >         if (event->attr.sample_period) /* no sampling */
> >                 return -EINVAL;
> > @@ -387,10 +391,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
> >         rapl_pmus_scope = rapl_pmus->pmu.scope;
> > 
> >         if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
> > -               /* only look at RAPL package events */
> > -               if (event->attr.type != rapl_pmus_pkg->pmu.type)
> > -                       return -ENOENT;
> > -
> >                 cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
> >                 if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> >                         return -EINVAL;
> > @@ -398,10 +398,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
> >                 bit = cfg - 1;
> >                 event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
> >         } else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
> > -               /* only look at RAPL core events */
> > -               if (event->attr.type != rapl_pmus_core->pmu.type)
> > -                       return -ENOENT;
> > -
> >                 cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
> >                 if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> >                         return -EINVAL;
> > 
> >>
> >> Thanks,
> >>
> >> -Koichiro
> > 
> 
