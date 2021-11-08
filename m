Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62286C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460D06134F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhKHSBn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234180AbhKHSBk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:01:40 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E70C061764
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 09:58:54 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v65so19986837ioe.5
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 09:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHThHp9jfU44bAE/LV4Xlx6pAL/7UM6SnzeK448lqY0=;
        b=swIA8LFkrWuRCUG3r6nkxuxd6Y2/C8+myue09DQ5NKQPxv384Hp+CsIyU7mUqLsSzX
         1e5X8LirFlszNsvc/k4KKR5vIiMHTFzLxv77JBRmhv/YTkgowCrL0wmia3xxh2qRh/xk
         NX0SSBHUhuA0PLHUuQa6gWVIq+zRZiQopAQEUuswvcJRu09liwbW9eFER82bVXGn26IJ
         P/8sr0GpVwbextYP3XaXQeKCeyCU5SKKL1zA+IE0bc+3v7gRHyYZWiAjJd+mWOpo7NZz
         K071O83oDj0pyQmWV8uLrLXt1UwdLHYvGi1wm2yWARuTV2k+set7Dbod09LV8uAiNzX6
         HQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHThHp9jfU44bAE/LV4Xlx6pAL/7UM6SnzeK448lqY0=;
        b=MFGAnsVODzFrFn+DS6vvxdtfzgbTvfaDudZzAcjgOrFeO7fubqtl2JtEVD9KYEs1Ry
         bkI0peoIoXz+J1iHBl7B14tkLy9cjDSKvJL5M5yO8jtpZgLXN2QImKglt8mDU9alifxY
         fDk/+FUQQu+1zZ4DcHmz+/LXUZ1+EeYA133Wf54luQ+fEP4ZNN+rF/OZtrYSD64tMCJ+
         kSgBHRYj/eFfYbXyZ0dUpKCf4hMvsbn0lLQ5jz3G84FQOXhDf+BrKKTJ4eE8fUK+g0zu
         MZ/eFf0upPAzgM41MUNyPJmtwD2jYtCN5VkexMvYWn5l68ZFIzaiu3vivPG2aTpSM854
         N7aA==
X-Gm-Message-State: AOAM5305/BOJbob/AeUID7JetADhNLUzKWA5xfEfdnXIT/Y7lkEuMtbj
        whNKzgLeeHNLmdVUhNhv72xp3kp450OjWGAIjxiWxQ==
X-Google-Smtp-Source: ABdhPJzIMQwlxsH0CeCzc91CsxGSh2q6eVxroaT75S0B1LD2Hc+Da/WRABOg74Ucum9AxJ0+l+Phl+65m5Og6eIKUlo=
X-Received: by 2002:a02:950e:: with SMTP id y14mr757997jah.88.1636394333437;
 Mon, 08 Nov 2021 09:58:53 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-19-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-19-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 09:58:39 -0800
