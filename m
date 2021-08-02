Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C6EC4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 03:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15E54610A0
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Aug 2021 03:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhHBDP7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 1 Aug 2021 23:15:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:13653 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231361AbhHBDP4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 1 Aug 2021 23:15:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10063"; a="200548069"
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; 
   d="scan'208";a="200548069"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 20:15:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,287,1620716400"; 
   d="scan'208";a="509810527"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 20:15:43 -0700
Subject: Re: [PATCH v3 1/2] perf pmu: Add PMU alias support
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com
References: <20210730070717.30997-1-yao.jin@linux.intel.com>
 <20210730070717.30997-2-yao.jin@linux.intel.com>
 <071252c1bcf72a3fddd5664ca82b05b6589957cc.camel@gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f44cef59-7ea3-f589-0fdc-919f687b9f5c@linux.intel.com>
Date:   Mon, 2 Aug 2021 11:15:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <071252c1bcf72a3fddd5664ca82b05b6589957cc.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Riccardo,

On 7/30/2021 4:28 PM, Riccardo Mancini wrote:
> Hi,
> 
> thanks for your quick revision.
> 
> There is still one small memory issue with a variable not being freed, which I
> noticed when running this patchset together with John's patchset.
> 
> On Fri, 2021-07-30 at 15:07 +0800, Jin Yao wrote:
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
>>   $ perf stat -e uncore_cha_2/event=1/ -x,
>>     4044879584,,uncore_cha_2/event=1/,2528059205,100.00,,
>>
>> Use the alias,
>>   $ perf stat -e uncore_type_0_2/event=1/ -x,
>>     3659675336,,uncore_type_0_2/event=1/,2287306455,100.00,,
>>
>> Co-developed-by: Jin Yao <yao.jin@linux.intel.com>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
>> v3:
>>   - Use fgets to read alias string from sysfs.
>>   - Resource cleanup.
>>
>> v2:
>>   - No change.
>>
>>   tools/perf/arch/x86/util/pmu.c | 129 ++++++++++++++++++++++++++++++++-
>>   tools/perf/util/parse-events.y |   3 +-
>>   tools/perf/util/pmu.c          |  26 ++++++-
>>   tools/perf/util/pmu.h          |   5 ++
>>   4 files changed, 158 insertions(+), 5 deletions(-)
>>
> <SNIP>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 44b90d638ad5..cc9af7942e7b 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -944,13 +944,28 @@ static int pmu_max_precise(const char *name)
>>          return max_precise;
>>   }
>>   
>> -static struct perf_pmu *pmu_lookup(const char *name)
>> +char * __weak
>> +pmu_find_real_name(const char *name)
>> +{
>> +       return strdup(name);
>> +}
>> +
>> +char * __weak
>> +pmu_find_alias_name(const char *name __maybe_unused)
>> +{
>> +       return NULL;
>> +}
>> +
>> +static struct perf_pmu *pmu_lookup(const char *lookup_name)
>>   {
>>          struct perf_pmu *pmu;
>> +       char *name;
>>          LIST_HEAD(format);
>>          LIST_HEAD(aliases);
>>          __u32 type;
>>   
>> +       name = pmu_find_real_name(lookup_name);
> 
> name is not freed if one of the following checks fails.
> 
> 	/*
> 	 * The pmu data we store & need consists of the pmu
> 	 * type value and format definitions. Load both right
> 	 * now.
> 	 */
> 	if (pmu_format(name, &format))
> 		return NULL;
> 
> 	/*
> 	 * Check the type first to avoid unnecessary work.
> 	 */
> 	if (pmu_type(name, &type))
> 		return NULL;
> 
> 	if (pmu_aliases(name, &aliases))
> 		return NULL;
> 
> Thanks,
> Riccardo
> 

Thanks so much for pointing this out. I also find I need to rebase the patch because it has some 
conflicts with John's patch. I will prepare v4 (which will be based on tmp.perf/urgent).

Thanks
Jin Yao

> 
>> @@ -973,7 +988,8 @@ static struct perf_pmu *pmu_lookup(const char *name)
>>                  return NULL;
>>   
>>          pmu->cpus = pmu_cpumask(name);
>> -       pmu->name = strdup(name);
>> +       pmu->name = name;
>> +       pmu->alias_name = pmu_find_alias_name(name);
>>          pmu->type = type;
>>          pmu->is_uncore = pmu_is_uncore(name);
>>          if (pmu->is_uncore)
>> @@ -1003,7 +1019,8 @@ static struct perf_pmu *pmu_find(const char *name)
>>          struct perf_pmu *pmu;
>>   
>>          list_for_each_entry(pmu, &pmus, list)
>> -               if (!strcmp(pmu->name, name))
>> +               if (!strcmp(pmu->name, name) ||
>> +                   (pmu->alias_name && !strcmp(pmu->alias_name, name)))
>>                          return pmu;
>>   
>>          return NULL;
>> @@ -1898,6 +1915,9 @@ bool perf_pmu__has_hybrid(void)
>>   
>>   int perf_pmu__match(char *pattern, char *name, char *tok)
>>   {
>> +       if (!name)
>> +               return -1;
>> +
>>          if (fnmatch(pattern, name, 0))
>>                  return -1;
>>   
>> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
>> index 926da483a141..f6ca9f6a06ef 100644
>> --- a/tools/perf/util/pmu.h
>> +++ b/tools/perf/util/pmu.h
>> @@ -21,6 +21,7 @@ enum {
>>   #define PERF_PMU_FORMAT_BITS 64
>>   #define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>>   #define CPUS_TEMPLATE_CPU      "%s/bus/event_source/devices/%s/cpus"
>> +#define MAX_PMU_NAME_LEN 128
>>   
>>   struct perf_event_attr;
>>   
>> @@ -32,6 +33,7 @@ struct perf_pmu_caps {
>>   
>>   struct perf_pmu {
>>          char *name;
>> +       char *alias_name;       /* PMU alias name */
>>          char *id;
>>          __u32 type;
>>          bool selectable;
>> @@ -135,4 +137,7 @@ void perf_pmu__warn_invalid_config(struct perf_pmu *pmu,
>> __u64 config,
>>   bool perf_pmu__has_hybrid(void);
>>   int perf_pmu__match(char *pattern, char *name, char *tok);
>>   
>> +char *pmu_find_real_name(const char *name);
>> +char *pmu_find_alias_name(const char *name);
>> +
>>   #endif /* __PMU_H */
> 
> 
