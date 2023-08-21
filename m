Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5FEE49A5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Aug 2023 22:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjHUWRS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Aug 2023 18:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjHUWRS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Aug 2023 18:17:18 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003CA133
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 15:17:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso59767881fa.3
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692656231; x=1693261031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pnuXYzRxiJAi4ZTWILf7If+RLyD4xsvL3DTtJAtXks=;
        b=JcG5PFeXFkRKju0hQTgIfUA63T/9+V/ehDSDg/LLRqZWmYmcFS8QQ52saDoQPrcxSW
         +MNG61Q7w2IGvFC/GrOBfdeWiLTGRXpx3Kh1C57FAKcpD3k1AotSUhy8tkJgNgpgyhV8
         JZ7fOeisojvmOUOJQJcvVe07AWUuTXzej30Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692656231; x=1693261031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+pnuXYzRxiJAi4ZTWILf7If+RLyD4xsvL3DTtJAtXks=;
        b=MvKDnmqpQ3XSZXOsUrqYvzjr4sYdLrl0T+/5AVCROk9ya5pxLlyKUrGc2felbt3FaM
         WXkEA/7biIdkkWKaGeh17i2gzhS5k/tAYtiw4YloOo+RjJT5PgXeKhTgdgA9wntIpvbT
         a3ir3OujmkULAt2NqeHaanMbmZL9y94fA34ZJhizZqr9h0qAaA13HN3E79ihrxCYs3Nq
         lfxE3eHJGE7/RmpN5b6yV1F1ZHtVHcCDoBQR7Y5adkndqB/Z9PUQV0bi0+rjdIgK3ma3
         tqcWErZdU7SLGmtKuqh/+TIkpZWFZ3RNvlP2MSxgqTN4ovDgTbbBlt76DSXEaNlhB+uS
         7W5Q==
X-Gm-Message-State: AOJu0YyLTpMtr1L7BGoC6V4lpVplQSk0cys1t8EVh4Mykm2f/SwXUB+Q
        xA42WiXEpC1E94zGix9eLiO/fBvo/7vDQKujBOBQvl0z
X-Google-Smtp-Source: AGHT+IEsQExLgrkc9B4SRZZ5TY4ElqUUowr8604uuJ8u3KvLW1tT37h2s9bdEpjIiWcIOFPvAiNbqg==
X-Received: by 2002:a2e:7a16:0:b0:2b9:43a7:376e with SMTP id v22-20020a2e7a16000000b002b943a7376emr5586502ljc.29.1692656230860;
        Mon, 21 Aug 2023 15:17:10 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id k12-20020a1709061c0c00b009a1a653770bsm1164030ejg.87.2023.08.21.15.17.09
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 15:17:10 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fee2ba9d09so12855e9.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Aug 2023 15:17:09 -0700 (PDT)
X-Received: by 2002:a05:600c:82c8:b0:3f7:e4d8:2569 with SMTP id
 eo8-20020a05600c82c800b003f7e4d82569mr16271wmb.5.1692656229438; Mon, 21 Aug
 2023 15:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230601213440.2488667-1-dianders@chromium.org>
 <20230601143109.v9.3.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid> <ZNDDgRuNGzovddaO@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <ZNDDgRuNGzovddaO@FVFF77S0Q05N.cambridge.arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 21 Aug 2023 15:16:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVJsJSc=uQWad4x0EV2-iROFcueW_=4VbM+0N0+aD96g@mail.gmail.com>
