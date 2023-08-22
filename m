Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D604EE49A0
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 00:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjHVAHJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 20:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHVAHI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 20:07:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066D13E
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 17:07:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c353a395cso517660166b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692662824; x=1693267624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7J3x0Gt197keDgNUTYsLDArxgf8balIGee5TfL+T5L0=;
        b=Epf+6K1t2/miCODr+6hk8Whp+fdXM4dhbOLNsLUrEF6cOWxmT8luLIg3ZXPsFuzzrr
         wwrDAQnPmYCXIfUhskQ6bIc2guqaJi7sOnoIkdh8dsQpfFeE9UDCtbI/aky71AL0T/HG
         B5juM5Qsu1DJJipqXNG7uqEzvKnCNyFt37OK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692662824; x=1693267624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7J3x0Gt197keDgNUTYsLDArxgf8balIGee5TfL+T5L0=;
        b=jQ0p3T321AQUOJBgwMB8QHyy0fc4Bbl8CM8uce77RBZobIBaWjq5Vp8o8o7BsKkFBa
         WSB1FuUhIWBf5sQD/SyyhlyUuFLC0asYMbaMGCiQENO8z3mVEENzSpQmPPAjiM/xpnnk
         NO8X4eklBmu05JImqzM4XNPZZOe1HrTmREKTZ3npFZnvKCp0AHtjzOldaUrOt9VDDzkJ
         bgUWi6X3lu71wjaoJOMkpIWT+aZWO+oCwF/ltobdAFL8yxn3PG3ic4F5iRu5Aq8c39gZ
         si2qVYRYL+ynz3I+pvZewTqmeh1klKT+GAywIlC5yS5NkD1GMRIzK1mAKcQxsaLp7xYN
         mIdQ==
X-Gm-Message-State: AOJu0Ywnm5ZfMG2P1bnDCNDoFqPMlID8M8vTW3uYJJgVLraNsrRxYQXu
        vNUITZEoDCvHLlod5OC4kmmUT8X7qLOQJNcXcNEn+CbN
X-Google-Smtp-Source: AGHT+IF4rW6POX2yeMG8cIDmVmfdDWdH8Tdab9meVpajYvWHprMAblBwkKHVjpJzIKauA6ru0g6Oxw==
X-Received: by 2002:a17:907:2c57:b0:98e:419b:4cc6 with SMTP id hf23-20020a1709072c5700b0098e419b4cc6mr5572152ejc.70.1692662824307;
        Mon, 21 Aug 2023 17:07:04 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id mb12-20020a170906eb0c00b0099bd5b72d93sm7297515ejb.43.2023.08.21.17.07.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 17:07:03 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-521e046f6c7so2816a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 17:07:03 -0700 (PDT)
X-Received: by 2002:a50:8757:0:b0:51a:1ffd:10e with SMTP id
 23-20020a508757000000b0051a1ffd010emr19923edv.3.1692662823330; Mon, 21 Aug
 2023 17:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid> <ZNDGMJW01avOMShn@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZNDGMJW01avOMShn@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 17:06:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wz4Y836__Fo=Va8ek9BLEoTTbYx_zycBuVony37eOGVg@mail.gmail.com>
Message-ID: <CAD=FV=Wz4Y836__Fo=Va8ek9BLEoTTbYx_zycBuVony37eOGVg@mail.gmail.com>
Subject: Re: [PATCH v9 5/7] arm64: ipi_debug: Add support for backtrace using
 the debug IPI
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
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
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Mon, Aug 7, 2023 at 3:23=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Thu, Jun 01, 2023 at 02:31:49PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Enable arch_trigger_cpumask_backtrace() support on arm64 using the new
> > debug IPI. With this arm64 can now get backtraces in cases where
> > callers of the trigger_xyz_backtrace() class of functions don't check
> > the return code and implement a fallback. One example is
> > `kernel.softlockup_all_cpu_backtrace`. This also allows us to
> > backtrace hard locked up CPUs in cases where the debug IPI is backed
> > by an NMI (or pseudo NMI).
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v9:
> > - Added comments that we might not be using NMI always.
> > - Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
> > - arch_trigger_cpumask_backtrace() no longer returns bool
> >
> > Changes in v8:
> > - Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
> >
> >  arch/arm64/include/asm/irq.h  |  3 +++
> >  arch/arm64/kernel/ipi_debug.c | 25 +++++++++++++++++++++++--
> >  2 files changed, 26 insertions(+), 2 deletions(-)
>
> As with prior patches, I'd prefer if this lived in smp.c with the other I=
PI
> logic.
>
> >
> > diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.=
h
> > index fac08e18bcd5..be2d103f316e 100644
> > --- a/arch/arm64/include/asm/irq.h
> > +++ b/arch/arm64/include/asm/irq.h
> > @@ -6,6 +6,9 @@
> >
> >  #include <asm-generic/irq.h>
> >
> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclud=
e_self);
> > +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> > +
> >  struct pt_regs;
> >
> >  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
> > diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debu=
g.c
> > index b57833e31eaf..6984ed507e1f 100644
> > --- a/arch/arm64/kernel/ipi_debug.c
> > +++ b/arch/arm64/kernel/ipi_debug.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > +#include <linux/nmi.h>
> >  #include <linux/smp.h>
> >
> >  #include "ipi_debug.h"
> > @@ -24,11 +25,31 @@ void arm64_debug_ipi(cpumask_t *mask)
> >       __ipi_send_mask(ipi_debug_desc, mask);
> >  }
> >
> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclud=
e_self)
> > +{
> > +     /*
> > +      * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the n=
ame,
> > +      * nothing about it truly needs to be backed by an NMI, it's just=
 that
> > +      * it's _allowed_ to be called from an NMI. If set_smp_debug_ipi(=
)
> > +      * failed to get an NMI (or pseudo-NMI) this will just be backed =
by a
> > +      * regular IPI.
> > +      */
> > +     nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_debug_ipi=
);
> > +}
> > +
> >  static irqreturn_t ipi_debug_handler(int irq, void *data)
> >  {
> > -     /* nop, NMI handlers for special features can be added here. */
> > +     irqreturn_t ret =3D IRQ_NONE;
> > +
> > +     /*
> > +      * NOTE: Just like in arch_trigger_cpumask_backtrace(), we're cal=
ling
> > +      * a function with "nmi_" in the name but it works fine even if w=
e
> > +      * are using a regulaor IPI.
> > +      */
> > +     if (nmi_cpu_backtrace(get_irq_regs()))
> > +             ret =3D IRQ_HANDLED;
> >
>
> Does this need the printk_deferred_{enter,exit}() that 32-bit arm has?

I don't _think_ so, but I also don't _think_ it's needed for arm32.
;-) Let me explain my logic and you can tell me if it sounds right to
you.

If we're doing the backtrace in pseudo-NMI context then we definitely
don't need it. Specifically, the printk_deferred_{enter,exit}() just
manages the per-cpu "printk_context" value. That value doesn't matter
if "in_nmi()" returns true.

If we're _not_ doing the backtrace in pseudo-NMI context then I think
we also don't need it. After all, if we're not in pseudo-NMI context
then it's perfectly fine to print, right?

While it's hard to know 100% for sure, my best guess is that in arm
this might have helped prevent stack traces from getting interspersed
among one another. I guess this is no longer needed as of commit
55d6af1d6688 ("lib/nmi_backtrace: explicitly serialize banner and
regs")? In any case, when I tested this earlier things seemed to
printout fine without it...

That being said, it wouldn't hurt to include it here and I'll do it if you =
want.

-Doug
