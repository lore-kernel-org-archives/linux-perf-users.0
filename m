Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374FBC05052
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Aug 2023 09:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358965AbjHRJOt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 05:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359026AbjHRJOn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Aug 2023 05:14:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC8130E6
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Aug 2023 02:14:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRx1b5YzSztRwl;
        Fri, 18 Aug 2023 17:10:59 +0800 (CST)
Received: from [10.174.179.211] (10.174.179.211) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 17:14:37 +0800
Message-ID: <dcf0a583-2876-3305-709e-ffe820e2f2df@huawei.com>
Date:   Fri, 18 Aug 2023 17:14:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] perf header: Fix missing PMU caps recording in
 write_pmu_caps
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        <linux-perf-users@vger.kernel.org>, <huawei.libin@huawei.com>
References: <20230815130722.1223744-1-liwei391@huawei.com>
 <CAP-5=fX2v=vV8eUX3x2i+vcYQQ=W9_tswh4VXy4nP9R3MPh=2Q@mail.gmail.com>
From:   "liwei (GF)" <liwei391@huawei.com>
In-Reply-To: <CAP-5=fX2v=vV8eUX3x2i+vcYQQ=W9_tswh4VXy4nP9R3MPh=2Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.211]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Ian:

On 2023/8/17 11:31, Ian Rogers wrote:
(SNIP)
>>
>> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
>> index 52fbf526fe74..7d2bd1fb8ef2 100644
>> --- a/tools/perf/util/header.c
>> +++ b/tools/perf/util/header.c
>> @@ -1618,22 +1618,10 @@ static int write_pmu_caps(struct feat_fd *ff,
>>         if (!nr_pmu)
>>                 return 0;
>>
>> -       /*
>> -        * Write hybrid pmu caps first to maintain compatibility with
>> -        * older perf tool.
>> -        */
>> -       if (perf_pmus__num_core_pmus() > 1) {
>> -               pmu = NULL;
>> -               while ((pmu = perf_pmus__scan_core(pmu))) {
>> -                       ret = __write_pmu_caps(ff, pmu, true);
>> -                       if (ret < 0)
>> -                               return ret;
>> -               }
>> -       }
>> -
>>         pmu = NULL;
>>         while ((pmu = perf_pmus__scan(pmu))) {
>> -               if (pmu->is_core || !pmu->nr_caps)
>> +               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
>> +                   !pmu->nr_caps)
>>                         continue;
>>
>>                 ret = __write_pmu_caps(ff, pmu, true);
> 
> Sorry for the breakage. I think all of the branches are interfering
> here, I think a simpler solution is:
> 
> ```
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1605,8 +1605,7 @@ static int write_pmu_caps(struct feat_fd *ff,
>        int ret;
> 
>        while ((pmu = perf_pmus__scan(pmu))) {
> -               if (!pmu->name || !strcmp(pmu->name, "cpu") ||
> -                   perf_pmu__caps_parse(pmu) <= 0)
> +               if (perf_pmu__caps_parse(pmu) <= 0)
>                        continue;
>                nr_pmu++;
>        }
> @@ -1619,23 +1618,13 @@ static int write_pmu_caps(struct feat_fd *ff,
>                return 0;
> 
>        /*
> -        * Write hybrid pmu caps first to maintain compatibility with
> -        * older perf tool.
> +        * Note older perf tools assume core PMUs come first, this is a property
> +        * of perf_pmus__scan.
>         */
> -       if (perf_pmus__num_core_pmus() > 1) {
> -               pmu = NULL;
> -               while ((pmu = perf_pmus__scan_core(pmu))) {
> -                       ret = __write_pmu_caps(ff, pmu, true);
> -                       if (ret < 0)
> -                               return ret;
> -               }
> -       }
> -
>        pmu = NULL;
>        while ((pmu = perf_pmus__scan(pmu))) {
> -               if (pmu->is_core || !pmu->nr_caps)
> +               if (perf_pmu__caps_parse(pmu) <= 0)
>                        continue;
> -
>                ret = __write_pmu_caps(ff, pmu, true);
>                if (ret < 0)
>                        return ret;
> ```
> 
> Could you try it out?
> 

I have tested your patch, it does make "perf script" work, but your modification
records all the pmus with caps, including "cpu" on x86. This does not match the
spec in tools/perf/Documentation/perf.data-file-format.txt:

	HEADER_PMU_CAPS = 31,

	List of pmu capabilities (except cpu pmu which is already
	covered by HEADER_CPU_PMU_CAPS). Note that hybrid cpu pmu
	capabilities are also stored here.

---
The header info of perf.data:

# bpf_prog_info 5809: bpf_prog_6deef7357e7b4530 addr 0xffffffffc11a10e3 size 61
# cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
# cpu pmu capabilities: branches=32, max_precise=3, pmu_name=skylake
# intel_pt pmu capabilities: topa_multiple_entries=1, psb_cyc=1, single_range_output=1, mtc_periods=249, ip_filtering=1, output_subsys=0, cr3_filtering=1, psb_periods=3f, cycle_thresholds=3fff, power_event_t>
# missing features: TRACING_DATA BRANCH_STACK GROUP_DESC AUXTRACE STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA HYBRID_TOPOLOGY


Thanks,
Wei