Message-ID: <CAD=FV=VVJsJSc=uQWad4x0EV2-iROFcueW_=4VbM+0N0+aD96g@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] arm64: Add framework for a debug IPI
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Mon, Aug 7, 2023 at 3:12=E2=80=AFAM Mark Rutland <mark.rutland@arm.com> =
wrote:
>
> On Thu, Jun 01, 2023 at 02:31:47PM -0700, Douglas Anderson wrote:
> > From: Sumit Garg <sumit.garg@linaro.org>
> >
> > Introduce a framework for an IPI that will be used for debug
> > purposes. The primary use case of this IPI will be to generate stack
> > crawls on other CPUs, but it will also be used to round up CPUs for
> > kgdb.
> >
> > When possible, we try to allocate this debug IPI as an NMI (or a
> > pseudo NMI). If that fails (due to CONFIG, an incompatible interrupt
> > controller, a quirk, missing the "irqchip.gicv3_pseudo_nmi=3D1" kernel
> > parameter, etc) we fall back to a normal IPI.
> >
> > NOTE: hooking this up for CPU backtrace / kgdb will happen in a future
> > patch, this just adds the framework.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I think that we shouldn't add a framework in a separate file for this:
>
> * This is very similar to our existing IPI management in smp.c, so it fee=
ls
>   like duplication, or at least another thing we'd like to keep in-sync.
>
> * We're going to want an NMI backtrace regardless of KGDB
>
> * We're going to want the IPI_CPU_STOP and IPI_CRASH_CPU_STOP IPIs to be =
NMIs
>   too.
>
> I reckon it'd be better to extend the existing IPI logic in smp.c to allo=
w IPIs
> to be requested as NMIs, e.g.
>
> ----
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index edd63894d61e8..48e6aa62c473e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -33,6 +33,7 @@
>  #include <linux/kernel_stat.h>
>  #include <linux/kexec.h>
>  #include <linux/kvm_host.h>
> +#include <linux/nmi.h>
>
>  #include <asm/alternative.h>
>  #include <asm/atomic.h>
> @@ -926,6 +927,21 @@ static void smp_cross_call(const struct cpumask *tar=
get, unsigned int ipinr)
>         __ipi_send_mask(ipi_desc[ipinr], target);
>  }
>
> +static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
> +{
> +       if (!system_uses_irq_prio_masking())
> +               return false;
> +
> +       switch (ipi) {
> +       /*
> +        * TODO: select NMI IPIs here
> +        */
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
>  static void ipi_setup(int cpu)
>  {
>         int i;
> @@ -933,8 +949,14 @@ static void ipi_setup(int cpu)
>         if (WARN_ON_ONCE(!ipi_irq_base))
>                 return;
>
> -       for (i =3D 0; i < nr_ipi; i++)
> -               enable_percpu_irq(ipi_irq_base + i, 0);
> +       for (i =3D 0; i < nr_ipi; i++) {
> +               if (ipi_should_be_nmi(i)) {
> +                       prepare_percpu_nmi(ipi_irq_base + i);
> +                       enable_percpu_nmi(ipi_irq_base + i, 0);
> +               } else {
> +                       enable_percpu_irq(ipi_irq_base + i, 0);
> +               }
> +       }
>  }
>
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -945,8 +967,14 @@ static void ipi_teardown(int cpu)
>         if (WARN_ON_ONCE(!ipi_irq_base))
>                 return;
>
> -       for (i =3D 0; i < nr_ipi; i++)
> -               disable_percpu_irq(ipi_irq_base + i);
> +       for (i =3D 0; i < nr_ipi; i++) {
> +               if (ipi_should_be_nmi(i)) {
> +                       disable_percpu_nmi(ipi_irq_base + i);
> +                       teardown_percpu_nmi(ipi_irq_base + i);
> +               } else {
> +                       disable_percpu_irq(ipi_irq_base + i);
> +               }
> +       }
>  }
>  #endif
>
> @@ -958,11 +986,19 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>         nr_ipi =3D min(n, NR_IPI);
>
>         for (i =3D 0; i < nr_ipi; i++) {
> -               int err;
> -
> -               err =3D request_percpu_irq(ipi_base + i, ipi_handler,
> -                                        "IPI", &cpu_number);
> -               WARN_ON(err);
> +               int err =3D -EINVAL;
> +
> +               if (ipi_should_be_nmi(i)) {
> +                       err =3D request_percpu_nmi(ipi_base + i, ipi_hand=
ler,
> +                                                "IPI", &cpu_number);
> +                       WARN(err, "Could not request IPI %d as NMI, err=
=3D%d\n",
> +                            i, err);
> +               } else {
> +                       err =3D request_percpu_irq(ipi_base + i, ipi_hand=
ler,
> +                                                "IPI", &cpu_number);
> +                       WARN(err, "Could not request IPI %d as IRQ, err=
=3D%d\n",
> +                            i, err);
> +               }
>
>                 ipi_desc[i] =3D irq_to_desc(ipi_base + i);
>                 irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
> ----
>
> ... and then if we need an IPI for KGDB, we can add that to the existing =
list
> of IPIs, and have it requested/enabled/disabled as usual.

Sounds good. I'm starting to work on v10 incorporating your feedback.
A few quick questions:

1. If I mostly take your patch above verbatim, do you have any
suggested tags for Author/Signed-off-by? I'd tend to set you as the
author but I can't do that because you didn't provide a
Signed-off-by...

2. Would you prefer this patch on its own, or would you rather it be
squashed with the first user ("backtrace")? On its own, I think I have
to get rid of the "switch" statement in ipi_should_be_nmi() and just
return false;

Thanks!

-Doug
