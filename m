Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22A1DA301
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jul 2024 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719961099; cv=none; b=Zue74shZlX1Nmp146sMleszBOBCz+LLltJdynPSyrx21H1O25kJ7k7UnHEgox5YH7qfihsBladgNJVpeeYzh8fNhwfbXSjIc4c2okNuedfkiBgn3ITYxWgpJT9tJHKgb4asOiVx6fBGrtCTvctln403eQjNN6BzWThgZbZJx8Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719961099; c=relaxed/simple;
	bh=cmQjzzK9c8jeQNlcTULX6APz8wOCEXhaDhDgXY20iJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGHfqpBT+zT3sGUyAqz8h1iNkI5Dd3kF/gKwev8LBPaCzlqSh5TfJToujvqDvLtwmha8aUoe1ignqOXjXVwMeKihjmgoElCln9dl+MUfWeRET+Ga67n6pUwDot7s1CpmHGxHzDDBNYCPA6q/bNbMC003ZVd+W5pcQjNoG/FjmUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jMSDwWOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jMSDwWOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDF1C116B1;
	Tue,  2 Jul 2024 22:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719961098;
	bh=cmQjzzK9c8jeQNlcTULX6APz8wOCEXhaDhDgXY20iJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jMSDwWOQVWyl9TXTZPtgEPQDmqA51Qn0+10Y4CDnUdOoR79BhW1AQ+YbdZUDbKnAe
	 nVFPME0q3kbArjiPcv9Hq0NsS+hGGJbOcNPMH6aDBImw6WMbAXu0l/rqRwiqdWPLR+
	 gv2ngCcKHHRkqb8QifBLg/rjlpVFYh3C+AmkpmvvEdpxnlYGFzwY1MWf0cYZwDwMPk
	 fbo9GFrtMmy59BQ3PTT1t0h5tXogEQ+ufg+EAcySN0p69RewrjKy3pM2nnst3VyNna
	 o/yA0KksArj/S9eb/B9AcL2r+5mzDpTeZog0kDI3B6/zCYMMVLvVWg2c6SVvLdOdQi
	 NXvWGioMh4vJw==
Date: Tue, 2 Jul 2024 15:58:17 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/2] perf script: Fix perf script -F +metric
Message-ID: <ZoSGCQlQpvE4Iug6@google.com>
References: <20240628000455.1890269-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628000455.1890269-1-ak@linux.intel.com>

Hi Andi,

On Thu, Jun 27, 2024 at 05:04:54PM -0700, Andi Kleen wrote:
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
> 
> --

This should be "---" instead of "--".  Otherwise git or b4 is confused
and add tags under this section.

Thanks,
Namhyung

> 
> v2: Reformat code
> ---
>  tools/perf/builtin-script.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..0aeff280fa55 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -84,7 +84,9 @@ static bool			system_wide;
>  static bool			print_flags;
>  static const char		*cpu_list;
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> -static struct perf_stat_config	stat_config;
> +static struct perf_stat_config	stat_config = {
> +	.aggr_map = &(struct cpu_aggr_map){ .nr = 1 }
> +};
>  static int			max_blocks;
>  static bool			native_arch;
>  static struct dlfilter		*dlfilter;
> @@ -2133,12 +2135,14 @@ static void perf_sample__fprint_metric(struct perf_script *script,
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
> -- 
> 2.45.2
> 
