Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D4EB64D9
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Jul 2023 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjGJO24 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Jul 2023 10:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGJO2z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Jul 2023 10:28:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 195B38E
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Jul 2023 07:28:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E76042B;
        Mon, 10 Jul 2023 07:29:35 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5B5D3F67D;
        Mon, 10 Jul 2023 07:28:52 -0700 (PDT)
Message-ID: <555baa74-5c43-fe75-bad6-58b8871d1f5f@arm.com>
Date:   Mon, 10 Jul 2023 15:28:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/5] perf vendor events arm64: Update N2-r0p3 and V2
 metrics and events using Arm telemetry repo
Content-Language: en-US
To:     renyu.zj@linux.alibaba.com
Cc:     namhyung@kernel.org, acme@kernel.org,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, irogers@google.com
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-5-james.clark@arm.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <20230710141903.1595312-5-james.clark@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/07/2023 15:19, James Clark wrote:
> The new metrics contain a fix for N2 r0p3 where CPU_CYCLES should not be
> subtracted from stalls for topdown metrics anymore. The current metrics
> assume that the fix should be applied anywhere where slots != 5, but
> this is only the case for V2 and not N2 r0p3.
> 
> Split the metrics into a new version for N2-r0p3 and V2 which still
> share the same metrics. Apart from some slight naming and grouping
> differences the new metrics are functionally the same as the existing
> ones. Any missing metrics were manually appended to the end of the auto
> generated file.
> 
> For the events, the new data includes descriptions that may have product
> specific details and new groupings that will be consistent with other
> products.
> 
> After generating the metrics from the telemetry repo [1], the following
> manual steps were performed:
> 
>  * Change the hard coded slots in neoverse-n2r0p3-v2 to #slots so that
>    it will work on both N2 and V2.
> 
>  * Append some metrics from the old N2/V2 data that aren't present in
>    the telemetry data. These will possibly be added to the
>    telemetry-solution repo at a later time:
> 
>     l3d_cache_mpki, l3d_cache_miss_rate, branch_pki, ipc_rate, spec_ipc,
>     retired_rate, wasted_rate, load_spec_rate, store_spec_rate,
>     advanced_simd_spec_rate, float_point_spec_rate,
>     branch_immed_spec_rate, branch_return_spec_rate,
>     branch_indirect_spec_rate
> 
> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2.json
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---

[...]

> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
> new file mode 100644
> index 000000000000..b01cc2120175
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
> @@ -0,0 +1,331 @@
> +[
> +    {
> +        "ArchStdEvent": "backend_bound",
> +        "MetricExpr": "(100 * ((STALL_SLOT_BACKEND / (CPU_CYCLES * #slots)) - ((BR_MIS_PRED * 3) / CPU_CYCLES)))"
> +    },

Hi Jing,

I'm not sure if you remember, but a long time ago I said that I was
going to update these N2 and V2 metrics that you upstreamed.

Now that these are coming from the Arm telemetry repo they have an
adjustment for subtracting branch misses that we think is more accurate
because of an issue with the STALL_SLOT_BACKEND counter. I've left the
sbsa.json metrics without the adjustments as it shouldn't normally be
needed.

I also had to drop the "if (#slots - 5) else" check because it won't
apply to N2-r0p3, but I split the metrics into two instead to fix that
issue.

The rest is pretty much the same apart from some slight grouping/naming/
scaling differences.

Let me know what you think.

Thanks
James

> +    {
> +        "MetricName": "backend_stalled_cycles",
> +        "MetricExpr": "((STALL_BACKEND / CPU_CYCLES) * 100)",
> +        "BriefDescription": "This metric is the percentage of cycles that were stalled due to resource constraints in the backend unit of the processor.",
> +        "MetricGroup": "Cycle_Accounting",
> +        "ScaleUnit": "1percent of cycles"
> +    },
> +    {
> +        "ArchStdEvent": "bad_speculation",
> +        "MetricExpr": "(100 * (((1 - (OP_RETIRED / OP_SPEC)) * (1 - (STALL_SLOT / (CPU_CYCLES * #slots)))) + ((BR_MIS_PRED * 4) / CPU_CYCLES)))"
> +    },
> +    {
> +        "MetricName": "branch_misprediction_ratio",
> +        "MetricExpr": "(BR_MIS_PRED_RETIRED / BR_RETIRED)",
> +        "BriefDescription": "This metric measures the ratio of branches mispredicted to the total number of branches architecturally executed. This gives an indication of the effectiveness of the branch prediction unit.",
> +        "MetricGroup": "Miss_Ratio;Branch_Effectiveness",
> +        "ScaleUnit": "1per branch"
> +    },


