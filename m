Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E56AA7;
	Fri, 10 Jan 2025 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736470004; cv=none; b=hVzIVVEi0CdiUPN1g9OomOIfKj/Hepix245Z6Ikp6wrB9Uo0YzCpDFhFJePmXX7V7ezdQKCkjWQLM6YPz34pUnUW7Y/uhzKPcj9YfHZn5U6UdMod2gcu8x61q7FD5tvKCzNoZMbzrBamGK2Tx6tP0TyXeSqadyZ8DuM8BAxnftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736470004; c=relaxed/simple;
	bh=A3d3vgbVOw/ZeuhbBwDa1JMMTp93Uxd9h0fFzPHcFA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0AUdfZaaSeRsm/RTNsN/ilOHoKsYiJ36T98lfEptF5nzXTat06+Q5Y68XQDCwDiiqtwTwmxRjfm+RIqumR07pPxDrCBE4Ppm2A2yWkNhxa30+ctjywnuuuHH45c40wdALCz7BU9lYymX5Y8yfey4nsT93aqKBanV/6ox8ppN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEZCMrzN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEZCMrzN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E9BC4CED2;
	Fri, 10 Jan 2025 00:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736470003;
	bh=A3d3vgbVOw/ZeuhbBwDa1JMMTp93Uxd9h0fFzPHcFA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EEZCMrzN1blEKKiNzvvcsh1YCT1DL/XNVTT9jqK+A4ELWvHlkpC3VHZQyUhhWPDto
	 xvCIJy56EX4Eln0I9U6/7OlQwgj+T/SS+FyxVVH8poMc7PnQVx6c+rWVEhG3EzZga6
	 6PEQ+B3/IWZOxQYUa+IQSaZtXpFFQD1h6ZTiGWGjunbDy8dbM12oYc01Lif/wmravE
	 x/g82V2Y3nI27HsXlqZwYr377CThEBpeAIgx0I7TE645tMExQxpqurJagCLScYABL2
	 43M7tcPK/RDuIOn01nO9Z72Xrfj2jFugB7H99GLE+Zs5gVks+M58sZbxX/1UfbCJFo
	 iKOMrYQsYIMgQ==
Date: Thu, 9 Jan 2025 16:46:41 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf ftrace: Check min/max latency only with bucket
 range
Message-ID: <Z4Bt8aIkX5uErX8a@google.com>
References: <20250108210015.1188531-1-namhyung@kernel.org>
 <a016ab208eb3ee3821ab59a2520a2bf56645917e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a016ab208eb3ee3821ab59a2520a2bf56645917e.camel@redhat.com>

On Thu, Jan 09, 2025 at 08:53:02AM +0100, Gabriele Monaco wrote:
> On Wed, 2025-01-08 at 13:00 -0800, Namhyung Kim wrote:
> > It's an optional feature and remains 0 when bucket range is not
> > given.
> > And it makes the histogram goes to the last entry always because any
> > latency (num) is greater than or equal to 0.
> 
> Thanks Namhyung for fixing this, something definitely slipped while
> testing..
> 
> I confirm your patches work well also when the bucket range is provided but the
> min latency isn't.
> 
> I'm wondering if it would be cleaner to propagate your changes (using
> min/max latency only if bucket_range is provided) also to
> make_histogram. That function currently works since we assume
> min_latency to be always 0, which is the case but probably not
> considering it altogether would look a bit better and prevent some
> headache in the future.

It looks good.  One thing I concern is 'num += min_latency' before
do_inc.  I put it there to make it symmetric to 'num -= min_latency'
so it should go to inside the block too.

Or you could factor it out as a function like 'i = get_bucket_index(num)'
so that it can keep the original num for the stats.

Thanks,
Namhyung

> 
> ---
>  tools/perf/builtin-ftrace.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 076c703e5c334..82d63d7af9d03 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -779,19 +779,16 @@ static void make_histogram(struct perf_ftrace *ftrace, int buckets[],
>  		if (ftrace->use_nsec)
>  			num *= 1000;
>  
> -		i = 0;
> -		if (num < min_latency)
> -			goto do_inc;
> -
> -		num -= min_latency;
> -
>  		if (!ftrace->bucket_range) {
>  			i = log2(num);
>  			if (i < 0)
>  				i = 0;
>  		} else {
> -			// Less than 1 unit (ms or ns), or, in the future,
> -			// than the min latency desired.
> +			i = 0;
> +			if (num < min_latency)
> +				goto do_inc;
> +
> +			num -= min_latency;
>  			if (num > 0) // 1st entry: [ 1 unit .. bucket_range units ]
>  				i = num / ftrace->bucket_range + 1;
>  			if (num >= max_latency - min_latency)
> 
> base-commit: 257ccfaf9fbef6f54eabf1a8f8a8efcc9036439b
> -- 
> 2.47.1
> 
