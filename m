Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13122C83F12
	for <linux-perf-users@archiver.kernel.org>; Tue, 29 Aug 2023 10:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjH2Kiq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 29 Aug 2023 06:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbjH2KiV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Aug 2023 06:38:21 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377281A3
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 03:38:18 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-791b8525b59so1589394241.1
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Aug 2023 03:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693305497; x=1693910297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+S+OFM/SaIRDO4CZ1HS1+M3zY1M1wtDfmawa09i8kOs=;
        b=k18WsEYTY3SR8erQgVThbNFJcwf6j8oip5Wo2DTgEhMok+WoxDTppiV+l9fB+Qjtpj
         pKaRjzpqn2phfhYnEwLwTcGUwZk6w1lIytKg5ddmpvEH5d3EkDzXtiLyLb38TkhYcRHn
         CILIMjU98/jqzJ/2XadrR6NCYfEI+xleJpQWoaQEWcLE+6nDsWv6Lm4k5htDoK60R6xk
         9QB9V1rmeKNQEC3ofe+B+01SF7rER2vxsy59W5aTIDD/j77mkw/mV2tz/+eLzXmDBkqh
         cUtAAHMKSShlmJQ33CR6wnfFU3uWjdDUgCui+pzf5S5A+fZ/8Cd6AdHqGA+ShNF7rdBA
         bXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693305497; x=1693910297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+S+OFM/SaIRDO4CZ1HS1+M3zY1M1wtDfmawa09i8kOs=;
        b=ARVYh9mY4wGfnPi3Nli8WkA3qGl9UNctCS7XoltSQnHiZWL7PL1mVQup5Nr/LzUgO0
         VdIHI1OY3DHHQvyRpg2r1Ft0wpbWJK4jgKQu+hwOQUrlgCrjK5BXSgjixSzxadeqd1BM
         C5VTdb3XNwbbkVFDA3NEsA7SACA8RzvICpr8Pl2enpRn6HEVE9uu7tVZYkeYRuNbaC3u
         gLOPioq10IbseatbUlni4/KLzXbt7Er7SBpbGbRo9F1gFVDAziQWKBurPwFhYWY3DLKG
         8gIoTPItffGxpnWBgucZqb5VoicoUBXDpBU8mP59vfqk8n3DBz6zB/cz5+AAj7E3CwNr
         c1Yg==
X-Gm-Message-State: AOJu0YzYCgJ+Al2v5xcAxqKGaysdyjPEf4doGEFtfGlbv5t8RrACJ/Im
        LsD7wkRM/KbJOCQ5FK0lloqK9aBWxfHz/+lanSowVA==
X-Google-Smtp-Source: AGHT+IG4F5FrbB4LuavW+U011p9kyW0QyLMMxVW2gdfWcMm62cCwqrvaWq+v3KTsnGiFNLdYRP1OcPJsbCnuHRxqABU=
X-Received: by 2002:a67:eb0b:0:b0:44d:4904:e080 with SMTP id
 a11-20020a67eb0b000000b0044d4904e080mr21530579vso.31.1693305497289; Tue, 29
 Aug 2023 03:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230824153233.1006420-1-dianders@chromium.org> <20230824083012.v11.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
In-Reply-To: <20230824083012.v11.2.I4baba13e220bdd24d11400c67f137c35f07f82c7@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 29 Aug 2023 16:08:06 +0530
Message-ID: <CAFA6WYM2xTxBaNf8fjg3n0HotTaHezsB_e+eNgXK3PsSfWKx4A@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] arm64: idle: Tag the arm64 idle functions as __cpuidle
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
        Frederic Weisbecker <frederic@kernel.org>,
        Guo Ren <guoren@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, 24 Aug 2023 at 21:03, Douglas Anderson <dianders@chromium.org> wrote:
>
> As per the (somewhat recent) comment before the definition of
> `__cpuidle`, the tag is like `noinstr` but also marks a function so it
> can be identified by cpu_in_idle(). Let's add these markings to arm64
> cpuidle functions
>
> With this change we get useful backtraces like:
>
>   NMI backtrace for cpu N skipped: idling at cpu_do_idle+0x94/0x98
>
> instead of useless backtraces when dumping all processors using
> nmi_cpu_backtrace().
>
> NOTE: this patch won't make cpu_in_idle() work perfectly for arm64,
> but it doesn't hurt and does catch some cases. Specifically an example
> that wasn't caught in my testing looked like this:
>
>  gic_cpu_sys_reg_init+0x1f8/0x314
>  gic_cpu_pm_notifier+0x40/0x78
>  raw_notifier_call_chain+0x5c/0x134
>  cpu_pm_notify+0x38/0x64
>  cpu_pm_exit+0x20/0x2c
>  psci_enter_idle_state+0x48/0x70
>  cpuidle_enter_state+0xb8/0x260
>  cpuidle_enter+0x44/0x5c
>  do_idle+0x188/0x30c
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> Changes in v11:
> - Updated commit message as per Stephen.
>
> Changes in v9:
> - Added to commit message that this doesn't catch all cases.
>
> Changes in v8:
> - "Tag the arm64 idle functions as __cpuidle" new for v8
>
>  arch/arm64/kernel/idle.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/idle.c b/arch/arm64/kernel/idle.c
> index c1125753fe9b..05cfb347ec26 100644
> --- a/arch/arm64/kernel/idle.c
> +++ b/arch/arm64/kernel/idle.c
> @@ -20,7 +20,7 @@
>   *     ensure that interrupts are not masked at the PMR (because the core will
>   *     not wake up if we block the wake up signal in the interrupt controller).
>   */
> -void noinstr cpu_do_idle(void)
> +void __cpuidle cpu_do_idle(void)
>  {
>         struct arm_cpuidle_irq_context context;
>
> @@ -35,7 +35,7 @@ void noinstr cpu_do_idle(void)
>  /*
>   * This is our default idle handler.
>   */
> -void noinstr arch_cpu_idle(void)
> +void __cpuidle arch_cpu_idle(void)
>  {
>         /*
>          * This should do all the clock switching and wait for interrupt
> --
> 2.42.0.rc1.204.g551eb34607-goog
>
