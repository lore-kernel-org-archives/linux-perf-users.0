Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60944C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 17:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B5061159
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 17:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhKJSCA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKJSB7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 13:01:59 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD13CC061764
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 09:59:11 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id az33-20020a05600c602100b00333472fef04so4581551wmb.5
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 09:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgIGbQ+ELnZoSxdoafp+PyrTLIczqcJkb+RcXGdEEjQ=;
        b=d/vtuumeAYdigLXhsngLtZQ3LOyVMXKR59zYrqBFvpI6OFuJxMtg67LZaaXSpHFZYt
         d7JAJSrBqNa95Eg09MrvY0peCY+RMGBzPQ8UNLTroP0tFb3b0wD8+ZH5l65OCtBhaIKp
         kHrX+D4IEIV/mQMKpJbFl2yOn1OCcenjrT61Zw2j2UHrjPCyIw8J3fs2I7KtCb43n+Vh
         3USSZwm0A08MZOEnVQZITxxoZbkvnMnWxHBIBTwgvSG92oA68sZyXZvs52TUK1eensU5
         6N/oMbwbIgAkO4OVr8urbCg1XblpTJ1/gLgNmJluzgsMdxuBGBWlkBFWoqB+HQe8RyzX
         ++eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgIGbQ+ELnZoSxdoafp+PyrTLIczqcJkb+RcXGdEEjQ=;
        b=zVbM87B4m8Wmps0f+n9M+QV1h+xJOZlwQUydKYAdnO2yAHdnTpFHBCmmxLy7mPFROM
         L8yvWSOwJzdzAZELiekzph21joek4zZclVys72lp/59zwPUZ4aByMBKPdDphS6AL1ouY
         Hj+asiHxzzNis8CHk/FpurjqSRmNG6v3AHPHKpUA8WTgzxuQdWppt1aziOH0aOgothx0
         68gObw6umA8Iphvy03V7Y7474iuoX66SIjxMW6MihS6oqImDNZJ+T8YI9+x/ymQbpqt3
         pLY0Gu4t+VVH6ej5AvzV7w6dNEI0DK83dOeZZzwywATGomRpSjsRVx8xT1pfSm1iaCIP
         VNfg==
X-Gm-Message-State: AOAM531MdlxCd17FB/GOX7KySzfXGXvXbpFLAhWns3GEML3PVc7H6c2t
        +CsdrMQoFgAoIkPxg6oSHj8PYihHe86E30inxXJ43g==
X-Google-Smtp-Source: ABdhPJzVOeErgr6Vf0sFYcN9jag0yuKJlP5kR1fHeL7WaglNJCR0i6mRudPPfGaAjRaIW5LD691y6pzB5rD+f6zdwWU=
X-Received: by 2002:a1c:770e:: with SMTP id t14mr18046026wmi.173.1636567150039;
 Wed, 10 Nov 2021 09:59:10 -0800 (PST)
MIME-Version: 1.0
References: <20211105170943.3479315-1-irogers@google.com> <20211105170943.3479315-7-irogers@google.com>
 <YYvBhfyizI+z8SAC@krava> <CAP-5=fWRzptEG2TUALNJaVLdP2egHhyhPZ=9HuP2da68jiPPTA@mail.gmail.com>
 <YYvYnYPg43acgkvs@krava>
In-Reply-To: <YYvYnYPg43acgkvs@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 10 Nov 2021 09:58:57 -0800
Message-ID: <CAP-5=fU4JCn_8VY3KstN3bZeV-uRptO0hzyBFy=rGNtap1WRbw@mail.gmail.com>
Subject: Re: [PATCH 6/7] perf expr: Add metric literals for topology.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Song Liu <song@kernel.org>, Wan Jiabing <wanjiabing@vivo.com>,
        Yury Norov <yury.norov@gmail.com>,
        Changbin Du <changbin.du@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 10, 2021 at 6:35 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Nov 10, 2021 at 06:19:04AM -0800, Ian Rogers wrote:
