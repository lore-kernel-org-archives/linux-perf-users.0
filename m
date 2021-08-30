Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF12C432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 21:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E2060F42
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 21:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhH3Vlm (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237296AbhH3Vlm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 17:41:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D38D60F42;
        Mon, 30 Aug 2021 21:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630359648;
        bh=SzO1R52+ZB+6kqt/cDT852NMK8dI6tMtqvLALi8Kxds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Hak1fDsYnfPaKFY1JIjEueAOgawlGC0S2HgsT97Y8rpGcjSvaFpNwXHXD3JUvKXLw
         TquSc+bthbdVlt6WazZOFj4Dt6V/lKOKw0VPsEJFEoW5paMbnL83/EAWrBjErok/00
         1vEl7BZFe7nyTDYqVDhPrLPqKIQIXRFI/ZXPw+OxmReX2fYoa/vRp2dW0mOa7/vfDG
         5ipEzepz188NXry20yFlekCBMmQtKALtS1jsMs/TnQ4J5SUHxF2X1tDtH+vrOhLyq3
         3DCfw7T4mDZCsLGxazIc9/qJi1m/aOFs/0VXH9uNKeF1TuoItD5ZYvmy92CI3vSaB0
         UewWKMCWv48hA==
Received: by mail-ej1-f52.google.com with SMTP id ia27so34166528ejc.10;
        Mon, 30 Aug 2021 14:40:48 -0700 (PDT)
X-Gm-Message-State: AOAM530YHPI8Qn3jF0ltSLn3vvEs008MKM14MASaJB2JSgxgUzVQ/UtH
        8vBl9xQGVfQpfW1SJKhWLnwj8PC1mmPyxdHiUg==
X-Google-Smtp-Source: ABdhPJxGp4WjwQjr/Aw2mEv66FDMH6nC78/9Ppvg542fhNgLL79IDqfZVGKpaho3DBv+uzLo8HKcO0jhr0HsowtDn60=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr27805604eje.341.1630359646777;
 Mon, 30 Aug 2021 14:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210728230230.1911468-1-robh@kernel.org> <20210728230230.1911468-3-robh@kernel.org>
 <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org> <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
 <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com> <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com>
 <43b3a838-da8a-4733-9832-f3d5f990ec13@www.fastmail.com> <f3b72c71-f9c9-e1a8-4542-e248e8a5d769@maine.edu>
 <20210830085106.GF4353@worktop.programming.kicks-ass.net> <0b794c5-5988-c79d-7bb-11533ed92a9@maine.edu>
In-Reply-To: <0b794c5-5988-c79d-7bb-11533ed92a9@maine.edu>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Aug 2021 16:40:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJWe76gvwh7GE3qFCy2imskWSSVRyc6L=b_yVqxM4Xrww@mail.gmail.com>
Message-ID: <CAL_JsqJWe76gvwh7GE3qFCy2imskWSSVRyc6L=b_yVqxM4Xrww@mail.gmail.com>
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Aug 30, 2021 at 3:21 PM Vince Weaver <vincent.weaver@maine.edu> wrote:
>
> On Mon, 30 Aug 2021, Peter Zijlstra wrote:
>
> > There's just not much we can do to validate the usage, fundamentally at
> > RDPMC time we're not running any kernel code, so we can't validate the
> > conditions under which we're called.
> >
> > I suppose one way would be to create a mode where RDPMC is disabled but
> > emulated -- which completely voids the reason for using RDPMC in the
> > first place (performance), but would allow us to validate the usage.
> >
> > Fundamentally, we must call RDPMC only for events that are currently
> > actuve on *this* CPU. Currently we rely on userspace to DTRT and if it
> > doesn't we have no way of knowing and it gets to keep the pieces.
>
> yes, though it would be nice for cases where things will never work (such
> as process-attach?  I think even if pinned to the same CPU that won't
> work?) Maybe somehow the mmap page could be set in a way to indicate we
> should fall back to the syscall.  Maybe set pc->index to an invalid value
> so we can use the existing syscall fallback code.
>
> We could force every userspace program to know allthe unsupoorted cases
> but it seems like it could be easier and less failure-prone to centralize
> this in the kernel.
>
> I was looking into maybe creating a patch for this but the magic perf
> mmap page implementation is complex enough that I'm not sure I'm qualified
> to mess with it.

There's now an implementation in libperf[1]. perf_evsel__read() will
use it[2] and fallback to read() call if necessary (but will still
happily give you wrong values if reading on the wrong CPU).

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/mmap.c#n302
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/evsel.c#n305
