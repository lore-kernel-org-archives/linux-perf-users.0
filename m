Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E111FC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 05:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB88B60C51
	for <linux-perf-users@archiver.kernel.org>; Wed, 29 Sep 2021 05:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244181AbhI2FhG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 29 Sep 2021 01:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244110AbhI2FhF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 29 Sep 2021 01:37:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632893725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fYPoJ+HHx7LQ03iNT/GjSChjOpHqMM3m9N+X07o5q5s=;
        b=CBcQUEZmIeobxvIDXodj7mAyaFPqKLr5R2L68xzmoGP0nJi9wre2kccGmzTt5f4XOWjmpI
        iJplDixavLwrNvAleXlypykWXGcFZ9R+RS+4DyF5j/PTpOxJtj0khNe8//Vn+GrtVRM2aK
        7Fs66sgao5aWiVD4Pz1ekHZPIWoFAYQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-uffOuawJNPmO2Qf18Gxi8g-1; Wed, 29 Sep 2021 01:35:23 -0400
X-MC-Unique: uffOuawJNPmO2Qf18Gxi8g-1
Received: by mail-ed1-f71.google.com with SMTP id 1-20020a508741000000b003da559ba1eeso1138709edv.13
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Sep 2021 22:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fYPoJ+HHx7LQ03iNT/GjSChjOpHqMM3m9N+X07o5q5s=;
        b=YFW4qjPTOm7vQsGJEfpLgTNTUnox8WLwuMJX/Exh+HmgOmNqbjI7dCp0gIb/DWDvon
         esNo+EJRcWsej8blTLuIIkQeFjHQMq4wWIl6IyXeYL+BYf+BE21TuBbsav7eNCLzqjAH
         hszgDm30RehndDgvj3YhPofOjxNORdEREHsrxmHMqSJp6R7ZoZcoD+JCPUzZokRV0XdU
         1Igx5RSkmCYgpb/sOWCsjbJ1k4feVtO0gI9k2uurLF/N931Z42ZMcV3EO0dFQIqi9J++
         EMZrGx57Wzt9nFcylRWnqVCcfNtmsexPr8BNbEb4XMM6xx4EzWM7Wexc+hLfhzWGVT70
         mvzA==
X-Gm-Message-State: AOAM531dlw9WoE7mV1NMWfN0Bc+2FDL+FFjHa/uLiYwWlteJ3TBYQ3Ql
        OY8MIA6/iCDF+TNkhqm3VmtMkz8VZuDJOIgSRIjl8j9yrKCiYQQbomTwtJL+XgKe6kLwUa6lnzD
        hiKWPZAcXTx4YaDbs0tWGZxflDxNIEQ==
X-Received: by 2002:a17:906:288f:: with SMTP id o15mr11351002ejd.436.1632893722189;
        Tue, 28 Sep 2021 22:35:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxk2FUc1JVdkjb/gPfZp1EovaTk2jh+U41vmhR343Lp1WWGAa8uqs/LwrWNps/p5POw1hAFrA==
X-Received: by 2002:a17:906:288f:: with SMTP id o15mr11350989ejd.436.1632893722005;
        Tue, 28 Sep 2021 22:35:22 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id h13sm731600edr.4.2021.09.28.22.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 22:35:21 -0700 (PDT)
Date:   Wed, 29 Sep 2021 07:35:19 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
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
Subject: Re: [PATCH v9 00/13] Don't compute events that won't be used in a
 metric.
Message-ID: <YVP7F0NsKR8KIqX4@krava>
References: <20210923074616.674826-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923074616.674826-1-irogers@google.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 23, 2021 at 12:46:03AM -0700, Ian Rogers wrote:
> For a metric like:
>   EVENT1 if #smt_on else EVENT2
>     
> currently EVENT1 and EVENT2 will be measured and then when the metric
> is reported EVENT1 or EVENT2 will be printed depending on the value
> from smt_on() during the expr parsing. Computing both events is
> unnecessary and can lead to multiplexing as discussed in this thread:
> https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/
> 
> This change modifies expression parsing so that constants are
> considered when building the set of ids (events) and only events not
> contributing to a constant value are measured.
> 
> v9. adds a missing memory allocation failure check in the pmu-metrics
>     test.  A memory allocation failure in union returns NULL. Some
>     parser debug on IDs is removed. "Modify code layout" is broken
>     apart into 3 changes.  "Don't compute unused events" is broken
>     apart into 4 changes with the tests merged into the change that
>     adds the corresponding optimization. This is trying to address
>     feedback from Jiri Olsa <jolsa@redhat.com>.  The unmodified
>     patches have Reviewed-by: Andi Kleen <ak@linux.intel.com> added,
>     although the overall patch set is largely the same as v8 which was
>     fully reviewed-by.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> 
> v8. rebases, adds an ability to compute metrics with no events and
>     further breaks apart the "Don't compute unused events" part of the
>     change as requested by Jiri Olsa <jolsa@redhat.com>.
> 
> v7. fixes the fix to be in the correct patch.
> 
> v6. rebases and fixes issues raised by Namhyung Kim <namhyung@kernel.org>,
> a memory leak and a function comment.
> 
> v5. uses macros to reduce boiler plate in patch 5/5 as suggested by
> Andi Kleen <ak@linux.intel.com>.
> 
> v4. reduces references to BOTTOM/NAN in patch 5/5 by using utility
> functions. It improves comments and fixes an unnecessary union in a
> peephole optimization.
> 
> v3. fixes an assignment in patch 2/5. In patch 5/5 additional comments
> are added and useless frees are replaced by asserts. A new peephole
> optimization is added for the case CONST IF expr ELSE CONST, where the
> the constants are identical, as we don't need to evaluate the IF
> condition.
> 
> v2. is a rebase.
> 
> Ian Rogers (13):
>   perf metric: Restructure struct expr_parse_ctx.
>   perf metric: Use NAN for missing event IDs.
>   perf expr: Remove unused headers and inline d_ratio
>   perf expr: Separate token declataion from type
>   perf expr: Use macros for operators
>   perf expr: Move actions to the left.
>   perf metric: Rename expr__find_other.
>   perf metric: Add utilities to work on ids map.
>   perf metric: Allow metrics with no events
>   perf expr: Merge find_ids and regular parsing
>   perf expr: Propagate constants for binary operations
>   perf metric: Don't compute unused events
>   perf metric: Avoid events for an 'if' constant result
> 
>  tools/perf/tests/expr.c       | 160 ++++++++++++-----
>  tools/perf/tests/pmu-events.c |  54 +++---
>  tools/perf/util/expr.c        | 121 +++++++++++--
>  tools/perf/util/expr.h        |  20 ++-
>  tools/perf/util/expr.l        |   9 -
>  tools/perf/util/expr.y        | 325 +++++++++++++++++++++++++---------
>  tools/perf/util/metricgroup.c | 145 ++++++++-------
>  tools/perf/util/stat-shadow.c |  54 +++---
>  8 files changed, 620 insertions(+), 268 deletions(-)
> 
> -- 
> 2.33.0.464.g1972c5931b-goog
> 

