Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3F19B;
	Fri, 26 Jul 2024 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721952355; cv=none; b=B/nA3wVdrW6XkjzqtBk4iL2SweoEXetC3nSg+p1PLQ6MQoBMbSPObFeedtzZZdv35CfHWzg5zW8jYBur2uQPD7IyDuQqou/Ky43KZCodizIcRFiwLQQCe4qi/SIVWq8pfv0NrZkYCSgy35+m2qIg20VfI220kFd1RqSmFmnaikE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721952355; c=relaxed/simple;
	bh=ngBxGapSaWUVKf21KUVW3P6wC6BuZwT+K9U3vA4roq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxfcNekxUD4sJngQVh5jXB0g8G5ctaDc2Ihl6Xhi/L4aZ/xr4Pyp0DCOx2EEAlDvusDe41UvT36Kdvv832Vt12Pzigx74HthYw2HIwMz2MuwLcFvLJqhDLH8UuxMqPzTXiBgjmk+XP7jrybbYKWU7UH+YC+QCkpzgkPdsfmpF5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSLoK9LN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSLoK9LN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5480AC116B1;
	Fri, 26 Jul 2024 00:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721952354;
	bh=ngBxGapSaWUVKf21KUVW3P6wC6BuZwT+K9U3vA4roq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSLoK9LNJi0CIwhr8ANGt7wCFA45jxTutpKiAZPKCnrmvr2Bfbt2s1LbRZBHcwua8
	 BF5yPWucdX32+3AjKqmIh3LlaHVFkVjw1yiBDAw/CG5U22eZCzPsT99GC4w+0VGGi5
	 GCzZU87Dj/hP5dRKjKPWNcr4wEI2Bx6WoxObvTHj7uoP1FE6qpdEUFBB890zRCeBIC
	 6hR6/Lw4BUJoTF/q1htHLLlmlCwVhptEzId/qCp5G17FHQahTN65RSQ0sueo89EPwY
	 2JiGUujnjYXUsNk25Cx4ibbEnSTpEOykruRDGuyEz/rICU3erQ7ikG87o7Ty3XVqL0
	 0bHfSu3IrX6eQ==
Date: Thu, 25 Jul 2024 17:05:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 2/2] perf script: Fix for `perf script +F metric` with
 leader sampling
Message-ID: <ZqLoYL-kAVO-tCbo@google.com>
References: <20240720074552.1915993-1-irogers@google.com>
 <20240720074552.1915993-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240720074552.1915993-2-irogers@google.com>

Hi Ian,

On Sat, Jul 20, 2024 at 12:45:52AM -0700, Ian Rogers wrote:
> Andi Kleen reported a regression where `perf script +F metric` would
> crash. With this change the output is:
> 
> ```
> $ perf record -a -e '{cycles,instructions}:S' perf bench mem memcpy
> 
>       21.229620 GB/sec
> 
>       15.751008 GB/sec
> 
>       16.009221 GB/sec
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 1.945 MB perf.data (294 samples) ]
> $ perf --no-pager script -F +metric
>             perf 1912464 [000] 814503.473101:       6325       cycles:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>             perf 1912464 [000] 814503.473101:   metric:    0.06  insn per cycle
>             perf 1912464 [000] 814503.473101:        351 instructions:  ffffffff8548d64a native_write_msr+0xa ([kernel.kallsyms])
>             perf 1912464 [000] 814503.473101:   metric:    0.03  insn per cycle
> ...
> ```
> 
> The change fixes perf script to update counts and thereby aggregate
> values which then get consumed by unchanged metric logic in the shadow
> stat output. Note, it would be preferential to switch to json metrics.
> 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Closes: https://lore.kernel.org/linux-perf-users/20240713155443.1665378-1-ak@linux.intel.com/
> Fixes: 37cc8ad77cf8 ("perf metric: Directly use counts rather than saved_value")'
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> The code isn't well tested nor does it support non-leader sampling
> reading of counts based on periods that seemed to present in the
> previous code. Sending out for the sake of discussion. Andi's changes
> added a test and that should certainly be added.

You don't need to handle leader sampling specially since it's already
done by evlist__deliver_sample().  It will call tool->sample() for each
event (with sample->period is set) when leader sampling is enabled.

