Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5667C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 28 Nov 2021 16:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhK1Q2m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 28 Nov 2021 11:28:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347755AbhK1Q0m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 28 Nov 2021 11:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638116605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3TGYiyPyATGrZ8W3sGTNjoRLXExApqZ+1tfi5LQVbgI=;
        b=IBF5NCBF1CKmRnzmFzE4v2wvMNfGI/3+8/G1Aavo8fK6cSKPPQn8trw0fn6OZuI8KSgysV
        rKy7Tb7I7W8r6/K0yg6cA4H2dvu51UjiADX8w8z7N7+rrudCaVJLcPK3vA1GmN2OzYclhx
        rn3JylIhWzxbv2hJbZLzVvQ3+9CKA/Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-cfXgt-HKNmqnHpUy00JUWA-1; Sun, 28 Nov 2021 11:23:24 -0500
X-MC-Unique: cfXgt-HKNmqnHpUy00JUWA-1
Received: by mail-wm1-f70.google.com with SMTP id g81-20020a1c9d54000000b003330e488323so4625202wme.0
        for <linux-perf-users@vger.kernel.org>; Sun, 28 Nov 2021 08:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3TGYiyPyATGrZ8W3sGTNjoRLXExApqZ+1tfi5LQVbgI=;
        b=f40i4GlMk1/xXynmcs+QK7uENzn/rfN/8m4DCElOX/I6a93aUwzuuQYsesNakL/xIf
         twufPV+X8lIMMYgd1ChDZbhUNp1AM76wg5TWDJAB/wnfq3RfTstHs/JWe00LjYm0beHt
         B9MrlK9bGD5pdWdO8ahr/KPdb3MxVdwenycy0Af4lQ0/bvzihCrEdybVx5JA5R0Rxdy5
         IuajVEXEBatThg+9JXq7P2miAsGtfFqzDojVNVKS0Mqh0+lXtQt43wtndAd7HaaqbKhL
         cOLYO40J9146CwM3rimaI8YPQVkHND6+0tjMx0uFfrP5zfFoCWa8gvnXgmtr/SKV+XBA
         8H7w==
X-Gm-Message-State: AOAM530cgEDZOkU80ne8hPk7skjLrhK/QX5XLd9CunhLBlXgUvmbRcPR
        X6HaY7jKMi0Hk06GCcCrNB2cskRsEbaEUnS+BAfCnYV5Sx+RKMasno+hIKwBJguG1tdcTzEFcF/
        POuIHBpR07I4jSV8d4ye/ZhGQ/l3VqQ==
X-Received: by 2002:a05:6000:1868:: with SMTP id d8mr28538177wri.285.1638116603007;
        Sun, 28 Nov 2021 08:23:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2qI5+3gfVJ84zIoHppQOgZKjtRm/HgFjVpIH7n21wWhBW8o4xE+ET2/mMjW0yPWm/y9KgHw==
X-Received: by 2002:a05:6000:1868:: with SMTP id d8mr28538157wri.285.1638116602804;
        Sun, 28 Nov 2021 08:23:22 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t4sm16335034wmi.48.2021.11.28.08.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 08:23:22 -0800 (PST)
Date:   Sun, 28 Nov 2021 17:23:20 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Subject: Re: [PATCH v2] perf metric: Reduce multiplexing with duration_time
Message-ID: <YaOs+DjuoQvuqIrC@krava>
References: <20211124015226.3317994-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124015226.3317994-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Nov 23, 2021 at 05:52:26PM -0800, Ian Rogers wrote:
> It is common to use the same counters with and without
> duration_time. The ID sharing code treats duration_time as if it
> were a hardware event placed in the same group. This causes
> unnecessary multiplexing such as in the following example where
> l3_cache_access isn't shared:
> 
> $ perf stat -M l3 -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>          3,117,007      l3_cache_miss             #    199.5 MB/s  l3_rd_bw
>                                                   #     43.6 %  l3_hits
>                                                   #     56.4 %  l3_miss               (50.00%)
>          5,526,447      l3_cache_access                                               (50.00%)
>          5,392,435      l3_cache_access           # 5389191.2 access/s  l3_access_rate  (50.00%)
>      1,000,601,901 ns   duration_time
> 
>        1.000601901 seconds time elapsed
> 
> Fix this by placing duration_time in all groups unless metric
> sharing has been disabled on the command line:
> 
> $ perf stat -M l3 -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>          3,597,972      l3_cache_miss             #    230.3 MB/s  l3_rd_bw
>                                                   #     48.0 %  l3_hits
>                                                   #     52.0 %  l3_miss
>          6,914,459      l3_cache_access           # 6909935.9 access/s  l3_access_rate
>      1,000,654,579 ns   duration_time
> 
>        1.000654579 seconds time elapsed
> 
> $ perf stat --metric-no-merge -M l3 -a sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>          3,501,834      l3_cache_miss             #     53.5 %  l3_miss               (24.99%)
>          6,548,173      l3_cache_access                                               (24.99%)
>          3,417,622      l3_cache_miss             #     45.7 %  l3_hits               (25.04%)
>          6,294,062      l3_cache_access                                               (25.04%)
>          5,923,238      l3_cache_access           # 5919688.1 access/s  l3_access_rate  (24.99%)
>      1,000,599,683 ns   duration_time
>          3,607,486      l3_cache_miss             #    230.9 MB/s  l3_rd_bw           (49.97%)
> 
>        1.000599683 seconds time elapsed
> 
> v2. Doesn't count duration_time in the metric_list_cmp function that
>     sorts larger metrics first. Without this a metric with duration_time
>     and an event is sorted the same as a metric with two events,
>     possibly not allowing the first metric to share with the second.

