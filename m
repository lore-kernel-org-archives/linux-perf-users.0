Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBE819B
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 00:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721953882; cv=none; b=A7d66w90IwEUFh5+o5b4V1/jaPHHcKTc5M4jnYMqfdb1UpgSWktWBWLW/OOA5+/RsTZ67YigqTLmyhARfE+LfEkOI3wSLd3G/q0D03n7LlthFkHzhO0zV9dVoWJEiAc/fVqWjl0V3Q9LkxCnIHq246vmrhht5zO2yywingvj2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721953882; c=relaxed/simple;
	bh=qm5S+fbHM5swYKUWlQdQK4H24yfsFA4+OWQ99aScqbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZYxBCQg04zFEPb9de6fOKo6L7NhmTYKcFyarVoT9SubzoXAOp4BchVYJ5nj8Ek//PUlvvMBYLH7HvswQJt3TLFaY2blbbdjKSzqVYJIcHSFZ/0nrXykBzBSfpydB2sdKPGIgRr1FG2HPZwXjEd4xwO6sZAPDvLOrYhYWWOMMc6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV3y4Qks; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV3y4Qks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD67C116B1;
	Fri, 26 Jul 2024 00:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721953881;
	bh=qm5S+fbHM5swYKUWlQdQK4H24yfsFA4+OWQ99aScqbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iV3y4Qks1NzVOeo8DRfQ2Evmvo5+r90Q9hRx0+BgJkowRbR6CnFw+PuboxatfVW+H
	 epkzD55RuWCbm9FbD+4sACJ3kbkUeEJ0WMxjw6lbjUliuZDHX1mafMNVcFPFSiqzK9
	 0BE+5ct44atYeMG0c9zSAKP+ZrhnNG5XzZfhZg1kWOrsOLcL6fQUAUkoiw3cfg3s+k
	 aeRdTrta+5zFV7LDO/NPAL3til2WTBbwQdGN6F1RkuHXRblYqICODdApRPL9jb2kik
	 kJ4vSqg+LMkcveY4PkN/u+SDrQ29dJ4CUc0G51171fzxSHvZUxaRDAePmt7FS+zTYi
	 po+cwaW25r5Ow==
Date: Thu, 25 Jul 2024 17:31:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 3/4] perf script: Fix perf script -F +metric
Message-ID: <ZqLuWGKZjdUrkd0L@google.com>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <20240724190137.3810429-3-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240724190137.3810429-3-ak@linux.intel.com>

On Wed, Jul 24, 2024 at 12:01:36PM -0700, Andi Kleen wrote:
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
> ---
>  tools/perf/builtin-script.c | 42 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..8058bb19a956 100644
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
> @@ -2132,13 +2131,17 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
>  	if (evsel_script(leader)->gnum++ == 0)
>  		perf_stat__reset_shadow_stats();
> -	val = sample->period * evsel->scale;
> -	evsel_script(evsel)->val = val;
> +	val = sample->period;
> +	/*
> +	 * Always use the first storage because the groups are contiguous

Without leader sampling we cannot guarantee groups events fire
together, right?


> +	 * and there's no need to handle multiple indexes for anything

Actually I think this is a behavior change that you changed the
aggregation mode from NONE to GLOBAL.

> +	 */
> +	evsel->stats->aggr[0].counts.val = val;
>  	if (evsel_script(leader)->gnum == leader->core.nr_members) {
>  		for_each_group_member (ev2, leader) {
>  			perf_stat__print_shadow_stats(&stat_config, ev2,
> -						      evsel_script(ev2)->val,
> -						      sample->cpu,
> +						      evsel->stats->aggr[0].counts.val,
> +						      0,

Like I said to Ian, we should pass a proper aggr_idx here not just 0 to
support correct aggregation.  For now I think only possible choice is
AGGR_NONE (for cpu-wide record) or AGGR_THREAD (for per-task record).
Then it should be an index to cpu or thread map.

I think existing sample->cpu can be incorrect for cpu-wide records too
in case of non-contiguous CPU list like `perf record -C 1,3,5 ...`.

>  						      &ctx,
>  						      NULL);
>  		}
> @@ -2325,6 +2328,20 @@ static void process_event(struct perf_script *script,
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
> @@ -2334,6 +2351,8 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
>  	struct perf_cpu cpu;
>  	static int header_printed;
>  
> +	check_metric_conflict();
> +
>  	if (!header_printed) {
>  		printf("%3s %8s %15s %15s %15s %15s %s\n",
>  		       "CPU", "THREAD", "VAL", "ENA", "RUN", "TIME", "EVENT");
> @@ -3725,6 +3744,8 @@ static int process_stat_config_event(struct perf_session *session __maybe_unused
>  {
>  	perf_event__read_stat_config(&stat_config, &event->stat_config);
>  
> +	check_metric_conflict();
> +
>  	/*
>  	 * Aggregation modes are not used since post-processing scripts are
>  	 * supposed to take care of such requirements
> @@ -4088,6 +4109,17 @@ int cmd_script(int argc, const char **argv)
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

It should be number of entries in the cpu map or thread map.

Thanks,
Namhyung


> +			break;
> +		}
> +	}
>  
>  	if (symbol_conf.guestmount ||
>  	    symbol_conf.default_guest_vmlinux_name ||
> -- 
> 2.45.2
> 
