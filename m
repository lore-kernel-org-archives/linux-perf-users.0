Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E54C001DB
	for <linux-perf-users@archiver.kernel.org>; Mon,  7 Aug 2023 16:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjHGQEz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 7 Aug 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjHGQEy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 7 Aug 2023 12:04:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59122E79
        for <linux-perf-users@vger.kernel.org>; Mon,  7 Aug 2023 09:04:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DD321FB;
        Mon,  7 Aug 2023 09:05:35 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578883F59C;
        Mon,  7 Aug 2023 09:04:51 -0700 (PDT)
Message-ID: <9755c2b6-b5bb-aa11-f900-729184de98ac@arm.com>
Date:   Mon, 7 Aug 2023 17:04:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/5] perf vendor events arm64: Update N2-r0p3 and V2
 metrics and events using Arm telemetry repo
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-5-james.clark@arm.com>
 <555baa74-5c43-fe75-bad6-58b8871d1f5f@arm.com>
 <1b38b7d3-25e8-f2f5-678d-55d592670b24@linux.alibaba.com>
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
In-Reply-To: <1b38b7d3-25e8-f2f5-678d-55d592670b24@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 27/07/2023 04:50, Jing Zhang wrote:
> 
> 
> 在 2023/7/10 下午10:28, James Clark 写道:
>>
>>
>> On 10/07/2023 15:19, James Clark wrote:
>>> The new metrics contain a fix for N2 r0p3 where CPU_CYCLES should not be
>>> subtracted from stalls for topdown metrics anymore. The current metrics
>>> assume that the fix should be applied anywhere where slots != 5, but
>>> this is only the case for V2 and not N2 r0p3.
>>>
>>> Split the metrics into a new version for N2-r0p3 and V2 which still
>>> share the same metrics. Apart from some slight naming and grouping
>>> differences the new metrics are functionally the same as the existing
>>> ones. Any missing metrics were manually appended to the end of the auto
>>> generated file.
>>>
>>> For the events, the new data includes descriptions that may have product
>>> specific details and new groupings that will be consistent with other
>>> products.
>>>
>>> After generating the metrics from the telemetry repo [1], the following
>>> manual steps were performed:
>>>
>>>  * Change the hard coded slots in neoverse-n2r0p3-v2 to #slots so that
>>>    it will work on both N2 and V2.
>>>
>>>  * Append some metrics from the old N2/V2 data that aren't present in
>>>    the telemetry data. These will possibly be added to the
>>>    telemetry-solution repo at a later time:
>>>
>>>     l3d_cache_mpki, l3d_cache_miss_rate, branch_pki, ipc_rate, spec_ipc,
>>>     retired_rate, wasted_rate, load_spec_rate, store_spec_rate,
>>>     advanced_simd_spec_rate, float_point_spec_rate,
>>>     branch_immed_spec_rate, branch_return_spec_rate,
>>>     branch_indirect_spec_rate
>>>
>>> [1]: https://gitlab.arm.com/telemetry-solution/telemetry-solution/-/blob/main/data/pmu/cpu/neoverse/neoverse-n2.json
>>>
>>> Signed-off-by: James Clark <james.clark@arm.com>
>>> ---
>>
>> [...]
>>
>>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
>>> new file mode 100644
>>> index 000000000000..b01cc2120175
>>> --- /dev/null
>>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2r0p3-v2/metrics.json
>>> @@ -0,0 +1,331 @@
>>> +[
>>> +    {
>>> +        "ArchStdEvent": "backend_bound",
>>> +        "MetricExpr": "(100 * ((STALL_SLOT_BACKEND / (CPU_CYCLES * #slots)) - ((BR_MIS_PRED * 3) / CPU_CYCLES)))"
>>> +    },
>>
>> Hi Jing,
>>
>> I'm not sure if you remember, but a long time ago I said that I was
>> going to update these N2 and V2 metrics that you upstreamed.
>>
>> Now that these are coming from the Arm telemetry repo they have an
>> adjustment for subtracting branch misses that we think is more accurate
>> because of an issue with the STALL_SLOT_BACKEND counter. I've left the
>> sbsa.json metrics without the adjustments as it shouldn't normally be
>> needed.
>>
>> I also had to drop the "if (#slots - 5) else" check because it won't
>> apply to N2-r0p3, but I split the metrics into two instead to fix that
>> issue.
>>
>> The rest is pretty much the same apart from some slight grouping/naming/
>> scaling differences.
>>
>> Let me know what you think.
>>
> 
> 
> Hi James,
> 
> Sorry, I just saw it now, I think it is ok to update the metric. But because only
> the metric is different, is it a bit redundant to copy all the events?
> 
> For uncore_sys_pmu_event, there is a way to deal with this problem, which is to
> identify different rivision identifiers through a "Compat" field. So I wonder if it
> is also possible to add a field similar to "Compat" when describing the metric,
> so that the metric can be matched to different revisions. For example:
> 
> 
> +    {
> +        "ArchStdEvent": "frontend_bound",
> +        "MetricExpr": "(100 * ((STALL_SLOT_FRONTEND / (CPU_CYCLES * #slots)) - (BR_MIS_PRED / CPU_CYCLES)))"
> +	 "Compat": "0x00000000410fd493;0x00000000410fd4f0"
> +    },
> 
> +    {
> +        "ArchStdEvent": "frontend_bound",
> +        "MetricExpr": "(100 * (((STALL_SLOT_FRONTEND - CPU_CYCLES) / (5 * CPU_CYCLES)) - (BR_MIS_PRED / CPU_CYCLES)))"
> +	 "Compat": "0x00000000410fd490"
> +    },
> 
> With this “Compat” field, it only matches the specified revision, and if the “Compat”
> field is not added, it can match all revisions. The 'Compat' field for the Core PMU
> is currently not supported. However, I believe that adding this is not complex,
> and it also has good readability without causing redundancy. Would it be worth a try?
> 
> What do you think?
> 
> 
> Thanks,
> Jing

Hi Jing,

I posted a V4 on the list. I went with John's approach of modifying the
metric expression literal so that the V2 and N2 metrics could be
re-used. I thought that was simpler than the "Compat" field. And I
thought that it might be duplicating some of what the mapfile.csv
already does.

Instead of adding this compat field for core PMUs, if we want to do
something like this, maybe we could make it so that new versions of CPUs
can be added in the mapfile, but they append and modify all the previous
matching versions of JSONs found. So in this case it would work like I
add some new JSONs for N2 r0p3, but they only contain the modified
metrics, rather than everything, and that overwrites that part of the
r0p0 metrics. That way we could add new items in the existing mapfile
but they choose how much or how little of the previous revisions they
would like to replace.

Otherwise we could end up being in a situation where instead of the
mapfile we just add the compat field to all metrics and then we can
delete the mapfile and everything still works. So it seems like it could
end up being two different ways to do the same thing. I'm not completely
against this idea, but I suppose in this exact scenario the new literal
was less change and works pretty well.

Thanks
James

