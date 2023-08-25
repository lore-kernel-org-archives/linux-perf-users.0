Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A588C3DA6F
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 04:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbjHYEQd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 00:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjHYEQX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 00:16:23 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97BA1FCE
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:16:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-407db3e9669so92451cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 21:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692936981; x=1693541781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVJbwQJBz4fIhry+uL3sWXjwZFHZzrz63eCkxNfFeEg=;
        b=e8bFzWmHf03M8HfSss8etDZ5SiePii+NFvLIl/lE9evGbFW/46KxPFfFpi/FKdXf9L
         yG762qPEjASMfACqfYr74KkKfa3t5g2yrDljs6Yx2Fxff+xMQNBUlQe5In5+iO41SyrK
         BZttaQpdEcjQaO7vLbpvsLyHj4fY9cO+veeZnzJeCnRWU68uSyWIGaPWS8PVBq8IFjV9
         bY7RkHKJpC3k1g0GS372fbNpChD3Z4RF8bwawqTPCeYLsAS7pwUcgofErPQpGqYG8y5v
         wINjKPyclsLFkBVb7rfIgzYpl7B3VcQR46j35HBTItzLgRFWAPrZ65A/A9APfuFCImBE
         V0pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692936981; x=1693541781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVJbwQJBz4fIhry+uL3sWXjwZFHZzrz63eCkxNfFeEg=;
        b=bv6DbYzs+SO7eSI2H7GW6tsatEp7F7oS7hFml22bPzeiltn+TQ9JEMYZ/WIlmFidHL
         AmoM+yfF7G52RVpZepvFObIH54TyQbKF/XyH/oCEuGB/OwgUF34gK6lMwNkc4JqX888K
         xFj46fSaoo211Z1Ywt9ssA5GVERTzFOPJNBvMIv32BkdR5QnIyuQ7dRticIfuyfubOw5
         kyhB6DZLxb9LeMFy5HSXS0BeNtdoWarLfN0mxx/aYTzTcYSCdbfa3rEIZewnEzOpNGm4
         z/VZ8xmSXUX2Bcs1uAHvgItEc+4nuk004I8ml0CZJ2s9kcOLgQfGdfvnPQ25Ntwfh/JX
         f+qw==
X-Gm-Message-State: AOJu0YwSe+kyY2g7eNrDXFdl8eIyNLNH0DHaJyWpJdgJwz+OIua3U2FZ
        r6oo7nbmDcyn+Mvq8QmrRQRi4GxTMZ59ZvSsRCX+ZQ==
X-Google-Smtp-Source: AGHT+IE4V9Zc0SlNJEupRrn3MM6gX37NNqqjFDP7/Okcsn/QLAbipTiG1YcB7O1zkePViZ7vLYLb42kmb7ZQe197c/k=
X-Received: by 2002:ac8:5a11:0:b0:3f6:97b4:1a4d with SMTP id
 n17-20020ac85a11000000b003f697b41a4dmr92615qta.23.1692936980740; Thu, 24 Aug
 2023 21:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <1692606977-92009-1-git-send-email-renyu.zj@linux.alibaba.com> <1692606977-92009-3-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1692606977-92009-3-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Aug 2023 21:16:08 -0700
Message-ID: <CAP-5=fXnZq=5W7pzTcukRbQANF8VoW7rnz312JG09Wtk1tR1WQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/8] perf metric: "Compat" supports matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 21, 2023 at 1:36=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
>
> The same PMU driver has different PMU identifiers due to different
> hardware versions and types, but they may have some common PMU metric.
> Since a Compat value can only match one identifier, when adding the
> same metric to PMUs with different identifiers, each identifier needs
> to be defined once, which is not streamlined enough.
>
> So let "Compat" supports matching multiple identifiers for uncore PMU
> metric.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.=
c
> index 5e9c657..ff81bc5 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -477,7 +477,7 @@ static int metricgroup__sys_event_iter(const struct p=
mu_metric *pm,
>
>         while ((pmu =3D perf_pmu__scan(pmu))) {
>
> -               if (!pmu->id || strcmp(pmu->id, pm->compat))
> +               if (!pmu->id || !pmu_uncore_identifier_match(pmu->id, pm-=
>compat))
>                         continue;
>
>                 return d->fn(pm, table, d->data);
> --
> 1.8.3.1
>
