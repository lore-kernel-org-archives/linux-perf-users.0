Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC88BEB64D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Jun 2023 16:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234756AbjFMQ2G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Jun 2023 12:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFMQ2E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Jun 2023 12:28:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83F711989;
        Tue, 13 Jun 2023 09:27:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 304801FB;
        Tue, 13 Jun 2023 09:28:44 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.39.126])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 712093F5A1;
        Tue, 13 Jun 2023 09:27:57 -0700 (PDT)
Date:   Tue, 13 Jun 2023 17:27:47 +0100
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
Subject: Re: [PATCH V11 02/10] arm64/perf: Add BRBE registers and fields
Message-ID: <ZIiZA+4G6n/mUZeL@FVFF77S0Q05N.cambridge.arm.com>
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-3-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040428.501523-3-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 31, 2023 at 09:34:20AM +0530, Anshuman Khandual wrote:
> This adds BRBE related register definitions and various other related field
> macros there in. These will be used subsequently in a BRBE driver which is
> being added later on.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Tested-by: James Clark <james.clark@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/sysreg.h | 103 +++++++++++++++++++++
>  arch/arm64/tools/sysreg         | 159 ++++++++++++++++++++++++++++++++
>  2 files changed, 262 insertions(+)

> +SysregFields BRBINFx_EL1

> +Enum	1:0	VALID
> +	0b00	NONE
> +	0b01	TARGET
> +	0b10	SOURCE
> +	0b11	FULL
> +EndEnum

This looks correct...

[...]

> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0

> +Enum	1:0	VALID
> +	0b00	NONE
> +	0b01	TARGET
> +	0b10	SOURCE
> +	0b00	FULL
> +EndEnum

... but this clearly isn't.

Mark.
