Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578D7C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 19:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE5A6108D
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Aug 2021 19:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbhHZTKN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:10:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230442AbhHZTKM (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 15:10:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4D5161052;
        Thu, 26 Aug 2021 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630004964;
        bh=n+iRiPHG+mQ5MPOYWhKEq5xLaeCMPXwkshM8Phv4gEM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YlmdBnTf1WEJ/CSDKcgZSZo5LOGl/lOxpaxCBPfGWeN/ZT65COEFIf6ydN61V9QgK
         yxzyCP/uYkccM12cAZMVlDjL+m600Wy9G9evncSRPKSCnpPeirT+PAq5leSOFv7CTA
         zc3QdPsvOocdjH0QRS1Ev88Cd4xqLng6hMoVM9/eg0Nzi2ovlXXDQzCrqCOnPkpCSq
         xi7bkJTrUecp+pA3dQawr/Siu/drJk54pM98puz1kqjGifqduu81aTT6+IK5XyNyqp
         hC3Oc2IgRhdUI7t3m5b+WHqhBNRGeQLcGlfcJUjIvKZe/FrHJV43SZC3Zt6HblBmOp
         8boPWErB9pdGQ==
Received: by mail-ej1-f45.google.com with SMTP id me10so8483031ejb.11;
        Thu, 26 Aug 2021 12:09:24 -0700 (PDT)
X-Gm-Message-State: AOAM531ENHRn/nHkqGYp3RH6BYOKY+xQ98+Dyak0pH/mWN75fN+jvPoO
        o5voHpSkE8R4rxoRNPc4V1nyLpOTZyAKfk+E4A==
X-Google-Smtp-Source: ABdhPJzUFDpBsNWGNyiE29SIh7dKKli7aZ0R/Ozw8m0It0WdT9wJ+yjrqf2xnCrbBfbJ7thVBpF+m/Xy+TkMyPiCW6Q=
X-Received: by 2002:a17:906:1cd0:: with SMTP id i16mr5841937ejh.360.1630004963537;
 Thu, 26 Aug 2021 12:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210728230230.1911468-1-robh@kernel.org> <20210728230230.1911468-3-robh@kernel.org>
 <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org> <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
 <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com>
In-Reply-To: <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 26 Aug 2021 14:09:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com>
Message-ID: <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com>
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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

On Thu, Aug 26, 2021 at 1:13 PM Andy Lutomirski <luto@kernel.org> wrote:
>
>
>
> On Thu, Aug 12, 2021, at 11:16 AM, Rob Herring wrote:
> > On Thu, Aug 12, 2021 at 11:50 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > On 7/28/21 4:02 PM, Rob Herring wrote:
> > > > Rather than controlling RDPMC access behind the scenes from switch_mm(),
> > > > move RDPMC access controls to the PMU .enable() hook. The .enable() hook
> > > > is called whenever the perf CPU or task context changes which is when
> > > > the RDPMC access may need to change.
> > > >
> > > > This is the first step in moving the RDPMC state tracking out of the mm
> > > > context to the perf context.
> > >
> > > Is this series supposed to be a user-visible change or not?  I'm confused.
> >
> > It should not be user-visible. Or at least not user-visible for what
> > any user would notice. If an event is not part of the perf context on
> > another thread sharing the mm, does that thread need rdpmc access? No
> > access would be a user-visible change, but I struggle with how that's
> > a useful scenario?
> >
>
> This is what I mean by user-visible -- it changes semantics in a way that a user program could detect.  I'm not saying it's a problem, but I do think you need to document the new semantics.

After testing some scenarios and finding perf_event_tests[1], this
series isn't going to work for x86 unless rdpmc is restricted to task
events only or allowed to segfault on CPU events when read on the
wrong CPU rather than just returning garbage. It's been discussed
before here[2].

Ultimately, I'm just trying to define the behavior for arm64 where we
don't have an existing ABI to maintain and don't have to recreate the
mistakes of x86 rdpmc ABI. Tying the access to mmap is messy. As we
explicitly request user access on perf_event_open(), I think it may be
better to just enable access when the event's context is active and
ignore mmap(). Maybe you have an opinion there since you added the
mmap() part?

Rob

[1] https://github.com/deater/perf_event_tests
[2] https://lore.kernel.org/lkml/alpine.DEB.2.21.1901101229010.3358@macbook-air/
