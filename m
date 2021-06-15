Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45046C48BE8
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 17:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B90613BF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Jun 2021 17:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFORxY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbhFORxX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 15 Jun 2021 13:53:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F88CC061574
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Jun 2021 10:51:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso2328244wmi.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Jun 2021 10:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5k8c03lkLJ0kEuGDXFoZR8zuq5YE2cs2QXAAUVdxSs=;
        b=eeDbpFBW6hZkvOkv0vqEMQ4rHjp/8/P3u86ix65h8unQyzzjZ48xAnYzu0XzxIRL2x
         IFAEn1IGnXV57IcRuVoUEtfAnKlZzIJr8XuX+GwXZEbj27U0MZE5UcRUO9XKfqPCuqvc
         +OdFitdRSlcCJoaqFyX9WgreqA8HM6S8iqMPgvPluqq0iB9SPmP9Jp4z4uLpVRct7koX
         O+cLf4lk5PGSDQ8Hx+zbn2zpGei3ejlvjbkKBk5emlLXATKpak8QA6sEnk7RQDN4NpO6
         Ys6zRsL7RniAX0SE8bBKhKT8cmIOuq8G6NWk3PAy/Etf+FczjA231bV6+ogt89ETWMI0
         N/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5k8c03lkLJ0kEuGDXFoZR8zuq5YE2cs2QXAAUVdxSs=;
        b=ZJadsd/nMwxH1PMsVBvp9FBMXgC1MVuAjqCq5dX9+BOLbMDSpp98xJWlgKdS0m3wWW
         DSoCnthLYgG91j1BRU/a+OAenc8lHMXckSVdMijsW9FsNNqSamChVw3qPhuBBumB6bA4
         prYjSZ/meetgKy7qisXabBkHYxZ9pndcbzYtx7/lnUT932Ffx3giX/7o8vMUrzRCrUz8
         ssLhOgdY7XeQP7jSJP+P+9Or44ThdjAb+2XbubFkvfwp4IPyYRtsnomke2Vf6Pul5jK2
         SmdDy2W70k1ushndffDl7iBkvE9yNKyl2+TwfeJW+GONb/Pt4/R0W95NqN4Zed49bajR
         IDfA==
X-Gm-Message-State: AOAM532dBXia7Rj0zEmeexiWjbjx8RD2la4W3FnDaMMwtEw9VXEKAyxB
        +OaJA0LwvVwsK43siFucFjZyRA3mAyimCdr46HnRmA==
X-Google-Smtp-Source: ABdhPJzvX8P1XG+eO/n3Zzga3WNwwtUuHh5PxOaZfnRae+9cCf/dBqxKFhC5ItGiS0Hee11OVWbIjrHppWs1nNm6XB0=
X-Received: by 2002:a05:600c:a01:: with SMTP id z1mr6625877wmp.77.1623779477124;
 Tue, 15 Jun 2021 10:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <1623335580-187317-1-git-send-email-john.garry@huawei.com>
 <1623335580-187317-3-git-send-email-john.garry@huawei.com>
 <CAP-5=fV3L5HoJrXry5fvjedJG1dksJ7JJfy54YOQcgfPQMn4Og@mail.gmail.com> <YMduL3nCJ9NU8Va2@kernel.org>
In-Reply-To: <YMduL3nCJ9NU8Va2@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Jun 2021 10:51:04 -0700
Message-ID: <CAP-5=fXNjjZ2Vji06pvLqSoFCwg4ciD4x9SJ8yKnec5kSQq73g@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf metricgroup: Return error code from metricgroup__add_metric_sys_event_iter()
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Mon, Jun 14, 2021 at 7:56 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jun 10, 2021 at 11:45:17AM -0700, Ian Rogers escreveu:
> > On Thu, Jun 10, 2021 at 7:37 AM John Garry <john.garry@huawei.com> wrote:
> > >
> > > The error code is not set at all in the sys event iter function.
> > >
> > > This may lead to an uninitialized value of "ret" in
> > > metricgroup__add_metric() when no CPU metric is added.
> > >
> > > Fix by properly setting the error code.
> > >
> > > It is not necessary to init "ret" to 0 in metricgroup__add_metric(), as
> > > if we have no CPU or sys event metric matching, then "has_match" should
> > > be 0 and "ret" is set to -EINVAL.
> > >
> > > However gcc cannot detect that it may not have been set after the
> > > map_for_each_metric() loop for CPU metrics, which is strange.
> > >
> > > Fixes: be335ec28efa8 ("perf metricgroup: Support adding metrics for system PMUs")
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
>
> Do your Acked-by applies to both patches? Or just 2/2?  I reproduced the
> problem fixed by 1/2 on a Thinkpad T450S (broadwell) and after applying
> the patch it doesn't segfaults.

IIRC I need to look at what is going on with the names in patch 1/2
and didn't have a repro. I don't mind to ack it given that you've
repro-ed the problem and confirmed the fix. In general this logic
isn't working well (especially for --metric-no-group) so I plan to
take a stab at reorganizing it.

Thanks,
Ian

> Please clarify,
>
> - Arnaldo
>
>
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/util/metricgroup.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > > index c456fdeae06a..d3cf2dee36c8 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -1073,16 +1073,18 @@ static int metricgroup__add_metric_sys_event_iter(struct pmu_event *pe,
> > >
> > >         ret = add_metric(d->metric_list, pe, d->metric_no_group, &m, NULL, d->ids);
> > >         if (ret)
> > > -               return ret;
> > > +               goto out;
> > >
> > >         ret = resolve_metric(d->metric_no_group,
> > >                                      d->metric_list, NULL, d->ids);
> > >         if (ret)
> > > -               return ret;
> > > +               goto out;
> > >
> > >         *(d->has_match) = true;
> > >
> > > -       return *d->ret;
> > > +out:
> > > +       *(d->ret) = ret;
> > > +       return ret;
> > >  }
> > >
> > >  static int metricgroup__add_metric(const char *metric, bool metric_no_group,
> > > --
> > > 2.26.2
> > >
>
> --
>
> - Arnaldo
