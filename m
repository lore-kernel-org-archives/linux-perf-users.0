Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D13C83F10
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 15:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345911AbjHaPcH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345659AbjHaPcH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 11:32:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B96E57
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 08:31:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so1259576a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693495914; x=1694100714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OkBoG7R/Bh/kZjYjKo0ralsC3KC777LpPg9zwJWSmVg=;
        b=BLVCV2x6UuwRUrcPoRGjjT00/uHYvaHs/HPN+eYKjnpDXm807xpyxjn0OYLKMIaTi9
         QF+VCeKsVpN7iVHrRJXf5aqqEwnOJCMsp61pfF82nxPWifPSTYh0+k9Q1PJYX/MgTTFC
         WRFRn5QvxA8TrFa0U71Lv3xMJw8o672BRM6rU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495914; x=1694100714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OkBoG7R/Bh/kZjYjKo0ralsC3KC777LpPg9zwJWSmVg=;
        b=ASddsIBZ4fRUKRDE26SriSPbTA5mXB7TJ/GubrIfPYv3cCq4VuU0sXTjSbbjKmUp8K
         YfYqfUXDmWARFctceGroaahiyjAcPwh9fx2GPqosN3cblnTKrDzQapmP/iiw4C6LrVKC
         Sj6nIeNNbWczK6pmevokn5gmgfjjR8tymjrlN+DavQaMx6yXkMPA+F62sOxqV+cXiEEm
         BAEZENDUc2up8k7ZNAImAdmAwVTNhaUxM72OdUYDM9h/2Jpjn1J106GMyFRK+PLNChFW
         x3UOG176ss9fdkL0wiqbwVhcWhErTktvSmWHT6fYJ1jJGs5eWRrfKLPLkLrdvDwTURBF
         h89g==
X-Gm-Message-State: AOJu0YzkeQuHz56ILbDl8dl2f0iP4XjKL96UTYr/2OL1Km/JjMUYt8Bt
        iErng5nxQN6yh6qLRDeycjkNuC/UkK6lloqeZU0SN/+N
X-Google-Smtp-Source: AGHT+IGvQCqTujTNpnHUnoZDsKW92g/avPJOM/D5bGWABnOSk+9pDhlMSm6TM35RsFVzfr22MB0S+A==
X-Received: by 2002:aa7:d9cb:0:b0:51e:2e39:9003 with SMTP id v11-20020aa7d9cb000000b0051e2e399003mr3883812eds.40.1693495914451;
        Thu, 31 Aug 2023 08:31:54 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id p11-20020a056402074b00b005231e1780aasm899488edy.91.2023.08.31.08.31.53
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 08:31:53 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso85635e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 31 Aug 2023 08:31:53 -0700 (PDT)
X-Received: by 2002:a05:600c:364f:b0:3fe:f32f:c57f with SMTP id
 y15-20020a05600c364f00b003fef32fc57fmr169559wmq.0.1693495913002; Thu, 31 Aug
 2023 08:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230830191314.1618136-1-dianders@chromium.org>
 <20230830121115.v12.1.I1223c11c88937bd0cbd9b086d4ef216985797302@changeid> <ZPBVB_z3FTl2nBy0@FVFF77S0Q05N>
