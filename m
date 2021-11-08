Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F40C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9418B60EE5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbhKHSaM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhKHSaK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:30:10 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B45C061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:27:25 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id z26so2845165iod.10
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:27:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oQP/WxuiAebTrnI6/GjM1jYNcsYTCHvWypTqL01iTK8=;
        b=Ls+OfrXcX9g2WrpaaLDab7AyC2RSxgG0pf/avrUsxRryvMNt6Flb4nShyhDWyh0EK0
         3OwdKyLKEuBgB5W9NMVDvd+p1RhnkhZhgC3B7mW6doQtCB0Xg650gqctZY5I9xO5qWML
         /To9BJKIMxanM6te571vTz+84QHG9u/7nu5YzOtVIJIw9Qm94XEvKU0sC673ZdDAvQST
         oEI6oAIw75R3pmxxg5fo0DpeTnmoPyhv0hOBpidf+AxM+N4m4agQxRW3ajzYv2zREUFc
         j4WJovzcHsHHvkHJRfS+l5jxxyStmTbdlglsjZWUVdkva8Hcu9X46OwA/c1ZwMZhqnn3
         NN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oQP/WxuiAebTrnI6/GjM1jYNcsYTCHvWypTqL01iTK8=;
        b=sACV1uTxb3UgjT32E246h26Sag7oxD+lPNLUGnXwJ3m60rb5h4nO2+HPYH0WHk5I1K
         wG0FA7+CqV3f9JNRBFP0mGaSDdBWGowDOCls49TAhPviM98oK5Auebd7NcmAV39Dw1Ka
         17hNltT12MwcjC2yz75QMFyYRlBkK4hIREZgrEex9umY58GsLoaVrbKF0TM2gN1/SQCE
         T4Dtdyjt4wJsDFN7rULOUk1X5ZGSIcLPVdVHYmDg7j0seJdQGTnQZi8rHDFVk/Iime3I
         Vs9iegJqZmYW0CmdW1qQzrsiAJemRU95UQg/YY1drK7TTID4lLcDO03KMQN01BWm0+86
         6DOQ==
X-Gm-Message-State: AOAM530LXem97dRxWhxyyWqWP8fTsoxtcL9Yvf+CSG3xkx1DLX1O4Z0D
        pu8WQUGbbnckJleAGqMqhH3NJIeTqA6D3nNF2hqFQg==
X-Google-Smtp-Source: ABdhPJw5WJw9glrM0YQCC5FvNmHcKzFSy9kSVErTgXaW+b+RA34GqHsuo9QlAc4+AnFUDYyTZaizID1Hz3UUG5aP8s8=
X-Received: by 2002:a6b:b886:: with SMTP id i128mr802620iof.151.1636396044897;
 Mon, 08 Nov 2021 10:27:24 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-47-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-47-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 10:27:10 -0800
