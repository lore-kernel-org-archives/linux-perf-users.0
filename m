Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6687BC25B4E
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 17:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjAXRDN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234608AbjAXRCi (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 12:02:38 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6994DCF0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 09:02:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so13296265wma.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 09:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hww7XDIMPWfn/YjbvHbaubFFaqHXt1LFf2Mw/SUUACI=;
        b=D0HV8kuuS7LPC8j01FGHyV/OJ14aoIKR9xmDoLNywLaPP8exhXgNj8J7vLP/710sdJ
         6hkdDS86LvDiLkTv3w1u1XkL/TSjddwN3+k22/9oWsMgUt6HBsUp0HQpzhHm8eEvrMfk
         5Cg0iqfKke65C9q1yp3heUtGlDMf3E/f5z9R5jGFDhRn/zf2MOB0mP2bH5T8PQ4AYsY1
         cYAlLNgw7M6uolipz/Q+P5P85fPm+5mDe2Z+sGUrucUtWaONkEry3s3jJ0HI1xjfB19D
         cLb6pScHeC9GcJ5PiIGVU9V9AhGAQqrgZ+chRPI/LbyA+5FC2FP75KW9I3/sP8lDe24H
         LlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hww7XDIMPWfn/YjbvHbaubFFaqHXt1LFf2Mw/SUUACI=;
        b=xNHB9WWeowk2yzRiag8MEr9/Bq3NpnSD/prf0kBPNrV0cPs+/rChnhvRX+xsDLwOJx
         dC8zkEDEzG91Z6lMC6Lp7un1XRGo3iL2WO5NI8Cdhg98VNrqqMYA93jxjvZD9Uchnvta
         t39I1b4LCXOBx8eryNM+3XRytuJYc34QBYgIvpa3vDLgrajPoOxa+Il4yUeio6zIvLJI
         WU88gSzUuyssGiAQ5AALBbZgOPNRQG+gvudsL42pYnHZt/cuzzmZh95DTQVLKiMRnvEX
         eiu5yhRuO1sUjLaylZ/WMV2wwyXkvuAIDzSmP+vZYRQOkBr2U3/uD+/fxzVIirEY6on9
         /gKg==
X-Gm-Message-State: AFqh2kpp3vkykZR4JDf+uxxh9qDtFEWXGsNNbilNnH1zkHJ1sQHw+1Tw
        d+4gqOPwaEhRHiQnC6JruW8neRkJYFwmSxoTzuvJjiEpkG3fRsQOBUQ=
X-Google-Smtp-Source: AMrXdXsR1Do4oiIIMFlvlXMzmKJJ0iQOxUxHrLHzPQkGQkWVV9JOR6OzlzLYiffmmDljt6dxnrAd0OlaH4h9O4L4Z64=
X-Received: by 2002:a05:600c:1c9a:b0:3d9:ee45:8a9e with SMTP id
 k26-20020a05600c1c9a00b003d9ee458a9emr1353464wms.174.1674579753898; Tue, 24
 Jan 2023 09:02:33 -0800 (PST)
MIME-Version: 1.0
References: <20230123211310.127532-1-raj.khem@gmail.com>
In-Reply-To: <20230123211310.127532-1-raj.khem@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Jan 2023 09:02:22 -0800
Message-ID: <CAP-5=fWoQrn3i-Vpec0w8y4djq=PLhbR6TTeQ4XxKaR-bBDZAw@mail.gmail.com>
Subject: Re: [PATCH] perf cpumap: Make counter as unsigned ints
To:     Khem Raj <raj.khem@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jan 23, 2023 at 1:13 PM Khem Raj <raj.khem@gmail.com> wrote:
>
> These are loop counters which is inherently unsigned. Therefore make
> them unsigned. Moreover it also fixes alloc-size-larger-than
> error with gcc-13, where malloc can be called with (-1) due to tmp_len
> being an int type.
>
> Fixes
> | cpumap.c:366:20: error: argument 1 range [18446744065119617024, 18446744073709551612] exceeds maximum object size 9223372036854775807 [-Werror=alloc-size-larger-than=]
> |   366 |         tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> |       |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/lib/perf/cpumap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> index 6cd0be7c1bb4..d960880dd903 100644
> --- a/tools/lib/perf/cpumap.c
> +++ b/tools/lib/perf/cpumap.c
> @@ -351,8 +351,8 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
>                                          struct perf_cpu_map *other)
>  {
>         struct perf_cpu *tmp_cpus;
> -       int tmp_len;
> -       int i, j, k;
> +       unsigned int tmp_len;
> +       unsigned int i, j, k;
>         struct perf_cpu_map *merged;
>
>         if (perf_cpu_map__is_subset(orig, other))
> @@ -369,7 +369,7 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
>
>         /* Standard merge algorithm from wikipedia */
>         i = j = k = 0;
> -       while (i < orig->nr && j < other->nr) {
> +       while (i < (unsigned int)orig->nr && j < (unsigned int)other->nr) {

Rather than cast 'nr' why not add the unsigned to the declaration?

Thanks,
Ian

>                 if (orig->map[i].cpu <= other->map[j].cpu) {
>                         if (orig->map[i].cpu == other->map[j].cpu)
>                                 j++;
> @@ -378,10 +378,10 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
>                         tmp_cpus[k++] = other->map[j++];
>         }
>
> -       while (i < orig->nr)
> +       while (i < (unsigned int)orig->nr)
>                 tmp_cpus[k++] = orig->map[i++];
>
> -       while (j < other->nr)
> +       while (j < (unsigned int)other->nr)
>                 tmp_cpus[k++] = other->map[j++];
>         assert(k <= tmp_len);
>
> --
> 2.39.1
>
