Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD13C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Apr 2022 21:18:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbiDSVVR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Apr 2022 17:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbiDSVVP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Apr 2022 17:21:15 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3BE3819A
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2022 14:18:31 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id d9so16886985vsh.10
        for <linux-perf-users@vger.kernel.org>; Tue, 19 Apr 2022 14:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYMQrJatxv+ymWWVnT4mFSHb3fDjJ92SZBZYGIm/cFg=;
        b=LPDQdpVf05m8GyTpA6fFr1g32B4J76C3vOWOorBkGk1nar/zDTlLRXC5WYR5iFLb+c
         wFcebErih28bmiMyt6TiDI+oQ2VZ/Qmc+IO1CH5GMmcyEb43+bCMf5eQBN3zimFLiRC4
         gAB5IJl9MOCqEJuqzUfnRuxicZoRCJ4C5wGnAmOb2+T7IZQysH3EEpgZYWudN4JQ025p
         EjTwpnv/lUXQzOz2t+IEnaDWcTUPAKkpEE5EIkfUIwonFjxu92gTuAhxwu7wyjbOp/X/
         xfhTmHD0jxuS7+s1wCHQPd5YL+qT/Xs6S40P0VducbRlUILhDCm/FV1yPhL7CWgH4aev
         bKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYMQrJatxv+ymWWVnT4mFSHb3fDjJ92SZBZYGIm/cFg=;
        b=1WvBUJA4Oh+wlD4bYHtwfQLsjDmck6QysMVy90ojFWVIOmnJNJ0lkB84dfhZJT92mW
         7/lAkzW9tzu23QxWTVoXvgChvfAFmFruDKnzFSuwY5dsvzVC95LfmY/jI8Fu7lMK5vpH
         Hc2Hxz6q0Yi1dVV8PkOYViU2AWlmYBPVqd5F1YKjvVgh66dM6KicYz/jr9vRV786FLow
         pz52/Sf6dfpuLWeaX23g6/vNAXzsho0P7wss4dgonLvbKpyFjLSsPhKgxR0hYtkZR8+b
         Yf8JomOLFNBfNawvV2SGbxZQ3CouZ/Ss1Vp1XHPP0kr8QguJsTy/Brkk0hBDQYeGUnn1
         8vaA==
X-Gm-Message-State: AOAM530SIGNVDrttfyJdWJRa8g/0uvvWiRE5ATO0B0JmgdCMMK27sZuC
        N4Gg1u76uuQ4YqILnTsNdPitTTGYgS/mqA/du8o02Q==
X-Google-Smtp-Source: ABdhPJw2RLuxOaVIo0nZFbFyHcZiPjKxLRlSTp/Qm+7gqVR9tFsx2zVK8dgQAUXucgB8+yFhqsqvD5RjwCCiJTI8JMc=
X-Received: by 2002:a05:6102:3107:b0:32a:e37:4544 with SMTP id
 e7-20020a056102310700b0032a0e374544mr5442087vsh.14.1650403110152; Tue, 19 Apr
 2022 14:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220304110351.47731-1-simon.wy@alibaba-inc.com>
 <20220304110351.47731-2-simon.wy@alibaba-inc.com> <YiIyrFn7upPEouVt@hirez.programming.kicks-ass.net>
 <0c119da1-053b-a2d6-1579-8fb09dbe8e63@linux.alibaba.com> <YidREXNn2AtI3V1c@hirez.programming.kicks-ass.net>
 <271bc186-7ffb-33c8-4934-cda2beb94816@linux.alibaba.com> <Yi8fELo+k9gmkJIa@hirez.programming.kicks-ass.net>
 <05861b8c-2c7c-ae89-613a-41fcace6a174@linux.alibaba.com> <e50c5307-8b2d-9338-0acc-9375b76c211d@linux.alibaba.com>
 <c33fd91c-8f8f-c82f-4e03-8799f3b8cd28@linux.alibaba.com> <20220419205738.GZ2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220419205738.GZ2731@worktop.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 19 Apr 2022 14:18:18 -0700
Message-ID: <CABPqkBSnJcioAeppPXtURu9+qSFpompWMrs-A=FdD76a6-+S8A@mail.gmail.com>
Subject: Re: [RESEND PATCH 2/2] perf/x86: improve the event scheduling to
 avoid unnecessary pmu_stop/start
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Wen Yang <simon.wy@alibaba-inc.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        mark rutland <mark.rutland@arm.com>,
        jiri olsa <jolsa@redhat.com>,
        namhyung kim <namhyung@kernel.org>,
        borislav petkov <bp@alien8.de>, x86@kernel.org,
        "h. peter anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

Going back to the original description of this patch 2/2, it seems the
problem was that you expected PINNED events to always remain in
the same counters. This is NOT what the interface guarantees. A pinned
event is guaranteed to either be on a counter or in error state if active.
But while active the event can change counters because of event scheduling
and this is fine. The kernel only computes deltas of the raw counter. If you
are using the read() syscall to extract a value, then this is totally
transparent
and you will see no jumps. If you are instead using RDPMC, then you cannot
assume the counter index of a pinned event remains the same. If you do, then
yes, you will see discrepancies in the count returned by RDPMC.  You cannot
just use RDPMC to read a counter from user space. You need kernel help.
The info you need is in the page you must mmap on the fd of the event. It
shows the current counter index of the event along with sequence number and
timing to help scale the count if necessary. This proper loop for
RDPMC is documented
in include/uapi/linux/perf_event.h inside the perf_event_mmap_page definition.

As for TFA, it is not clear to me why this is a problem unless you
have the RDPMC problem
I described above.


On Tue, Apr 19, 2022 at 1:57 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Apr 19, 2022 at 10:16:12PM +0800, Wen Yang wrote:
> > We finally found that TFA (TSX Force Abort) may affect PMC3's behavior,
> > refer to the following patch:
> >
> > 400816f60c54 perf/x86/intel:  ("Implement support for TSX Force Abort")
> >
> > When the MSR gets set; the microcode will no longer use PMC3 but will
> > Force Abort every TSX transaction (upon executing COMMIT).
> >
> > When TSX Force Abort (TFA) is allowed (default); the MSR gets set when
> > PMC3 gets scheduled and cleared when, after scheduling, PMC3 is
> > unused.
> >
> > When TFA is not allowed; clear PMC3 from all constraints such that it
> > will not get used.
> >
> >
> > >
> > > However, this patch attempts to avoid the switching of the pmu counters
> > > in various perf_events, so the special behavior of a single pmu counter
> > > will not be propagated to other events.
> > >
> >
> > Since PMC3 may have special behaviors, the continuous switching of PMU
> > counters may not only affects the performance, but also may lead to abnormal
> > data, please consider this patch again.
>
> I'm not following. How do you get abnormal data?
>
> Are you using RDPMC from userspace? If so, are you following the
> prescribed logic using the self-monitoring interface?
