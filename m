Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33230C433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Nov 2021 22:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhK2Wz2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbhK2WzB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Nov 2021 17:55:01 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C46C0C2362
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Nov 2021 09:46:45 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b187so11475553iof.11
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Nov 2021 09:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vX2hvoTTCIqA6f6a6sn0jXYtJu9qfk4PIoqLvyXdDiQ=;
        b=QEKT2fnP+gGQII5WJK2Alzrm/i24p5abLw5ClHmt5h7KqSfVEtpVJCzoe3aafihaK4
         eydrDq7ljFkoNd2pehWhAMCQNzbkRduiM8+O4922IBV1pTI4JQ96x1rMpQvsB+0zIp21
         TbJKuYq16Yua+TkvuB7k88yuQ4wINUBmaGxw+j1cLnIO0ShCLNq/dv/K3IdEHCG6Yyge
         fW2QRv9GaUvMN6gjpfeZ4IYKbywJS37wrBs3vmUxIlCQtRHoEDHcSDoHdDK6MetSW9jV
         I5gdizj2BFs9/ybG/hJ9xFZa/bOGi7PtsQabq1ZG9s5nTVJh/ncTwq2rBGILzyVwXxH7
         hYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vX2hvoTTCIqA6f6a6sn0jXYtJu9qfk4PIoqLvyXdDiQ=;
        b=vCX3LG2CNvT7PncXmL5pmSUGH7xBXQwj6JOBY+Og4VQjKw6pD1bq51MUUiNbyUL/zp
         R5wBqeapkJyuH6Xr/kxbxQTJneVJwilr5w1K7I/2U/uvbnuAF5RxngMEqwkX72SQ30iI
         4aBOBjj+Av7HleegLndccX9m8Um5mdp2I/JqqXhiJBMIAPbnmMF7x2YlYigVMlKmpyPq
         gYO2WPtToOTVEM1h5Jg8MkeuURb1moNziky05+HBxx8+aN5lOPCErCX3WGHP+Y+BgVcs
         X2OquiTNQl/5rwT6KuAWfSuTbq/22ago4GHQ8d9lb67yc6fstZxcpy1y7y+vSmL9Qvo4
         vQ7A==
X-Gm-Message-State: AOAM5338boFwjdBjZtrhxlVLfoimUHLOomZktBpkhuTQKhOj0o5lm1lt
        ewUPw6rkVXDxD0CqS0DoX3ej4cYrI6SkM5KUWrkgiw==
X-Google-Smtp-Source: ABdhPJxjO4I4tclJ9zhfxEAwKMxN3ghCktYDHiYkvU5nZT8rc0w2uZ6lBddMhifIs2mRBrzQzbgU3+WUg5gyeJdoGnQ=
X-Received: by 2002:a02:c559:: with SMTP id g25mr69999860jaj.123.1638208004601;
 Mon, 29 Nov 2021 09:46:44 -0800 (PST)
MIME-Version: 1.0
References: <20211124015226.3317994-1-irogers@google.com> <YaOs+DjuoQvuqIrC@krava>
In-Reply-To: <YaOs+DjuoQvuqIrC@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 29 Nov 2021 09:46:31 -0800
Message-ID: <CAP-5=fXBRa7+ugLAWjuOkwr3vqWtaby86e8zovUvkX2wmYV4ag@mail.gmail.com>
Subject: Re: [PATCH v2] perf metric: Reduce multiplexing with duration_time
To:     Jiri Olsa <jolsa@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Nov 28, 2021 at 8:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Nov 23, 2021 at 05:52:26PM -0800, Ian Rogers wrote:
> > It is common to use the same counters with and without
> > duration_time. The ID sharing code treats duration_time as if it
> > were a hardware event placed in the same group. This causes
> > unnecessary multiplexing such as in the following example where
> > l3_cache_access isn't shared:
> >
> > $ perf stat -M l3 -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >          3,117,007      l3_cache_miss             #    199.5 MB/s  l3_rd_bw
> >                                                   #     43.6 %  l3_hits
> >                                                   #     56.4 %  l3_miss               (50.00%)
> >          5,526,447      l3_cache_access                                               (50.00%)
> >          5,392,435      l3_cache_access           # 5389191.2 access/s  l3_access_rate  (50.00%)
> >      1,000,601,901 ns   duration_time
> >
> >        1.000601901 seconds time elapsed
> >
> > Fix this by placing duration_time in all groups unless metric
> > sharing has been disabled on the command line:
> >
> > $ perf stat -M l3 -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >          3,597,972      l3_cache_miss             #    230.3 MB/s  l3_rd_bw
> >                                                   #     48.0 %  l3_hits
> >                                                   #     52.0 %  l3_miss
> >          6,914,459      l3_cache_access           # 6909935.9 access/s  l3_access_rate
> >      1,000,654,579 ns   duration_time
> >
> >        1.000654579 seconds time elapsed
> >
> > $ perf stat --metric-no-merge -M l3 -a sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >          3,501,834      l3_cache_miss             #     53.5 %  l3_miss               (24.99%)
> >          6,548,173      l3_cache_access                                               (24.99%)
> >          3,417,622      l3_cache_miss             #     45.7 %  l3_hits               (25.04%)
> >          6,294,062      l3_cache_access                                               (25.04%)
> >          5,923,238      l3_cache_access           # 5919688.1 access/s  l3_access_rate  (24.99%)
> >      1,000,599,683 ns   duration_time
> >          3,607,486      l3_cache_miss             #    230.9 MB/s  l3_rd_bw           (49.97%)
> >
> >        1.000599683 seconds time elapsed
> >
> > v2. Doesn't count duration_time in the metric_list_cmp function that
> >     sorts larger metrics first. Without this a metric with duration_time
> >     and an event is sorted the same as a metric with two events,
> >     possibly not allowing the first metric to share with the second.
>
> hum, isn't the change about adding duration_time in every metric?
> or you could still end up with metric without duration_time

