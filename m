Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D46C43214
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC5A61074
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbhHaT2j (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:28:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240813AbhHaT2h (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:28:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05A5B61053;
        Tue, 31 Aug 2021 19:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630438062;
        bh=1hz+rLyf4P3BZ3OMt88NDe8EDolggy1OIHQDfSHHPc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Drl5/ExfkJPnxheBzwCx81pEtdrxwdXzNuBv+1v2hTUn68ldoOmV22x/cSICSOb3y
         CvE7ijrYwvZEzK3I9ApsBqvcl054Ej0X0szhXsp879WYoQM8eMzpEa0XMzjHnmPDwq
         lNVkspNiciUAUcbCs8ZmAy+gQr6DUbq372RZHazVwcmgLJfDJ2QbEdFIUs+b3IHtVp
         hyF7v+J2jNvmtpXyg7p0EKlnMXgftfLe7HZ/QIzaFEsg4LObcEBQng7ExAuc3A4wo/
         0KgOA4kyJg2VS4FABGfJrgKJRAlfWQUKKmr0JIzzGe5omNEbU7XtyNbTrcd8vfzrT0
         C/rRWNbr1hFfQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D73E74007E; Tue, 31 Aug 2021 16:27:39 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:27:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 15/37] perf evsel: separate open preparation from
 open itself
Message-ID: <YS6Cqw8oHJ72zIRK@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <e14118b934c338dbbf68b8677f20d0d7dbf9359a.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e14118b934c338dbbf68b8677f20d0d7dbf9359a.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:21AM +0200, Riccardo Mancini escreveu:
> This is a preparatory patch for the following patches with the goal to
> separate in evlist__open_cpu the actual perf_event_open, which could be
> performed in parallel, from the existing fallback mechanisms, which
> should be handled sequentially.

Thanks, applied as the end result is equivalent and we erode this
patchkit a bit more.

- Arnaldo
 
> This patch separates the first lines of evsel__open_cpu into a new
> __evsel__prepare_open function.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 45 +++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 7b4bb3229a16524e..ddf324e2e17a0951 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1746,22 +1746,20 @@ static int perf_event_open(struct evsel *evsel,
>  	return fd;
>  }
>  
> -static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> -		struct perf_thread_map *threads,
> -		int start_cpu, int end_cpu)
> +
> +static struct perf_cpu_map *empty_cpu_map;
> +static struct perf_thread_map *empty_thread_map;
> +
> +static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
> +		struct perf_thread_map *threads)
>  {
> -	int cpu, thread, nthreads;
> -	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
> -	int pid = -1, err, old_errno;
> -	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
> +	int nthreads;
>  
>  	if ((perf_missing_features.write_backward && evsel->core.attr.write_backward) ||
>  	    (perf_missing_features.aux_output     && evsel->core.attr.aux_output))
>  		return -EINVAL;
>  
>  	if (cpus == NULL) {
> -		static struct perf_cpu_map *empty_cpu_map;
> -
>  		if (empty_cpu_map == NULL) {
>  			empty_cpu_map = perf_cpu_map__dummy_new();
>  			if (empty_cpu_map == NULL)
> @@ -1772,8 +1770,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	}
>  
>  	if (threads == NULL) {
> -		static struct perf_thread_map *empty_thread_map;
> -
>  		if (empty_thread_map == NULL) {
>  			empty_thread_map = thread_map__new_by_tid(-1);
>  			if (empty_thread_map == NULL)
> @@ -1792,6 +1788,33 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	    perf_evsel__alloc_fd(&evsel->core, cpus->nr, nthreads) < 0)
>  		return -ENOMEM;
>  
> +	return 0;
> +}
> +
> +static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> +		struct perf_thread_map *threads,
> +		int start_cpu, int end_cpu)
> +{
> +	int cpu, thread, nthreads;
> +	unsigned long flags = PERF_FLAG_FD_CLOEXEC;
> +	int pid = -1, err, old_errno;
> +	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
> +
> +	err = __evsel__prepare_open(evsel, cpus, threads);
> +	if (err)
> +		return err;
> +
> +	if (cpus == NULL)
> +		cpus = empty_cpu_map;
> +
> +	if (threads == NULL)
> +		threads = empty_thread_map;
> +
> +	if (evsel->core.system_wide)
> +		nthreads = 1;
> +	else
> +		nthreads = threads->nr;
> +
>  	if (evsel->cgrp) {
>  		flags |= PERF_FLAG_PID_CGROUP;
>  		pid = evsel->cgrp->fd;
> -- 
> 2.31.1

-- 

- Arnaldo