> > On Wed, Nov 10, 2021 at 4:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Nov 05, 2021 at 10:09:42AM -0700, Ian Rogers wrote:
> > > > Allow the number of cpus, cores, dies and packages to be queried by a
> > > > metric expression.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/tests/expr.c | 12 +++++++++++-
> > > >  tools/perf/util/expr.c  | 27 +++++++++++++++++++++++++++
> > > >  2 files changed, 38 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > > > index 9ee2dc91c27b..0c09ccc76665 100644
> > > > --- a/tools/perf/tests/expr.c
> > > > +++ b/tools/perf/tests/expr.c
> > > > @@ -66,7 +66,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> > > >  {
> > > >       struct expr_id_data *val_ptr;
> > > >       const char *p;
> > > > -     double val;
> > > > +     double val, num_cpus, num_cores, num_dies, num_packages;
> > > >       int ret;
> > > >       struct expr_parse_ctx *ctx;
> > > >
> > > > @@ -161,6 +161,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> > > >                       NULL, ctx) == 0);
> > > >       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> > > >
> > > > +     /* Test toplogy constants appear well ordered. */
> > > > +     expr__ctx_clear(ctx);
> > > > +     TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> > > > +     TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
> > > > +     TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
> > > > +     TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
> > > > +     TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
> > > > +     TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
> > > > +     TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> > > > +
> > > >       expr__ctx_free(ctx);
> > > >
> > > >       return 0;
> > > > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > > > index 7464739c2890..15af8b8ef5e7 100644
> > > > --- a/tools/perf/util/expr.c
> > > > +++ b/tools/perf/util/expr.c
> > > > @@ -5,6 +5,8 @@
> > > >  #include <stdlib.h>
> > > >  #include <string.h>
> > > >  #include "metricgroup.h"
> > > > +#include "cpumap.h"
> > > > +#include "cputopo.h"
> > > >  #include "debug.h"
> > > >  #include "expr.h"
> > > >  #include "expr-bison.h"
> > > > @@ -375,9 +377,34 @@ double expr_id_data__value(const struct expr_id_data *data)
> > > >
> > > >  double expr__get_literal(const char *literal)
> > > >  {
> > > > +     static struct cpu_topology *topology;
> > > > +
> > > >       if (!strcmp("#smt_on", literal))
> > > >               return smt_on() > 0 ? 1.0 : 0.0;
> > > >
> > > > +     if (!strcmp("#num_cpus", literal))
> > > > +             return cpu__max_present_cpu();
> > > > +
> > > > +     /*
> > > > +      * Assume that topology strings are consistent, such as CPUs "0-1"
> > > > +      * wouldn't be listed as "0,1", and so after deduplication the number of
> > > > +      * these strings gives an indication of the number of packages, dies,
> > > > +      * etc.
> > > > +      */
> > > > +     if (!topology) {
> > > > +             topology = cpu_topology__new();
> > >
> > > any chance we could propagate expr_scanner_ctx in here and store topology
> > > to it and release it at the end? I think we have several places like this,
> > > so it'd be nice not to make more if it's possible ;-)
> >
> > The topology here is static and so will only get computed once per
> > execution rather than once pre expression parse. I was worried about
> > the cost of recomputing the topology for something like 'perf stat -I
> > 1000 -M ...' in which case the static will do less recomputation.
>
> can't we have the topology created/release on the top fo the parsing
> and released after all expressions are parsed?
>
> or we could come up with some generic way to handle this kind of release

Creating the topology at the top of metric parsing would incur a sysfs
parsing cost on metrics regardless of whether they used the topology.
I feel a lazy approach is better to avoid this cost. We could make
this part of the expression context and lazily initialize it there.
It'd be good to keep the expression context around in 'perf stat' in
that case. I quite like this approach as really the topology should be
part of the perf environment and part of the header. It is interesting
to think how can we get metrics to work with 'perf stat record'.
Currently you will get metrics for something like 'perf stat record -e
instructions,cycles -a sleep 2; perf stat report', but none baked in
metrics don't work and we don't even have the metric-id to make this
work (even using '-M IPC' doesn't work). Putting the environment in
the session, making the topology part of it, writing/reading data
based on that seems like worthwhile clean up but beyond the scope of
what I was trying to do here.

In terms of releasing for the sake of memory leaks, leak sanitizer
doesn't treat memory allocated and reachable from a global as a leak.
We can't precompute the topology and so this style of approach is what
I'm used to. Putting the topology into the parsing context and lazily
initializing would be the second best option imo, and I can do that if
this is a blocker.

Thanks,
Ian

> jirka
>
> >
> > Thanks,
> > Ian
> >
> > > thanks,
> > > jirka
> > >
> > > > +             if (!topology) {
> > > > +                     pr_err("Error creating CPU topology");
> > > > +                     return NAN;
> > > > +             }
> > > > +     }
> > > > +     if (!strcmp("#num_packages", literal))
> > > > +             return topology->package_cpus_lists;
> > > > +     if (!strcmp("#num_dies", literal))
> > > > +             return topology->die_cpus_lists;
> > > > +     if (!strcmp("#num_cores", literal))
> > > > +             return topology->core_cpus_lists;
> > > > +
> > > >       pr_err("Unrecognized literal '%s'", literal);
> > > >       return NAN;
> > > >  }
> > > > --
> > > > 2.34.0.rc0.344.g81b53c2807-goog
> > > >
> > >
> >
>
