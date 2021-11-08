Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE576C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3C761359
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 18:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhKHSSp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235105AbhKHSSp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 13:18:45 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD34FC061570
        for <linux-perf-users@vger.kernel.org>; Mon,  8 Nov 2021 10:16:00 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id s14so17892172ilv.10
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 10:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGsSiA/aW84oGCUv982OYruFDgs8eTiyrUrAWo+DeAM=;
        b=M/hChVaZP2hyZt5MT0xVBgam9xK+iJPDCd3l0P1wEj8/ozQbI5yu17Wp3uZiE7I30S
         mtidwQbgSRGEo6ffheNeQNf8RTLSOnKMgQHkqlRhynPQRLn5CbCR91+sHStXKcwcbV4J
         5hEIdWqtGBDr3BcvfvGsRJBvU4ptjaWPW/iHc6NUuv67Lg7RFB39PQlOtOLbKp90ZHSh
         PwhJPx1UXeZTWKZLaoeTo4ZkhsJbkEmTbplQ+6jYGTWtBMZu58z5yfMPYe5RT5OF4fLw
         qIh3pkVTEbSnjAo/OxHo6oFWjQgHKBU2CtAlmfafi9EMSGNPcNh8NtL3NgJFwYjk1DmF
         Fu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGsSiA/aW84oGCUv982OYruFDgs8eTiyrUrAWo+DeAM=;
        b=3938q1KNBzxMYqUtw6rKyvMMU7UVD6RmLhy4jmfC5gU9RIN+9/YULgqo16WYli+Uwy
         gGkUh0MRUjV8ZTHrG7s6Yy0ZN5P6+5CHtJ3wHZoZ09ELbE6AIQhJdZiGck2HBzx/sH84
         /Y9TjrIvg+KyzETBFDbkjLK0w4Hfy4rpRxsshTAo7Ryd8b40v4tjYHgiHGkJ34+0m+mn
         j89VVGK6Ru2V8WroAxGEu0ygoOiA8/ZxiOO5QMT3HSVe6kXfWm1u3jwNBMqOvdBrKM6V
         u9zgNWPkqxA2Bb+2HXZzwoNVJfjPebyQ7SuymTBteJXCbxL6pz6HM5cujj2ts4DZsGoy
         3ORQ==
X-Gm-Message-State: AOAM530VeXrJjXAFg3NdTGSv+ZFhX51gF95uLKqy/it8XbWvdLrRp5SC
        RqYXDJqOebi/mtBqxtAfWrQ3xVugf4GLOjX1FeJXadwJVvicJw==
X-Google-Smtp-Source: ABdhPJx7kn0S2lYv2g47Q6xxQmJ7RnGai7c/YGDe3npO3g4FhYmSfRXbO9+QhcprRWd02qbMR/AcP0smmwWPgk6ImtU=
X-Received: by 2002:a05:6e02:1bc8:: with SMTP id x8mr798853ilv.150.1636395359886;
 Mon, 08 Nov 2021 10:15:59 -0800 (PST)
MIME-Version: 1.0
References: <20211108133710.1352822-1-jolsa@kernel.org> <20211108133710.1352822-20-jolsa@kernel.org>
In-Reply-To: <20211108133710.1352822-20-jolsa@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 8 Nov 2021 10:15:45 -0800
Message-ID: <CAP-5=fV39pCqjvZeBW4LHXq02nzhPO4zAcR6R3cjMRAthstcuA@mail.gmail.com>
Subject: Re: [PATCH 19/59] perf tools: Fix parse_events_term__num call
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
> We are wrongly passing &config to parse_events_term__num
> as loc_term_ argument.
>
> Fixes: fb0811535e92 ("perf parse-events: Allow config on kernel PMU events")

I think this shows up on the fix as this change moved the code around,
but it didn't originate the issue. This pattern is common in
parse-events.y, are they also problematic?
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/parse-events.y?h=perf/core#n783

Thanks,
Ian

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/parse-events.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 05a96b0f7b41..2bacbab86b09 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1697,8 +1697,7 @@ int parse_events_multi_pmu_add(struct parse_events_state *parse_state,
>
>         if (parse_events_term__num(&term,
>                                    PARSE_EVENTS__TERM_TYPE_USER,
> -                                  config, 1, false, &config,
> -                                       NULL) < 0) {
> +                                  config, 1, false, NULL, NULL) < 0) {
>                 free(config);
>                 goto out_err;
>         }
> --
> 2.31.1
>
