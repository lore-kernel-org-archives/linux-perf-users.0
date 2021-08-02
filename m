Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FAAC432BE
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D938610FB
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 15:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhHBPDU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:03:20 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3550 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbhHBPDU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Aug 2021 11:03:20 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gdh833fyRz6F7yB;
        Mon,  2 Aug 2021 23:02:59 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:03:08 +0200
Received: from [10.47.87.154] (10.47.87.154) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 16:03:07 +0100
Subject: Re: [PATCH 02/11] perf jevents: Relocate test events to cpu folder
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <yao.jin@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <irogers@google.com>, <linuxarm@huawei.com>
References: <1627566986-30605-1-git-send-email-john.garry@huawei.com>
 <1627566986-30605-3-git-send-email-john.garry@huawei.com>
 <YQgHMt4BsDeJnE09@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <d15bf358-5044-4db6-24c8-90fb6b1c5d52@huawei.com>
Date:   Mon, 2 Aug 2021 16:02:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YQgHMt4BsDeJnE09@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.87.154]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 02/08/2021 15:54, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 29, 2021 at 09:56:17PM +0800, John Garry escreveu:
>> In future to add support for sys events, relocate the core and uncore
>> events to a cpu folder.
>>
>> Signed-off-by: John Garry<john.garry@huawei.com>
>> ---
>>   .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json | 0
>>   .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json  | 0
>>   .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json  | 0
>>   .../pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json | 0
>>   tools/perf/pmu-events/jevents.c                                 | 2 +-
>>   5 files changed, 1 insertion(+), 1 deletion(-)
>>   rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json (100%)
>>   rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json (100%)
>>   rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json (100%)
>>   rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json (100%)
>>
>> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/branch.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/branch.json
>> similarity index 100%
>> rename from tools/perf/pmu-events/arch/test/test_cpu/branch.json
>> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/branch.json
>> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/cache.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/cache.json
>> similarity index 100%
>> rename from tools/perf/pmu-events/arch/test/test_cpu/cache.json
>> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/cache.json
>> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/other.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/other.json
>> similarity index 100%
>> rename from tools/perf/pmu-events/arch/test/test_cpu/other.json
>> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/other.json
>> diff --git a/tools/perf/pmu-events/arch/test/test_cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
>> similarity index 100%
>> rename from tools/perf/pmu-events/arch/test/test_cpu/uncore.json
>> rename to tools/perf/pmu-events/arch/test/test_soc/cpu/uncore.json
>> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
>> index 9604446f8360..405bdd36b9b9 100644
>> --- a/tools/perf/pmu-events/jevents.c
>> +++ b/tools/perf/pmu-events/jevents.c
>> @@ -814,7 +814,7 @@ static void print_mapping_test_table(FILE *outfp)
>>   	fprintf(outfp, "\t.cpuid = \"testcpu\",\n");
>>   	fprintf(outfp, "\t.version = \"v1\",\n");
>>   	fprintf(outfp, "\t.type = \"core\",\n");
>> -	fprintf(outfp, "\t.table = pme_test_cpu,\n");
>> +	fprintf(outfp, "\t.table = pme_test_soc_cpu,\n");
> Humm, is this already generated by some script? I.e. this
> 'pme_test_soc_cpu' table? Or does this works only when applying the full
> patchset?

Hi Arnaldo,

This file jevents.c generates a table in tools/perf/pmu-events/pmu-events.c

Are you having some issue in applying and building this?

I ask as I think that there is some pre-existing dependency issue which 
I mean to fix, i.e. so please try a clean build.

Thanks,
John
