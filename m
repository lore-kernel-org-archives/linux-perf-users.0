Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E769C07E9B
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 07:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279B9611CE
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 07:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236132AbhGUG5O (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 21 Jul 2021 02:57:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3440 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236038AbhGUG5H (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 21 Jul 2021 02:57:07 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GV6Vm5QWVz6D8n1;
        Wed, 21 Jul 2021 15:22:56 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 21 Jul 2021 09:37:42 +0200
Received: from [10.47.85.43] (10.47.85.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 21 Jul
 2021 08:37:41 +0100
Subject: Re: [PATCH] perf pmu: Fix alias matching
To:     "Jin, Yao" <yao.jin@linux.intel.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <kjain@linux.ibm.com>,
        <alexander.shishkin@linux.intel.com>, <irogers@google.com>
CC:     <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1626793819-79090-1-git-send-email-john.garry@huawei.com>
 <0b57fa9b-fba4-8143-bef6-b7c4f2987635@linux.intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <0752a2b1-4770-4614-3b3f-73752a7d962a@huawei.com>
Date:   Wed, 21 Jul 2021 08:37:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <0b57fa9b-fba4-8143-bef6-b7c4f2987635@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.85.43]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

>>
>> Fixes: c47a5599eda3 ("perf tools: Fix pattern matching for same 
>> substring in different PMU type")
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> ---
>> @Jin Yao, please test for your scenarios
>>
> 
> For x86, the form uncore_pmu_{digits} or the uncore_pmu itself are 
> supported. We don't have more complex case such as the name in the form 
> aaa_bbbX_cccY. So my test didn't cover that complex form.
> 

My next thing to do is to add support for these more complex scenarios 
in the PMU events self tests

> For my test, your patch works, thanks! :)

Good

> 
>> Note:
>> About any effect in perf_pmu__match() -> perf_pmu__valid_suffix()
>> callchain, this seems to be called for wildcard in PMU names in metric
>> expressions. We don't have any metrics for arm64 which use feature.
>> However, I hacked an existing metric to use a wildcard and it looks ok.
>> Also the "DRAM_BW_Use" metric on my broadwell uses this feature, and it
>> looks ok.
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index a1bd7007a8b4..fc683bc41715 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -742,9 +742,13 @@ struct pmu_events_map *__weak 
>> pmu_events_map__find(void)
>>       return perf_pmu__find_map(NULL);
>>   }
>> -static bool perf_pmu__valid_suffix(char *pmu_name, char *tok)
>> +/*
>> + * Suffix must be in form tok_{digits}, or tok{digits}, or same as 
>> pmu_name
>> + * to be valid.
>> + */
>> +static bool perf_pmu__valid_suffix(const char *pmu_name, char *tok)
>>   {
>> -    char *p;
>> +    const char *p;
>>       if (strncmp(pmu_name, tok, strlen(tok)))
>>           return false;
>> @@ -753,12 +757,16 @@ static bool perf_pmu__valid_suffix(char 
>> *pmu_name, char *tok)
>>       if (*p == 0)
>>           return true;
>> -    if (*p != '_')
>> -        return false;
>> +    if (*p == '_')
>> +        ++p;
>> -    ++p;
>> -    if (*p == 0 || !isdigit(*p))
>> -        return false;
>> +    /* Ensure we end in a number */
>> +    while (1) {
>> +        if (!isdigit(*p))
>> +            return false;
>> +        if (*(++p) == 0)
>> +            break;
>> +    }
> 
> Do we check *p before first isdigit? For example,
> 
> if (*p == 0)
>      return false;
> 
> While (*p) {
>      if (!isdigit(*p)
>          return false;
>      ++p;
> }
> 
> But maybe isdigit can handle the null string well. I'm just feeling a 
> bit unsure.
> 

isdigit() can safely handle 0 and returns 0 for that case, so what I 
added should be ok

>>       return true;
>>   }
>> @@ -789,12 +797,19 @@ bool pmu_uncore_alias_match(const char 
>> *pmu_name, const char *name)
>>        *        match "socket" in "socketX_pmunameY" and then 
>> "pmuname" in
>>        *        "pmunameY".
>>        */
>> -    for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
>> +    while (1) {
>> +        char *next_tok = strtok_r(NULL, ",", &tmp);
>> +
>>           name = strstr(name, tok);
>> -        if (!name || !perf_pmu__valid_suffix((char *)name, tok)) {
>> +        if (!name ||
>> +            (!next_tok && !perf_pmu__valid_suffix(name, tok))) {
>>               res = false;
>>               goto out;
>>           }
>> +        if (!next_tok)
>> +            break;
>> +        tok = next_tok;
>> +        name += strlen(tok);
>>       }
>>       res = true;
>>
> 
> My test didn't cover the tokens which were delimited by ','. I assume 
> you have tested that on arm64 system. :)
> 

Right
Thanks,
John
