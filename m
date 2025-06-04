Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07B628DD0;
	Wed,  4 Jun 2025 16:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053317; cv=none; b=icvNMIT4yHcnFkzfABoEbyw8JAJJ1z7kpBXmNPseVlifqNF6PiRDtTnVXTf8f/TVAhqa814+NyRB9Zfz/JB6nD5pbbpNNXbtTsX/HZ0fZIvsf2Uefd3somdvy/c3mBrVsRod7c9OchnXu4jvkuR1DeozyBF/zS2khcagykbPKho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053317; c=relaxed/simple;
	bh=ppswMUxkFPu2BpBWwr3iS8sQtvjltaCv3JhK3TXGmA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJTDDpSlju2ohF4+WUP7B/R2WbYBNC4EW9YswqD5WSYjA+dyMGyghMIs6oQnHheoskErSQndY5ITdjCrvRlngitYU8bogaP4kr/axbwox+BrHJHZxrD5kpfqetCuRJXmVNH1GUzYuxeVZCIC9aN6Ggs/qNSF1SlLqRKoHln9wzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DD8E01758;
	Wed,  4 Jun 2025 09:08:17 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5690C3F5A1;
	Wed,  4 Jun 2025 09:08:32 -0700 (PDT)
Date: Wed, 4 Jun 2025 17:08:23 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Baisheng Gao <baisheng.gao@unisoc.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"reviewer:PERFORMANCE EVENTS SUBSYSTEM" <kan.liang@linux.intel.com>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>,
	cixi.geng@linux.dev, hao_hao.wang@unisoc.com
Subject: Re: [PATCH] perf/core: Handling the race between exit_mmap and perf
 sample
Message-ID: <aEBvd8fIdjlTV53j@J2N7QTR9R3>
References: <20250424025429.10942-1-baisheng.gao@unisoc.com>
 <aEBSt2LN7YhxYX7N@J2N7QTR9R3>
 <20250604142437.GM38114@noisy.programming.kicks-ass.net>
 <aEBeRfScZKD-7h5u@J2N7QTR9R3>
 <20250604153219.GJ39944@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604153219.GJ39944@noisy.programming.kicks-ass.net>

On Wed, Jun 04, 2025 at 05:32:19PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 04, 2025 at 03:55:01PM +0100, Mark Rutland wrote:
> 
> > I think we might need something in the perf core for cpu-bound events, assuming
> > those can also potentially make samples.
> > 
> > From a quick scan of perf_event_sample_format:

> > 	PERF_SAMPLE_DATA_PAGE_SIZE	// partial; doesn't check addr < TASK_SIZE
> > 	PERF_SAMPLE_CODE_PAGE_SIZE	// partial; doesn't check addr < TASK_SIZE
> 
> But does use init_mm when !mm, perf_get_page_size().

Yeah; think there might be a distinct issue (at least on arm64) where
it's possible to probe the depth of the kernel page tables, but that
might only be a problem on arm64 due to the separate TTBR0/TTBR1 tables
for the low/high halves.

I'll go take another look; that needn't block the rest of this.

[...]

> > 	PERF_SAMPLE_WEIGHT_STRUCT	// ???
> Safe, driver bits again.

Thanks for digging through the rest of these!

> > ... I think all the dodgy cases use mm somehow, so maybe the perf core
> > should check for current->mm?
> 
> This then... I suppose.

That looks good to me!

Mark.

> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f34c99f8ce8f..49944e4ec3e7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7439,6 +7439,10 @@ perf_sample_ustack_size(u16 stack_size, u16 header_size,
>  	if (!regs)
>  		return 0;
>  
> +	/* No mm, no stack, no dump. */
> +	if (!current->mm)
> +		return 0;
> +
>  	/*
>  	 * Check if we fit in with the requested stack size into the:
>  	 * - TASK_SIZE
> @@ -8153,6 +8157,9 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
>  	if (!kernel && !user)
>  		return &__empty_callchain;
>  
> +	if (!current->mm)
> +		user = false;
> +
>  	callchain = get_perf_callchain(regs, 0, kernel, user,
>  				       max_stack, crosstask, true);
>  	return callchain ?: &__empty_callchain;
