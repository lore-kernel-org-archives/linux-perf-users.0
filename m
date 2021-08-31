Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B680C432BE
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304BE60F91
	for <linux-perf-users@archiver.kernel.org>; Tue, 31 Aug 2021 19:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbhHaTgK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 15:36:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240895AbhHaTgD (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 15:36:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E479661059;
        Tue, 31 Aug 2021 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630438508;
        bh=lJl812jWZ9pp2L8z9pIZmOr/kh8QoAiHqxxqA2KL4To=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=neZ6ScwxRqrUqfakfaz1ENR+ujv8fVP+pl58AfTYWRRiXMVRDZwhDBB/HXYyw2E0b
         L74BHdggQHv6No/mtajI6bpihIe4mWs7AUgGZy7egETQEfEIShWcV/i0J2fAdU3KPx
         grw5oA6BWoYuTU4nxOq0FicgX7A7C37/tMKcrjvaj0/Lq6k5qXyp/3vbONv30whu90
         5e/4H8FoVmLDPDSrKodXDHftDRJkEQaFEsIVueUIHyXTEhS+SHuXS8SCXqYubmHldT
         M4sWhTzQZarzdnv0fn76DyAi8MSPZadZN7qG3grX0AxsmEtxkuhDfWTDemdqZMj2F9
         twhdvLAptB52g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C47304007E; Tue, 31 Aug 2021 16:35:04 -0300 (-03)
Date:   Tue, 31 Aug 2021 16:35:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 17/37] perf evsel: separate missing feature
 disabling from evsel__open_cpu
Message-ID: <YS6EaLuwquCwiWqX@kernel.org>
References: <cover.1629490974.git.rickyman7@gmail.com>
 <48138bd2932646dde315505da733c2ca635ad2ee.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48138bd2932646dde315505da733c2ca635ad2ee.1629490974.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Aug 21, 2021 at 11:19:23AM +0200, Riccardo Mancini escreveu:
> This is a preparatory patch for the following patches with the goal to
> separate in evlist__open_cpu the actual opening, which could be
> performed in parallel, from the existing fallback mechanisms, which
> should be handled sequentially.
> 
> This patch separates the disabling of missing features from
> evlist__open_cpu into a new function evsel__disable_missing_features.


Thanks, applied as the end result is the same.

- Arnaldo

 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/evsel.c | 57 ++++++++++++++++++++++-------------------
>  1 file changed, 31 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 509a2970a94b3142..f0bc89f743915800 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1794,33 +1794,8 @@ static int __evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
>  	return 0;
>  }
>  
> -static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> -		struct perf_thread_map *threads,
> -		int start_cpu, int end_cpu)
> +static void evsel__disable_missing_features(struct evsel *evsel)
>  {
> -	int cpu, thread, nthreads;
> -	int pid = -1, err, old_errno;
> -	enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit = NO_CHANGE;
> -
> -	err = __evsel__prepare_open(evsel, cpus, threads);
> -	if (err)
> -		return err;
> -
> -	if (cpus == NULL)
> -		cpus = empty_cpu_map;
> -
> -	if (threads == NULL)
> -		threads = empty_thread_map;
> -
> -	if (evsel->core.system_wide)
> -		nthreads = 1;
> -	else
> -		nthreads = threads->nr;
> -
> -	if (evsel->cgrp)
> -		pid = evsel->cgrp->fd;
> -
> -fallback_missing_features:
>  	if (perf_missing_features.weight_struct) {
>  		evsel__set_sample_bit(evsel, WEIGHT);
>  		evsel__reset_sample_bit(evsel, WEIGHT_STRUCT);
> @@ -1850,6 +1825,36 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
>  		evsel->core.attr.branch_sample_type &= ~PERF_SAMPLE_BRANCH_HW_INDEX;
>  	if (perf_missing_features.sample_id_all)
>  		evsel->core.attr.sample_id_all = 0;
> +}
> +
> +static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
> +		struct perf_thread_map *threads,
> +		int start_cpu, int end_cpu)
> +{
> +	int cpu, thread, nthreads;
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
> +	if (evsel->cgrp)
> +		pid = evsel->cgrp->fd;
> +
> +fallback_missing_features:
> +	evsel__disable_missing_features(evsel);
>  
>  	display_attr(&evsel->core.attr);
>  
> -- 
> 2.31.1

-- 

- Arnaldo
