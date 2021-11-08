Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A5EC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D650061503
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhKHR4o (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 12:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbhKHR4o (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 12:56:44 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE5C061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 09:53:59 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id j28so17849047ila.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C4WiLNQQSOQ7W/xo+m+jjD3GIDJJSLZQOASKnrNeALc=;
        b=UCoOU12O5YTIBMFfL4HOW/1tClk5LXgXq0VlQglazitzySixE6KPq+M8gNIyRYWnY2
         KwyKktBu8CI56vJHbPyXTlb3vI7M+j2xbbUFGgmBAC3xkJy+Ujl/9Q/XQi9Ek/Agce5O
         4zmQUraMVmpUy/DVdXG+Rcdci/Mz62JvKF9LkS+I5UoyKAP5z7rYIlP9IJrLS3jKu6vM
         MCa4wsYFM1A1rK0IzMYJHANuWp9EOPNVLvY0J3/RgdNk9NBm2sjF8zVmxsVBWmah0kXw
         4pqp8YhZbuhg8SdLoDaORwZQqtLY7ANBicOQnfh1UZjqVth73fzBjn0KHV4B/NDbvAh6
         3bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C4WiLNQQSOQ7W/xo+m+jjD3GIDJJSLZQOASKnrNeALc=;
        b=XrSF35WYwjVbFyNFZTJNBAvxs8kPPZHLHka25TkR7heGWtAYyXSPvyCyQd9BRXXvwW
         aCZDHXjLQitDaoB3iuTRBFo9p0nUD5qV1JdJOAuYzxfs6G+8vkiULaqxaRahDdUapqnw
         Zsse51LYhb61FuOT812c3OIEkE7nXkwfePM6BY8+1GepBFub2jSNS5GYrLOkOipV+S35
         ePLS4Ad1/45fWzLTSch/N65Wg8cHWeKqxYqJTgFbJ6opzE98DX3gLrNVUWbn08jnrpp5
         zBpaaqkHiEUMHjm3gcDPEU4LKdzeYOAJjdLTn1VDAMdADatKIuuTlGWTcMqcZT/XePk5
         vDZw==
X-Gm-Message-State: AOAM530uy7Ujk3kWMkSAvt2b4B52pLDSY07MJRh255qNa+iOwdG7jpbi
        Iulb6VdKg7K1ztuHS4/UJ5ltnTEiay36j2NNdjSeSg==
X-Google-Smtp-Source: ABdhPJygra8No6NcGRZio0lEJYsViOMvO3SttdA6OfxeCYB+PKmmmlHemEMQrpDLBIGlR1rMIC+CZhFzQWUCOrE/q30=
X-Received: by 2002:a92:cda2:: with SMTP id g2mr637999ild.2.1636394038712;
 Mon, 08 Nov 2021 09:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-14-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-14-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 09:53:44 -0800
Message-ID: <CAP-5=fVcHtPxS01GJCazeJmF-Jnx07qGAcPpNwM2ocyV7yu63g@mail.gmail.com>
Subject: Re: [PATCH 13/59] libperf: Move exclude_GH to perf_evsel
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 8, 2021 at 5:38 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Moving exclude_GH to perf_evsel struct.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/include/internal/evsel.h | 1 +
>  tools/perf/util/evsel.c                 | 2 +-
>  tools/perf/util/evsel.h                 | 1 -
>  tools/perf/util/parse-events.c          | 4 ++--
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
> index b96c9f4808ca..7f3ee73c5aa5 100644
> --- a/tools/lib/perf/include/internal/evsel.h
> +++ b/tools/lib/perf/include/internal/evsel.h
> @@ -69,6 +69,7 @@ struct perf_evsel {
>                 const char              *metric_id;
>                 enum perf_tool_event    tool_event;
>                 const char              *unit;
> +               int                     exclude_GH;

I think it'd be pretty awesome if when these things get moved around
we added a comment here to explain what the variable means. Perhaps
even put an example :-) In this case it could explain why this is an
int and not a bool. This is a while you are here request rather than a
criticism of the changes which I find fine.

Thanks,
Ian

>         };
>  };
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 133b571e1190..802c7de9e8e3 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -431,7 +431,7 @@ struct evsel *evsel__clone(struct evsel *orig)
>         evsel->use_uncore_alias = orig->use_uncore_alias;
>         evsel->is_libpfm_event = orig->is_libpfm_event;
>
> -       evsel->exclude_GH = orig->exclude_GH;
> +       evsel->core.exclude_GH = orig->core.exclude_GH;
>         evsel->sample_read = orig->sample_read;
>         evsel->core.auto_merge_stats = orig->core.auto_merge_stats;
>         evsel->collect_stat = orig->collect_stat;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index f6cc1e78903f..6c3634ed169a 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -62,7 +62,6 @@ struct evsel {
>                 double                  scale;
>                 struct cgroup           *cgrp;
>                 /* parse modifier helper */
> -               int                     exclude_GH;
>                 int                     sample_read;
>                 bool                    snapshot;
>                 bool                    per_pkg;
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 1878ea1310d3..89787ebc23ef 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1918,7 +1918,7 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
>         int exclusive = evsel ? evsel->core.attr.exclusive : 0;
>
>         int exclude = eu | ek | eh;
> -       int exclude_GH = evsel ? evsel->exclude_GH : 0;
> +       int exclude_GH = evsel ? evsel->core.exclude_GH : 0;
>         int weak = 0;
>         int bpf_counter = 0;
>
> @@ -2049,7 +2049,7 @@ int parse_events__modifier_event(struct list_head *list, char *str, bool add)
>                 evsel->core.attr.exclude_host   = mod.eH;
>                 evsel->core.attr.exclude_guest  = mod.eG;
>                 evsel->core.attr.exclude_idle   = mod.eI;
> -               evsel->exclude_GH          = mod.exclude_GH;
> +               evsel->core.exclude_GH          = mod.exclude_GH;
>                 evsel->sample_read         = mod.sample_read;
>                 evsel->precise_max         = mod.precise_max;
>                 evsel->weak_group          = mod.weak;
> --
> 2.31.1
>
