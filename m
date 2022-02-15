Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628DFC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 15 Feb 2022 04:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiBOEq5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Feb 2022 23:46:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiBOEq4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Feb 2022 23:46:56 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF9385962
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 20:46:47 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w20so12175785plq.12
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Feb 2022 20:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZyA1Beu16WSVWnohfzMoe4vWqDU4ejeqVgR0fAng8A8=;
        b=bs2CNKDDrFOrphyiAobwHxiPCo571sKKumapDGB6pHwvrgtFi9CWVlDQZNZoluvN6O
         jY3wBYo3Nbstzi9mfAd3JOabH5LFdQxG4cLWG5OwNB8g36IkTcRzubC71007kJG2spBi
         xv+Q2AUhBr6GbSGMp2bA1yCRUR072hBmNnFFRv1KHODqraO1wTr4+Dk3czl/DdG7tnoH
         Ir0i8n4/aZWyGxWuKjM785PObnZ2zA9wlIG6ZK5w+g4Bxcl2IlfhOSkHXPegJmYHEuNH
         ziMObmJrqdQJpuL09NrJbRAAbmFc2Z+LDUyViFq8JGa+nd+00M+WRQPueq0RZAUl6a4g
         lmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZyA1Beu16WSVWnohfzMoe4vWqDU4ejeqVgR0fAng8A8=;
        b=wI9QkT+qffy12b0T1iDsAsjTHCZqBlFk/vu8iUwJNa9ytn+VH0+D5cYl8rJDp2n83S
         Y1UjZKlNlI57UhyDvL1LDCSm/ibCw88lcxwoG5tZXe17pOiW3e9dafWfmgtM9Uatc9bg
         2f+EFEwK13G8dENaYvn048I/siqZmbjfklNzrXPo+kZkIIgONVsN4DAX+K9nIpFGmiP5
         7zrTJlWHAXayizPggznYQEb0ILS4js5u3UlOEkVLe0GoDBrILYCoIJAIUaDpkYFUkbzj
         EYgUUtwTNMj4A7SuD0bN3N0fHMJabpjI5/TMgjZrCS5+iase5AryJLqgpUINSujY+47Q
         fFuQ==
X-Gm-Message-State: AOAM532LmdG7MnZM4RHk6V8p+pRaNWYj59jT1hax65pTSIc7qhAmhTeK
        /PM7uVV9JiQYb+/ztDlrm23XxMEPTbrMeijxazo=
X-Google-Smtp-Source: ABdhPJwpna7wErt6hwKwn8WDpr69hwbWzXPOSEvQsgePkRI7Ymv5OUJUAuv6oUIkCOvr0TNl4PwrPvTZ2jRujMX72sk=
X-Received: by 2002:a17:90a:9f91:b0:1b9:e916:25da with SMTP id
 o17-20020a17090a9f9100b001b9e91625damr2420298pjp.208.1644900406495; Mon, 14
 Feb 2022 20:46:46 -0800 (PST)
MIME-Version: 1.0
References: <CAPpZLN6+BPu=Y_iCXBV_Uqg_mcY2LEBtg+_7r+oJqWkG8pNSGA@mail.gmail.com>
 <YgrIId0p9KoE9zPI@krava> <CAP-5=fXNfvttL6VungRvqHX8dqD5tmUHwrVbs+n=4j2KhV5Usw@mail.gmail.com>
In-Reply-To: <CAP-5=fXNfvttL6VungRvqHX8dqD5tmUHwrVbs+n=4j2KhV5Usw@mail.gmail.com>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Tue, 15 Feb 2022 06:46:30 +0200
Message-ID: <CAPpZLN6eC-GbOhbvpRzKntGxFQaQ-e0x991G32N0K3K9hYrJPA@mail.gmail.com>
Subject: Re: libperf: CPU map question
To:     Ian Rogers <irogers@google.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 15, 2022 at 12:18 AM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Feb 14, 2022 at 1:22 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Feb 14, 2022 at 06:54:38PM +0200, Tzvetomir Stoyanov wrote:
> > > Hello,
> > > I'm trying to use libperf as an interface to perf from an application,
> > > but I face some difficulties.  I cannot understand how perf_cpu_map_
> > > APIs should be used. My use case is:
> > >  I want to iterate over the CPUs from the map. I'm using
> > > perf_evsel__cpus() API to get the map and perf_cpu_map__for_each_cpu()
> > > macros to iterate over the map. However, using that logic I get a
> > > struct perf_cpu for each CPU from the map. That structure seems to be
> > > private and I cannot access the actual .cpu id. Am I missing something
> > > ?
> > > Will be glad for any help and clarification.
> >
> > yea it's a bug ;-) there was a change recently that wrapped cpu
> > in struct perf_cpu to distinguish it from cpu indexes
> >
> >   6d18804b963b perf cpumap: Give CPUs their own type
> >
> > not sure there's workaround for that.. but I think change below should fix it
> >
> > Ian, would this be ok? we need to add some test for this
>
> This looks good to me, thanks! Agreed on the test.
>
> Thanks,
> Ian
>
> > jirka
> >

I applied the patch, it solves my problem. Thanks!

I have one more problem, related to thread map allocation. I submitted
a patch a few days ago. Do not know if you have time to look at it,
I'll ping you on the other thread. Will be glad for any help or
comments on the patch.

> >
> > ---
> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/include/internal/cpumap.h
> > index 581f9ffb4237..1973a18c096b 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -3,11 +3,7 @@
> >  #define __LIBPERF_INTERNAL_CPUMAP_H
> >
> >  #include <linux/refcount.h>
> > -
> > -/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> > -struct perf_cpu {
> > -       int cpu;
> > -};
> > +#include <perf/cpumap.h>
> >
> >  /**
> >   * A sized, reference counted, sorted array of integers representing CPU
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> > index 15b8faafd615..4a2edbdb5e2b 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -7,6 +7,11 @@
> >  #include <stdio.h>
> >  #include <stdbool.h>
> >
> > +/** A wrapper around a CPU to avoid confusion with the perf_cpu_map's map's indices. */
> > +struct perf_cpu {
> > +       int cpu;
> > +};
> > +
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__dummy_new(void);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__default_new(void);
> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__new(const char *cpu_list);



-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
