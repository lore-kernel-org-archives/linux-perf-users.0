Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB81DFD2
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720802536; cv=none; b=EiFG/Rw9dEalCTISe35S9FGa+rMdgU3+Xg9nfXr7iE0pJEHcqFf3W6/mjtMwJzWL8uLnAFEdNVCbXeWeAOAnPc/HjN4NiwasZnHocwUOukCHDPQqCmxgLrlUo32UC5u3V8+OLSmkq1YPP4ewUhRWKHk+nEddKbfrDqhWkDjX2wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720802536; c=relaxed/simple;
	bh=ImtupmMyF6x+j7EQ5xw/Ds0DEKnBTYpHY6cVLqbwHxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGvxPI84SGVqqF+QqeTFDUGUw0me/VvI3kCPiPcaV96i2ojHRQqrYt+zqq+GzJyy5DfdrEnWxl58pIWx8YEAyaQHRaJGLTzE6J8p76wPE+mO65ew/wd0hpAvIKssqKj0PHTc45Yu6r4vOkeFU7WjXeqZqNsjQbxNkCayj9oug2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3usBvGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3usBvGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBBBC32782;
	Fri, 12 Jul 2024 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720802535;
	bh=ImtupmMyF6x+j7EQ5xw/Ds0DEKnBTYpHY6cVLqbwHxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R3usBvGOXWEzjSZdK087mcTrLOVzsRv1opiPQwotdwx2kwrnw2UwnkxWRppuhpxlc
	 hPKuLI7836emddSM+8zE8esFv8Py0zqNUMAMY14R850Xo+mTRuGh0OYczGnrjmTITJ
	 TGzli/s+svYWu6XtRnCvCmvhaAA7oITT0+6Vkgfj7nh0flRTZHF+NOl6hpB+1R72ja
	 bqCMvpcHyK5h39erpkbxhVHFllICuWaZOUJOT2Ei7gkXnyLcv/ylLj/uIvu3F5iuGJ
	 oEy0SFwIGNgaF+cNpFwieGtJmp7T8h4pTHK3tYDSwu+1DJnXtKNWhA2PYL78K/b3rF
	 MORU4IkjeMaOw==
Date: Fri, 12 Jul 2024 09:42:12 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 1/2] perf script: Fix perf script -F +metric
Message-ID: <ZpFc5Lt70CThoSaa@google.com>
References: <20240706191857.302450-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240706191857.302450-1-ak@linux.intel.com>

Hi Andi,

On Sat, Jul 06, 2024 at 12:18:56PM -0700, Andi Kleen wrote:
> This fixes a regression with perf script -F +metric originally caused by :
> 
> commit 37cc8ad77cf81f3ffd226856c367b0e15333a738
> Author: Ian Rogers <irogers@google.com>
> Date:   Sun Feb 19 01:28:46 2023 -0800
> 
>     perf metric: Directly use counts rather than saved_value
> 
> In the perf script environment the evsel wouldn't allocate an aggr
> values array, which led to a -1 reference because the metric
> evaluation would try to reference NULL - 1 (for aggr_idx)
> 
> Give the perf script evsels a single CPU aggr setup. That's
> enough because the groups are always contiguous, so no need
> to store more than one CPU's worth of values.
> 
> Before
> 
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> % perf script -F +metric
> Segmentation fault (core dumped)
> 
> After:
> 
> % perf record -e '{cycles,instructions}:S' perf bench  mem memcpy
> ...
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.028 MB perf.data (90 samples) ]
> % perf script -F +metric
>        perf-exec 1847557 264658.180789:       3009       cycles:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
>        perf-exec 1847557 264658.180789:        382 instructions:  ffffffff990a579a native_write_msr+0xa ([kernel.kallsyms])
>        perf-exec 1847557 264658.180789:         metric:    0.13  insn per cycle
> ...
> 
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

This makes perf stat test fail.

  $ sudo ./perf test -v 104
  104: perf stat tests:
  --- start ---
  test child forked, pid 2762796
  Basic stat command test
  Basic stat command test [Success]
  stat record and report test
  stat record and report test [Success]
  stat record and script test
  stat record and script test [Failed]
  stat repeat weak groups test
  stat repeat weak groups test [Success]
  Topdown event group test
  Topdown event group test [Skipped event parsing failed]
  Topdown weak groups test
  Topdown weak groups test [Skipped event parsing failed]
  cputype test
  cputype test [Success]
  ---- end(-1) ----
  104: perf stat tests                                                 : FAILED!

And it gets a segfault to run manually.

  $ ./perf stat record -o- true | ./perf script -i-
  Segmentation fault

Thanks,
Namhyung

> 
> ----
> 
> v2: Reformat code
> v3: Avoid warning on some compilers
> ---
>  tools/perf/builtin-script.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..95ba3f3cff60 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -2133,12 +2133,14 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  	if (evsel_script(leader)->gnum++ == 0)
>  		perf_stat__reset_shadow_stats();
>  	val = sample->period * evsel->scale;
> +	/* Always use CPU 0 storage because the groups are contiguous. */
> +	evsel->stats->aggr[0].counts.val = val;
>  	evsel_script(evsel)->val = val;
>  	if (evsel_script(leader)->gnum == leader->core.nr_members) {
>  		for_each_group_member (ev2, leader) {
>  			perf_stat__print_shadow_stats(&stat_config, ev2,
>  						      evsel_script(ev2)->val,
> -						      sample->cpu,
> +						      0,
>  						      &ctx,
>  						      NULL);
>  		}
> @@ -4084,6 +4086,7 @@ int cmd_script(int argc, const char **argv)
>  
>  	perf_set_singlethreaded();
>  
> +	stat_config.aggr_map = &(struct cpu_aggr_map){ .nr = 1 };
>  	setup_scripting();
>  
>  	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
> -- 
> 2.45.2
> 
