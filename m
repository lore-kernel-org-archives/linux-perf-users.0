Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F0C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 20:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1929360F6C
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235749AbhH3U7f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235898AbhH3U7f (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 16:59:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D6E461008;
        Mon, 30 Aug 2021 20:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630357121;
        bh=sTRehZGcYy+Yc7uLDclFNF91ENgqtbr7oENyFmAL5TU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZW1NbJsaPxeE7G5eUXY+YvTgTHsC5BcI5HhA53AZnIUxN61WucGdEZyNOkwf43dus
         x8CqUcZxfhKwamEa7FDiPFcDASHJJrVNzQdvXdngPulDRdguLJrxi3xukWuVJ0VP65
         zC4ZleNjRs7uufQnxNxNkjNxlD3kzcdEEwFu2BSz8V6eX68/CLMyBDoZ6D6z7ZRzvG
         LpCLXzfyAPGm0G2af9QzY47U1SeszKGDgZB64C1FFPR9hrFghX/Ez9FWIIqHIHU2+t
         MLfckrP944o6IXWpOdb6UgCAga/4CD7xaxl6nsAm1bvT0Xh/+hbUGIyXjshbcD9FXW
         JBYPSqD/arLoQ==
Received: by mail-ej1-f51.google.com with SMTP id h9so33982445ejs.4;
        Mon, 30 Aug 2021 13:58:41 -0700 (PDT)
X-Gm-Message-State: AOAM530Pc01oLNv/fBgK8kSJfHvXHBbMV/7CYgJ1h/21R89uumfKQhTX
        cOafhCTrwmAR/B/znj+VL855I8ah6o7n5BLfsA==
X-Google-Smtp-Source: ABdhPJx4Ui5N1WjpN6yxDi75ZXSmB5EwI9nNo0eNIiVjqAZYoAy5aGYleTBanIMZJSY66PvSA9aHhTpsGnptDYTlga0=
X-Received: by 2002:a17:906:1cd0:: with SMTP id i16mr26673334ejh.360.1630357119849;
 Mon, 30 Aug 2021 13:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210728230230.1911468-1-robh@kernel.org> <20210728230230.1911468-3-robh@kernel.org>
 <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org> <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
 <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com> <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com>
 <43b3a838-da8a-4733-9832-f3d5f990ec13@www.fastmail.com> <f3b72c71-f9c9-e1a8-4542-e248e8a5d769@maine.edu>
In-Reply-To: <f3b72c71-f9c9-e1a8-4542-e248e8a5d769@maine.edu>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Aug 2021 15:58:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLs9Wbdbso0_XdijME=zDK9=5yKpi1a1NQM6j1qNczWbg@mail.gmail.com>
Message-ID: <CAL_JsqLs9Wbdbso0_XdijME=zDK9=5yKpi1a1NQM6j1qNczWbg@mail.gmail.com>
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sun, Aug 29, 2021 at 10:06 PM Vince Weaver <vincent.weaver@maine.edu> wr=
ote:
>
> On Fri, 27 Aug 2021, Andy Lutomirski wrote:
>
> > On Thu, Aug 26, 2021, at 12:09 PM, Rob Herring wrote:
>
> > > After testing some scenarios and finding perf_event_tests[1], this
> > > series isn't going to work for x86 unless rdpmc is restricted to task
> > > events only or allowed to segfault on CPU events when read on the
> > > wrong CPU rather than just returning garbage. It's been discussed
> > > before here[2].
> > >
> > > Ultimately, I'm just trying to define the behavior for arm64 where we
> > > don't have an existing ABI to maintain and don't have to recreate the
> > > mistakes of x86 rdpmc ABI. Tying the access to mmap is messy. As we
> > > explicitly request user access on perf_event_open(), I think it may b=
e
> > > better to just enable access when the event's context is active and
> > > ignore mmap(). Maybe you have an opinion there since you added the
> > > mmap() part?
> >
> > That makes sense to me. The mmap() part was always a giant kludge.
> >
> > There is fundamentally a race, at least if rseq isn=E2=80=99t used: if =
you check
> > that you=E2=80=99re on the right CPU, do RDPMC, and throw out the resul=
t if you
> > were on the wrong CPU (determined by looking at the mmap), you still
> > would very much prefer not to fault.
> >
> > Maybe rseq or a vDSO helper is the right solution for ARM.

There was a version using rseq[1]. AIUI, that would solve the reading
from the wrong CPU problem. I don't think using rseq would change the
kernel implementation other than whether we enable events on specific
CPUs.

> as the author of those perf_event tests for rdpmc, I have to say if ARM
> comes up with a cleaner implementation I'd be glad to have x86 transition
> to something better.

Thanks for chiming in.

My plan is to be more restricted in terms of what works, and fail or
disable user access for what's not supported. Unless I hear events on
specific CPUs is really important, that means only monitoring of a
thread on all (for big.LITTLE, all homogeneous) CPUs is supported.
That doesn't require a better/cleaner interface. It just means cpu
must be -1 for perf_event_open if you want rdpmc. The difference on
Arm is just that we can enforce/indicate that.

We could also enable CPU events, but abort if read on the wrong CPU.
The user in that case either has to control the thread affinity or
possibly use rseq.

> The rdpmc code is a huge mess and has all kinds of corner cases.  I'm not
> sure anyone besides the PAPI library tries to use it, and while it's a
> nice performance improvement to use rdpmc it is really hard to get things
> working right.

Yes, I've been reading thru the bugs you reported and related tests. I
just wish I found them sooner...

> As a PAPI developer we actually have run into the issue where the CPU
> switches and we were reporting the wrong results.  Also if I recall (it's
> been a while) we were having issues where the setup lets you attach to a
> process on another CPU for monitoring using the rdpmc interface and it
> returns results even though I think that will rarely ever work in
> practice.

Returning the wrong results is obviously bad for the user, but making
that "work" also complicates the kernel implementation.

Rob

[1] https://x-lore.kernel.org/all/20190611125315.18736-4-raphael.gault@arm.=
com/
