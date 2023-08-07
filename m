Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CCAC04A6A
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Aug 2023 12:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjHGMrF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjHGMrD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2023 08:47:03 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C4E1BE2
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Aug 2023 05:46:41 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4475af775c7so1539259137.0
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Aug 2023 05:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691412396; x=1692017196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9t5nBRjNzdkdc9QzeOluuR4xKMtvtID49kCNpeDzH2Y=;
        b=FwJjNe45kCbq5qXs+ry0Q1vC6w59/+Im+9Iw2Tvscb/IIQ6465g0P045SBWdXLPzfu
         yaOXI7hqamCPU3+JqHAHlSS0YR8n2hLDcFZsuRBYGWZ1hyYrkRwaaknrdd1Eo359Wd6V
         QZSWH6AgC8J/18tkRHRkXXwmUvJb7B0LUjdyUwabFXwkWlTS/nihJu6LO6LbsA+hxij1
         xxXoF11NXguL33AeDKFUig6UTUosMmFCJgeN+8JsIDHFUuftJTlebpAjy8WeWwt/GoEt
         df1gb0u1BPJIWSG/F3il55Dy8PSlm4YXmVYH7vvixK95vYt1LpMbaMXPoZwdxjZNrJJM
         PzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691412396; x=1692017196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9t5nBRjNzdkdc9QzeOluuR4xKMtvtID49kCNpeDzH2Y=;
        b=Mg0OdUoOUkdjI36sCEnyFseZ8XNObDaBhAZwNsEbxnD1HGhDtqnT6vq/8DJ72Xd407
         BhGcy8ZdEhEIDxvw225EWQms3mrJfJzBa2V8zaeMC1/ndl8/M7iwa7kTb4xAd5SUrF0X
         TcCG2wtTICr5zppGzineCm2z2Oo7Jf3a2Bq8REj0IiZ+VZ2lCsVh3x1gFSETroE1CprB
         cn1ImcgTCsdw5mL0GEdd1S0cYj6N5CF5P2Ef15lucCxB9u4Th/T+/hb+/MkUXkCy1+iQ
         4RLFZvg3dd71kz+JDElPOUW+mVIHpelahbpmNvwT5h2D+fdLM4H6NPkfvCxbCE2w8kcp
         QraA==
X-Gm-Message-State: AOJu0YxHuTbjPQYkymKxLKnjVP7TiFu+vHTVihbOBXz7PthCrwWsWF7S
        vFMJIIfvsALu7hB4AHnH4uFfKXXt3HSUzFTKFogfOHyzuHq/DT1iIJ0=
X-Google-Smtp-Source: AGHT+IG2sQb4KYXITpRPT/2oajN8A3GYoBsP/KAHU7XnME8OTvWW3UQnsC7Bentk96hJ/VHFSMldrPbP1fvvCyVgaIE=
X-Received: by 2002:a67:f912:0:b0:446:da54:19b3 with SMTP id
 t18-20020a67f912000000b00446da5419b3mr4527404vsq.23.1691412395913; Mon, 07
 Aug 2023 05:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
 <CAD=FV=V2fFqwg3f3KS29+AkggHFDbyYvfAb12DrDn_PF8+bJjA@mail.gmail.com> <ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZNDKVP2m-iiZCz3v@FVFF77S0Q05N.cambridge.arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 7 Aug 2023 18:16:24 +0530
Message-ID: <CAFA6WYMD4TRR5psUyhu2jhZ2XBMUfav3D7_eH1HE8VJfXc7Fuw@mail.gmail.com>
Subject: Re: [PATCH v9 0/7] arm64: Add debug IPI for backtraces / kgdb; try to
 use NMI for it
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
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

On Mon, 7 Aug 2023 at 16:11, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Doug,
>
> Apologies for the delay.
>
> On Mon, Jul 24, 2023 at 08:55:44AM -0700, Doug Anderson wrote:
> > On Thu, Jun 1, 2023 at 2:37=E2=80=AFPM Douglas Anderson <dianders@chrom=
ium.org> wrote:
> > I'm looking for some ideas on what to do to move this patch series
> > forward. Thanks to Daniel, the kgdb patch is now in Linus's tree which
> > hopefully makes this simpler to land. I guess there is still the
> > irqchip dependency that will need to be sorted out, though...
> >
> > Even if folks aren't in agreement about whether this is ready to be
> > enabled in production, I don't think anything here is super
> > objectionable or controversial, is it? Can we land it? If you feel
> > like it needs extra review, would it help if I tried to drum up some
> > extra people to provide review feedback?
>
> Ignoring the soundness issues I mentioned before (which I'm slowly chippi=
ng
> away at, and you're likely lucky enough to avoid in practice)...
>
> Having looked over the series, I think the GICv3 bit isn't quite right, b=
ut is
> easy enough to fix. I've commented on the patch with what I think we shou=
ld
> have there.

Thanks for catching this and I agree with your proposed fix.

>
> The only major thing otherwise from my PoV is the structure of the debug =
IPI
> framework. I'm not keen on that being a separate body of code and I think=
 it
> should live in smp.c along with the other IPIs.

That's a fair point.

> I'd also strongly prefer if we
> could have separate IPI_CPU_BACKTRACE and IPI_CPU_KGDB IPIs,

With current logic of single debug IPI, it is not required for a user
to enable KGDB in order to use that IPI for backtrace. The original
motivation for this logic was that the IPIs are a scarce resource on
arm64 as per comments from Marc. So I am fine either way to keep them
separate or unified.

> and I think we can
> do that either by unifying IPI_CPU_STOP && IPI_CPU_CRASH_STOP or by recla=
iming
> IPI_WAKEUP by reusing a different IPI for the parking protocol (e.g.
> IPI_RESCHEDULE).

That sounds like a good cleanup.

>
> I think it'd be nice if the series could enable NMIs for backtrace and th=
e
> CPU_{,CRASH_}STOP cases, with KGDB being the bonus atop. That way it'd be
> clearly beneficial for anyone trying to debug lockups even if they're not=
 a
> KGDB user.
>

It's good to see other use-cases of IPIs turned into NMIs.

-Sumit

> > Also: in case it's interesting to anyone, I've been doing benchmarks
> > on sc7180-trogdor devices in preparation for enabling this. On that
> > platform, I did manage to see about 4% reduction in a set of hackbench
> > numbers when fully enabling pseudo-NMI. However, when I instead ran
> > Speedometer 2.1 I saw no difference. See:
> >
> > https://issuetracker.google.com/issues/197061987
>
> Thanks for the pointer!
>
> I know that there are a couple of things that we could do to slightly imp=
rove
> local_irq_*() when using pNMIs, though I suspect that the bulk of the cos=
t
> there will come from the necessary synchronization.
>
> Thanks,
> Mark.
