Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C18E2AF04;
	Sun, 23 Mar 2025 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742756541; cv=none; b=nuKtAalYsDmpZt6t5aeL8Q7f4wFAwiWpiUyimnX7Kj42K0CDvHxDxLixB/cu5VZ83Oe6pA++qhMv0/ropDX/cKRkS2od2in1fFuG4b1dfENl3dfU6dVVtg3oEwxl8MyIMpVsx91DPbGGQOFMfLklM3ImbsBfhXF/02dSf6zHKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742756541; c=relaxed/simple;
	bh=xPwUEeMkum1alHhyumvzKlvq3K2o0Qo1SY878rhBFGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2+9kVozO6hgqHgDyHAjuqAs1zGKsjQCdZdfGm8FnRmFqipMMxepMlQzGcYxRQhiPbVBUkE9gLkc42GPUgfi1lpG45dI19hHqnt7fReI3AseJ04WxvYTJ1ng4khfa3Eh5aQGIiW9zo54Ds6ccMb5sdYsV9Qr1iWF85rxko0daGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbbDbVN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbbDbVN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97137C4CEE2;
	Sun, 23 Mar 2025 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742756540;
	bh=xPwUEeMkum1alHhyumvzKlvq3K2o0Qo1SY878rhBFGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sbbDbVN06ziuFHRyBn225BaHp3dYBYyjTiUiQptdyTp6qqBPG6QN0EQ+VJeHwQxDf
	 HnDtbcAlzJhCqkipskKCGyDtNJ/Z5CswXFmz/dASHjHqZeEOy9RsMkpEM8TvfcADWs
	 hP2LbPnnQNWMgsOnXTVhV0hMqd96skZT0wcROVllJCT82+jZoAlxRXhKBz9UKZrmDz
	 QA8JMm4fom4/C9HuKpouG78++gEM8MxblXmmEnrr7YHY2Mpwi8Bxk2t+s0PSHNbnRf
	 s3oTbJO5hQFh5jshHLN/GpJVQgPx9XTMZchJkdFz5pdWfTv4lm8VW3pHt2HWjIqVgJ
	 5LVUyIog5wwyA==
Date: Sun, 23 Mar 2025 20:02:15 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Dirk Gouders <dirk@gouders.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf bench sched pipe: fix enforced blocking reads in
 worker_thread
Message-ID: <Z-Bat1oBCQqT5mt5@gmail.com>
References: <20250323140316.19027-2-dirk@gouders.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250323140316.19027-2-dirk@gouders.net>


* Dirk Gouders <dirk@gouders.net> wrote:

> The function worker_thread() is programmed in a way that roughly
> doubles the number of expectable context switches, because it enforces
> blocking reads:
> 
>  Performance counter stats for 'perf bench sched pipe':
> 
>          2,000,004      context-switches
> 
>       11.859548321 seconds time elapsed
> 
>        0.674871000 seconds user
>        8.076890000 seconds sys
> 
> The result of this behavior is that the blocking reads by far dominate
> the performance analysis of 'perf bench sched pipe':
> 
> Samples: 78K of event 'cycles:P', Event count (approx.): 27964965844
> Overhead  Command     Shared Object         Symbol
>   25.28%  sched-pipe  [kernel.kallsyms]     [k] read_hpet
>    8.11%  sched-pipe  [kernel.kallsyms]     [k] retbleed_untrain_ret
>    2.82%  sched-pipe  [kernel.kallsyms]     [k] pipe_write
> 
> From the code, it is unclear if that behavior is wanted but the log
> says that at least Ingo Molnar aims to mimic lmbench's lat_ctx, that
> doesn't handle the pipe ends that way
> (https://sourceforge.net/p/lmbench/code/HEAD/tree/trunk/lmbench2/src/lat_ctx.c)
> 
> Fix worker_thread() by always first feeding the write ends of the pipes
> and then trying to read.
> 
> This roughly halves the context switches and runtime of pure
> 'perf bench sched pipe':
> 
>  Performance counter stats for 'perf bench sched pipe':
> 
>          1,005,770      context-switches
> 
>        6.033448041 seconds time elapsed
> 
>        0.423142000 seconds user
>        4.519829000 seconds sys
> 
> And the blocking reads do no longer dominate the analysis at the above
> extreme:
> 
> Samples: 40K of event 'cycles:P', Event count (approx.): 14309364879
> Overhead  Command     Shared Object         Symbol
>   12.20%  sched-pipe  [kernel.kallsyms]     [k] read_hpet
>    9.23%  sched-pipe  [kernel.kallsyms]     [k] retbleed_untrain_ret
>    3.68%  sched-pipe  [kernel.kallsyms]     [k] pipe_write
> 
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  tools/perf/bench/sched-pipe.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/bench/sched-pipe.c b/tools/perf/bench/sched-pipe.c
> index e2562677df96..70139036d68f 100644
> --- a/tools/perf/bench/sched-pipe.c
> +++ b/tools/perf/bench/sched-pipe.c
> @@ -204,17 +204,10 @@ static void *worker_thread(void *__tdata)
>  	}
>  
>  	for (i = 0; i < loops; i++) {
> -		if (!td->nr) {
> -			ret = read_pipe(td);
> -			BUG_ON(ret != sizeof(int));
> -			ret = write(td->pipe_write, &m, sizeof(int));
> -			BUG_ON(ret != sizeof(int));
> -		} else {
> -			ret = write(td->pipe_write, &m, sizeof(int));
> -			BUG_ON(ret != sizeof(int));
> -			ret = read_pipe(td);
> -			BUG_ON(ret != sizeof(int));
> -		}
> +		ret = write(td->pipe_write, &m, sizeof(int));
> +		BUG_ON(ret != sizeof(int));
> +		ret = read_pipe(td);
> +		BUG_ON(ret != sizeof(int));

Yeah, this was unintended:

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
