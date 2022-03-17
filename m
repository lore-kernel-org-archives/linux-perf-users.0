Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E5C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 17 Mar 2022 03:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbiCQDKz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Mar 2022 23:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346961AbiCQDKz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Mar 2022 23:10:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0C421257
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Mar 2022 20:09:35 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r64so2379601wmr.4
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Mar 2022 20:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5LNjOLzXZNfaRuVCiO8zqbvLc/6WuHx1l+39+7jAPR4=;
        b=LTMntLDiHaWhOMPo6NHb0YbfdOVgi7dGsjruxRQXL8AZ+8qXvBTR+Gu+qifHcpaSkH
         aYchrmpMlnuPXOiGdjGEIL9+BfcpDZGGDLpR+b0ND4SCaF8NbmDXBv2Jgt1facQf2X57
         05DMfH8ope5tBo931ZiJtjzIuGnXwaAtVLhvKUZo0zrCmIKq5rvGnOTitLUiCiSynqPr
         GnkTHnF/6QlhpKvsA1ePcmf32eE/8RTDsCRpg7/HmmAcL9dFIMmZZgomehhNDLqw0MAl
         wIQkYCljYFs/WcSIr8MFGift1lCK9cd9FJSu1jRFvfGuix2SV28RCpJAHsQ024erLM/W
         xGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5LNjOLzXZNfaRuVCiO8zqbvLc/6WuHx1l+39+7jAPR4=;
        b=Rx/9IqY8/bSUlLnzW3quPKrk4ZJMCtWMjYqUmnjr9G2Iuy+uWRbMD/GpuNsCgataBd
         /9Ra1WOVK22Nj9MZUtmZXyLJZdHt5Z4649fCwiTKlfYI+OBrCvhm0Yg2Xin8qAOqrU4e
         6mQNnEQGsZyk4CheJcwVDFPP1FUAtVd3J0yjAqQu/5Jd3r/THl7sGo6OH4NXbT5f5hJc
         KklzkFD59SXE30U7qRDfaNSHJqxZmrNjll62CVE8GYAVavQoef7RuD9ddkD6mrtG4NgD
         xmrsIEJr9wYsBSjMH9XZuooWrTjRsEGyKVt20Z8MsfdpH5hOJYtm4H3oICaOOlaLqHhC
         6ckw==
X-Gm-Message-State: AOAM532KoZN71aPxCCxF3rA79dq1cAWgSVJ9aBCNhF8Q40cRxUptmmlz
        +fvRFuKSyDj0tBKaiV1inlbbWZg2IdACpVE4Qy3udw==
X-Google-Smtp-Source: ABdhPJzUx6RY0JlJgFsNlUUwmZEbo5Ah3jIabHDqEWv45NY/xGsp06njJ4+0GIlXDp+2H5YUhTaCVO3vVOr45JeOjuc=
X-Received: by 2002:a05:600c:3d07:b0:38b:94f2:5d17 with SMTP id
 bh7-20020a05600c3d0700b0038b94f25d17mr2000148wmb.67.1647486574260; Wed, 16
 Mar 2022 20:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220314115354.144023-1-Julia.Lawall@inria.fr> <20220314115354.144023-31-Julia.Lawall@inria.fr>
In-Reply-To: <20220314115354.144023-31-Julia.Lawall@inria.fr>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 16 Mar 2022 20:09:22 -0700
Message-ID: <CAP-5=fV11-Haeh2SGQhtjkzYXotDjg1suaO9mDY-BeTmZxfs=g@mail.gmail.com>
Subject: Re: [PATCH 30/30] perf/core: fix typos in comments
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 14, 2022 at 5:48 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
>
> Various spelling mistakes in comments.
> Detected with the help of Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index cfde994ce61c..25fcd4cca0d7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -872,7 +872,7 @@ static void perf_cgroup_switch(struct task_struct *task, int mode)
>                          * event_filter_match() to not have to pass
>                          * task around
>                          * we pass the cpuctx->ctx to perf_cgroup_from_task()
> -                        * because cgorup events are only per-cpu
> +                        * because cgroup events are only per-cpu
>                          */
>                         cpuctx->cgrp = perf_cgroup_from_task(task,
>                                                              &cpuctx->ctx);
>
