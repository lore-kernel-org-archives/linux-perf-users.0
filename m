Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E488C83F04
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 23:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjHYXDR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 19:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjHYXDK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 19:03:10 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F026D2117
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 16:03:07 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c93638322so300685566b.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693004584; x=1693609384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUQeoEtJIbpPqZk/kirNVPmfBI5GvX7ZX6+7/bN246Q=;
        b=Hge3pryFvMKh7+5m50952T5UCNUhGkRwOuw2N2TnNiUPq2OEeKFIhi99Fq99S/5fHg
         C60a3WTUv0Jn7f9A+pbYa22HtepULsZtgW3RspK3sfh4IErPDhUraYtOliXuUfOXcgl0
         kjUWPBMBoLtAYTLQLlq3UeqqvwVLhneE0e734=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693004584; x=1693609384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUQeoEtJIbpPqZk/kirNVPmfBI5GvX7ZX6+7/bN246Q=;
        b=JH7bQ5kvuTeN+BnNPIXLAIMwSwFENubBRKAcazOxNkYmTPSzti4oq6frgT59W3n4qx
         dUFtVRB7zPv1meQOKYd9IFhSntFblixpetmUUX5Q2LXw9wxhH8tRWBoubIUUV1mkZXW3
         OUTzqrk70IT04HKGSEoEq5MC4MLZvxIDrG4k4TIjaC0BSwuvYDk4KGQC18WQSOu8+ohl
         KrIJUxfgKAP7FX4J/axGFcJHbA/Ay1mCJFd2ZwKPYsunGHLQAeL6cAoN6oIVjYcX5GCP
         c/PiKKvsvBzpAGGc0FqjnnQyQ4AqsCDGq/7Sw5UQBTsk8cBtQIrdqv/laZq/mpE80QNy
         gbfA==
X-Gm-Message-State: AOJu0YymsZeqAGKoUvgSbyvdKlVUfTMnDRFGVw2IGndRzI6CRkEkf7sh
        7ALlpj+Sw2DSEuRngVFY5ObSPu/flgWlkHIkf+UT6NBZ
X-Google-Smtp-Source: AGHT+IG4GdNwxIEqA/oZPm/O34iPw6nxh1g4DFj77aN+jGRUDtMZucELozmhhqmL54s6HlEtVcdruQ==
X-Received: by 2002:a17:906:518d:b0:9a1:fda6:2e2a with SMTP id y13-20020a170906518d00b009a1fda62e2amr7800001ejk.9.1693004584593;
        Fri, 25 Aug 2023 16:03:04 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id b10-20020a170906490a00b009a1be9c29d7sm1432133ejq.179.2023.08.25.16.03.03
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Aug 2023 16:03:03 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso14245e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 16:03:03 -0700 (PDT)
X-Received: by 2002:a05:600c:501e:b0:3f7:e4d8:2569 with SMTP id
 n30-20020a05600c501e00b003f7e4d82569mr45412wmr.5.1693004583371; Fri, 25 Aug
 2023 16:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid> <CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com>
In-Reply-To: <CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 25 Aug 2023 16:02:46 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U24kF7WbZPKMbk=kJMU14+yFJXpGWWfj0fPbA9J6h0Eg@mail.gmail.com>
Message-ID: <CAD=FV=U24kF7WbZPKMbk=kJMU14+yFJXpGWWfj0fPbA9J6h0Eg@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Fri, Aug 25, 2023 at 3:27=E2=80=AFPM Stephen Boyd <swboyd@chromium.org> =
wrote:
>
> Quoting Douglas Anderson (2023-08-24 08:30:30)
> > diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.=
h
> > index fac08e18bcd5..50ce8b697ff3 100644
> > --- a/arch/arm64/include/asm/irq.h
> > +++ b/arch/arm64/include/asm/irq.h
> > @@ -6,6 +6,9 @@
> >
> >  #include <asm-generic/irq.h>
> >
> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude=
_cpu);
>
> Some nits, but otherwise
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
>
> > +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> > +
> >  struct pt_regs;
> >
> >  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
> > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > index a5848f1ef817..c8896cbc5327 100644
> > --- a/arch/arm64/kernel/smp.c
> > +++ b/arch/arm64/kernel/smp.c
> > @@ -72,12 +73,18 @@ enum ipi_msg_type {
> >         IPI_CPU_CRASH_STOP,
> >         IPI_TIMER,
> >         IPI_IRQ_WORK,
> > -       NR_IPI
> > +       NR_IPI,
> > +       /*
> > +        * Any enum >=3D NR_IPI and < MAX_IPI is special and not tracab=
le
> > +        * with trace_ipi_*
> > +        */
> > +       IPI_CPU_BACKTRACE =3D NR_IPI,
> > +       MAX_IPI
> >  };
> >
> >  static int ipi_irq_base __read_mostly;
> >  static int nr_ipi __read_mostly =3D NR_IPI;
> > -static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
> > +static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
>
> Side note: it would be nice to mark ipi_desc as __ro_after_init. Same
> for nr_ipi and ipi_irq_base.

I'd rather not change it in this patch since it's a pre-existing and
separate issue, but I can add a patch to the end of the series for
that if I end up spinning it. Otherwise I can send a follow-up patch
for it.


> >  static void ipi_setup(int cpu);
> >
> > @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsigned=
 int cpu, struct pt_regs *regs
> >  #endif
> >  }
> >
> > +static void arm64_backtrace_ipi(cpumask_t *mask)
> > +{
> > +       __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> > +}
> > +
> > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude=
_cpu)
>
> Can this be 'bool exclude_self' instead of int? That matches all other
> implementations from what I can tell.

Nope. See the part of the commit message that says:

This patch depends on commit 36759e343ff9 ("nmi_backtrace: allow
excluding an arbitrary CPU") since that commit changed the prototype
of arch_trigger_cpumask_backtrace(), which this patch implements.

> > +{
> > +       /*
> > +        * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the=
 name,
>
> USe nmi_trigger_cpumask_backtrace() to indicate function.

I won't plan on doing an immediate spin for this and for now I'll wait
for additional feedback. If a maintainer is getting ready to land
this, I'm happy to post a new version with this fix or also happy if a
maintainer wants to add the "()" while applying.

-Doug
