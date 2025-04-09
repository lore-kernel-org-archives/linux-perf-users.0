Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ABD25E456;
	Wed,  9 Apr 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744198733; cv=none; b=HpprX+q5NO5WXorc+VgKpSpBqpzRQjYccHxoNo58BLKwAUaLrMgMJYdZanDmgus9wM8x0GYM7UXfr0RCL9VbweiwFZZ3WRSRpkwD4XSQekzucMyT/E1eIiSEtjwhJJ9qxfYlTp9bUMbxUjHvQ/nyqIw99LGK5uGZ/pke7UwGJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744198733; c=relaxed/simple;
	bh=dxcwp88N3G7DYDiwZR4Ji/yjFiG0rmREie8R00/aZb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTOupfHpvTH/qVL910hRhdtu6TuSkHkVbW5TvGlX1j4S7Yr0MSRCVru+jY/HEKyDYSW5eKwiRuhxbsYCdwhFYOQpTvJYHnzSnONZ7dqIq7Sam4+TIbSqHxOYxfahRrbxrh9GV1Ey11tGvG77wrw2fXx1Zzu7Fe9JuGdxrVqqjFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8uVlP8+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8uVlP8+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA28C4CEEF;
	Wed,  9 Apr 2025 11:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744198732;
	bh=dxcwp88N3G7DYDiwZR4Ji/yjFiG0rmREie8R00/aZb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8uVlP8+D9bkpnrf2KtAq9aEYGaZbfVNOtXqQ59uWnRu0v5YyNbt4ON1X6EX08eYh
	 h4l5BQ090lrB9bwREOZF7L/d8DOR2YmhK8nI2cO0NkjCBC+DS7SJY1GhGdejnPjvaF
	 fhTUFD8H1z43iWkSc0bj/OeEH8v3aN8nj64RikOZSwGW/a0/e39tP1wYHu5qAJTzGm
	 KEPkHInBMooAQ7UKAmx9b+IB/AggOPwPznGqyp4DdiWgL4VArhOB99XHTkxw0GDCzY
	 KpuQSMZ2DuNLofi95tTAHFjXXegkvvAhPZpaNqOjkLbpKEQ3ShJZ0Nj1JhGr47/vv4
	 vKAOJ5h2TWL5w==
Date: Wed, 9 Apr 2025 13:38:46 +0200
From: Ingo Molnar <mingo@kernel.org>
To: mark.barnett@arm.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, irogers@google.com, ben.gainey@arm.com,
	deepak.surti@arm.com, ak@linux.intel.com, will@kernel.org,
	james.clark@arm.com, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/5] A mechanism for efficient support for
 per-function metrics
Message-ID: <Z_ZcRiHTGljxEEdN@gmail.com>
References: <20250408171530.140858-1-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408171530.140858-1-mark.barnett@arm.com>


* mark.barnett@arm.com <mark.barnett@arm.com> wrote:

