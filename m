Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68883C43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 00:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiFIAIJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Jun 2022 20:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiFIAII (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Jun 2022 20:08:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2FEE2B
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Jun 2022 17:08:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso5124855wms.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jun 2022 17:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GnlYXnVoQYJPnNV8/iC3fNyGpmORV44baev9cEKD2IY=;
        b=rlG44ICMM4z4bNcMt5KDKsiGZ7e5+g5gPlD3n6KCPMALmsgSLMviYzo5++Ytwl8EEg
         clrF5nU1PA+9yGWshhXdqvHFQxSansRhSL/aS4orgaNjMOtwEXpFDW7J42J7G8C/kU+O
         f6wDlBTnM8YsjTOGNxVI/cyC/Hu7ORI7s8w6ISivX6yn1dlc9j5aN7UAz2mUBPgCc5zY
         dZRUlY+RNoT+h+A9F/eqmWjhF7Rx2cEODLQL4TVR0nmxbqOpEs0mRYh0y7W8wwfWS55V
         A1cfQNxgTpNsajQArIGxBLzBbE2F/YL9zXhd8IqCZMOwB2w1JRM+gaTs9Fq+/3169anP
         K3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GnlYXnVoQYJPnNV8/iC3fNyGpmORV44baev9cEKD2IY=;
        b=zl9N8OXdRXv6K9zqA9gDfM8rCj69gP4xtBoeUiZgknOy9X1fMQv9WosRvT3mvnthGV
         ignDFR0SYxBjqC1SwCu17mXcB2QLqWx1jqAGhmJs/39yVSKpTlOkYX5wN4lxAxiYebBT
         GoX26Ic1Ay9MH783AVO5VtEhICF3M3ug75R+yykFchYllcl/y4nZRXryGtwf8Fgxse1e
         x/D8/HNN5VgBOdE/zm70vcqMwZqaKXZLRk1R5vHjCCQwtMQqhHnMx6DTSAsURPCEu2hx
         dZ7qXCur6Px9DghOQKOCXl2D/4MvpYvzJZOmL7zIhOwQ6VEP8pxuOZb8dRSRXl/ADNeq
         27Ww==
X-Gm-Message-State: AOAM530Ck7dVSWEFJ45GrPao0BGoHWgqDWiknZAbc+BdnizeKNej4MeO
        WIoLytqVE6foI9HZ7WgiAiI9gNpXgfOLuKouMlq6xw==
X-Google-Smtp-Source: ABdhPJy54ZnoQBAo63W05vgLEvMwWjLv/9KzfirQgHDWFuLjzwgfXLUiRyRGEYSaQORswgcDGo1zKhC4x2XiqCMNS0g=
X-Received: by 2002:a7b:c7da:0:b0:39c:5b34:3019 with SMTP id
 z26-20020a7bc7da000000b0039c5b343019mr442073wmk.115.1654733284190; Wed, 08
 Jun 2022 17:08:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220608224353.1176079-1-irogers@google.com> <20220608224353.1176079-3-irogers@google.com>
 <CAL_Jsq+rWB7AYr4THs2Dg98ss8cuL38QVuvTbQNwar2ePqwuww@mail.gmail.com>
In-Reply-To: <CAL_Jsq+rWB7AYr4THs2Dg98ss8cuL38QVuvTbQNwar2ePqwuww@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 8 Jun 2022 17:07:48 -0700
Message-ID: <CAP-5=fVyb6mc2UFYM0kMQXUwo4gZ2WxgY6G6G8+C5WqdxoxXJw@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf: Align user space counter reading with code
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jun 8, 2022 at 4:25 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jun 8, 2022 at 4:44 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Align the user space counter reading documentation with the code in
> > perf_mmap__read_self. Previously the documentation was based on the perf
> > rdpmc test, but now general purpose code is provided by libperf.
>
> IMO, this copy of not quite right code should just be removed perhaps
> with a pointer to perf_mmap__read_self(). It will just get out of date
> again. For example, the read loop might get rewritten with restartable
> sequences.

Thanks. The intent with the rdpmc test and the header is they be in
sync. The test flakes when testing at scale, why I'm here. Having the
code in the header makes it clear this is a Linux API and subject to
the Linux syscall note. I like the code in the header but not that it
is out of sync with the code used currently to read it.

> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/uapi/linux/perf_event.h       | 32 ++++++++++++++++-----------
> >  tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++-----------
> >  2 files changed, 38 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index d37629dbad72..3b84e0ad0723 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
> >          *
> >          *     if (pc->cap_usr_time && enabled != running) {
> >          *       cyc = rdtsc();
>
> Kind of x86 specific.

There is a reference to it below and so I let it be, the name rdpmc is
also very x86 but something of a sailed ship.

> > -        *       time_offset = pc->time_offset;
> >          *       time_mult   = pc->time_mult;
> >          *       time_shift  = pc->time_shift;
> > +        *       time_offset = pc->time_offset;
> > +        *       if (pc->cap_user_time_short) {
> > +        *         time_cycles = pc->time_cycles;
> > +        *         time_mask = pc->time_mask;
> > +        *       }
>
> This still misses the need for READ_ONCE().

I'd elided that as it is something of.a kernel API. I can add it back.

> >          *     }
> >          *
> >          *     index = pc->index;
> > @@ -548,6 +552,9 @@ struct perf_event_mmap_page {
> >          *     if (pc->cap_user_rdpmc && index) {
> >          *       width = pc->pmc_width;
> >          *       pmc = rdpmc(index - 1);
> > +        *       pmc <<= 64 - width;
> > +        *       pmc >>= 64 - width;
> > +        *       count += pmc;
> >          *     }
> >          *
> >          *     barrier();
> > @@ -590,25 +597,24 @@ struct perf_event_mmap_page {
> >          * If cap_usr_time the below fields can be used to compute the time
> >          * delta since time_enabled (in ns) using rdtsc or similar.
> >          *
> > -        *   u64 quot, rem;
> > -        *   u64 delta;
> > -        *
> > -        *   quot = (cyc >> time_shift);
> > -        *   rem = cyc & (((u64)1 << time_shift) - 1);
> > -        *   delta = time_offset + quot * time_mult +
> > -        *              ((rem * time_mult) >> time_shift);
> > +        *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
> > +        *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
>
> For documentation purposes, the original code was easier to read and
> this is just an optimization. What does mul_u64_u32_shr() do exactly?
> It's not documented.

My concern with expanding the function is the header and the code
aren't in sync and so we're not testing what we're advertising.
Finding the definition is not a huge challenge imo.

Thanks,
Ian

> >          *
> >          * Where time_offset,time_mult,time_shift and cyc are read in the
> >          * seqcount loop described above. This delta can then be added to
> > -        * enabled and possible running (if index), improving the scaling:
> > +        * enabled and possible running (if index) to improve the scaling. Due
> > +        * to event multiplexing, running maybe zero and so care is needed to
> > +        * avoid division by zero.
> >          *
> >          *   enabled += delta;
> > -        *   if (index)
> > +        *   if (idx)
> >          *     running += delta;
> >          *
> > -        *   quot = count / running;
> > -        *   rem  = count % running;
> > -        *   count = quot * enabled + (rem * enabled) / running;
> > +        *   if (running != 0) {
> > +        *     quot = count / running;
> > +        *     rem  = count % running;
> > +        *     count = quot * enabled + (rem * enabled) / running;
> > +        *   }
> >          */
> >         __u16   time_shift;
> >         __u32   time_mult;
