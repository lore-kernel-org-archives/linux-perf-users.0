Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCC7EE49AB
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Aug 2023 23:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjHVXj5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Aug 2023 19:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjHVXj4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Aug 2023 19:39:56 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAFCCF
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 16:39:54 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ffae5bdc9aso5611328e87.1
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Aug 2023 16:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692747593; x=1693352393;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBnThSAKzhzR9rSGGQ+uW8RCv4yp0DSEOJ+0TVL56nk=;
        b=QsWKy1jTDTWB52uTxFOi3zfsOweTLAKE3PIHrsWhMpiDKzBr4toJGch4TKmtMUvYqG
         3GzQ1U9eZDhrRAtWdnMSLfjPzssVgU4ZTTvsHDjNjP5dg8GL+S8oOqqlNglvm4NnylKc
         6+zHhcCs50LUOHQJb0msu4XGtH1LwbJGc0ftU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692747593; x=1693352393;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBnThSAKzhzR9rSGGQ+uW8RCv4yp0DSEOJ+0TVL56nk=;
        b=W9rb2sHTvZ0C44xcpOJ7ZcPGgkGzz0+XrheSVzEnuf/VKT1h4ztxKerDXN6EC7bFNA
         OyKSj72LhS7pVDoG3ccy0w+nLg/hAPQCqgUm60AYNSwOTXyExaUehg/1D5hMqNHAqrX+
         wMzTaXvteUMtHjDIKOFpoIln+KiFzTm4Yn0FsbeWDq2FjPBunGDd4UgxN6jluAL64/IR
         ri/nYerD3PDB9BvwxyYrKJVI7dmGwyf7inhUZKOkHyp1a9pt6RM4B2iH/ojgqpwb2Lm0
         xXGecOGWmEyXWnCPenMiQBW8e2lmsRP5HtOmr6SkTOaiy/nF6/pzuNiSZrV3AEoB6y3c
         SJSw==
X-Gm-Message-State: AOJu0Yx9qFPqA9jxIfY4IlPvLAuMmZMKv+YUOCZq2KTMPzEfcER9x0oE
        UYDbEc6q3dbX4QfEOexJixVigclXTqLMs++oantOhA==
X-Google-Smtp-Source: AGHT+IGU9ghgpnimdTBYx+LsvN3eXoAUQ0e5d7XJpOiOkBBJbb3/8kf+cIH2Muh6sY0AYdzIn/S1uuiuvJTrDHYspL8=
X-Received: by 2002:a05:6512:3045:b0:4fb:89b3:3374 with SMTP id
 b5-20020a056512304500b004fb89b33374mr9771049lfb.54.1692747592254; Tue, 22 Aug
 2023 16:39:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Aug 2023 16:39:51 -0700
MIME-Version: 1.0
In-Reply-To: <20230822142644.v10.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
References: <20230822212927.249645-1-dianders@chromium.org> <20230822142644.v10.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Aug 2023 16:39:51 -0700
Message-ID: <CAE-0n52ZLr0qZ=9zN0kcXK2G5=sGKizGg5F9z4pLPjY_Xv6OJw@mail.gmail.com>
Subject: Re: [PATCH v10 4/6] arm64: smp: Add arch support for backtrace using pseudo-NMI
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        kgdb-bugreport@lists.sourceforge.net, ito-yuichi@fujitsu.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Quoting Douglas Anderson (2023-08-22 14:26:59)
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index bfe60adbc453..15b66dc1391b 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
>  #endif
>  }
>
> +void arm64_backtrace_ipi(cpumask_t *mask)
> +{
> +       __ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
> +}
> +
> +void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
> +{
> +       /*
> +        * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the name,
> +        * nothing about it truly needs to be backed by an NMI, it's just that
> +        * it's _allowed_ to work with NMIs. If ipi_should_be_nmi() returned
> +        * false our backtrace attempt will just be backed by a regular IPI.

I think "backed by" is an idiom and may be confusing. Simplify by
replacing "backed by" with "implemented using"?

> +        */
> +       nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
> +}
> +
>  /*
>   * Main handler for inter-processor interrupts
>   */
