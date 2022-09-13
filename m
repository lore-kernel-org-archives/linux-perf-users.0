Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F56AC6FA82
	for <linux-perf-users@archiver.kernel.org>; Tue, 13 Sep 2022 12:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiIMMNB (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 13 Sep 2022 08:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiIMMNB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 13 Sep 2022 08:13:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F12B95FAD8;
        Tue, 13 Sep 2022 05:12:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 250331063;
        Tue, 13 Sep 2022 05:13:06 -0700 (PDT)
Received: from [10.163.58.193] (unknown [10.163.58.193])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CE763F71A;
        Tue, 13 Sep 2022 05:12:55 -0700 (PDT)
Message-ID: <14c0b04b-f9f0-632c-4813-f1952e3320bc@arm.com>
Date:   Tue, 13 Sep 2022 17:42:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2 0/7] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
References: <20220908051046.465307-1-anshuman.khandual@arm.com>
 <e44d0bd6-7809-59db-0133-1c6c9ba8cd55@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <e44d0bd6-7809-59db-0133-1c6c9ba8cd55@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 9/13/22 16:25, James Clark wrote:
> 
> On 08/09/2022 06:10, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> relevant register definitions could be accessed here.
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
>>
>> This series applies on v6.0-rc4 after the BRBE related perf ABI changes series
>> (V7) that was posted earlier, and a branch sample filter helper patch.
>>
>> https://lore.kernel.org/all/20220824044822.70230-1-anshuman.khandual@arm.com/
>>
>> https://lore.kernel.org/all/20220906084414.396220-1-anshuman.khandual@arm.com/
>>
>> Following issues have been resolved
>>
>> - Jame's concerns regarding permission inadequacy related to perfmon_capable()
>> - Jame's concerns regarding using perf_event_paranoid along with perfmon_capable()
> I don't see the resolution to this one. I'm not 100% sure of the code
> path used for LBR, but I think you just need to take perf_allow_kernel()
> into account somewhere to make this command have the same result with
> BRBE. Is there any contention that the permissions shouldn't behave in
> the same way across platforms? This is when perf_event_paranoid < 2:
> 
> Intel:
> 
>   $ perf record -j any -- ls
> 
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.014 MB perf.data (16 samples) ]
> 
> Arm:
> 
>   $ perf record -j any -- ls
> 
>   Error:
>   No permission to enable cycles event.
> 
Proposed solution here just follows what we did for the SPE driver recently.
I would not be surprised, if there is difference in semantics in permission
checking across various platform perf drivers. Ideally permission should not
even be checked in platform drivers - either capability or perf_event_paranoid.

Unfortunately changing the permission checking framework across generic perf
is beyond the scope for this BRBE proposal and might be taken up later via a
different series. Although I would be willing to accommodate any alternate
suggestions to improve permission checking here in the BRBE driver.
