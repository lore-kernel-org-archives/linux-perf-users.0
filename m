Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DFEC43214
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 01:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDD361074
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Sep 2021 01:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241225AbhIABPJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 21:15:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:38589 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234036AbhIABPI (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 31 Aug 2021 21:15:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205823001"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="205823001"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 18:14:12 -0700
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="541278746"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.2.86]) ([10.238.2.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 18:14:06 -0700
Subject: Re: [PATCH v5 1/2] perf pmu: Add PMU alias support
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        rickyman7@gmail.com, john.garry@huawei.com,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210817051933.16978-1-yao.jin@linux.intel.com>
 <20210817051933.16978-2-yao.jin@linux.intel.com> <YS6CCNpd3+557fQZ@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <dfe8f4d2-37de-babe-92af-e8bf72761be2@linux.intel.com>
Date:   Wed, 1 Sep 2021 09:14:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS6CCNpd3+557fQZ@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jiri,

On 9/1/2021 3:24 AM, Jiri Olsa wrote:
> On Tue, Aug 17, 2021 at 01:19:32PM +0800, Jin Yao wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A perf uncore PMU may have two PMU names, a real name and an alias. The
>> alias is exported at /sys/bus/event_source/devices/uncore_*/alias.
>> The perf tool should support the alias as well.
>>
>> Add alias_name in the struct perf_pmu to store the alias. For the PMU
>> which doesn't have an alias. It's NULL.
>>
>> Introduce two X86 specific functions to retrieve the real name and the
>> alias separately.
>>
>> Only go through the sysfs to retrieve the mapping between the real name
>> and the alias once. The result is cached in a list, uncore_pmu_list.
>>
>> Nothing changed for the other ARCHs.
>>
>> With the patch, the perf tool can monitor the PMU with either the real
>> name or the alias.
>>
>> Use the real name,
>>   $ perf stat -e uncore_cha_2/event=1/ -x,
>>     4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
>>
>> Use the alias,
>>   $ perf stat -e uncore_type_0_2/event=1/ -x,
>>     3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,
>>
>> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> SNIP
> 
>> +static char *__pmu_find_real_name(const char *name)
>> +{
>> +	struct perf_pmu_alias_name *pmu;
>> +
>> +	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
>> +		if (!strcmp(name, pmu->alias))
>> +			return pmu->name;
>> +	}
>> +
>> +	return (char *)name;
>> +}
>> +
>> +char *pmu_find_real_name(const char *name)
>> +{
>> +	static bool cached_list;
>> +
>> +	if (cached_list)
>> +		return __pmu_find_real_name(name);
>> +
>> +	setup_pmu_alias_list();
>> +	cached_list = true;
>> +
>> +	return __pmu_find_real_name(name);
>> +}
>> +
>> +char *pmu_find_alias_name(const char *name)
>> +{
>> +	struct perf_pmu_alias_name *pmu;
> 
> should this one call setup_pmu_alias_list as well?
> 

Yes, you're right! We'd better call setup_pmu_alias_list in pmu_find_alias_name too.

>> +
>> +	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
>> +		if (!strcmp(name, pmu->name))
>> +			return pmu->alias;
>> +	}
>> +	return NULL;
>> +}
>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>> index 9321bd0e2f76..d94e48e1ff9b 100644
>> --- a/tools/perf/util/parse-events.y
>> +++ b/tools/perf/util/parse-events.y
>> @@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
>>   			if (!strncmp(name, "uncore_", 7) &&
>>   			    strncmp($1, "uncore_", 7))
>>   				name += 7;
>> -			if (!perf_pmu__match(pattern, name, $1)) {
>> +			if (!perf_pmu__match(pattern, name, $1) ||
>> +			    !perf_pmu__match(pattern, pmu->alias_name, $1)) {
>>   				if (parse_events_copy_term_list(orig_terms, &terms))
>>   					CLEANUP_YYABORT;
>>   				if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 6cdbee8a12e7..9df874155370 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -945,6 +945,18 @@ perf_pmu__get_default_config(struct perf_pmu *pmu __maybe_unused)
>>   	return NULL;
>>   }
>>   
>> +char * __weak
>> +pmu_find_real_name(const char *name)
>> +{
>> +	return (char *)name;
>> +}
>> +
>> +char * __weak
>> +pmu_find_alias_name(const char *name __maybe_unused)
>> +{
>> +	return NULL;
>> +}
>> +
>>   static int pmu_max_precise(const char *name)
>>   {
>>   	char path[PATH_MAX];
>> @@ -958,13 +970,15 @@ static int pmu_max_precise(const char *name)
>>   	return max_precise;
>>   }
>>   
>> -static struct perf_pmu *pmu_lookup(const char *name)
>> +static struct perf_pmu *pmu_lookup(const char *lookup_name)
>>   {
>>   	struct perf_pmu *pmu;
>>   	LIST_HEAD(format);
>>   	LIST_HEAD(aliases);
>>   	__u32 type;
>> +	char *name = pmu_find_real_name(lookup_name);
>>   	bool is_hybrid = perf_pmu__hybrid_mounted(name);
>> +	char *alias_name;
>>   
>>   	/*
>>   	 * Check pmu name for hybrid and the pmu may be invalid in sysfs
>> @@ -995,6 +1009,9 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>   
>>   	pmu->cpus = pmu_cpumask(name);
>>   	pmu->name = strdup(name);
>> +	alias_name = pmu_find_alias_name(name);
>> +	if (alias_name)
>> +		pmu->alias_name = strdup(alias_name);
> 
> please add pmu->name and pmu->alias_name check
> 

OK. I will add the checks.

Thanks
Jin Yao

> thanks,
> jirka
> 
>>   	pmu->type = type;
>>   	pmu->is_uncore = pmu_is_uncore(name);
>>   	if (pmu->is_uncore)
>> @@ -1023,9 +1040,11 @@ static struct perf_pmu *pmu_find(const char *name)
>>   {
>>   	struct perf_pmu *pmu;
>>   
>> -	list_for_each_entry(pmu, &pmus, list)
>> -		if (!strcmp(pmu->name, name))
>> +	list_for_each_entry(pmu, &pmus, list) {
>> +		if (!strcmp(pmu->name, name) ||
>> +		    (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>>   			return pmu;
>> +	}
>>   
>>   	return NULL;
>>   }
>> @@ -1919,6 +1938,9 @@ bool perf_pmu__has_hybrid(void)
>>   
>>   int perf_pmu__match(char *pattern, char *name, char *tok)
>>   {
>> +	if (!name)
>> +		return -1;
>> +
>>   	if (fnmatch(pattern, name, 0))
>>   		return -1;
>>   
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 033e8211c025..6b122f97acf3 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -21,6 +21,7 @@ enum {
>>   #define PERF_PMU_FORMAT_BITS 64
>>   #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>>   #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
>> +#define MAX_PMU_NAME_LEN 128
>>   
>>   struct perf_event_attr;
>>   
>> @@ -32,6 +33,7 @@ struct perf_pmu_caps {
>>   
>>   struct perf_pmu {
>>   	char *name;
>> +	char *alias_name;
>>   	char *id;
>>   	__u32 type;
>>   	bool selectable;
>> @@ -136,4 +138,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
>>   bool perf_pmu__has_hybrid(void);
>>   int perf_pmu__match(char *pattern, char *name, char *tok);
>>   
>> +char *pmu_find_real_name(const char *name);
>> +char *pmu_find_alias_name(const char *name);
>> +
>>   #endif /* __PMU_H */
>> -- 
>> 2.17.1
>>
> 
