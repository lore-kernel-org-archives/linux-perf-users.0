Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739F340A63;
	Thu,  6 Nov 2025 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440746; cv=none; b=NcORz0R8hc6iNaAcRndWNf8E4GmAOrj2eY6ZsOxOgsMCyfonir3hOv7Eba2/A5WI8jbqQwjYV7Qp0iglNu+H/e++dmhLtg7Q3EEa/Eg7EyjGd6qqydAPq51Suz14GfM4u6c3JGyLEenq+HT8EUNnZndH39mMcaP8Tq6KE0T9SHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440746; c=relaxed/simple;
	bh=tcaOpyDqFjvSZ69nrl+0ZuvV86G30hxmGpWz26Csv0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VR61WkqYXTuCJdquUvO6S3r61ZUlfpra0uRgXQHNPqzxpDu4TqNjtk1iwNReeL+YpNnTKvFW6D8LdIvDxf9XYDARJYp9M+Vda8nYvGusxEBZKpenOqS4ejC+MCb68QRyxvUXNeWqwI8lCisQk3cij3zwJTNTWFZEO3sg19qG4tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ArNThtl3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ArNThtl3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NyoA7SWkK0lJW4LEr18FkB2b/+c43xpuxaSs8twz+UQ=; b=ArNThtl3xl9f7G1rXQ21QTRqOG
	W8j5LAHWxwPvlS9gN8Z2aJ4t+nc3F9JqTF2j45Uu/RD1PZgi8y5GbtqwuljgaevcuL5uz2nijrSaT
	3KE46PBAmaOnaDrgzDFPuMtPCJdplkdUAp3Pz745duZoTadM0gDxal6CVhaAcsT0D/KFEP4e9cdND
	3F0FLMlUu6zxl3kCeFrcUtaNMfnTdks5efVTZdDJnCdhNEzjbPku1RVGMB1i824p+rbgy4cfmD8Yp
	Me6ZQFTmNqkUjuWFMcR7cFgaUZz4rrz8YGtLZN/Gw9GiQJ2KkLdjCTsgTaB2nQjrf7mBM3Udkyf2B
	KZu1oZeQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vH0Tp-00000004Z0F-14zd;
	Thu, 06 Nov 2025 13:56:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AB13A300230; Thu, 06 Nov 2025 15:52:17 +0100 (CET)
Date: Thu, 6 Nov 2025 15:52:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v9 10/12] perf/x86/intel: Update dyn_constranit base on
 PEBS event precise level
Message-ID: <20251106145217.GA4067720@noisy.programming.kicks-ass.net>
References: <20251029102136.61364-1-dapeng1.mi@linux.intel.com>
 <20251029102136.61364-11-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029102136.61364-11-dapeng1.mi@linux.intel.com>

On Wed, Oct 29, 2025 at 06:21:34PM +0800, Dapeng Mi wrote:
> arch-PEBS provides CPUIDs to enumerate which counters support PEBS
> sampling and precise distribution PEBS sampling. Thus PEBS constraints
> should be dynamically configured base on these counter and precise
> distribution bitmap instead of defining them statically.
> 
> Update event dyn_constraint base on PEBS event precise level.

What happened to this:

  https://lore.kernel.org/all/e0b25b3e-aec0-4c43-9ab2-907186b56c71@linux.intel.com/


> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 11 +++++++++++
>  arch/x86/events/intel/ds.c   |  1 +
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 6e04d73dfae5..40ccfd80d554 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4252,6 +4252,8 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  	}
>  
>  	if (event->attr.precise_ip) {
> +		struct arch_pebs_cap pebs_cap = hybrid(event->pmu, arch_pebs_cap);
> +
>  		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
>  			return -EINVAL;
>  
> @@ -4265,6 +4267,15 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		}
>  		if (x86_pmu.pebs_aliases)
>  			x86_pmu.pebs_aliases(event);
> +
> +		if (x86_pmu.arch_pebs) {
> +			u64 cntr_mask = hybrid(event->pmu, intel_ctrl) &
> +						~GLOBAL_CTRL_EN_PERF_METRICS;
> +			u64 pebs_mask = event->attr.precise_ip >= 3 ?
> +						pebs_cap.pdists : pebs_cap.counters;
> +			if (cntr_mask != pebs_mask)
> +				event->hw.dyn_constraint &= pebs_mask;
> +		}
>  	}
>  
>  	if (needs_branch_stack(event)) {
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 5c26a5235f94..1179980f795b 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -3005,6 +3005,7 @@ static void __init intel_arch_pebs_init(void)
>  	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
>  	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
>  	x86_pmu.pebs_capable = ~0ULL;
> +	x86_pmu.flags |= PMU_FL_PEBS_ALL;
>  
>  	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
>  	x86_pmu.pebs_disable = __intel_pmu_pebs_disable;
> -- 
> 2.34.1
> 
