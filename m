Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48626C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJJXhW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 19:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJJXhV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 19:37:21 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A316967154
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:37:19 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so19049298wrb.13
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wOFrw5L6E4tI0Pf3OamOCWasrHtI4ULdJstjQvMqtK0=;
        b=EleNOctxxCcFFE45zPIcH9yZ3aWsU6J/g2BLj06jsIywNCe2KxyuMfhoen4TjLxs67
         LXZOA5zAml8wpscuOkFj8u5I6uZi1w1P0Jp8G3TugSH57u1t3vwYUW0RMwaIoTHMudI0
         Xu0yTMmEpx50zUKC6AyYKjZRe9s5Ma8h+vGq5Lf40Ucj3CJKIZIVW+8X/lLcoOTeaXRb
         adXQQnXQR+RI/Eeyxk0HoC+yXytuq6Lvdq9Y0yuRK4Gypvs0Psxy8nJLdMNwJpFyX4vv
         A9Po7HVU3qSYxNCRzUckNUnMhN3M0qBnoIlsl/XWFJd8hSW6+J4KkwYS1Smh1PK/hFuE
         yCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOFrw5L6E4tI0Pf3OamOCWasrHtI4ULdJstjQvMqtK0=;
        b=0zNoj6lvsuOdYQl2UxyFgtLbfNHdRYjYnHnBUQy0i3N3momd4QZ1JrlZBaIpjWVERC
         n6IzT7O/5OUy6ffYJQgnNkFrp2Je46tjHAPsqHpRZAtFAVS77qm9BkhkLm/YGyqaCn+u
         CeR5KPavukxid5LLX29e7KsJ3eeS1xiqwdb2OuXoiKZMwxM39RT8y7kNt267hyQJosaO
         UVfQqgbbyV7A5OL6vNVaoBaF12fcKYmEPEfaOStum6AEPbKWlw7laJNBTazIMnFNjk/a
         x1jXdswmqrZcsVVJuVPbkUBNQgG6vArM6Kq7ZyDHqOrjMbZF1uc7VsjkWBBw4DHXCS7n
         TuBQ==
X-Gm-Message-State: ACrzQf2nPx9S0u8Cy27FzbnGg+Kf73CdxBP92hZNVmTJZ7uu9Y6jqf9G
        dj21viHSgmZHnHVUR/qZS7yomo1AhCsU2KhVTVTASDzbpTE=
X-Google-Smtp-Source: AMsMyM6mqNEp4BEg9NCs4plRDTK01oGNfCCqN+jSA/19hea8d859REwm2S9m0Vmbju1yTmW0ljoU0ub/N/4OTou+sZU=
X-Received: by 2002:a05:6000:168f:b0:22e:4c3:de09 with SMTP id
 y15-20020a056000168f00b0022e04c3de09mr12847129wrd.40.1665445027996; Mon, 10
 Oct 2022 16:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-17-namhyung@kernel.org>
In-Reply-To: <20221010053600.272854-17-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Oct 2022 16:36:56 -0700
Message-ID: <CAP-5=fXrhHrOqSNGdHY6V=QDw7YvDRpyTPX7ZmN1p8LkPG+=Wg@mail.gmail.com>
Subject: Re: [PATCH 16/19] perf stat: Add perf_stat_process_shadow_stats()
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
> This function updates the shadow stats using the aggregated counts
> uniformly since it uses the aggr_counts for the every aggr mode.
>
> It'd have duplicate shadow stats for each items for now since the
> display routines will update them once again.  But that'd be fine
> as it shows the average values and it'd be gone eventually.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c |  1 +
>  tools/perf/util/stat.c    | 50 ++++++++++++++++++++-------------------
>  tools/perf/util/stat.h    |  1 +
>  3 files changed, 28 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index c127e784a7be..d92815f4eae0 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -489,6 +489,7 @@ static void process_counters(void)
>
>         perf_stat_merge_counters(&stat_config, evsel_list);
>         perf_stat_process_percore(&stat_config, evsel_list);
> +       perf_stat_process_shadow_stats(&stat_config, evsel_list);
>  }
>
>  static void process_interval(void)
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index d788d0e85204..f2a3761dacff 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -454,7 +454,7 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 aggr_counts->val += count->val;
>                 aggr_counts->ena += count->ena;
>                 aggr_counts->run += count->run;
> -               goto update;
> +               return 0;
>         }
>
>         if (ps->aggr) {
> @@ -491,32 +491,10 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
>                 }
>         }
>
> -update:
> -       switch (config->aggr_mode) {
> -       case AGGR_THREAD:
> -       case AGGR_CORE:
> -       case AGGR_DIE:
> -       case AGGR_SOCKET:
> -       case AGGR_NODE:
> -       case AGGR_NONE:
> -               if ((config->aggr_mode == AGGR_NONE) && (!evsel->percore)) {
> -                       perf_stat__update_shadow_stats(evsel, count->val,
> -                                                      cpu_map_idx, &rt_stat);
> -               }
> -
> -               if (config->aggr_mode == AGGR_THREAD) {
> -                       perf_stat__update_shadow_stats(evsel, count->val,
> -                                                      thread, &rt_stat);
> -               }
> -               break;
> -       case AGGR_GLOBAL:
> +       if (config->aggr_mode == AGGR_GLOBAL) {
>                 aggr->val += count->val;
>                 aggr->ena += count->ena;
>                 aggr->run += count->run;
> -       case AGGR_UNSET:
> -       case AGGR_MAX:
> -       default:
> -               break;
>         }
>
>         return 0;
> @@ -742,6 +720,30 @@ void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *e
>                 evsel__process_percore(evsel);
>  }
>
> +static void evsel__update_shadow_stats(struct evsel *evsel)
> +{
> +       struct perf_stat_evsel *ps = evsel->stats;
> +       int i;
> +
> +       if (ps->aggr == NULL)
> +               return;
> +
> +       for (i = 0; i < ps->nr_aggr; i++) {
> +               struct perf_counts_values *aggr_counts = &ps->aggr[i].counts;
> +
> +               perf_stat__update_shadow_stats(evsel, aggr_counts->val, i, &rt_stat);
> +       }
> +}
> +
> +void perf_stat_process_shadow_stats(struct perf_stat_config *config __maybe_unused,
> +                                   struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       evlist__for_each_entry(evlist, evsel)
> +               evsel__update_shadow_stats(evsel);
> +}
> +
>  int perf_event__process_stat_event(struct perf_session *session,
>                                    union perf_event *event)
>  {
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index ac85ed46aa59..e51214918c7f 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -273,6 +273,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
>                               struct evsel *counter);
>  void perf_stat_merge_counters(struct perf_stat_config *config, struct evlist *evlist);
>  void perf_stat_process_percore(struct perf_stat_config *config, struct evlist *evlist);
> +void perf_stat_process_shadow_stats(struct perf_stat_config *config, struct evlist *evlist);
>
>  struct perf_tool;
>  union perf_event;
> --
> 2.38.0.rc1.362.ged0d419d3c-goog
>
