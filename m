Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6E1B4F1A
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736689383; cv=none; b=Vap+FYX40D3fBu4LMZCKvp4fHB14fxZ1uuqpMwbb6QmHl6pAG0n04CR3Scb5LXSGJa0j3IfJbWsmBEAR2ODHMGlGYtX+S9b3jVeOOjXq6nqfbp0sAzCiqUmYrEsOHO5M2wnjqC5/VGvs98LIG+TIgTmKO+EZNvPreRGgwGbkJUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736689383; c=relaxed/simple;
	bh=c3ia+DjshRY9LadSHZIcjKnOsy+lH5YYvow7JDj8/cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFpg4hlGhdtH6mdf4fV+XAsT4AGLA/8hhx9MFPRDDXy55MDRapEepLlTJmjEEyRCIP7Ss2xm7RlkEuAJQ5k7MvokOPqibSO9LrLhKykr9Afe6353i7xVv0d04f/hJnRai7zuTIywiRzkQptO58dZo8Qf1GoMKSUvUryetfIqAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tw1YKk/6; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tw1YKk/6"
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BA6B73F27F
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 13:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1736689371;
	bh=/SYLtKuL+TcrSYTu3535iKxtYnKffJssQ8uc2Sk8nn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=tw1YKk/6FUxARDGzyK6OYMICwcHuivC5WESHZZftXs8ey9kYL7wwPW28N3Kz/CgYL
	 Q3eSpz7OKshFiJL42Az0SzGaR61XuDX2fCVBxW2DvmN2CO/FdJTHfLrQ5qsFnvSeTV
	 mXpVabrYJmDPZOqRaY26PR9zdv+FcqAG7UtzXjo+NCDJLHyOgSzQ4O9/PmWHsBfe9C
	 XIEegQTs4qRyhNT4LYljlu1b73LxIThk9MD6WwI+GxYD6CdRp8nj7/OhaCIFMoC/5W
	 7E1k4m6fI9cllLXDAlmPJMtMCoIyMlcRkaOUPzRE0ihnE6E55S8Pl69PSjU9yfRD5n
	 PYhg+m1T5q4nA==
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2f46b7851fcso10153552a91.1
        for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 05:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736689367; x=1737294167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SYLtKuL+TcrSYTu3535iKxtYnKffJssQ8uc2Sk8nn4=;
        b=CdUwhBObhC8M/FUDARP6cPC1NzpMsel9dJVu+PRj5rg5p9wWiClKz2auDM6RJKGehq
         ShyIP3k7QGud1XjAuW83cFbsq99Qt33zyewrR196DLaduqyZMTbhE0W2UxNOeWI38vZJ
         JJwGVanMJvQnM77fX2k1yWa27vwZT2O/Edlv5oUPZX7mwzRcHq+L5kz9Z62FWfFgUV7Z
         kUew7cH/EOn7EmRmVDFsPGbZa17cj8Kp/x4AgahB2AKx968bw8T7Q3KW1Sg9P2i6IeBv
         y9TXPqEGA8Ffng5TrDqRgIVhdeLvs1C+JoPKj6jKzBheGf5iU3Ne+3aslejiKZONBlTw
         xS3A==
X-Forwarded-Encrypted: i=1; AJvYcCVy3i/GWItZ/ZcJUmfKU/V2ilOESocqu2ubAyULd7FzNhPjBIQ4/AHIfPh7vrxKHHTtgNdBdAvKfmH7GOr8AskB@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqxUV4NNga0vrHmxG7fKXbNfn0gtcBj9PK8UNEVZghaY+gDOH
	4DkNTSudGwpMBtpPr154GZFP4BmGFIzL5YqRnGBZZJu8vlQXi+p3zLdaCL4hM/BOxGw8QHv6lm3
	9xYVvHFEs/bUMFtvsGZn0R2YC4lfKL5CONS1ZA/gf1rwiCSm2hURGApkVgUAmmcju+P23WxJvsY
	21qLgygfM=
