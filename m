Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDCC433E6
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F15B22DD3
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbhASOiX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:38:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2370 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390869AbhASKmJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Jan 2021 05:42:09 -0500
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKlVh4ZWMz67dl0;
        Tue, 19 Jan 2021 18:38:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 11:41:28 +0100
Received: from [10.47.10.61] (10.47.10.61) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 10:41:27 +0000
Subject: Re: [PATCH V1 3/4] perf vendor events: Add JSON metrics for imx8mq
 DDR Perf
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, <acme@kernel.org>,
        <jolsa@redhat.com>
CC:     <will@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-imx@nxp.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210119025647.12569-1-qiangqing.zhang@nxp.com>
 <20210119025647.12569-4-qiangqing.zhang@nxp.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <20a74eda-ae1b-249e-06f1-4ab70e20f684@huawei.com>
Date:   Tue, 19 Jan 2021 10:40:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210119025647.12569-4-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.61]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 19/01/2021 02:56, Joakim Zhang wrote:
> index 000000000000..c3e9f89a4a4d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
> @@ -0,0 +1,26 @@
> +[
> +   {
> +	    "BriefDescription": "bandwidth usage for lpddr4 evk board",

Why mention the evk board specifically? Is this metric only specific to 
that board, and not all i.MX8MQ platforms?

Thanks,
John

> +	    "MetricName": "imx8mq_bandwidth_usage.lpddr4",
> +	    "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (800 * 1000000 * 4 * 4)",
> +	    "ScaleUnit": "1e2%",
> +	    "Unit": "imx8_ddr",
> +	    "Compat": "i.MX8MQ"
> +   },

