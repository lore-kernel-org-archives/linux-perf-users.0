Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A4C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 12:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02DE61288
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 12:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbhKHMoe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 07:44:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4068 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhKHMod (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 07:44:33 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HnrGR6WVJz67Lng;
        Mon,  8 Nov 2021 20:37:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Mon, 8 Nov 2021 13:41:47 +0100
Received: from [10.47.92.13] (10.47.92.13) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 8 Nov
 2021 12:41:47 +0000
Subject: Re: Question: SMMUv3 PMU event aliasing
To:     Leo Yan <leo.yan@linaro.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20211108121941.GC1267967@leoy-ThinkPad-X240s>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8b24f36b-6459-c13c-bf19-b9f588eb6b8e@huawei.com>
Date:   Mon, 8 Nov 2021 12:41:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211108121941.GC1267967@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.13]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 08/11/2021 12:19, Leo Yan wrote:
> Hi John,
> 
> [ + mailing list ]

Hi Leo,

> 
> I'd like to confirm the latest upstream status for SMMUv3 PMU event
> aliasing.
> 
> I see the patch set v6 of "perf pmu-events: Support event aliasing for
> system PMUs" [1] has been landed on the mainline kernel, and as an
> example, imx8mm DDR PMU has been supported as system PMU [2].
> 
> On the other hand, I can see patch set 5 contains the SMMUv3 PMU event
> aliasing with patch "perf vendor events arm64: Add Architected events
> smmuv3-pmcg.json" [3], but this patch was left out in patch set 6 and
> it's never landed on the mainline kernel.
> 
> Could you share current status (or plan) for upstreaming SMMUv3 PMU
> event alias?  Or if there have any block issue to prevent merging the
> changes in the mainline kernel?

This feature should be supported in the SMMUv3 PMU kernel driver and 
perf tool.

However it relies on the SMMU PMU identifier sysfs file to work. This 
relies on SMMU_PMCG_IIDR being set, which is introduced latest spec, 
which not much HW will support yet - see commit 2c255223362e. In theory 
we don't need that for the fixed, non-IMPDEF events, but I did not 
complicate perf tool with that mixed support.

That's the reason for which I paused smmuv3-pmcg.json upstream in [3]. I 
will revive that for new gen HW when concrete IMPDEF events known and 
shared.

Thanks,
John

> 
> Thanks for your help!
> 
> Leo
> 
> [1] https://lore.kernel.org/lkml/1607080216-36968-1-git-send-email-john.garry@huawei.com/
> [2] pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
> [3] https://lore.kernel.org/lkml/1604666153-4187-6-git-send-email-john.garry@huawei.com/
> .
> 

