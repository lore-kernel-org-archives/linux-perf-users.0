Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634F1C6FA82
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Sep 2022 10:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiIMKjo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Sep 2022 06:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiIMKjn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Sep 2022 06:39:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4954B49B;
        Tue, 13 Sep 2022 03:39:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC82A1063;
        Tue, 13 Sep 2022 03:39:47 -0700 (PDT)
Received: from [10.57.77.29] (unknown [10.57.77.29])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81D613F71A;
        Tue, 13 Sep 2022 03:39:39 -0700 (PDT)
Message-ID: <740298c9-0cae-251d-97b4-d2724399ba40@arm.com>
Date:   Tue, 13 Sep 2022 11:39:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 6/7] arm64/perf: Add BRBE driver
Content-Language: en-US
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com, German Gomez <german.gomez@arm.com>
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <20220908051046.465307-7-anshuman.khandual@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20220908051046.465307-7-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 08/09/2022 06:10, Anshuman Khandual wrote:
> This adds a BRBE driver which implements all the required helper functions
> for struct arm_pmu. Following functions are defined by this driver which
> will configure, enable, capture, reset and disable BRBE buffer HW as and
> when requested via perf branch stack sampling framework.
> 
> - arm64_pmu_brbe_filter()
> - arm64_pmu_brbe_enable()
> - arm64_pmu_brbe_disable()
> - arm64_pmu_brbe_read()
> - arm64_pmu_brbe_probe()
> - arm64_pmu_brbe_reset()
> - arm64_pmu_brbe_supported()
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c |   8 +-
>  drivers/perf/Kconfig           |  11 +
>  drivers/perf/Makefile          |   1 +
>  drivers/perf/arm_pmu_brbe.c    | 448 +++++++++++++++++++++++++++++++++
>  drivers/perf/arm_pmu_brbe.h    | 259 +++++++++++++++++++
>  include/linux/perf/arm_pmu.h   |  20 ++
>  6 files changed, 746 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/perf/arm_pmu_brbe.c
>  create mode 100644 drivers/perf/arm_pmu_brbe.h
> 
[...]
> +
> +static int brbe_fetch_perf_priv(u64 brbinf)
> +{
> +       int brbe_el = brbe_fetch_el(brbinf);
> +
> +       switch (brbe_el) {
> +       case BRBINF_EL_EL0:
> +               return PERF_BR_PRIV_USER;
> +       case BRBINF_EL_EL1:
> +               return PERF_BR_PRIV_KERNEL;
> +       case BRBINF_EL_EL2:
> +               if (is_kernel_in_hyp_mode())
> +                       return PERF_BR_PRIV_KERNEL;
> +               return PERF_BR_PRIV_HV;
> +       default:
> +               pr_warn("unknown branch privilege captured\n");
> +               return -1;

On V1 you said that you would change this to PERF_BR_PRIV_UNKNOWN, looks
like that was dropped. Unless it didn't work out?
