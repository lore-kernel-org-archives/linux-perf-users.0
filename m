Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258D3C38A2D
	for <linux-perf-users@archiver.kernel.org>; Wed, 26 Oct 2022 09:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiJZJYA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 26 Oct 2022 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiJZJXk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 26 Oct 2022 05:23:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C404A3F4D
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Oct 2022 02:23:39 -0700 (PDT)
Received: from frapeml100007.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4My3Dg3jqtz688s6;
        Wed, 26 Oct 2022 17:20:03 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 frapeml100007.china.huawei.com (7.182.85.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 11:23:36 +0200
Received: from [10.202.227.197] (10.202.227.197) by
 lhrpeml500003.china.huawei.com (7.191.162.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 26 Oct 2022 10:23:36 +0100
Message-ID: <7509f5f8-b58c-2b91-4183-642a8edb9027@huawei.com>
Date:   Wed, 26 Oct 2022 10:23:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 2/3] perf vendor events arm64: Add HiSilicon hip08 core
 events
To:     Shang XiaoJing <shangxiaojing@huawei.com>, <will@kernel.org>,
        <james.clark@arm.com>, <mike.leach@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
References: <20221021105035.10000-1-shangxiaojing@huawei.com>
 <20221021105035.10000-3-shangxiaojing@huawei.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <20221021105035.10000-3-shangxiaojing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/10/2022 11:50, Shang XiaoJing wrote:
> Add some core events of hip08 to the corresponding core-imp-def.json.

Are they actually useful? When I upsteamed the original events, I was 
told that they were the only useful ones

> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Acked-by: James Clark <james.clark@arm.com>

Generally looks ok, but some event descriptions are hard to understand, 
below.

Reveiewed-by: John Garry <john.garry@huawei.com<

> ---
>   .../arm64/hisilicon/hip08/core-imp-def.json   | 132 ++++++++++++++++++
>   1 file changed, 132 insertions(+)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
> index a4a6408639b4..f9a90d6a958d 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/core-imp-def.json
> @@ -53,6 +53,36 @@
>       {
>           "ArchStdEvent": "L2D_CACHE_INVAL"
>       },
> +    {
> +        "PublicDescription": "Number of predictable branches predicted by static predictor",
> +        "EventCode": "0x1001",
> +        "EventName": "IF_BP_PRED_BR_SP",
> +        "BriefDescription": "Static predictor predict count"
> +    },
> +    {
> +        "PublicDescription": "Number of mispredicted procedure returns",
> +        "EventCode": "0x100d",
> +        "EventName": "IF_BP_MISP_BR_RET",
> +        "BriefDescription": "Mispredicted procedures"
> +    },
> +    {
> +        "PublicDescription": "Number of mispredicted indirect branches",
> +        "EventCode": "0x1010",
> +        "EventName": "IF_BP_MISP_BR_IND",
> +        "BriefDescription": "Mispredicted indirect branches"
> +    },
> +    {
> +        "PublicDescription": "Number of mispredicted BLR branches",

maybe telling what BLR is would be helpful

> +        "EventCode": "0x1013",
> +        "EventName": "IF_BP_MISP_BR_BLR",
> +        "BriefDescription": "Mispredicted BLR branches"
> +    },
> +    {
> +        "PublicDescription": "Number of mispredicted BL branches",
> +        "EventCode": "0x1016",
> +        "EventName": "IF_BP_MISP_BR_BL",
> +        "BriefDescription": "Mispredicted BL branches"
> +    },
>       {
>           "PublicDescription": "Level 1 instruction cache prefetch access count",
>           "EventCode": "0x102e",
> @@ -77,12 +107,90 @@
>           "EventName": "IF_IS_STALL",
>           "BriefDescription": "Instruction fetch stall cycles"
>       },
> +    {
> +        "PublicDescription": "Number of times ROB is full",
> +        "EventCode": "0x2004",
> +        "EventName": "ROB_STALL",
> +        "BriefDescription": "ROB stall"
> +    },
> +    {
> +        "PublicDescription": "Number of times PC buffer is full",
> +        "EventCode": "0x2005",
> +        "EventName": "PCBUF_STALL",
> +        "BriefDescription": "PC buffer stall"
> +    },
> +    {
> +        "PublicDescription": "No INT ptag allocated from free list",
> +        "EventCode": "0x2006",
> +        "EventName": "INT_PTAG_STALL",
> +        "BriefDescription": "INT ptag stall"
> +    },
> +    {
> +        "PublicDescription": "No CC ptag allocated from free list",
> +        "EventCode": "0x2007",
> +        "EventName": "CC_PTAG_STALL",
> +        "BriefDescription": "CC ptag stall"
> +    },
> +    {
> +        "PublicDescription": "No VFP ptag allocated from free list",
> +        "EventCode": "0x2008",
> +        "EventName": "VFP_PTAG_STALL",
> +        "BriefDescription": "VFP ptag stall"
> +    },
> +    {
> +        "PublicDescription": "Issue queue of ALU is full",
> +        "EventCode": "0x200b",
> +        "EventName": "ALU_ISQ_STALL",
> +        "BriefDescription": "ALU issue queue stall"
> +    },
> +    {
> +        "PublicDescription": "Issue queue of LSU is full",
> +        "EventCode": "0x200c",
> +        "EventName": "LSU_ISQ_STALL",
> +        "BriefDescription": "LSU issueQ stall"
> +    },
> +    {
> +        "PublicDescription": "Issue queue of FSU is full",
> +        "EventCode": "0x200d",
> +        "EventName": "FSU_ISQ_STALL",
> +        "BriefDescription": "FSU issueQ stall"
> +    },
> +    {
> +        "PublicDescription": "Sync buffer is full",
> +        "EventCode": "0x2010",
> +        "EventName": "SYNC_STALL",
> +        "BriefDescription": "Sync buffer stall"
> +    },
> +    {
> +        "PublicDescription": "LSU nuke flush caused by incorrect data from speculative execution",
> +        "EventCode": "0x2012",
> +        "EventName": "NUKE_FLUSH",
> +        "BriefDescription": "LSU nuke flush"
> +    },
> +    {
> +        "PublicDescription": "OoO ROB flush",
> +        "EventCode": "0x2013",
> +        "EventName": "OOO_FLUSH",
> +        "BriefDescription": "OoO ROB flush"
> +    },
>       {
>           "PublicDescription": "Instructions can receive, but not send",
>           "EventCode": "0x2014",
>           "EventName": "FETCH_BUBBLE",
>           "BriefDescription": "Instructions can receive, but not send"
>       },
> +    {
> +        "PublicDescription": "Cycles of Fetch bubble >= 4",

/s/Fetch/fetch/

> +        "EventCode": "0x201d",
> +        "EventName": "FETCH_BUBBLE_EXCEEDMIW",
> +        "BriefDescription": "Cycles of Fetch bubble >= 4"
> +    },
> +    {
> +        "PublicDescription": "SaveOp queue is full",
> +        "EventCode": "0x201e",
> +        "EventName": "SAVEOP_QUEUE_STALL",
> +        "BriefDescription": "SaveOp queue stall"
> +    },
>       {
>           "PublicDescription": "Prefetch request from LSU",
>           "EventCode": "0x6013",
> @@ -95,18 +203,42 @@
>           "EventName": "HIT_ON_PRF",
>           "BriefDescription": "Hit on prefetched data"
>       },
> +    {
> +        "PublicDescription": "OoO Stall & Inst in OoO but No_Dispatch & IssueQ_can_Accept",

This is hard to understand

> +        "EventCode": "0x7000",
> +        "EventName": "RESOURCE_BOUND",
> +        "BriefDescription": "OoO Stall & Inst in OoO but No_Dispatch & IssueQ_can_Accept"
> +    },
>       {
>           "PublicDescription": "Cycles of that the number of issuing micro operations are less than 4",
>           "EventCode": "0x7001",
>           "EventName": "EXE_STALL_CYCLE",
>           "BriefDescription": "Cycles of that the number of issue ups are less than 4"
>       },
> +    {
> +        "PublicDescription": "No any micro operation is issued & no memstall & executing DIV operation",
> +        "EventCode": "0x7002",
> +        "EventName": "EXE_STALL_DIV",
> +        "BriefDescription": "No any micro operation is issued & no memstall & executing DIV operation"
> +    },
> +    {
> +        "PublicDescription": "No INT operation is issued & no FSU operation is issued & executing FSU operation",
> +        "EventCode": "0x7003",
> +        "EventName": "FSU_STALL",
> +        "BriefDescription": "No INT operation is issued & no FSU operation is issued & executing FSU operation"
> +    },
>       {
>           "PublicDescription": "No any micro operation is issued and meanwhile any load operation is not resolved",
>           "EventCode": "0x7004",
>           "EventName": "MEM_STALL_ANYLOAD",
>           "BriefDescription": "No any micro operation is issued and meanwhile any load operation is not resolved"
>       },
> +    {
> +        "PublicDescription": "No any micro operation is issued and meanwhile any store operation is not resolved",

The grammar here is understand, specifically "No any micro ...". There 
are many instances of this in the above events.

> +        "EventCode": "0x7005",
> +        "EventName": "MEM_STALL_ANYSTORE",
> +        "BriefDescription": "No any micro operation is issued and meanwhile any store operation is not resolved"
> +    },
>       {
>           "PublicDescription": "No any micro operation is issued and meanwhile there is any load operation missing L1 cache and pending data refill",
>           "EventCode": "0x7006",

