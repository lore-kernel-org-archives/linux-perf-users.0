Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EB4C83F10
	for <linux-perf-users@archiver.kernel.org>; Thu, 31 Aug 2023 10:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjHaKP2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 31 Aug 2023 06:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344173AbjHaKPY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 31 Aug 2023 06:15:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC4F6CF3;
        Thu, 31 Aug 2023 03:15:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 187F7C15;
        Thu, 31 Aug 2023 03:16:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.3.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42A9D3F64C;
        Thu, 31 Aug 2023 03:15:18 -0700 (PDT)
Date:   Thu, 31 Aug 2023 11:15:15 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 7/7] arm64: smp: Mark IPI globals as __ro_after_init
Message-ID: <ZPBoMx8fsFRnC8gI@FVFF77S0Q05N>
References: <20230830191314.1618136-1-dianders@chromium.org>
 <20230830121115.v12.7.I625d393afd71e1766ef73d3bfaac0b347a4afd19@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830121115.v12.7.I625d393afd71e1766ef73d3bfaac0b347a4afd19@changeid>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Aug 30, 2023 at 12:11:28PM -0700, Douglas Anderson wrote:
> Mark the three IPI-related globals in smp.c as "__ro_after_init" since
> they are only ever set in set_smp_ipi_range(), which is marked
> "__init". This is a better and more secure marking than the old
> "__read_mostly".
> 
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> This patch is almost completely unrelated to the rest of the series
> other than the fact that it would cause a merge conflict with the
> series if sent separately. I tacked it on to this series in response
> to Stephen's feedback on v11 of this series [1]. If someone hates it
> (not sure why they would), it could be dropped. If someone loves it,
> it could be promoted to the start of the series and/or land on its own
> (resolving merge conflicts).
> 
> [1] https://lore.kernel.org/r/CAE-0n52iVDgZa8XT8KTMj12c_ESSJt7f7A0fuZ_oAMMqpGcSzA@mail.gmail.com

This looks reasonable to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> Changes in v12:
> - ("arm64: smp: Mark IPI globals as __ro_after_init") new for v12.
> 
>  arch/arm64/kernel/smp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 1a53e57c81d0..814d9aa93b21 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -84,9 +84,9 @@ enum ipi_msg_type {
>  	MAX_IPI
>  };
>  
> -static int ipi_irq_base __read_mostly;
> -static int nr_ipi __read_mostly = NR_IPI;
> -static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
> +static int ipi_irq_base __ro_after_init;
> +static int nr_ipi __ro_after_init = NR_IPI;
> +static struct irq_desc *ipi_desc[MAX_IPI] __ro_after_init;
>  
>  static void ipi_setup(int cpu);
>  
> -- 
> 2.42.0.283.g2d96d420d3-goog
> 
