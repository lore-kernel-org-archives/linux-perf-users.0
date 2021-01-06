Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B15C433E6
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Jan 2021 10:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118E02311C
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Jan 2021 10:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbhAFKZG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:25:06 -0500
Received: from foss.arm.com ([217.140.110.172]:38538 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbhAFKZG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Jan 2021 05:25:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C6021FB;
        Wed,  6 Jan 2021 02:24:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.216])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4A273F719;
        Wed,  6 Jan 2021 02:24:17 -0800 (PST)
Date:   Wed, 6 Jan 2021 10:24:10 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     James Clark <james.clark@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, will@kernel.org,
        leo.yan@linaro.org, Al Grant <al.grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
Message-ID: <20210106102327.GA26994@C02TD0UTHF1T.local>
References: <20201214084502.19954-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214084502.19954-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Dec 14, 2020 at 10:45:02AM +0200, James Clark wrote:
> Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
> This flag is required to get PID data in the SPE trace. Without
> it the perf tool will report 0 for PID which isn't very useful,
> especially when doing system wide profiling or profiling
> applications that fork.
> 
> There is a small performance overhead when enabling
> PID_IN_CONTEXTIDR, but SPE itself is optional and not enabled by
> default so the impact is minimised.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Al Grant <al.grant@arm.com>
> Cc: Leo Yan <leo.yan@linaro.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  arch/arm64/Kconfig.debug | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
> index 265c4461031f..b030bb21a0bb 100644
> --- a/arch/arm64/Kconfig.debug
> +++ b/arch/arm64/Kconfig.debug
> @@ -2,6 +2,7 @@
>  
>  config PID_IN_CONTEXTIDR
>  	bool "Write the current PID to the CONTEXTIDR register"
> +	default y if ARM_SPE_PMU
>  	help
>  	  Enabling this option causes the kernel to write the current PID to
>  	  the CONTEXTIDR register, at the expense of some additional

Given that PID_IN_CONTEXTIDR doesn't take PID namespacing into account,
IIUC it's kinda broken today (and arguably removing that support would
be better).

Can we not track the (namespaced) PID in thte main ringbuffer regardless
of PID_IN_CONTEXTIDR, and leave PID_IN_CONTEXTIDR as an external debug
aid only?

Making this default y is ARM_SPE_PMU implies it'll be on in all distro
kernels, and I think we need to think harder before doing that.

Thanks,
Mark.
