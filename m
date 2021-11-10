Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407DFC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 14:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2E36112F
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 14:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbhKJOiF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 09:38:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232240AbhKJOiC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 09:38:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636554914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XzTh+Q15aMwIcAcypgPtn2F/6DAjnMg723kzP00nSZs=;
        b=GrA13iVaFYhIEwK2JPG5WBDMhWS9HlxJe92/9eXtlZmWm44ejDOqvaj0nBCB3icEM5yzzG
        UW5Ne9I6Qmb5bxUUDAwsDIQXRjivLyQvfiktINPidJoSXlztsj/Xf+6iF1VU2mNumTxjxQ
        WpwPoaD2qs7mYsDltq/hMzDdTs2PlJQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-dvlCh9CaMSONbJEPTdYYgg-1; Wed, 10 Nov 2021 09:35:13 -0500
X-MC-Unique: dvlCh9CaMSONbJEPTdYYgg-1
Received: by mail-ed1-f70.google.com with SMTP id w12-20020a056402268c00b003e2ab5a3370so2545342edd.0
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 06:35:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XzTh+Q15aMwIcAcypgPtn2F/6DAjnMg723kzP00nSZs=;
        b=yi14yKQIBSyrdY6UewOXrWRwkOMjVVQuWwSEwkF9mJbncD/zjSh4nx6rWZAWe7yloH
         i1IpoAXdMmw9rK2nP5hczjM39wrvn3EmVpz3YQVb5uxVjMded3n4d1XzMwHG2vRsj09Z
         NYHzQJtMIMre+w2vKGckjmFE/tYM9mb8WtZWU+cOiHJKbzlGJ+MeJuWlmPu6HtgYlW2N
         EBMtEw7yyxhhTB2r+W7gIZBLnWlZOIdknXQxeagD7fxyjmealouG0hCRwzX60ZXtP5LJ
         XEBqK67PemxAdol7FQROLOb13TrdKb/ab1MS2SpQVCNZV6/XMGnfUbmw4j/gzW4PkY44
         s61Q==
X-Gm-Message-State: AOAM532byYeE5TYZV/u9piHhbQJqzzbWiqxdUfQu1qYtqDHhsdlA8RWh
        Uw9Z/8ZmgbRsd8lzXRAk/cvSIizxvd+UT5ZIMBvkGkrh+7/bbG7MyHKrM3oyM4UbSli+d6qKHcy
        Gj7A0JHbDrHt9+PBTsgUGwxauWbkl8g==
X-Received: by 2002:a05:6402:40d4:: with SMTP id z20mr83391edb.210.1636554911684;
        Wed, 10 Nov 2021 06:35:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFuMU/1tTXMzHUyT5Ck6EXJ07FUVIIhRksGuhVn/yOPYQaeyzLXJQHByX+EU1ufBKKmPQPWw==
X-Received: by 2002:a05:6402:40d4:: with SMTP id z20mr83351edb.210.1636554911502;
        Wed, 10 Nov 2021 06:35:11 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id sd28sm12700414ejc.37.2021.11.10.06.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 06:35:11 -0800 (PST)
Date:   Wed, 10 Nov 2021 15:35:09 +0100
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
Message-ID: <YYvYnYPg43acgkvs@krava>
References: <20211105170943.3479315-1-irogers@google.com>
 <20211105170943.3479315-7-irogers@google.com>
 <YYvBhfyizI+z8SAC@krava>
 <CAP-5=fWRzptEG2TUALNJaVLdP2egHhyhPZ=9HuP2da68jiPPTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWRzptEG2TUALNJaVLdP2egHhyhPZ=9HuP2da68jiPPTA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 10, 2021 at 06:19:04AM -0800, Ian Rogers wrote:
> On Wed, Nov 10, 2021 at 4:56 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Nov 05, 2021 at 10:09:42AM -0700, Ian Rogers wrote:
> > > Allow the number of cpus, cores, dies and packages to be queried by a
> > > metric expression.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/expr.c | 12 +++++++++++-
> > >  tools/perf/util/expr.c  | 27 +++++++++++++++++++++++++++
> > >  2 files changed, 38 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> > > index 9ee2dc91c27b..0c09ccc76665 100644
> > > --- a/tools/perf/tests/expr.c
> > > +++ b/tools/perf/tests/expr.c
> > > @@ -66,7 +66,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> > >  {
> > >       struct expr_id_data *val_ptr;
> > >       const char *p;
> > > -     double val;
> > > +     double val, num_cpus, num_cores, num_dies, num_packages;
> > >       int ret;
> > >       struct expr_parse_ctx *ctx;
> > >
> > > @@ -161,6 +161,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
> > >                       NULL, ctx) == 0);
> > >       TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
> > >
> > > +     /* Test toplogy constants appear well ordered. */
> > > +     expr__ctx_clear(ctx);
> > > +     TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> > > +     TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
> > > +     TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
> > > +     TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
> > > +     TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
> > > +     TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
> > > +     TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> > > +
> > >       expr__ctx_free(ctx);
> > >
> > >       return 0;
> > > diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> > > index 7464739c2890..15af8b8ef5e7 100644
> > > --- a/tools/perf/util/expr.c
> > > +++ b/tools/perf/util/expr.c
> > > @@ -5,6 +5,8 @@
> > >  #include <stdlib.h>
> > >  #include <string.h>
> > >  #include "metricgroup.h"
> > > +#include "cpumap.h"
> > > +#include "cputopo.h"
> > >  #include "debug.h"
> > >  #include "expr.h"
> > >  #include "expr-bison.h"
> > > @@ -375,9 +377,34 @@ double expr_id_data__value(const struct expr_id_data *data)
> > >
> > >  double expr__get_literal(const char *literal)
> > >  {
> > > +     static struct cpu_topology *topology;
> > > +
> > >       if (!strcmp("#smt_on", literal))
> > >               return smt_on() > 0 ? 1.0 : 0.0;
> > >
> > > +     if (!strcmp("#num_cpus", literal))
> > > +             return cpu__max_present_cpu();
> > > +
> > > +     /*
> > > +      * Assume that topology strings are consistent, such as CPUs "0-1"
> > > +      * wouldn't be listed as "0,1", and so after deduplication the number of
> > > +      * these strings gives an indication of the number of packages, dies,
> > > +      * etc.
> > > +      */
> > > +     if (!topology) {
> > > +             topology = cpu_topology__new();
> >
> > any chance we could propagate expr_scanner_ctx in here and store topology
> > to it and release it at the end? I think we have several places like this,
> > so it'd be nice not to make more if it's possible ;-)
> 
> The topology here is static and so will only get computed once per
> execution rather than once pre expression parse. I was worried about
> the cost of recomputing the topology for something like 'perf stat -I
> 1000 -M ...' in which case the static will do less recomputation.

can't we have the topology created/release on the top fo the parsing
and released after all expressions are parsed?

or we could come up with some generic way to handle this kind of release

jirka

> 
> Thanks,
> Ian
> 
> > thanks,
> > jirka
> >
> > > +             if (!topology) {
> > > +                     pr_err("Error creating CPU topology");
> > > +                     return NAN;
> > > +             }
> > > +     }
> > > +     if (!strcmp("#num_packages", literal))
> > > +             return topology->package_cpus_lists;
> > > +     if (!strcmp("#num_dies", literal))
> > > +             return topology->die_cpus_lists;
> > > +     if (!strcmp("#num_cores", literal))
> > > +             return topology->core_cpus_lists;
> > > +
> > >       pr_err("Unrecognized literal '%s'", literal);
> > >       return NAN;
> > >  }
> > > --
> > > 2.34.0.rc0.344.g81b53c2807-goog
> > >
> >
> 