X-Gm-Gg: ASbGncvBp1wFJ+L5NuxsO9QYr/e6X9bWnaFX4H4GwV/tYBtyy0tUAmkPpT29XiEnfih
	pea3ISToDL1oAPFjHTfLuGCaAt0Hpel5I4LjQH365Z9V0RKs+Byucplu3x7qHW7cF4SP5/wt7p9
	OAwOzKgcNMIUNdKdUsti1ZDgBpnR9Sc+1giiwGS8AjooumM19GOy2E4uoBPlFfZ0kCEQfAiVwb2
	T6qFqFG7w98TljIrvh6XPrXwmY7DHgN1K3gabYlYSD8aodsAOZc5zo2uA0=
X-Received: by 2002:a05:6a00:408e:b0:725:9dc7:4f8b with SMTP id d2e1a72fcca58-72d21f562c6mr23526898b3a.15.1736689367292;
        Sun, 12 Jan 2025 05:42:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrMMTskNvubTL+r7umeiw9uFk/SWpiMmiUrJSlENrizBev1U/5D9v1rEAWBOkTOI5bQHhkMg==
X-Received: by 2002:a05:6a00:408e:b0:725:9dc7:4f8b with SMTP id d2e1a72fcca58-72d21f562c6mr23526869b3a.15.1736689366892;
        Sun, 12 Jan 2025 05:42:46 -0800 (PST)
