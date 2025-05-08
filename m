Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F54B1E78;
	Thu,  8 May 2025 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746701208; cv=none; b=liTEhE1DcWcEFk4HsqjqzbRAti1+p6gGsoU+Ecu7yU9Hkltyutju4ThA9BX08z9COY+DaYi14AKb8Eklb9qAbLXpdRXn2u+1P5dvit3DGC6c6Gz7Y1RjRs8t4/Of1CFRwgAl8ZnsLpudXS81uxE/StNLZlr+bCrt8604RFGwb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746701208; c=relaxed/simple;
	bh=PtvCpPTeWkdP+4SYjcODInMZUU/8Uc2VA5yIqq6wRNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VjXpb7cF/2YL+TZsKEl7MRXQhDQCOxQMFgEOuGRDeJzmHjEIDmq4C5R2qiPwz/yQcaIaOpfPhpsRLFCvFUlq0bmYehl1w42V8eZvhUGOwDM42MGl1wfeMj2eGMbS2F/sypKeZRBksQ0IFbjRE4lqDv+4EhDU+IfllRtNnIIcpEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43376106F;
	Thu,  8 May 2025 03:46:35 -0700 (PDT)
Received: from [10.163.54.182] (unknown [10.163.54.182])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 09C4E3F5A1;
	Thu,  8 May 2025 03:46:37 -0700 (PDT)
Message-ID: <618a8e5d-e5e9-4565-beb8-96194fe0f9c9@arm.com>
Date: Thu, 8 May 2025 16:16:34 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] perf: Allocate non-contiguous AUX pages by default
To: Yabin Cui <yabinc@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20250507181346.1892103-1-yabinc@google.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250507181346.1892103-1-yabinc@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 23:43, Yabin Cui wrote:
> perf always allocates contiguous AUX pages based on aux_watermark.
> However, this contiguous allocation doesn't benefit all PMUs. For
> instance, ARM SPE and TRBE operate with virtual pages, and Coresight
> ETR allocates a separate buffer. For these PMUs, allocating contiguous
> AUX pages unnecessarily exacerbates memory fragmentation. This
> fragmentation can prevent their use on long-running devices.
> 
> This patch modifies the perf driver to be memory-friendly by default,
> by allocating non-contiguous AUX pages. For PMUs requiring contiguous
> pages (Intel BTS and some Intel PT), the existing
> PERF_PMU_CAP_AUX_NO_SG capability can be used. For PMUs that don't
> require but can benefit from contiguous pages (some Intel PT), a new
> capability, PERF_PMU_CAP_AUX_PREFER_LARGE, is added to maintain their
> existing behavior.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> Changes since v3:
> Add comments and a local variable to explain max_order value
> changes in rb_alloc_aux().
> 
> Changes since v2:
> Let NO_SG imply PREFER_LARGE. So PMUs don't need to set both flags.
> Then the only place needing PREFER_LARGE is intel/pt.c.
> 
> Changes since v1:
> In v1, default is preferring contiguous pages, and add a flag to
> allocate non-contiguous pages. In v2, default is allocating
> non-contiguous pages, and add a flag to prefer contiguous pages.
> 
> v1 patchset:
> perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
> cs_etm
> 
>  arch/x86/events/intel/pt.c  |  2 ++
>  include/linux/perf_event.h  |  1 +
>  kernel/events/ring_buffer.c | 33 ++++++++++++++++++++++++---------
>  3 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index fa37565f6418..25ead919fc48 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -1863,6 +1863,8 @@ static __init int pt_init(void)
>  
>  	if (!intel_pt_validate_hw_cap(PT_CAP_topa_multiple_entries))
>  		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_NO_SG;
> +	else
> +		pt_pmu.pmu.capabilities = PERF_PMU_CAP_AUX_PREFER_LARGE;
>  
>  	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
>  					   PERF_PMU_CAP_ITRACE |
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0069ba6866a4..56d77348c511 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -301,6 +301,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>  #define PERF_PMU_CAP_AUX_PAUSE			0x0200
> +#define PERF_PMU_CAP_AUX_PREFER_LARGE		0x0400
>  
>  /**
>   * pmu::scope
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 5130b119d0ae..69c90ea1b79a 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -679,7 +679,19 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  {
>  	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
>  	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
> -	int ret = -ENOMEM, max_order;
> +	/*
> +	 * True if the PMU needs a contiguous AUX buffer (CAP_AUX_NO_SG) or
> +	 * prefers large contiguous pages (CAP_AUX_PREFER_LARGE).
> +	 */
> +	bool use_contiguous_pages = event->pmu->capabilities & (
> +		PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_AUX_PREFER_LARGE);
> +	/*
> +	 * Initialize max_order to 0 for page allocation. This allocates single
> +	 * pages to minimize memory fragmentation. This is overriden if

Small nit typo	-- s/overriden/overridden		    ^^^^
    
> +	 * use_contiguous_pages is true.
> +	 */
> +	int max_order = 0;
> +	int ret = -ENOMEM;
>  
>  	if (!has_aux(event))
>  		return -EOPNOTSUPP;
> @@ -689,8 +701,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  
>  	if (!overwrite) {
>  		/*
> -		 * Watermark defaults to half the buffer, and so does the
> -		 * max_order, to aid PMU drivers in double buffering.
> +		 * Watermark defaults to half the buffer, to aid PMU drivers
> +		 * in double buffering.
>  		 */
>  		if (!watermark)
>  			watermark = min_t(unsigned long,
> @@ -698,16 +710,19 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
>  
>  		/*
> -		 * Use aux_watermark as the basis for chunking to
> -		 * help PMU drivers honor the watermark.
> +		 * If using contiguous pages, use aux_watermark as the basis
> +		 * for chunking to help PMU drivers honor the watermark.
>  		 */
> -		max_order = get_order(watermark);
> +		if (use_contiguous_pages)
> +			max_order = get_order(watermark);
>  	} else {
>  		/*
> -		 * We need to start with the max_order that fits in nr_pages,
> -		 * not the other way around, hence ilog2() and not get_order.
> +		 * If using contiguous pages, we need to start with the
> +		 * max_order that fits in nr_pages, not the other way around,
> +		 * hence ilog2() and not get_order.
>  		 */
> -		max_order = ilog2(nr_pages);
> +		if (use_contiguous_pages)
> +			max_order = ilog2(nr_pages);
>  		watermark = 0;
>  	}
>  

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
