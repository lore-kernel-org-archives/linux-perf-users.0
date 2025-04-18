Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912E1DFFD;
	Fri, 18 Apr 2025 09:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744967008; cv=none; b=kJ9DSXrRD5DchCvkGQiemd+WMhsteMvqwahces1k+fKjC1RXZ2LcbVekO97vli/l/BKUKCCW870rwc46Vi3OF9l30A7fHjUOLg4ESjjAZ9UFnV5JMwvNW4GusnzoXxC+T3UVIDjpVTimFa+Fqqeh+2UZcCZPILiSa/Jcr7E61tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744967008; c=relaxed/simple;
	bh=AgJPAS9MsnLGt5FsKWWaLN2F2nwB4XC3KF9DCC0oN2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh3WQ51LNqhYDnW6I9F5CXmvyqfWNzjNLtPnMnnB0zPTlrOj8xEp1VYeOXGP2oOICUN+RqfH0NWB69zL00ILXEYlYOMlvQD/KIWVSF06tndrJaY5J5mkQKJTYUfqryig307M48FprTvGJOIvX1w2aogMC6+9dJgqaKgVTy94qCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TVzVGcMa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TVzVGcMa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=L1yZdH4nNTnw8blnrBkBJgEu/+WnJUkKaga0ecRrWYI=; b=TVzVGcMaz2HvQJiROFC2RZQ7mo
	09QZ7uiHLMKgahwjIc/WJwW2yV/mTc1uUkjqBYrMpEGkrGLTTKu/tU8+m9ID0ljImEN+PNszPmopf
	IvgZFTLx86LURSHJSijjY7/ADgTPe3IvlVj45gN3fNQgDKQJl56DIwjozVXbITvlECBni18MTbs9w
	0Dz0XJ1AC3fsuL/3Hy5V6AZp8DABn81bSOd/CKtmwVLCxfdNp2MBX0TJEA2Q70WCpl5+X4WaP5edS
	udEDRaDvFxVl7bVUiWMylcpvC/imiCxohs4slO0z5mFfV6gItf2D3sdNskSfKoDNb0L+1C9caffCj
	iJgFIYTg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5hck-0000000CaPi-0AbI;
	Fri, 18 Apr 2025 09:03:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 45C15300619; Fri, 18 Apr 2025 11:03:02 +0200 (CEST)
Date: Fri, 18 Apr 2025 11:03:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wong <wangqing7171@gmail.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf/core: Fix broken throttling when
 max_samples_per_tick=1
Message-ID: <20250418090302.GO38216@noisy.programming.kicks-ass.net>
References: <20250405141635.243786-1-wangqing7171@gmail.com>
 <20250405141635.243786-3-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250405141635.243786-3-wangqing7171@gmail.com>

On Sat, Apr 05, 2025 at 10:16:35PM +0800, Qing Wong wrote:
> From: Qing Wang <wangqing7171@gmail.com>
> 
> According to the throttling mechanism, the pmu interrupts number can not
> exceed the max_samples_per_tick in one tick. But this mechanism is
> ineffective when max_samples_per_tick=1, because the throttling check is
> skipped during the first interrupt and only performed when the second
> interrupt arrives.
> 
> Perhaps this bug may cause little influence in one tick, but if in a
> larger time scale, the problem can not be underestimated.
> 
> When max_samples_per_tick = 1:
> Allowed-interrupts-per-second max-samples-per-second  default-HZ  ARCH
> 200                           100                     100         X86
> 500                           250                     250         ARM64
> ...
> Obviously, the pmu interrupt number far exceed the user's expect.
> 
> Fixes: e050e3f0a71b ("perf: Fix broken interrupt rate throttling")
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  kernel/events/core.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 29cdb240e104..4ac2ac988ddc 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -10047,16 +10047,15 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>  	if (seq != hwc->interrupts_seq) {
>  		hwc->interrupts_seq = seq;
>  		hwc->interrupts = 1;
> -	} else {
> +	} else
>  		hwc->interrupts++;
> -		if (unlikely(throttle
> -			     && hwc->interrupts >= max_samples_per_tick)) {
> -			__this_cpu_inc(perf_throttled_count);
> -			tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
> -			hwc->interrupts = MAX_INTERRUPTS;
> -			perf_log_throttle(event, 0);
> -			ret = 1;
> -		}
> +
> +	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
> +		__this_cpu_inc(perf_throttled_count);
> +		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
> +		hwc->interrupts = MAX_INTERRUPTS;
> +		perf_log_throttle(event, 0);
> +		ret = 1;
>  	}

Fair enough I suppose. I'll make this apply without that revert -- it
seems pointless to have that in between.
