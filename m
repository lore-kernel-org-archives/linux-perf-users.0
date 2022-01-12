Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01BCC433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jan 2022 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343710AbiALRXF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jan 2022 12:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240797AbiALRXE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jan 2022 12:23:04 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5166EC061748
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jan 2022 09:23:04 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id 19so4666410ioz.4
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jan 2022 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J/kXP8SqQiSR4LFSJtIEJPK0TG8hRH/GcTd8e3fRbjs=;
        b=aqjAJjD5sEzzsSormxWUDg+xxR/nVVrhCqo5Bwox0k6u8BHFr4gzNOnQyR4SbJEBlU
         xbVJGwuA4ZHNpMYQ1WZ22wAcLzZDoZTJnkRmAvqm6wEUniRPJjt4W1rvQin9zDna6Uf7
         09FXzkX2W4SCyzfv2dWOvGG4pmAqH7MB5Q4D8XjRvA80FAzdaEuEQDSBySp5Qus87V1z
         ivrJoRfkSDTTv/BPJcG2OnAHxzFIUDpmnttdoVyJvvz46vkcHeojzwXKMgQ21urLLBd/
         Q5sgGLJz9jGF+4rkz+TF7KilSYEw26kZFoLRTVoZskHBZSEYLn/fTaRA+GRcYZ0H6V63
         k92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J/kXP8SqQiSR4LFSJtIEJPK0TG8hRH/GcTd8e3fRbjs=;
        b=fFo1fxSSRcofxgpyk1bkvXC2vbWsBMXygDtXugDNBlvKWt3qLIy53rP6DSony4X//2
         4SjJudrXowpWsCZalyW0DisILDjKsrlowIwv8YRrdpJfh9yerE7uNHwNdMBf9h1m1ctS
         MFzu1SM9MhTLlRa+XEH5A2an77OZzaqOpdg19bzTjbGgLn8cg4MhS1XXvTzt3CJTt2jb
         t5NlRHeHxH/fHaFHYh6floETLkGFRDR2H0fIR1qHzZEKyYMz6NZTABMnPDmMENSaPKg4
         QTYwJ+iMDfXHzeVXAxpjhGmJfnPM3zMW7elcmDkW0xRQXh9eDVqubI6GHrCcAJozY9C+
         fLAw==
X-Gm-Message-State: AOAM532OON1moUps2q0RW9ud/jVScdLgbsMYDHrZ7kEZfGzIXtO2OMeB
        lQbc92pI00UOGZWoCAc+/Wr62Pytb8qFG4uPFe/Hvg==
X-Google-Smtp-Source: ABdhPJw/NzKKgLkxmtrIipbWj99LyLr319P/VDc5fsuulsUImAm9BAUPdJp4oK6zjqvwsi9z2dk8Kvgekj5hYBQguKE=
X-Received: by 2002:a02:22c9:: with SMTP id o192mr352411jao.287.1642008183379;
 Wed, 12 Jan 2022 09:23:03 -0800 (PST)
MIME-Version: 1.0
References: <20211126071305.3733878-1-irogers@google.com>
In-Reply-To: <20211126071305.3733878-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jan 2022 09:22:51 -0800
Message-ID: <CAP-5=fU2kEq3T8UCpX0tAmwcGhZ+1h92uRPbzyuLDNpeCD7ffQ@mail.gmail.com>
Subject: Re: [RFC PATCH] perf pmu-events: Don't lower case MetricExpr
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 25, 2021 at 11:13 PM Ian Rogers <irogers@google.com> wrote:
>
> This patch changes MetricExpr to be written out in the same case. This
> enables events in metrics to use modifiers like 'G' which currently
> yield parse errors when made lower case. To keep tests passing the
> literal #smt_on is compared in a non-case sensitive way - #SMT_on is
> present in at least SkylakeX metrics.

Ping.

Thanks,
Ian

> This patch is on top of:
> https://lore.kernel.org/lkml/20211124001231.3277836-1-irogers@google.com/
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.c | 2 --
>  tools/perf/util/expr.c          | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 2e7c4153875b..1a57c3f81dd4 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -672,8 +672,6 @@ static int json_events(const char *fn,
>                                 addfield(map, &je.metric_constraint, "", "", val);
>                         } else if (json_streq(map, field, "MetricExpr")) {
>                                 addfield(map, &je.metric_expr, "", "", val);
> -                               for (s = je.metric_expr; *s; s++)
> -                                       *s = tolower(*s);
>                         } else if (json_streq(map, field, "ArchStdEvent")) {
>                                 addfield(map, &arch_std, "", "", val);
>                                 for (s = arch_std; *s; s++)
> diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
> index cdbab4f959fe..5cd6b9ff2489 100644
> --- a/tools/perf/util/expr.c
> +++ b/tools/perf/util/expr.c
> @@ -397,7 +397,7 @@ double expr__get_literal(const char *literal)
>         static struct cpu_topology *topology;
>         double result = NAN;
>
> -       if (!strcmp("#smt_on", literal)) {
> +       if (!strcasecmp("#smt_on", literal)) {
>                 result =  smt_on() > 0 ? 1.0 : 0.0;
>                 goto out;
>         }
> --
> 2.34.0.rc2.393.gf8c9666880-goog
>
