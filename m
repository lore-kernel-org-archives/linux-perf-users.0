Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51498C77B7E
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 May 2023 04:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjE2Ev0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 May 2023 00:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjE2EvH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 May 2023 00:51:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC1A549C3;
        Sun, 28 May 2023 21:44:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10F6CAB6;
        Sun, 28 May 2023 21:36:01 -0700 (PDT)
Received: from [10.162.40.17] (a077893.blr.arm.com [10.162.40.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168683F64C;
        Sun, 28 May 2023 21:35:10 -0700 (PDT)
Message-ID: <632289e3-6f3c-20b9-0454-77d6295c1c87@arm.com>
Date:   Mon, 29 May 2023 10:05:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V10 00/10] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230517022410.722287-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230517022410.722287-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 5/17/23 07:54, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on 6.4-rc2.
> 
> Changes in V10:
> 
> - Rebased the series on v6.4-rc2
> - Moved ARMV8 PMUV3 changes inside drivers/perf/arm_pmuv3.c
> - Moved BRBE driver changes inside drivers/perf/arm_brbe.[c|h]
> - Moved the WARN_ON() inside the if condition in armv8pmu_handle_irq()

Hello Will/Mark,

There was a crash reported on V9 (applicable here in V10 as well) because of
accessing event->pmu_ctx->task_ctx_data during a PMU IRQ for per-cpu events,
where it would not have been allocated in the first place. I have proposed a
fix for that on the other thread [1]. Besides, does the series looks good in
the current form ? Unless there are other comments, will respin with the fix
later in the week. Thank you.

[1] https://lore.kernel.org/linux-arm-kernel/d02df808-6d2b-c24b-bc8d-8f4859c0c71b@arm.com/

- Anshuman
