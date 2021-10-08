Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C54FC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 14:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F21460F5C
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Oct 2021 14:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhJHOkZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 8 Oct 2021 10:40:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:46992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229756AbhJHOkY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 8 Oct 2021 10:40:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0585F60EB6;
        Fri,  8 Oct 2021 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633703909;
        bh=sWrfbFTY7cx1134BJRPVHEJpmaXkRzVNn6Kio4zNSUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3PIfTAh2sLIVyWs1OvWeV68fHTS8b1OS59f5xXLGU1APEhkZyhcK/g0BfkkYdxAq
         E1UCre2ZayXXeQ0QYt4kJeG1aYuTJMa4uE1oGuxgOEcOonPxjd+RC2mrXChMv9Ina6
         XoU9hDg9KouiHTp0o5Sq7Lpas/eFusWYL7bAQmxZFuqZJ4a0IGzOF5JwbyCmtiDMoU
         sYi+2dYThtF/8o3X4j6IFydHtZ4mxtWytk5JBZzlVq+CkGgYuz/sYV0PBa2xoLHTPT
         fSsHnPM5Vct/OD9wYj5RLKerHZvZ5scFtOdpcwZ6/AGYB44CCv9Oq/inKCziF7LjiN
         ZXr7jC5Hhmapw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FBAF410A1; Fri,  8 Oct 2021 11:38:26 -0300 (-03)
Date:   Fri, 8 Oct 2021 11:38:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 03/37] perf evlist: replace evsel__cpu_iter*
 functions with evsel__find_cpu()
