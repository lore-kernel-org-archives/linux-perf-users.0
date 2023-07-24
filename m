Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C9D4C0015E
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Jul 2023 15:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjGXP4C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Jul 2023 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGXP4B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Jul 2023 11:56:01 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A981413D
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 08:55:59 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98377c5d53eso731799166b.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 08:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690214158; x=1690818958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqJrERUDo+zp/o5kHkQ6aMOqQKKqLEOmzFVk7PKhL/I=;
        b=SrkEWragiyal8ZEiT1/Rd/fxkuDejUOg6Ue7v8n0fy94wSxfTLmbDmd7XVZEplUH+h
         zJCLKe4D/uljzic4FUrF4tfHdAcSJ67uwq/6r5tfiVXwpeOfKZ/xNARMvTfAeCdmicOW
         X40+q98fKabBQxH4JLxUiNEEHbS9TAti/WlkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690214158; x=1690818958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqJrERUDo+zp/o5kHkQ6aMOqQKKqLEOmzFVk7PKhL/I=;
        b=h8GroCt6iyAMt2M2y572ld0xV3gzIXdYezetaUgOXed+1M9QqNpj6zGWa4QsjtfFyd
         KFpdo+mr7tyYHStE9jVtqXx13YUI0mNL6GWkudGtJDb291l7lJ4ruwIUg1Avt7TzInEP
         Adt2g2eM94tY9SLLbwSpN2CIHfwWjGAulGrNFqaKEvQ/Bjt8PJr8H9Id6a4KfhqRINX6
         Zu9lNX0OZXAmYzCjK7VeGIzd+FGqe4M690giXTYnqqSHhbl+66VYhwXOLhLUAjEPzeFA
         yb+72d5kNva/H+cI3E0InnLxkZTnMlt/allKmo7LktXNDJ560XkKAnFkBIPpj/9GtYrp
         rfEg==
X-Gm-Message-State: ABy/qLYJZHsb8ILBcFP3JF3fGcHinreirumhmuQ5fBxeRVFBuC0M/ZD7
        GY8H7DsgQBchSGHBWLUnMk7nj1S0xi/BSarIP0JSoQ==
X-Google-Smtp-Source: APBJJlGshBzXO+g/1FUXHDi79t6rLS7Pld2ss/gr54WDYXtkqw6pOnQ+t6y4SzM3oTZEY/CPdvmGkQ==
X-Received: by 2002:a17:906:749c:b0:993:d536:3cb7 with SMTP id e28-20020a170906749c00b00993d5363cb7mr9507850ejl.11.1690214157878;
        Mon, 24 Jul 2023 08:55:57 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id e13-20020a170906080d00b009944e955e19sm6848992ejd.30.2023.07.24.08.55.57
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:55:57 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so16894a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Jul 2023 08:55:57 -0700 (PDT)
X-Received: by 2002:a50:f68e:0:b0:522:3ead:377 with SMTP id
 d14-20020a50f68e000000b005223ead0377mr33590edn.7.1690214156878; Mon, 24 Jul
 2023 08:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jul 2023 08:55:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com>
Message-ID: <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try to
 use NMI for it
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi folks,

