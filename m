Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7122DC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 08:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595E860F70
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 08:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbhHCIUA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:20:00 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3567 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhHCIT7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Aug 2021 04:19:59 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gf78917yXz6DJnq;
        Tue,  3 Aug 2021 16:19:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 10:19:46 +0200
Received: from [10.47.27.165] (10.47.27.165) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 3 Aug 2021
 09:19:45 +0100
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
Message-ID: <90094733-741c-50e5-ac7d-f5640b5f0bdd@huawei.com>
Date:   Tue, 3 Aug 2021 09:19:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YQgHMt4BsDeJnE09@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.165]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
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

So I think we need something like this:

----->8--------

 From a08df563665e9ec088b1af86ceed058497e112a4 Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Tue, 3 Aug 2021 08:44:09 +0100
Subject: [PATCH] perf jevents: Make build dependency on test JSONs

Currently all JSONs and the mapfile for an arch are dependencies for
building pmu-events.c

The test JSONs are missing as a dependency, so add them.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index 215ba30b8534..a055dee6a46a 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -6,10 +6,13 @@ pmu-events-y	+= pmu-events.o
  JDIR		=  pmu-events/arch/$(SRCARCH)
  JSON		=  $(shell [ -d $(JDIR) ] &&				\
  			find $(JDIR) -name '*.json' -o -name 'mapfile.csv')
+JDIR_TEST	=  pmu-events/arch/test
+JSON_TEST	=  $(shell [ -d $(JDIR_TEST) ] &&			\
+			find $(JDIR_TEST) -name '*.json')

  #
  # Locate/process JSON files in pmu-events/arch/
  # directory and create tables in pmu-events.c.
  #
-$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JEVENTS)
+$(OUTPUT)pmu-events/pmu-events.c: $(JSON) $(JSON_TEST) $(JEVENTS)
  	$(Q)$(call echo-cmd,gen)$(JEVENTS) $(SRCARCH) pmu-events/arch 
$(OUTPUT)pmu-events/pmu-events.c $(V)


-----8<-----

Thanks,
john