It is about adding duration_time to all metrics. Sorting of the
metrics by number of IDs happens before we insert duration_time which
happens just prior to parsing. duration_time needn't be inserted if
--metric-no-merge is passed.

Thanks,
Ian

> thanks,
> jirka
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c | 42 +++++++++++++++++++++++++++--------
> >  1 file changed, 33 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index fffe02aae3ed..51c99cb08abf 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -1115,13 +1115,27 @@ static int metricgroup__add_metric_sys_event_iter(const struct pmu_event *pe,
> >       return ret;
> >  }
> >
> > +/**
> > + * metric_list_cmp - list_sort comparator that sorts metrics with more events to
> > + *                   the front. duration_time is excluded from the count.
> > + */
> >  static int metric_list_cmp(void *priv __maybe_unused, const struct list_head *l,
> >                          const struct list_head *r)
> >  {
> >       const struct metric *left = container_of(l, struct metric, nd);
> >       const struct metric *right = container_of(r, struct metric, nd);
> > +     struct expr_id_data *data;
> > +     int left_count, right_count;
> > +
> > +     left_count = hashmap__size(left->pctx->ids);
> > +     if (!expr__get_id(left->pctx, "duration_time", &data))
> > +             left_count--;
> > +
> > +     right_count = hashmap__size(right->pctx->ids);
> > +     if (!expr__get_id(right->pctx, "duration_time", &data))
> > +             right_count--;
> >
> > -     return hashmap__size(right->pctx->ids) - hashmap__size(left->pctx->ids);
> > +     return right_count - left_count;
> >  }
> >
> >  /**
> > @@ -1299,14 +1313,16 @@ static int build_combined_expr_ctx(const struct list_head *metric_list,
> >  /**
> >   * parse_ids - Build the event string for the ids and parse them creating an
> >   *             evlist. The encoded metric_ids are decoded.
> > + * @metric_no_merge: is metric sharing explicitly disabled.
> >   * @fake_pmu: used when testing metrics not supported by the current CPU.
> >   * @ids: the event identifiers parsed from a metric.
> >   * @modifier: any modifiers added to the events.
> >   * @has_constraint: false if events should be placed in a weak group.
> >   * @out_evlist: the created list of events.
> >   */
> > -static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
> > -                  const char *modifier, bool has_constraint, struct evlist **out_evlist)
> > +static int parse_ids(bool metric_no_merge, struct perf_pmu *fake_pmu,
> > +                  struct expr_parse_ctx *ids, const char *modifier,
> > +                  bool has_constraint, struct evlist **out_evlist)
> >  {
> >       struct parse_events_error parse_error;
> >       struct evlist *parsed_evlist;
> > @@ -1314,12 +1330,19 @@ static int parse_ids(struct perf_pmu *fake_pmu, struct expr_parse_ctx *ids,
> >       int ret;
> >
> >       *out_evlist = NULL;
> > -     if (hashmap__size(ids->ids) == 0) {
> > +     if (!metric_no_merge || hashmap__size(ids->ids) == 0) {
> >               char *tmp;
> >               /*
> > -              * No ids/events in the expression parsing context. Events may
> > -              * have been removed because of constant evaluation, e.g.:
> > -              *  event1 if #smt_on else 0
> > +              * We may fail to share events between metrics because
> > +              * duration_time isn't present in one metric. For example, a
> > +              * ratio of cache misses doesn't need duration_time but the same
> > +              * events may be used for a misses per second. Events without
> > +              * sharing implies multiplexing, that is best avoided, so place
> > +              * duration_time in every group.
> > +              *
> > +              * Also, there may be no ids/events in the expression parsing
> > +              * context because of constant evaluation, e.g.:
> > +              *    event1 if #smt_on else 0
> >                * Add a duration_time event to avoid a parse error on an empty
> >                * string.
> >                */
> > @@ -1387,7 +1410,8 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> >               ret = build_combined_expr_ctx(&metric_list, &combined);
> >
> >               if (!ret && combined && hashmap__size(combined->ids)) {
> > -                     ret = parse_ids(fake_pmu, combined, /*modifier=*/NULL,
> > +                     ret = parse_ids(metric_no_merge, fake_pmu, combined,
> > +                                     /*modifier=*/NULL,
> >                                       /*has_constraint=*/true,
> >                                       &combined_evlist);
> >               }
> > @@ -1435,7 +1459,7 @@ static int parse_groups(struct evlist *perf_evlist, const char *str,
> >                       }
> >               }
> >               if (!metric_evlist) {
> > -                     ret = parse_ids(fake_pmu, m->pctx, m->modifier,
> > +                     ret = parse_ids(metric_no_merge, fake_pmu, m->pctx, m->modifier,
> >                                       m->has_constraint, &m->evlist);
> >                       if (ret)
> >                               goto out;
> > --
> > 2.34.0.rc2.393.gf8c9666880-goog
> >
>