hum, isn't the change about adding duration_time in every metric?
or you could still end up with metric without duration_time

thanks,
jirka

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/metricgroup.c | 42 +++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index fffe02aae3ed..51c99cb08abf 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1115,13 +1115,27 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
>  	return ret;
>  }
>  
> +/**
> + * metric_list_cmp - list_sort comparator that sorts metrics with more events to
> + *                   the front. duration_time is excluded from the count.
> + */
>  static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
>  			   const struct list_head *r)
>  {
>  	const struct metric *left = container_of(l, struct metric, nd);
>  	const struct metric *right = container_of(r, struct metric, nd);
> +	struct expr_id_data *data;
> +	int left_count, right_count;
> +
> +	left_count = hashmap__size(left->pctx->ids);
> +	if (!expr__get_id(left->pctx, "duration_time", &data))
> +		left_count--;
> +
> +	right_count = hashmap__size(right->pctx->ids);
> +	if (!expr__get_id(right->pctx, "duration_time", &data))
> +		right_count--;
>  
> -	return hashmap__size(right->pctx->ids) - hashmap__size(left->pctx->ids);
> +	return right_count - left_count;
>  }
>  
>  /**
> @@ -1299,14 +1313,16 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
>  /**
>   * parse_ids - Build the event string for the ids and parse them creating an
>   *             evlist. The encoded metric_ids are decoded.
> + * @metric_no_merge: is metric sharing explicitly disabled.
>   * @fake_pmu: used when testing metrics not supported by the current CPU.
>   * @ids: the event identifiers parsed from a metric.
>   * @modifier: any modifiers added to the events.
>   * @has_constraint: false if events should be placed in a weak group.
>   * @out_evlist: the created list of events.
>   */
> -static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
> -		     const char *modifier, bool has_constraint, struct evlist **out_evlist)
> +static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
> +		     struct expr_parse_ctx *ids, const char *modifier,
> +		     bool has_constraint, struct evlist **out_evlist)
>  {
>  	struct parse_events_error parse_error;
>  	struct evlist *parsed_evlist;
> @@ -1314,12 +1330,19 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
>  	int ret;
>  
>  	*out_evlist = NULL;
> -	if (hashmap__size(ids->ids) == 0) {
> +	if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
>  		char *tmp;
>  		/*
> -		 * No ids/events in the expression parsing context. Events may
> -		 * have been removed because of constant evaluation, e.g.:
> -		 *  event1 if #smt_on else 0
> +		 * We may fail to share events between metrics because
> +		 * duration_time isn't present in one metric. For example, a
> +		 * ratio of cache misses doesn't need duration_time but the same
> +		 * events may be used for a misses per second. Events without
> +		 * sharing implies multiplexing, that is best avoided, so place
> +		 * duration_time in every group.
> +		 *
> +		 * Also, there may be no ids/events in the expression parsing
> +		 * context because of constant evaluation, e.g.:
> +		 *    event1 if #smt_on else 0
>  		 * Add a duration_time event to avoid a parse error on an empty
>  		 * string.
>  		 */
> @@ -1387,7 +1410,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  		ret = build_combined_expr_ctx(&metric_list, &combined);
>  
>  		if (!ret && combined && hashmap__size(combined->ids)) {
> -			ret = parse_ids(fake_pmu, combined, /*modifier=*/NULL,
> +			ret = parse_ids(metric_no_merge, fake_pmu, combined,
> +					/*modifier=*/NULL,
>  					/*has_constraint=*/true,
>  					&combined_evlist);
>  		}
> @@ -1435,7 +1459,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
>  			}
>  		}
>  		if (!metric_evlist) {
> -			ret = parse_ids(fake_pmu, m->pctx, m->modifier,
> +			ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
>  					m->has_constraint, &m->evlist);
>  			if (ret)
>  				goto out;
> -- 
> 2.34.0.rc2.393.gf8c9666880-goog
> 

