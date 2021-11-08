Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE855C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6F04613B3
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 21:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240013AbhKHVWe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 16:22:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240023AbhKHVWd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 16:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636406388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BKT+AaVjU5qgWegkY+EPnT7Pk89fZER9eUuHrp8QEfU=;
        b=hNuoS3rJ8TqWLo45KYKC2AG+Y5g9cNTmi2DMMnSLiW0rlvhHQLGzM390BHtJ9telEC8ZGT
        M7HC//Gl5McgGH3ze40luPIIonpT+RYsMK4qk0HRWkD7SbySeoGwP11gcaVgv+ZSz/twNO
        cKUpU8//XLNORk6Sy8J3HN0dq7S///Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Z3Hhd84PNH61xxPvOkdUUg-1; Mon, 08 Nov 2021 16:19:45 -0500
X-MC-Unique: Z3Hhd84PNH61xxPvOkdUUg-1
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a05640242d600b003e28aecc0afso16029254edc.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 13:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BKT+AaVjU5qgWegkY+EPnT7Pk89fZER9eUuHrp8QEfU=;
        b=ZEQt7g10EZo8ZEnQ1tbHYi6JrGZmksJ1yH8Bwcc7Aj189kZb5st/XaOqLmKD7giGAd
         d8WQrMNuQNrMoNX2Y8sp14AJj/hrHuuzbp8hK26iV0Sk1+SmrXf4fRCLWCfnlE/YbUOF
         yvOQz0NE0kF8sdOWFmSFgZFGCq/nOlzORz3fsW21+OroUnyKo47zbHU5/ZaemkEae8Zk
         lcbvfpzcSPSfMSl+qSBU61S8XR2BrLSB0x6xhZEl/AYuyIezF8J4I4+O7Lw4BwRIipWO
         D1M9F2YgVLnWC92Uz7aMjYU7MtT4+LETB+VvHNb4MFZp7kvOCk5LMP3aDMiptIxLsd7X
         zPmw==
X-Gm-Message-State: AOAM531cDUX3zxskUqmxWabFJzta31DGVgSt+SRWy0EUgX//+KsTHe5D
        WlrY/RfkQCk+8VPsrJTxm23c8TnmIqXRZqxJxArsBk/ULpQdLAEJr9Bczm9+waKSpBheCJpHKGJ
        GNih4B9URB+NGKKLqANRt6FM9aqX88g==
X-Received: by 2002:a17:906:a1d0:: with SMTP id bx16mr2889323ejb.94.1636406382981;
        Mon, 08 Nov 2021 13:19:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyx+Q2LLsJftCgmeJKRNzgEKgJqcvwy1eMf8JuKWr5UtwVMWRCZX0hESvKOU3rT1C0ypPaoAA==
X-Received: by 2002:a17:906:a1d0:: with SMTP id bx16mr2889268ejb.94.1636406382614;
        Mon, 08 Nov 2021 13:19:42 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id j3sm8485490ejo.2.2021.11.08.13.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 13:19:42 -0800 (PST)
Date:   Mon, 8 Nov 2021 22:19:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 18/59] libperf: Move group_name to perf_evsel
Message-ID: <YYmUbGz8ZOSnldyy@krava>
References: <20211108133710.1352822-1-jolsa@kernel.org>
 <20211108133710.1352822-19-jolsa@kernel.org>
 <CAP-5=fU=4q5=6ejcc1G4RKdUDbENSLdNVBbP=iWuYiwc8Yq_0Q@mail.gmail.com>
 <D3BB2601-12C9-46D4-82E3-4E2F47604F14@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3BB2601-12C9-46D4-82E3-4E2F47604F14@gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 08, 2021 at 03:07:05PM -0300, Arnaldo Carvalho de Melo wrote:
