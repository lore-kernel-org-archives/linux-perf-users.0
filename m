Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B131AC83F12
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 10:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjH2Kl0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 06:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbjH2KlS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 06:41:18 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112581AB
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 03:41:13 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-44d60bb6aa5so1915518137.2
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 03:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693305672; x=1693910472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uq0twIbHfJhR39j1Okq5KqdBEmQgm7OtHD/B0a98m4o=;
        b=qIZwPKqtSRd5ATCAllPT8EV4T4gxGI6S6UYQ15dRIcyZxOwPfrBcbhOiCrToz+5fRy
         5k+LaqVKgen1ercePfiFJojKXuIMczxLfb43CdRWFcT4FgWsTJ0VU1CzsUci+p42hPp2
         kw6OG3uSSo4r2IFJj1Btn5o7ix96k+9ALUl2uJB/msb/N+5PkVfmTnc0m3gLUjQ1soXC
         m4TCDZfwPwb0mD5rCLe/7GICal3lbXWKZlaD6ehV+3avFymj4rybIf5b2f/y21Ez0o/5
         ++Kt7pFc9XaN0wYDAiwbYcr9xd/7yM8ymJgNYHSeNO5Ix/DDsr+Z0PUM6OpJAc9e57q+
         y3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305672; x=1693910472;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uq0twIbHfJhR39j1Okq5KqdBEmQgm7OtHD/B0a98m4o=;
        b=KfD11ggx/PwBI4WS+9QlCIov5UaQElpMMWkdslZW6Yn5nYXou2oM0Yy/nb/Aqd1GMa
         NKo5rHdtGIkdX+sSp8nyc+MRLJwgA+/Z6rn7oXYToTrnSW+tElhAhlWKnFBos6I8Zp+v
         rNFJDyjnF6wXAh44eE7Oc+kGSccWSI4/KVGWDEc30oSuqE0qsU8GJQsJWnRnf4ub2YWV
         g1TgXRjYPAtJ4RHievcFu1hLMdxySCNB7atlA0Pw+7P+xICovESmA2VuSBj3LnZAd/yW
         7F5iKe5OJ+PnY3x+A90ywB0BlH/o4xwaCTd2hbdOKYHJk/FCraoUma7Q3Lo53Mtgncs7
         SjTg==
X-Gm-Message-State: AOJu0YwLgwhFyed7ZYaNbNAxUCHkBa3WQJQZpbg3cO2o5grhLZUU83hd
        /ZtpKOvj25sKU1J4dzMZuKZXPPdHpsd2klNbu6HzeuYUPlqa79tpMrs=
X-Google-Smtp-Source: AGHT+IGH7wzy7FoFt53j1Wl8pOHg+HIIejrpPXYkORsQvwPy2CQYvDOVJGh+hxhV8WoG1gHRHPz9TAGqKsv7dZYykpA=
X-Received: by 2002:a05:6102:7cc:b0:44d:4e64:f175 with SMTP id
 y12-20020a05610207cc00b0044d4e64f175mr23582480vsg.5.1693305672186; Tue, 29
 Aug 2023 03:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
