Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB77C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 22:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4024D611AD
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 22:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242646AbhIIWjT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Sep 2021 18:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbhIIWjT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Sep 2021 18:39:19 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CAFC061575
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Sep 2021 15:38:09 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a15so4442353iot.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Sep 2021 15:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8DdnJaARMEXFCIn1ATv21wXbd/Uac08dgF8Zs8aP5u4=;
        b=KShW6PSZpMMowvh+hPwcoBd/fd6EOqqzSKX3TdzcGp2yr4Og82KjBHEFc2GMvmN73y
         Ppru/RZzIagm4DhQhBGwdKIqsFXCMBCKgWawWrY5Z7h/ezJ7/mFwn/ROqNiam/00ee53
         nFVHj1lulNT1Kdo4r415KAq/JPYfIbIYPbNM6d6GGGXIV0uovrgMVpCsMFXgpo0FGFUA
         YK/q0BXYhPYlCwjN2y10/AzyRmIKxJ+uBWsMqi1worc+beiXE2gsDzRGFItt8tvBu5G5
         Bf8qhOE26diPIF5LsjNIbKwDe+0VKV0mFmyG2/2fQL4qsULVMiHRuShrNMlajymIi3b9
         PKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8DdnJaARMEXFCIn1ATv21wXbd/Uac08dgF8Zs8aP5u4=;
        b=qzMrjuS6HMnNmxjnJlr/Pld0XpRfHtID0yje2KYlGWRdAtq1wAebnL6EFehkQf3zWC
         TSB61RwxXN2UFV+NgHMvoYuBAgyS1T3WZekSkYoFD6xJgtOxnugnJ4s34PIbf7q0tilB
         ex03DJ5VmlfGx1c7P+i9rtyRSLDPfTZnO3/EFvaBuXKqacTNzLvCV00I8HkYuttOJcoh
         qvH0UGFjS8+YpG5Qhvc5SUrCb3oWs1C5pr4y1coRf0QnwgT3h4TRE4RKgupx/xqxvmTo
         kIfTZ2FOAzeovgIrrRxx6eYuKVVx6UpsQ76DzTPW9QM9wxfSetHUX1ShM0C/Zatk+0KL
         EbQw==
X-Gm-Message-State: AOAM532l52tGNm5Mzo6y2BQb0kUtrbk4itOCVBzz10U/J3hjs0ict+kf
        4brcVpUdTPIVvVQpOuMaBFJBwmrrIbex4T9Tz/pKAg==
X-Google-Smtp-Source: ABdhPJwCJ/BzLRv1xCS5t0zNBA5heGYxiSlS15b3zjtB1oWJQYb7dbQ+5qV58qeFHYmUwAtubbSsO0xrHPfO1SVGC0w=
X-Received: by 2002:a5d:9253:: with SMTP id e19mr4568535iol.35.1631227088205;
 Thu, 09 Sep 2021 15:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210903025239.22754-1-yao.jin@linux.intel.com>
In-Reply-To: <20210903025239.22754-1-yao.jin@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 9 Sep 2021 15:37:56 -0700
Message-ID: <CAP-5=fVT6G6Ysdd39O3XROyKUxAs6uQVeO8mnbsy-Oy5VqujrA@mail.gmail.com>
Subject: Re: [PATCH v2] perf list: Display hybrid pmu events with cpu type
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 2, 2021 at 7:54 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> Add a new option '--cputype' to perf-list to display core-only pmu events
> or atom-only pmu events.
>
> Each hybrid pmu event has been assigned with a pmu name, this patch
> compares the pmu name before listing the result.

Would this work more broadly for any PMU type? If so perhaps pmu
rather than cputype is a more appropriate option name?

Thanks,
Ian

