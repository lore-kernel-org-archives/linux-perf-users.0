Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC67C43334
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Jun 2022 07:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiF1HkP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Jun 2022 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiF1HkO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Jun 2022 03:40:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3B802A413;
        Tue, 28 Jun 2022 00:40:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73B0D152B;
        Tue, 28 Jun 2022 00:40:11 -0700 (PDT)
Received: from [10.162.42.7] (unknown [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C95CD3F66F;
        Tue, 28 Jun 2022 00:40:07 -0700 (PDT)
Message-ID: <967c0a4f-c864-21ec-33f1-5e3943a42409@arm.com>
Date:   Tue, 28 Jun 2022 13:10:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/8] arm64/perf: Enable branch stack sampling
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peterz@infradead.org, acme@kernel.org, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org
References: <20220613100119.684673-1-anshuman.khandual@arm.com>
 <20220627110105.GF22095@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220627110105.GF22095@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 6/27/22 16:31, Will Deacon wrote:
> On Mon, Jun 13, 2022 at 03:31:11PM +0530, Anshuman Khandual wrote:
>> This series enables perf branch stack sampling support on arm64 platform
>> via a new arch feature called Branch Record Buffer Extension (BRBE). All
>> relevant register definitions could be accessed here.
>>
>> https://developer.arm.com/documentation/ddi0601/2021-12/AArch64-Registers
>>
>> This series applies on v5.19-rc2 after the BRBE related perf ABI changes series
>> (V6) that was posted earlier.
>>
>> https://lore.kernel.org/linux-arm-kernel/20220610035101.424112-1-anshuman.khandual@arm.com/
>>
>> Following issues remain inconclusive
>>
>> - Jame's concerns regarding permission inadequacy related to perfmon_capable()
>> - Jame's concerns regarding using perf_event_paranoid along with perfmon_capable()
> 
> afaict, the capability stuff remains unresolved with the SPE driver, so I'd
> really like to see it fixed there first before we add more broken drivers.
> 
> https://lore.kernel.org/r/20220118100702.GB16547@willie-the-truck

Hello Will,

I did go through the above mentioned thread, but could not understand (clear
enough) - what needs to be done. Could you please help summerize the problem
and possible solutions which I can start looking into. Thank you.

- Anshuman
