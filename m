Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26208C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 18:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiJFSwV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 14:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiJFSwV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Oct 2022 14:52:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C137FB0B1A
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Oct 2022 11:52:19 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j7so4068100wrr.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Oct 2022 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2q27jP6E6NElEQiCWI0qcz0t4HAjzaD9Xdkel7gLsl4=;
        b=Ifnwo9S4Jl5LgelDyL2JFpUPyE9ddOjLnDpXlxg7pX7lCnZgPte3qA7SAcrchSrL6w
         o4jnAZbQGgIIlE+oGZBkrr79nqZMc5nFFz8RlMxsv/ykNz9dpJ6s3pCwNhpytoJgcERY
         afQ1lbWt8LW+xsnoZLhsOEoWK5NjSY1V70l8ZjLfVa7vNVUYDlOOKp3SMdZcTftFXQY6
         8lfzkI6D9ooBSZextaJ06JJjPSYLQ46aWkY8y0I1EUevxzzkwBEd/bsrrzvWinJJ9G4r
         /HPOipHAbW/QGK+2JFD9DnvOw2yjvTZS7usBBCMrUtKER8SUueQeVNyYKXRI8ELDv+KM
         1Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2q27jP6E6NElEQiCWI0qcz0t4HAjzaD9Xdkel7gLsl4=;
        b=upjQsBrFspWwJN8miiDDFvldqPnUsPuXJ4t5SVnIo3bJ2ODEmFTyrUFWjDw3stfmaC
         Vb8HHzpPFhaZOz0cMNTngIRIypf30dg6WWOGSydy/Ir1h2TPFw3c/b9sohgzaPa7fqcJ
         q1L92nLD8C6z5NGz1sfNhB6T2v1VhX4y8QnWYbnPToK42Rw6T9qjMMi/wIesYluYFUBI
         llLttXg1br20rNK21AENtuwfoFtUr5LFSTXmPbJafRt+Lqd53l9Cr8SI/JUQ2dzcSRnP
         q/oGR3qhmeOQiSUleG6ufrnKc2aTAcL/b+pDVvIXOLm/B1d74TZ1hwYR+D4Ttvj/+uai
         Lh/Q==
X-Gm-Message-State: ACrzQf03p9DWanZQjr4QuoAQjpXqH9z2LeApG0nbWXz1WNedv6kZV+jD
        96pf59tqnh4HOBjoD7aE8RSQC3V1ZOLXnacyHF+IgA==
X-Google-Smtp-Source: AMsMyM6LB/ZB7nq8S8fT13EgJtvqV4p0x2AOalPf6ph/D3TirEfYEWAx0+tQsAwDH0Dlc83twXUItmPhHzVE3sxfPhY=
X-Received: by 2002:adf:fd50:0:b0:22e:5503:9c4c with SMTP id
 h16-20020adffd50000000b0022e55039c4cmr877835wrs.375.1665082338122; Thu, 06
 Oct 2022 11:52:18 -0700 (PDT)
MIME-Version: 1.0
References: <20221003204647.1481128-1-namhyung@kernel.org> <20221003204647.1481128-3-namhyung@kernel.org>
In-Reply-To: <20221003204647.1481128-3-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 6 Oct 2022 11:52:05 -0700
Message-ID: <CAP-5=fUw9j=PJrJ1khM2L9bpYbFYK3=0MKeeJqT2Y5mGasCvJA@mail.gmail.com>
Subject: Re: [PATCH 2/5] libperf: Propagate maps only if necessary
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Oct 3, 2022 at 1:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The current code propagate evsel's cpu map settings to evlist when it's
> added to an evlist.  But the evlist->all_cpus and each evsel's cpus will
> be updated in perf_evlist__set_maps() later.  No need to do it before
> evlist's cpus are set actually.
>
> In fact it discards this intermediate all_cpus maps at the beginning
> of perf_evlist__set_maps().  Let's not do this.  It's only needed when
> an evsel is added after the evlist cpu/thread maps are set.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/evlist.c                  | 11 ++++-------
>  tools/lib/perf/include/internal/evlist.h |  1 +
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index 187129652ab6..8ce92070086c 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -67,9 +67,7 @@ static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
>  {
>         struct perf_evsel *evsel;
>
> -       /* Recomputing all_cpus, so start with a blank slate. */
> -       perf_cpu_map__put(evlist->all_cpus);
> -       evlist->all_cpus = NULL;
> +       evlist->needs_map_propagation = true;

Might be nice to also clear this in  perf_evlist__init.

>
>         perf_evlist__for_each_evsel(evlist, evsel)
>                 __perf_evlist__propagate_maps(evlist, evsel);
> @@ -81,7 +79,9 @@ void perf_evlist__add(struct perf_evlist *evlist,
>         evsel->idx = evlist->nr_entries;
>         list_add_tail(&evsel->node, &evlist->entries);
>         evlist->nr_entries += 1;
> -       __perf_evlist__propagate_maps(evlist, evsel);
> +
> +       if (evlist->needs_map_propagation)
> +               __perf_evlist__propagate_maps(evlist, evsel);

I think a comment here would be useful. Something like:
Adding events won't set the CPU maps in the evlist until
set_maps/propogate_maps is called. Catch the case that an evsel is
added after this and propagate the map.

Thanks,
Ian

>  }
>
>  void perf_evlist__remove(struct perf_evlist *evlist,
> @@ -177,9 +177,6 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
>                 evlist->threads = perf_thread_map__get(threads);
>         }
>
> -       if (!evlist->all_cpus && cpus)
> -               evlist->all_cpus = perf_cpu_map__get(cpus);
> -
>         perf_evlist__propagate_maps(evlist);
>  }
>
> diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
> index 6f89aec3e608..850f07070036 100644
> --- a/tools/lib/perf/include/internal/evlist.h
> +++ b/tools/lib/perf/include/internal/evlist.h
> @@ -19,6 +19,7 @@ struct perf_evlist {
>         int                      nr_entries;
>         int                      nr_groups;
>         bool                     has_user_cpus;
> +       bool                     needs_map_propagation;
>         /**
>          * The cpus passed from the command line or all online CPUs by
>          * default.
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
