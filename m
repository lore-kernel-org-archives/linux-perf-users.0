Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE62C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 224246102A
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbhHaTxu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:53:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241009AbhHaTxr (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:53:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 36CFD6108B;
        Tue, 31 Aug 2021 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630439571;
        bh=xNMN2u+WxIaMkCU2FbZtFtSdUVxdfHTvJJz6sJp62V0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gvz1NPpyTnZ3uclqKuiMGhsk9g3YiKbrHAaH89MLILtmJMA9+T78PY33gyOWC0Wii
         b3/Ju0NFxf1LHBbtThBSwmnpcsFoXsGoHvtpBdUpkRxtXnzD7dolMAGckDy9mvPtmt
         yqqI123QuNFWRnpuV58AAhq/uBgwgLajmUIQ6biEzLLGjd0M9+RqMYUSH9g/2SWdzB
         WlNAvxahwweui4Lt1JpFA7ALfMQoYXwjpJ0LSly0f2WEW6c7JGLH4i0l8//fksHLd8
         OW6aBddmlVPVXNlQBic+eHqcrLagxcOEFl+mroJnVGC1fxNOhB6eY8YAB/qSzWBGYa
         57jB3BB3AHn0w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 083AB4007E; Tue, 31 Aug 2021 16:52:49 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:52:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 24/37] perf evsel: handle precise_ip fallback in
 evsel__open_cpu
Message-ID: <YS6IkHuMDIGuOzO7@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <74208c433d2024a6c4af9c0b140b54ed6b5ea810.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74208c433d2024a6c4af9c0b140b54ed6b5ea810.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:30AM +0200, Riccardo Mancini escreveu:
> This is another patch in the effort to separate the fallback mechanisms
> from the open itself.
> 
> In case of precise_ip fallback, the original precise_ip will be stored
> in the evsel (it was stored in a local variable) and the open will be
> retried. Since the precise_ip fallback will be the first in the chain of
> fallbacks, there should be no functional change with this patch.

Thanks, looks ok, applied.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 59 ++++++++++++++++++-----------------------
>  tools/perf/util/evsel.h |  2 ++
>  2 files changed, 28 insertions(+), 33 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 3e556afed8dd396c..2e95416b8320c6b9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1709,42 +1709,29 @@ static void display_attr(struct perf_event_attr *attr)
>  	}
>  }
>  
> -static int perf_event_open(struct evsel *evsel,
> -			   pid_t pid, int cpu, int group_fd)
> +bool evsel__precise_ip_fallback(struct evsel *evsel)
>  {
> -	int precise_ip = evsel->core.attr.precise_ip;
> -	int fd;
> -
> -	while (1) {
> -		pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
> -			  pid, cpu, group_fd, evsel->open_flags);
> -
> -		fd = sys_perf_event_open(&evsel->core.attr, pid, cpu, group_fd, evsel->open_flags);
> -		if (fd >= 0)
> -			break;
> -
> -		/* Do not try less precise if not requested. */
> -		if (!evsel->precise_max)
> -			break;
> -
> -		/*
> -		 * We tried all the precise_ip values, and it's
> -		 * still failing, so leave it to standard fallback.
> -		 */
> -		if (!evsel->core.attr.precise_ip) {
> -			evsel->core.attr.precise_ip = precise_ip;
> -			break;
> -		}
> +	/* Do not try less precise if not requested. */
> +	if (!evsel->precise_max)
> +		return false;
>  
> -		pr_debug2_peo("\nsys_perf_event_open failed, error %d\n", -ENOTSUP);
> -		evsel->core.attr.precise_ip--;
> -		pr_debug2_peo("decreasing precise_ip by one (%d)\n", evsel->core.attr.precise_ip);
> -		display_attr(&evsel->core.attr);
> +	/*
> +	 * We tried all the precise_ip values, and it's
> +	 * still failing, so leave it to standard fallback.
> +	 */
> +	if (!evsel->core.attr.precise_ip) {
> +		evsel->core.attr.precise_ip = evsel->precise_ip_original;
> +		return false;
>  	}
>  
> -	return fd;
> -}
> +	if (!evsel->precise_ip_original)
> +		evsel->precise_ip_original = evsel->core.attr.precise_ip;
>  
> +	evsel->core.attr.precise_ip--;
> +	pr_debug2_peo("decreasing precise_ip by one (%d)\n", evsel->core.attr.precise_ip);
> +	display_attr(&evsel->core.attr);
> +	return true;
> +}
>  
>  static struct perf_cpu_map *empty_cpu_map;
>  static struct perf_thread_map *empty_thread_map;
> @@ -2004,8 +1991,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  
>  			test_attr__ready();
>  
> -			fd = perf_event_open(evsel, pid, cpus->map[cpu],
> -					     group_fd);
> +			pr_debug2_peo("sys_perf_event_open: pid %d  cpu %d  group_fd %d  flags %#lx",
> +				pid, cpus->map[cpu], group_fd, evsel->open_flags);
> +
> +			fd = sys_perf_event_open(&evsel->core.attr, pid, cpus->map[cpu],
> +						group_fd, evsel->open_flags);
>  
>  			FD(evsel, cpu, thread) = fd;
>  
> @@ -2058,6 +2048,9 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	return 0;
>  
>  try_fallback:
> +	if (evsel__precise_ip_fallback(evsel))
> +		goto retry_open;
> +
>  	if (evsel__ignore_missing_thread(evsel, cpus->nr, cpu, threads, thread, err)) {
>  		/* We just removed 1 thread, so lower the upper nthreads limit. */
>  		nthreads--;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 661d2677a19b6248..0a245afab2d87d74 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -150,6 +150,7 @@ struct evsel {
>  		struct bperf_follower_bpf *follower_skel;
>  	};
>  	unsigned long		open_flags;
> +	int			precise_ip_original;
>  };
>  
>  struct perf_missing_features {
> @@ -297,6 +298,7 @@ bool evsel__ignore_missing_thread(struct evsel *evsel,
>  				  int nr_cpus, int cpu,
>  				  struct perf_thread_map *threads,
>  				  int thread, int err);
> +bool evsel__precise_ip_fallback(struct evsel *evsel);
>  
>  struct perf_sample;
>  
> -- 
> 2.31.1

-- 

- Arnaldo
