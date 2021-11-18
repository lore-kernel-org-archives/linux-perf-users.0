Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507D7C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3340E61AE2
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Nov 2021 13:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhKRNWx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Nov 2021 08:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:57336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhKRNWx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Nov 2021 08:22:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A705361507;
        Thu, 18 Nov 2021 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637241593;
        bh=7Ej1eCyvMoykGQJV5L+TbSPMLFwDrFz5s3QKLNmBn6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk9e+0HaLrI+lKHoa+tljqOcc6BRaT2h2Z+lS0lIsyJsGHEEUKE4mVWaS36u7ZBAF
         36bznk66XQuGE3wyCxiUZv5/7dJomyM1E7u9GFdtRbEDGKH3Lt+RIAhj1K9QksFGGF
         ExiDaQI9XHjE5ic55eY+OCVs97qPgbTqKL5EIERC9n4fmwpiTijorHCdviJiYBLO4L
         MTmuQ5wto3mxK9tO232v9877GEHMD1TyHxfQe1y7Ty8UxpKsOmwB28QuDavSiuG7Kf
         XRCryErjTimNV94sJTbALEg63fvjt6mj5A2NOTTRGjCh/YH6NVWso1H0e4WxwCux60
         lYODt588uoMqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 90E2F4088E; Thu, 18 Nov 2021 10:19:50 -0300 (-03)
Date:   Thu, 18 Nov 2021 10:19:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf evsel: Fix memory leaks relating to unit
Message-ID: <YZZS9iNwvS6NGint@kernel.org>
References: <20211118084749.2191447-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118084749.2191447-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Nov 18, 2021 at 12:47:49AM -0800, Ian Rogers escreveu:
> unit may have a strdup pointer or be to a literal, consequently memory
> assocciated with it isn't freed. Change it so the unit is always strdup
> and so the memory can be safely freed. Fix related issue in
> perf_event__process_event_update for name and own_cpus. Leaks were
> spotted by leak sanitizer.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/event_update.c |  5 ++---
>  tools/perf/util/evsel.c         | 18 +++++++++---------
>  tools/perf/util/header.c        |  8 +++++---
>  tools/perf/util/parse-events.c  |  9 ++++++---
>  4 files changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
> index fbb68deba59f..d01532d40acb 100644
> --- a/tools/perf/tests/event_update.c
> +++ b/tools/perf/tests/event_update.c
> @@ -88,7 +88,6 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>  	struct evsel *evsel;
>  	struct event_name tmp;
>  	struct evlist *evlist = evlist__new_default();
> -	char *unit = strdup("KRAVA");
>  
>  	TEST_ASSERT_VAL("failed to get evlist", evlist);
>  
> @@ -99,7 +98,8 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>  
>  	perf_evlist__id_add(&evlist->core, &evsel->core, 0, 0, 123);
>  
> -	evsel->unit = unit;
> +	free((char *)evsel->unit);
> +	evsel->unit = strdup("KRAVA");
>  
>  	TEST_ASSERT_VAL("failed to synthesize attr update unit",
>  			!perf_event__synthesize_event_update_unit(NULL, evsel, process_event_unit));
> @@ -119,7 +119,6 @@ static int test__event_update(struct test_suite *test __maybe_unused, int subtes
>  	TEST_ASSERT_VAL("failed to synthesize attr update cpus",
>  			!perf_event__synthesize_event_update_cpus(&tmp.tool, evsel, process_event_cpus));
>  
> -	free(unit);
>  	evlist__delete(evlist);
>  	return 0;
>  }
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a59fb2ecb84e..ac0127be0459 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -241,7 +241,7 @@ void evsel__init(struct evsel *evsel,
>  {
>  	perf_evsel__init(&evsel->core, attr, idx);
>  	evsel->tracking	   = !idx;
> -	evsel->unit	   = "";
> +	evsel->unit	   = strdup("");
>  	evsel->scale	   = 1.0;
>  	evsel->max_events  = ULONG_MAX;
>  	evsel->evlist	   = NULL;
> @@ -276,13 +276,8 @@ struct evsel *evsel__new_idx(struct perf_event_attr *attr, int idx)
>  	}
>  
>  	if (evsel__is_clock(evsel)) {
> -		/*
> -		 * The evsel->unit points to static alias->unit
> -		 * so it's ok to use static string in here.
> -		 */
> -		static const char *unit = "msec";
> -
> -		evsel->unit = unit;
> +		free((char *)evsel->unit);
> +		evsel->unit = strdup("msec");
>  		evsel->scale = 1e-6;
>  	}
>  
> @@ -420,7 +415,11 @@ struct evsel *evsel__clone(struct evsel *orig)
>  
>  	evsel->max_events = orig->max_events;
>  	evsel->tool_event = orig->tool_event;
> -	evsel->unit = orig->unit;
> +	free((char *)evsel->unit);
> +	evsel->unit = strdup(orig->unit);
> +	if (evsel->unit == NULL)
> +		goto out_err;
> +
>  	evsel->scale = orig->scale;
>  	evsel->snapshot = orig->snapshot;
>  	evsel->per_pkg = orig->per_pkg;
> @@ -1441,6 +1440,7 @@ void evsel__exit(struct evsel *evsel)
>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
>  	zfree(&evsel->pmu_name);
> +	zfree(&evsel->unit);
>  	zfree(&evsel->metric_id);
>  	evsel__zero_per_pkg(evsel);
>  	hashmap__free(evsel->per_pkg_mask);
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index fda8d14c891f..79cce216727e 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -4257,9 +4257,11 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
>  
>  	switch (ev->type) {
>  	case PERF_EVENT_UPDATE__UNIT:
> +		free((char *)evsel->unit);
>  		evsel->unit = strdup(ev->data);
>  		break;
>  	case PERF_EVENT_UPDATE__NAME:
> +		free(evsel->name);
>  		evsel->name = strdup(ev->data);
>  		break;
>  	case PERF_EVENT_UPDATE__SCALE:
> @@ -4268,11 +4270,11 @@ int perf_event__process_event_update(struct perf_tool *tool __maybe_unused,
>  		break;
>  	case PERF_EVENT_UPDATE__CPUS:
>  		ev_cpus = (struct perf_record_event_update_cpus *)ev->data;
> -
>  		map = cpu_map__new_data(&ev_cpus->cpus);
> -		if (map)
> +		if (map) {
> +			perf_cpu_map__put(evsel->core.own_cpus);
>  			evsel->core.own_cpus = map;
> -		else
> +		} else
>  			pr_err("failed to get event_update cpus\n");
>  	default:
>  		break;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index a2f4c086986f..12d925a6d27f 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -402,8 +402,10 @@ static int add_event_tool(struct list_head *list, int *idx,
>  	if (!evsel)
>  		return -ENOMEM;
>  	evsel->tool_event = tool_event;
> -	if (tool_event == PERF_TOOL_DURATION_TIME)
> -		evsel->unit = "ns";
> +	if (tool_event == PERF_TOOL_DURATION_TIME) {
> +		free((char *)evsel->unit);
> +		evsel->unit = strdup("ns");
> +	}
>  	return 0;
>  }
>  
> @@ -1630,7 +1632,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  	if (parse_state->fake_pmu)
>  		return 0;
>  
> -	evsel->unit = info.unit;
> +	free((char *)evsel->unit);
> +	evsel->unit = strdup(info.unit);
>  	evsel->scale = info.scale;
>  	evsel->per_pkg = info.per_pkg;
>  	evsel->snapshot = info.snapshot;
> -- 
> 2.34.0.rc1.387.gb447b232ab-goog

-- 

- Arnaldo
