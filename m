Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C645364AB
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Aug 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885804; cv=none; b=bWz2cFobxEJYQ5g5kbkBM2cqriLvEfa1P0F43XqQmEAE+7CnM+DBXJsXMmgnPvJksrWEpK8fbURsYjFxK6nuSk1e9sPCqiDHa7Ua15Enr6+DT0Ti9bstU1Hcx7TOO0GqQvuFAcTiZBbdHYQHesimjVpe8G/34rv+6wIOeUfu52I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885804; c=relaxed/simple;
	bh=nis7DM7PTY+HA5z/d9KgtqaMFEmyar/UjLOuqnu9OcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdjJXSNVtJaPtzSsHWn5enpYd1PHXh/0V3DOgeR4IYX3CxlrKyH9bFo8JLcNl5odGEyUmlR9moG4CJpz1SRv/Ktr+26p+1YIcfPWp/5BL66Lri4X77YPFcHDN57RHZnwTWMwYe0J2XIGeEMaETakyJrvDg+t38bEz968OevWk+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhxiXgDX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhxiXgDX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B23EC32782;
	Mon,  5 Aug 2024 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885804;
	bh=nis7DM7PTY+HA5z/d9KgtqaMFEmyar/UjLOuqnu9OcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EhxiXgDXOp7bVuplsObb9t6u1ShuWSMNlf74W81RBODFD9nO7/VyZn8YoL4xVlAnL
	 EhEfTQZeBisBb8IDFCYJcxFA8Ogj7+wPgdsBoI8nVIe/nIoctiixOYeHT+ILPM3qXu
	 GAh8jtzHsy7pX/Mtg0JAVVVPQFsW81HtWz1sE90nAWv+thOm5ckNWPT/zhZQeMfx++
	 qVgmJW627mxKFHA38UdRL9YO+KbrQJ8lpLNqC0H07IQuc1X2qdwHkTba20YTsT2pPa
	 4ViebqoI2Kyys/DHoQfWim/6KB5kUtSbDUxD/hZUQ9NIaMCVINmx0IyRHjJjJ0co+F
	 q1w28JBWtweMA==
Date: Mon, 5 Aug 2024 12:23:22 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v8 3/4] perf script: Fix perf script -F +metric
Message-ID: <ZrEmqk8yNzzGXd_4@google.com>
References: <20240801212844.677895-1-ak@linux.intel.com>
 <20240801212844.677895-3-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240801212844.677895-3-ak@linux.intel.com>

On Thu, Aug 01, 2024 at 02:28:43PM -0700, Andi Kleen wrote:
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
> ----
> 
> v2: Reformat code
> v3: Work around bogus warning
> v4: Set up aggr map only for metrics case to keep perf stat record
> working
> v5: Broken version
> v6: Only set up limited aggregation mode with -F +metric. Add conflict
> checks with perf stat record files.
> v7: Remove some unnecessary conflict checks. Fix buffer overflow. Minor cleanups.
> v8: Add check for leader sampling. Update some comments.
> ---
>  tools/perf/builtin-script.c | 50 +++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..04378615b2ad 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -335,7 +335,6 @@ struct evsel_script {
>         FILE *fp;
>         u64  samples;
>         /* For metric output */
> -       u64  val;
>         int  gnum;
>  };
>  
> @@ -2127,18 +2126,30 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  	};
>  	struct evsel *ev2;
>  	u64 val;
> +	static int printed;
>  
>  	if (!evsel->stats)
>  		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
>  	if (evsel_script(leader)->gnum++ == 0)
>  		perf_stat__reset_shadow_stats();
> -	val = sample->period * evsel->scale;
> -	evsel_script(evsel)->val = val;
> +	val = sample->period;
> +	if (!(evsel->core.attr.sample_type & PERF_SAMPLE_READ)) {

The correct check would need PERF_FORMAT_GROUP in attr.read_format for
the leader event, and no attr.sample_period for member events.  But I
guess practically it's enough to check the leader only.

Thanks,
Namhyung


> +		if (!printed)
> +			fprintf(stderr, "perf script: -F metric requires {}:S for groups leader sampling\n");
> +		printed = 1;
> +		return;
> +	}
> +	/*
> +	 * Always use the first entry as storage because the leader sampling
> +	 * groups are contiguous and there's no need to handle multiple indexes
> +	 * for anything.
> +	 */
> +	evsel->stats->aggr[0].counts.val = val;
>  	if (evsel_script(leader)->gnum == leader->core.nr_members) {
>  		for_each_group_member (ev2, leader) {
>  			perf_stat__print_shadow_stats(&stat_config, ev2,
> -						      evsel_script(ev2)->val,
> -						      sample->cpu,
> +						      evsel->stats->aggr[0].counts.val,
> +						      0,
>  						      &ctx,
>  						      NULL);
>  		}
> @@ -2325,6 +2336,20 @@ static void process_event(struct perf_script *script,
>  		fflush(fp);
>  }
>  
> +static void check_metric_conflict(void)
> +{
> +	int i;
> +	/*
> +	 * Avoid conflict with the aggregation mode used for the metric printing.
> +	 */
> +	for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
> +		if (output[i].fields & PERF_OUTPUT_METRIC) {
> +			fprintf(stderr, "perf stat record files are not supported with -F metric\n");
> +			exit(1);
> +		}
> +	}
> +}
> +
>  static struct scripting_ops	*scripting_ops;
>  
>  static void __process_stat(struct evsel *counter, u64 tstamp)
> @@ -2334,6 +2359,8 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
>  	struct perf_cpu cpu;
>  	static int header_printed;
>  
> +	check_metric_conflict();
> +
>  	if (!header_printed) {
>  		printf("%3s %8s %15s %15s %15s %15s %s\n",
>  		       "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
> @@ -3725,6 +3752,8 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
>  {
>  	perf_event__read_stat_config(&stat_config, &event->stat_config);
>  
> +	check_metric_conflict();
> +
>  	/*
>  	 * Aggregation modes are not used since post-processing scripts are
>  	 * supposed to take care of such requirements
> @@ -4088,6 +4117,17 @@ int cmd_script(int argc, const char **argv)
>  
>  	argc = parse_options_subcommand(argc, argv, options, script_subcommands, script_usage,
>  			     PARSE_OPT_STOP_AT_NON_OPTION);
> +	for (i = 0; i < OUTPUT_TYPE_MAX; i++) {
> +		if (output[i].fields & PERF_OUTPUT_METRIC) {
> +			stat_config.aggr_map = cpu_aggr_map__empty_new(1);
> +			err = -ENOMEM;
> +			if (!stat_config.aggr_map)
> +				goto out;
> +			err = 0;
> +			stat_config.aggr_map->nr = 1;
> +			break;
> +		}
> +	}
>  
>  	if (symbol_conf.guestmount ||
>  	    symbol_conf.default_guest_vmlinux_name ||
> -- 
> 2.45.2
> 
