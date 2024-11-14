Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DEC7DA93;
	Thu, 14 Nov 2024 15:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596526; cv=none; b=kcHim58z8vGPAVaz8xqzARnTMm4pdsUWyohVQEU8Q/NcsTXiYNDgyYwpb/xJhAytF9l6e+9SQBT5zXo+B+dVEywoIxESny1XeaAr4FNAl5W+WAokSy9al7vMMXzhFMf3Z6HaZeDvL2Hu+bPG6uJ/Bwi5eb9wgDR2r7XjmRqgJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596526; c=relaxed/simple;
	bh=BrpgHeZZUBGGE/4npmemVXo9LQmjuTH144fIxM1YZAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDRHqKARbtSOiKNFL/RuEMvAupacNTaRaQZHrrT2Uo4x4/NG5AGTo3OLprdqBFcijIu90/LDVE1u4scwYXYalLlNk+wGrI8aNhu6wpP5aHyTd4SLJqYKY9DnRREEaelBRgHSBe3HiCzR7y55pW8VytGtRWLOmf9i5vDxw9j8pIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=n2xkHdT1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n2xkHdT1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KVl4h5R6rnhw6YUf9IrDWsXYnzegGCj/KhuQEleNVkg=; b=n2xkHdT1HWMG3UPYX8L66GnioC
	9sZRphIee2ajkU+LPtbpX5CE9MIOoSsqtUh1uDWgEAwLlU+a0yJG/qf55YVfVYuz3ac1thP+B/8ww
	e8wtORX2Dyew/ckDq8nvfhXoayao12i1iinsE+R7gTy9ynsQwbCY+JmzkgWPG5BqQv7QqmD1Sx8Zb
	4nNqABqm9+73dAdbJVBmWYYNcKgnTg/BSSGuH477e5jkruwIIDfrGH/hLcbTCON2wvBYz0Pb0LKWK
	u1qA/SGgiq9rIOy8VIRRfSJ5KSQrGyps7gipayt101UsD7HxuN1Z0JkbjsP5ui2/VdmQyWrv2iBeQ
	Bd/6zqBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tBbM1-0000000033t-3CHr;
	Thu, 14 Nov 2024 15:01:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1FB58300446; Thu, 14 Nov 2024 16:01:53 +0100 (CET)
Date: Thu, 14 Nov 2024 16:01:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Deepak Surti <deepak.surti@arm.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.barnett@arm.com, ben.gainey@arm.com, ak@linux.intel.com,
	will@kernel.org, james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/4] perf: Allow periodic events to alternate between
 two sample periods
Message-ID: <20241114150152.GC39245@noisy.programming.kicks-ass.net>
References: <20241107160721.1401614-1-deepak.surti@arm.com>
 <20241107160721.1401614-2-deepak.surti@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107160721.1401614-2-deepak.surti@arm.com>

On Thu, Nov 07, 2024 at 04:07:18PM +0000, Deepak Surti wrote:
> From: Ben Gainey <ben.gainey@arm.com>
> 
> This change modifies perf_event_attr to add a second, alternative
> sample period field, and modifies the core perf overflow handling
> such that when specified an event will alternate between two sample
> periods.
> 
> Currently, perf does not provide a  mechanism for decoupling the period
> over which counters are counted from the period between samples. This is
> problematic for building a tool to measure per-function metrics derived
> from a sampled counter group. Ideally such a tool wants a very small
> sample window in order to correctly attribute the metrics to a given
> function, but prefers a larger sample period that provides representative
> coverage without excessive probe effect, triggering throttling, or
> generating excessive amounts of data.
> 
> By alternating between a long and short sample_period and subsequently
> discarding the long samples, tools may decouple the period between
> samples that the tool cares about from the window of time over which
> interesting counts are collected.

Do you have a link to a paper or something that explains this method?


> +	/*
> +	 * Indicates that the alternative_sample_period is used
> +	 */
> +	bool				using_alternative_sample_period;

I typically prefer variables names that are shorter.


> @@ -9822,6 +9825,26 @@ static int __perf_event_overflow(struct perf_event *event,
>  	    !bpf_overflow_handler(event, data, regs))
>  		return ret;
>  
> +	/*
> +	 * Swap the sample period to the alternative period
> +	 */
> +	if (event->attr.alternative_sample_period) {
> +		bool using_alt = hwc->using_alternative_sample_period;
> +		u64 sample_period = (using_alt ? event->attr.sample_period
> +					       : event->attr.alternative_sample_period);
> +
> +		hwc->sample_period = sample_period;
> +		hwc->using_alternative_sample_period = !using_alt;
> +
> +		if (local64_read(&hwc->period_left) > 0) {
> +			event->pmu->stop(event, PERF_EF_UPDATE);
> +
> +			local64_set(&hwc->period_left, 0);
> +
> +			event->pmu->start(event, PERF_EF_RELOAD);
> +		}

This is quite terrible :-(

Getting here means we just went through the effort of programming the
period and you'll pretty much always hit that 'period_left > 0' case.

Why do we need this case at all? If you don't do this, then the next
overflow will pick the period you just wrote to hwc->sample_period
(although you might want to audit all arch implementations).

Looking at it again, that truncation to 0 is just plain wrong -- always.
Why are you doing this?