Message-ID: <YWBX4slh2U7yNahE@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <5bfe13dd0985611285bb697987816ddc36e93e76.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bfe13dd0985611285bb697987816ddc36e93e76.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:09AM +0200, Riccardo Mancini escreveu:
> Commit a8cbe40fe9f4ba49 ("perf evsel: Add iterator to iterate over events
> ordered by CPU") introduced an iterator for evsel.core.cpus inside evsel
> which is used to iterate over evlist one CPU at a time.
> 
> However, this solution is hacky since it involves a mutable state in the
> evsel which is supposed to be unmodified during iteration.
> Sice checking that a CPU is within the evsel can be done quickly in
> O(logn) time, this patch replaces the aforementioned iterator with a
> simple check.

Andi, can you take a look at this and provide your Reviewed-by, please?

- Arnaldo
 
> Cc: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/builtin-stat.c | 24 +++++++++--------
>  tools/perf/util/evlist.c  | 54 +++++++++++----------------------------
>  tools/perf/util/evlist.h  |  5 +---
>  tools/perf/util/evsel.h   |  1 -
>  4 files changed, 30 insertions(+), 54 deletions(-)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 84de61795e67bbb9..62dcc001c8f0a78b 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -407,7 +407,7 @@ static int read_affinity_counters(struct timespec *rs)
>  {
>  	struct evsel *counter;
>  	struct affinity affinity;
> -	int i, ncpus, cpu;
> +	int i, ncpus, cpu, cpu_idx;
>  
>  	if (all_counters_use_bpf)
>  		return 0;
> @@ -424,13 +424,14 @@ static int read_affinity_counters(struct timespec *rs)
>  		affinity__set(&affinity, cpu);
>  
>  		evlist__for_each_entry(evsel_list, counter) {
> -			if (evsel__cpu_iter_skip(counter, cpu))
> +			cpu_idx = evsel__find_cpu(counter, cpu);
> +			if (cpu_idx < 0)
>  				continue;
>  			if (evsel__is_bpf(counter))
>  				continue;
>  			if (!counter->err) {
>  				counter->err = read_counter_cpu(counter, rs,
> -								counter->cpu_iter - 1);
> +								cpu_idx);
>  			}
>  		}
>  	}
> @@ -789,7 +790,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  	const bool forks = (argc > 0);
>  	bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
>  	struct affinity affinity;
> -	int i, cpu, err;
> +	int i, cpu, cpu_idx, err;
>  	bool second_pass = false;
>  
>  	if (forks) {
> @@ -823,7 +824,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  		affinity__set(&affinity, cpu);
>  
>  		evlist__for_each_entry(evsel_list, counter) {
> -			if (evsel__cpu_iter_skip(counter, cpu))
> +			cpu_idx = evsel__find_cpu(counter, cpu);
> +			if (cpu_idx < 0)
>  				continue;
>  			if (counter->reset_group || counter->errored)
>  				continue;
> @@ -831,7 +833,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  				continue;
>  try_again:
>  			if (create_perf_stat_counter(counter, &stat_config, &target,
> -						     counter->cpu_iter - 1) < 0) {
> +						     cpu_idx) < 0) {
>  
>  				/*
>  				 * Weak group failed. We cannot just undo this here
> @@ -877,22 +879,24 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>  			evlist__for_each_entry(evsel_list, counter) {
>  				if (!counter->reset_group && !counter->errored)
>  					continue;
> -				if (evsel__cpu_iter_skip_no_inc(counter, cpu))
> +				cpu_idx = evsel__find_cpu(counter, cpu);
> +				if (cpu_idx < 0)
>  					continue;
> -				perf_evsel__close_cpu(&counter->core, counter->cpu_iter);
> +				perf_evsel__close_cpu(&counter->core, cpu_idx);
>  			}
>  			/* Now reopen weak */
>  			evlist__for_each_entry(evsel_list, counter) {
>  				if (!counter->reset_group && !counter->errored)
>  					continue;
> -				if (evsel__cpu_iter_skip(counter, cpu))
> +				cpu_idx = evsel__find_cpu(counter, cpu);
> +				if (cpu_idx < 0)
>  					continue;
>  				if (!counter->reset_group)
>  					continue;
>  try_again_reset:
>  				pr_debug2("reopening weak %s\n", evsel__name(counter));
>  				if (create_perf_stat_counter(counter, &stat_config, &target,
> -							     counter->cpu_iter - 1) < 0) {
> +							     cpu_idx) < 0) {
>  
>  					switch (stat_handle_error(counter)) {
>  					case COUNTER_FATAL:
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 47581a237c7a7848..3d55d9a53b9f4875 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -341,36 +341,9 @@ static int evlist__nr_threads(struct evlist *evlist, struct evsel *evsel)
>  		return perf_thread_map__nr(evlist->core.threads);
>  }
>  
> -void evlist__cpu_iter_start(struct evlist *evlist)
> +int evsel__find_cpu(struct evsel *ev, int cpu)
>  {
> -	struct evsel *pos;
> -
> -	/*
> -	 * Reset the per evsel cpu_iter. This is needed because
> -	 * each evsel's cpumap may have a different index space,
> -	 * and some operations need the index to modify
> -	 * the FD xyarray (e.g. open, close)
> -	 */
> -	evlist__for_each_entry(evlist, pos)
> -		pos->cpu_iter = 0;
> -}
> -
> -bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu)
> -{
> -	if (ev->cpu_iter >= ev->core.cpus->nr)
> -		return true;
> -	if (cpu >= 0 && ev->core.cpus->map[ev->cpu_iter] != cpu)
> -		return true;
> -	return false;
> -}
> -
> -bool evsel__cpu_iter_skip(struct evsel *ev, int cpu)
> -{
> -	if (!evsel__cpu_iter_skip_no_inc(ev, cpu)) {
> -		ev->cpu_iter++;
> -		return false;
> -	}
> -	return true;
> +	return perf_cpu_map__idx(ev->core.cpus, cpu);
>  }
>  
>  static int evsel__strcmp(struct evsel *pos, char *evsel_name)
> @@ -400,7 +373,7 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  {
>  	struct evsel *pos;
>  	struct affinity affinity;
> -	int cpu, i, imm = 0;
> +	int cpu, i, imm = 0, cpu_idx;
>  	bool has_imm = false;
>  
>  	if (affinity__setup(&affinity) < 0)
> @@ -414,7 +387,8 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  			evlist__for_each_entry(evlist, pos) {
>  				if (evsel__strcmp(pos, evsel_name))
>  					continue;
> -				if (evsel__cpu_iter_skip(pos, cpu))
> +				cpu_idx = evsel__find_cpu(pos, cpu);
> +				if (cpu_idx < 0)
>  					continue;
>  				if (pos->disabled || !evsel__is_group_leader(pos) || !pos->core.fd)
>  					continue;
> @@ -422,7 +396,7 @@ static void __evlist__disable(struct evlist *evlist, char *evsel_name)
>  					has_imm = true;
>  				if (pos->immediate != imm)
>  					continue;
> -				evsel__disable_cpu(pos, pos->cpu_iter - 1);
> +				evsel__disable_cpu(pos, cpu_idx);
>  			}
>  		}
>  		if (!has_imm)
> @@ -462,7 +436,7 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>  {
>  	struct evsel *pos;
>  	struct affinity affinity;
> -	int cpu, i;
> +	int cpu, i, cpu_idx;
>  
>  	if (affinity__setup(&affinity) < 0)
>  		return;
> @@ -473,11 +447,12 @@ static void __evlist__enable(struct evlist *evlist, char *evsel_name)
>  		evlist__for_each_entry(evlist, pos) {
>  			if (evsel__strcmp(pos, evsel_name))
>  				continue;
> -			if (evsel__cpu_iter_skip(pos, cpu))
> +			cpu_idx = evsel__find_cpu(pos, cpu);
> +			if (cpu_idx < 0)
>  				continue;
>  			if (!evsel__is_group_leader(pos) || !pos->core.fd)
>  				continue;
> -			evsel__enable_cpu(pos, pos->cpu_iter - 1);
> +			evsel__enable_cpu(pos, cpu_idx);
>  		}
>  	}
>  	affinity__cleanup(&affinity);
> @@ -1264,7 +1239,7 @@ void evlist__close(struct evlist *evlist)
>  {
>  	struct evsel *evsel;
>  	struct affinity affinity;
> -	int cpu, i;
> +	int cpu, i, cpu_idx;
>  
>  	/*
>  	 * With perf record core.cpus is usually NULL.
> @@ -1282,9 +1257,10 @@ void evlist__close(struct evlist *evlist)
>  		affinity__set(&affinity, cpu);
>  
>  		evlist__for_each_entry_reverse(evlist, evsel) {
> -			if (evsel__cpu_iter_skip(evsel, cpu))
> -			    continue;
> -			perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
> +			cpu_idx = evsel__find_cpu(evsel, cpu);
> +			if (cpu_idx < 0)
> +				continue;
> +			perf_evsel__close_cpu(&evsel->core, cpu_idx);
>  		}
>  	}
>  	affinity__cleanup(&affinity);
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index 5c22383489ae4905..fde893170c7ba6d2 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -310,15 +310,12 @@ void evlist__to_front(struct evlist *evlist, struct evsel *move_evsel);
>  	__evlist__for_each_entry_safe(&(evlist)->core.entries, tmp, evsel)
>  
>  #define evlist__for_each_cpu(evlist, index, cpu)	\
> -	evlist__cpu_iter_start(evlist);			\
>  	perf_cpu_map__for_each_cpu (cpu, index, (evlist)->core.all_cpus)
>  
>  struct evsel *evlist__get_tracking_event(struct evlist *evlist);
>  void evlist__set_tracking_event(struct evlist *evlist, struct evsel *tracking_evsel);
>  
> -void evlist__cpu_iter_start(struct evlist *evlist);
> -bool evsel__cpu_iter_skip(struct evsel *ev, int cpu);
> -bool evsel__cpu_iter_skip_no_inc(struct evsel *ev, int cpu);
> +int evsel__find_cpu(struct evsel *ev, int cpu);
>  
>  struct evsel *evlist__find_evsel_by_str(struct evlist *evlist, const char *str);
>  
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 80383096d51c5f00..eabccce406886320 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -119,7 +119,6 @@ struct evsel {
>  	bool			errored;
>  	struct hashmap		*per_pkg_mask;
>  	int			err;
> -	int			cpu_iter;
>  	struct {
>  		evsel__sb_cb_t	*cb;
>  		void		*data;
> -- 
> 2.31.1

-- 

- Arnaldo
