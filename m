Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4040C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 00:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C967D61074
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 00:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhIBA7U (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 20:59:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:1620 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232429AbhIBA7T (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 20:59:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="282626434"
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="282626434"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 17:58:22 -0700
X-IronPort-AV: E=Sophos;i="5.84,370,1620716400"; 
   d="scan'208";a="532539775"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.2.86]) ([10.238.2.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 17:58:18 -0700
Subject: Re: [PATCH v6 1/2] perf pmu: Add PMU alias support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        john.garry@huawei.com, Kan Liang <kan.liang@linux.intel.com>
References: <20210901054602.17010-1-yao.jin@linux.intel.com>
 <20210901054602.17010-2-yao.jin@linux.intel.com>
 <YS+G5s41RWX0GIqG@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <298a4efe-72f3-f99a-3923-939eab44885a@linux.intel.com>
Date:   Thu, 2 Sep 2021 08:58:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS+G5s41RWX0GIqG@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On 9/1/2021 9:57 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Sep 01, 2021 at 01:46:01PM +0800, Jin Yao escreveu:
> <SNIP>
> 
>> +++ b/tools/perf/arch/x86/util/pmu.c
> 
> <SNIP>
> 
>> +static int setup_pmu_alias_list(void)
>> +{
>> +	char path[PATH_MAX];
>> +	DIR *dir;
>> +	struct dirent *dent;
>> +	const char *sysfs = sysfs__mountpoint();
>> +	struct perf_pmu_alias_name *pmu;
>> +	char buf[MAX_PMU_NAME_LEN];
>> +	FILE *file;
>> +	int ret = 0;
>> +
>> +	if (!sysfs)
>> +		return -1;
>> +
>> +	snprintf(path, PATH_MAX,
>> +		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
>> +
>> +	dir = opendir(path);
>> +	if (!dir)
>> +		return -1;
>> +
>> +	while ((dent = readdir(dir))) {
>> +		if (!strcmp(dent->d_name, ".") ||
>> +		    !strcmp(dent->d_name, ".."))
>> +			continue;
>> +
>> +		snprintf(path, PATH_MAX,
>> +			 TEMPLATE_ALIAS, sysfs, dent->d_name);
>> +
>> +		if (!file_available(path))
>> +			continue;
>> +
>> +		file = fopen(path, "r");
>> +		if (!file)
>> +			continue;
>> +
>> +		if (!fgets(buf, sizeof(buf), file)) {
>> +			fclose(file);
>> +			continue;
>> +		}
>> +
>> +		fclose(file);
>> +
>> +		pmu = zalloc(sizeof(*pmu));
>> +		if (!pmu) {
>> +			ret = -ENOMEM;
>> +			break;
>> +		}
>> +
>> +		/* Remove the last '\n' */
>> +		buf[strlen(buf) - 1] = 0;
>> +
>> +		pmu->alias = strdup(buf);
>> +		if (!pmu->alias)
>> +			goto mem_err;
> 
> This isn't returning -ENOMEM like when zalloc() fails above. Also you're
> mixing 'return -1' with 'return -ENOMEM', please be consistent. Please
> find some -E errno for the !sysfs case, perhaps -ENODEV?
> 

For opendir() error, can we just return -errno?

dir = opendir(path);
if (!dir)
	return -errno;

>> +
>> +		pmu->name = strdup(dent->d_name);
>> +		if (!pmu->name)
>> +			goto mem_err;
>> +
>> +		list_add_tail(&pmu->list, &pmu_alias_name_list);
>> +		continue;
> 
> 
> Don't we have a 'struct pmu' constructor/destructor pair? I.e. instead
> of doing all this in an open coded way as above, why not have:
> 
> void pmu__delete(struct pmu *pmu)
> {
> 	if (!pmu)
> 		return;
> 
> 	zfree(&pmu->name);
> 	zfree(&pmu->alias);
> 	free(pmu);
> }
> 
> struct pmu *pmu__new(const char *name, const char *alias)
> {
> 	struct pmu *pmu = zalloc(sizeof(*pmu));
> 
> 	if (pmu) {
> 		pmu->name = strdup(name);
> 		if (!pmu->name)
> 			goto out_delete;
> 
> 		pmu->alias = strdup(alias);
> 		if (!pmu->alias)
> 			goto out_delete;
> 	}
> 
> 	return pmu;
> out_err:
> 	pmu__delete(pmu);
> 	return NULL;
> }
> 
> 	And then just:
> 
> 	pmu = pmu__new(dent->d_name, buf);
> 	if (!pmu)
> 		goto out_closedir;
> 
> 	list_add_tail(&pmu->list, &pmu_alias_name_list);
> 
> And then you don't need the 'continue', as this is the end of the loop
> block.
> 		
> That 'ret' probably should start with -ENOMEM and you end the function
> with:
> 
> 	ret = 0;
> out_closedir:
> 	closedir(dir);
> 	return ret;
> }

Yes, using 'struct pmu' constructor/destructor is absolutely a good design.

I will follow this approach.

> 
> 
> The pmu__delete() should be used in perf's shutdown when running it
> using memory leak detectors, when not using it, its ok to just leave it
> as is to speed up the shutdown.
> 
> - Arnaldo
> 

Yes, agree. I will create a separate patch to implement the 'struct pmu' constructor/destructor.

Thanks
Jin Yao

>> +mem_err:
>> +		free(pmu->alias);
>> +		free(pmu->name);
>> +		free(pmu);
>> +		break;
>> +	}
>> +
>> +	closedir(dir);
>> +	return ret;
>> +}
>> +
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
>> +	if (cached_list)
>> +		return __pmu_find_real_name(name);
>> +
>> +	setup_pmu_alias_list();
>> +	cached_list = true;
>> +
>> +	return __pmu_find_real_name(name);
>> +}
>> +
>> +static char *__pmu_find_alias_name(const char *name)
>> +{
>> +	struct perf_pmu_alias_name *pmu;
>> +
>> +	list_for_each_entry(pmu, &pmu_alias_name_list, list) {
>> +		if (!strcmp(name, pmu->name))
>> +			return pmu->alias;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +char *pmu_find_alias_name(const char *name)
>> +{
>> +	if (cached_list)
>> +		return __pmu_find_alias_name(name);
>> +
>> +	setup_pmu_alias_list();
>> +	cached_list = true;
>> +
>> +	return __pmu_find_alias_name(name);
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
>> index 6cdbee8a12e7..1a35915edf68 100644
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
>> @@ -995,6 +1009,16 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>   
>>   	pmu->cpus = pmu_cpumask(name);
>>   	pmu->name = strdup(name);
>> +	if (!pmu->name)
>> +		goto err;
>> +
>> +	alias_name = pmu_find_alias_name(name);
>> +	if (alias_name) {
>> +		pmu->alias_name = strdup(alias_name);
>> +		if (!pmu->alias_name)
>> +			goto err;
>> +	}
>> +
>>   	pmu->type = type;
>>   	pmu->is_uncore = pmu_is_uncore(name);
>>   	if (pmu->is_uncore)
>> @@ -1017,15 +1041,22 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>   	pmu->default_config = perf_pmu__get_default_config(pmu);
>>   
>>   	return pmu;
>> +err:
>> +	if (pmu->name)
>> +		free(pmu->name);
>> +	free(pmu);
>> +	return NULL;
>>   }
>>   
>>   static struct perf_pmu *pmu_find(const char *name)
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
>> @@ -1919,6 +1950,9 @@ bool perf_pmu__has_hybrid(void)
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
