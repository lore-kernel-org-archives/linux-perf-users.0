Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFFC38A2D
	for <linux-perf-users@archiver.kernel.org>; Thu, 27 Oct 2022 02:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiJ0Cvv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 22:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiJ0Cvu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 22:51:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BE7F7125004;
        Wed, 26 Oct 2022 19:51:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3FCAE23A;
        Wed, 26 Oct 2022 19:51:55 -0700 (PDT)
Received: from [10.163.38.26] (unknown [10.163.38.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 791D43F792;
        Wed, 26 Oct 2022 19:51:44 -0700 (PDT)
Message-ID: <7f66a0df-1fc5-b00f-d734-601b70baa018@arm.com>
Date:   Thu, 27 Oct 2022 08:21:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 0/7] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20221017055713.451092-1-anshuman.khandual@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20221017055713.451092-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 10/17/22 11:27, Anshuman Khandual wrote:
> This series enables perf branch stack sampling support on arm64 platform
> via a new arch feature called Branch Record Buffer Extension (BRBE). All
> relevant register definitions could be accessed here.
> 
> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
> 
> This series applies on v6.1-rc1.
> 
> Changes in V4:
> 
> - Changed ../tools/sysreg declarations as suggested
> - Set PERF_SAMPLE_BRANCH_STACK in data.sample_flags
> - Dropped perfmon_capable() check in armpmu_event_init()
> - s/pr_warn_once/pr_info in armpmu_event_init()
> - Added brbe_format element into struct pmu_hw_events
> - Changed v1p1 as brbe_v1p1 in struct pmu_hw_events
> - Dropped pr_info() from arm64_pmu_brbe_probe(), solved LOCKDEP warning

Folks,

Gentle ping, any updates on this series ?
