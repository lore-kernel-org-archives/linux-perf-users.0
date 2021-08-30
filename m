Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34FBC432BE
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 20:21:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF9C60200
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Aug 2021 20:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhH3UWR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Aug 2021 16:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhH3UWQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Aug 2021 16:22:16 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC354C06175F
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Aug 2021 13:21:22 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w17so3105366qta.9
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Aug 2021 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=X7a3OV8CJpHOBd/pCAOp/2UFjX6RkqdkX1D3kGcsPcE=;
        b=M+fTkpA41Uub+mOaSv7kcWaeQm3vIscRWIMBMqoISpojyDuGEmCULgvUOgsdSLmmxD
         a9lAGZaWrL3v0Li5+QZkgKWpLT0K75/AZGUzifyvsOaF9WUNY0q5sk/eSpHNanAYRlp+
         532QwkMUbAR+FiPQw0hDi7p415rdQn7h2gspU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=X7a3OV8CJpHOBd/pCAOp/2UFjX6RkqdkX1D3kGcsPcE=;
        b=Z2LDA6aEg0+wBmnrfphNLVG9WVntZvsgRd39gO/9uvry5Ppc50JT6EdrPLmxTDybPc
         IxCR0iF4AyCruQXmHInj73WpeHxBxay9OYWKuA2JArsr3kXI0bDnEA8bGA8GOeud2tR1
         xZsWAO8XWp2gRHSBWy4HFvH1p32pTlbpNdBU0kniMCfVz9Mt1ctroSr/SQYoi1xUIpQ4
         aDqJBpVuwYuwUTDQnG0WndUpK5RkE4jYq4czRzfbVC3FckFUi3jveCX4wOS4xCdfnPCn
         FOmOKNDjcx0hDidTbANDWliAu9Ebsja/jdO1xGJDm4DcI6ddV/Bb+nJVb+GUADITQJu8
         X0cQ==
X-Gm-Message-State: AOAM531zArC/ILE3YR//DCrSDbQnbp+crM89MjSZEW5bMqDhSiFWcewp
        /khVwNI1E6moD04VsAlBZ8Mn/Q==
X-Google-Smtp-Source: ABdhPJydpWIP492t1UTT5fjbG2zKIIJqZI2UcajFxI7JG8jM6Yunv/Ol884PuqKAJVWyFN1tBYwtpw==
X-Received: by 2002:a05:622a:1888:: with SMTP id v8mr22468747qtc.105.1630354881835;
        Mon, 30 Aug 2021 13:21:21 -0700 (PDT)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id s28sm11974306qkm.43.2021.08.30.13.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:21:21 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Mon, 30 Aug 2021 16:21:19 -0400 (EDT)
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Andy Lutomirski <luto@kernel.org>,
        Rob Herring <robh@kernel.org>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
In-Reply-To: <20210830085106.GF4353@worktop.programming.kicks-ass.net>
Message-ID: <0b794c5-5988-c79d-7bb-11533ed92a9@maine.edu>
References: <20210728230230.1911468-1-robh@kernel.org> <20210728230230.1911468-3-robh@kernel.org> <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org> <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com> <de97454b-9b4d-492f-a435-6a5e33889219@www.fastmail.com>
 <CAL_JsqKpT93W6nBj68DykEJzjFYOPG=8PGShsh2QZVzHq5N3fQ@mail.gmail.com> <43b3a838-da8a-4733-9832-f3d5f990ec13@www.fastmail.com> <f3b72c71-f9c9-e1a8-4542-e248e8a5d769@maine.edu> <20210830085106.GF4353@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 30 Aug 2021, Peter Zijlstra wrote:

> There's just not much we can do to validate the usage, fundamentally at
> RDPMC time we're not running any kernel code, so we can't validate the
> conditions under which we're called.
> 
> I suppose one way would be to create a mode where RDPMC is disabled but
> emulated -- which completely voids the reason for using RDPMC in the
> first place (performance), but would allow us to validate the usage.
> 
> Fundamentally, we must call RDPMC only for events that are currently
> actuve on *this* CPU. Currently we rely on userspace to DTRT and if it
> doesn't we have no way of knowing and it gets to keep the pieces.

yes, though it would be nice for cases where things will never work (such 
as process-attach?  I think even if pinned to the same CPU that won't 
work?) Maybe somehow the mmap page could be set in a way to indicate we 
should fall back to the syscall.  Maybe set pc->index to an invalid value 
so we can use the existing syscall fallback code.

We could force every userspace program to know allthe unsupoorted cases 
but it seems like it could be easier and less failure-prone to centralize 
this in the kernel.

I was looking into maybe creating a patch for this but the magic perf 
mmap page implementation is complex enough that I'm not sure I'm qualified 
to mess with it.

Vince
