Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC55B308F3E;
	Mon,  4 May 2026 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883567; cv=none; b=sv0M4ETxJ17xGkyEur7uKZhzpsEFy4aKxXG+e+dUclBZGaBypTgufFU9z6cFo8dG6i5Ltgw5EdEehNC8YFh+yjSnZ0CcMi+KI5s4ilkxH/YnfYnbr33qmK6DH0TWJKZV5/THSESiVPSo0aAIoCGr0gD3awIpbO/3aAm1Wxd5tZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883567; c=relaxed/simple;
	bh=jUpKBKbDAjJfYqlWM6jPVIqw3bJI9hVpxAGx3BPjrME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7UtjRpbFQonSv0Zpjx3qXlf64r80XwsrQGzvtaSVeeymyIpjCgZKsgQpuP1zwfQusrohtTCR9+biCvqjq7VJaqVtlzcoVlHyWRjUlUTp2G31FEpSs9o9sNw4fAUVgY4pn2f6djfEa+gI4UV6+rkYUcEjOMjvgOkNvkNjRk/gTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H5PH/Bz1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H5PH/Bz1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hfDkmo30U2+i90gKGLs3gEKZ0jQpgUb+IDc2ox9NSrA=; b=H5PH/Bz1uxLaimZi40dCVaG2aL
	wu3rdwoxbHQaAM3LVYGdy4YxeWFyTZaF4eC2M6B79ScKKemru7nWTbzHmW4jIniGt+QIjOKE3Ccwc
	Z6PgUNr9NkJtU+Fa0i2VyB/QgMjMpBkU7wThi/4ySspvX1qWeLqzaWv47/GjwXGPLq2KVyEDhE46n
	tlT8IvQ7rRxCC4l8f+EzsqMEpV0MI3BGWu0606QrtCkP3RFqH3XTw+Hxjh0hOL2z39/HorU10ffBZ
	pe0Z8RwFfG9fs3+1lp/1kdex9g74kmThJTS6uWkSkDHt6wIg3+HZOfiZ3bz+9UsmswkLkmE5hHI0d
	rz7VedYg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wJoj6-0000000BA5w-46Pz;
	Mon, 04 May 2026 08:32:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1A099300390; Mon, 04 May 2026 10:32:28 +0200 (CEST)
Date: Mon, 4 May 2026 10:32:28 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] perf/x86: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20260504083228.GQ3126523@noisy.programming.kicks-ass.net>
References: <afJcDg1I5ZU5ZkXf@kspp>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afJcDg1I5ZU5ZkXf@kspp>

On Wed, Apr 29, 2026 at 01:29:18PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the TRAILING_OVERLAP() helper to fix the following warnings:
> 
> 14 arch/x86/events/intel/../perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 6 arch/x86/events/amd/../perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 3 arch/x86/events/perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 arch/x86/xen/../events/perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 arch/x86/events/zhaoxin/../perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 1 ./arch/x86/include/generated/../../events/perf_event.h:326:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> This helper creates a union between a flexible-array member (FAM)
> and a set of members that would otherwise follow it. This overlays
> the trailing members onto the FAM while preserving the original
> memory layout.
> 
> Lastly, the static_assert() ensures the alignment between the FAM
> and struct perf_branch_entry lbr_entries[MAX_LBR_ENTRIES]; is not
> inadvertently changed, and it's intentionally placed inmediately
> after the related structure (that is, no blank line in between).
> 
> It's also worth mentioning that the entire Intel LBR bits block
> is moved just to avoid splitting it.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  arch/x86/events/perf_event.h | 41 ++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..9641b888cbee 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -318,24 +318,6 @@ struct cpu_hw_events {
>  	/* Cached CFG_C values */
>  	u64			cfg_c_val[X86_PMC_IDX_MAX];
>  
> -	/*
> -	 * Intel LBR bits
> -	 */
> -	int				lbr_users;
> -	int				lbr_pebs_users;
> -	struct perf_branch_stack	lbr_stack;
> -	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
> -	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
> -	union {
> -		struct er_account		*lbr_sel;
> -		struct er_account		*lbr_ctl;
> -	};
> -	u64				br_sel;
> -	void				*last_task_ctx;
> -	int				last_log_id;
> -	int				lbr_select;
> -	void				*lbr_xsave;
> -
>  	/*
>  	 * Intel host/guest exclude bits
>  	 */
> @@ -384,7 +366,30 @@ struct cpu_hw_events {
>  	void				*kfree_on_online[X86_PERF_KFREE_MAX];
>  
>  	struct pmu			*pmu;
> +
> +	/*
> +	 * Intel LBR bits
> +	 */
> +	int				lbr_users;
> +	int				lbr_pebs_users;
> +	union {
> +		struct er_account		*lbr_sel;
> +		struct er_account		*lbr_ctl;
> +	};
> +	u64				br_sel;
> +	void				*last_task_ctx;
> +	int				last_log_id;
> +	int				lbr_select;
> +	void				*lbr_xsave;
> +
> +	/* Must be last as it ends in a flexible-array member. */
> +	TRAILING_OVERLAP(struct perf_branch_stack, lbr_stack, entries,
> +		struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
> +		u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
> +	);
>  };
> +static_assert(offsetof(struct cpu_hw_events, lbr_stack.entries) ==
> +	      offsetof(struct cpu_hw_events, lbr_entries));

This is horrible. That code was perfectly fine, and now you've made it
an unholy trainwreck just because compiler is stupid :-(

Also, we seem to be going around in circles, what was wrong with:

  https://lore.kernel.org/all/20240806113254.GG12673@noisy.programming.kicks-ass.net/
