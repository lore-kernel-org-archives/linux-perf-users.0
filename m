Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC9210183;
	Fri, 10 Jan 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518128; cv=none; b=Rntabv6ps9DhiA7tOB3XepzyCAIt0qbRRN8S7T5MLLvLQCkk/duTddpjnwUpWfvD6wFnQS9D+dzzEtI6E4BBoXLkM+aNAfYQGbHu4uvVF07OHMdmF65qNK+5sS1lQX/d/xC8ploUhf7LKbb+j0+51S2qbUV+hmbnBupvs17t72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518128; c=relaxed/simple;
	bh=doLg3OVsgxP+lzIE9qGLE2bunoaSON/plcxNQy85W+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4txMOOl4BzXi0PWBwV5TWRvsDMBntMglKfP2qXmrdXFmosedcE+baYoWMR2qwn/pYqMOFk1yh+AHnKx62/+RTFldIm8ZTC7h5xzoHz0lbVGKQnP7/ONbUB76Y16kY+RQN/aDze5eofGWdAaSh22EfoLIzInomMEYBjGapROLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVOqUC0J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVOqUC0J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4E2AC4CED6;
	Fri, 10 Jan 2025 14:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736518128;
	bh=doLg3OVsgxP+lzIE9qGLE2bunoaSON/plcxNQy85W+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVOqUC0JSXRaQ6LKSsxWPhkQKK26jfaIABa0hTPtjJuuZ16qLyOqnQfEWVd4ksxUk
	 5oQ1UobDXyvc8HfA2DWWXOYL09lHk8ZSYHOFEsgY5uqjVBb4+2gxSQpicw3X2VeHJT
	 shBJefucxxI0A9wyl0AwWomghlkeGRE8zbwhyGcvFSge0R8lwE0So+1f/MH6jT04V9
	 2a3UtCZWaqMx43qQDP44wV8oIs3j5Q/LwR+2Hn8jjbCQS/DDDW/4SSJdvscIRoIRMD
	 tzsQdoHsbYnsZhR0feZsNB450hLZf+dGs4u067OE6tQjqyKnFeJtDdHlt7RhVgzKoz
	 UZLCwX7eB36yA==
Date: Fri, 10 Jan 2025 11:08:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 2/2] perf ftrace: Fix display for range of the first
 bucket
Message-ID: <Z4Ep7WbRhZXVINCc@x1>
References: <20250108210015.1188531-1-namhyung@kernel.org>
 <20250108210015.1188531-2-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108210015.1188531-2-namhyung@kernel.org>

On Wed, Jan 08, 2025 at 01:00:15PM -0800, Namhyung Kim wrote:
> When min_latency is not given, it prints 0 - 0.  It should be 0 - 1.
> 
> Before:
>   $ sudo ./perf ftrace latency -a -T do_futex sleep 1
>   #   DURATION     |      COUNT | GRAPH                                          |
>        0 -    0 us |        321 | ###########                                    |
>   ...
> 
> After:
>   $ sudo ./perf ftrace latency -a -T do_futex sleep 1
>   #   DURATION     |      COUNT | GRAPH                                          |
>        0 -    1 us |        699 | ############                                   |
>   ...
> 
> Fixes: b875b6bf608589 ("perf ftrace latency: Introduce --min-latency to narrow down into a latency range")

I couldn't find the above cset in perf-tools not perf-tools-next nor in
upstream, I fixed it up to:

Fixes: 08b875b6bf608589 ("perf ftrace latency: Introduce --min-latency to narrow down into a latency range")

Thanks,

- Arnaldo

> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 90cf2c9915a7e35b..cfd770ec72867d77 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -840,7 +840,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
>  	bar_len = buckets[0] * bar_total / total;
>  
>  	printf("  %4d - %4d %s | %10d | %.*s%*s |\n",
> -	       0, min_latency, use_nsec ? "ns" : "us",
> +	       0, min_latency ?: 1, use_nsec ? "ns" : "us",
>  	       buckets[0], bar_len, bar, bar_total - bar_len, "");
>  
>  	for (i = 1; i < NUM_BUCKET - 1; i++) {
> -- 
> 2.47.1.613.gc27f4b7a9f-goog
