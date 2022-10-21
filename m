Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA86C433FE
	for <linux-perf-users@archiver.kernel.org>; Fri, 21 Oct 2022 09:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiJUJMH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 21 Oct 2022 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJUJLp (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 21 Oct 2022 05:11:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 814DC25643C
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Oct 2022 02:10:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C98C1FB;
        Fri, 21 Oct 2022 02:10:09 -0700 (PDT)
Received: from [10.57.2.49] (unknown [10.57.2.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0AC63F67D;
        Fri, 21 Oct 2022 02:10:00 -0700 (PDT)
Message-ID: <bf6205a7-8d72-fabe-2633-a0d2282ce299@arm.com>
Date:   Fri, 21 Oct 2022 10:09:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 3/3] perf vendor events arm64: Use event name instead of
 event code
To:     Shang XiaoJing <shangxiaojing@huawei.com>
References: <20221021085326.17139-1-shangxiaojing@huawei.com>
 <20221021085326.17139-4-shangxiaojing@huawei.com>
Content-Language: en-US
Cc:     john.garry@huawei.com, will@kernel.org, mike.leach@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, kjain@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20221021085326.17139-4-shangxiaojing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 21/10/2022 09:53, Shang XiaoJing wrote:
> Use the event name instead of the corresponding event code for more
> clear, which makes the result of perf more readable.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> ---
>  .../arch/arm64/hisilicon/hip08/metrics.json   | 50 +++++++++----------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> index 6443a061e22a..4629349005d0 100644
> --- a/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
> @@ -28,7 +28,7 @@
>          "MetricName": "backend_bound"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x201d@ / CPU_CYCLES",
> +        "MetricExpr": "FETCH_BUBBLE_EXCEEDMIW / CPU_CYCLES",
>          "PublicDescription": "Fetch latency bound L2 topdown metric",
>          "BriefDescription": "Fetch latency bound L2 topdown metric",
>          "MetricGroup": "TopDownL2",
> @@ -42,7 +42,7 @@
>          "MetricName": "fetch_bandwidth_bound"
>      },
>      {
> -        "MetricExpr": "(bad_speculation * BR_MIS_PRED) / (BR_MIS_PRED + armv8_pmuv3_0@event\\=0x2013@)",
> +        "MetricExpr": "(bad_speculation * BR_MIS_PRED) / (BR_MIS_PRED + OOO_FLUSH)",
>          "PublicDescription": "Branch mispredicts L2 topdown metric",
>          "BriefDescription": "Branch mispredicts L2 topdown metric",
>          "MetricGroup": "TopDownL2",
> @@ -56,14 +56,14 @@
>          "MetricName": "machine_clears"
>      },
>      {
> -        "MetricExpr": "(EXE_STALL_CYCLE - (MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@)) / CPU_CYCLES",
> +        "MetricExpr": "(EXE_STALL_CYCLE - (MEM_STALL_ANYLOAD + MEM_STALL_ANYSTORE)) / CPU_CYCLES",
>          "PublicDescription": "Core bound L2 topdown metric",
>          "BriefDescription": "Core bound L2 topdown metric",
>          "MetricGroup": "TopDownL2",
>          "MetricName": "core_bound"
>      },
>      {
> -        "MetricExpr": "(MEM_STALL_ANYLOAD + armv8_pmuv3_0@event\\=0x7005@) / CPU_CYCLES",
> +        "MetricExpr": "(MEM_STALL_ANYLOAD + MEM_STALL_ANYSTORE) / CPU_CYCLES",
>          "PublicDescription": "Memory bound L2 topdown metric",
>          "BriefDescription": "Memory bound L2 topdown metric",
>          "MetricGroup": "TopDownL2",
> @@ -91,53 +91,53 @@
>          "MetricName": "bp_misp_flush"
>      },
>      {
> -        "MetricExpr": "(armv8_pmuv3_0@event\\=0x2013@ * 5) / CPU_CYCLES",
> +        "MetricExpr": "(OOO_FLUSH * 5) / CPU_CYCLES",
>          "PublicDescription": "OOO flush L3 topdown metric",
>          "BriefDescription": "OOO flush L3 topdown metric",
>          "MetricGroup": "TopDownL3",
> -        "MetricName": "ooo_flush"
> +        "MetricName": "ooo_flush_ratio"
>      },
>      {
> -        "MetricExpr": "(armv8_pmuv3_0@event\\=0x1001@ * 5) / CPU_CYCLES",
> +        "MetricExpr": "(IF_BP_PRED_BR_SP * 5) / CPU_CYCLES",
>          "PublicDescription": "Static predictor flush L3 topdown metric",
>          "BriefDescription": "Static predictor flush L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "sp_flush"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x1010@ / BR_MIS_PRED",
> +        "MetricExpr": "IF_BP_MISP_BR_IND / BR_MIS_PRED",
>          "PublicDescription": "Indirect branch L3 topdown metric",
>          "BriefDescription": "Indirect branch L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "indirect_branch"
>      },
>      {
> -        "MetricExpr": "(armv8_pmuv3_0@event\\=0x1013@ + armv8_pmuv3_0@event\\=0x1016@) / BR_MIS_PRED",
> +        "MetricExpr": "(IF_BP_MISP_BR_BLR + IF_BP_MISP_BR_BL) / BR_MIS_PRED",
>          "PublicDescription": "Push branch L3 topdown metric",
>          "BriefDescription": "Push branch L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "push_branch"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x100d@ / BR_MIS_PRED",
> +        "MetricExpr": "IF_BP_MISP_BR_RET / BR_MIS_PRED",
>          "PublicDescription": "Pop branch L3 topdown metric",
>          "BriefDescription": "Pop branch L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "pop_branch"
>      },
>      {
> -        "MetricExpr": "(BR_MIS_PRED - armv8_pmuv3_0@event\\=0x1010@ - armv8_pmuv3_0@event\\=0x1013@ - armv8_pmuv3_0@event\\=0x1016@ - armv8_pmuv3_0@event\\=0x100d@) / BR_MIS_PRED",
> +        "MetricExpr": "(BR_MIS_PRED - IF_BP_MISP_BR_IND - IF_BP_MISP_BR_BLR - IF_BP_MISP_BR_BL - IF_BP_MISP_BR_RET) / BR_MIS_PRED",
>          "PublicDescription": "Other branch L3 topdown metric",
>          "BriefDescription": "Other branch L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "other_branch"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x2012@ / armv8_pmuv3_0@event\\=0x2013@",
> +        "MetricExpr": "NUKE_FLUSH / OOO_FLUSH",
>          "PublicDescription": "Nuke flush L3 topdown metric",
>          "BriefDescription": "Nuke flush L3 topdown metric",
>          "MetricGroup": "TopDownL3",
> -        "MetricName": "nuke_flush"
> +        "MetricName": "nuke_flush_ratio"
>      },
>      {
>          "MetricExpr": "1 - nuke_flush",
> @@ -147,53 +147,53 @@
>          "MetricName": "other_flush"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x2010@ / CPU_CYCLES",
> +        "MetricExpr": "SYNC_STALL / CPU_CYCLES",
>          "PublicDescription": "Sync stall L3 topdown metric",
>          "BriefDescription": "Sync stall L3 topdown metric",
>          "MetricGroup": "TopDownL3",
> -        "MetricName": "sync_stall"
> +        "MetricName": "sync_stall_ratio"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x2004@ / CPU_CYCLES",
> +        "MetricExpr": "ROB_STALL / CPU_CYCLES",
>          "PublicDescription": "Rob stall L3 topdown metric",
>          "BriefDescription": "Rob stall L3 topdown metric",
>          "MetricGroup": "TopDownL3",
> -        "MetricName": "rob_stall"
> +        "MetricName": "rob_stall_ratio"
>      },
>      {
> -        "MetricExpr": "(armv8_pmuv3_0@event\\=0x2006@ + armv8_pmuv3_0@event\\=0x2007@ + armv8_pmuv3_0@event\\=0x2008@) / CPU_CYCLES",
> +        "MetricExpr": "(INT_PTAG_STALL + CC_PTAG_STALL + VFP_PTAG_STALL) / CPU_CYCLES",
>          "PublicDescription": "Ptag stall L3 topdown metric",
>          "BriefDescription": "Ptag stall L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "ptag_stall"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x201e@ / CPU_CYCLES",
> +        "MetricExpr": "SAVEOP_QUEUE_STALL / CPU_CYCLES",
>          "PublicDescription": "SaveOpQ stall L3 topdown metric",
>          "BriefDescription": "SaveOpQ stall L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "saveopq_stall"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x2005@ / CPU_CYCLES",
> +        "MetricExpr": "PCBUF_STALL / CPU_CYCLES",
>          "PublicDescription": "PC buffer stall L3 topdown metric",
>          "BriefDescription": "PC buffer stall L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "pc_buffer_stall"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x7002@ / CPU_CYCLES",
> +        "MetricExpr": "EXE_STALL_DIV / CPU_CYCLES",
>          "PublicDescription": "Divider L3 topdown metric",
>          "BriefDescription": "Divider L3 topdown metric",
>          "MetricGroup": "TopDownL3",
>          "MetricName": "divider"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x7003@ / CPU_CYCLES",
> +        "MetricExpr": "FSU_STALL / CPU_CYCLES",
>          "PublicDescription": "FSU stall L3 topdown metric",
> -        "BriefDescription": "FSU stall L3 topdown metric",
> +	"BriefDescription": "FSU stall L3 topdown metric",

There is a tab here, but it's probably not worth resubmitting over.

Otherwise for the whole set:

Acked-by: James Clark <james.clark@arm.com>

>          "MetricGroup": "TopDownL3",
> -        "MetricName": "fsu_stall"
> +        "MetricName": "fsu_stall_ratio"
>      },
>      {
>          "MetricExpr": "core_bound - divider - fsu_stall",
> @@ -224,7 +224,7 @@
>          "MetricName": "mem_bound"
>      },
>      {
> -        "MetricExpr": "armv8_pmuv3_0@event\\=0x7005@ / CPU_CYCLES",
> +        "MetricExpr": "MEM_STALL_ANYSTORE / CPU_CYCLES",
>          "PublicDescription": "Store bound L3 topdown metric",
>          "BriefDescription": "Store bound L3 topdown metric",
>          "MetricGroup": "TopDownL3",
