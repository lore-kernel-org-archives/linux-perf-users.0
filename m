Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7CCC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E61D61506
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbhKHSYO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:24:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235387AbhKHSYO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:24:14 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5950C061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:21:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r8so5640237iog.7
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d2YD7Z4FLD+GD02XtN2ok0eBFyyNepX4WZSV0b3ntEQ=;
        b=Kkg0HiCq0UcuuHBgy/A5amebpLN//Thbd7fbNzRT0aQO8Fc/Ng3eFCY62NwM9CXQgq
         hrCmHN6fcpw9AHD/yIrqZ/uGeJLQ8/ZXR2KhBL7+FKyRJzsuPejNWyPVMuy7BjKIEM+0
         tagqY8mcxIdihVQr8W4DNOdCBgHswNDEoxg6IoNPy9U+9349QZ6FVdSCGa3TBdqhGrEU
         1wu/SAY9NGawjgBVnUFsU5hPBwbaDpW5iL7NPdirml4vqDy/osfCtLCk5Vtl9Fp+SAwf
         hKoyu/7Wo36MzsUS5w8uP6w1twnwafmsf8eoFo3hSJJ41KoFRyjT/EHKvLQ4osj1cDOO
         IQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d2YD7Z4FLD+GD02XtN2ok0eBFyyNepX4WZSV0b3ntEQ=;
        b=qpbYh7hn5RmchRiUWsu3btX/Xr31xEJCzGN09lTfTR5VKWxD9R0dUUXdSwjnBOgjH+
         W95BQUl20yIqSTAHuM05p0piQlA4WQ3oQ05d6Xf96Yr+d59uQaoGgUoWBvYHgWq41NnC
         8mHfVu4cUxwqXc9hoyCdlpRtrrn3W1RNEVSa0KIsfa68/7IUrvmkOoPKvz+2gchi/eHS
         5lj+/rIxcjOmr4DcLvmWkIg1ZRWsqt2XxhE5uNkCbREoeqx02k6mof19S6RRsPqR9CWo
         aIiTy5JPpK66uHZApWWVy0ZZWm7hwNeCUW7C+vCJcH+FRjRxRUBK7cb4HtBnD3ypRPPe
         gEnw==
X-Gm-Message-State: AOAM531aNgFG+Pp9mk7LAJv2golHn3nK9ufR5sNSCB/Kl+YB3RCwMMi+
        /M2RgWSpoaJ2GY+IieriHsIOX/5Hfxxxdtq6yhw1UQ==
X-Google-Smtp-Source: ABdhPJyRiLE0F7ad4fVzxirUR6Rq7YwjzLgUQjY7I5R+Xw1qUW0ODtnQuSRvql/SslnkAOAWgrCzx/ZYx7mBNuq4Leg=
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr847953jad.21.1636395689160;
 Mon, 08 Nov 2021 10:21:29 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-31-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-31-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 10:21:14 -0800
Message-ID: <CAP-5=fWQtYizPSXw2NPLBhV-W-a=sK_aKC6HNSwNACGE0hUiGQ@mail.gmail.com>
Subject: Re: [PATCH 30/59] libperf: Move in struct parse_events_state
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 8, 2021 at 5:40 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Moving in struct parse_events_state to libperf
> together with related structs.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../lib/perf/include/internal/parse-events.h  | 29 +++++++++++++++++++
>  tools/perf/util/parse-events.h                | 28 ------------------
>  2 files changed, 29 insertions(+), 28 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
> index 46f632efd71b..aff13afa08e1 100644
> --- a/tools/lib/perf/include/internal/parse-events.h
> +++ b/tools/lib/perf/include/internal/parse-events.h
> @@ -5,6 +5,7 @@
>  #include <linux/types.h>
>  #include <linux/list.h>
>  #include <unistd.h>
> +#include <linux/perf_event.h>
>
>  struct event_symbol {
>         const char      *symbol;
> @@ -74,6 +75,34 @@ struct parse_events_term {
>         bool weak;
>  };
>
> +struct parse_events_error {
> +       int   num_errors;       /* number of errors encountered */
> +       int   idx;      /* index in the parsed string */
> +       char *str;      /* string to display at the index */
> +       char *help;     /* optional help string */
> +       int   first_idx;/* as above, but for the first encountered error */
> +       char *first_str;
> +       char *first_help;
> +};

Just to note that this will conflict with the patches in:
https://lore.kernel.org/lkml/YYfyEcPfj5ct7w7Q@kernel.org/
Which may mean a bit larger change.

Thanks,
Ian

> +struct parse_events_ops {
> +       struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
> +       struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
> +};
> +
> +struct parse_events_state {
> +       struct list_head           list;
> +       int                        idx;
> +       int                        nr_groups;
> +       struct parse_events_error *error;
> +       struct perf_evlist        *evlist;
> +       struct list_head          *terms;
> +       int                        stoken;
> +       struct perf_pmu           *fake_pmu;
> +       char                      *hybrid_pmu_name;
> +       struct parse_events_ops   *ops;
> +};
> +
>  int parse_events_term__num(struct parse_events_term **term,
>                            int type_term, char *config, u64 num,
>                            bool novalue,
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index 2f75e823124f..057b92778d17 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -61,34 +61,6 @@ struct perf_pmu_event_symbol {
>         enum perf_pmu_event_symbol_type type;
>  };
>
> -struct parse_events_error {
> -       int   num_errors;       /* number of errors encountered */
> -       int   idx;      /* index in the parsed string */
> -       char *str;      /* string to display at the index */
> -       char *help;     /* optional help string */
> -       int   first_idx;/* as above, but for the first encountered error */
> -       char *first_str;
> -       char *first_help;
> -};
> -
> -struct parse_events_ops {
> -       struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
> -       struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
> -};
> -
> -struct parse_events_state {
> -       struct list_head           list;
> -       int                        idx;
> -       int                        nr_groups;
> -       struct parse_events_error *error;
> -       struct perf_evlist        *evlist;
> -       struct list_head          *terms;
> -       int                        stoken;
> -       struct perf_pmu           *fake_pmu;
> -       char                      *hybrid_pmu_name;
> -       struct parse_events_ops   *ops;
> -};
> -
>  void parse_events__handle_error(struct parse_events_error *err, int idx,
>                                 char *str, char *help);
>  void parse_events__shrink_config_terms(void);
> --
> 2.31.1
>
