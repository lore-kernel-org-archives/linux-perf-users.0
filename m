Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1819E7CC;
	Fri, 14 Jun 2024 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718377324; cv=none; b=Yji2nVV/WvJfJSsqO6oYHlEc939HO7BS+G9/ameJ7MfmUAwHpIqhntYVzUNM+4CUO6bs/v6pBwsuB1Cx+pWr/sR7YbtQYv9alQBg2PtJcKpVktalU8Xh3Qdf06almce1Q1hE0podUxjRlG1ZXirACNZHO+nDM/zJSgs6esns+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718377324; c=relaxed/simple;
	bh=qkWL93xJiBFm741aewrWA5fb6uRq1PuR7yWIPq9P0T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuWo4J0VA2JpOmmf5KCmVp1+Qb9iQKyzzU3m20ZXGahkkgQ5L6cHTZDx/zzIQ9zG32h63Ls4poAjmLEfuQHMMc/avA4Gj7oPqr8kzza8Doyn5TKnb1JbTCAIoxPaY5g7TWk5NuXR32566u7bBdPP8O9hByF29Yi43pzwHlsTY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BD06176B;
	Fri, 14 Jun 2024 08:02:27 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C06023F8A4;
	Fri, 14 Jun 2024 08:02:00 -0700 (PDT)
Date: Fri, 14 Jun 2024 16:01:55 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V18 3/9] drivers: perf: arm_pmu: Add infrastructure for
 branch stack sampling
Message-ID: <ZmxbYxE5PBl4CHzE@J2N7QTR9R3.cambridge.arm.com>
References: <20240613061731.3109448-1-anshuman.khandual@arm.com>
 <20240613061731.3109448-4-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613061731.3109448-4-anshuman.khandual@arm.com>

On Thu, Jun 13, 2024 at 11:47:25AM +0530, Anshuman Khandual wrote:
> @@ -289,6 +289,23 @@ static void armpmu_start(struct perf_event *event, int flags)
>  {
>  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
>  	struct hw_perf_event *hwc = &event->hw;
> +	struct pmu_hw_events *cpuc = this_cpu_ptr(armpmu->hw_events);
> +	int idx;
> +
> +	/*
> +	 * Merge all branch filter requests from different perf
> +	 * events being added into this PMU. This includes both
> +	 * privilege and branch type filters.
> +	 */
> +	if (armpmu->has_branch_stack) {
> +		cpuc->branch_sample_type = 0;
> +		for (idx = 0; idx < ARMPMU_MAX_HWEVENTS; idx++) {
> +			struct perf_event *event_idx = cpuc->events[idx];
> +
> +			if (event_idx && has_branch_stack(event_idx))
> +				cpuc->branch_sample_type |= event_idx->attr.branch_sample_type;
> +		}
> +	}

When we spoke about this, I meant that we should do this under armpmu::start(),
or a callee or caller thereof once we know all the events are configured, just
before we actually enable the PMU.

For example, this could live in armv8pmu_branch_enable(), which'd allow
all the actual logic to be added in the BRBE enablement patch.

Doing this in armpmu_start() doesn't work as well because it won't handle
events being removed.

[...]

> diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
> index b3b34f6670cf..9eda16dd684e 100644
> --- a/include/linux/perf/arm_pmu.h
> +++ b/include/linux/perf/arm_pmu.h
> @@ -46,6 +46,18 @@ static_assert((PERF_EVENT_FLAG_ARCH & ARMPMU_EVT_63BIT) == ARMPMU_EVT_63BIT);
>  	},								\
>  }
>  
> +/*
> + * Maximum branch record entries which could be processed
> + * for core perf branch stack sampling support, regardless
> + * of the hardware support available on a given ARM PMU.
> + */
> +#define MAX_BRANCH_RECORDS 64
> +
> +struct branch_records {
> +	struct perf_branch_stack	branch_stack;
> +	struct perf_branch_entry	branch_entries[MAX_BRANCH_RECORDS];
> +};
> +
>  /* The events for a given PMU register set. */
>  struct pmu_hw_events {
>  	/*
> @@ -66,6 +78,17 @@ struct pmu_hw_events {
>  	struct arm_pmu		*percpu_pmu;
>  
>  	int irq;
> +
> +	struct branch_records	*branches;
> +
> +	/* Active context for task events */
> +	void			*branch_context;

Using 'void *' here makes this harder to reason about and hides type
safety issues.

Give this a real type. IIUC it should be 'perf_event_context *'.

> +
> +	/* Active events requesting branch records */
> +	unsigned int		branch_users;
> +
> +	/* Active branch sample type filters */
> +	unsigned long		branch_sample_type;
>  };
>  
>  enum armpmu_attr_groups {
> @@ -96,8 +119,15 @@ struct arm_pmu {
>  	void		(*stop)(struct arm_pmu *);
>  	void		(*reset)(void *);
>  	int		(*map_event)(struct perf_event *event);
> +	void		(*sched_task)(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
> +	bool		(*branch_stack_init)(struct perf_event *event);
> +	void		(*branch_stack_add)(struct perf_event *event, struct pmu_hw_events *cpuc);
> +	void		(*branch_stack_del)(struct perf_event *event, struct pmu_hw_events *cpuc);
> +	void		(*branch_stack_reset)(void);

The reset callback isn't used in this series; s

Subsequent patches call armv8pmu_branch_stack_reset() directly from
PMUv3 and the BRBE driver, and arm_pmu::branch_stack_reset() is never
used, so we can delete it.

Mark.
