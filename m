Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9827C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 00:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B7461211
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Sep 2021 00:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238606AbhIWAWz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 20:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhIWAWy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 22 Sep 2021 20:22:54 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9DCC061574
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 17:21:24 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id v16so4773684ilg.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Sep 2021 17:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h7wFZSZhYGFARstld/sZjenoBCnbb3GG4Ocnt9MAVDk=;
        b=c2vlCmsfUy+TefokCLQ4ZeuQNHcAawavIeazh6hI3wDO8jgBff0pJTxQWrmhZU++Da
         l4d98ugOiQcpIRMdz2iOXDmXRib0FY5rLgA4RDE2IAsA/sCUOAwljOlgIpiAs53XvZpA
         h9WuRMh7DqEq+ee4egpIej6VnoyEMajMAQVE2sa9rpmwF3xurOy/7Oucvxf9NnSAEC7a
         c0W8Cykv/vjWBkTrcsX8BoHU9xr2RXvn6BFjXu+U7Ek40OuJJwQsYqHTxuqxxuZry0/V
         e7KW3D5qrZKKp+CbpHTdtZOqlW1f/4eCJ9y0iuvPLGojSWlk3XOc0Aqgfu4AOTtC/twc
         8/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7wFZSZhYGFARstld/sZjenoBCnbb3GG4Ocnt9MAVDk=;
        b=xJs8B79nbB4gSuo0OzOWI9Lh6FO5D/i8vtkVEgNdmWOGN42FxjQEsj0rm7gnepd02J
         Y+7PVUvtxIVEL1M1V/H264xM1tHegU337w2kJEPurH9P7lOFsU/SZ3Jib0nC6xkADnRp
         cWtmj5xohUitvDFu8vDzSRDFBkCnb5whpa2GwbzESpaqYEEWmK4WfLpvJJgBisVsOIel
         mZOJ8/NaCAJqId41fUWcPLwB2diynYXZVOCuNuHyov03exXZRSjKCtD7dfx+WzHf7pBk
         8ZHlLR0haHx40AP6OwNz1ohUkQqssf/1Z4TlIvy7NVJjHCa5rLLKicxO5If+A1IF4AoT
         +E0w==
X-Gm-Message-State: AOAM533CB3O2fIuTJHhCi9REgkYurI9oj5TR9GSy3pUqWO5gdG7a9snk
        66EdseGpeYRYApGcXlO0qzcdeYxvspY3rd1xa1paQQ==
X-Google-Smtp-Source: ABdhPJwFyCT4v7jUw6KRdpNKFxDnOEqu+Bj3xbLqfeR/oX2+dnP6daTv73S2YbmIhaheQNjRNLDdFxCXboMde8s9Pyo=
X-Received: by 2002:a05:6e02:1caf:: with SMTP id x15mr1481981ill.150.1632356483191;
 Wed, 22 Sep 2021 17:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210918063513.2356923-1-irogers@google.com> <20210918063513.2356923-2-irogers@google.com>
 <YUuZJ/UeNv9uphy8@krava>
In-Reply-To: <YUuZJ/UeNv9uphy8@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Sep 2021 17:21:10 -0700
Message-ID: <CAP-5=fXdf2cpyndXYEEQyRMYrcC=kos81+G6boshjSRLtcRAug@mail.gmail.com>
Subject: Re: [PATCH v8 1/8] perf metric: Restructure struct expr_parse_ctx.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Sep 22, 2021 at 1:59 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Sep 17, 2021 at 11:35:06PM -0700, Ian Rogers wrote:
> > A later change to parsing the ids out (in expr__find_other) will
> > potentially drop hashmaps and so it is more convenient to move
> > expr_parse_ctx to have a hashmap pointer rather than a struct value. As
> > this pointer must be freed, rather than just going out of scope,
> > add expr__ctx_new and expr__ctx_free to manage expr_parse_ctx memory.
> > Adjust use of struct expr_parse_ctx accordingly.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/expr.c       | 81 ++++++++++++++++++-----------------
> >  tools/perf/tests/pmu-events.c | 43 +++++++++++--------
> >  tools/perf/util/expr.c        | 39 +++++++++++++----
> >  tools/perf/util/expr.h        |  5 ++-
> >  tools/perf/util/metricgroup.c | 44 ++++++++++---------
> >  tools/perf/util/stat-shadow.c | 50 +++++++++++++--------
> >  6 files changed, 155 insertions(+), 107 deletions(-)
> >
> > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > index 4d01051951cd..b0a3b5fd0c00 100644
> > --- a/tools/perf/tests/expr.c
> > +++ b/tools/perf/tests/expr.c
> > @@ -22,67 +22,70 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> >       const char *p;
> >       double val;
> >       int ret;
> > -     struct expr_parse_ctx ctx;
> > +     struct expr_parse_ctx *ctx;
> >
> > -     expr__ctx_init(&ctx);
> > -     expr__add_id_val(&ctx, strdup("FOO"), 1);
> > -     expr__add_id_val(&ctx, strdup("BAR"), 2);
> > +     ctx = expr__ctx_new();
>
> missing ctx check

