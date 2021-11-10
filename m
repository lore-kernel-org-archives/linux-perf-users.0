Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84595C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 18:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C9B261178
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 18:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhKJScE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47154 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232096AbhKJScE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 13:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636568956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ckaC4HApZN9hZGfKlYmJ3lbe5VmvvuXCdyrcPx2tqXY=;
        b=dXZ+mj9PSYdGN6wcmLKEIlR22RALd0khlrpCuhvFiWV+vE9xlSyw+sAO7dtqhWBz0jYnXQ
        SBIhtuUS2HXuPS136EuiT/mbreMZ4FXUXCCuSNfdb4xx41jixVmYfZbN0Nt5+NXL0p525L
        qPIvvlDALMoxMFb/2dM0FCJvuZC1GtI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-hv02_mEKOqKT42bpcta_sQ-1; Wed, 10 Nov 2021 13:29:14 -0500
X-MC-Unique: hv02_mEKOqKT42bpcta_sQ-1
Received: by mail-wm1-f72.google.com with SMTP id l187-20020a1c25c4000000b0030da46b76daso3477894wml.9
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 10:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ckaC4HApZN9hZGfKlYmJ3lbe5VmvvuXCdyrcPx2tqXY=;
        b=PXs36+IUZnzD+yTu0Xo5vyHp5SoAUcwJb3wOXNES1O2zirFqBOf/qwlrGzYCoZjili
         HNolJdNForBCyYZqbir8LU6ThASsrNJdjBUGsGn0hIcXadvr/+Jfjld5GkXr/5bkKLV/
         0POlyhVLBnKTMLJy6jUEDTJgeXjY4NG9XCLP7QcjLwJHOgl/pK9/7sRDAjlsJGGWklM9
         BsQnf5TICqbL+QYj1wBBb72cHRsgNcOMzuds4A2Pi6MM6kRMIIA5SafoYpqNdTWHWDIV
         +OKJe/BKrTu5pR0W3GxlgSR/MAdXJDepJX8OhDYeKAEdgrEX/Orj7sKFyqWyxi1SG6IY
         UBxA==
X-Gm-Message-State: AOAM530t9SZ2qSsqUfVBVY5BPdQHJ3KRNgddUn5sRJ6si7UNJ9rQKQnL
        wjOLLsD6teWvyb6R3OPE3Z50RPWp0U93syX+KiLc+MeJ0nWR/5DP4iBTbHeZjGik4tkyKlMzGMK
        58DJDnKPs6EBKMo3nI1jDoS2WkQfcjw==
X-Received: by 2002:a05:600c:a0b:: with SMTP id z11mr19161380wmp.147.1636568953467;
        Wed, 10 Nov 2021 10:29:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxLNc+b6q1bOBa1tUYi+GlKpjxtH5KVHH3xHHPQdLoHjDBHgBPOijDSdCW1wnanyUW0q4ladg==
X-Received: by 2002:a05:600c:a0b:: with SMTP id z11mr19161343wmp.147.1636568953236;
        Wed, 10 Nov 2021 10:29:13 -0800 (PST)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o12sm601367wmq.12.2021.11.10.10.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 10:29:12 -0800 (PST)
Date:   Wed, 10 Nov 2021 19:29:11 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH 6/7] perf expr: Add metric literals for topology.
Message-ID: <YYwPdzgVlbenb2ai@krava>
References: <20211105170943.3479315-1-irogers@google.com>
 <20211105170943.3479315-7-irogers@google.com>
 <YYvBhfyizI+z8SAC@krava>
 <CAP-5=fWRzptEG2TUALNJaVLdP2egHhyhPZ=9HuP2da68jiPPTA@mail.gmail.com>
 <YYvYnYPg43acgkvs@krava>
 <CAP-5=fU4JCn_8VY3KstN3bZeV-uRptO0hzyBFy=rGNtap1WRbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU4JCn_8VY3KstN3bZeV-uRptO0hzyBFy=rGNtap1WRbw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 10, 2021 at 09:58:57AM -0800, Ian Rogers wrote:
> On Wed, Nov 10, 2021 at 6:35 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Nov 10, 2021 at 06:19:04AM -0800, Ian Rogers wrote:
> > > On Wed, Nov 10, 2021 at 4:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Fri, Nov 05, 2021 at 10:09:42AM -0700, Ian Rogers wrote:
> > > > > Allow the number of cpus, cores, dies and packages to be queried by a
> > > > > metric expression.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/tests/expr.c | 12 +++++++++++-
> > > > >  tools/perf/util/expr.c  | 27 +++++++++++++++++++++++++++
> > > > >  2 files changed, 38 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > > > > index 9ee2dc91c27b..0c09ccc76665 100644
> > > > > --- a/tools/perf/tests/expr.c
> > > > > +++ b/tools/perf/tests/expr.c
> > > > > @@ -66,7 +66,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> > > > >  {
> > > > >       struct expr_id_data *val_ptr;
> > > > >       const char *p;
> > > > > -     double val;
> > > > > +     double val, num_cpus, num_cores, num_dies, num_packages;
> > > > >       int ret;
> > > > >       struct expr_parse_ctx *ctx;
> > > > >
> > > > > @@ -161,6 +161,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> > > > >                       NULL, ctx) == 0);
> > > > >       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> > > > >
> > > > > +     /* Test toplogy constants appear well ordered. */
> > > > > +     expr__ctx_clear(ctx);
> > > > > +     TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> > > > > +     TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
> > > > > +     TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
> > > > > +     TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
> > > > > +     TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
> > > > > +     TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
> > > > > +     TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> > > > > +
> > > > >       expr__ctx_free(ctx);
> > > > >
> > > > >       return 0;
> > > > > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > > > > index 7464739c2890..15af8b8ef5e7 100644
> > > > > --- a/tools/perf/util/expr.c
> > > > > +++ b/tools/perf/util/expr.c
> > > > > @@ -5,6 +5,8 @@
> > > > >  #include <stdlib.h>
> > > > >  #include <string.h>
> > > > >  #include "metricgroup.h"
> > > > > +#include "cpumap.h"
> > > > > +#include "cputopo.h"
> > > > >  #include "debug.h"
> > > > >  #include "expr.h"
> > > > >  #include "expr-bison.h"
> > > > > @@ -375,9 +377,34 @@ double expr_id_data__value(const struct expr_id_data *data)
> > > > >
> > > > >  double expr__get_literal(const char *literal)
> > > > >  {
> > > > > +     static struct cpu_topology *topology;
> > > > > +
> > > > >       if (!strcmp("#smt_on", literal))
> > > > >               return smt_on() > 0 ? 1.0 : 0.0;
> > > > >
> > > > > +     if (!strcmp("#num_cpus", literal))
> > > > > +             return cpu__max_present_cpu();
> > > > > +
> > > > > +     /*
> > > > > +      * Assume that topology strings are consistent, such as CPUs "0-1"
> > > > > +      * wouldn't be listed as "0,1", and so after deduplication the number of
> > > > > +      * these strings gives an indication of the number of packages, dies,
> > > > > +      * etc.
> > > > > +      */
> > > > > +     if (!topology) {
> > > > > +             topology = cpu_topology__new();
> > > >
> > > > any chance we could propagate expr_scanner_ctx in here and store topology
> > > > to it and release it at the end? I think we have several places like this,
> > > > so it'd be nice not to make more if it's possible ;-)
> > >
> > > The topology here is static and so will only get computed once per
> > > execution rather than once pre expression parse. I was worried about
> > > the cost of recomputing the topology for something like 'perf stat -I
> > > 1000 -M ...' in which case the static will do less recomputation.
> >
> > can't we have the topology created/release on the top fo the parsing
> > and released after all expressions are parsed?
> >
> > or we could come up with some generic way to handle this kind of release
> 
> Creating the topology at the top of metric parsing would incur a sysfs
> parsing cost on metrics regardless of whether they used the topology.
> I feel a lazy approach is better to avoid this cost. We could make
> this part of the expression context and lazily initialize it there.
> It'd be good to keep the expression context around in 'perf stat' in
> that case. I quite like this approach as really the topology should be
> part of the perf environment and part of the header. It is interesting
> to think how can we get metrics to work with 'perf stat record'.
> Currently you will get metrics for something like 'perf stat record -e
> instructions,cycles -a sleep 2; perf stat report', but none baked in
> metrics don't work and we don't even have the metric-id to make this
> work (even using '-M IPC' doesn't work). Putting the environment in
> the session, making the topology part of it, writing/reading data
> based on that seems like worthwhile clean up but beyond the scope of
> what I was trying to do here.
> 
> In terms of releasing for the sake of memory leaks, leak sanitizer
> doesn't treat memory allocated and reachable from a global as a leak.
> We can't precompute the topology and so this style of approach is what
> I'm used to. Putting the topology into the parsing context and lazily
> initializing would be the second best option imo, and I can do that if
> this is a blocker.

ok, let's leave it as it is.. thanks for the details

jirka