In-Reply-To: <20230824083012.v11.3.I7209db47ef8ec151d3de61f59005bbc59fe8f113@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 29 Aug 2023 16:11:01 +0530
Message-ID: <CAFA6WYMJHr=r=3CvCq=nb1R_vt2jveJoyUXT4KsEtZea7wMF-w@mail.gmail.com>
Subject: Re: [PATCH v11 3/6] arm64: smp: Remove dedicated wakeup IPI
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kgdb-bugreport@lists.sourceforge.net,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-perf-users@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, ito-yuichi@fujitsu.com,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 24 Aug 2023 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
>
> From: Mark Rutland <mark.rutland@arm.com>
>
> To enable NMI backtrace and KGDB's NMI cpu roundup, we need to free up
> at least one dedicated IPI.
>
> On arm64 the IPI_WAKEUP IPI is only used for the ACPI parking protocol,
> which itself is only used on some very early ARMv8 systems which
> couldn't implement PSCI.
>
> Remove the IPI_WAKEUP IPI, and rely on the IPI_RESCHEDULE IPI to wake
> CPUs from the parked state. This will cause a tiny amonut of redundant
> work to check the thread flags, but this is miniscule in relation to the
> cost of taking and handling the IPI in the first place. We can safely
> handle redundant IPI_RESCHEDULE IPIs, so there should be no functional
> impact as a result of this change.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Will Deacon <will@kernel.org>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> ---
> I have no idea how to test this. I just took Mark's patch and jammed
> it into my series. Logicially the patch seems reasonable to me.
>
> Changes in v11:
> - arch_send_wakeup_ipi() now takes an unsigned int.
>
> Changes in v10:
> - ("arm64: smp: Remove dedicated wakeup IPI") new for v10.
>
>  arch/arm64/include/asm/smp.h              |  4 ++--
>  arch/arm64/kernel/acpi_parking_protocol.c |  2 +-
>  arch/arm64/kernel/smp.c                   | 28 +++++++++--------------
>  3 files changed, 14 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
> index 9b31e6d0da17..efb13112b408 100644
> --- a/arch/arm64/include/asm/smp.h
> +++ b/arch/arm64/include/asm/smp.h
> @@ -89,9 +89,9 @@ extern void arch_send_call_function_single_ipi(int cpu);
>  extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
>
>  #ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> -extern void arch_send_wakeup_ipi_mask(const struct cpumask *mask);
> +extern void arch_send_wakeup_ipi(unsigned int cpu);
>  #else
> -static inline void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> +static inline void arch_send_wakeup_ipi(unsigned int cpu)
>  {
>         BUILD_BUG();
>  }
> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> index b1990e38aed0..e1be29e608b7 100644
> --- a/arch/arm64/kernel/acpi_parking_protocol.c
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -103,7 +103,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
>                        &mailbox->entry_point);
>         writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
>
> -       arch_send_wakeup_ipi_mask(cpumask_of(cpu));
> +       arch_send_wakeup_ipi(cpu);
>
>         return 0;
>  }
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 960b98b43506..a5848f1ef817 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -72,7 +72,6 @@ enum ipi_msg_type {
>         IPI_CPU_CRASH_STOP,
>         IPI_TIMER,
>         IPI_IRQ_WORK,
> -       IPI_WAKEUP,
>         NR_IPI
>  };
>
> @@ -764,7 +763,6 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
>         [IPI_CPU_CRASH_STOP]    = "CPU stop (for crash dump) interrupts",
>         [IPI_TIMER]             = "Timer broadcast interrupts",
>         [IPI_IRQ_WORK]          = "IRQ work interrupts",
> -       [IPI_WAKEUP]            = "CPU wake-up interrupts",
>  };
>
>  static void smp_cross_call(const struct cpumask *target, unsigned int ipinr);
> @@ -797,13 +795,6 @@ void arch_send_call_function_single_ipi(int cpu)
>         smp_cross_call(cpumask_of(cpu), IPI_CALL_FUNC);
>  }
>
> -#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> -void arch_send_wakeup_ipi_mask(const struct cpumask *mask)
> -{
> -       smp_cross_call(mask, IPI_WAKEUP);
> -}
> -#endif
> -
>  #ifdef CONFIG_IRQ_WORK
>  void arch_irq_work_raise(void)
>  {
> @@ -897,14 +888,6 @@ static void do_handle_IPI(int ipinr)
>                 break;
>  #endif
>
> -#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> -       case IPI_WAKEUP:
> -               WARN_ONCE(!acpi_parking_protocol_valid(cpu),
> -                         "CPU%u: Wake-up IPI outside the ACPI parking protocol\n",
> -                         cpu);
> -               break;
> -#endif
> -
>         default:
>                 pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
>                 break;
> @@ -979,6 +962,17 @@ void arch_smp_send_reschedule(int cpu)
>         smp_cross_call(cpumask_of(cpu), IPI_RESCHEDULE);
>  }
>
> +#ifdef CONFIG_ARM64_ACPI_PARKING_PROTOCOL
> +void arch_send_wakeup_ipi(unsigned int cpu)
> +{
> +       /*
> +        * We use a scheduler IPI to wake the CPU as this avoids the need for a
> +        * dedicated IPI and we can safely handle spurious scheduler IPIs.
> +        */
> +       arch_smp_send_reschedule(cpu);
> +}
> +#endif
> +
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  void tick_broadcast(const struct cpumask *mask)
>  {
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
