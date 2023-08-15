Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0D2C0015E
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Aug 2023 08:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjHOIRR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Aug 2023 04:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbjHOIRG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Aug 2023 04:17:06 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E63E72
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 01:17:01 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-40c72caec5cso159121cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Aug 2023 01:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692087420; x=1692692220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGGKDDNwGnFQDzqcRZv6uXfyy6kqSDcvWt33DukCwns=;
        b=LHP7LRgi0HwWo/JsQoA/KJowFtt55lXAZ9F1CMz9YTK6LWVVxkJhkw2QNwXq+NV92v
         m3sjTvjIfbAmMHZdetXXZZtW3B3VwoG7J5zab4YSZVqK6hzIcmEQkiLl/WyZX2+mYyqR
         QQd65WXqP2zW2vWFBp9hPRLi3FP1JabL6s30FfuLcQLSjvZI1B1Mx6sB6+kbLqDJo7fI
         6oSwAzG+AqDXCCvYtSHaGppdAX3mQIrWJv6myO8eCiz8YdCZ5/T2zZQuQHTvTfFrpObW
         G0a8iBiqL6ddgdAJhm3de9XFaDnc8UfPniLeeQRTTp3Tnm5hoN33a50q26+TtOiT8ufx
         uFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692087420; x=1692692220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGGKDDNwGnFQDzqcRZv6uXfyy6kqSDcvWt33DukCwns=;
        b=keq2R2CyBslQb5tXVQF2aaMpViHYkwDTHYST5jio2FnNeGquTxSvfUxlHrECu5vKlG
         axvZU5A1NWefRVb8YEO+C2oWDAoQYi06CJkYmhyWoxN3XawceyL6eLmRCYyR0vC6KfOR
         tHWHpXBnKvWsR+aJpru4GEgY27evT09q6zTcPlvhjQdK05ERKxhWWSrq134diIAAde/S
         rDl+rHhRkjKJqYRExdYBh0Ax9ZLMiQasucChMmAWz8b2YU/8fJgMxg3ZZGljDoEtchnZ
         F+kiRku0TnAqhH2iw23ysv5PXYI5zKBbSCpDgWHeT0+8HynQStfdogpY+6vzIaPir8KC
         gJrA==
X-Gm-Message-State: AOJu0YyLq5GrdFLoKHlONxcYQe7Xr1tVfJmKjurB0ID1JO2o3RxF9Yoo
        IAJW2B5yzajQWMEl6QDRbWjFZ5RBLS09mR06KCS5LQ==
X-Google-Smtp-Source: AGHT+IFJLjmq0YlyLOJA7m1XpDyTX80DZqvMd1mwYeyfAmBet8lx03RLtKBykd/NEr59kCdSXOpUh6UEJLM7doIDeGY=
X-Received: by 2002:a05:622a:1888:b0:3f5:2006:50f1 with SMTP id
 v8-20020a05622a188800b003f5200650f1mr814354qtc.12.1692087420657; Tue, 15 Aug
 2023 01:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230811025822.3859771-1-namhyung@kernel.org>
In-Reply-To: <20230811025822.3859771-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Aug 2023 01:16:48 -0700
Message-ID: <CAP-5=fXNTw8sYup-Gavn6u_NpTJv1DCSkxmAonCXdrxJp86MEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf bpf-filter: Fix sample flag check with ||
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 10, 2023 at 7:58=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> For logical OR operator, the actual sample_flags are in the 'groups'
> list so it needs to check entries in the list instead.  Otherwise it
> would show the following error message.
>
>   $ sudo perf record -a -e cycles:p --filter 'period > 100 || weight > 0'=
 sleep 1
>   Error: cycles:p event does not have sample flags 0
>   failed to set filter "BPF" on event cycles:p with 2 (No such file or di=
rectory)
>
> Actually it should warn on 'weight' is used without WEIGHT flag.
>
>   Error: cycles:p event does not have PERF_SAMPLE_WEIGHT
>    Hint: please add -W option to perf record
>   failed to set filter "BPF" on event cycles:p with 2 (No such file or di=
rectory)
>
> Fixes: 4310551b76e0 ("perf bpf filter: Show warning for missing sample fl=
ags")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/bpf-filter.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/tools/perf/util/bpf-filter.c b/tools/perf/util/bpf-filter.c
> index 47f01df658d9..b51544996046 100644
> --- a/tools/perf/util/bpf-filter.c
> +++ b/tools/perf/util/bpf-filter.c
> @@ -62,6 +62,16 @@ static int check_sample_flags(struct evsel *evsel, str=
uct perf_bpf_filter_expr *
>         if (evsel->core.attr.sample_type & expr->sample_flags)
>                 return 0;
>
> +       if (expr->op =3D=3D PBF_OP_GROUP_BEGIN) {
> +               struct perf_bpf_filter_expr *group;
> +
> +               list_for_each_entry(group, &expr->groups, list) {
> +                       if (check_sample_flags(evsel, group) < 0)
> +                               return -1;
> +               }
> +               return 0;
> +       }
> +
>         info =3D get_sample_info(expr->sample_flags);
>         if (info =3D=3D NULL) {
>                 pr_err("Error: %s event does not have sample flags %lx\n"=
,
> --
> 2.41.0.640.ga95def55d0-goog
>
