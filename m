Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A95ECAAD8
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Sep 2022 22:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIVWuz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiIVWuy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Sep 2022 18:50:54 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5482EEB57
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 15:50:52 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id m65so11959217vsc.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Sep 2022 15:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6ixemsguAnkV+NJr3TXAMzLMT+oF4LgLNizRhlILdtE=;
        b=NkkRGCdQC1gM5ooCQFtV5EdHO8UzxDteTkh7Z9bTM8mx0WwAoT9bt+75W67FopC+VS
         OoN7Aa7vZ2eFX4xVCAOS2CFH16o0EN03EpPL1WJqNUrGsrQw5/tIJy2u262DRHbaTidI
         qmKPFX9pVyu7zwinPIP3hcwawvMvnzwK6CrPO4KtgRG/hlo+xxUpfOGnS/JnlWMaD9JG
         V+fwfm48dGKeR3/goUweH6OLdgZWx9IvO4PymXXiOiwhtpv0EjaDUZAaV66McEkBBrJL
         mkNePs7lssq4BcV1nd3LmtSpOkIFBl5nFR5AbG3OICTS85a4E+2qOxud+dC0KveOFwt9
         Tz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6ixemsguAnkV+NJr3TXAMzLMT+oF4LgLNizRhlILdtE=;
        b=4EYr5VZRqlxMtWiK8M7AMrjHLZVkdFXXbzyVhA+QwV/olOzMSWJ/GSb1Q+5esmsLRY
         JS51ZFSAHZA1uP5A0uATxr/rvH2Oo42skHcRA9MA4P2rMxEr/JLq3Duz1m0j1Qinc6co
         KO9MtQkPDiEr+/e84eU8mk6EH7q6yuYgwcERgSZNnLHOCORh8CHHXq3Aqu8QnclKEUyE
         alo+IJb0cti4mqX+67AKGDyuRnkKlIdcOh7JqXxnEmY1vYyoMbxSpnMJgtr0cLYVP0Ze
         UhBlCgGNruqacCpFUdJYSYkkdQXaGyD6pxlkWH5cx3Qpys9BHwqXZHH7M5zHPlXDniZ6
         17Og==
X-Gm-Message-State: ACrzQf2+qAf8tD6eBmyBKwyoJypgUq6Jn1sfBjjMh5CYN1ulos8plFoq
        M/St9VPeJIJZb7rE58JZ3l8jAUsRFnQa8EuA2XzAfA==
X-Google-Smtp-Source: AMsMyM5T+s6ZZ/4PeDW4GBmuKNNL5THlPXterma8dzdljKo+DGK2r8SrnD/zcKmx1sVd4WF+HjpW0z3SfOYl4wRVgZs=
X-Received: by 2002:a67:a603:0:b0:39a:c317:8eff with SMTP id
 p3-20020a67a603000000b0039ac3178effmr2429010vse.46.1663887051689; Thu, 22 Sep
 2022 15:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220922141438.22487-1-shangxiaojing@huawei.com>
 <20220922141438.22487-5-shangxiaojing@huawei.com> <Yyy9jX5vlnUaDa/G@kernel.org>
In-Reply-To: <Yyy9jX5vlnUaDa/G@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 22 Sep 2022 15:50:40 -0700
Message-ID: <CAP-5=fXPnXVgw_XvqnPpnV4kq_HntQOSdbBVmy7ajjZhJeRi2g@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf stat: Clean redundant if in process_evlist
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 22, 2022 at 12:55 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Sep 22, 2022 at 10:14:38PM +0800, Shang XiaoJing escreveu:
> > Since the first if statment is covered by the following one, clean up
> > the first if statment.
> >
> > Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> >  tools/perf/builtin-stat.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index e10595f649bc..ccea5d1e053a 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -899,8 +899,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> >               evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
> >                       counter = evlist_cpu_itr.evsel;
> >
> > -                     if (!counter->reset_group && !counter->errored)
> > -                             continue;
> >                       if (!counter->reset_group)
> >                               continue;
>
> Ian, can you please take a look at this one? You added this in:
>
> commit 472832d2c000b9611feaea66fe521055c3dbf17a
> Author: Ian Rogers <irogers@google.com>
> Date:   Tue Jan 4 22:13:37 2022 -0800
>
>     perf evlist: Refactor evlist__for_each_cpu()
>
> >  try_again_reset:
> > --
> > 2.17.1
>
>
> - Arnaldo
