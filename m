Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080D9C7EE22
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 23:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjEOXMO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 19:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245415AbjEOXMN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 19:12:13 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CC7D99
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 16:12:11 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f475746ae0so37213891cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 16:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684192330; x=1686784330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqtkImGxR85aToYA0Aq0yuOc2duxdpDWQf3A/P/lpm0=;
        b=UPSmIKf7273Wy1Mw+xSr5yVGmTgrDBlcXcvk1aOZw9NVOZHB6gqQ9XSaQmV4fqy7tz
         IEweB/5fBnqoU5BS5zoWBtr8DAwQSX+3VhvEEAxhHCA0WNP7QTGzsBu4Od8R00BCsh+C
         gWawwK4Np+DG/AGrA1DNe/9aA1EJGZv3SxEWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684192330; x=1686784330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqtkImGxR85aToYA0Aq0yuOc2duxdpDWQf3A/P/lpm0=;
        b=cGnEfUZUB8mbxJynxxjnDK+Ao5HX5ifPkf5QiPQC+Q0+gj4qhejT9a3TqWSGvb7Q8N
         CsoRzpzGDegbrJCZofWkrgo66gUfP+FAyjMJwsrzjaVQJeLuiSeyyDnkPh4kP6lv6eym
         WI2WNmIef7rxk4FW1mG5QQbNKCnjMYV7zAzseN5pkXENihPVZwuKnF3VWMw71pPBCdqh
         ioKq4aIbj9xYiEGEUy8eRCgYUFptHeBIT8f4B+i31fuwyvs56jsPpIBlMNe3qYKEbhZd
         xWpSQhp7B6vOKknmiFT0g7Prlx51IFw/fUhZ60t66WJjvoMnUE7Y9odN070j4oDN3jlO
         BPvA==
X-Gm-Message-State: AC+VfDwNrkpkep3s3DDD+wiL8/fZdns4yPG+5GXzRjKFPcNDSUv5h4ZG
        1xU0X22erYXEu1SUdRaMAE/J3ovZo0qfCRxc73o=
X-Google-Smtp-Source: ACHHUZ5M+Iazz33djd0bLoB4gW2nOGBtz9ZAnvHYjm8f1tAp6ulGYsBIhRQZdbF5lfM2xJHGXbFA0A==
X-Received: by 2002:ac8:7dd1:0:b0:3ea:65d2:2fd1 with SMTP id c17-20020ac87dd1000000b003ea65d22fd1mr54331715qte.3.1684192330307;
        Mon, 15 May 2023 16:12:10 -0700 (PDT)
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com. [209.85.160.181])
        by smtp.gmail.com with ESMTPSA id z26-20020ac83e1a000000b003f3937c16c4sm5776457qtf.5.2023.05.15.16.12.08
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 16:12:08 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-3f38a9918d1so1589381cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 16:12:08 -0700 (PDT)
X-Received: by 2002:ac8:5c48:0:b0:3f3:8b28:f0b4 with SMTP id
 j8-20020ac85c48000000b003f38b28f0b4mr67302qtj.18.1684192327980; Mon, 15 May
 2023 16:12:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.9.I2ef26d1b3bfbed2d10a281942b0da7d9854de05e@changeid>
 <20230512140051.GA217273@aspen.lan>
In-Reply-To: <20230512140051.GA217273@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 May 2023 16:11:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UPy5kA7mJteY+YzHa2ExvBKHvxR9SnM=qxxKwXbTNHkw@mail.gmail.com>
Message-ID: <CAD=FV=UPy5kA7mJteY+YzHa2ExvBKHvxR9SnM=qxxKwXbTNHkw@mail.gmail.com>
Subject: Re: [PATCH v8 09/10] arm64: kgdb: Roundup cpus using IPI as NMI
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, ito-yuichi@fujitsu.com,
        kgdb-bugreport@lists.sourceforge.net, Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Fri, May 12, 2023 at 7:00=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Apr 19, 2023 at 03:56:03PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > arm64 platforms with GICv3 or later supports pseudo NMIs which can be
> > leveraged to roundup CPUs which are stuck in hard lockup state with
> > interrupts disabled that wouldn't be possible with a normal IPI.
> >
> > So instead switch to roundup CPUs using IPI turned as NMI. And in
> > case a particular arm64 platform doesn't supports pseudo NMIs,
> > it will switch back to default kgdb CPUs roundup mechanism.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Tested-by: Chen-Yu Tsai <wens@csie.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm64/kernel/ipi_nmi.c |  5 +++++
> >  arch/arm64/kernel/kgdb.c    | 18 ++++++++++++++++++
> >  2 files changed, 23 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/ipi_nmi.c b/arch/arm64/kernel/ipi_nmi.c
> > index c592e92b8cbf..2adaaf1519e5 100644
> > --- a/arch/arm64/kernel/ipi_nmi.c
> > +++ b/arch/arm64/kernel/ipi_nmi.c
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > +#include <linux/kgdb.h>
> >  #include <linux/nmi.h>
> >  #include <linux/smp.h>
> >
> > @@ -45,10 +46,14 @@ bool arch_trigger_cpumask_backtrace(const cpumask_t=
 *mask, bool exclude_self)
> >  static irqreturn_t ipi_nmi_handler(int irq, void *data)
> >  {
> >       irqreturn_t ret =3D IRQ_NONE;
> > +     unsigned int cpu =3D smp_processor_id();
>
> Does this play nice with CONFIG_DEBUG_PREEMPT? I may have missed
> something about the NMI entry but a quick scan of the arm64
> arch_irq_disabled() suggests that debug_smp_processor_id() will issue
> warnings at this point...
>
> Other than I didn't see anything I don't like here.

Good question. It seems to, at least on the sc7180-trogdor-based
system I tested.

Just to confirm, I printed out the values of some of the stuff that's
checked. When this function was called, I saw:

irqs_disabled() =3D> true
raw_local_save_flags() =3D> 0x000000f0
__irqflags_uses_pmr() =3D> 1

The "__irqflags_uses_pmr" is the thing that gets set when we try to
enable pseudo-NMIs and they're actually there. That causes us to call
__pmr_irqs_disabled_flags() which will compare the flags (0xf0) to
GIC_PRIO_IRQON (0xe0). If flags is not the same as GIC_PRIO_IRQON then
interrupts are disabled.

...so, assuming I understood everything, I think we're OK.

I also tried to see what happened with the whole "fallback to use
regular IPIs if we don't have pseudo-NMIs enabled" (AKA patch #10 in
this series). In that case, I had:

irqs_disabled() =3D> true
raw_local_save_flags() =3D> 0x000000c0
__irqflags_uses_pmr() =3D> 0

...in this case we end up in __daif_irqs_disabled_flags(). That checks
to see if the flags (0xc0) has the "I bit" (0x80) set. It is set, so
interrupts are disabled.

-Doug