Received: from localhost ([240f:74:7be:1:2846:8ec3:3898:1a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a5f3sm4504874b3a.58.2025.01.12.05.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 05:42:46 -0800 (PST)
Date: Sun, 12 Jan 2025 22:42:44 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, rui.zhang@intel.com, 
	irogers@google.com, kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.dei, 
	gautham.shenoy@amd.com, kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
Message-ID: <uv7mz6vew2bzgre5jdpmwldxljp5djzmuiksqdcdwipfm4zm7w@ribobcretidk>
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>

On Fri, Nov 15, 2024 at 06:08:06AM GMT, Dhananjay Ugwekar wrote:
> Add a new "power_core" PMU and "energy-core" event for monitoring
> energy consumption by each individual core. The existing energy-cores
> event aggregates the energy consumption of CPU cores at the package level.
> This new event aligns with the AMD's per-core energy counters.
> 
> Tested the package level and core level PMU counters with workloads
> pinned to different CPUs.
> 
> Results with workload pinned to CPU 4 in core 4 on an AMD Zen4 Genoa
> machine:
> 
> $ sudo perf stat --per-core -e power_core/energy-core/ -- taskset -c 4 stress-ng --matrix 1 --timeout 5s
> stress-ng: info:  [21250] setting to a 5 second run per stressor
> stress-ng: info:  [21250] dispatching hogs: 1 matrix
> stress-ng: info:  [21250] successful run completed in 5.00s
> 
>  Performance counter stats for 'system wide':
> 
> S0-D0-C0              1               0.00 Joules power_core/energy-core/
> S0-D0-C1              1               0.00 Joules power_core/energy-core/
> S0-D0-C2              1               0.00 Joules power_core/energy-core/
> S0-D0-C3              1               0.00 Joules power_core/energy-core/
> S0-D0-C4              1               8.43 Joules power_core/energy-core/
> S0-D0-C5              1               0.00 Joules power_core/energy-core/
> S0-D0-C6              1               0.00 Joules power_core/energy-core/
> S0-D0-C7              1               0.00 Joules power_core/energy-core/
> S0-D1-C8              1               0.00 Joules power_core/energy-core/
> S0-D1-C9              1               0.00 Joules power_core/energy-core/
> S0-D1-C10             1               0.00 Joules power_core/energy-core/
> 
> Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> ---
>  arch/x86/events/rapl.c | 185 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 152 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index 6e51386ff91f..e9be1f31163d 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -39,6 +39,10 @@
>   *	  event: rapl_energy_psys
>   *    perf code: 0x5
>   *
> + *  core counter: consumption of a single physical core
> + *	  event: rapl_energy_core (power_core PMU)
> + *    perf code: 0x1
> + *
>   * We manage those counters as free running (read-only). They may be
>   * use simultaneously by other tools, such as turbostat.
>   *
> @@ -81,6 +85,10 @@ enum perf_rapl_pkg_events {
>  	NR_RAPL_PKG_DOMAINS = PERF_RAPL_PKG_EVENTS_MAX,
>  };
>  
> +#define PERF_RAPL_CORE			0		/* single core */
> +#define PERF_RAPL_CORE_EVENTS_MAX	1
> +#define NR_RAPL_CORE_DOMAINS		PERF_RAPL_CORE_EVENTS_MAX
> +
>  static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst = {
>  	"pp0-core",
>  	"package",
> @@ -89,6 +97,8 @@ static const char *const rapl_pkg_domain_names[NR_RAPL_PKG_DOMAINS] __initconst
>  	"psys",
>  };
>  
> +static const char *const rapl_core_domain_name __initconst = "core";
> +
>  /*
>   * event code: LSB 8 bits, passed in attr->config
>   * any other bit is reserved
> @@ -141,14 +151,18 @@ enum rapl_unit_quirk {
>  
>  struct rapl_model {
>  	struct perf_msr *rapl_pkg_msrs;
> +	struct perf_msr *rapl_core_msrs;
>  	unsigned long	pkg_events;
> +	unsigned long	core_events;
>  	unsigned int	msr_power_unit;
>  	enum rapl_unit_quirk	unit_quirk;
>  };
>  
>   /* 1/2^hw_unit Joule */
>  static int rapl_pkg_hw_unit[NR_RAPL_PKG_DOMAINS] __read_mostly;
> +static int rapl_core_hw_unit __read_mostly;
>  static struct rapl_pmus *rapl_pmus_pkg;
> +static struct rapl_pmus *rapl_pmus_core;
>  static u64 rapl_timer_ms;
>  static struct rapl_model *rapl_model;
>  
> @@ -156,14 +170,23 @@ static struct rapl_model *rapl_model;
>   * Helper function to get the correct topology id according to the
>   * RAPL PMU scope.
>   */
> -static inline unsigned int get_rapl_pmu_idx(int cpu)
> -{	/*
> +static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
> +{
> +	/*
>  	 * Returns unsigned int, which converts the '-1' return value
>  	 * (for non-existent mappings in topology map) to UINT_MAX, so
>  	 * the error check in the caller is simplified.
>  	 */
> -	return rapl_pkg_pmu_is_pkg_scope() ? topology_logical_package_id(cpu) :
> -					     topology_logical_die_id(cpu);
> +	switch (scope) {
> +	case PERF_PMU_SCOPE_PKG:
> +		return topology_logical_package_id(cpu);
> +	case PERF_PMU_SCOPE_DIE:
> +		return topology_logical_die_id(cpu);
> +	case PERF_PMU_SCOPE_CORE:
> +		return topology_logical_core_id(cpu);
> +	default:
> +		return -EINVAL;
> +	}
>  }
>  
>  static inline u64 rapl_read_counter(struct perf_event *event)
> @@ -173,19 +196,20 @@ static inline u64 rapl_read_counter(struct perf_event *event)
>  	return raw;
>  }
>  
> -static inline u64 rapl_scale(u64 v, int cfg)
> +static inline u64 rapl_scale(u64 v, struct perf_event *event)
>  {
> -	if (cfg > NR_RAPL_PKG_DOMAINS) {
> -		pr_warn("Invalid domain %d, failed to scale data\n", cfg);
> -		return v;
> -	}
> +	int hw_unit = rapl_pkg_hw_unit[event->hw.config - 1];
> +
> +	if (event->pmu->scope == PERF_PMU_SCOPE_CORE)
> +		hw_unit = rapl_core_hw_unit;
> +
>  	/*
>  	 * scale delta to smallest unit (1/2^32)
>  	 * users must then scale back: count * 1/(1e9*2^32) to get Joules
>  	 * or use ldexp(count, -32).
>  	 * Watts = Joules/Time delta
>  	 */
> -	return v << (32 - rapl_pkg_hw_unit[cfg - 1]);
> +	return v << (32 - hw_unit);
>  }
>  
>  static u64 rapl_event_update(struct perf_event *event)
> @@ -212,7 +236,7 @@ static u64 rapl_event_update(struct perf_event *event)
>  	delta = (new_raw_count << shift) - (prev_raw_count << shift);
>  	delta >>= shift;
>  
> -	sdelta = rapl_scale(delta, event->hw.config);
> +	sdelta = rapl_scale(delta, event);
>  
>  	local64_add(sdelta, &event->count);
>  
> @@ -341,13 +365,14 @@ static void rapl_pmu_event_del(struct perf_event *event, int flags)
>  static int rapl_pmu_event_init(struct perf_event *event)
>  {
>  	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
> -	int bit, ret = 0;
> +	int bit, rapl_pmus_scope, ret = 0;
>  	struct rapl_pmu *rapl_pmu;
>  	unsigned int rapl_pmu_idx;
> +	struct rapl_pmus *rapl_pmus;
>  
> -	/* only look at RAPL events */
> -	if (event->attr.type != rapl_pmus_pkg->pmu.type)
> -		return -ENOENT;
> +	/* unsupported modes and filters */
> +	if (event->attr.sample_period) /* no sampling */
> +		return -EINVAL;

Hi Dhananjay,

On linux-next, since this commit, it seems that simple sampling with 'perf
record -- <command>' (i.e. the default event), 'perf top' etc. can
unexpectedly fail because rapl_pmu_event_init() now returns -EINVAL instead
of -ENOENT even in such cases of a type mismatch. I observed that this
prevents evsel__fallback() from falling back to cpu-clock or task-clock.

Should we reorder the checks in rapl_pmu_event_init() to allow an early
return with -ENOENT in such cases, as shown below? I'm not very familiar
with this area and I might be missing something. I'd appreciate it if you
could share your thoughts.

--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -370,17 +370,6 @@ static int rapl_pmu_event_init(struct perf_event *event)
        unsigned int rapl_pmu_idx;
        struct rapl_pmus *rapl_pmus;

-       /* unsupported modes and filters */
-       if (event->attr.sample_period) /* no sampling */
-               return -EINVAL;
-
-       /* check only supported bits are set */
-       if (event->attr.config & ~RAPL_EVENT_MASK)
-               return -EINVAL;
-
-       if (event->cpu < 0)
-               return -EINVAL;
-
        rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
        if (!rapl_pmus)
                return -EINVAL;
@@ -411,6 +400,17 @@ static int rapl_pmu_event_init(struct perf_event *event)
        } else
                return -EINVAL;

+       /* unsupported modes and filters */
+       if (event->attr.sample_period) /* no sampling */
+               return -EINVAL;
+
+       /* check only supported bits are set */
+       if (event->attr.config & ~RAPL_EVENT_MASK)
+               return -EINVAL;
+
+       if (event->cpu < 0)
+               return -EINVAL;
+
        /* check event supported */
        if (!(rapl_pmus->cntr_mask & (1 << bit)))
                return -EINVAL;

Thanks.

-Koichiro

>  
>  	/* check only supported bits are set */
>  	if (event->attr.config & ~RAPL_EVENT_MASK)
> @@ -356,31 +381,49 @@ static int rapl_pmu_event_init(struct perf_event *event)
>  	if (event->cpu < 0)
>  		return -EINVAL;
>  
> -	if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +	rapl_pmus = container_of(event->pmu, struct rapl_pmus, pmu);
> +	if (!rapl_pmus)
>  		return -EINVAL;
> -
> -	cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
> -	bit = cfg - 1;
> -
> -	/* check event supported */
> -	if (!(rapl_pmus_pkg->cntr_mask & (1 << bit)))
> +	rapl_pmus_scope = rapl_pmus->pmu.scope;
> +
> +	if (rapl_pmus_scope == PERF_PMU_SCOPE_PKG || rapl_pmus_scope == PERF_PMU_SCOPE_DIE) {
> +		/* only look at RAPL package events */
> +		if (event->attr.type != rapl_pmus_pkg->pmu.type)
> +			return -ENOENT;
> +
> +		cfg = array_index_nospec((long)cfg, NR_RAPL_PKG_DOMAINS + 1);
> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +			return -EINVAL;
> +
> +		bit = cfg - 1;
> +		event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
> +	} else if (rapl_pmus_scope == PERF_PMU_SCOPE_CORE) {
> +		/* only look at RAPL core events */
> +		if (event->attr.type != rapl_pmus_core->pmu.type)
> +			return -ENOENT;
> +
> +		cfg = array_index_nospec((long)cfg, NR_RAPL_CORE_DOMAINS + 1);
> +		if (!cfg || cfg >= NR_RAPL_PKG_DOMAINS + 1)
> +			return -EINVAL;
> +
> +		bit = cfg - 1;
> +		event->hw.event_base = rapl_model->rapl_core_msrs[bit].msr;
> +	} else
>  		return -EINVAL;
>  
> -	/* unsupported modes and filters */
> -	if (event->attr.sample_period) /* no sampling */
> +	/* check event supported */
> +	if (!(rapl_pmus->cntr_mask & (1 << bit)))
>  		return -EINVAL;
>  
> -	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu);
> -	if (rapl_pmu_idx >= rapl_pmus_pkg->nr_rapl_pmu)
> +	rapl_pmu_idx = get_rapl_pmu_idx(event->cpu, rapl_pmus_scope);
> +	if (rapl_pmu_idx >= rapl_pmus->nr_rapl_pmu)
>  		return -EINVAL;
> -
>  	/* must be done before validate_group */
> -	rapl_pmu = rapl_pmus_pkg->rapl_pmu[rapl_pmu_idx];
> +	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
>  	if (!rapl_pmu)
>  		return -EINVAL;
>  
>  	event->pmu_private = rapl_pmu;
> -	event->hw.event_base = rapl_model->rapl_pkg_msrs[bit].msr;
>  	event->hw.config = cfg;
>  	event->hw.idx = bit;
>  
> @@ -397,12 +440,14 @@ RAPL_EVENT_ATTR_STR(energy-pkg  ,   rapl_pkg, "event=0x02");
>  RAPL_EVENT_ATTR_STR(energy-ram  ,   rapl_ram, "event=0x03");
>  RAPL_EVENT_ATTR_STR(energy-gpu  ,   rapl_gpu, "event=0x04");
>  RAPL_EVENT_ATTR_STR(energy-psys,   rapl_psys, "event=0x05");
> +RAPL_EVENT_ATTR_STR(energy-core,   rapl_core, "event=0x01");
>  
>  RAPL_EVENT_ATTR_STR(energy-cores.unit, rapl_cores_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-pkg.unit  ,   rapl_pkg_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-ram.unit  ,   rapl_ram_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-gpu.unit  ,   rapl_gpu_unit, "Joules");
>  RAPL_EVENT_ATTR_STR(energy-psys.unit,   rapl_psys_unit, "Joules");
> +RAPL_EVENT_ATTR_STR(energy-core.unit,   rapl_core_unit, "Joules");
>  
>  /*
>   * we compute in 0.23 nJ increments regardless of MSR
> @@ -412,6 +457,7 @@ RAPL_EVENT_ATTR_STR(energy-pkg.scale,     rapl_pkg_scale, "2.3283064365386962890
>  RAPL_EVENT_ATTR_STR(energy-ram.scale,     rapl_ram_scale, "2.3283064365386962890625e-10");
>  RAPL_EVENT_ATTR_STR(energy-gpu.scale,     rapl_gpu_scale, "2.3283064365386962890625e-10");
>  RAPL_EVENT_ATTR_STR(energy-psys.scale,   rapl_psys_scale, "2.3283064365386962890625e-10");
> +RAPL_EVENT_ATTR_STR(energy-core.scale,   rapl_core_scale, "2.3283064365386962890625e-10");
>  
>  /*
>   * There are no default events, but we need to create
> @@ -444,6 +490,12 @@ static const struct attribute_group *rapl_attr_groups[] = {
>  	NULL,
>  };
>  
> +static const struct attribute_group *rapl_core_attr_groups[] = {
> +	&rapl_pmu_format_group,
> +	&rapl_pmu_events_group,
> +	NULL,
> +};
> +
>  static struct attribute *rapl_events_cores[] = {
>  	EVENT_PTR(rapl_cores),
>  	EVENT_PTR(rapl_cores_unit),
> @@ -504,6 +556,18 @@ static struct attribute_group rapl_events_psys_group = {
>  	.attrs = rapl_events_psys,
>  };
>  
> +static struct attribute *rapl_events_core[] = {
> +	EVENT_PTR(rapl_core),
> +	EVENT_PTR(rapl_core_unit),
> +	EVENT_PTR(rapl_core_scale),
> +	NULL,
> +};
> +
> +static struct attribute_group rapl_events_core_group = {
> +	.name  = "events",
> +	.attrs = rapl_events_core,
> +};
> +
>  static bool test_msr(int idx, void *data)
>  {
>  	return test_bit(idx, (unsigned long *) data);
> @@ -541,6 +605,11 @@ static struct perf_msr amd_rapl_pkg_msrs[] = {
>  	[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  NULL, false, 0 },
>  };
>  
> +static struct perf_msr amd_rapl_core_msrs[] = {
> +	[PERF_RAPL_CORE] = { MSR_AMD_CORE_ENERGY_STATUS, &rapl_events_core_group,
> +				 test_msr, false, RAPL_MSR_MASK },
> +};
> +
>  static int rapl_check_hw_unit(void)
>  {
>  	u64 msr_rapl_power_unit_bits;
> @@ -552,6 +621,8 @@ static int rapl_check_hw_unit(void)
>  	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
>  		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
>  
> +	rapl_core_hw_unit = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
> +
>  	switch (rapl_model->unit_quirk) {
>  	/*
>  	 * DRAM domain on HSW server and KNL has fixed energy unit which can be
> @@ -570,7 +641,6 @@ static int rapl_check_hw_unit(void)
>  		break;
>  	}
>  
> -
>  	/*
>  	 * Calculate the timer rate:
>  	 * Use reference of 200W for scaling the timeout to avoid counter
> @@ -589,9 +659,13 @@ static int rapl_check_hw_unit(void)
>  static void __init rapl_advertise(void)
>  {
>  	int i;
> +	int num_counters = hweight32(rapl_pmus_pkg->cntr_mask);
> +
> +	if (rapl_pmus_core)
> +		num_counters += hweight32(rapl_pmus_core->cntr_mask);
>  
>  	pr_info("API unit is 2^-32 Joules, %d fixed counters, %llu ms ovfl timer\n",
> -		hweight32(rapl_pmus_pkg->cntr_mask), rapl_timer_ms);
> +		num_counters, rapl_timer_ms);
>  
>  	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++) {
>  		if (rapl_pmus_pkg->cntr_mask & (1 << i)) {
> @@ -599,6 +673,10 @@ static void __init rapl_advertise(void)
>  				rapl_pkg_domain_names[i], rapl_pkg_hw_unit[i]);
>  		}
>  	}
> +
> +	if (rapl_pmus_core && (rapl_pmus_core->cntr_mask & (1 << PERF_RAPL_CORE)))
> +		pr_info("hw unit of domain %s 2^-%d Joules\n",
> +			rapl_core_domain_name, rapl_core_hw_unit);
>  }
>  
>  static void cleanup_rapl_pmus(struct rapl_pmus *rapl_pmus)
> @@ -619,6 +697,10 @@ static const struct attribute_group *rapl_attr_update[] = {
>  	NULL,
>  };
>  
> +static const struct attribute_group *rapl_core_attr_update[] = {
> +	&rapl_events_core_group,
> +};
> +
>  static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  {
>  	struct rapl_pmu *rapl_pmu;
> @@ -645,13 +727,22 @@ static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
>  	return -ENOMEM;
>  }
>  
> -static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope)
> +static int __init init_rapl_pmus(struct rapl_pmus **rapl_pmus_ptr, int rapl_pmu_scope,
> +				 const struct attribute_group **rapl_attr_groups,
> +				 const struct attribute_group **rapl_attr_update)
>  {
>  	int nr_rapl_pmu = topology_max_packages();
>  	struct rapl_pmus *rapl_pmus;
>  
> +	/*
> +	 * rapl_pmu_scope must be either PKG, DIE or CORE
> +	 */
>  	if (rapl_pmu_scope == PERF_PMU_SCOPE_DIE)
>  		nr_rapl_pmu	*= topology_max_dies_per_package();
> +	else if (rapl_pmu_scope == PERF_PMU_SCOPE_CORE)
> +		nr_rapl_pmu	*= topology_num_cores_per_package();
> +	else if (rapl_pmu_scope != PERF_PMU_SCOPE_PKG)
> +		return -EINVAL;
>  
>  	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
>  	if (!rapl_pmus)
> @@ -740,8 +831,10 @@ static struct rapl_model model_spr = {
>  
>  static struct rapl_model model_amd_hygon = {
>  	.pkg_events	= BIT(PERF_RAPL_PKG),
> +	.core_events	= BIT(PERF_RAPL_CORE),
>  	.msr_power_unit = MSR_AMD_RAPL_POWER_UNIT,
>  	.rapl_pkg_msrs	= amd_rapl_pkg_msrs,
> +	.rapl_core_msrs	= amd_rapl_core_msrs,
>  };
>  
>  static const struct x86_cpu_id rapl_model_match[] __initconst = {
> @@ -813,7 +906,8 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		return ret;
>  
> -	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope);
> +	ret = init_rapl_pmus(&rapl_pmus_pkg, rapl_pkg_pmu_scope, rapl_attr_groups,
> +			     rapl_attr_update);
>  	if (ret)
>  		return ret;
>  
> @@ -825,6 +919,27 @@ static int __init rapl_pmu_init(void)
>  	if (ret)
>  		goto out;
>  
> +	if (rapl_model->core_events) {
> +		ret = init_rapl_pmus(&rapl_pmus_core, PERF_PMU_SCOPE_CORE,
> +				     rapl_core_attr_groups,
> +				     rapl_core_attr_update);
> +		if (ret) {
> +			pr_warn("power-core PMU initialization failed (%d)\n", ret);
> +			goto core_init_failed;
> +		}
> +
> +		rapl_pmus_core->cntr_mask = perf_msr_probe(rapl_model->rapl_core_msrs,
> +						     PERF_RAPL_CORE_EVENTS_MAX, false,
> +						     (void *) &rapl_model->core_events);
> +
> +		ret = perf_pmu_register(&rapl_pmus_core->pmu, "power_core", -1);
> +		if (ret) {
> +			pr_warn("power-core PMU registration failed (%d)\n", ret);
> +			cleanup_rapl_pmus(rapl_pmus_core);
> +		}
> +	}
> +
> +core_init_failed:
>  	rapl_advertise();
>  	return 0;
>  
> @@ -837,6 +952,10 @@ module_init(rapl_pmu_init);
>  
>  static void __exit intel_rapl_exit(void)
>  {
> +	if (rapl_pmus_core) {
> +		perf_pmu_unregister(&rapl_pmus_core->pmu);
> +		cleanup_rapl_pmus(rapl_pmus_core);
> +	}
>  	perf_pmu_unregister(&rapl_pmus_pkg->pmu);
>  	cleanup_rapl_pmus(rapl_pmus_pkg);
>  }
> -- 
> 2.34.1
> 
