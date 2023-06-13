Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD07EB64D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 19:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbjFMTXJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 15:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237409AbjFMTXF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 15:23:05 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E42510F7
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 12:23:02 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3c43279c1so28915ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jun 2023 12:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686684181; x=1689276181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+D4HqqatbIO3Y5m0N5oSclLaQb1DH2u/EcPqTcyMdUY=;
        b=iorkUsU5RLmVLaJi+JzfcC7MPYf/n2Ac/nb2cukiZxk1G/KaQLc9+4K94FCyRJuhw5
         GH82dhntRG+u6Qw9YVx5gEj/jZcyP8BpvGig2WfVp9fdtA431QuPa7KJeQnEOwKuwJZO
         vrNVeNnj4ZlWxaaF9mzj898LsAURLZAZTtFYhpH2ELPamtmZ+Y8T1g8F/KGosJpRjtW6
         sVvDmra59MKl8xq2z8lU8sbMmm5ZgD4HhXrIiIVzO3xm5Z6nvOk6oj+vF88nGrWEiYb8
         f7VddXZa8P/Y5MxoR0sIOuTXrOZlX8B6T/wCz5qD1VHKcjtTEjk57+ridBDNMbF0JBKk
         27pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686684181; x=1689276181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D4HqqatbIO3Y5m0N5oSclLaQb1DH2u/EcPqTcyMdUY=;
        b=jaMX7ey1P/PvGxyTOJOsbqmPqFdFiNpqC70mHYIub8lq4HfO2ncOmAU+EXximtmxmR
         NiU9URMxapTuJHAwIfmZpk2DaGAbF5cXBM8807rqXJmfFW0nFAMtlJKjAiFmST9vEW24
         TdiN2+Y28onIJEJ0gUi7meaPy4u9Ss0aTrHsrU9ihl2FHzNmJ77Lh3qAMtLZ18d1b9gc
         sFruZ2ljlMvF5klnDv0liNxvHHlTsZ72OSF8K+6olijoXSGX50BMDTqJ4iwKKvSrIP+p
         CB8aCEmcyxEf0GohywI8b9fIol1+Zq7hDytfpS7K7h1ozuyjLqjapplnFKHKjMWWIf9g
         /BHA==
X-Gm-Message-State: AC+VfDyXFatBCupo9tABvdpinzWcAaX6TFZNhXER8Wfje9UKhkMtVEBQ
        G0qx3kzJpgfOFHexRSEVrf2TqLPk14BlWgn6fPEFLg==
X-Google-Smtp-Source: ACHHUZ7IdUcspwOvM0xXqtKaD2SAV/caVjerale3K/7e+6pfL57YVGqqlwDDCVLiMR2Yr6wlC5WOGtTN4AwNWHNau68=
X-Received: by 2002:a17:902:c205:b0:1b3:b200:a3dc with SMTP id
 5-20020a170902c20500b001b3b200a3dcmr41025pll.2.1686684178700; Tue, 13 Jun
 2023 12:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-2-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-2-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 12:22:46 -0700
Message-ID: <CAP-5=fXcMobh7+12su=AvMs+3-GbRiGE4STMv9FjOYfphWzkAA@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf metric: Fix no group check
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The no group check fails if there is more than one meticgroup in the
> metricgroup_no_group.
>
> The first parameter of the match_metric() should be the string, while
> the substring should be the second parameter.
>
> Fixes: ccc66c609280 ("perf metric: JSON flag to not group events if gathe=
ring a metric group")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 70ef2e23a710..74f2d8efc02d 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1175,7 +1175,7 @@ static int metricgroup__add_metric_callback(const s=
truct pmu_metric *pm,
>
>         if (pm->metric_expr && match_pm_metric(pm, data->pmu, data->metri=
c_name)) {
>                 bool metric_no_group =3D data->metric_no_group ||
> -                       match_metric(data->metric_name, pm->metricgroup_n=
o_group);
> +                       match_metric(pm->metricgroup_no_group, data->metr=
ic_name);
>
>                 data->has_match =3D true;
>                 ret =3D add_metric(data->list, pm, data->modifier, metric=
_no_group,
> --
> 2.35.1
>
