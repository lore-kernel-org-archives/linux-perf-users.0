Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35A3C001E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 25 Jul 2023 13:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjGYN3r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 25 Jul 2023 09:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGYN3q (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 25 Jul 2023 09:29:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D705F1BD8;
        Tue, 25 Jul 2023 06:29:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AED3E15BF;
        Tue, 25 Jul 2023 06:30:27 -0700 (PDT)
Received: from [10.57.89.166] (unknown [10.57.89.166])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BC33F5A1;
        Tue, 25 Jul 2023 06:29:41 -0700 (PDT)
Message-ID: <3873f3b6-5e0b-360f-2f01-4584e15e960a@arm.com>
Date:   Tue, 25 Jul 2023 14:29:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH V13 - RESEND 06/10] arm64/perf: Enable branch stack events
 via FEAT_BRBE
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shen <shenyang39@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230711082455.215983-1-anshuman.khandual@arm.com>
 <20230711082455.215983-7-anshuman.khandual@arm.com>
 <5c7c1ff3-1e2a-1258-7fa0-c82a9ab62646@huawei.com>
 <9d07e82a-06fb-a5f8-6f4f-f3c16784b9b7@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <9d07e82a-06fb-a5f8-6f4f-f3c16784b9b7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/07/2023 12:42, Anshuman Khandual wrote:
> Hello Yang,
> 
> On 7/25/23 12:42, Yang Shen wrote:
>>> +    if (!(branch_type & PERF_SAMPLE_BRANCH_NO_CYCLES))
>>> +        brbcr |= BRBCR_EL1_CC;
>>
>> Hi Anshuman,
>>
>> Here is problem about enable CYCLES_COUNT. The SPEC defines that the CYCLES_COUNT is only
>>
>> valid when the BRECR_EL1.CC & BRBCR_EL2.CC is true. And here the SPEC also defines that
>>
>> when PSTATE.EL == EL2 and HCR_EL2.E2h == '1', 'MSR BRBCR_EL1, <Xt>' means writing to
>>
>> BRBCR_EL2 actually. So 'armv8pmu_branch_enable' can only set the BRBCR_EL2.CC, while the
>>
>> BRECR_EL1.CC is still 0. The CYCLES_COUNT will be always 0 in records.
> 
> 
> Agreed, this is a valid problem i.e BRBCR_EL1.CC and BRBCR_EL2.CC both needs to be set
> for valid cycle count information regardless if the kernel runs in EL1 or EL2. A simple
> hack in the current code setting BRBCR_EL12.C, which in turn sets BRBCR_EL1.CC when the
> kernel runs in EL2 solves the problem.
> 
>>
>> As a solution, maybe BRBCR_EL12 should be added for driver according to the registers definition.
> 
> Right, will add the definition for BRBCR_EL12 in arch/arm64/tools/sysreg
> 
>>
>> Or, do you have a more standard solution?
> 
> Right, there are some nuances involved here.
> 
> Kernel could boot
> 	
> a. Directly into EL2 and stays in EL2 for good
> b. Directly into EL2 but switches into EL1
> c. Directly into EL1 without ever going into EL2
> 
> In all the above cases BRBCR_EL1.CC and BRBCR_EL2.CC needs to be set when cycle count
> is requested in the perf event interface (event->attr.branch_sample_type) via clearing
> PERF_SAMPLE_BRANCH_NO_CYCLES.
> 
> 
> - For the case as in (c) where kernel boots into EL1 directly and hence cannot ever set
>    EL2 register, BRBCR_EL2.CC would be a booting requirement - updated in booting.rst
> 
> - For the cases as in (a) and (b) kernel boots via EL2, hence there is an opportunity
>    to set both BRBCR_EL1.CC (via accessed BRBCR_EL12.CC) and BRBCR_EL2.CC. Depending on

You don't need to use BRBCR_EL12, if you do it early enough, before
HCR_EL2.E2H == 1 is applied.

Suzuki

