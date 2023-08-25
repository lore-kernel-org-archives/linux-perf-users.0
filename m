Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692CDC83F07
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 23:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjHYXXx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 19:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjHYXXX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 19:23:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D328B2129
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 16:23:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-5008d16cc36so2161814e87.2
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 16:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693005799; x=1693610599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4y/MCOutpdQ9jrdBYlOHctxvB4AexelxGOeGhkirgy8=;
        b=U8NKwCCNSifsc2lSTaq4WiTeE1T6YuPABAyz74CRhWhIPiyirbpLKqOOyHPBIdfVD0
         Itd8MKaLEcUQ+vuDtqtCUcpbE2MedhssvMzV160oBFM/wKbNn9o4q7ThtKK6zbFpzaiE
         BMDad/zHG8StzWD3C1o3qgOLzhAp0vVKoTLs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693005799; x=1693610599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4y/MCOutpdQ9jrdBYlOHctxvB4AexelxGOeGhkirgy8=;
        b=isNlpKn8HLJ3h/WsaBps7sQD32RXmgTXQU4xDpntV+WUD67SP5cIwB7zTAeRNunGR2
         kOcR9euQBvBMvkWbsfGpA8Hg6NJjRzEM1alR4BZBQMWjxjLL7tcLnc1pJM+WOiICzHZD
         4924YRtxxBmb01Wz6lCEsj+j5kBR1vL+pXK6QCszsoFrQ6v4XyphpniTdLKPhU4cqnER
         HVECbyABy5g8ekszNpL3AD2PdH3nf4RFm7jQlFQXSNPiXis209XPDIPfnyiLKeHDXg4b
         tXCBap+s9W0viruwYsm1dhitxTLgq2S45UxYGL4s0tv+PIzdyNxN52rsxHGjN+kAFsRF
         Y63w==
X-Gm-Message-State: AOJu0YzlYSbQom5vVbl5iFVvzoYVCF29MWNlOiUCn2gVS9ePcyLFvkf0
        nYRXdzVxDuKqkowbv13rKAmqG0aW0qcio0pXYjSEKw==
X-Google-Smtp-Source: AGHT+IEHxDRNRzDhD7J/HEqvUIEgnQd72FT7NvreGyXrsE98RFOiKe9Js51h5J1CykBkagVO4tydb+PQ0x7QUhyImSE=
X-Received: by 2002:ac2:5f4b:0:b0:500:9ee2:15f with SMTP id
 11-20020ac25f4b000000b005009ee2015fmr3398223lfz.46.1693005799136; Fri, 25 Aug
 2023 16:23:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 18:23:18 -0500
MIME-Version: 1.0
In-Reply-To: <CAD=FV=U24kF7WbZPKMbk=kJMU14+yFJXpGWWfj0fPbA9J6h0Eg@mail.gmail.com>
References: <20230824153233.1006420-1-dianders@chromium.org>
 <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
 <CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com> <CAD=FV=U24kF7WbZPKMbk=kJMU14+yFJXpGWWfj0fPbA9J6h0Eg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 18:23:18 -0500
Message-ID: <CAE-0n514xGWz1yaF84zL=QBCQcMwct+pu8nLBgRHPq6+DE3g5g@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     Doug Anderson <dianders@chromium.org>
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

Quoting Doug Anderson (2023-08-25 16:02:46)
> On Fri, Aug 25, 2023 at 3:27=E2=80=AFPM Stephen Boyd <swboyd@chromium.org=
> wrote:
> >
> > Quoting Douglas Anderson (2023-08-24 08:30:30)
> > > diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/ir=
q.h
> > >
> > >  static int ipi_irq_base __read_mostly;
> > >  static int nr_ipi __read_mostly =3D NR_IPI;
> > > -static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
> > > +static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
> >
> > Side note: it would be nice to mark ipi_desc as __ro_after_init. Same
> > for nr_ipi and ipi_irq_base.
>
> I'd rather not change it in this patch since it's a pre-existing and
> separate issue, but I can add a patch to the end of the series for
> that if I end up spinning it. Otherwise I can send a follow-up patch
> for it.

Of course. Don't change it in this patch.

>
>
> > >  static void ipi_setup(int cpu);
> > >
> > > @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsign=
ed int cpu, struct pt_regs *regs
> > >  #endif
> > >  }
> > >
> > > +static void arm64_backtrace_ipi(cpumask_t *mask)
> > > +{
> > > +       __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> > > +}
> > > +
> > > +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclu=
de_cpu)
> >
> > Can this be 'bool exclude_self' instead of int? That matches all other
> > implementations from what I can tell.
>
> Nope. See the part of the commit message that says:
>
> This patch depends on commit 36759e343ff9 ("nmi_backtrace: allow
> excluding an arbitrary CPU") since that commit changed the prototype
> of arch_trigger_cpumask_backtrace(), which this patch implements.

Ah, ok. Sounds fine then.
