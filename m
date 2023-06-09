Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCAEC7EE25
	for <linux-perf-users@archiver.kernel.org>; Fri,  9 Jun 2023 12:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbjFIMhl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 9 Jun 2023 08:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjFIMhl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 9 Jun 2023 08:37:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00F7A1A2;
        Fri,  9 Jun 2023 05:37:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04D55AB6;
        Fri,  9 Jun 2023 05:38:25 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEE0D3F6C4;
        Fri,  9 Jun 2023 05:37:37 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:37:32 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Message-ID: <ZIMdDMSjnNfx6q+n@FVFF77S0Q05N.cambridge.arm.com>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
 <ZH3mhorKNo77hsv5@FVFF77S0Q05N>
 <006be03c-43da-6482-6bc4-83fe65dcd706@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <006be03c-43da-6482-6bc4-83fe65dcd706@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jun 09, 2023 at 10:00:09AM +0530, Anshuman Khandual wrote:
> >> +static u64 branch_type_to_brbcr(int branch_type)
> >> +{
> >> +	u64 brbcr = BRBCR_EL1_DEFAULT_TS;
> >> +
> >> +	/*
> >> +	 * BRBE need not be paused on PMU interrupt while tracing only
> >> +	 * the user space, bcause it will automatically be inside the
> >> +	 * prohibited region. But even after PMU overflow occurs, the
> >> +	 * interrupt could still take much more cycles, before it can
> >> +	 * be taken and by that time BRBE will have been overwritten.
> >> +	 * Let's enable pause on PMU interrupt mechanism even for user
> >> +	 * only traces.
> >> +	 */
> >> +	brbcr |= BRBCR_EL1_FZP;
> > I think this is trying to say that we *should* use FZP when sampling the
> > kernel (due to IRQ latency), and *can* safely use it when sampling userspace,
> > so it would be good to explain it that way around.
> 
> Agreed, following updated comment explains why we should enable FZP
> when sampling kernel, otherwise BRBE will capture unwanted records.
> It also explains why we should enable FZP even when sampling user
> space due to IRQ latency.
> 
>         /*
>          * BRBE should be paused on PMU interrupt while tracing kernel
>          * space to stop capturing further branch records. Otherwise
>          * interrupt handler branch records might get into the samples
>          * which is not desired.
>          *
>          * BRBE need not be paused on PMU interrupt while tracing only
>          * the user space, because it will automatically be inside the
>          * prohibited region. But even after PMU overflow occurs, the
>          * interrupt could still take much more cycles, before it can
>          * be taken and by that time BRBE will have been overwritten.
>          * Hence enable pause on PMU interrupt mechanism even for user
>          * only traces as well.
>          */
>         brbcr |= BRBCR_EL1_FZP;

Thanks; I think that's a lot clearer!

Mark.