In-Reply-To: <ZPBVB_z3FTl2nBy0@FVFF77S0Q05N>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 31 Aug 2023 08:31:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3-XaT_KsJXwUXVuaXfx-RfbW3ehW4JJcvWLsty_9fcA@mail.gmail.com>
Message-ID: <CAD=FV=V3-XaT_KsJXwUXVuaXfx-RfbW3ehW4JJcvWLsty_9fcA@mail.gmail.com>
Subject: Re: [PATCH v12 1/7] irqchip/gic-v3: Enable support for SGIs to act as NMIs
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Thu, Aug 31, 2023 at 1:53=E2=80=AFAM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Wed, Aug 30, 2023 at 12:11:22PM -0700, Douglas Anderson wrote:
> > As of commit 6abbd6988971 ("irqchip/gic, gic-v3: Make SGIs use
> > handle_percpu_devid_irq()") SGIs are treated the same as PPIs/EPPIs
> > and use handle_percpu_devid_irq() by default. Unfortunately,
> > handle_percpu_devid_irq() isn't NMI safe, and so to run in an NMI
> > context those should use handle_percpu_devid_fasteoi_nmi().
> >
> > In order to accomplish this, we just have to make room for SGIs in the
> > array of refcounts that keeps track of which interrupts are set as
> > NMI. We also rename the array and create a new indexing scheme that
> > accounts for SGIs.
> >
> > Also, enable NMI support prior to gic_smp_init() as allocation of SGIs
> > as IRQs/NMIs happen as part of this routine.
> >
> > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > I'll note that this change is a little more black magic to me than
> > others in this series. I don't have a massive amounts of familiarity
> > with all the moving parts of gic-v3, so I mostly just followed Mark
> > Rutland's advice [1]. Please pay extra attention to make sure I didn't
> > do anything too terrible.
> >
> > Mark's advice wasn't a full patch and I ended up doing a bit of work
> > to translate it to reality, so I did not add him as "Co-developed-by"
> > here. Mark: if you would like this tag then please provide it and your
> > Signed-off-by. I certainly won't object.
>
> That's all reasonable, and I'm perfectly happy without a tag.
>
> I have one trivial nit below, but with or without that fixed up:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> >
> > [1] https://lore.kernel.org/r/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.cambridge.a=
rm.com
> >
> > Changes in v12:
> > - Added a comment about why we account for 16 SGIs when Linux uses 8.
> >
> > Changes in v10:
> > - Rewrite as needed for 5.11+ as per Mark Rutland and Sumit.
> >
> >  drivers/irqchip/irq-gic-v3.c | 59 +++++++++++++++++++++++++-----------
> >  1 file changed, 41 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.=
c
> > index eedfa8e9f077..8d20122ba0a8 100644
> > --- a/drivers/irqchip/irq-gic-v3.c
> > +++ b/drivers/irqchip/irq-gic-v3.c
> > @@ -78,6 +78,13 @@ static DEFINE_STATIC_KEY_TRUE(supports_deactivate_ke=
y);
> >  #define GIC_LINE_NR  min(GICD_TYPER_SPIS(gic_data.rdists.gicd_typer), =
1020U)
> >  #define GIC_ESPI_NR  GICD_TYPER_ESPIS(gic_data.rdists.gicd_typer)
> >
> > +/*
> > + * There are 16 SGIs, though we only actually use 8 in Linux. The othe=
r 8 SGIs
> > + * are potentially stolen by the secure side. Some code, especially co=
de dealing
> > + * with hwirq IDs, is simplified by accounting for all 16.
> > + */
> > +#define SGI_NR               16
> > +
> >  /*
> >   * The behaviours of RPR and PMR registers differ depending on the val=
ue of
> >   * SCR_EL3.FIQ, and the behaviour of non-secure priority registers of =
the
> > @@ -125,8 +132,8 @@ EXPORT_SYMBOL(gic_nonsecure_priorities);
> >               __priority;                                             \
> >       })
> >
> > -/* ppi_nmi_refs[n] =3D=3D number of cpus having ppi[n + 16] set as NMI=
 */
> > -static refcount_t *ppi_nmi_refs;
> > +/* rdist_nmi_refs[n] =3D=3D number of cpus having the rdist interrupt =
n set as NMI */
> > +static refcount_t *rdist_nmi_refs;
> >
> >  static struct gic_kvm_info gic_v3_kvm_info __initdata;
> >  static DEFINE_PER_CPU(bool, has_rss);
> > @@ -519,9 +526,22 @@ static u32 __gic_get_ppi_index(irq_hw_number_t hwi=
rq)
> >       }
> >  }
> >
> > -static u32 gic_get_ppi_index(struct irq_data *d)
> > +static u32 __gic_get_rdist_idx(irq_hw_number_t hwirq)
> > +{
> > +     switch (__get_intid_range(hwirq)) {
> > +     case SGI_RANGE:
> > +     case PPI_RANGE:
> > +             return hwirq;
> > +     case EPPI_RANGE:
> > +             return hwirq - EPPI_BASE_INTID + 32;
> > +     default:
> > +             unreachable();
> > +     }
> > +}
> > +
> > +static u32 gic_get_rdist_idx(struct irq_data *d)
> >  {
> > -     return __gic_get_ppi_index(d->hwirq);
> > +     return __gic_get_rdist_idx(d->hwirq);
> >  }
>
> Nit: It would be nicer to call this gic_get_rdist_index() to match
> gic_get_ppi_index(); likewise with __gic_get_rdist_index().
>
> That's my fault given I suggested the gic_get_rdist_idx() name in:
>
>   https://lore.kernel.org/linux-arm-kernel/ZNC-YRQopO0PaIIo@FVFF77S0Q05N.=
cambridge.arm.com/
>
> ... so sorry about that!

Yeah, I kept the name you suggested even though it seemed a little
inconsistent. I'll happily send a v13 with that fixed up, though I'll
probably wait a little bit just to avoid spamming new versions too
quickly. It's not like the patches can land in the middle of the merge
window anyway.

Unless someone says otherwise, I guess this series is in good shape to
land then. Does anyone have any plans for the details of how to land
it? I guess this would be something that Marc, Catalin and Will would
need to hash out since the first patch would ideally go through a
different tree than the others.

-Doug
