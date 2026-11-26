Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671500;
	b=02RZEUZY7luGH6DdNHiWTnEpHnlaQLXrv879lsZNH6lg3KbutReF15zh98bUOZihrjXs
	 J9p6SKTHIWq+5z9nY7HBJE8QFwnYR+9UmB6ehZ2BpVjiNR/aDUCq5j3C9bHhypks+iXMZ
	 z1opKbBeced20uTEyQTKbmPIpoDcxOig0wpv3BhZrk8m29YDXzaEOYSfVD6A49xBHCtvV
	 uw3aydE3JucOaZiCCCly5JgJ8nTlc3qhU2glsRAW7xzrnyE1ffwyDNjx4aogKePi+JfJ/
	 4N/lExWkgHIKH5YOiNXPzxMpE97eFbmo0beG39k0HjsJwK8+1ID5hLBaMuD+SI3A3Pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671500;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3QUZQKBgoaQNaINr5d2OxlEp6T/zS6u/bJipBb0+Pes=;
	b=JXMvafUzjXMRgJujd6o3pmQW3OUjNsQ9zm4o3U4k6o64WUNg7AxrvhITU9g10iIpD368
	 h8wpCHVLNJV5KbbJqJkd9KytT9r54rehdR7AiXKs6UQ7ozy23LpIVF8HAIDiIVhJ92YBl
	 Tb9d2pw9DjoLWU4EljQ9VLPT0rwC4DLjU7cxybjtF+jonnmRUyprcCcmkjLYepcC4D6rX
	 sPNZs65cqoD2vrs3Y5U26aFAbEMaZIHpxCc+jHqGHlMEGIjfl5nGu/zIeXrJS3a525xoU
	 BruwjirSAa+mk79xl+UXf5SkLAzIgZ52uXec07w/B+QPIce81LIC8yFD45WzHGDds+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RA5KRNiL;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E33606A31C;
	Thu, 26 Nov 2026 05:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E33606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=RA5KRNiL
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 890482F;
	Wed, 25 Nov 2026 21:38:14 -0800 (PST)
