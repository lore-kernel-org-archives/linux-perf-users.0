Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726D8C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 12:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2E36115B
	for <linux-perf-users@archiver.kernel.org>; Wed, 10 Nov 2021 12:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhKJM7a (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:59:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231904AbhKJM73 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 07:59:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636549002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kfb9OGaFgsDcaAnejXjetAN0Wh7QOUxBXf6grsbHak=;
        b=asWlEIRR8Hpk6O4L4YDx35CVYFRTl5TCjgCDwDFxf1uGJ2g1yOK6cFT0kK8BgXPES9tgZ1
        XFHd6CZkOtASfZqPYgCKgp3oJ8LwirD87xN5xQHdKaA7G+zzgvIy9mF+oVRkVCpe6YMixe
        xsScbSkPNjKZoBQCMyjwVvvsRM8WbXk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-444-xwTKxHMZMmaEr2YO7ZKsUQ-1; Wed, 10 Nov 2021 07:56:41 -0500
X-MC-Unique: xwTKxHMZMmaEr2YO7ZKsUQ-1
Received: by mail-ed1-f70.google.com with SMTP id y20-20020a056402359400b003e28c9bc02cso2249058edc.9
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 04:56:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9kfb9OGaFgsDcaAnejXjetAN0Wh7QOUxBXf6grsbHak=;
        b=fejYyLKE3/Y+UMy94sLBtbX01TtOQpawUZfIWphBmFLiXWZ5DZJBauCJ5Qtzq6MM09
         p5vfV230A8f5PrB9PNct0zE2O5iRTHIW8Rqx1tgsD0eWQg5r+HpoMIOUi/BoTGD24e7q
         /9J7uZjUh4IzXYGj1nsHHqNB6FfRmceBPbKZ1WEGS6y/wdWR2JQPXGJGBf4heL5DvBTI
         9hdF2xqk3rwrpQdo5e1NYSjRDEe2s7EPYPIiC0OcQtITRtoyLQYGwBnH1wdZCNenHt2O
         WUk8dsgm8acPRIxcupNPnf+z1je6IqIhJCcwglZvAJQ7VLYKHMkDkHtXy4Tm5P+EWOz9
         kPYA==
X-Gm-Message-State: AOAM5321s1543Va807EYB07FAEsQrjevCszUdWVhfFmSELFWoYm7CGVp
        du1lXs+sSLej5Getvx2vqp3CEdE5fiK1LcbR3tZfMWFbmryWTZdKKxsTexYk1jwyNVqHVRcfnk4
        fVSDHQBk67s6elF/HQKH4JpSHp5XA3g==
X-Received: by 2002:a50:fd0d:: with SMTP id i13mr20930475eds.309.1636548999827;
        Wed, 10 Nov 2021 04:56:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybYbvsdvF43/8PIqsCVn41khiPSadPtODkUoxuj9JC4/SemMGsTn0VeiBpaZiUDVrjYr05rA==
X-Received: by 2002:a50:fd0d:: with SMTP id i13mr20930443eds.309.1636548999672;
        Wed, 10 Nov 2021 04:56:39 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id r22sm3014355edc.23.2021.11.10.04.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 04:56:39 -0800 (PST)
Date:   Wed, 10 Nov 2021 13:56:37 +0100
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
Message-ID: <YYvBhfyizI+z8SAC@krava>
References: <20211105170943.3479315-1-irogers@google.com>
 <20211105170943.3479315-7-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211105170943.3479315-7-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Nov 05, 2021 at 10:09:42AM -0700, Ian Rogers wrote:
> Allow the number of cpus, cores, dies and packages to be queried by a
> metric expression.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c | 12 +++++++++++-
>  tools/perf/util/expr.c  | 27 +++++++++++++++++++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index 9ee2dc91c27b..0c09ccc76665 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -66,7 +66,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  {
>  	struct expr_id_data *val_ptr;
>  	const char *p;
> -	double val;
> +	double val, num_cpus, num_cores, num_dies, num_packages;
>  	int ret;
>  	struct expr_parse_ctx *ctx;
>  
> @@ -161,6 +161,16 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  			NULL, ctx) == 0);
>  	TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 0);
>  
> +	/* Test toplogy constants appear well ordered. */
> +	expr__ctx_clear(ctx);
> +	TEST_ASSERT_VAL("#num_cpus", expr__parse(&num_cpus, ctx, "#num_cpus") == 0);
> +	TEST_ASSERT_VAL("#num_cores", expr__parse(&num_cores, ctx, "#num_cores") == 0);
> +	TEST_ASSERT_VAL("#num_cpus >= #num_cores", num_cpus >= num_cores);
> +	TEST_ASSERT_VAL("#num_dies", expr__parse(&num_dies, ctx, "#num_dies") == 0);
> +	TEST_ASSERT_VAL("#num_cores >= #num_dies", num_cores >= num_dies);
> +	TEST_ASSERT_VAL("#num_packages", expr__parse(&num_packages, ctx, "#num_packages") == 0);
> +	TEST_ASSERT_VAL("#num_dies >= #num_packages", num_dies >= num_packages);
> +
>  	expr__ctx_free(ctx);
>  
>  	return 0;
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index 7464739c2890..15af8b8ef5e7 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -5,6 +5,8 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include "metricgroup.h"
> +#include "cpumap.h"
> +#include "cputopo.h"
>  #include "debug.h"
>  #include "expr.h"
>  #include "expr-bison.h"
> @@ -375,9 +377,34 @@ double expr_id_data__value(const struct expr_id_data *data)
>  
>  double expr__get_literal(const char *literal)
>  {
> +	static struct cpu_topology *topology;
> +
>  	if (!strcmp("#smt_on", literal))
>  		return smt_on() > 0 ? 1.0 : 0.0;
>  
> +	if (!strcmp("#num_cpus", literal))
> +		return cpu__max_present_cpu();
> +
> +	/*
> +	 * Assume that topology strings are consistent, such as CPUs "0-1"
> +	 * wouldn't be listed as "0,1", and so after deduplication the number of
> +	 * these strings gives an indication of the number of packages, dies,
> +	 * etc.
> +	 */
> +	if (!topology) {
> +		topology = cpu_topology__new();

any chance we could propagate expr_scanner_ctx in here and store topology
to it and release it at the end? I think we have several places like this,
so it'd be nice not to make more if it's possible ;-)

thanks,
jirka

> +		if (!topology) {
> +			pr_err("Error creating CPU topology");
> +			return NAN;
> +		}
> +	}
> +	if (!strcmp("#num_packages", literal))
> +		return topology->package_cpus_lists;
> +	if (!strcmp("#num_dies", literal))
> +		return topology->die_cpus_lists;
> +	if (!strcmp("#num_cores", literal))
> +		return topology->core_cpus_lists;
> +
>  	pr_err("Unrecognized literal '%s'", literal);
>  	return NAN;
>  }
> -- 
> 2.34.0.rc0.344.g81b53c2807-goog
> 

