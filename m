Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9799C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jul 2022 15:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240992AbiGTPST (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGTPSS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jul 2022 11:18:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A1A599C6
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:18:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z12so26602016wrq.7
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtdCkh5Q9N9knOQNFgtdwyolXJKWft8+CGVuOwEKrH0=;
        b=tXiU4nSLjpcwpnSJcnt+toLSKL9QSNSCughUnC0e5eI2eeGOGW2fKp6opZwLKyILVX
         KUV/t+k5DrYVj5dEbntiEe51DmuZGoY/dDGN9d2osYo6W34yk5hJbHf9LgWfpwJtwaad
         kHJQuFWg/nT55LlisCMEmKrh8jnRXwxWge20GX98gg07Hbl8lwLI8ZhZgrQjeQJhLngq
         sLc/ojYAKiWsc5KtjNfrk7OT6TA84lGG0chpYhkzXEcWDhYvspDn2A7VMs5dskIbmtPA
         m5jg/8wDZriLDkAZjDLtcs3cNB6GSftvfjyjG4II7yhq9fY4q4a40/S2sfiS+McWnNQ+
         /2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtdCkh5Q9N9knOQNFgtdwyolXJKWft8+CGVuOwEKrH0=;
        b=yhRZdv6IvLQl2GQdk7C42OUFbkGH3Jrcx0/MM67ChyMIYCf6k6LoO/lFGkQ/EGmCl5
         66Pjd9IptgA5kTuLPeYRe4CFM5uq/j4nA6DHC8rOLYp8Yg8ZNkJKibq6rOXEZycKmeqK
         fGBnwfaXvcXxyTBAQdg+0/lK7T6Zav6lZ/5LoHMAEKh6lZgK916bTg27puqcLQUxbxGX
         x0gkr89rZHMAnOiopV29bENofyNat9aI79QCon2QrmTL3VkQa7vaVjBP9bv2SGkrVHZJ
         piNhrLg6+Hi+QFMZ2YCNQ254/LYMFWGDTD0jqrPnydl3ekJFiD5IwzzipBc0EzyK6ssQ
         87Ig==
X-Gm-Message-State: AJIora+VgiM3S5GNEbLIbakVPsafG5tcsIDCX4CoLUSdT4u91ayZAnc1
        XDSvrcFvqPHZWQUDuIqz8U53Inlid+a2ZZ3cBPkSBA==
X-Google-Smtp-Source: AGRyM1t/1aPyh24DcDcKsSeznYH68QBBjLFKbWUi9XLEvmBhoG5IcdTdq+tu0w5B6sTghlijMhxmXxFCGFPIWjkN4Sc=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr30000082wrx.343.1658330296042; Wed, 20
 Jul 2022 08:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220719223946.176299-1-irogers@google.com> <20220719223946.176299-2-irogers@google.com>
 <ef5125e0-8265-8c16-e904-c95c8ddc2754@maine.edu>
In-Reply-To: <ef5125e0-8265-8c16-e904-c95c8ddc2754@maine.edu>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:18:04 -0700
Message-ID: <CAP-5=fVU17DxzdOvr0aob6G4HvjianSuWW4Q-QRWQV=Kd8_+jw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf: Align user space counter reading with code
To:     Vince Weaver <vincent.weaver@maine.edu>
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
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Jul 20, 2022 at 8:06 AM Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> On Tue, 19 Jul 2022, Ian Rogers wrote:
>
> > Align the user space counter reading documentation with the code in
> > perf_mmap__read_self. Previously the documentation was based on the perf
> > rdpmc test, but now general purpose code is provided by libperf.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  include/uapi/linux/perf_event.h       | 35 +++++++++++++++++----------
> >  tools/include/uapi/linux/perf_event.h | 35 +++++++++++++++++----------
> >  2 files changed, 44 insertions(+), 26 deletions(-)
> >
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index d37629dbad72..6826dabb7e03 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -538,9 +538,13 @@ struct perf_event_mmap_page {
> >        *
> >        *     if (pc->cap_usr_time && enabled != running) {
> >        *       cyc = rdtsc();
> > -      *       time_offset = pc->time_offset;
> >        *       time_mult   = pc->time_mult;
> >        *       time_shift  = pc->time_shift;
> > +      *       time_offset = pc->time_offset;
> > +      *       if (pc->cap_user_time_short) {
> > +      *         time_cycles = pc->time_cycles;
> > +      *         time_mask = pc->time_mask;
> > +      *       }
>
> From what I've been told, and from what perf_mmap__read_self() actually
> does, many of these MMAP fields need to be accessed by READ_ONCE()
> (a GPLv2 only interface) to be correct.
>
> Should we update perf_event.h to reflect this?  Otherwise it's confusing
> when the actual code and the documentation in the header don't match like
> this.  As an example, see the actual code snippets from
> perf_mmap__read_self()
>
>                 seq = READ_ONCE(pc->lock);
>                 barrier();
>
>                 count->ena = READ_ONCE(pc->time_enabled);
>                 count->run = READ_ONCE(pc->time_running);
>
>                 if (pc->cap_user_time && count->ena != count->run) {
>                         cyc = read_timestamp();
>                         time_mult = READ_ONCE(pc->time_mult);
>                         time_shift = READ_ONCE(pc->time_shift);
>                         time_offset = READ_ONCE(pc->time_offset);
>
>                         if (pc->cap_user_time_short) {
>                                 time_cycles = READ_ONCE(pc->time_cycles);
>                                 time_mask = READ_ONCE(pc->time_mask);
>                         }
>                 }
>
>                 idx = READ_ONCE(pc->index);
>                 cnt = READ_ONCE(pc->offset);
>
> ...

Thanks! So I think what this patch proposes is an improvement,
specifically it aligns it better with the code and deals with the
divide by zero. I think what you're asking for makes sense but as you
point out READ_ONCE probably isn't the correct API for something
outside the kernel. Given the kernel is now C11:
https://lwn.net/Articles/885941/
This opens the possibility of using stdatomic.h, so perhaps we can
move these variables to more correct atomic types. So, I think we can
land this and worry about the atomic API in a follow up.

Thanks,
Ian

> Vince