Message-ID: <CAP-5=fUZyxqJXDuH1kS7fVXy4osCfQGcv9d5yUwuLHjUZumo5g@mail.gmail.com>
Subject: Re: [PATCH 46/59] perf tools: Add add_numeric callback to struct parse_events_ops
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
> Adding add_numeric callback to struct parse_events_ops,
> to allow custom numeric parsing code.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/include/internal/parse-events.h |  5 +++++
>  tools/perf/util/parse-events.c                 |  2 ++
>  tools/perf/util/parse-events.h                 |  4 ----
>  tools/perf/util/parse-events.y                 | 12 ++++++++----
>  4 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
> index 78dd3f989346..cbcf799f8969 100644
> --- a/tools/lib/perf/include/internal/parse-events.h
> +++ b/tools/lib/perf/include/internal/parse-events.h
> @@ -102,6 +102,11 @@ struct parse_events_ops {
>         int (*add_pmu_multi)(struct parse_events_state *parse_state,
>                              char *str, struct list_head *head,
>                              struct list_head **listp);
> +
> +       int (*add_numeric)(struct parse_events_state *parse_state,
> +                          struct list_head *list,
> +                          u32 type, u64 config,
> +                          struct list_head *head_config);
>  };
>
>  struct parse_events_state {
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index c67634c9de0d..a05e1bdb4e60 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1306,6 +1306,7 @@ int parse_events_add_tracepoint(struct parse_events_state *parse_state,
>                                             err, head_config);
>  }
>
> +static
>  int parse_events_add_numeric(struct parse_events_state *parse_state,
>                              struct list_head *list,
>                              u32 type, u64 config,
> @@ -2904,4 +2905,5 @@ static struct parse_events_ops parse_state_ops = {
>         .perf_evsel__delete = perf_evsel__delete_helper,
>         .add_pmu            = parse_events_add_pmu,
>         .add_pmu_multi      = parse_events_multi_pmu_add,
> +       .add_numeric        = parse_events_add_numeric,

Some documentation on the ops would be awesome :-) Especially as this
is allowing configuration and it is not immediately clear what that
could mean when changes happen.

Thanks,
Ian

>  };
> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
> index fa03f8f70f33..40d192cace03 100644
> --- a/tools/perf/util/parse-events.h
> +++ b/tools/perf/util/parse-events.h
> @@ -79,10 +79,6 @@ int parse_events_load_bpf_obj(struct parse_events_state *parse_state,
>                               struct list_head *list,
>                               struct bpf_object *obj,
>                               struct list_head *head_config);
> -int parse_events_add_numeric(struct parse_events_state *parse_state,
> -                            struct list_head *list,
> -                            u32 type, u64 config,
> -                            struct list_head *head_config);
>  int parse_events_add_tool(struct parse_events_state *parse_state,
>                           struct list_head *list,
>                           int tool_event);
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index f903690b3c8a..b23691397374 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -436,6 +436,7 @@ PE_VALUE_SYM_SW
>  event_legacy_symbol:
>  value_sym '/' event_config '/'
>  {
> +       struct parse_events_state *parse_state = _parse_state;
>         struct list_head *list;
>         int type = $1 >> 16;
>         int config = $1 & 255;
> @@ -443,7 +444,7 @@ value_sym '/' event_config '/'
>
>         list = alloc_list();
>         ABORT_ON(!list);
> -       err = parse_events_add_numeric(_parse_state, list, type, config, $3);
> +       err = parse_state->ops->add_numeric(parse_state, list, type, config, $3);
>         parse_events_terms__delete($3);
>         if (err) {
>                 free_list_evsel(_parse_state, list);
> @@ -454,13 +455,14 @@ value_sym '/' event_config '/'
>  |
>  value_sym sep_slash_slash_dc
>  {
> +       struct parse_events_state *parse_state = _parse_state;
>         struct list_head *list;
>         int type = $1 >> 16;
>         int config = $1 & 255;
>
>         list = alloc_list();
>         ABORT_ON(!list);
> -       ABORT_ON(parse_events_add_numeric(_parse_state, list, type, config, NULL));
> +       ABORT_ON(parse_state->ops->add_numeric(parse_state, list, type, config, NULL));
>         $$ = list;
>  }
>  |
> @@ -646,12 +648,13 @@ PE_NAME ':' PE_NAME
>  event_legacy_numeric:
>  PE_VALUE ':' PE_VALUE opt_event_config
>  {
> +       struct parse_events_state *parse_state = _parse_state;
>         struct list_head *list;
>         int err;
>
>         list = alloc_list();
>         ABORT_ON(!list);
> -       err = parse_events_add_numeric(_parse_state, list, (u32)$1, $3, $4);
> +       err = parse_state->ops->add_numeric(_parse_state, list, (u32)$1, $3, $4);
>         parse_events_terms__delete($4);
>         if (err) {
>                 free(list);
> @@ -663,12 +666,13 @@ PE_VALUE ':' PE_VALUE opt_event_config
>  event_legacy_raw:
>  PE_RAW opt_event_config
>  {
> +       struct parse_events_state *parse_state = _parse_state;
>         struct list_head *list;
>         int err;
>
>         list = alloc_list();
>         ABORT_ON(!list);
> -       err = parse_events_add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
> +       err = parse_state->ops->add_numeric(_parse_state, list, PERF_TYPE_RAW, $1, $2);
>         parse_events_terms__delete($2);
>         if (err) {
>                 free(list);
> --
> 2.31.1
>