It is covered in the assert below.

> > +     TEST_ASSERT_VAL("expr__ctx_new", ctx);
> > +     expr__add_id_val(ctx, strdup("FOO"), 1);
> > +     expr__add_id_val(ctx, strdup("BAR"), 2);
> >
> > -     ret = test(&ctx, "1+1", 2);
> > -     ret |= test(&ctx, "FOO+BAR", 3);
> > -     ret |= test(&ctx, "(BAR/2)%2", 1);
> > -     ret |= test(&ctx, "1 - -4",  5);
> > -     ret |= test(&ctx, "(FOO-1)*2 + (BAR/2)%2 - -4",  5);
> > -     ret |= test(&ctx, "1-1 | 1", 1);
> > -     ret |= test(&ctx, "1-1 & 1", 0);
> > -     ret |= test(&ctx, "min(1,2) + 1", 2);
> > -     ret |= test(&ctx, "max(1,2) + 1", 3);
> > -     ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
> > -     ret |= test(&ctx, "1.1 + 2.1", 3.2);
> > -     ret |= test(&ctx, ".1 + 2.", 2.1);
> > -     ret |= test(&ctx, "d_ratio(1, 2)", 0.5);
> > -     ret |= test(&ctx, "d_ratio(2.5, 0)", 0);
> > -     ret |= test(&ctx, "1.1 < 2.2", 1);
> > -     ret |= test(&ctx, "2.2 > 1.1", 1);
> > -     ret |= test(&ctx, "1.1 < 1.1", 0);
> > -     ret |= test(&ctx, "2.2 > 2.2", 0);
> > -     ret |= test(&ctx, "2.2 < 1.1", 0);
> > -     ret |= test(&ctx, "1.1 > 2.2", 0);
> > +     ret = test(ctx, "1+1", 2);
> > +     ret |= test(ctx, "FOO+BAR", 3);
> > +     ret |= test(ctx, "(BAR/2)%2", 1);
> > +     ret |= test(ctx, "1 - -4",  5);
> > +     ret |= test(ctx, "(FOO-1)*2 + (BAR/2)%2 - -4",  5);
> > +     ret |= test(ctx, "1-1 | 1", 1);
> > +     ret |= test(ctx, "1-1 & 1", 0);
> > +     ret |= test(ctx, "min(1,2) + 1", 2);
> > +     ret |= test(ctx, "max(1,2) + 1", 3);
> > +     ret |= test(ctx, "1+1 if 3*4 else 0", 2);
> > +     ret |= test(ctx, "1.1 + 2.1", 3.2);
> > +     ret |= test(ctx, ".1 + 2.", 2.1);
> > +     ret |= test(ctx, "d_ratio(1, 2)", 0.5);
> > +     ret |= test(ctx, "d_ratio(2.5, 0)", 0);
> > +     ret |= test(ctx, "1.1 < 2.2", 1);
> > +     ret |= test(ctx, "2.2 > 1.1", 1);
> > +     ret |= test(ctx, "1.1 < 1.1", 0);
> > +     ret |= test(ctx, "2.2 > 2.2", 0);
> > +     ret |= test(ctx, "2.2 < 1.1", 0);
> > +     ret |= test(ctx, "1.1 > 2.2", 0);
>
>
> SNIP
>
>
> >                               ret++;
> > @@ -876,27 +881,27 @@ static int test_parsing(void)
> >                        * make them unique.
> >                        */
> >                       k = 1;
> > -                     hashmap__for_each_entry((&ctx.ids), cur, bkt)
> > -                             expr__add_id_val(&ctx, strdup(cur->key), k++);
> > +                     hashmap__for_each_entry(ctx->ids, cur, bkt)
> > +                             expr__add_id_val(ctx, strdup(cur->key), k++);
> >
> > -                     hashmap__for_each_entry((&ctx.ids), cur, bkt) {
> > +                     hashmap__for_each_entry(ctx->ids, cur, bkt) {
> >                               if (check_parse_cpu(cur->key, map == cpus_map,
> >                                                  pe))
> >                                       ret++;
> >                       }
> >
> >                       list_for_each_entry_safe(metric, tmp, &compound_list, list) {
> > -                             expr__add_ref(&ctx, &metric->metric_ref);
> > +                             expr__add_ref(ctx, &metric->metric_ref);
> >                               free(metric);
> >                       }
> >
> > -                     if (expr__parse(&result, &ctx, pe->metric_expr, 0)) {
> > +                     if (expr__parse(&result, ctx, pe->metric_expr, 0)) {
> >                               expr_failure("Parse failed", map, pe);
> >                               ret++;
> >                       }
> > -                     expr__ctx_clear(&ctx);
> >               }
> >       }
> > +     expr__ctx_free(ctx);
> >       /* TODO: fail when not ok */
> >  exit:
> >       return ret == 0 ? TEST_OK : TEST_SKIP;
> > @@ -916,7 +921,7 @@ static struct test_metric metrics[] = {
> >
> >  static int metric_parse_fake(const char *str)
> >  {
> > -     struct expr_parse_ctx ctx;
> > +     struct expr_parse_ctx *ctx;
> >       struct hashmap_entry *cur;
> >       double result;
> >       int ret = -1;
> > @@ -925,8 +930,8 @@ static int metric_parse_fake(const char *str)
> >
> >       pr_debug("parsing '%s'\n", str);
> >
> > -     expr__ctx_init(&ctx);
> > -     if (expr__find_other(str, NULL, &ctx, 0) < 0) {
> > +     ctx = expr__ctx_new();
>
> missing ctx check

Done.

Thanks,
Ian

> jirka
>
> > +     if (expr__find_other(str, NULL, ctx, 0) < 0) {
> >               pr_err("expr__find_other failed\n");
> >               return -1;
> >       }
> > @@ -937,23 +942,23 @@ static int metric_parse_fake(const char *str)
> >        * make them unique.
> >        */
> >       i = 1;
> > -     hashmap__for_each_entry((&ctx.ids), cur, bkt)
> > -             expr__add_id_val(&ctx, strdup(cur->key), i++);
> > +     hashmap__for_each_entry(ctx->ids, cur, bkt)
> > +             expr__add_id_val(ctx, strdup(cur->key), i++);
> >
> > -     hashmap__for_each_entry((&ctx.ids), cur, bkt) {
> > +     hashmap__for_each_entry(ctx->ids, cur, bkt) {
> >               if (check_parse_fake(cur->key)) {
> >                       pr_err("check_parse_fake failed\n");
> >                       goto out;
> >               }
> >       }
> >
> > -     if (expr__parse(&result, &ctx, str, 0))
> > +     if (expr__parse(&result, ctx, str, 0))
> >               pr_err("expr__parse failed\n");
> >       else
> >               ret = 0;
> >
> >  out:
> > -     expr__ctx_clear(&ctx);
> > +     expr__ctx_free(ctx);
> >       return ret;
> >  }
> >
> > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > index a850fd0be3ee..7b1c06772a49 100644
> > --- a/tools/perf/util/expr.c
> > +++ b/tools/perf/util/expr.c
> > @@ -73,7 +73,7 @@ int expr__add_id(struct expr_parse_ctx *ctx, const char *id)
> >       data_ptr->parent = ctx->parent;
> >       data_ptr->kind = EXPR_ID_DATA__PARENT;
> >
> > -     ret = hashmap__set(&ctx->ids, id, data_ptr,
> > +     ret = hashmap__set(ctx->ids, id, data_ptr,
> >                          (const void **)&old_key, (void **)&old_data);
> >       if (ret)
> >               free(data_ptr);
> > @@ -95,7 +95,7 @@ int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val)
> >       data_ptr->val = val;
> >       data_ptr->kind = EXPR_ID_DATA__VALUE;
> >
> > -     ret = hashmap__set(&ctx->ids, id, data_ptr,
> > +     ret = hashmap__set(ctx->ids, id, data_ptr,
> >                          (const void **)&old_key, (void **)&old_data);
> >       if (ret)
> >               free(data_ptr);
> > @@ -140,7 +140,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> >       data_ptr->ref.metric_expr = ref->metric_expr;
> >       data_ptr->kind = EXPR_ID_DATA__REF;
> >
> > -     ret = hashmap__set(&ctx->ids, name, data_ptr,
> > +     ret = hashmap__set(ctx->ids, name, data_ptr,
> >                          (const void **)&old_key, (void **)&old_data);
> >       if (ret)
> >               free(data_ptr);
> > @@ -156,7 +156,7 @@ int expr__add_ref(struct expr_parse_ctx *ctx, struct metric_ref *ref)
> >  int expr__get_id(struct expr_parse_ctx *ctx, const char *id,
> >                struct expr_id_data **data)
> >  {
> > -     return hashmap__find(&ctx->ids, id, (void **)data) ? 0 : -1;
> > +     return hashmap__find(ctx->ids, id, (void **)data) ? 0 : -1;
> >  }
> >
> >  int expr__resolve_id(struct expr_parse_ctx *ctx, const char *id,
> > @@ -205,15 +205,23 @@ void expr__del_id(struct expr_parse_ctx *ctx, const char *id)
> >       struct expr_id_data *old_val = NULL;
> >       char *old_key = NULL;
> >
> > -     hashmap__delete(&ctx->ids, id,
> > +     hashmap__delete(ctx->ids, id,
> >                       (const void **)&old_key, (void **)&old_val);
> >       free(old_key);
> >       free(old_val);
> >  }
> >
> > -void expr__ctx_init(struct expr_parse_ctx *ctx)
> > +struct expr_parse_ctx *expr__ctx_new(void)
> >  {
> > -     hashmap__init(&ctx->ids, key_hash, key_equal, NULL);
> > +     struct expr_parse_ctx *ctx;
> > +
> > +     ctx = malloc(sizeof(struct expr_parse_ctx));
> > +     if (!ctx)
> > +             return NULL;
> > +
> > +     ctx->ids = hashmap__new(key_hash, key_equal, NULL);
> > +     ctx->parent = NULL;
> > +     return ctx;
> >  }
> >
> >  void expr__ctx_clear(struct expr_parse_ctx *ctx)
> > @@ -221,11 +229,24 @@ void expr__ctx_clear(struct expr_parse_ctx *ctx)
> >       struct hashmap_entry *cur;
> >       size_t bkt;
> >
> > -     hashmap__for_each_entry((&ctx->ids), cur, bkt) {
> > +     hashmap__for_each_entry(ctx->ids, cur, bkt) {
> > +             free((char *)cur->key);
> > +             free(cur->value);
> > +     }
> > +     hashmap__clear(ctx->ids);
> > +}
> > +
> > +void expr__ctx_free(struct expr_parse_ctx *ctx)
> > +{
> > +     struct hashmap_entry *cur;
> > +     size_t bkt;
> > +
> > +     hashmap__for_each_entry(ctx->ids, cur, bkt) {
> >               free((char *)cur->key);
> >               free(cur->value);
> >       }
> > -     hashmap__clear(&ctx->ids);
> > +     hashmap__free(ctx->ids);
> > +     free(ctx);
> >  }
> >
> >  static int
> > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > index 85df3e4771e4..5fa394f10418 100644
> > --- a/tools/perf/util/expr.h
> > +++ b/tools/perf/util/expr.h
> > @@ -19,7 +19,7 @@ struct expr_id {
> >  };
> >
> >  struct expr_parse_ctx {
> > -     struct hashmap   ids;
> > +     struct hashmap  *ids;
> >       struct expr_id  *parent;
> >  };
> >
> > @@ -30,8 +30,9 @@ struct expr_scanner_ctx {
> >       int runtime;
> >  };
> >
> > -void expr__ctx_init(struct expr_parse_ctx *ctx);
> > +struct expr_parse_ctx *expr__ctx_new(void);
> >  void expr__ctx_clear(struct expr_parse_ctx *ctx);
> > +void expr__ctx_free(struct expr_parse_ctx *ctx);
> >  void expr__del_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id(struct expr_parse_ctx *ctx, const char *id);
> >  int expr__add_id_val(struct expr_parse_ctx *ctx, const char *id, double val);
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 29b747ac31c1..b7924a2f1f45 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -118,7 +118,7 @@ struct metric_ref_node {
> >
> >  struct metric {
> >       struct list_head nd;
> > -     struct expr_parse_ctx pctx;
> > +     struct expr_parse_ctx *pctx;
> >       const char *metric_name;
> >       const char *metric_expr;
> >       const char *metric_unit;
> > @@ -198,7 +198,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >       struct evsel *ev, *current_leader = NULL;
> >       struct expr_id_data *val_ptr;
> >       int i = 0, matched_events = 0, events_to_match;
> > -     const int idnum = (int)hashmap__size(&pctx->ids);
> > +     const int idnum = (int)hashmap__size(pctx->ids);
> >
> >       /*
> >        * duration_time is always grouped separately, when events are grouped
> > @@ -206,7 +206,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >        * add it to metric_events at the end.
> >        */
> >       if (!has_constraint &&
> > -         hashmap__find(&pctx->ids, "duration_time", (void **)&val_ptr))
> > +         hashmap__find(pctx->ids, "duration_time", (void **)&val_ptr))
> >               events_to_match = idnum - 1;
> >       else
> >               events_to_match = idnum;
> > @@ -242,7 +242,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
> >               if (contains_event(metric_events, matched_events, ev->name))
> >                       continue;
> >               /* Does this event belong to the parse context? */
> > -             if (hashmap__find(&pctx->ids, ev->name, (void **)&val_ptr))
> > +             if (hashmap__find(pctx->ids, ev->name, (void **)&val_ptr))
> >                       metric_events[matched_events++] = ev;
> >
> >               if (matched_events == events_to_match)
> > @@ -322,12 +322,12 @@ static int metricgroup__setup_events(struct list_head *groups,
> >               struct metric_ref *metric_refs = NULL;
> >
> >               metric_events = calloc(sizeof(void *),
> > -                             hashmap__size(&m->pctx.ids) + 1);
> > +                             hashmap__size(m->pctx->ids) + 1);
> >               if (!metric_events) {
> >                       ret = -ENOMEM;
> >                       break;
> >               }
> > -             evsel = find_evsel_group(perf_evlist, &m->pctx,
> > +             evsel = find_evsel_group(perf_evlist, m->pctx,
> >                                        metric_no_merge,
> >                                        m->has_constraint, metric_events,
> >                                        evlist_used);
> > @@ -693,7 +693,7 @@ static void metricgroup__add_metric_weak_group(struct strbuf *events,
> >       size_t bkt;
> >       bool no_group = true, has_duration = false;
> >
> > -     hashmap__for_each_entry((&ctx->ids), cur, bkt) {
> > +     hashmap__for_each_entry(ctx->ids, cur, bkt) {
> >               pr_debug("found event %s\n", (const char *)cur->key);
> >               /*
> >                * Duration time maps to a software event and can make
> > @@ -724,7 +724,7 @@ static void metricgroup__add_metric_non_group(struct strbuf *events,
> >       size_t bkt;
> >       bool first = true;
> >
> > -     hashmap__for_each_entry((&ctx->ids), cur, bkt) {
> > +     hashmap__for_each_entry(ctx->ids, cur, bkt) {
> >               if (!first)
> >                       strbuf_addf(events, ",");
> >               strbuf_addf(events, "%s", (const char *)cur->key);
> > @@ -799,7 +799,11 @@ static int __add_metric(struct list_head *metric_list,
> >               if (!m)
> >                       return -ENOMEM;
> >
> > -             expr__ctx_init(&m->pctx);
> > +             m->pctx = expr__ctx_new();
> > +             if (!m->pctx) {
> > +                     free(m);
> > +                     return -ENOMEM;
> > +             }
> >               m->metric_name = pe->metric_name;
> >               m->metric_expr = pe->metric_expr;
> >               m->metric_unit = pe->unit;
> > @@ -847,15 +851,15 @@ static int __add_metric(struct list_head *metric_list,
> >
> >       /* Force all found IDs in metric to have us as parent ID. */
> >       WARN_ON_ONCE(!parent);
> > -     m->pctx.parent = parent;
> > +     m->pctx->parent = parent;
> >
> >       /*
> >        * For both the parent and referenced metrics, we parse
> >        * all the metric's IDs and add it to the parent context.
> >        */
> > -     if (expr__find_other(pe->metric_expr, NULL, &m->pctx, runtime) < 0) {
> > +     if (expr__find_other(pe->metric_expr, NULL, m->pctx, runtime) < 0) {
> >               if (m->metric_refs_cnt == 0) {
> > -                     expr__ctx_clear(&m->pctx);
> > +                     expr__ctx_free(m->pctx);
> >                       free(m);
> >                       *mp = NULL;
> >               }
> > @@ -878,8 +882,8 @@ static int __add_metric(struct list_head *metric_list,
> >               list_for_each_prev(pos, metric_list) {
> >                       struct metric *old = list_entry(pos, struct metric, nd);
> >
> > -                     if (hashmap__size(&m->pctx.ids) <=
> > -                         hashmap__size(&old->pctx.ids))
> > +                     if (hashmap__size(m->pctx->ids) <=
> > +                         hashmap__size(old->pctx->ids))
> >                               break;
> >               }
> >               list_add(&m->nd, pos);
> > @@ -927,7 +931,7 @@ static int recursion_check(struct metric *m, const char *id, struct expr_id **pa
> >        * if we already processed 'id', if we did, it's recursion
> >        * and we fail.
> >        */
> > -     ret = expr__get_id(&m->pctx, id, &data);
> > +     ret = expr__get_id(m->pctx, id, &data);
> >       if (ret)
> >               return ret;
> >
> > @@ -982,7 +986,7 @@ static int __resolve_metric(struct metric *m,
> >        */
> >       do {
> >               all = true;
> > -             hashmap__for_each_entry((&m->pctx.ids), cur, bkt) {
> > +             hashmap__for_each_entry(m->pctx->ids, cur, bkt) {
> >                       struct expr_id *parent;
> >                       struct pmu_event *pe;
> >
> > @@ -996,7 +1000,7 @@ static int __resolve_metric(struct metric *m,
> >
> >                       all = false;
> >                       /* The metric key itself needs to go out.. */
> > -                     expr__del_id(&m->pctx, cur->key);
> > +                     expr__del_id(m->pctx, cur->key);
> >
> >                       /* ... and it gets resolved to the parent context. */
> >                       ret = add_metric(metric_list, pe, metric_no_group, &m, parent, ids);
> > @@ -1144,10 +1148,10 @@ static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> >
> >               if (m->has_constraint) {
> >                       metricgroup__add_metric_non_group(events,
> > -                                                       &m->pctx);
> > +                                                       m->pctx);
> >               } else {
> >                       metricgroup__add_metric_weak_group(events,
> > -                                                        &m->pctx);
> > +                                                        m->pctx);
> >               }
> >       }
> >
> > @@ -1210,7 +1214,7 @@ static void metricgroup__free_metrics(struct list_head *metric_list)
> >
> >       list_for_each_entry_safe (m, tmp, metric_list, nd) {
> >               metric__free_refs(m);
> > -             expr__ctx_clear(&m->pctx);
> > +             expr__ctx_free(m->pctx);
> >               list_del_init(&m->nd);
> >               free(m);
> >       }
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index 34a7f5c1fff7..c9fa07e49e72 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -1,8 +1,10 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <math.h>
> >  #include <stdio.h>
> >  #include "evsel.h"
> >  #include "stat.h"
> >  #include "color.h"
> > +#include "debug.h"
> >  #include "pmu.h"
> >  #include "rblist.h"
> >  #include "evlist.h"
> > @@ -370,12 +372,16 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
> >  {
> >       struct evsel *counter, *leader, **metric_events, *oc;
> >       bool found;
> > -     struct expr_parse_ctx ctx;
> > +     struct expr_parse_ctx *ctx;
> >       struct hashmap_entry *cur;
> >       size_t bkt;
> >       int i;
> >
> > -     expr__ctx_init(&ctx);
> > +     ctx = expr__ctx_new();
> > +     if (!ctx) {
> > +             pr_debug("expr__ctx_new failed");
> > +             return;
> > +     }
> >       evlist__for_each_entry(evsel_list, counter) {
> >               bool invalid = false;
> >
> > @@ -383,25 +389,25 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
> >               if (!counter->metric_expr)
> >                       continue;
> >
> > -             expr__ctx_clear(&ctx);
> > +             expr__ctx_clear(ctx);
> >               metric_events = counter->metric_events;
> >               if (!metric_events) {
> >                       if (expr__find_other(counter->metric_expr,
> >                                            counter->name,
> > -                                          &ctx, 1) < 0)
> > +                                          ctx, 1) < 0)
> >                               continue;
> >
> >                       metric_events = calloc(sizeof(struct evsel *),
> > -                                            hashmap__size(&ctx.ids) + 1);
> > +                                            hashmap__size(ctx->ids) + 1);
> >                       if (!metric_events) {
> > -                             expr__ctx_clear(&ctx);
> > +                             expr__ctx_free(ctx);
> >                               return;
> >                       }
> >                       counter->metric_events = metric_events;
> >               }
> >
> >               i = 0;
> > -             hashmap__for_each_entry((&ctx.ids), cur, bkt) {
> > +             hashmap__for_each_entry(ctx->ids, cur, bkt) {
> >                       const char *metric_name = (const char *)cur->key;
> >
> >                       found = false;
> > @@ -453,7 +459,7 @@ void perf_stat__collect_metric_expr(struct evlist *evsel_list)
> >                       counter->metric_expr = NULL;
> >               }
> >       }
> > -     expr__ctx_clear(&ctx);
> > +     expr__ctx_free(ctx);
> >  }
> >
> >  static double runtime_stat_avg(struct runtime_stat *st,
> > @@ -818,7 +824,6 @@ static int prepare_metric(struct evsel **metric_events,
> >       char *n, *pn;
> >       int i, j, ret;
> >
> > -     expr__ctx_init(pctx);
> >       for (i = 0; metric_events[i]; i++) {
> >               struct saved_value *v;
> >               struct stats *stats;
> > @@ -880,17 +885,22 @@ static void generic_metric(struct perf_stat_config *config,
> >                          struct runtime_stat *st)
> >  {
> >       print_metric_t print_metric = out->print_metric;
> > -     struct expr_parse_ctx pctx;
> > +     struct expr_parse_ctx *pctx;
> >       double ratio, scale;
> >       int i;
> >       void *ctxp = out->ctx;
> >
> > -     i = prepare_metric(metric_events, metric_refs, &pctx, cpu, st);
> > -     if (i < 0)
> > +     pctx = expr__ctx_new();
> > +     if (!pctx)
> >               return;
> >
> > +     i = prepare_metric(metric_events, metric_refs, pctx, cpu, st);
> > +     if (i < 0) {
> > +             expr__ctx_free(pctx);
> > +             return;
> > +     }
> >       if (!metric_events[i]) {
> > -             if (expr__parse(&ratio, &pctx, metric_expr, runtime) == 0) {
> > +             if (expr__parse(&ratio, pctx, metric_expr, runtime) == 0) {
> >                       char *unit;
> >                       char metric_bf[64];
> >
> > @@ -926,22 +936,26 @@ static void generic_metric(struct perf_stat_config *config,
> >                            (metric_name ? metric_name : name) : "", 0);
> >       }
> >
> > -     expr__ctx_clear(&pctx);
> > +     expr__ctx_free(pctx);
> >  }
> >
> >  double test_generic_metric(struct metric_expr *mexp, int cpu, struct runtime_stat *st)
> >  {
> > -     struct expr_parse_ctx pctx;
> > +     struct expr_parse_ctx *pctx;
> >       double ratio = 0.0;
> >
> > -     if (prepare_metric(mexp->metric_events, mexp->metric_refs, &pctx, cpu, st) < 0)
> > +     pctx = expr__ctx_new();
> > +     if (!pctx)
> > +             return NAN;
> > +
> > +     if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, cpu, st) < 0)
> >               goto out;
> >
> > -     if (expr__parse(&ratio, &pctx, mexp->metric_expr, 1))
> > +     if (expr__parse(&ratio, pctx, mexp->metric_expr, 1))
> >               ratio = 0.0;
> >
> >  out:
> > -     expr__ctx_clear(&pctx);
> > +     expr__ctx_free(pctx);
> >       return ratio;
> >  }
> >
> > --
> > 2.33.0.464.g1972c5931b-goog
> >
>
