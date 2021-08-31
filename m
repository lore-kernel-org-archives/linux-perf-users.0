Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC42C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4332D61057
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhHaTcC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:32:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234139AbhHaTcB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:32:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0F6260F91;
        Tue, 31 Aug 2021 19:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630438266;
        bh=NFwDSnpklMxKC8EPBXBrgV0olmRU2p/XdOiop04+OXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmEuKQQCj4tfmsYyd5IsPjxYsRUf3ApRsmYdwQ6q3/qUi76aR0LmiwGmXuyVQPjdB
         CNGvHoIM5ZEqHo8f9lc31czbFDwjIY01Chxsghw6C9Q1LfFs/BUofJrztjHzJVun+j
         0Niqp6lNuaGceUIjD66H5UXzQ+OdNFltfUTCO+EmkcjcwyDFpeRYsN6lQTu1z3SfYw
         P3inIZDD0vBMtQSlToI4yXOvx228cHUkBtjLXLoa09050UQb3QIj9wOvAqkefAVeKu
         dokUAuH8DUqskf5u0K3XtWkXRxiKK0pRRVEiK4Kh1VFJqnTHwSwKjdLz1J4gRT0YPm
         tFM5+VinuW+BQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 720894007E; Tue, 31 Aug 2021 16:31:03 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:31:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 16/37] perf evsel: save open flags in evsel
Message-ID: <YS6Dd6lZoftrKGXl@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <d9f63159098e56fa518eecf25171d72e6f74df37.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9f63159098e56fa518eecf25171d72e6f74df37.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:22AM +0200, Riccardo Mancini escreveu:
> This patch caches the flags used in perf_event_open inside evsel, so
> that they can be set in __evsel__prepare_open (this will be useful
> in following patches, when the fallback mechanisms will be handled
> outside the open itself).
> This also optimizes the code, by not having to recompute them everytime.

Nice, thanks, applied, I'll make available what I have in tmp.perf/core
so that you can take a look before I push it all to Linus, this week.

- Arnaldo
 
> Since flags are now saved in evsel, the flags argument in
> perf_event_open is removed.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 24 ++++++++++++------------
>  tools/perf/util/evsel.h |  1 +
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index ddf324e2e17a0951..509a2970a94b3142 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1710,17 +1710,16 @@ static void display_attr(struct perf_event_attr *attr)
>  }
>  
>  static int perf_event_open(struct evsel *evsel,
> -			   pid_t pid, int cpu, int group_fd,
> -			   unsigned long flags)
> +			   pid_t pid, int cpu, int group_fd)
>  {
>  	int precise_ip = evsel->core.attr.precise_ip;
>  	int fd;
>  
>  	while (1) {
>  		pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
> -			  pid, cpu, group_fd, flags);
> +			  pid, cpu, group_fd, evsel->open_flags);
>  
> -		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, flags);
> +		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, evsel->open_flags);
>  		if (fd >= 0)
>  			break;
>  
> @@ -1788,6 +1787,10 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
>  		return -ENOMEM;
>  
> +	evsel->open_flags = PERF_FLAG_FD_CLOEXEC;
> +	if (evsel->cgrp)
> +		evsel->open_flags |= PERF_FLAG_PID_CGROUP;
> +
>  	return 0;
>  }
>  
> @@ -1796,7 +1799,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		int start_cpu, int end_cpu)
>  {
>  	int cpu, thread, nthreads;
> -	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
>  	int pid = -1, err, old_errno;
>  	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
>  
> @@ -1815,10 +1817,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	else
>  		nthreads = threads->nr;
>  
> -	if (evsel->cgrp) {
> -		flags |= PERF_FLAG_PID_CGROUP;
> +	if (evsel->cgrp)
>  		pid = evsel->cgrp->fd;
> -	}
>  
>  fallback_missing_features:
>  	if (perf_missing_features.weight_struct) {
> @@ -1832,7 +1832,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		evsel->core.attr.clockid = 0;
>  	}
>  	if (perf_missing_features.cloexec)
> -		flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
> +		evsel->open_flags &= ~(unsigned long)PERF_FLAG_FD_CLOEXEC;
>  	if (perf_missing_features.mmap2)
>  		evsel->core.attr.mmap2 = 0;
>  	if (perf_missing_features.exclude_guest)
> @@ -1866,7 +1866,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  			test_attr__ready();
>  
>  			fd = perf_event_open(evsel, pid, cpus->map[cpu],
> -					     group_fd, flags);
> +					     group_fd);
>  
>  			FD(evsel, cpu, thread) = fd;
>  
> @@ -1874,7 +1874,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			if (unlikely(test_attr__enabled)) {
>  				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
> -						fd, group_fd, flags);
> +						fd, group_fd, evsel->open_flags);
>  			}
>  
>  			if (fd < 0) {
> @@ -2012,7 +2012,7 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		perf_missing_features.clockid = true;
>  		pr_debug2_peo("switching off use_clockid\n");
>  		goto fallback_missing_features;
> -	} else if (!perf_missing_features.cloexec && (flags & PERF_FLAG_FD_CLOEXEC)) {
> +	} else if (!perf_missing_features.cloexec && (evsel->open_flags & PERF_FLAG_FD_CLOEXEC)) {
>  		perf_missing_features.cloexec = true;
>  		pr_debug2_peo("switching off cloexec flag\n");
>  		goto fallback_missing_features;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index eabccce406886320..1c0057e80d080f2f 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -149,6 +149,7 @@ struct evsel {
>  		struct bperf_leader_bpf *leader_skel;
>  		struct bperf_follower_bpf *follower_skel;
>  	};
> +	unsigned long		open_flags;
>  };
>  
>  struct perf_missing_features {
> -- 
> 2.31.1

-- 

- Arnaldo
