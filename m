Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFACC433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 10:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF0A22242
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jan 2021 10:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbhATKtS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jan 2021 05:49:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2383 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731298AbhATJ1u (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jan 2021 04:27:50 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DLKpR0PdHz67f3t;
        Wed, 20 Jan 2021 17:23:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 10:27:07 +0100
Received: from [10.47.7.185] (10.47.7.185) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 20 Jan
 2021 09:27:06 +0000
Subject: Re: [PATCH V1 3/4] perf vendor events: Add JSON metrics for imx8mq
 DDR Perf
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>
CC:     "will@kernel.org" <will@kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
 <20210119025647.12569-4-qiangqing.zhang@nxp.com>
 <20a74eda-ae1b-249e-06f1-4ab70e20f684@huawei.com>
 <DB8PR04MB6795A3ED474456F17F52680AE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <65bb44fa-a75a-4425-5289-7ac6374b9285@huawei.com>
 <DB8PR04MB6795DB8ACE469B28A8A6F0ECE6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d3e18e10-dbab-db24-02a9-19fcd53c4bb5@huawei.com>
Date:   Wed, 20 Jan 2021 09:25:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB6795DB8ACE469B28A8A6F0ECE6A20@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.7.185]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 20/01/2021 05:46, Joakim Zhang wrote:
>> -----Original Message-----
>> From: John Garry<john.garry@huawei.com>
>> Sent: 2021年1月19日 20:27
>> To: Joakim Zhang<qiangqing.zhang@nxp.com>;acme@kernel.org;
>> jolsa@redhat.com
>> Cc:will@kernel.org;linux-perf-users@vger.kernel.org; dl-linux-imx
>> <linux-imx@nxp.com>;mark.rutland@arm.com;
>> linux-arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH V1 3/4] perf vendor events: Add JSON metrics for imx8mq
>> DDR Perf
>>
>> On 19/01/2021 11:00, Joakim Zhang wrote:
>>>> -----Original Message-----
>>>> From: John Garry<john.garry@huawei.com>
>>>> Sent: 2021年1月19日 18:40
>>>> To: Joakim Zhang<qiangqing.zhang@nxp.com>;acme@kernel.org;
>>>> jolsa@redhat.com
>>>> Cc:will@kernel.org;linux-perf-users@vger.kernel.org; dl-linux-imx
>>>> <linux-imx@nxp.com>;mark.rutland@arm.com;
>>>> linux-arm-kernel@lists.infradead.org
>>>> Subject: Re: [PATCH V1 3/4] perf vendor events: Add JSON metrics for
>>>> imx8mq DDR Perf
>>>>
>>>> On 19/01/2021 02:56, Joakim Zhang wrote:
>>>>> index 000000000000..c3e9f89a4a4d
>>>>> --- /dev/null
>>>>> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.
>>>>> +++ js
>>>>> +++ on
>>>>> @@ -0,0 +1,26 @@
>>>>> +[
>>>>> +   {
>>>>> +	    "BriefDescription": "bandwidth usage for lpddr4 evk board",
>>>> Why mention the evk board specifically? Is this metric only specific
>>>> to that board, and not all i.MX8MQ platforms?
>>> Yes, John, we have lpddr4 evk board and ddr4 evk borad......
>>>
>> How is this supposed to work?
>>
>> So perf matches on the identifier file for system PMUs; however the contents of
>> this file are based on the HW implementation for imx DDR PMU, not the board.
> Yes, I know this feature is for system PMU, not board. You know DDR bandwidth calculation is based on DDR clock frequency, which is vary form boards.
> 
> e.g.
> lpddr4 board, DDR clock frequency is 750MHZ:
> "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)"
> 
> ddr4 board, DDR clock frequency is 600MHZ.
> "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (600 * 1000000 * 4 * 4)"
> 
> I give different metric names,
> "MetricName": "imx8mm_bandwidth_usage.lpddr4"
> "MetricName": "imx8mm_bandwidth_usage.ddr4"
> 

But that is just not how things are done. We - or I - would expect that 
perf tool would have the intelligence to know the appropriate metric for 
that specific platform. Or, more specifically, we should not present the 
user with many metrics and expect him/her to know the appropriate metric 
for the specific board.

Are there other cases for other architectures where things are done like 
this?

Thanks,
John

> So users can select correct bandwidth metric according to their own board types. To a certain extent, it can also support some board-level metrics.
> 
> If it is okay for you, I will send a V2 to replace ( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) with ( imx8mm_ddr.read_cycles + imx8mm_ddr.write_cycles ).
> 
>>> John, change to your new framework, I found it can't support all features
>> which is supported in 5.10 kernel.
>>
>> Yes, so let me know about all the problems.
> It should have worked as 5.10 kernel at my side. Thanks.