On Thu, Jun 1, 2023 at 2:37=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> This is an attempt to resurrect Sumit's old patch series [1] that
> allowed us to use the arm64 pseudo-NMI to get backtraces of CPUs and
> also to round up CPUs in kdb/kgdb. The last post from Sumit that I
> could find was v7, so I started my series at v8. I haven't copied all
> of his old changelongs here, but you can find them from the link.
>
> I'm really looking for a way to land this patch series. In response to
> v8, Mark Rutland indicated [2] that he was worried about the soundness
> of pseudo NMI. Those definitely need to get fixed, but IMO this patch
> series could still land in the meantime. That would at least let
> people test with it.
>
> Request for anyone reading this: please help indicate your support of
> this patch series landing by replying, even if you don't have the
> background for a full review. My suspicion is that there are a lot of
> people who agree that this would be super useful to get landed.
>
> Since v8, I have cleaned up this patch series by integrating the 10th
> patch from v8 [3] into the whole series. As part of this, I renamed
> the "NMI IPI" to the "debug IPI" since it could now be backed by a
> regular IPI in the case that pseudo NMIs weren't available. With the
> fallback, this allowed me to drop some extra patches from the
> series. This feels (to me) to be pretty clean and hopefully others
> agree. Any patch I touched significantly I removed Masayoshi and
> Chen-Yu's tags from.
>
> ...also in v8, I reorderd the patches a bit in a way that seemed a
> little cleaner to me.
>
> Since v7, I have:
> * Addressed the small amount of feedback that was there for v7.
> * Rebased.
> * Added a new patch that prevents us from spamming the logs with idle
>   tasks.
> * Added an extra patch to gracefully fall back to regular IPIs if
>   pseudo-NMIs aren't there.
>
> It can be noted that this patch series works very well with the recent
> "hardlockup" patches that have landed through Andrew Morton's tree and
> are currently in linuxnext. It works especially well with the "buddy"
> lockup detector.
>
> [1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-=
email-sumit.garg@linaro.org/
> [2] https://lore.kernel.org/lkml/ZFvGqD%2F%2Fpm%2FlZb+p@FVFF77S0Q05N.camb=
ridge.arm.com/
> [3] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522=
fc3afcdfd88d7a5f030@changeid/
>
> Changes in v9:
> - Add a warning if we don't have enough IPIs for the NMI IPI
> - Added comments that we might not be using NMI always.
> - Added missing "inline"
> - Added to commit message that this doesn't catch all cases.
> - Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
> - Moved header file out of "include" since it didn't need to be there.
> - Remove arm64_supports_nmi()
> - Remove fallback for when debug IPI isn't available.
> - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> - Update commit description
> - arch_trigger_cpumask_backtrace() no longer returns bool
>
> Changes in v8:
> - "Provide a stub kgdb_nmicallback() if !CONFIG_KGDB" new for v8
> - "Tag the arm64 idle functions as __cpuidle" new for v8
> - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> - debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param
>
> Douglas Anderson (2):
>   arm64: idle: Tag the arm64 idle functions as __cpuidle
>   kgdb: Provide a stub kgdb_nmicallback() if !CONFIG_KGDB
>
> Sumit Garg (5):
>   irqchip/gic-v3: Enable support for SGIs to act as NMIs
>   arm64: Add framework for a debug IPI
>   arm64: smp: Assign and setup the debug IPI
>   arm64: ipi_debug: Add support for backtrace using the debug IPI
>   arm64: kgdb: Roundup cpus using the debug IPI
>
>  arch/arm64/include/asm/irq.h  |   3 +
>  arch/arm64/kernel/Makefile    |   2 +-
>  arch/arm64/kernel/idle.c      |   4 +-
>  arch/arm64/kernel/ipi_debug.c | 102 ++++++++++++++++++++++++++++++++++
>  arch/arm64/kernel/ipi_debug.h |  13 +++++
>  arch/arm64/kernel/kgdb.c      |  14 +++++
>  arch/arm64/kernel/smp.c       |  11 ++++
>  drivers/irqchip/irq-gic-v3.c  |  29 +++++++---
>  include/linux/kgdb.h          |   1 +
>  9 files changed, 168 insertions(+), 11 deletions(-)

I'm looking for some ideas on what to do to move this patch series
forward. Thanks to Daniel, the kgdb patch is now in Linus's tree which
hopefully makes this simpler to land. I guess there is still the
irqchip dependency that will need to be sorted out, though...

Even if folks aren't in agreement about whether this is ready to be
enabled in production, I don't think anything here is super
objectionable or controversial, is it? Can we land it? If you feel
like it needs extra review, would it help if I tried to drum up some
extra people to provide review feedback?

Also: in case it's interesting to anyone, I've been doing benchmarks
on sc7180-trogdor devices in preparation for enabling this. On that
platform, I did manage to see about 4% reduction in a set of hackbench
numbers when fully enabling pseudo-NMI. However, when I instead ran
Speedometer 2.1 I saw no difference. See:

https://issuetracker.google.com/issues/197061987

-Doug
