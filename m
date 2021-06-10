Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC382C48BDF
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E4A613DF
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 18:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFJSrc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 14:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFJSrb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 14:47:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA29C061574
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jun 2021 11:45:34 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f2so3390096wri.11
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Jun 2021 11:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=grq5x0Cjb5fTifNMwhlvZcwKbZ6wbhg2QeSMuRahiO4=;
        b=ONBH+mqR9A5FJwmWT2iKn8qnh2Wu4ZvAnlTunGMtohdER4jO4LC5C+ryc85Tn9bdwK
         DVuCHks9wPUkblNJ9Z/Dmr2F1PRVMkIEX4kWrDAc+essGekQYXVAMNr7Ser7m3u6jqPb
         iL9araxfutkLj3yCrvjfEzc3qzLnefi+BvwKkX0lnDkKtVF8hCLRJqv/0uJBwedg+Hxs
         Iqm0WDxw1XqaJglgWwxb8+zhRMJTytiac2GlbNwELGU351yrJM1KGIggMCEU4JHS1P2q
         XLXN+fUh6Vzu1owN7iIQYLMSl9yF9uQYYcBvr5iOw3mFtDMp8MELlxevHl1nld90Ivc1
         AgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=grq5x0Cjb5fTifNMwhlvZcwKbZ6wbhg2QeSMuRahiO4=;
        b=Cizbcvh6k24cSuXAhswzB1OhEtjOggaXaF+0zG6uWUjWGnMF4tR54Af3n0n9rwjo/J
         Xonf0OG1OQj3mO4jUfp6Bkz4gcGt8PW7aHklpkUvaa1mNTPLektJ2qo0eG6LPF3XSHN1
         YDA5TytgGZtj0GEH5IBjAvR/6u6rpdOp2fn2ei70qNH4GJb7nfYFlsF4eM/6lBV6clbJ
         6LjRpa+MqIbJ+UVaMJr1ILkiMILB5shHSC1MORptRDwvMLUTqxTFFeHU1jM9ShVZSuRA
         YTZox7P06h5FyMiE7wcfgFZmiZIfwVLG9fdSxoSs5m8ks4g11sMF8785CIp/HAktieDY
         HdSQ==
X-Gm-Message-State: AOAM5328LR1r52UF6FSncIyIrVnirbtVkQESkReyYia3dq6Nj/tXSBXS
        3icu6ZL26vVnUGxtfq+Qng/Mj+5x3jwIYZNoxeiBUA==
X-Google-Smtp-Source: ABdhPJz1UJiNuR1E46pRJGEcgdtmieLH0ZI/DZwAAcDJD0IJEvDN4P9BQYd+HCG+XODhQgkHKizz9lduOtIbMX9MuZY=
X-Received: by 2002:a5d:4903:: with SMTP id x3mr6693454wrq.376.1623350729533;
 Thu, 10 Jun 2021 11:45:29 -0700 (PDT)
MIME-Version: 1.0
References: <1623335580-187317-1-git-send-email-john.garry@huawei.com> <1623335580-187317-3-git-send-email-john.garry@huawei.com>
In-Reply-To: <1623335580-187317-3-git-send-email-john.garry@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 10 Jun 2021 11:45:17 -0700
Message-ID: <CAP-5=fV3L5HoJrXry5fvjedJG1dksJ7JJfy54YOQcgfPQMn4Og@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf metricgroup: Return error code from metricgroup__add_metric_sys_event_iter()
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Jun 10, 2021 at 7:37 AM John Garry <john.garry@huawei.com> wrote:
>
> The error code is not set at all in the sys event iter function.
>
> This may lead to an uninitialized value of "ret" in
> metricgroup__add_metric() when no CPU metric is added.
>
> Fix by properly setting the error code.
>
> It is not necessary to init "ret" to 0 in metricgroup__add_metric(), as
> if we have no CPU or sys event metric matching, then "has_match" should
> be 0 and "ret" is set to -EINVAL.
>
> However gcc cannot detect that it may not have been set after the
> map_for_each_metric() loop for CPU metrics, which is strange.
>
> Fixes: be335ec28efa8 ("perf metricgroup: Support adding metrics for system PMUs")
> Signed-off-by: John Garry <john.garry@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/metricgroup.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index c456fdeae06a..d3cf2dee36c8 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -1073,16 +1073,18 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
>
>         ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         ret = resolve_metric(d->metric_no_group,
>                                      d->metric_list, NULL, d->ids);
>         if (ret)
> -               return ret;
> +               goto out;
>
>         *(d->has_match) = true;
>
> -       return *d->ret;
> +out:
> +       *(d->ret) = ret;
> +       return ret;
>  }
>
>  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> --
> 2.26.2
>
