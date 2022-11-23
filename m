Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5A9C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Nov 2022 23:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiKWXeW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Nov 2022 18:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiKWXeP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Nov 2022 18:34:15 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547562A421
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:34:09 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso65272wmp.5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Nov 2022 15:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ta2Zb663w+hTcqdpNUGC4OtuQUTQUUplhbDEWR91618=;
        b=PW7/IdvYDe1fY2xW3B2vR7IAaprWV+VDcV7m3onc30QaWM4mA03Ao5zi6rbnN3Hy8a
         vYpUO+ZAymzFIWgb7cIdyNJFRPtYmXEfo85KrduP4ht2IyYUqJlXaghtXaLB8vrrZdSO
         c9YAFg722ximDKZfRYYAPYTAqNai8T6ozKH9z/+HeownU8g+0d7GJj81AMreLm86T6Lg
         RiqErMUyxMCYWbbVAwRwCRC4/UE9QzqQtB/nSLkcqOdPe3B8af96OxrYogYknJnZtpxG
         QPuzy1Dhoy8uRjWN+3JvVjaw4MA4p05fXimeZFfMuDxNTVit00X9CDV6eDhYAaGC5eJx
         lEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ta2Zb663w+hTcqdpNUGC4OtuQUTQUUplhbDEWR91618=;
        b=bShi1hvnXJuB/qMWIPwExK4no1lTr1IOzvEwS296jVoPh4MnXeYlu4DWAVzr5ZXXVi
         btA1fR7WupImAX1UIuUcBuELj8Juomf2Cm1cPQlwovs73fy7+Sg25VTpOPZUkJ/3Tj/V
         lvaGYWHwOH6j+S3DUW14IlfyTN7KJQN3agmRsarKN1+ARyU6NvUx8MpU5D3ZArDNNr2H
         tUnbYGucYqr/Ybe74iwiRvKNRw//0dofyWd5S5CTJGOavP68yy91AXer2dC9mg4tsWvf
         idOrIAqvVsbi1fQ27BsHbbBY6B/qvR2BdY452OWJtRvdSyGbpGkI4SS7LzAmrsXtFrtV
         jywg==
X-Gm-Message-State: ANoB5pmQvajwzhVwFPGHr1u8V3HxQAldgvLAXmsM3VBOfouJ+5ZtiKDZ
        fwjHY2XmtJU6eyAdI+KKE0UeViNsgszY0Zg8XIlIgQ==
X-Google-Smtp-Source: AA0mqf6Z+6eCByVZTjXKSfoOhCjTGv9s0e/HVVpnT3VDCjYn81vKxcchedie8IM/xoUzwIaGOwVaM2XSKqwFspjr+8Y=
X-Received: by 2002:a05:600c:4920:b0:3cf:8b23:549c with SMTP id
 f32-20020a05600c492000b003cf8b23549cmr14549932wmp.174.1669246448065; Wed, 23
 Nov 2022 15:34:08 -0800 (PST)
MIME-Version: 1.0
References: <202211231700506267036@zte.com.cn>
In-Reply-To: <202211231700506267036@zte.com.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Nov 2022 15:33:55 -0800
Message-ID: <CAP-5=fWB8AZYBQ-6CWbkPSsS7qr-T=cczCekXs-qY6yuH55_dg@mail.gmail.com>
Subject: Re: [PATCH linux-next] perf stat: remove redundant variable in arch_get_topdown_pmu_name
To:     zhang.songyi@zte.com.cn
Cc:     peterz@infradead.org, zhengjun.xing@linux.intel.com,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Nov 23, 2022 at 1:01 AM <zhang.songyi@zte.com.cn> wrote:
>
> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> Return value from arch_get_topdown_pmu_name directly instead of taking
> this in another redundant variable.
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/arch/x86/util/topdown.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 54810f9acd6f..5a5cdd6efe4d 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -84,8 +84,6 @@ bool arch_topdown_sample_read(struct evsel *leader)
>
>  const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
>  {
> -       const char *pmu_name;
> -
>         if (!perf_pmu__has_hybrid())
>                 return "cpu";
>
> @@ -95,9 +93,7 @@ const char *arch_get_topdown_pmu_name(struct evlist *evlist, bool warn)
>                 evlist->hybrid_pmu_name = perf_pmu__hybrid_type_to_pmu("core");
>         }
>
> -       pmu_name = evlist->hybrid_pmu_name;
> -
> -       return pmu_name;
> +       return evlist->hybrid_pmu_name;
>  }
>
>  int topdown_parse_events(struct evlist *evlist)
> --
> 2.15.2
