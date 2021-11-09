Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97910C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74CC4610A0
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Nov 2021 11:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbhKILfA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:35:00 -0500
Received: from foss.arm.com ([217.140.110.172]:60554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245757AbhKILe5 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Nov 2021 06:34:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E0C2ED1;
        Tue,  9 Nov 2021 03:32:11 -0800 (PST)
Received: from [10.57.81.233] (unknown [10.57.81.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63B2E3F7F5;
        Tue,  9 Nov 2021 03:32:10 -0800 (PST)
Message-ID: <7213fdb0-b0ff-f851-87c6-7a55245cfcce@arm.com>
Date:   Tue, 9 Nov 2021 11:32:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: Question: SMMUv3 PMU event aliasing
Content-Language: en-GB
To:     John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211108121941.GC1267967@leoy-ThinkPad-X240s>
 <8b24f36b-6459-c13c-bf19-b9f588eb6b8e@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <8b24f36b-6459-c13c-bf19-b9f588eb6b8e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 2021-11-08 12:41, John Garry wrote:
> On 08/11/2021 12:19, Leo Yan wrote:
>> Hi John,
>>
>> [ + mailing list ]
> 
> Hi Leo,
> 
>>
>> I'd like to confirm the latest upstream status for SMMUv3 PMU event
>> aliasing.
>>
>> I see the patch set v6 of "perf pmu-events: Support event aliasing for
>> system PMUs" [1] has been landed on the mainline kernel, and as an
>> example, imx8mm DDR PMU has been supported as system PMU [2].
>>
>> On the other hand, I can see patch set 5 contains the SMMUv3 PMU event
>> aliasing with patch "perf vendor events arm64: Add Architected events
>> smmuv3-pmcg.json" [3], but this patch was left out in patch set 6 and
>> it's never landed on the mainline kernel.
>>
>> Could you share current status (or plan) for upstreaming SMMUv3 PMU
>> event alias?  Or if there have any block issue to prevent merging the
>> changes in the mainline kernel?
> 
> This feature should be supported in the SMMUv3 PMU kernel driver and 
> perf tool.
> 
> However it relies on the SMMU PMU identifier sysfs file to work. This 
> relies on SMMU_PMCG_IIDR being set, which is introduced latest spec, 
> which not much HW will support yet - see commit 2c255223362e. In theory 
> we don't need that for the fixed, non-IMPDEF events, but I did not 
> complicate perf tool with that mixed support.
> 
> That's the reason for which I paused smmuv3-pmcg.json upstream in [3]. I 
> will revive that for new gen HW when concrete IMPDEF events known and 
> shared.

FWIW, imp-def-events are readily available for the existing Arm 
implementations[1][2], and annoyingly we could trivially synthesise an 
IIDR value from their imp-def PIDR registers if only we knew that that 
was valid to do in the first place. I feel tempted now to resurrect 
Jean-Philippe's DT binding and have a quick hack at that, then maybe a 
much longer think about how to attempt it for IORT...

Cheers,
Robin.

[1] 
https://developer.arm.com/documentation/100310/0202/Functional-description/Operation/Performance-Monitoring-Unit
[2] 
https://developer.arm.com/documentation/101542/0001/Functional-description/Operation/Performance-Monitoring-Unit

> 
> Thanks,
> John
> 
>>
>> Thanks for your help!
>>
>> Leo
>>
>> [1] 
>> https://lore.kernel.org/lkml/1607080216-36968-1-git-send-email-john.garry@huawei.com/ 
>>
>> [2] pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
>> [3] 
>> https://lore.kernel.org/lkml/1604666153-4187-6-git-send-email-john.garry@huawei.com/ 
>>
>> .
>>
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
