Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041BAC433FE
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 22:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJJWx0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiJJWxZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 18:53:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B5E7A53B
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:53:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o20-20020a05600c4fd400b003b4a516c479so7177388wmq.1
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 15:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2/7dBLvcYggq0WlSYa7mtXAxbb5Cng6Hp/hFVrEbwzw=;
        b=J9LdGmZKcfPt6F+ikOtoqh9Xvdmp7IkzhQK98M3fOznPeTEkmpk8yNzmy4+48rE0J0
         7Kcuh57dA8NWOo6YjdkC3X0GOodDM9zHsWMa4JBHnfThfd832MT05WWtJZpGucf0UKGY
         DcuwAOQTKOz9kcSQ08tmvmjAYfsEGP5pQOJS2DIwnE9/ph0dihRl84L5zkDbqFSiXjnT
         lD4BKHxL2F8SZSX4C+FzLEkLGgfq714K7JwzTqgc0LjPUXCtK3zYbMvbYxPFGtx41rV/
         ndE7zwIxVrjPrg2LvF43vS1C3jOwPRTPJG1IFcVMWIYrzZGzzwAy20Sa6oR/g/nX9B49
         XsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2/7dBLvcYggq0WlSYa7mtXAxbb5Cng6Hp/hFVrEbwzw=;
        b=uRrfsreJ1CezFHds55NOUVB3OXDGmlSKv442iZ5l4O5cyOyYNzncuPVaW8f+zO9LEb
         9qtTeC+D1HcaLTbuge+5ij1Y4Y65GvrjWuVll+W7VsZOp3AIX4K4rvbEiBArzIAwjX9Q
         ZoMCAB6d18tsuv6CvTTuh/ObtxfO4qLX24i9R34LT5yhSBui/1yvJwQs4JKrOrZtBzF6
         YfNNJmr36x02vvOxk/Am621GmzUKGBpnnk3dYkZOfJCG/pkJHuKM5cfU3k5D0nwafGPS
         IIPlbYi6TN+F+XwgEgvzST0Fij18nSwFxwhuWSMSMcMFEc0fvrk+Yc6HfKuKbWyOgOSe
         nbIw==
X-Gm-Message-State: ACrzQf1r+hXAeF+dPEtUuAbqcade+SccYfblOu9tvE1xYk3PX0xTw8+G
        gh+8UtfKYkOLY43ZDRO2TCvde86KLq9J4YINxB+jjw==
X-Google-Smtp-Source: AMsMyM5/vTRfmBmpbvrKwlrvzMtzpAS136crdZ8ProtuYh2cC6nFUKMMnFyYj8u5fIH7nXBFKndBuY7I5+XzeB3p3sA=
X-Received: by 2002:a05:600c:88a:b0:3c5:c9e3:15cc with SMTP id
 l10-20020a05600c088a00b003c5c9e315ccmr7002458wmp.67.1665442402945; Mon, 10
 Oct 2022 15:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-7-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 15:53:10 -0700
Message-ID: <CAP-5=fWe5sgNJTYyLf26jmF6whHVGth5Ss+0TE_JNOJ_gEs76g@mail.gmail.com>
Subject: Re: [PATCH 06/19] perf stat: Add 'needs_sort' argument to cpu_aggr_map__new()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Oct 9, 2022 at 10:36 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> In case of no aggregation, it needs to keep the original (cpu) ordering
> in the aggr_map so that it can be in sync with the cpu map.  This will
> make the code easier to handle AGGR_NONE similar to others.
>

The CPU map is sorted and so sorting the aggr_map should be fine. If
the data is already sorted then it is O(n) to sort. I think this is
preferable to having additional complexity around whether the aggr_map
is sorted.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-stat.c | 7 +++++--
>  tools/perf/util/cpumap.c  | 6 ++++--
>  tools/perf/util/cpumap.h  | 2 +-
>  3 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b00ef20aef5b..e5ddf60ab31d 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1461,8 +1461,9 @@ static int perf_stat_init_aggr_mode(void)
>         aggr_cpu_id_get_t get_id = aggr_mode__get_aggr(stat_config.aggr_mode);
>
>         if (get_id) {
> +               bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
>                 stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
> -                                                        get_id, /*data=*/NULL);
> +                                                        get_id, /*data=*/NULL, needs_sort);
>                 if (!stat_config.aggr_map) {
>                         pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
>                         return -1;
> @@ -1677,11 +1678,13 @@ static int perf_stat_init_aggr_mode_file(struct perf_stat *st)
>  {
>         struct perf_env *env = &st->session->header.env;
>         aggr_cpu_id_get_t get_id = aggr_mode__get_aggr_file(stat_config.aggr_mode);
> +       bool needs_sort = stat_config.aggr_mode != AGGR_NONE;
>
>         if (!get_id)
>                 return 0;
>
> -       stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus, get_id, env);
> +       stat_config.aggr_map = cpu_aggr_map__new(evsel_list->core.user_requested_cpus,
> +                                                get_id, env, needs_sort);
>         if (!stat_config.aggr_map) {
>                 pr_err("cannot build %s map", aggr_mode__string[stat_config.aggr_mode]);
>                 return -1;
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 60209fe87456..6e3fcf523de9 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -234,7 +234,7 @@ static int aggr_cpu_id__cmp(const void *a_pointer, const void *b_pointer)
>
>  struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>                                        aggr_cpu_id_get_t get_id,
> -                                      void *data)
> +                                      void *data, bool needs_sort)
>  {
>         int idx;
>         struct perf_cpu cpu;
> @@ -270,8 +270,10 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>                 if (trimmed_c)
>                         c = trimmed_c;
>         }
> +
>         /* ensure we process id in increasing order */
> -       qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
> +       if (needs_sort)
> +               qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
>
>         return c;
>
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index b2ff648bc417..da28b3146ef9 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -97,7 +97,7 @@ typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(struct perf_cpu cpu, void *data)
>   */
>  struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
>                                        aggr_cpu_id_get_t get_id,
> -                                      void *data);
> +                                      void *data, bool needs_sort);
>
>  bool aggr_cpu_id__equal(const struct aggr_cpu_id *a, const struct aggr_cpu_id *b);
>  bool aggr_cpu_id__is_empty(const struct aggr_cpu_id *a);
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
