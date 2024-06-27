Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3020B13FF9
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Jun 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719528417; cv=none; b=SlgcFDm5ZfigED/qXfRkk9a53xx7bLxbO/apZUBPLbD7iVHsTnNbDsWpYyoLe90zNDYm0WUKH9+m5HzpJmWtRQTcJML4cMrO8UM0IfGOZppHh09c6bsK5oW9kk5KlVCv2gZg9k+fV2EFXe9LF+NmWCB7c5Mp5byRj/X/Om8Kcko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719528417; c=relaxed/simple;
	bh=aaLpt5wMITQ53o71cHIlZAYk34xozZnmTL8g4xFRp+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LpU2mhartooxhpgM1YwV6haRH4mJqqs+J0YRmrMPgCAmusy2krnLAsA/A6ti52z8oCKZavi02dyZX5pOvg/TulvQvJBGaN/HeT2ZRrQySYVo/Qj9wGlRyUlqnd+sJNPI6qRPM3cpMBkwAFRUq8HkzHvBAPW0J1BWAx4tlsuHuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CK2i5oRx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CK2i5oRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DEEDC32786;
	Thu, 27 Jun 2024 22:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719528416;
	bh=aaLpt5wMITQ53o71cHIlZAYk34xozZnmTL8g4xFRp+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CK2i5oRxIjKO4zERZHwEsTnpZbUV7oUXeOVSbwNmRtc5tFFxhYW2AXzI8vhxaxRLQ
	 wCB/N2hG0T/MiTTUeBBZFXKHFUyGqQAZ+GwGpTVbQQx8VuIYJ2kfXrzYzNcbMpAobG
	 kNFZqlQcowXhYSZIV/u0jrHnHZnftMPtmVs0NFl9Fl93xelE6Y/GnygqBEt4Z+1QdX
	 LbtDELiP/dFytz0JklX1S2Tr1uzQKalJfBkQWdGlccAL7a7knM6C/eNFF8wXWewALd
	 sqTG7IvEuKKlYcuTFcOGCI4/8E/zMzT2qic4Ti5cityNVfX5HEvUyvHfJHDTFv0awZ
	 XRN3Fmn93LqHQ==
Date: Thu, 27 Jun 2024 15:46:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/2] perf script: Fix perf script -F +metric
Message-ID: <Zn3r3xNIItbpm19i@google.com>
References: <20240625004232.1852705-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240625004232.1852705-1-ak@linux.intel.com>

Hi Andi,

On Mon, Jun 24, 2024 at 05:42:31PM -0700, Andi Kleen wrote:
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

Thanks for the fix!

> 
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather ...")
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/builtin-script.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..4aab194b4b1a 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -84,7 +84,7 @@ static bool			system_wide;
>  static bool			print_flags;
>  static const char		*cpu_list;
>  static DECLARE_BITMAP(cpu_bitmap, MAX_NR_CPUS);
> -static struct perf_stat_config	stat_config;
> +static struct perf_stat_config	stat_config = { .aggr_map = &(struct cpu_aggr_map){ .nr = 1 } };

Can you please follow the coding style and properly put the code?

Thanks,
Namhyung


>  static int			max_blocks;
>  static bool			native_arch;
>  static struct dlfilter		*dlfilter;
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
> -- 
> 2.45.2
> 
