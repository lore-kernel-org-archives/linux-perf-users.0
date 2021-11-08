Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55710C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A19B61130
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbhKHS07 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235472AbhKHS07 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:26:59 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E08C061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:24:14 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id f9so19553161ioo.11
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4l5J7a4kMoeNKba3jePdj1lRAoyRWauW74ReLgePXrs=;
        b=BpYFWq0EdQOyvIQvpmESh3wVyk8j2dRqxEPEhtMS3zBlxFsCxo/LS+31LZOn4RSFJr
         1Bvt+DFWNSajNnsjHuA+oo6z6CMVEd1tNers05nKLfpZHWe7K+XyUP/BlmvcH9XW7Zdo
         vq8LG680YYjyG9uItobRP4dwuv8fFyQLJ4tVuKS5fsvfMyIO5KRSRxlDHUNP7PfUihzQ
         VWgP7TFvG8jufjZEa9IW8OGwkc2ugZs+Oj4PTM/xmvta7PNY0GlTP95jtyacoY/gEkKL
         ap2Q28f8/sWEtdo/qILVnAF1kq33JDdgmse0agA5gb2O+y/UfD9dBxtXy5OM9muvJLVv
         4OWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4l5J7a4kMoeNKba3jePdj1lRAoyRWauW74ReLgePXrs=;
        b=k835abTFXzcEaXR59S5FFUiBZc09E8p2+Am2VMzqW7qfdenGqcUtsMYY1SDi8RDELA
         OTwSKBwd0iNneQX/swxenVtnnFVFLq8BMA1hLm/r6NIcqlisMwuKh9+k+Xdoy+iaGznz
         Vpiq6pEXJ9PPif5t0yQO0GP+bclAHrtJv7xp+RSEz341mnJreuZlp9WeQyqjZeiPoYLv
         P9vfEtH2Q/rjcxseVSPDuvAVtMG6HB7WsypJ3Ae5C5tvAmTvX0zhDK2SDKGQvd9Zr1TQ
         Q0+olMcWcfvGkIB03BMrTRXviYCPAwIzHVToByqeXmKzw6A4529dh6y9P7C5+55eyhAe
         svfA==
X-Gm-Message-State: AOAM531rMOuhKb8JD3IEtavG0/kI7IOaLhkNj69HBjKQZ9koNyJZjgan
        1tpzru3n6Sg+xsdIGCQbODvW/D5z/SWClrxVrzGX/w==
X-Google-Smtp-Source: ABdhPJwr7vrnIuyn6TEi+wfVZyLxgf2/ZXGV/1S587fuq+1DZf7N2+lln+/X1MqFeJgesOGcgjhRAaZCvJxHczAlgWA=
X-Received: by 2002:a02:8663:: with SMTP id e90mr907902jai.14.1636395852840;
 Mon, 08 Nov 2021 10:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-43-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-43-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 10:23:59 -0800
Message-ID: <CAP-5=fVE+YswCCeAYEtA85u9ggZZ59o_-ONn2W31rWV24fpWQQ@mail.gmail.com>
Subject: Re: [PATCH 42/59] libperf: Move in parse_events_name function
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Nov 8, 2021 at 5:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Moving parse_events_name function to libperf.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/include/internal/parse-events.h |  1 +
>  tools/lib/perf/parse-events.c                  | 12 ++++++++++++
>  tools/perf/util/parse-events.c                 | 12 ------------
>  tools/perf/util/parse-events.h                 |  1 -
>  4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
> index 1d7ee03b8a80..11a85a118480 100644
> --- a/tools/lib/perf/include/internal/parse-events.h
> +++ b/tools/lib/perf/include/internal/parse-events.h
> @@ -137,4 +137,5 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
>                                 char *str, char *help);
>  void parse_events_evlist_error(struct parse_events_state *parse_state,
>                                int idx, const char *str);
> +int parse_events_name(struct list_head *list, const char *name);
>  #endif /* __LIBPERF_PARSE_EVENTS_H */
> diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
> index 07c89a3601b1..6efc2bb73cdf 100644
> --- a/tools/lib/perf/parse-events.c
> +++ b/tools/lib/perf/parse-events.c
> @@ -580,3 +580,15 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
>
>         parse_events__handle_error(parse_state->error, idx, strdup(str), NULL);
>  }
> +
> +int parse_events_name(struct list_head *list, const char *name)
> +{
> +       struct perf_evsel *evsel;
> +
> +       __perf_evlist__for_each_entry(list, evsel) {
> +               if (!evsel->name)
> +                       evsel->name = strdup(name);

It is a pre-existing problem but there should probably be an ENOMEM check here.

Thanks,
Ian

> +       }
> +
> +       return 0;
> +}
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 0f2bf2b48888..1469bdf88f2b 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1721,18 +1721,6 @@ void parse_events__set_leader(char *name, struct list_head *list,
>         leader->core.group_name = name ? strdup(name) : NULL;
>  }
>
> -int parse_events_name(struct list_head *list, const char *name)
> -{
> -       struct evsel *evsel;
> -
> -       __evlist__for_each_entry(list, evsel) {
> -               if (!evsel->core.name)
> -                       evsel->core.name = strdup(name);
> -       }
> -
> -       return 0;
> -}
> -
>  static int
>  comp_pmu(const void *p1, const void *p2)
>  {
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index cc7c6449d423..5530614e7a10 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -63,7 +63,6 @@ struct perf_pmu_event_symbol {
>
>  void parse_events__shrink_config_terms(void);
>  void parse_events__clear_array(struct parse_events_array *a);
> -int parse_events_name(struct list_head *list, const char *name);
>  int parse_events_add_tracepoint(struct parse_events_state *parse_state,
>                                 struct list_head *list,
>                                 const char *sys, const char *event,
> --
> 2.31.1
>
