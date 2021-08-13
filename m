Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9893C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 01:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9C661038
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Aug 2021 01:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhHMB7o (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 21:59:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:26461 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhHMB7o (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Aug 2021 21:59:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="195073404"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="195073404"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 18:59:16 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="517749378"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.255.30.176]) ([10.255.30.176])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 18:59:12 -0700
Subject: Re: [PATCH v4 1/2] perf pmu: Add PMU alias support
To:     John Garry <john.garry@huawei.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, Kan Liang <kan.liang@linux.intel.com>
References: <20210811024827.9483-1-yao.jin@linux.intel.com>
 <20210811024827.9483-2-yao.jin@linux.intel.com>
 <8730872e-dae1-4d95-48aa-60b15dec2fa7@huawei.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <3f74ca01-8e15-d393-969c-e9d222a989ef@linux.intel.com>
Date:   Fri, 13 Aug 2021 09:59:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8730872e-dae1-4d95-48aa-60b15dec2fa7@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi John,

On 8/12/2021 8:14 PM, John Garry wrote:
> perf pmu: Add x86 PMU alias support
> 
>> +char *pmu_find_real_name(const char *name)
>> +{
>> +    static bool cached_list;
>> +
>> +    if (cached_list)
>> +        return __pmu_find_real_name(name);
>> +
>> +    setup_pmu_alias_list();
>> +    cached_list = true;
>> +
>> +    return __pmu_find_real_name(name);
>> +}
>> +
>> +char *pmu_find_alias_name(const char *name)
>> +{
>> +    struct perf_pmu_alias_name *pmu;
>> +
>> +    list_for_each_entry(pmu, &pmu_alias_name_list, list) {
>> +        if (!strcmp(name, pmu->name))
>> +            return strdup(pmu->alias);
> 
> I would not expect a function which does a "find" to duplicate the name.
> 
> Same goes for all the other places which does similar.
> 

Yes, you are right. Jiri has the similar comment for the name duplicating here. We will still keep 
the 'pmu->name = strdup(name);' in pmu_lookup() in v5.

>> +    }
>> +    return NULL;
>> +}
>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>> index 9321bd0e2f76..d94e48e1ff9b 100644
>> --- a/tools/perf/util/parse-events.y
>> +++ b/tools/perf/util/parse-events.y
>> @@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
>>               if (!strncmp(name, "uncore_", 7) &&
>>                   strncmp($1, "uncore_", 7))
>>                   name += 7;
>> -            if (!perf_pmu__match(pattern, name, $1)) {
>> +            if (!perf_pmu__match(pattern, name, $1) ||
>> +                !perf_pmu__match(pattern, pmu->alias_name, $1)) {
>>                   if (parse_events_copy_term_list(orig_terms, &terms))
>>                       CLEANUP_YYABORT;
>>                   if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index fc683bc41715..796a4be752f4 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -946,6 +946,18 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>>       return NULL;
>>   }
>> +char * __weak
>> +pmu_find_real_name(const char *name)
>> +{
>> +    return strdup(name);
>> +}
> 
> That's not finding anything.
> 

Will just return name in non-x86 implementation.

pmu_find_real_name(const char *name)
{
	return name;
}

>> +
>> +char * __weak
>> +pmu_find_alias_name(const char *name __maybe_unused)
>> +{
>> +    return NULL;
>  > +}
>> +
>>   static int pmu_max_precise(const char *name)
>>   {
>>       char path[PATH_MAX];
>> @@ -959,19 +971,25 @@ static int pmu_max_precise(const char *name)
>>       return max_precise;
>>   }
>> -static struct perf_pmu *pmu_lookup(const char *name)
>> +static struct perf_pmu *pmu_lookup(const char *lookup_name)
>>   {
>> -    struct perf_pmu *pmu;
>> +    struct perf_pmu *pmu = NULL;
>>       LIST_HEAD(format);
>>       LIST_HEAD(aliases);
>>       __u32 type;
>> -    bool is_hybrid = perf_pmu__hybrid_mounted(name);
>> +    bool is_hybrid;
>> +    char *name = pmu_find_real_name(lookup_name);
>> +
>> +    if (!name)
>> +        return NULL;
>> +
>> +    is_hybrid = perf_pmu__hybrid_mounted(name);
>>       /*
>>        * Check pmu name for hybrid and the pmu may be invalid in sysfs
>>        */
>>       if (!strncmp(name, "cpu_", 4) && !is_hybrid)
>> -        return NULL;
>> +        goto out;
>>       /*
>>        * The pmu data we store & need consists of the pmu
>> @@ -979,23 +997,24 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>        * now.
>>        */
>>       if (pmu_format(name, &format))
>> -        return NULL;
>> +        goto out;
>>       /*
>>        * Check the type first to avoid unnecessary work.
>>        */
>>       if (pmu_type(name, &type))
>> -        return NULL;
>> +        goto out;
>>       if (pmu_aliases(name, &aliases))
>> -        return NULL;
>> +        goto out;
>>       pmu = zalloc(sizeof(*pmu));
>>       if (!pmu)
>> -        return NULL;
>> +        goto out;
>>       pmu->cpus = pmu_cpumask(name);
>> -    pmu->name = strdup(name);
>> +    pmu->name = name;
>> +    pmu->alias_name = pmu_find_alias_name(name);
>>       pmu->type = type;
>>       pmu->is_uncore = pmu_is_uncore(name);
>>       if (pmu->is_uncore)
>> @@ -1017,6 +1036,10 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>       pmu->default_config = perf_pmu__get_default_config(pmu);
>> +out:
>> +    if (!pmu)
>> +        free(name);
> 
> I don't understand this. There are lots of places this function can fail , but we don't free 
> memories allocated previously - why just free this one?
>

That's because it's only introduced by my patch (duplicating name). :)

But if we keep 'pmu->name = strdup(name)' in pmu_lookup(), I'm OK to keep original code/behavior.

>> +
>>       return pmu;
>>   }
>> @@ -1025,7 +1048,8 @@ static struct perf_pmu *pmu_find(const char *name)
>>       struct perf_pmu *pmu;
>>       list_for_each_entry(pmu, &pmus, list)
>> -        if (!strcmp(pmu->name, name))
>> +        if (!strcmp(pmu->name, name) ||
>> +            (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>>               return pmu;
> 
> I'd be inclined to use {} for the list_for_each_entry() call
> 

OK, I will add {}, thanks!

>>       return NULL;
>> @@ -1920,6 +1944,9 @@ bool perf_pmu__has_hybrid(void)
>>   int perf_pmu__match(char *pattern, char *name, char *tok)
>>   {
>> +    if (!name)
>> +        return -1;
>> +
>>       if (fnmatch(pattern, name, 0))
>>           return -1;
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 926da483a141..f6ca9f6a06ef 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -21,6 +21,7 @@ enum {
>>   #define PERF_PMU_FORMAT_BITS 64
>>   #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>>   #define CPUS_TEMPLATE_CPU    "%s/bus/event_source/devices/%s/cpus"
>> +#define MAX_PMU_NAME_LEN 128
>>   struct perf_event_attr;
>> @@ -32,6 +33,7 @@ struct perf_pmu_caps {
>>   struct perf_pmu {
>>       char *name;
>> +    char *alias_name;    /* PMU alias name */
> 
> useless comment
> 

OK, remove it :)

Thanks
Jin Yao

>>       char *id;
>>       __u32 type;
>>       bool selectable;
>> @@ -135,4 +137,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>>   bool perf_pmu__has_hybrid(void);
>>   int perf_pmu__match(char *pattern, char *name, char *tok);
>> +char *pmu_find_real_name(const char *name);
>> +char *pmu_find_alias_name(const char *name);
>> +
>>   #endif /* __PMU_H */
>>
> 
