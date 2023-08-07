Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B102C001B0
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Aug 2023 11:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjHGL0y (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjHGL0k (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2023 07:26:40 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334D530D4
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Aug 2023 04:23:39 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7948c329363so1190691241.0
        for <linux-perf-users@vger.kernel.org>; Mon, 07 Aug 2023 04:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691407371; x=1692012171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iMLr1Gc880uh/ZHXumz1rEhP4HlyB4PKNyXqL+18D8M=;
        b=J/kOXBGY4ZtoV5dZQHzLSJ0KpsvnTfi/Fzuh+zYMKGj2tdw66/FNXbUwQ49+6H4jga
         LWQ6ikvUejtEBuOmQIRO7OYwq1t+KmNBF8kEuU6GOdvR2jzk0HMUMAREME7AduEpDhhW
         ovuvWFhQdGjgs1+EuR6AIVdAb/Fd35siMbhWZMlbH96tONpp2lZAwAJz3lZCy2IFs/oD
         3Q0FSiSpp+66RwkFxtGDL7zqxc4k1CIWKQIpQaV1D7R9u/hgzJSd6jBvymcJOyT+nXlv
         hOmPWk6LyyG0PmuVihGN1tAlGiGpTONAdzQr545SaDkAqS6YZfF6Yq3Z0b4QFGWKWw5O
         ruhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691407371; x=1692012171;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iMLr1Gc880uh/ZHXumz1rEhP4HlyB4PKNyXqL+18D8M=;
        b=FHGQMmgMyDokqJOglCPD2DeRTTG1WsUTOYlp9ZV9gjEdeHXewjQtkQ1DSFJIt1gIdk
         I7nM06uLOUQH5B3mqlC3hAFzklcwlgBcouxMfqNxXvdz76Qy9nzmywZ5sCSJBPgsL7rG
         S5oJApbBgKJ/lslGAFJxjIcsGo2BGAl8w+l2S7Eq7n8uHdJkHDrR559YdXT13CGDRZM9
         XzHGNJv3Yr1O+ooNKGeyuXFskuTJD1p7xlZAG1pKoM1qLiFYVbwpBLpAxRYMHnrsza4p
         YmyWkJDXNEW6LQ79Jbp22kNlLpUYmUnlDJHYIEKRnCV8RoLiBsUrpkZMkGFD4CKqtdrv
         IOtA==
X-Gm-Message-State: AOJu0Yy4Re2CwhpQKma6E2bT3f8ZTTTtQnMpSbJtPd23b7JzD0QMytdd
        DD+8Ei+TCPevqrKkNzdjcH8QvQ2nvUy0qZrAFWp5AQ==
X-Google-Smtp-Source: AGHT+IEj+i5FlUU3khAH/NnmUUvb6VWoy0zsekkbZJPac2ghU15i5jblnPnt8dkmw1sS5evkaKc3+45FPGj4U8a4MY8=
X-Received: by 2002:a05:6102:150:b0:437:e5ce:7e8f with SMTP id
 a16-20020a056102015000b00437e5ce7e8fmr4526221vsr.4.1691407371300; Mon, 07 Aug
 2023 04:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid> <ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 7 Aug 2023 16:52:40 +0530
Message-ID: <CAFA6WYN7SH83mnTPqBj9=hCakM=KJkor7fMQasdeBe6Ue5JXRg@mail.gmail.com>
Subject: Re: [PATCH v9 1/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
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
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Mark,

On Mon, 7 Aug 2023 at 15:20, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Doug,
>
> On Thu, Jun 01, 2023 at 02:31:45PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Add support to handle SGIs as pseudo NMIs. As SGIs or IPIs default to a
> > special flow handler: handle_percpu_devid_fasteoi_ipi(), so skip NMI
> > handler update in case of SGIs.
>
> I couldn't find handle_percpu_devid_fasteoi_ipi() in mainline, and when
> researching I found that we changed that in commit:
>
>   6abbd6988971aaa6 ("irqchip/gic, gic-v3: Make SGIs use handle_percpu_devid_irq()")
>
> ... which was in v5.11, so it looks like this is stale?

The last time I tested this patchset (v7 [1]) was with kernel
v5.9.0-rc3. So I agree with you that later
handle_percpu_devid_fasteoi_ipi() was removed and the SGI handling
flow almost became identical to PPI.

[1] https://lore.kernel.org/linux-arm-kernel/1604317487-14543-1-git-send-email-sumit.garg@linaro.org/

>
> Since that commit, SGIs are treated the same as PPIs/EPPIs, and use
> handle_percpu_devid_irq() by default.
>
> IIUC handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI context
> those should use handle_percpu_devid_fasteoi_nmi().

True.

>
> Marc, does that sound right to you? i.e. SGI NMIs should be handled exactly the
> same as PPI NMIs, and use handle_percpu_devid_fasteoi_nmi()?
>
> I have some comments below assuming that SGI NMIs should use
> handle_percpu_devid_fasteoi_nmi().
>

This sounds fine to me.

> > Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> > as IRQs/NMIs happen as part of this routine.
>
> This bit looks fine to me.
>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  drivers/irqchip/irq-gic-v3.c | 29 +++++++++++++++++++++--------
> >  1 file changed, 21 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> > index 0c6c1af9a5b7..ed37e02d4c5f 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -525,6 +525,7 @@ static u32 gic_get_ppi_index(struct irq_data *d)
> >  static int gic_irq_nmi_setup(struct irq_data *d)
> >  {
> >       struct irq_desc *desc = irq_to_desc(d->irq);
> > +     u32 idx;
> >
> >       if (!gic_supports_nmi())
> >               return -EINVAL;
> > @@ -542,16 +543,22 @@ static int gic_irq_nmi_setup(struct irq_data *d)
> >               return -EINVAL;
> >
> >       /* desc lock should already be held */
> > -     if (gic_irq_in_rdist(d)) {
> > -             u32 idx = gic_get_ppi_index(d);
> > +     switch (get_intid_range(d)) {
> > +     case SGI_RANGE:
> > +             break;
> > +     case PPI_RANGE:
> > +     case EPPI_RANGE:
> > +             idx = gic_get_ppi_index(d);
> >
> >               /* Setting up PPI as NMI, only switch handler for first NMI */
> >               if (!refcount_inc_not_zero(&ppi_nmi_refs[idx])) {
> >                       refcount_set(&ppi_nmi_refs[idx], 1);
> >                       desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
> >               }
> > -     } else {
> > +             break;
> > +     default:
> >               desc->handle_irq = handle_fasteoi_nmi;
> > +             break;
> >       }
>
> As above, I reckon this isn't right, and we should treat all rdist interrupts
> (which are all percpu) the same.
>
> I reckon what we should be doing here is make ppi_nmi_refs cover all of the
> rdist interrupts (e.g. make that rdist_nmi_refs, add a gic_get_rdist_idx()
> helper), and then here have something like:
>
>         if (gic_irq_in_rdist(d)) {
>                 u32 idx = gic_get_rdist_idx(d);
>
>                 /*
>                  * Setting up a percpu interrupt as NMI, only switch handler
>                  * for first NMI
>                  */
>                 if (!refcount_inc_not_zero(&rdist_nmi_refs[idx])) {
>                         refcount_set(&ppi_nmi_refs[idx], 1);
>                         desc->handle_irq = handle_percpu_devid_fasteoi_nmi;
>                 }
>         }

It looks like you missed the else part here as follows for all other
interrupt types:

         } else {
                 desc->handle_irq = handle_fasteoi_nmi;
         }

Apart from that, your logic sounds good to me.

-Sumit

>
> ... as an aside, it'd be nicer if we could switch the handler at request time,
> as then we wouldn't need the refcount at all, but I couldn't see a good irqchip
> hook to hang that off, so I don't think that needs to change as a prerequisite.
>
> >
> >       gic_irq_set_prio(d, GICD_INT_NMI_PRI);
> > @@ -562,6 +569,7 @@ static int gic_irq_nmi_setup(struct irq_data *d)
> >  static void gic_irq_nmi_teardown(struct irq_data *d)
> >  {
> >       struct irq_desc *desc = irq_to_desc(d->irq);
> > +     u32 idx;
> >
> >       if (WARN_ON(!gic_supports_nmi()))
> >               return;
> > @@ -579,14 +587,20 @@ static void gic_irq_nmi_teardown(struct irq_data *d)
> >               return;
> >
> >       /* desc lock should already be held */
> > -     if (gic_irq_in_rdist(d)) {
> > -             u32 idx = gic_get_ppi_index(d);
> > +     switch (get_intid_range(d)) {
> > +     case SGI_RANGE:
> > +             break;
> > +     case PPI_RANGE:
> > +     case EPPI_RANGE:
> > +             idx = gic_get_ppi_index(d);
> >
> >               /* Tearing down NMI, only switch handler for last NMI */
> >               if (refcount_dec_and_test(&ppi_nmi_refs[idx]))
> >                       desc->handle_irq = handle_percpu_devid_irq;
> > -     } else {
> > +             break;
> > +     default:
> >               desc->handle_irq = handle_fasteoi_irq;
> > +             break;
> >       }
>
> Same comments as for gic_irq_nmi_setup() here.
>
> >
> >       gic_irq_set_prio(d, GICD_INT_DEF_PRI);
> > @@ -2001,6 +2015,7 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
> >
> >       gic_dist_init();
> >       gic_cpu_init();
> > +     gic_enable_nmi_support();
> >       gic_smp_init();
> >       gic_cpu_pm_init();
> >
> > @@ -2013,8 +2028,6 @@ static int __init gic_init_bases(phys_addr_t dist_phys_base,
> >                       gicv2m_init(handle, gic_data.domain);
> >       }
> >
> > -     gic_enable_nmi_support();
> > -
>
> This bit looks fine to me.
>
> Thanks,
> Mark.
