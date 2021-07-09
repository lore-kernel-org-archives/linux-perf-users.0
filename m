Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60750C07E99
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 17:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D7F613CA
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jul 2021 17:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhGISCd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jul 2021 14:02:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229459AbhGISCc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jul 2021 14:02:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3E7761283;
        Fri,  9 Jul 2021 17:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625853589;
        bh=f5Fvxbr/aBQAphMEZtDhZtTNqhCI3uozp6rs0YUYld0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iypEH2VRyJy22TmGmEQULP1P7HV2JE46MLZoAIc/0TZvYe4rxng5axBz9iHF9mXL+
         Z0jDjor+anrQya7dvSbdA8GCxBE3sJ7ilfdfoOna/UXxpmnnXEuQAXw70meJfrWs1k
         U1kJPvsD2/lMq1Q6xYUZnWplgSe2731yfwBKTLyug9h/vpv+a/g1jN7TqTLEEoMdCQ
         xVSCsCTA15f6QitqvG2hKHwpy0xVUE2xLpHIo1pv6JklTmDPzOqUJPpTpxSwSCPkjZ
         q8rAJvYnYyQeNP6fvVSY3v3QT3+JJYRo+z+aaxmCJCDbZmbFXep3zueZu0Q/nsby8j
         m4zLWfYMsbJLQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 97D2740B1A; Fri,  9 Jul 2021 14:59:46 -0300 (-03)
Date:   Fri, 9 Jul 2021 14:59:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 7/7] libperf: Add tests for perf_evlist__set_leader
 function
Message-ID: <YOiOkgTnd8NC/k+P@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-8-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706151704.73662-8-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 06, 2021 at 05:17:04PM +0200, Jiri Olsa escreveu:
> Adding test for newly added perf_evlist__set_leader function.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/tests/test-evlist.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
> index 7435529fb21c..c67c83399170 100644
> --- a/tools/lib/perf/tests/test-evlist.c
> +++ b/tools/lib/perf/tests/test-evlist.c
> @@ -19,6 +19,7 @@
>  #include <internal/tests.h>
>  #include <api/fs/fs.h>
>  #include "tests.h"
> +#include <internal/evsel.h>
>  
>  static int libperf_print(enum libperf_print_level level,
>  			 const char *fmt, va_list ap)
> @@ -30,7 +31,7 @@ static int test_stat_cpu(void)
>  {
>  	struct perf_cpu_map *cpus;
>  	struct perf_evlist *evlist;
> -	struct perf_evsel *evsel;
> +	struct perf_evsel *evsel, *leader;
>  	struct perf_event_attr attr1 = {
>  		.type	= PERF_TYPE_SOFTWARE,
>  		.config	= PERF_COUNT_SW_CPU_CLOCK,
> @@ -47,7 +48,7 @@ static int test_stat_cpu(void)
>  	evlist = perf_evlist__new();
>  	__T("failed to create evlist", evlist);
>  
> -	evsel = perf_evsel__new(&attr1);
> +	evsel = leader = perf_evsel__new(&attr1);
>  	__T("failed to create evsel1", evsel);
>  
>  	perf_evlist__add(evlist, evsel);
> @@ -57,6 +58,10 @@ static int test_stat_cpu(void)
>  
>  	perf_evlist__add(evlist, evsel);
>  
> +	perf_evlist__set_leader(evlist);
> +	__T("failed to set leader", leader->leader == leader);
> +	__T("failed to set leader", evsel->leader  == leader);
> +
>  	perf_evlist__set_maps(evlist, cpus, NULL);
>  
>  	err = perf_evlist__open(evlist);
> @@ -85,7 +90,7 @@ static int test_stat_thread(void)
>  	struct perf_counts_values counts = { .val = 0 };
>  	struct perf_thread_map *threads;
>  	struct perf_evlist *evlist;
> -	struct perf_evsel *evsel;
> +	struct perf_evsel *evsel, *leader;
>  	struct perf_event_attr attr1 = {
>  		.type	= PERF_TYPE_SOFTWARE,
>  		.config	= PERF_COUNT_SW_CPU_CLOCK,
> @@ -104,7 +109,7 @@ static int test_stat_thread(void)
>  	evlist = perf_evlist__new();
>  	__T("failed to create evlist", evlist);
>  
> -	evsel = perf_evsel__new(&attr1);
> +	evsel = leader = perf_evsel__new(&attr1);
>  	__T("failed to create evsel1", evsel);
>  
>  	perf_evlist__add(evlist, evsel);
> @@ -114,6 +119,10 @@ static int test_stat_thread(void)
>  
>  	perf_evlist__add(evlist, evsel);
>  
> +	perf_evlist__set_leader(evlist);
> +	__T("failed to set leader", leader->leader == leader);
> +	__T("failed to set leader", evsel->leader  == leader);
> +
>  	perf_evlist__set_maps(evlist, NULL, threads);
>  
>  	err = perf_evlist__open(evlist);
> @@ -136,7 +145,7 @@ static int test_stat_thread_enable(void)
>  	struct perf_counts_values counts = { .val = 0 };
>  	struct perf_thread_map *threads;
>  	struct perf_evlist *evlist;
> -	struct perf_evsel *evsel;
> +	struct perf_evsel *evsel, *leader;
>  	struct perf_event_attr attr1 = {
>  		.type	  = PERF_TYPE_SOFTWARE,
>  		.config	  = PERF_COUNT_SW_CPU_CLOCK,
> @@ -157,7 +166,7 @@ static int test_stat_thread_enable(void)
>  	evlist = perf_evlist__new();
>  	__T("failed to create evlist", evlist);
>  
> -	evsel = perf_evsel__new(&attr1);
> +	evsel = leader = perf_evsel__new(&attr1);
>  	__T("failed to create evsel1", evsel);
>  
>  	perf_evlist__add(evlist, evsel);
> @@ -167,6 +176,10 @@ static int test_stat_thread_enable(void)
>  
>  	perf_evlist__add(evlist, evsel);
>  
> +	perf_evlist__set_leader(evlist);
> +	__T("failed to set leader", leader->leader == leader);
> +	__T("failed to set leader", evsel->leader  == leader);
> +
>  	perf_evlist__set_maps(evlist, NULL, threads);
>  
>  	err = perf_evlist__open(evlist);
> @@ -254,6 +267,7 @@ static int test_mmap_thread(void)
>  
>  	evsel = perf_evsel__new(&attr);
>  	__T("failed to create evsel1", evsel);
> +	__T("failed to set leader", evsel->leader == evsel);
>  
>  	perf_evlist__add(evlist, evsel);
>  
> @@ -339,6 +353,7 @@ static int test_mmap_cpus(void)
>  
>  	evsel = perf_evsel__new(&attr);
>  	__T("failed to create evsel1", evsel);
> +	__T("failed to set leader", evsel->leader == evsel);
>  
>  	perf_evlist__add(evlist, evsel);
>  
> -- 
> 2.31.1
> 

-- 

- Arnaldo