> ---
>  tools/perf/builtin-script.c | 114 +++++++++++++++++++++++++++++-------
>  1 file changed, 93 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index c16224b1fef3..752d6219fb08 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -63,6 +63,7 @@
>  #include "util/util.h"
>  #include "util/cgroup.h"
>  #include "perf.h"
> +#include <internal/threadmap.h>
>  
>  #include <linux/ctype.h>
>  #ifdef HAVE_LIBTRACEEVENT
> @@ -334,16 +335,8 @@ struct evsel_script {
>         char *filename;
>         FILE *fp;
>         u64  samples;
> -       /* For metric output */
> -       u64  val;
> -       int  gnum;
>  };
>  
> -static inline struct evsel_script *evsel_script(struct evsel *evsel)
> -{
> -	return (struct evsel_script *)evsel->priv;
> -}
> -
>  static struct evsel_script *evsel_script__new(struct evsel *evsel, struct perf_data *data)
>  {
>  	struct evsel_script *es = zalloc(sizeof(*es));
> @@ -2107,6 +2100,12 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
>  	fputs("\tmetric: ", mctx->fp);
>  }
>  
> +static struct aggr_cpu_id perf_script__get_cpu(struct perf_stat_config *config __maybe_unused,
> +					struct perf_cpu cpu)
> +{
> +	return aggr_cpu_id__cpu(cpu, /*data=*/NULL);
> +}
> +
>  static void perf_sample__fprint_metric(struct perf_script *script,
>  				       struct thread *thread,
>  				       struct evsel *evsel,
> @@ -2126,23 +2125,96 @@ static void perf_sample__fprint_metric(struct perf_script *script,
>  		.force_header = false,
>  	};
>  	struct evsel *ev2;
> -	u64 val;
> +	struct perf_cpu sample_cpu = { .cpu = sample->cpu, };
> +	int thread_idx, cpu_map_idx;
> +	u64 read_format = evsel->core.attr.read_format;
> +	int aggr_idx;
>  
> +	/* Only support leader sampling with a group of read events. */
> +	if ((read_format & PERF_FORMAT_GROUP) == 0)
> +		return;
> +
> +	/* Lazy initialization of stats values. */
>  	if (!evsel->stats)
>  		evlist__alloc_stats(&stat_config, script->session->evlist, /*alloc_raw=*/false);
> -	if (evsel_script(leader)->gnum++ == 0)
> -		perf_stat__reset_shadow_stats();
> -	val = sample->period * evsel->scale;
> -	evsel_script(evsel)->val = val;
> -	if (evsel_script(leader)->gnum == leader->core.nr_members) {
> -		for_each_group_member (ev2, leader) {
> -			perf_stat__print_shadow_stats(&stat_config, ev2,
> -						      evsel_script(ev2)->val,
> -						      sample->cpu,
> -						      &ctx,
> -						      NULL);
> +	if (!stat_config.aggr_map) {
> +		int nr_aggr;
> +
> +		stat_config.aggr_get_id = perf_script__get_cpu;

To support per-thread mode, I think we should check thread_map of the
evlist if it has actual PID.  And use the thread map index as an aggr
idx.

Thanks,
Namhyung


> +		stat_config.aggr_map =
> +			cpu_aggr_map__new(evsel->evlist->core.user_requested_cpus,
> +					aggr_cpu_id__cpu,
> +					/*data=*/NULL,
> +					/*needs_sort=*/false);
> +		if (!stat_config.aggr_map) {
> +			pr_err("cannot allocate aggr map\n");
> +			return;
> +		}
> +		nr_aggr = stat_config.aggr_map->nrd;
> +		if (evlist__alloc_aggr_stats(evsel->evlist, nr_aggr) < 0) {
> +			pr_err("cannot allocate aggr counts\n");
> +			return;
>  		}
> -		evsel_script(leader)->gnum = 0;
> +	}
> +
> +	/* Add group counts from sample into appropriate evsel counts by id. */
> +	for_each_group_evsel(ev2, leader) {
> +		struct perf_thread_map *threads = perf_evsel__threads(&ev2->core);
> +		struct perf_cpu_map *cpus = evsel__cpus(ev2);
> +		int id_num = 0;
> +		bool match = false;
> +
> +		perf_cpu_map__for_each_idx(cpu_map_idx, cpus) {
> +			for (thread_idx = 0; thread_idx < threads->nr; thread_idx++) {
> +				struct sample_read_value *value = sample->read.group.values;
> +				u64 id = ev2->core.id[id_num++];
> +
> +				sample_read_group__for_each(value, sample->read.group.nr,
> +							    read_format) {
> +					struct perf_counts_values *counts;
> +
> +					if (value->id != id)
> +						continue;
> +
> +					counts = perf_counts(ev2->counts, cpu_map_idx, thread_idx);
> +					counts->val += value->value;
> +					/*
> +					 * Ensure the enabled/running time isn't
> +					 * 0, which implies an error.
> +					 */
> +					counts->ena += sample->read.time_enabled ?: sample->period;
> +					counts->run += sample->read.time_running ?: sample->period;
> +					match = true;
> +				}
> +			}
> +		}
> +		if (match) {
> +			/* Update the aggreate count in ev2. */
> +			perf_stat_process_counter(&stat_config, ev2);
> +		}
> +	}
> +
> +	/* Find the appropriate indices for dumping of this sample. */
> +	thread_idx = perf_thread_map__idx(perf_evsel__threads(&evsel->core),
> +					thread__pid(thread));
> +	cpu_map_idx = perf_cpu_map__idx(evsel__cpus(evsel), sample_cpu);
> +	if (thread_idx == -1 || cpu_map_idx == -1)
> +		return;
> +
> +	cpu_aggr_map__for_each_idx(aggr_idx, stat_config.aggr_map) {
> +		if (stat_config.aggr_map->map[aggr_idx].cpu.cpu == sample_cpu.cpu)
> +			break;
> +	}
> +	/* Iterate all events and the leader of the group, trying to print stats. */
> +	for_each_group_evsel(ev2, leader) {
> +		struct perf_counts_values *counts =
> +			perf_counts(ev2->counts, cpu_map_idx, thread_idx);
> +
> +		if (!counts)
> +			continue;
> +
> +		perf_stat__print_shadow_stats(&stat_config, ev2, counts->val * ev2->scale,
> +					      aggr_idx, &ctx, NULL);
>  	}
>  }
>  
> -- 
> 2.45.2.1089.g2a221341d9-goog
> 
