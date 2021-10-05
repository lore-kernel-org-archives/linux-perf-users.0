Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4190CC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 10:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A55613AC
	for <linux-perf-users@archiver.kernel.org>; Tue,  5 Oct 2021 10:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbhJEKKK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 5 Oct 2021 06:10:10 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3916 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbhJEKKK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 5 Oct 2021 06:10:10 -0400
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HNtVW6gdcz67Z5Y;
        Tue,  5 Oct 2021 18:04:51 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 5 Oct 2021 12:08:18 +0200
Received: from [10.47.95.252] (10.47.95.252) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 11:08:17 +0100
Subject: Re: [PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1
 json
To:     Andrew Kilroy <andrew.kilroy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b7a4a1b3-3d22-7a52-75b1-66c04b57a50c@huawei.com>
Date:   Tue, 5 Oct 2021 11:10:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20211004160008.21645-1-andrew.kilroy@arm.com>
Content-Type: text/plain; charset="gbk"; format=flowed
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
> There are some syntactical mistakes in the json files for the Cortex A76
> N1 (Neoverse N1).  This was obstructing parsing from an external tool.

If the trailing comma is not allowed by standard, then maybe we should 
fix our parsing tool to not allow it also. However maybe there is a good 
reason why we allow it..

Reviewed-by: John Garry <john.garry@huawei.com>

> 
> This patch fixes the erroneous placement of commas causing the problems.
> 
> Signed-off-by: Andrew Kilroy<andrew.kilroy@arm.com>
> ---
>   .../arch/arm64/arm/cortex-a76-n1/branch.json  |  4 +--
>   .../arch/arm64/arm/cortex-a76-n1/bus.json     | 12 +++----
>   .../arch/arm64/arm/cortex-a76-n1/cache.json   | 34 +++++++++----------
>   .../arm64/arm/cortex-a76-n1/exception.json    |  4 +--
>   .../arm64/arm/cortex-a76-n1/instruction.json  | 18 +++++-----
>   .../arch/arm64/arm/cortex-a76-n1/memory.json  |  2 +-
>   .../arch/arm64/arm/cortex-a76-n1/other.json   |  2 +-
>   .../arm64/arm/cortex-a76-n1/pipeline.json     |  4 +--
>   8 files changed, 40 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
> index ec0dc92288ab..db68de188390 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/branch.json
> @@ -1,10 +1,10 @@
>   [
>       {
>           "PublicDescription": "This event counts any predictable branch instruction which is mispredicted either due to dynamic misprediction or because the MMU is off and the branches are statically predicted not taken",
> -        "ArchStdEvent": "BR_MIS_PRED",
> +        "ArchStdEvent": "BR_MIS_PRED"
>       },

