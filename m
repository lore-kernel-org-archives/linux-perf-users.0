Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 490C6C433E0
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7C9230FF
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 11:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405140AbhAZLlY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 06:41:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2429 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405320AbhAZLlU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 26 Jan 2021 06:41:20 -0500
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DQ4TV4HFNz67dgZ;
        Tue, 26 Jan 2021 19:37:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 26 Jan 2021 12:40:36 +0100
Received: from [10.47.2.35] (10.47.2.35) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 26 Jan
 2021 11:40:35 +0000
Subject: Re: [PATCH V2 4/4] perf vendor events: Add JSON metrics for imx8mp
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
References: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
 <20210125085927.27322-5-qiangqing.zhang@nxp.com>
 <d3035793-d348-7343-a7a5-38b1d0d93852@huawei.com>
 <DB8PR04MB679545815769E27D3A17CE6DE6BC0@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7f8bc7e3-4d85-562e-e28f-05d75711c392@huawei.com>
Date:   Tue, 26 Jan 2021 11:39:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB679545815769E27D3A17CE6DE6BC0@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.35]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


> 
> 
>>> +	   "MetricName": "imx8mp_ddr_read.isp1",
>>> +	   "MetricExpr":
>>> +"imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",
>> eh, does this really even qualify as a "metric"? Seems only a single event...
> Yes, actually it needs a single metric. I consult to Will before, there is no way to program it in the kernel. I also don't want users to enter a long
> command line, what worst is that users need find out the AXI ID for each master. If we put it in the metric, it is more friendly. Is it reasonable that
> a single metric could be regarded as a special metric? Such as "( imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@ ) * 1 * 1".
> 

ok, fine - I don't see a point in being pedantic, and we should try to 
enhance the user experience (like here).

Maybe in future we could consider a different class of event, like this.

> 
>>> +	   "ScaleUnit": "9.765625e-4KB",
>>> +	   "Unit": "imx8_ddr",
>>> +	   "Compat": "i.MX8MP"
>>> +   },
>>> +   {
>>> +	   "BriefDescription": "bytes of display isp1 write to ddr",
>>> +	   "MetricName": "imx8mp_ddr_write.isp1",
>>> +	   "MetricExpr":
>> "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",
>>> +	   "MetricGroup": "imx8_ddr_DDR_MON",
>>> +	   "Unit": "imx8_ddr",
>> why no scale unit here?
> I will add it. Thanks.
> 
> 
>>> +	   "Compat": "i.MX8MP"
>> btw, not sure if Arnaldo is ok with you not cc'ing other guys mentioned in
>> "performance events subsystem" or "performance events tooling arm64"..
> OK, I will cc them next version. Thanks for your kindly review.

I'll have another look today at the rest of the series.

John