> From: Mark Barnett <mark.barnett@arm.com>
> 
> This patch introduces the concept of an alternating sample rate to perf
> core and provides the necessary basic changes in the tools to activate
> that option.
> 
> The primary use case for this change is to be able to enable collecting
> per-function performance metrics using the Arm PMU, as per the following 
> approach:
> 
>  * Starting with a simple periodic sampling (hotspot) profile,
>    augment each sample with PMU counters accumulated over a short window
>    up to the point the sample was taken.
>  * For each sample, perform some filtering to improve attribution of
>    the accumulated PMU counters (ensure they are attributed to a single
>    function)
>  * For each function accumulate a total for each PMU counter so that
>    metrics may be derived.
> 
> Without modification, and sampling at a typical rate associated
> with hotspot profiling (~1mS) leads to poor results. Such an
> approach gives you a reasonable estimation of where the profiled
> application is spending time for relatively low overhead, but the
> PMU counters cannot easily be attributed to a single function as the
> window over which they are collected is too large. A modern CPU may
> execute many millions of instructions over many thousands of functions
> within 1mS window. With this approach, the per-function metrics tend
> to trend to some average value across the top N functions in the
> profile.
> 
> In order to ensure a reasonable likelihood that the counters are
> attributed to a single function, the sampling window must be rather
> short; typically something in the order of a few hundred cycles proves
> well as tested on a range of aarch64 Cortex and Neoverse cores.
> 
> As it stands, it is possible to achieve this with perf using a very high
> sampling rate (e.g ~300cy), but there are at least three major concerns
> with this approach:
> 
>  * For speculatively executing, out of order cores, can the results be
>    accurately attributed to a give function or the given sample window?
>  * A short sample window is not guaranteed to cover a single function.
>  * The overhead of sampling every few hundred cycles is very high and
>    is highly likely to cause throttling which is undesirable as it leads
>    to patchy results; i.e. the profile alternates between periods of 
>    high frequency samples followed by longer periods of no samples. 
> 
> This patch does not address the first two points directly. Some means
> to address those are discussed on the RFC v2 cover letter. The patch
> focuses on addressing the final point, though happily this approach
> gives us a way to perform basic filtering on the second point.
> 
> The alternating sample period allows us to do two things:
> 
>  * We can control the risk of throttling and reduce overhead by
>    alternating between a long and short period. This allows us to
>    decouple the "periodic" sampling rate (as might be used for hotspot
>    profiling) from the short sampling window needed for collecting
>    the PMU counters.
>  * The sample taken at the end of the long period can be otherwise 
>    discarded (as the PMU data is not useful), but the
>    PERF_RECORD_CALLCHAIN information can be used to identify the current
>    function at the start of the short sample window. This is useful
>    for filtering samples where the PMU counter data cannot be attributed
>    to a single function.
> 
> There are several reasons why it is desirable to reduce the overhead and
> risk of throttling:
> 
>   * PMU counter overflow typically causes an interrupt into the kernel;
>     this affects program runtime, and can affect things like branch
>     prediction, cache locality and so on which can skew the metrics.
>   * The very high sample rate produces significant amounts of data.
>     Depending on the configuration of the profiling session and machine,
>     it is easily possible to produce many orders of magnitude more data
>     which is costly for tools to post-process and increases the chance
>     of data loss. This is especially relevant on larger core count
>     systems where it is very easy to produce massive recordings.
>     Whilst the kernel will throttle such a configuration,
>     which helps to mitigate a large portion of the bandwidth and capture
>     overhead, it is not something that can be controlled for on a per
>     event basis, or for non-root users, and because throttling is
>     controlled as a percentage of time its affects vary from machine to
>     machine. AIUI throttling may also produce an uneven temporal
>     distribution of samples. Finally, whilst throttling does a good job
>     at reducing the overall amount of data produced, it still leads to
>     much larger captures than with this method; typically we have
>     observed 1-2 orders of magnitude larger captures.
> 
> This patch set modifies perf core to support alternating between two
> sample_period values, providing a simple and inexpensive way for tools
> to separate out the sample window (time over which events are
> counted) from the sample period (time between interesting samples). 

Upstreaming path:
=================

So, while this looks interesting and it might work, a big problem as I 
see it is to get tools to use it: the usual kernel feature catch-22.

So I think a hard precondition for an upstream merge would be for the 
usage of this new ABI to be built into 'perf top/record' and used by 
default, so the kernel side code gets tested and verified - and our 
default profiling output would improve rather substantially as well.

ABI details:
============

I'd propose a couple of common-sense extensions to the ABI:

1)

I think a better approach would be to also batch the short periods, 
i.e. instead of interleaved long-short periods:

   L S L S L

we'd support batches of short periods:

   L SSSS L SSSS L SSSS L SSSS

As long as the long periods are 'long enough', throttling wouldn't
(or, at least, shouldn't) trigger. (If throttling triggers, it's the 
throttling code that needs to be fixed.)

This means that your proposed ABI would also require an additional 
parameter: [long,short,batch-count]. Your current proposal is basically 
[long,short,1].

Advantages of batching the short periods (let's coin it 
'burst-profiling'?) would be:

 - Performance: the caching of the profiling machinery, which would 
   reduce the per-short-sample overhead rather substantially I believe. 
   With your current approach we bring all that code into CPU caches 
   and use it 1-2 times for a single data record, which is kind of a 
   waste.

 - Data quality: batching increases the effective data rate of 
   'relevant' short samples, with very little overall performance 
   impact. By tuning the long-period and the batch length the overall 
   tradeoff between profiling overhead and amount of data extracted can 
   be finetuned pretty well IMHO. (Tools might even opt to discard the 
   first 'short' sample to decouple it from the first cache-cold 
   execution of the perf machinery.)

2)

I agree with the random-jitter approach as well, to remove short-period 
sampling artifacts that may arise out of the period length resonating 
with the execution time of key code sequences, especially in the 2-3 
digits long integers sampling period spectrum, but maybe it should be 
expressed in terms of a generic period length, not as a random 4-bit 
parameter overlaid on another parameter.

Ie. the ABI would be something like:

  [period_long, period_short, period_jitter, batch_count]

I see no reason why the random jitter has to be necessarily 4 bits 
short, and it could apply to the 'long' periods as well. Obviously this 
all complicates the math on the tooling side a bit. ;-)

If data size is a concern: there's no real need to save space all that 
much on the perf_attr ABI side: it's a setup/configuration structure, 
not a per sample field where every bit counts.

Implementation:
===============

Instead of making it an entirely different mode, we could allow 
period_long to be zero, and map regular periodic events to 
[0,period_short,0,1], or so? But only if that simplifies/unifies the 
code.

Summary:
========

Anyway, would something like this work for you? I think the most 
important aspect is to demonstrate working tooling side. Good thing
we have tools/perf/ in-tree for exactly such purposes. ;-)

Thanks,

	Ingo
