Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091DE17E8EA;
	Tue, 13 Aug 2024 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574659; cv=none; b=u5SQT83y3MnM5GF8guGzS4ttk1Wc4J/wzImtn+c5tWjmHaXXBe+/DCMVsNFxOgoDfqKylMciRtA2e9yeXZVTWE8G0szXjE4dSZXtheIhE+xDk8CbuyEtCfnxt/cX1hZ+OVnxzjPgNIiESt4zftVaS/RbZwy0bqKV5RTgvipWgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574659; c=relaxed/simple;
	bh=gtilcs91KeERi9zTucw/jea5Ymc0ZF42wSPow6EdHIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPyfayAHyBQ6eThxPRrLrGH4o6ddcINl0GeVSP+PM/lwzKHif3IcvtqHFixyzcdvqT4bU8xp0MufvMXxhnv8H7zxSGoJ2qUBhLsHt6VjYysfeNjZhVJQqCT7c8MZ4ADiTqNaAqege4bdK8XmYcQiKREP2i0SfRtABnsy20zxwrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrJ2Acub; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrJ2Acub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72A0C32782;
	Tue, 13 Aug 2024 18:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723574658;
	bh=gtilcs91KeERi9zTucw/jea5Ymc0ZF42wSPow6EdHIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrJ2AcubdBQyyXBhXlS/behMzDEGy8NiJ95pD34ZUlFSUedJO0uKQbxC7YGKv2ySJ
	 IsuCaBr/gRrxY/VqZhGZYyYSr0Uc5KkwZRnEBSngQC7W4UHLKyjFO4YMxfg3X47wIh
	 mcfKmDOiipuTMjKpIh3x5xA1HIm7wFmUh0ND4U4w92y6Sn6mc2GBpG+WoR87dh3sg/
	 K04ac7kITSv4KV3gLA4Xb6lNz+x9Ky7cFLC/DhpbFp+Eqe0KWLf2Fm3ynOEQs3TpWN
	 kSlsMr087FDwil5p6tGsUPT4Hs3yaduPeZV9bZDyn8mtIicLgoJc3dkD4tp3zLch/j
	 Yk9YHfPlVztKg==
Date: Tue, 13 Aug 2024 15:44:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kan.liang@linux.intel.com
Cc: namhyung@kernel.org, irogers@google.com, peterz@infradead.org,
	mingo@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH V3 1/9] perf report: Fix --total-cycles --stdio output
 error
Message-ID: <ZrupfUSZwem-hCZm@x1>
References: <20240813160208.2493643-1-kan.liang@linux.intel.com>
 <20240813160208.2493643-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813160208.2493643-2-kan.liang@linux.intel.com>

On Tue, Aug 13, 2024 at 09:02:00AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The --total-cycles may output wrong information with the --stdio.

Hey, I tried --total-cycles with --group but that didn't work, do you
think that would make sense?

Anyway, all applied, now testing and reviewing the changes,

thanks!

- Arnaldo
 
> For example,
>   perf record -e "{cycles,instructions}",cache-misses -b sleep 1
>   perf report --total-cycles --stdio
> 
> The total cycles output of {cycles,instructions} and cache-misses are
> almost the same.
> 
>  # Samples: 938  of events 'anon group { cycles, instructions }'
>  # Event count (approx.): 938
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>  # ...............  ..............  ...........  ..........
>   ..................................................>
>  #
>            11.19%            2.6K        0.10%          21
>                           [perf_iterate_ctx+48 -> >
>             5.79%            1.4K        0.45%          97
>             [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>             5.11%            1.2K        0.33%          71
>                              [native_write_msr+0 ->>
> 
>  # Samples: 293  of event 'cache-misses'
>  # Event count (approx.): 293
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>                                                   [>
>  # ...............  ..............  ...........  ..........
>    ..................................................>
>  #
>            11.19%            2.6K        0.13%          21
>                           [perf_iterate_ctx+48 -> >
>             5.79%            1.4K        0.59%          97
> [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
>             5.11%            1.2K        0.43%          71
>                              [native_write_msr+0 ->>
> 
> With the symbol_conf.event_group, the perf report should only report the
> block information of the leader event in a group.
> However, the current implementation retrieves the next event's block
> information, rather than the next group leader's block information.
> 
> Make sure the index is updated even if the event is skipped.
> 
> With the patch,
> 
>  # Samples: 293  of event 'cache-misses'
>  # Event count (approx.): 293
>  #
>  # Sampled Cycles%  Sampled Cycles  Avg Cycles%  Avg Cycles
>                                                   [>
>  # ...............  ..............  ...........  ..........
>    ..................................................>
>  #
>            37.98%            9.0K        4.05%         299
>    [perf_event_addr_filters_exec+0 -> perf_event_a>
>            11.19%            2.6K        0.28%          21
>                           [perf_iterate_ctx+48 -> >
>             5.79%            1.4K        1.32%          97
> [__intel_pmu_enable_all.constprop.0+80 -> __intel_>
> 
> Fixes: 6f7164fa231a ("perf report: Sort by sampled cycles percent per block for stdio")
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/builtin-report.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index dfb47fa85e5c..04b9a5c1bc7e 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -565,6 +565,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
>  		struct hists *hists = evsel__hists(pos);
>  		const char *evname = evsel__name(pos);
>  
> +		i++;
>  		if (symbol_conf.event_group && !evsel__is_group_leader(pos))
>  			continue;
>  
> @@ -574,7 +575,7 @@ static int evlist__tty_browse_hists(struct evlist *evlist, struct report *rep, c
>  		hists__fprintf_nr_sample_events(hists, rep, evname, stdout);
>  
>  		if (rep->total_cycles_mode) {
> -			report__browse_block_hists(&rep->block_reports[i++].hist,
> +			report__browse_block_hists(&rep->block_reports[i - 1].hist,
>  						   rep->min_percent, pos, NULL);
>  			continue;
>  		}
> -- 
> 2.38.1
