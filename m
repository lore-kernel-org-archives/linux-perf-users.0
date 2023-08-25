Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70430C83F01
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 22:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHYW2B (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 25 Aug 2023 18:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjHYW1c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 25 Aug 2023 18:27:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65672123
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 15:27:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so2175281e87.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Aug 2023 15:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693002448; x=1693607248;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozIL3ztcMY/CjRnACD5tsgtlWnLwTY4DlCvApQ3YGH8=;
        b=Ov9w9fm79WxSQCPhsJOvhtQl9wezVlm7usWwtpySiNQyWRnOHMCtrRKP9iDDQR5wiz
         uEpyEOsQCfAUrxRj+Fg1pOoOZoau8Ac9zH+X6lspQB/f3kBk6JhesTbnZ0eI8Wyqz+pM
         i9X06ciV6i1kAwgpoqX6YVyLxG8jQ2oS3Eua4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693002448; x=1693607248;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozIL3ztcMY/CjRnACD5tsgtlWnLwTY4DlCvApQ3YGH8=;
        b=bhStegf8RkKeDGVhUYKJmYRKyHYM3NxNRtkexoINBRGFQy72CBZF8zoU8CxvNdn9O/
         833bTm+rTsLYBONdaxuOFwaFkw0jOqYoACYxRUK07FJ9WiBF9jNb3f3dzADYJ0E0sGjt
         aWgZx7FS7Kc20MjTYQX+n8mcer+d410JGZrFV1MfyJnGVmOGjnlOgs1FtMFey/7O3yJJ
         hZQIAvgCe+m2iN9XuP3DCuoqJjFcv0JJJrsI5KIhhLD6kOF16husfJuK/Rr8aja0buAM
         N2/zGJQudxxSvDfXz7L3ZEh4+ZzrR6MmXx1deO5wDD5TmsT0Bq2fjlBMNowkORlQXJf5
         uH+w==
X-Gm-Message-State: AOJu0Yxahl8Ce1vuDP1ciV1dSeldqn7YuyNG1ZYQ00/AfNqLJHD4Bkwz
        dGPpOlI+XIeCvJDHGYsE3P/cviq20hIYPv6hW8kN/Q==
X-Google-Smtp-Source: AGHT+IFQRv+LRhmJpKCQ1JJuh/OxEc+CDv/RRDR6yVXx8WifztG0VJqHHXmhp+GvZCUxdtO/gLoTkhk63iMCDLx4NVQ=
X-Received: by 2002:a05:6512:b94:b0:4ff:8c0f:a745 with SMTP id
 b20-20020a0565120b9400b004ff8c0fa745mr17432931lfv.54.1693002448042; Fri, 25
 Aug 2023 15:27:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 25 Aug 2023 17:27:27 -0500
MIME-Version: 1.0
In-Reply-To: <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 25 Aug 2023 17:27:27 -0500
Message-ID: <CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com>
Subject: Re: [PATCH v11 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
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
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Quoting Douglas Anderson (2023-08-24 08:30:30)
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index fac08e18bcd5..50ce8b697ff3 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -6,6 +6,9 @@
>
>  #include <asm-generic/irq.h>
>
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);

Some nits, but otherwise

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

> +#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
> +
>  struct pt_regs;
>
>  int set_handle_irq(void (*handle_irq)(struct pt_regs *));
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index a5848f1ef817..c8896cbc5327 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -72,12 +73,18 @@ enum ipi_msg_type {
>         IPI_CPU_CRASH_STOP,
>         IPI_TIMER,
>         IPI_IRQ_WORK,
> -       NR_IPI
> +       NR_IPI,
> +       /*
> +        * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
> +        * with trace_ipi_*
> +        */
> +       IPI_CPU_BACKTRACE = NR_IPI,
> +       MAX_IPI
>  };
>
>  static int ipi_irq_base __read_mostly;
>  static int nr_ipi __read_mostly = NR_IPI;
> -static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
> +static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;

Side note: it would be nice to mark ipi_desc as __ro_after_init. Same
for nr_ipi and ipi_irq_base.

>
>  static void ipi_setup(int cpu);
>
> @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
>  #endif
>  }
>
> +static void arm64_backtrace_ipi(cpumask_t *mask)
> +{
> +       __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> +}
> +
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)

Can this be 'bool exclude_self' instead of int? That matches all other
implementations from what I can tell.

> +{
> +       /*
> +        * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the name,

USe nmi_trigger_cpumask_backtrace() to indicate function.

> +        * nothing about it truly needs to be implemented using an NMI, it's
> +        * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
> +        * returned false our backtrace attempt will just use a regular IPI.
> +        */
> +       nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
