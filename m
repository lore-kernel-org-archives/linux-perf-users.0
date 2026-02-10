Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6933627A904;
	Tue, 10 Feb 2026 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770737821; cv=none; b=tzC12R3RvaX1Z5wCtgqb/qLHAYMDCJ+wDjkzgwfh+EOOrs6Bf5yykWOXJK0scdOE5+6PpiWTXe837BMGR9kNEzmcP0Z7aa3kpQt5sow151HCiI9NV3gXvpvE+KURkU/5Ph04+vadW8GzwOhlZxr1VsEsWDLRVW8Au6sKonrkQXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770737821; c=relaxed/simple;
	bh=WGWl4mpF1OqHunY9pBI18c2HSFhBWVjdXzjWTJzxXsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9f3WfIWkQQoIrnQCgkZjdZ0jpQ3zO9/P9ANmRUfGFZ+Fvl5NL0KzOTjWTr8HTchCjL227NRb1OihIwiquqv75COJvtvjIlwqT0py5UA6PdwlwSXhHYPl2zbgna7jyqSLs8GLslNx4n3Wfiqn0rRDcSshare+9TNAWbAFzgkUVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L/JBr+td; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L/JBr+td"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=t3Xas7MkQkNtwhO+VbM27kxtgUNOO+7GjHQ7BacLALs=; b=L/JBr+tdrh/621fD52YBg+FRTN
	xx0FU8XkBmwV9oaRxmTBpNbAi8MqxE2qGbqbU9bbaAUSA3s4bINcviG1gCCP5WpFperG30y6GCoRY
	NbDGG8t2T8nioG1Vz+5K5qtntvofRaQIZAgmJT+6nfvJGOOVqhbfjHQXOH4Z7SX/btJH1I6gLuUCL
	bzbn9BYpMB4LviQN4WVb0iAtLmd7XLyLehcv1TMTFxh8XMtG1rWBSaZFiRqhxqj7tQ4lU6QFdVZXq
	T3AomHUIhvtBiXNVKDvE8SDdAycKfMooVA3yc488cwTxyUOPs1SWptHA/YuW//zdKdC0ZyOGmPGsF
	6c3vvBJw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppnB-0000000BHEV-06Db;
	Tue, 10 Feb 2026 15:36:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CF2A30070F; Tue, 10 Feb 2026 16:36:43 +0100 (CET)
Date: Tue, 10 Feb 2026 16:36:43 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v6 01/22] perf/x86/intel: Restrict PEBS_ENABLE writes to
 PEBS-capable counters
Message-ID: <20260210153643.GA3931095@noisy.programming.kicks-ass.net>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209072047.2180332-2-dapeng1.mi@linux.intel.com>

On Mon, Feb 09, 2026 at 03:20:26PM +0800, Dapeng Mi wrote:
> Before the introduction of extended PEBS, PEBS supported only
> general-purpose (GP) counters. In a virtual machine (VM) environment,
> the PEBS_BASELINE bit in PERF_CAPABILITIES may not be set, but the PEBS
> format could be indicated as 4 or higher. In such cases, PEBS events
> might be scheduled to fixed counters, and writing the corresponding bits
> into the PEBS_ENABLE MSR could cause a #GP fault.
> 
> To prevent writing unsupported bits into the PEBS_ENABLE MSR, ensure
> cpuc->pebs_enabled aligns with x86_pmu.pebs_capable and restrict the
> writes to only PEBS-capable counter bits.

This seems very wrong. Should we not avoid getting those bits set in the
first place?

That is; the fact that we set those cpuc->pebs_enabled bits indicates
that we 'successfully' scheduled PEBS counters. And then we silently
disable PEBS when programming the hardware.

Or am I reading this wrong?

> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
> 
> V6: new patch.
> 
>  arch/x86/events/intel/core.c |  6 ++++--
>  arch/x86/events/intel/ds.c   | 11 +++++++----
>  2 files changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index f3ae1f8ee3cd..546ebc7e1624 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3554,8 +3554,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>  		 * cpuc->enabled has been forced to 0 in PMI.
>  		 * Update the MSR if pebs_enabled is changed.
>  		 */
> -		if (pebs_enabled != cpuc->pebs_enabled)
> -			wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> +		if (pebs_enabled != cpuc->pebs_enabled) {
> +			wrmsrq(MSR_IA32_PEBS_ENABLE,
> +			       cpuc->pebs_enabled & x86_pmu.pebs_capable);
> +		}
>  
>  		/*
>  		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 5027afc97b65..57805c6ba0c3 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1963,6 +1963,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	struct hw_perf_event *hwc = &event->hw;
> +	u64 pebs_enabled;
>  
>  	__intel_pmu_pebs_disable(event);
>  
> @@ -1974,16 +1975,18 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>  
>  	intel_pmu_pebs_via_pt_disable(event);
>  
> -	if (cpuc->enabled)
> -		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> +	pebs_enabled = cpuc->pebs_enabled & x86_pmu.pebs_capable;
> +	if (pebs_enabled)
> +		wrmsrq(MSR_IA32_PEBS_ENABLE, pebs_enabled);
>  }
>  
>  void intel_pmu_pebs_enable_all(void)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
> +	u64 pebs_enabled = cpuc->pebs_enabled & x86_pmu.pebs_capable;
>  
> -	if (cpuc->pebs_enabled)
> -		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
> +	if (pebs_enabled)
> +		wrmsrq(MSR_IA32_PEBS_ENABLE, pebs_enabled);
>  }
>  
>  void intel_pmu_pebs_disable_all(void)
> -- 
> 2.34.1
> 