> For example,
>
> perf list --cputype atom
> ...
> cache:
>   core_reject_l2q.any
>        [Counts the number of request that were not accepted into the L2Q because the L2Q is FULL. Unit: cpu_atom]
> ...
>
> The "Unit: cpu_atom" is displayed in the brief description section
> to indicate this is an atom event.
>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v2:
>  - Rebase to perf/core branch.
>
>  tools/perf/Documentation/perf-list.txt |  4 +++
>  tools/perf/builtin-list.c              | 42 ++++++++++++++++++--------
>  tools/perf/util/metricgroup.c          |  7 ++++-
>  tools/perf/util/metricgroup.h          |  2 +-
>  tools/perf/util/parse-events.c         |  8 +++--
>  tools/perf/util/parse-events.h         |  3 +-
>  tools/perf/util/pmu.c                  | 29 +++++++++++++++---
>  tools/perf/util/pmu.h                  |  2 +-
>  8 files changed, 73 insertions(+), 24 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
> index 4c7db1da8fcc..4dc8d0af19df 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -39,6 +39,10 @@ any extra expressions computed by perf stat.
>  --deprecated::
>  Print deprecated events. By default the deprecated events are hidden.
>
> +--cputype::
> +Print events applying cpu with this type for hybrid platform
> +(e.g. --cputype core or --cputype atom)
> +
>  [[EVENT_MODIFIERS]]
>  EVENT MODIFIERS
>  ---------------
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 10ab5e40a34f..468958154ed9 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -12,6 +12,7 @@
>
>  #include "util/parse-events.h"
>  #include "util/pmu.h"
> +#include "util/pmu-hybrid.h"
>  #include "util/debug.h"
>  #include "util/metricgroup.h"
>  #include <subcmd/pager.h>
> @@ -20,13 +21,15 @@
>
>  static bool desc_flag = true;
>  static bool details_flag;
> +static const char *hybrid_type;
>
>  int cmd_list(int argc, const char **argv)
>  {
> -       int i;
> +       int i, ret = 0;
>         bool raw_dump = false;
>         bool long_desc_flag = false;
>         bool deprecated = false;
> +       char *pmu_name = NULL;
>         struct option list_options[] = {
>                 OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
>                 OPT_BOOLEAN('d', "desc", &desc_flag,
> @@ -37,6 +40,9 @@ int cmd_list(int argc, const char **argv)
>                             "Print information on the perf event names and expressions used internally by events."),
>                 OPT_BOOLEAN(0, "deprecated", &deprecated,
>                             "Print deprecated events."),
> +               OPT_STRING(0, "cputype", &hybrid_type, "hybrid cpu type",
> +                          "Print events applying cpu with this type for hybrid platform "
> +                          "(e.g. core or atom)"),
>                 OPT_INCR(0, "debug", &verbose,
>                              "Enable debugging output"),
>                 OPT_END()
> @@ -56,10 +62,16 @@ int cmd_list(int argc, const char **argv)
>         if (!raw_dump && pager_in_use())
>                 printf("\nList of pre-defined events (to be used in -e):\n\n");
>
> +       if (hybrid_type) {
> +               pmu_name = perf_pmu__hybrid_type_to_pmu(hybrid_type);
> +               if (!pmu_name)
> +                       pr_warning("WARNING: hybrid cputype is not supported!\n");
> +       }
> +
>         if (argc == 0) {
>                 print_events(NULL, raw_dump, !desc_flag, long_desc_flag,
> -                               details_flag, deprecated);
> -               return 0;
> +                               details_flag, deprecated, pmu_name);
> +               goto out;
>         }
>
>         for (i = 0; i < argc; ++i) {
> @@ -82,25 +94,27 @@ int cmd_list(int argc, const char **argv)
>                 else if (strcmp(argv[i], "pmu") == 0)
>                         print_pmu_events(NULL, raw_dump, !desc_flag,
>                                                 long_desc_flag, details_flag,
> -                                               deprecated);
> +                                               deprecated, pmu_name);
>                 else if (strcmp(argv[i], "sdt") == 0)
>                         print_sdt_events(NULL, NULL, raw_dump);
>                 else if (strcmp(argv[i], "metric") == 0 || strcmp(argv[i], "metrics") == 0)
> -                       metricgroup__print(true, false, NULL, raw_dump, details_flag);
> +                       metricgroup__print(true, false, NULL, raw_dump, details_flag, pmu_name);
>                 else if (strcmp(argv[i], "metricgroup") == 0 || strcmp(argv[i], "metricgroups") == 0)
> -                       metricgroup__print(false, true, NULL, raw_dump, details_flag);
> +                       metricgroup__print(false, true, NULL, raw_dump, details_flag, pmu_name);
>                 else if ((sep = strchr(argv[i], ':')) != NULL) {
>                         int sep_idx;
>
>                         sep_idx = sep - argv[i];
>                         s = strdup(argv[i]);
> -                       if (s == NULL)
> -                               return -1;
> +                       if (s == NULL) {
> +                               ret = -1;
> +                               goto out;
> +                       }
>
>                         s[sep_idx] = '\0';
>                         print_tracepoint_events(s, s + sep_idx + 1, raw_dump);
>                         print_sdt_events(s, s + sep_idx + 1, raw_dump);
> -                       metricgroup__print(true, true, s, raw_dump, details_flag);
> +                       metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
>                         free(s);
>                 } else {
>                         if (asprintf(&s, "*%s*", argv[i]) < 0) {
> @@ -116,12 +130,16 @@ int cmd_list(int argc, const char **argv)
>                         print_pmu_events(s, raw_dump, !desc_flag,
>                                                 long_desc_flag,
>                                                 details_flag,
> -                                               deprecated);
> +                                               deprecated,
> +                                               pmu_name);
>                         print_tracepoint_events(NULL, s, raw_dump);
>                         print_sdt_events(NULL, s, raw_dump);
> -                       metricgroup__print(true, true, s, raw_dump, details_flag);
> +                       metricgroup__print(true, true, s, raw_dump, details_flag, pmu_name);
>                         free(s);
>                 }
>         }
> -       return 0;
> +
> +out:
> +       free(pmu_name);
> +       return ret;
>  }
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 99d047c5ead0..ad2587079689 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -11,6 +11,7 @@
>  #include "evsel.h"
>  #include "strbuf.h"
>  #include "pmu.h"
> +#include "pmu-hybrid.h"
>  #include "expr.h"
>  #include "rblist.h"
>  #include <string.h>
> @@ -616,7 +617,7 @@ static int metricgroup__print_sys_event_iter(struct pmu_event *pe, void *data)
>  }
>
>  void metricgroup__print(bool metrics, bool metricgroups, char *filter,
> -                       bool raw, bool details)
> +                       bool raw, bool details, const char *pmu_name)
>  {
>         struct pmu_events_map *map = pmu_events_map__find();
>         struct pmu_event *pe;
> @@ -642,6 +643,10 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>                         break;
>                 if (!pe->metric_expr)
>                         continue;
> +               if (pmu_name && perf_pmu__is_hybrid(pe->pmu) &&
> +                   strcmp(pmu_name, pe->pmu)) {
> +                       continue;
> +               }
>                 if (metricgroup__print_pmu_event(pe, metricgroups, filter,
>                                                  raw, details, &groups,
>                                                  metriclist) < 0)
> diff --git a/tools/perf/util/metricgroup.h b/tools/perf/util/metricgroup.h
> index cc4a92492a61..9deee6691f2e 100644
> --- a/tools/perf/util/metricgroup.h
> +++ b/tools/perf/util/metricgroup.h
> @@ -53,7 +53,7 @@ int metricgroup__parse_groups_test(struct evlist *evlist,
>                                    struct rblist *metric_events);
>
>  void metricgroup__print(bool metrics, bool groups, char *filter,
> -                       bool raw, bool details);
> +                       bool raw, bool details, const char *pmu_name);
>  bool metricgroup__has_metric(const char *metric);
>  int arch_get_runtimeparam(struct pmu_event *pe __maybe_unused);
>  void metricgroup__rblist_exit(struct rblist *metric_events);
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index e5eae23cfceb..f36e748ad715 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2995,7 +2995,8 @@ void print_symbol_events(const char *event_glob, unsigned type,
>   * Print the help text for the event symbols:
>   */
>  void print_events(const char *event_glob, bool name_only, bool quiet_flag,
> -                       bool long_desc, bool details_flag, bool deprecated)
> +                       bool long_desc, bool details_flag, bool deprecated,
> +                       const char *pmu_name)
>  {
>         print_symbol_events(event_glob, PERF_TYPE_HARDWARE,
>                             event_symbols_hw, PERF_COUNT_HW_MAX, name_only);
> @@ -3007,7 +3008,7 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
>         print_hwcache_events(event_glob, name_only);
>
>         print_pmu_events(event_glob, name_only, quiet_flag, long_desc,
> -                       details_flag, deprecated);
> +                       details_flag, deprecated, pmu_name);
>
>         if (event_glob != NULL)
>                 return;
> @@ -3033,7 +3034,8 @@ void print_events(const char *event_glob, bool name_only, bool quiet_flag,
>
>         print_sdt_events(NULL, NULL, name_only);
>
> -       metricgroup__print(true, true, NULL, name_only, details_flag);
> +       metricgroup__print(true, true, NULL, name_only, details_flag,
> +                          pmu_name);
>
>         print_libpfm_events(name_only, long_desc);
>  }
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index bf6e41aa9b6a..ce0c910163d1 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -219,7 +219,8 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
>                                int idx, const char *str);
>
>  void print_events(const char *event_glob, bool name_only, bool quiet,
> -                 bool long_desc, bool details_flag, bool deprecated);
> +                 bool long_desc, bool details_flag, bool deprecated,
> +                 const char *pmu_name);
>
>  struct event_symbol {
>         const char      *symbol;
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 6cdbee8a12e7..77204c5af29c 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -1577,6 +1577,7 @@ static int cmp_sevent(const void *a, const void *b)
>  {
>         const struct sevent *as = a;
>         const struct sevent *bs = b;
> +       int ret;
>
>         /* Put extra events last */
>         if (!!as->desc != !!bs->desc)
> @@ -1592,7 +1593,13 @@ static int cmp_sevent(const void *a, const void *b)
>         if (as->is_cpu != bs->is_cpu)
>                 return bs->is_cpu - as->is_cpu;
>
> -       return strcmp(as->name, bs->name);
> +       ret = strcmp(as->name, bs->name);
> +       if (!ret) {
> +               if (as->pmu && bs->pmu)
> +                       return strcmp(as->pmu, bs->pmu);
> +       }
> +
> +       return ret;
>  }
>
>  static void wordwrap(char *s, int start, int max, int corr)
> @@ -1622,7 +1629,8 @@ bool is_pmu_core(const char *name)
>  }
>
>  void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
> -                       bool long_desc, bool details_flag, bool deprecated)
> +                       bool long_desc, bool details_flag, bool deprecated,
> +                       const char *pmu_name)
>  {
>         struct perf_pmu *pmu;
>         struct perf_pmu_alias *alias;
> @@ -1648,10 +1656,16 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>         pmu = NULL;
>         j = 0;
>         while ((pmu = perf_pmu__scan(pmu)) != NULL) {
> +               if (pmu_name && perf_pmu__is_hybrid(pmu->name) &&
> +                   strcmp(pmu_name, pmu->name)) {
> +                       continue;
> +               }
> +
>                 list_for_each_entry(alias, &pmu->aliases, list) {
>                         char *name = alias->desc ? alias->name :
>                                 format_alias(buf, sizeof(buf), pmu, alias);
> -                       bool is_cpu = is_pmu_core(pmu->name);
> +                       bool is_cpu = is_pmu_core(pmu->name) ||
> +                                     perf_pmu__is_hybrid(pmu->name);
>
>                         if (alias->deprecated && !deprecated)
>                                 continue;
> @@ -1699,8 +1713,13 @@ void print_pmu_events(const char *event_glob, bool name_only, bool quiet_flag,
>         qsort(aliases, len, sizeof(struct sevent), cmp_sevent);
>         for (j = 0; j < len; j++) {
>                 /* Skip duplicates */
> -               if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name))
> -                       continue;
> +               if (j > 0 && !strcmp(aliases[j].name, aliases[j - 1].name)) {
> +                       if (!aliases[j].pmu || !aliases[j - 1].pmu ||
> +                           !strcmp(aliases[j].pmu, aliases[j - 1].pmu)) {
> +                               continue;
> +                       }
> +               }
> +
>                 if (name_only) {
>                         printf("%s ", aliases[j].name);
>                         continue;
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 033e8211c025..91fc0de892f5 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -108,7 +108,7 @@ struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
>  bool is_pmu_core(const char *name);
>  void print_pmu_events(const char *event_glob, bool name_only, bool quiet,
>                       bool long_desc, bool details_flag,
> -                     bool deprecated);
> +                     bool deprecated, const char *pmu_name);
>  bool pmu_have_event(const char *pname, const char *name);
>
>  int perf_pmu__scan_file(struct perf_pmu *pmu, const char *name, const char *fmt, ...) __scanf(3, 4);
> --
> 2.27.0
>
