Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F1AC7EE2C
	for <linux-perf-users@archiver.kernel.org>; Mon,  5 Jun 2023 03:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjFEDBI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jun 2023 23:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjFEDBH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jun 2023 23:01:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC45DBD;
        Sun,  4 Jun 2023 20:01:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAC13D75;
        Sun,  4 Jun 2023 20:01:48 -0700 (PDT)
Received: from [10.162.41.6] (a077893.blr.arm.com [10.162.41.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 969373F663;
        Sun,  4 Jun 2023 20:00:58 -0700 (PDT)
Message-ID: <a04b4e03-39cf-ab47-e2fc-48feebbd1635@arm.com>
Date:   Mon, 5 Jun 2023 08:30:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V11 06/10] arm64/perf: Enable branch stack events via
 FEAT_BRBE
Content-Language: en-US
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230531040428.501523-1-anshuman.khandual@arm.com>
 <20230531040428.501523-7-anshuman.khandual@arm.com>
 <CAM9d7cgvXwsoZqC8tG=X-rkCWEAeQVdyBFTMjMZg8EiX5Y=5Ew@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAM9d7cgvXwsoZqC8tG=X-rkCWEAeQVdyBFTMjMZg8EiX5Y=5Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 6/2/23 07:15, Namhyung Kim wrote:
> Hello,
> 
> On Tue, May 30, 2023 at 9:21 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> This enables branch stack sampling events in ARMV8 PMU, via an architecture
>> feature FEAT_BRBE aka branch record buffer extension. This defines required
>> branch helper functions pmuv8pmu_branch_XXXXX() and the implementation here
>> is wrapped with a new config option CONFIG_ARM64_BRBE.
>>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Tested-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
> 
> [SNIP]
>> +void armv8pmu_branch_read(struct pmu_hw_events *cpuc, struct perf_event *event)
>> +{
>> +       struct brbe_hw_attr *brbe_attr = (struct brbe_hw_attr *)cpuc->percpu_pmu->private;
>> +       u64 brbfcr, brbcr;
>> +       int idx, loop1_idx1, loop1_idx2, loop2_idx1, loop2_idx2, count;
>> +
>> +       brbcr = read_sysreg_s(SYS_BRBCR_EL1);
>> +       brbfcr = read_sysreg_s(SYS_BRBFCR_EL1);
>> +
>> +       /* Ensure pause on PMU interrupt is enabled */
>> +       WARN_ON_ONCE(!(brbcr & BRBCR_EL1_FZP));
>> +
>> +       /* Pause the buffer */
>> +       write_sysreg_s(brbfcr | BRBFCR_EL1_PAUSED, SYS_BRBFCR_EL1);
>> +       isb();
>> +
>> +       /* Determine the indices for each loop */
>> +       loop1_idx1 = BRBE_BANK0_IDX_MIN;
>> +       if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
>> +               loop1_idx2 = brbe_attr->brbe_nr - 1;
>> +               loop2_idx1 = BRBE_BANK1_IDX_MIN;
>> +               loop2_idx2 = BRBE_BANK0_IDX_MAX;
> 
> Is this to disable the bank1?  Maybe need a comment.

Sure, will add a comment.

> 
> 
>> +       } else {
>> +               loop1_idx2 = BRBE_BANK0_IDX_MAX;
>> +               loop2_idx1 = BRBE_BANK1_IDX_MIN;
>> +               loop2_idx2 = brbe_attr->brbe_nr - 1;
>> +       }
> 
> The loop2_idx1 is the same for both cases.  Maybe better
> to move it out of the if statement.

Sure, will do the following change as suggested but wondering whether should
the change be implemented from this patch onwards or in the later patch that
adds capture_brbe_regset().
 
--- a/drivers/perf/arm_brbe.c
+++ b/drivers/perf/arm_brbe.c
@@ -56,13 +56,14 @@ static int capture_brbe_regset(struct brbe_hw_attr *brbe_attr, struct brbe_regse
        int idx, count;
 
        loop1_idx1 = BRBE_BANK0_IDX_MIN;
+       loop2_idx1 = BRBE_BANK1_IDX_MIN;
        if (brbe_attr->brbe_nr <= BRBE_BANK_MAX_ENTRIES) {
                loop1_idx2 = brbe_attr->brbe_nr - 1;
-               loop2_idx1 = BRBE_BANK1_IDX_MIN;
+
+               /* Disable capturing the bank 1 */
                loop2_idx2 = BRBE_BANK0_IDX_MAX;
        } else {
                loop1_idx2 = BRBE_BANK0_IDX_MAX;
-               loop2_idx1 = BRBE_BANK1_IDX_MIN;
                loop2_idx2 = brbe_attr->brbe_nr - 1;
        }