> 
> 
> On November 8, 2021 2:58:39 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
> >On Mon, Nov 8, 2021 at 5:39 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >>
> >> Moving group_name to perf_evsel struct.
> >>
> >> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >> ---
> >>  tools/lib/perf/include/internal/evsel.h |  1 +
> >>  tools/perf/tests/parse-events.c         | 32 ++++++++++++-------------
> >>  tools/perf/util/auxtrace.c              |  6 ++---
> >>  tools/perf/util/evsel.c                 | 10 ++++----
> >>  tools/perf/util/evsel.h                 |  1 -
> >>  tools/perf/util/evsel_fprintf.c         |  2 +-
> >>  tools/perf/util/header.c                |  6 ++---
> >>  tools/perf/util/parse-events.c          |  4 ++--
> >>  8 files changed, 31 insertions(+), 31 deletions(-)
> >>
> >> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> >> index 81df282fa008..befcd180ef3d 100644
> >> --- a/tools/lib/perf/include/internal/evsel.h
> >> +++ b/tools/lib/perf/include/internal/evsel.h
> >> @@ -64,6 +64,7 @@ struct perf_evsel {
> >>          */
> >>          struct {
> >>                  char                   *name;
> >> +               const char              *group_name;
> >
> >I like the constification here. But why constify group_name and not
> >name as well?
> 
> 
> Can be done in a separate patch, in other series, no?
> 
> I understand that he probably is taking advantage of this move do constify 'group_name', but then, looks unrelated too this move to libperf as well.

definitely separate patch, to have the move separated.. perhaps someone
could do constification patchset ;-) I'll put this one on top of the
patchset

thanks,
jirka

> 
> - Arnaldo
> 
> 
> 
> >
> >Thanks,
> >Ian
> >
> >>                 bool                    auto_merge_stats;
> >>                 struct list_head        config_terms;
> >>                 const char              *metric_id;
> >> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> >> index 15d6d3d907b7..50746bb524f0 100644
> >> --- a/tools/perf/tests/parse-events.c
> >> +++ b/tools/perf/tests/parse-events.c
> >> @@ -782,7 +782,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong group name",
> >> -               !strcmp(leader->group_name, "group1"));
> >> +               !strcmp(leader->core.group_name, "group1"));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
> >> @@ -800,7 +800,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 3);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 1);
> >>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
> >>
> >> @@ -817,7 +817,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong group name",
> >> -               !strcmp(leader->group_name, "group2"));
> >> +               !strcmp(leader->core.group_name, "group2"));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >>         TEST_ASSERT_VAL("wrong sample_read", !evsel->core.sample_read);
> >> @@ -872,7 +872,7 @@ static int test__group4(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip == 1);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >> @@ -915,7 +915,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >> @@ -947,7 +947,7 @@ static int test__group5(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >> @@ -1001,7 +1001,7 @@ static int test__group_gh1(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >> @@ -1041,7 +1041,7 @@ static int test__group_gh2(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >> @@ -1081,7 +1081,7 @@ static int test__group_gh3(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >> @@ -1121,7 +1121,7 @@ static int test__group_gh4(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> >>         TEST_ASSERT_VAL("wrong core.nr_members", evsel->core.nr_members == 2);
> >>         TEST_ASSERT_VAL("wrong group_idx", evsel__group_idx(evsel) == 0);
> >> @@ -1160,7 +1160,7 @@ static int test__leader_sample1(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> >>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
> >>
> >> @@ -1189,7 +1189,7 @@ static int test__leader_sample1(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> >>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
> >>
> >> @@ -1213,7 +1213,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> >>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
> >>
> >> @@ -1228,7 +1228,7 @@ static int test__leader_sample2(struct evlist *evlist __maybe_unused)
> >>         TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
> >>         TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
> >>         TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> >>         TEST_ASSERT_VAL("wrong sample_read", evsel->core.sample_read);
> >>
> >> @@ -1259,7 +1259,7 @@ static int test__pinned_group(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> >>         TEST_ASSERT_VAL("wrong config",
> >>                         PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> >>         TEST_ASSERT_VAL("wrong pinned", evsel->core.attr.pinned);
> >>
> >> @@ -1303,7 +1303,7 @@ static int test__exclusive_group(struct evlist *evlist)
> >>         TEST_ASSERT_VAL("wrong type", PERF_TYPE_HARDWARE == evsel->core.attr.type);
> >>         TEST_ASSERT_VAL("wrong config",
> >>                         PERF_COUNT_HW_CPU_CYCLES == evsel->core.attr.config);
> >> -       TEST_ASSERT_VAL("wrong group name", !evsel->group_name);
> >> +       TEST_ASSERT_VAL("wrong group name", !evsel->core.group_name);
> >>         TEST_ASSERT_VAL("wrong leader", evsel__has_leader(evsel, leader));
> >>         TEST_ASSERT_VAL("wrong exclusive", evsel->core.attr.exclusive);
> >>
> >> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> >> index c679394b898d..a882bc81e0fb 100644
> >> --- a/tools/perf/util/auxtrace.c
> >> +++ b/tools/perf/util/auxtrace.c
> >> @@ -1235,9 +1235,9 @@ static void unleader_evsel(struct evlist *evlist, struct evsel *leader)
> >>
> >>         /* Update group information */
> >>         if (new_leader) {
> >> -               zfree(&new_leader->group_name);
> >> -               new_leader->group_name = leader->group_name;
> >> -               leader->group_name = NULL;
> >> +               zfree(&new_leader->core.group_name);
> >> +               new_leader->core.group_name = leader->core.group_name;
> >> +               leader->core.group_name = NULL;
> >>
> >>                 new_leader->core.nr_members = leader->core.nr_members - 1;
> >>                 leader->core.nr_members = 1;
> >> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> >> index aafd91805870..7621eddc8e58 100644
> >> --- a/tools/perf/util/evsel.c
> >> +++ b/tools/perf/util/evsel.c
> >> @@ -395,9 +395,9 @@ struct evsel *evsel__clone(struct evsel *orig)
> >>                 if (evsel->core.name == NULL)
> >>                         goto out_err;
> >>         }
> >> -       if (orig->group_name) {
> >> -               evsel->group_name = strdup(orig->group_name);
> >> -               if (evsel->group_name == NULL)
> >> +       if (orig->core.group_name) {
> >> +               evsel->core.group_name = strdup(orig->core.group_name);
> >> +               if (evsel->core.group_name == NULL)
> >>                         goto out_err;
> >>         }
> >>         if (orig->pmu_name) {
> >> @@ -797,7 +797,7 @@ const char *evsel__metric_id(const struct evsel *evsel)
> >>
> >>  const char *evsel__group_name(struct evsel *evsel)
> >>  {
> >> -       return evsel->group_name ?: "anon group";
> >> +       return evsel->core.group_name ?: "anon group";
> >>  }
> >>
> >>  /*
> >> @@ -1436,7 +1436,7 @@ void evsel__exit(struct evsel *evsel)
> >>         perf_cpu_map__put(evsel->core.cpus);
> >>         perf_cpu_map__put(evsel->core.own_cpus);
> >>         perf_thread_map__put(evsel->core.threads);
> >> -       zfree(&evsel->group_name);
> >> +       zfree(&evsel->core.group_name);
> >>         zfree(&evsel->core.name);
> >>         zfree(&evsel->pmu_name);
> >>         zfree(&evsel->core.metric_id);
> >> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >> index c09bbddd5da0..e06d171baba3 100644
> >> --- a/tools/perf/util/evsel.h
> >> +++ b/tools/perf/util/evsel.h
> >> @@ -54,7 +54,6 @@ struct evsel {
> >>          * they can be released properly.
> >>          */
> >>         struct {
> >> -               char                    *group_name;
> >>                 const char              *pmu_name;
> >>                 struct tep_event        *tp_format;
> >>                 char                    *filter;
> >> diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
> >> index 8c2ea8001329..4670d1e745b2 100644
> >> --- a/tools/perf/util/evsel_fprintf.c
> >> +++ b/tools/perf/util/evsel_fprintf.c
> >> @@ -48,7 +48,7 @@ int evsel__fprintf(struct evsel *evsel, struct perf_attr_details *details, FILE
> >>                         return 0;
> >>
> >>                 if (evsel->core.nr_members > 1)
> >> -                       printed += fprintf(fp, "%s{", evsel->group_name ?: "");
> >> +                       printed += fprintf(fp, "%s{", evsel->core.group_name ?: "");
> >>
> >>                 printed += fprintf(fp, "%s", evsel__name(evsel));
> >>                 for_each_group_member(pos, evsel)
> >> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> >> index 4610b23fed28..a14b690a6025 100644
> >> --- a/tools/perf/util/header.c
> >> +++ b/tools/perf/util/header.c
> >> @@ -788,7 +788,7 @@ static int write_group_desc(struct feat_fd *ff,
> >>
> >>         evlist__for_each_entry(evlist, evsel) {
> >>                 if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
> >> -                       const char *name = evsel->group_name ?: "{anon_group}";
> >> +                       const char *name = evsel->core.group_name ?: "{anon_group}";
> >>                         u32 leader_idx = evsel->core.idx;
> >>                         u32 nr_members = evsel->core.nr_members;
> >>
> >> @@ -2094,7 +2094,7 @@ static void print_group_desc(struct feat_fd *ff, FILE *fp)
> >>
> >>         evlist__for_each_entry(session->evlist, evsel) {
> >>                 if (evsel__is_group_leader(evsel) && evsel->core.nr_members > 1) {
> >> -                       fprintf(fp, "# group: %s{%s", evsel->group_name ?: "", evsel__name(evsel));
> >> +                       fprintf(fp, "# group: %s{%s", evsel->core.group_name ?: "", evsel__name(evsel));
> >>
> >>                         nr = evsel->core.nr_members - 1;
> >>                 } else if (nr) {
> >> @@ -2743,7 +2743,7 @@ static int process_group_desc(struct feat_fd *ff, void *data __maybe_unused)
> >>                         evsel__set_leader(evsel, evsel);
> >>                         /* {anon_group} is a dummy name */
> >>                         if (strcmp(desc[i].name, "{anon_group}")) {
> >> -                               evsel->group_name = desc[i].name;
> >> +                               evsel->core.group_name = desc[i].name;
> >>                                 desc[i].name = NULL;
> >>                         }
> >>                         evsel->core.nr_members = desc[i].nr_members;
> >> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> >> index 24d01b768078..05a96b0f7b41 100644
> >> --- a/tools/perf/util/parse-events.c
> >> +++ b/tools/perf/util/parse-events.c
> >> @@ -1841,7 +1841,7 @@ parse_events__set_leader_for_uncore_aliase(char *name, struct list_head *list,
> >>         for (i = 0; i < nr_pmu; i++) {
> >>                 evsel = (struct evsel *) leaders[i];
> >>                 evsel->core.nr_members = total_members / nr_pmu;
> >> -               evsel->group_name = name ? strdup(name) : NULL;
> >> +               evsel->core.group_name = name ? strdup(name) : NULL;
> >>         }
> >>
> >>         /* Take the new small groups into account */
> >> @@ -1869,7 +1869,7 @@ void parse_events__set_leader(char *name, struct list_head *list,
> >>
> >>         __perf_evlist__set_leader(list);
> >>         leader = list_entry(list->next, struct evsel, core.node);
> >> -       leader->group_name = name ? strdup(name) : NULL;
> >> +       leader->core.group_name = name ? strdup(name) : NULL;
> >>  }
> >>
> >>  /* list_event is assumed to point to malloc'ed memory */
> >> --
> >> 2.31.1
> >>
> 