Received: from [10.164.19.73] (unknown [10.164.19.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6BE23F632;
	Wed, 25 Nov 2026 21:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795671497; bh=B+wOo28D0A/2UkcbroHsz0Ov/Dn4UYLTq2dAXaoDx5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RA5KRNiL71Xu/W8CVhP0nzCcEuU8Ue0aIzY7hGbgrUB82KL0tcHljL/9dZQ7fbvBM
	 qjPcdmuM+olFcRh5Zhy83fJhKcRQrDyfaRoCJkEbAokuUwAjQtl6Fmk1v7O/0OPU+t
	 +B+MYY6v5IuVYPvfTxlLJbmWOisVEVopsJwSTLQI=
Message-ID: <57d719b3-c701-455b-b467-1f50dd07850e@arm.com>
Date: Thu, 26 Nov 2026 11:08:10 +0530
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/aux: Avoid reclaim for optional higher-order
 allocations
To: Leo Yan <leo.yan@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Yabin Cui <yabinc@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Tamas Petz <tamas.petz@arm.com>,
 Tamas Zsoldos <tamas.zsoldos@arm.com>,
 Michiel van Tol <michiel.vantol@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20261125-perf_aux_alloc_optimize_psi-v2-1-b2ac7ed12849@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/11/26 5:24 pm, Leo Yan wrote:
> PERF_AUX_GFP includes GFP_KERNEL, which contains __GFP_RECLAIM. On
> fragmented systems, costly AUX allocations can wake kswapd. When perf
> falls back to lower orders, the allocating task can stall in direct
> reclaim or compaction. Yabin Cui reported that the resulting memory

When perf falls back to lower orders, how can the allocating task stall
in direct reclaim? It stalls when it is performing the high order allocation.

So let us write this as:

"On fragmented systems, costly AUX allocations can wake kswapd/kcompactd,
 or worse, they can stall in direct reclaim/compaction."

Reviewed-by: Dev Jain <dev.jain@arm.com>

> pressure can trigger Android's lmkd to kill applications.
> 
> For PMUs that support scatter-gather, higher-order AUX allocations are
> optional. Clear __GFP_RECLAIM and set __GFP_NOMEMALLOC for these
> attempts. Perf can then use contiguous pages when available and fall
> back to smaller orders without reclaiming memory or drawing on emergency
> reserves for the larger allocation.
> 
> The comparison is based on Yabin's result from an Android Pixel, a
> production phone with 4 KiB pages, 12 GiB of RAM and 6 GiB of zram.
> 
>   v7.4-rc3-sim
>     Android baseline kernel with the v7.4-rc3 perf AUX and page
>     allocator paths, including commit 526d945ad9c0 ("Revert "perf/aux:
>     Allocate non-contiguous AUX pages by default"") and
>     commit 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and
>     compaction for costly __GFP_NORETRY allocations").
> 
>   rc3 + [1]-noretry
>     The same baseline with this patch's GFP flag changes applied only
>     to optional higher-order AUX allocations.
> 
> The test allocated 4 MiB AUX buffer per CPU while running Dev Jain's
> compact-bench [1] at 90%, 95% and 99% memory pressure. Both kernels
> completed ten runs at each level without an AUX buffer allocation
> failure. Across the 30 runs per kernel, system-wide memory stall time
> (PSI some) fell by 97.7%.
> 
>   Totals over 30 runs        v7.4-rc3-sim  rc3 + [1]-noretry
>   Memory PSI some (ms)           1,840.29              41.78
>   compact_stall                       522                  0
>   allocstall                          161                  0
>   compact_daemon_wake                  14                  0
>   sp_kswapd_wk                         21                  1
> 
> In a separate test with realistic Android memory fragmentation, lmkd
> killed an application during TRBE testing on the baseline kernel, and
> SPE allocations stalled in direct compaction and reclaim. Neither issue
> was observed with this patch applied. When memory was unfragmented,
> the patched kernel allocated AUX buffer chunks at order 9 (2 MiB).
> 
> [1] https://lore.kernel.org/all/d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com/
> 
> Reported-by: Yabin Cui <yabinc@google.com>
> Link: https://lore.kernel.org/lkml/CALJ9ZPO9XxF-kz5K67Jg8RtpiEmK7XFU3e+xDak6LyV_We7yBQ@mail.gmail.com/
> Suggested-by: Yabin Cui <yabinc@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
> Changes in v2:
> - Dropped __GFP_RETRY_MAYFAIL and kept __GFP_NORETRY, as no allocation
>   failures were observed in Android testing. (Dev/Yabin)
> - Updated the commit log based on Yabin's test results to reflect the
>   benefits on Android. (Yabin)
> - Link to v1: https://lore.kernel.org/r/20261109-perf_aux_alloc_optimize_psi-v1-1-d56ac4bf3ef5@arm.com
> ---
>  kernel/events/ring_buffer.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 95f4fbdfd2764de5b72d901d778c46302f525fad..317a0454be8b26d60a14a5790a15625868836257 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -619,7 +619,7 @@ long perf_output_copy_aux(struct perf_output_handle *aux_handle,
>  
>  #define PERF_AUX_GFP	(GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY)
>  
> -static struct page *rb_alloc_aux_page(int node, int order)
> +static struct page *rb_alloc_aux_page(int node, int order, bool no_sg)
>  {
>  	struct page *page;
>  
> @@ -627,7 +627,16 @@ static struct page *rb_alloc_aux_page(int node, int order)
>  		order = MAX_PAGE_ORDER;
>  
>  	do {
> -		page = alloc_pages_node(node, PERF_AUX_GFP, order);
> +		gfp_t gfp = PERF_AUX_GFP;
> +
> +		/*
> +		 * Don't reclaim or use emergency reserves for optional
> +		 * higher-order allocations.
> +		 */
> +		if (order && !no_sg)
> +			gfp = (gfp | __GFP_NOMEMALLOC) & ~__GFP_RECLAIM;
> +
> +		page = alloc_pages_node(node, gfp, order);
>  	} while (!page && order--);
>  
>  	if (page && order) {
> @@ -683,6 +692,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  		 pgoff_t pgoff, int nr_pages, long watermark, int flags)
>  {
>  	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
> +	bool no_sg = event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG;
>  	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
>  	int ret = -ENOMEM, max_order;
>  
> @@ -733,7 +743,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  		int last, order;
>  
>  		order = min(max_order, ilog2(nr_pages - rb->aux_nr_pages));
> -		page = rb_alloc_aux_page(node, order);
> +		page = rb_alloc_aux_page(node, order, no_sg);
>  		if (!page)
>  			goto out;
>  
> @@ -748,8 +758,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>  	 * buffering. In this case, the entire buffer has to be one contiguous
>  	 * chunk.
>  	 */
> -	if ((event->pmu->capabilities & PERF_PMU_CAP_AUX_NO_SG) &&
> -	    overwrite) {
> +	if (no_sg && overwrite) {
>  		struct page *page = virt_to_page(rb->aux_pages[0]);
>  
>  		if (page_private(page) != max_order)
> 
> ---
> base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
> change-id: 20261109-perf_aux_alloc_optimize_psi-c2f8ce2e9a0c
> 
> Best regards,

