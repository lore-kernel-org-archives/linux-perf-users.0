Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98642C433E0
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jan 2021 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C87123101
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jan 2021 13:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbhAYNsw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 08:48:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2411 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729044AbhAYNrm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 08:47:42 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DPWKL6Lzbz67ghP;
        Mon, 25 Jan 2021 21:43:18 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 25 Jan 2021 14:46:35 +0100
Received: from [10.47.2.25] (10.47.2.25) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 25 Jan
 2021 13:46:34 +0000
Subject: Re: [PATCH V2 4/4] perf vendor events: Add JSON metrics for imx8mp
 DDR Perf
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, <acme@kernel.org>,
        <jolsa@redhat.com>
CC:     <will@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-imx@nxp.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
 <20210125085927.27322-5-qiangqing.zhang@nxp.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d3035793-d348-7343-a7a5-38b1d0d93852@huawei.com>
Date:   Mon, 25 Jan 2021 13:45:14 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210125085927.27322-5-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.25]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/01/2021 08:59, Joakim Zhang wrote:
> +   },
> +   {
> +	   "BriefDescription": "bytes of display isp1 read from ddr",

is it proper to have "bytes", while scale unit has KB?

> +	   "MetricName": "imx8mp_ddr_read.isp1",
> +	   "MetricExpr": "imx8_ddr0@axid\\-read\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",

eh, does this really even qualify as a "metric"? Seems only a single 
event...

> +	   "ScaleUnit": "9.765625e-4KB",
> +	   "Unit": "imx8_ddr",
> +	   "Compat": "i.MX8MP"
> +   },
> +   {
> +	   "BriefDescription": "bytes of display isp1 write to ddr",
> +	   "MetricName": "imx8mp_ddr_write.isp1",
> +	   "MetricExpr": "imx8_ddr0@axid\\-write\\,axi_mask\\=0x0000\\,axi_id\\=0x006d@",
> +	   "MetricGroup": "imx8_ddr_DDR_MON",
> +	   "Unit": "imx8_ddr",

why no scale unit here?

> +	   "Compat": "i.MX8MP"

btw, not sure if Arnaldo is ok with you not cc'ing other guys mentioned 
in "performance events subsystem" or "performance events tooling arm64"..

Thanks,
john
