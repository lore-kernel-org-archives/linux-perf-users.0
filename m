Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF931C433E0
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jan 2021 09:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D992075A
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Jan 2021 09:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhA0JRO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Jan 2021 04:17:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2437 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbhA0JOe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Jan 2021 04:14:34 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DQd8K1y3sz67gpQ;
        Wed, 27 Jan 2021 17:09:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 27 Jan 2021 10:13:45 +0100
Received: from [10.47.4.0] (10.47.4.0) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 27 Jan
 2021 09:13:44 +0000
Subject: Re: [PATCH V2 0/4] tools: perf: Add JSON metrics for i.MX8M platforms
To:     Joakim Zhang <qiangqing.zhang@nxp.com>, <acme@kernel.org>,
        <jolsa@redhat.com>
CC:     <will@kernel.org>, <linux-perf-users@vger.kernel.org>,
        <linux-imx@nxp.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <91f8504e-8955-142b-0d90-0dcdeaa920b3@huawei.com>
Date:   Wed, 27 Jan 2021 09:12:22 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210125085927.27322-1-qiangqing.zhang@nxp.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.4.0]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/01/2021 08:59, Joakim Zhang wrote:
> Add JSON metrics for i.MX8M platforms.
> 

generally this all looks ok, apart from what I already wrote.

> ChangeLogs:
> V1->V2:
> 	* remove board level metrics (bandwidth metrics)
> 
> Joakim Zhang (4):
>    perf vendor events: Fix indentation of brackets in imx8mm metrics
>    perf vendor events: Add JSON metrics for imx8mn DDR Perf
>    perf vendor events: Add JSON metrics for imx8mq DDR Perf
>    perf vendor events: Add JSON metrics for imx8mp DDR Perf
> 
>   .../arm64/freescale/imx8mm/sys/metrics.json   |   4 +-
>   .../arch/arm64/freescale/imx8mn/sys/ddrc.json |  37 ++
>   .../arm64/freescale/imx8mn/sys/metrics.json   |  18 +
>   .../arch/arm64/freescale/imx8mp/sys/ddrc.json |  37 ++
>   .../arm64/freescale/imx8mp/sys/metrics.json   | 466 ++++++++++++++++++
>   .../arch/arm64/freescale/imx8mq/sys/ddrc.json |  37 ++
>   .../arm64/freescale/imx8mq/sys/metrics.json   |  18 +
>   7 files changed, 615 insertions(+), 2 deletions(-)
>   create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
>   create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
> 

