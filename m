Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9A3C7618E
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Apr 2023 17:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjDXRxr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbjDXRxh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Apr 2023 13:53:37 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BA676B3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 10:53:35 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-32abc2e7da8so13241275ab.3
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682358814; x=1684950814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7A/OOVQszAo19NkFFicWYt7Qdu7ANiP0rHvHX9DAp1s=;
        b=YXyZXPuan65k2exNkU1OkBX8BGPMg4YcP+xuPT/rLcfyRSQOkTHFXuBhpjd10NVrHc
         OGN9rSZ0BBfNWxveqJ4+4vTYzoO7Y2Q4JOpzWmMs/C48UA6jbBZTtxPjMX5DD48+7X9h
         LLOEV5bFuJyccwRhAUdJCMnmG3licMp3k33kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682358814; x=1684950814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7A/OOVQszAo19NkFFicWYt7Qdu7ANiP0rHvHX9DAp1s=;
        b=IJOcG6jq1BqzeiNDn4P47B6EFODbF9IhI9QUBnOHDVoLouSTlA30smzajs/X2xATdh
         QEZfLK4hXR1VMRexcKLjFi2DyLYAUMt+tiI33dwq+zZhYMuoxz2Uqz20Y2qA/NbpeatN
         ugzPlYe4EJlc58zInbc2m5nNExqA2Z+1mSZ60fA0bxDSu2w+lLJ9Nm+818gkrlv63Z06
         AzYdjUCPGp2fQr/jWFxn7XT4BUA+QfoWBJ5Mc9IfUIQ8coOlK1Pr6Ze8DsRoP8ivAYav
         dcOUm6ZVMf52zfcreIBj58tJs8YM5IbJ2kcShrkTz7h4PTo0sPWWCli8VYhNUjPhVmD/
         iW+Q==
X-Gm-Message-State: AAQBX9enK+CV6SRKOOXjc97uSwwsuirw40kXrTp3dLq+o+e9jfGeIOHa
        cxDDWefBgiZdzUisi8b2IyrSE3TW1Y1BznA5z+8=
X-Google-Smtp-Source: AKy350ZQczDEYXlRjHGmwf1hTE4bqYyD4V30ceTxnELv9hueVJtIu4rh7nMe8o1uiaiXCxe/MQhIsA==
X-Received: by 2002:a92:d410:0:b0:328:715f:987a with SMTP id q16-20020a92d410000000b00328715f987amr6295936ilm.27.1682358814145;
        Mon, 24 Apr 2023 10:53:34 -0700 (PDT)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com. [209.85.166.182])
        by smtp.gmail.com with ESMTPSA id y68-20020a02954a000000b0040fa2395ad5sm3597021jah.178.2023.04.24.10.53.32
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 10:53:33 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-328cb023b1dso1090285ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Apr 2023 10:53:32 -0700 (PDT)
X-Received: by 2002:a05:6e02:1bcd:b0:315:8e3a:f546 with SMTP id
 x13-20020a056e021bcd00b003158e3af546mr23458ilv.6.1682358812275; Mon, 24 Apr
 2023 10:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230419225604.21204-1-dianders@chromium.org> <20230419155341.v8.3.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
In-Reply-To: <20230419155341.v8.3.I6d7f7d5fa0aa293c8c3374194947254b93114d37@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Apr 2023 10:53:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WWkott-nuPtV56PGGJdaYqSK5zf_DLGjG_AzGb9vHAoA@mail.gmail.com>
Message-ID: <CAD=FV=WWkott-nuPtV56PGGJdaYqSK5zf_DLGjG_AzGb9vHAoA@mail.gmail.com>
Subject: Re: [PATCH v8 03/10] arm64: smp: Assign and setup an IPI as NMI
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     ito-yuichi@fujitsu.com, kgdb-bugreport@lists.sourceforge.net,
        Chen-Yu Tsai <wens@csie.org>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <swboyd@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Ben Dooks <ben-linux@fluff.org>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, Apr 19, 2023 at 3:57=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> From: Sumit Garg <sumit.garg@linaro.org>
>
> Assign an unused IPI which can be turned as NMI using ipi_nmi framework.
> Also, invoke corresponding dynamic IPI setup/teardown APIs.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> Tested-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v8:
> - dynamic_ipi_setup() and dynamic_ipi_teardown() no longer take cpu param
>
>  arch/arm64/kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4e8327264255..94ff063527c6 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -43,6 +43,7 @@
>  #include <asm/daifflags.h>
>  #include <asm/kvm_mmu.h>
>  #include <asm/mmu_context.h>
> +#include <asm/nmi.h>
>  #include <asm/numa.h>
>  #include <asm/processor.h>
>  #include <asm/smp_plat.h>
> @@ -938,6 +939,8 @@ static void ipi_setup(int cpu)
>
>         for (i =3D 0; i < nr_ipi; i++)
>                 enable_percpu_irq(ipi_irq_base + i, 0);
> +
> +       dynamic_ipi_setup();
>  }
>
>  #ifdef CONFIG_HOTPLUG_CPU
> @@ -950,6 +953,8 @@ static void ipi_teardown(int cpu)
>
>         for (i =3D 0; i < nr_ipi; i++)
>                 disable_percpu_irq(ipi_irq_base + i);
> +
> +       dynamic_ipi_teardown();
>  }
>  #endif
>
> @@ -971,6 +976,9 @@ void __init set_smp_ipi_range(int ipi_base, int n)
>                 irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
>         }
>
> +       if (n > nr_ipi)
> +               set_smp_dynamic_ipi(ipi_base + nr_ipi);

From thinking about this patch more, I'm guessing that the biggest
objection someone could have is that this uses up the "last" IPI slot
in any systems that are stuck with only 8. Is that the reason that
this patch series stagnated in the past, or was it something else?

If this is truly the concern that people have, it doesn't look like it
would be terribly hard to combine the existing IPI_CPU_STOP and
IPI_CPU_CRASH_STOP. Presumably we could just get rid of the "crash
stop" IPI and have the normal "stop" IPI do the crash if
"waiting_for_crash_ipi" is non-zero. If that's the thing blocking the
series from moving forward then I can add that to the series, or we
could just wait until someone actually needs another IPI. ;-)

-Doug
