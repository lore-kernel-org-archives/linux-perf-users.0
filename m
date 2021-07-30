Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FDDC4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 01:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFFB61019
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 01:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234730AbhG3BnY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 21:43:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:2632 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234495AbhG3BnT (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 21:43:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="213042952"
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="213042952"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 18:43:14 -0700
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="507550294"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 18:43:12 -0700
Subject: Re: [PATCH v2 1/2] perf pmu: Add PMU alias support
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
References: <20210729070619.20726-1-yao.jin@linux.intel.com>
 <20210729070619.20726-2-yao.jin@linux.intel.com>
 <862ca312fe2b500e2d26bbfdfdadec3d2a705ac1.camel@gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <dd732b63-76e4-8be8-ee54-958537163a21@linux.intel.com>
Date:   Fri, 30 Jul 2021 09:43:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <862ca312fe2b500e2d26bbfdfdadec3d2a705ac1.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Riccardo,

On 7/29/2021 9:13 PM, Riccardo Mancini wrote:
> Hi,
> 
> On Thu, 2021-07-29 at 15:06 +0800, Jin Yao wrote:
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
>> v2:
>>   - No change.
>>
>>   tools/perf/arch/x86/util/pmu.c | 109 ++++++++++++++++++++++++++++++++-
>>   tools/perf/util/parse-events.y |   3 +-
>>   tools/perf/util/pmu.c          |  26 +++++++-
>>   tools/perf/util/pmu.h          |   5 ++
>>   4 files changed, 138 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
>> index d48d608517fd..bb79b1d19b96 100644
>> --- a/tools/perf/arch/x86/util/pmu.c
>> +++ b/tools/perf/arch/x86/util/pmu.c
>> @@ -1,12 +1,28 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <string.h>
>> -
>> +#include <stdio.h>
>> +#include <sys/types.h>
>> +#include <dirent.h>
>> +#include <fcntl.h>
>>   #include <linux/stddef.h>
>>   #include <linux/perf_event.h>
>> +#include <linux/zalloc.h>
>> +#include <api/fs/fs.h>
>>   
>>   #include "../../../util/intel-pt.h"
>>   #include "../../../util/intel-bts.h"
>>   #include "../../../util/pmu.h"
>> +#include "../../../util/fncache.h"
>> +
>> +#define TEMPLATE_ALIAS "%s/bus/event_source/devices/%s/alias"
>> +
>> +struct perf_pmu_alias_name {
>> +       char *name;
>> +       char *alias;
>> +       struct list_head list;
>> +};
>> +
>> +static LIST_HEAD(pmu_alias_name_list);
>>   
>>   struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu
>> __maybe_unused)
>>   {
>> @@ -18,3 +34,94 @@ struct perf_event_attr *perf_pmu__get_default_config(struct
>> perf_pmu *pmu __mayb
>>   #endif
>>          return NULL;
>>   }
>> +
>> +static void setup_pmu_alias_list(void)
>> +{
>> +       char path[PATH_MAX];
>> +       DIR *dir;
>> +       struct dirent *dent;
>> +       const char *sysfs = sysfs__mountpoint();
>> +       struct perf_pmu_alias_name *pmu;
>> +       char buf[MAX_PMU_NAME_LEN];
>> +       FILE *file;
>> +
>> +       if (!sysfs)
>> +               return;
>> +
>> +       snprintf(path, PATH_MAX,
>> +                "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
>> +
>> +       dir = opendir(path);
>> +       if (!dir)
>> +               return;
>> +
>> +       while ((dent = readdir(dir))) {
>> +               if (!strcmp(dent->d_name, ".") ||
>> +                   !strcmp(dent->d_name, ".."))
>> +                       continue;
>> +
>> +               snprintf(path, PATH_MAX,
>> +                        TEMPLATE_ALIAS, sysfs, dent->d_name);
>> +
>> +               if (!file_available(path))
>> +                       continue;
>> +
>> +               file = fopen(path, "r");
>> +               if (!file)
>> +                       continue;
>> +
>> +               if (fscanf(file, "%s", buf) != 1)
>> +                       continue;
> 
> Using fscanf with "%s" can lead to a buffer overflow.
> It's better to use fgets, if possible, or to specify a maximum length (better if
> through a macro, e.g. "%" STR(MAX_PMU_NAME_LEN) "s").
> 
Yes, fgets should be better. I will use 'fgets(buf, sizeof(buf), file)' instead in v3.

>> +
>> +               pmu = zalloc(sizeof(*pmu));
>> +               if (!pmu)
>> +                       continue;
>> +
>> +               pmu->alias = strdup(buf);
>> +               if (!pmu->alias) {
>> +                       free(pmu);
>> +                       continue;
>> +               }
>> +               pmu->name = strdup(dent->d_name);
> 
> The result of strdup is not checked.
> It's also probably better to return an error in case of ENOMEM, instead of
> continuing iteration, as also previous checks do.
> 

Yes, strictly we should check the return value, I will fix that.

Thanks
Jin Yao

> Thanks,
> Riccardo
> 
>> +               list_add_tail(&pmu->list, &pmu_alias_name_list);
>> +               fclose(file);
>> +       }
>> +
>> +       closedir(dir);
>> +}
>> +
>> +static char *__pmu_find_real_name(const char *name)
>> +{
>> +       struct perf_pmu_alias_name *pmu;
>> +
>> +       list_for_each_entry(pmu, &pmu_alias_name_list, list) {
>> +               if (!strcmp(name, pmu->alias))
>> +                       return strdup(pmu->name);
>> +       }
>> +
>> +       return strdup(name);
>> +}
>> +
>> +char *pmu_find_real_name(const char *name)
>> +{
>> +       static bool cached_list;
>> +
>> +       if (cached_list)
>> +               return __pmu_find_real_name(name);
>> +
>> +       setup_pmu_alias_list();
>> +       cached_list = true;
>> +
>> +       return __pmu_find_real_name(name);
>> +}
>> +
>> +char *pmu_find_alias_name(const char *name)
>> +{
>> +       struct perf_pmu_alias_name *pmu;
>> +
>> +       list_for_each_entry(pmu, &pmu_alias_name_list, list) {
>> +               if (!strcmp(name, pmu->name))
>> +                       return strdup(pmu->alias);
>> +       }
>> +       return NULL;
>> +}
>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>> index 9321bd0e2f76..d94e48e1ff9b 100644
>> --- a/tools/perf/util/parse-events.y
>> +++ b/tools/perf/util/parse-events.y
>> @@ -316,7 +316,8 @@ event_pmu_name opt_pmu_config
>>                          if (!strncmp(name, "uncore_", 7) &&
>>                              strncmp($1, "uncore_", 7))
>>                                  name += 7;
>> -                       if (!perf_pmu__match(pattern, name, $1)) {
>> +                       if (!perf_pmu__match(pattern, name, $1) ||
>> +                           !perf_pmu__match(pattern, pmu->alias_name, $1)) {
>>                                  if (parse_events_copy_term_list(orig_terms,
>> &terms))
>>                                          CLEANUP_YYABORT;
>>                                  if (!parse_events_add_pmu(_parse_state, list,
>> pmu->name, terms, true, false))
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
>> +
>>          /*
>>           * The pmu data we store & need consists of the pmu
>>           * type value and format definitions. Load both right
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