Message-ID: <CAP-5=fU=4q5=6ejcc1G4RKdUDbENSLdNVBbP=iWuYiwc8Yq_0Q@mail.gmail.com>
Subject: Re: [PATCH 18/59] libperf: Move group_name to perf_evsel
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 8, 2021 at 5:39 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Moving group_name to perf_evsel struct.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/include/internal/evsel.h |  1 +
>  tools/perf/tests/parse-events.c         | 32 ++++++++++++-------------
>  tools/perf/util/auxtrace.c              |  6 ++---
>  tools/perf/util/evsel.c                 | 10 ++++----
>  tools/perf/util/evsel.h                 |  1 -
>  tools/perf/util/evsel_fprintf.c         |  2 +-
>  tools/perf/util/header.c                |  6 ++---
>  tools/perf/util/parse-events.c          |  4 ++--
>  8 files changed, 31 insertions(+), 31 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index 81df282fa008..befcd180ef3d 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -64,6 +64,7 @@ struct perf_evsel {
>          */
>          struct {
>                  char                   *name;
> +               const char              *group_name;

I like the constification here. But why constify group_name and not
name as well?

Thanks,
Ian

>                 bool                    auto_merge_stats;
>                 struct list_head        config_terms;
>                 const char              *metric_id;
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 15d6d3d907b7..50746bb524f0 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -782,7 +782,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong group name",
> -               !strcmp(leader->group_name, "group1"));
> +               !strcmp(leader->core.group_name, "group1"));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
> @@ -800,7 +800,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 3);
>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
>
> @@ -817,7 +817,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong group name",
> -               !strcmp(leader->group_name, "group2"));
> +               !strcmp(leader->core.group_name, "group2"));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
> @@ -872,7 +872,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> @@ -915,7 +915,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> @@ -947,7 +947,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> @@ -1001,7 +1001,7 @@ static int test__group_gh1(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> @@ -1041,7 +1041,7 @@ static int test__group_gh2(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> @@ -1081,7 +1081,7 @@ static int test__group_gh3(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> @@ -1121,7 +1121,7 @@ static int test__group_gh4(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> @@ -1160,7 +1160,7 @@ static int test__leader_sample1(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
>
> @@ -1189,7 +1189,7 @@ static int test__leader_sample1(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
>
> @@ -1213,7 +1213,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
>
> @@ -1228,7 +1228,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
>
> @@ -1259,7 +1259,7 @@ static int test__pinned_group(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>         TEST_ASSERT_VAL("wrong config",
>                         PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>         TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
>
> @@ -1303,7 +1303,7 @@ static int test__exclusive_group(struct evlist *evlist)
>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
>         TEST_ASSERT_VAL("wrong config",
>                         PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
>         TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
>
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index c679394b898d..a882bc81e0fb 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1235,9 +1235,9 @@ static void unleader_evsel(struct evlist *evlist, struct evsel *leader)
>
>         /* Update group information */
>         if (new_leader) {
> -               zfree(&new_leader->group_name);
> -               new_leader->group_name = leader->group_name;
> -               leader->group_name = NULL;
> +               zfree(&new_leader->core.group_name);
> +               new_leader->core.group_name = leader->core.group_name;
> +               leader->core.group_name = NULL;
>
>                 new_leader->core.nr_members = leader->core.nr_members - 1;
>                 leader->core.nr_members = 1;
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index aafd91805870..7621eddc8e58 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -395,9 +395,9 @@ struct evsel *evsel__clone(struct evsel *orig)
>                 if (evsel->core.name == NULL)
>                         goto out_err;
>         }
> -       if (orig->group_name) {
> -               evsel->group_name = strdup(orig->group_name);
> -               if (evsel->group_name == NULL)
> +       if (orig->core.group_name) {
> +               evsel->core.group_name = strdup(orig->core.group_name);
> +               if (evsel->core.group_name == NULL)
>                         goto out_err;
>         }
>         if (orig->pmu_name) {
> @@ -797,7 +797,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
>
>  const char *evsel__group_name(struct evsel *evsel)
>  {
> -       return evsel->group_name ?: "anon group";
> +       return evsel->core.group_name ?: "anon group";
>  }
>
>  /*
> @@ -1436,7 +1436,7 @@ void evsel__exit(struct evsel *evsel)
>         perf_cpu_map__put(evsel->core.cpus);
>         perf_cpu_map__put(evsel->core.own_cpus);
>         perf_thread_map__put(evsel->core.threads);
> -       zfree(&evsel->group_name);
> +       zfree(&evsel->core.group_name);
>         zfree(&evsel->core.name);
>         zfree(&evsel->pmu_name);
>         zfree(&evsel->core.metric_id);
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index c09bbddd5da0..e06d171baba3 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -54,7 +54,6 @@ struct evsel {
>          * they can be released properly.
>          */
>         struct {
> -               char                    *group_name;
>                 const char              *pmu_name;
>                 struct tep_event        *tp_format;
>                 char                    *filter;
> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> index 8c2ea8001329..4670d1e745b2 100644
> --- a/tools/perf/util/evsel_fprintf.c
> +++ b/tools/perf/util/evsel_fprintf.c
> @@ -48,7 +48,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
>                         return 0;
>
>                 if (evsel->core.nr_members > 1)
> -                       printed += fprintf(fp, "%s{", evsel->group_name ?: "");
> +                       printed += fprintf(fp, "%s{", evsel->core.group_name ?: "");
>
>                 printed += fprintf(fp, "%s", evsel__name(evsel));
>                 for_each_group_member(pos, evsel)
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 4610b23fed28..a14b690a6025 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -788,7 +788,7 @@ static int write_group_desc(struct feat_fd *ff,
>
>         evlist__for_each_entry(evlist, evsel) {
>                 if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
> -                       const char *name = evsel->group_name ?: "{anon_group}";
> +                       const char *name = evsel->core.group_name ?: "{anon_group}";
>                         u32 leader_idx = evsel->core.idx;
>                         u32 nr_members = evsel->core.nr_members;
>
> @@ -2094,7 +2094,7 @@ static void print_group_desc(struct feat_fd *ff, FILE *fp)
>
>         evlist__for_each_entry(session->evlist, evsel) {
>                 if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
> -                       fprintf(fp, "# group: %s{%s", evsel->group_name ?: "", evsel__name(evsel));
> +                       fprintf(fp, "# group: %s{%s", evsel->core.group_name ?: "", evsel__name(evsel));
>
>                         nr = evsel->core.nr_members - 1;
>                 } else if (nr) {
> @@ -2743,7 +2743,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
>                         evsel__set_leader(evsel, evsel);
>                         /* {anon_group} is a dummy name */
>                         if (strcmp(desc[i].name, "{anon_group}")) {
> -                               evsel->group_name = desc[i].name;
> +                               evsel->core.group_name = desc[i].name;
>                                 desc[i].name = NULL;
>                         }
>                         evsel->core.nr_members = desc[i].nr_members;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 24d01b768078..05a96b0f7b41 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1841,7 +1841,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
>         for (i = 0; i < nr_pmu; i++) {
>                 evsel = (struct evsel *) leaders[i];
>                 evsel->core.nr_members = total_members / nr_pmu;
> -               evsel->group_name = name ? strdup(name) : NULL;
> +               evsel->core.group_name = name ? strdup(name) : NULL;
>         }
>
>         /* Take the new small groups into account */
> @@ -1869,7 +1869,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
>
>         __perf_evlist__set_leader(list);
>         leader = list_entry(list->next, struct evsel, core.node);
> -       leader->group_name = name ? strdup(name) : NULL;
> +       leader->core.group_name = name ? strdup(name) : NULL;
>  }
>
>  /* list_event is assumed to point to malloc'ed memory */
> --
> 2.31.1
>
