Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DCAC432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB496102A
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234715AbhHaTpv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232016AbhHaTpu (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:45:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAE2160F6C;
        Tue, 31 Aug 2021 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439095;
        bh=lTUh2DVu0SDf71xXMtCahB5YXku0JQOpZqCnumJpauU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PSpUpSaeyStxnRc3bwUi/cP1kzByp2fzzq47ippka8ErdVWlgjFDVnGjGw3XKJp1U
         QU2044pyd9KDZUizfIKBMLrzVX7yAJiN2MfFDh1ltSyZWlINsQHaSuFnqfwpeDzNnk
         6i7c7fesST/LydueI+UT6px2LLUgVRqrAqboPu1z+JRwvo/S0YisbFEAV2MBiVyJlz
         C6n8xY69p+k1YmrDGwnsUwod4Gp/D37TzvnHaDqtKfrLCYsJ7xuSKysb3zuq3wH0ib
         kjH9XfK80p3Laq4CAPK8PNYAxy/7SnQQ1WtC5hDzd1CzsbwthBYsHjlTyPWyjEawhg
         DBAvR+1pNsu+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 858CF4007E; Tue, 31 Aug 2021 16:44:52 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:44:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 21/37] perf evsel: move ignore_missing_thread to
 fallback code
Message-ID: <YS6GtNjIcyA4r8O8@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <4eca51443c786baaf6811b7cd8e73aafd97f7606.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eca51443c786baaf6811b7cd8e73aafd97f7606.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:27AM +0200, Riccardo Mancini escreveu:
> This patch moves ignore_missing_thread outside the perf_event_open loop.
> Doing so, we need to move the retry_open flag a few places higher, with
> minimal impact. Furthermore, thread need not be decreased since it won't
> get increased by the for loop (since we're jumping back inside), but we
> need to check that the nthreads decrease didn't put thread out of range.
> 
> The goal is to have fallbacks handled in one place only, since in the
> future parallel code, these would be handled separately.

Thanks, looks ok, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 29 +++++++++++++----------------
>  tools/perf/util/evsel.h |  5 +++++
>  2 files changed, 18 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 916930ea31450265..a1a88607fd59efcb 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1656,7 +1656,7 @@ static int update_fds(struct evsel *evsel,
>  	return 0;
>  }
>  
> -static bool ignore_missing_thread(struct evsel *evsel,
> +bool evsel__ignore_missing_thread(struct evsel *evsel,
>  				  int nr_cpus, int cpu,
>  				  struct perf_thread_map *threads,
>  				  int thread, int err)
> @@ -1993,12 +1993,15 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  		for (thread = 0; thread < nthreads; thread++) {
>  			int fd, group_fd;
> +retry_open:
> +			if (thread >= nthreads)
> +				break;
>  
>  			if (!evsel->cgrp && !evsel->core.system_wide)
>  				pid = perf_thread_map__pid(threads, thread);
>  
>  			group_fd = get_group_fd(evsel, cpu, thread);
> -retry_open:
> +
>  			test_attr__ready();
>  
>  			fd = perf_event_open(evsel, pid, cpus->map[cpu],
> @@ -2016,20 +2019,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  			if (fd < 0) {
>  				err = -errno;
>  
> -				if (ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
> -					/*
> -					 * We just removed 1 thread, so take a step
> -					 * back on thread index and lower the upper
> -					 * nthreads limit.
> -					 */
> -					nthreads--;
> -					thread--;
> -
> -					/* ... and pretend like nothing have happened. */
> -					err = 0;
> -					continue;
> -				}
> -
>  				pr_debug2_peo("\nsys_perf_event_open failed, error %d\n",
>  					  err);
>  				goto try_fallback;
> @@ -2069,6 +2058,14 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	return 0;
>  
>  try_fallback:
> +	if (evsel__ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
> +		/* We just removed 1 thread, so lower the upper nthreads limit. */
> +		nthreads--;
> +
> +		/* ... and pretend like nothing have happened. */
> +		err = 0;
> +		goto retry_open;
> +	}
>  	/*
>  	 * perf stat needs between 5 and 22 fds per CPU. When we run out
>  	 * of them try to increase the limits.
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index bf9abd9a5cbf9852..661d2677a19b6248 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -293,6 +293,11 @@ bool evsel__detect_missing_features(struct evsel *evsel);
>  enum rlimit_action { NO_CHANGE, SET_TO_MAX, INCREASED_MAX };
>  bool evsel__increase_rlimit(enum rlimit_action *set_rlimit);
>  
> +bool evsel__ignore_missing_thread(struct evsel *evsel,
> +				  int nr_cpus, int cpu,
> +				  struct perf_thread_map *threads,
> +				  int thread, int err);
> +
>  struct perf_sample;
>  
>  void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
> -- 
> 2.31.1

-- 

- Arnaldo
