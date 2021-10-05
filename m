Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC78CC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FA7610C9
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 09:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhJEJdE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:33:04 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3914 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhJEJdE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Oct 2021 05:33:04 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNsh41m76z67b5Q;
        Tue,  5 Oct 2021 17:28:04 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 5 Oct 2021 11:31:11 +0200
Received: from [10.47.95.252] (10.47.95.252) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 10:31:10 +0100
Subject: Re: [PATCH 4/4] perf vendor events: Add the Neoverse V1 to arm64
 mapfile
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <20211004160008.21645-4-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <424d066b-30d5-4512-bd8c-15b700af2864@huawei.com>
Date:   Tue, 5 Oct 2021 10:33:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004160008.21645-4-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.252]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 04/10/2021 17:00, Andrew Kilroy wrote:
> This is so that performance counters for the Neoverse V1 appear
> categorised upon running 'perf list' on the CPU.
> 

this really belongs with the previous patch

Thanks,
John

> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
> ---
>   tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> index c43591d831b8..31d8b57ca9bb 100644
> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> @@ -18,6 +18,7 @@
>   0x00000000410fd080,v1,arm/cortex-a57-a72,core
>   0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
>   0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
> +0x00000000410fd400,v1,arm/neoverse-v1,core
>   0x00000000420f5160,v1,cavium/thunderx2,core
>   0x00000000430f0af0,v1,cavium/thunderx2,core
>   0x00000000460f0010,v1,fujitsu/a64fx,core
> 

