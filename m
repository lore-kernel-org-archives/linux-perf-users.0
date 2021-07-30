Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09209C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 01:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5E4561019
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Jul 2021 01:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhG3BrR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 21:47:17 -0400
Received: from mga09.intel.com ([134.134.136.24]:35175 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234986AbhG3BrR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 21:47:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="212999080"
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="212999080"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 18:47:13 -0700
X-IronPort-AV: E=Sophos;i="5.84,280,1620716400"; 
   d="scan'208";a="507551634"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 18:47:10 -0700
Subject: Re: [PATCH v2 2/2] perf tests: Test for PMU alias
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com
References: <20210729070619.20726-1-yao.jin@linux.intel.com>
 <20210729070619.20726-3-yao.jin@linux.intel.com>
 <f5f6f40b58c3d2151a4e899a109bd58764152758.camel@gmail.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <e478b5e3-6043-1ffb-440f-cd4c48a8d694@linux.intel.com>
Date:   Fri, 30 Jul 2021 09:47:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f5f6f40b58c3d2151a4e899a109bd58764152758.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Riccardo,

On 7/29/2021 9:15 PM, Riccardo Mancini wrote:
> Hi,
> 
> On Thu, 2021-07-29 at 15:06 +0800, Jin Yao wrote:
>> A perf uncore PMU may have two PMU names, a real name and an alias
>> name. Add one test case to verify the real name and alias name having
>> the same effect.
>>
>> Iterate the sysfs to get one event which has an alias and create
>> evlist by adding two evsels. Evsel1 is created by event and evsel2
>> is created by alias.
>>
>> Test asserts:
>> evsel1->core.attr.type == evsel2->core.attr.type
>> evsel1->core.attr.config == evsel2->core.attr.config
>>
>> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
>> ---
>> v2:
>>   - New in v2.
>>
>>   tools/perf/tests/parse-events.c | 79 +++++++++++++++++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>
>> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
>> index 56a7b6a14195..b416851e4074 100644
>> --- a/tools/perf/tests/parse-events.c
>> +++ b/tools/perf/tests/parse-events.c
>> @@ -6,6 +6,7 @@
>>   #include "tests.h"
>>   #include "debug.h"
>>   #include "pmu.h"
>> +#include "fncache.h"
>>   #include <dirent.h>
>>   #include <errno.h>
>>   #include <sys/types.h>
>> @@ -2190,9 +2191,79 @@ static int test_pmu_events(void)
>>          return ret;
>>   }
>>   
>> +static bool test_alias(char **event, char **alias)
>> +{
>> +       char path[PATH_MAX];
>> +       DIR *dir;
>> +       struct dirent *dent;
>> +       const char *sysfs = sysfs__mountpoint();
>> +       char buf[128];
>> +       FILE *file;
>> +
>> +       if (!sysfs)
>> +               return false;
>> +
>> +       snprintf(path, PATH_MAX, "%s/bus/event_source/devices/", sysfs);
>> +       dir = opendir(path);
>> +       if (!dir)
>> +               return false;
>> +
>> +       while ((dent = readdir(dir))) {
>> +               if (!strcmp(dent->d_name, ".") ||
>> +                   !strcmp(dent->d_name, ".."))
>> +                       continue;
>> +
>> +               snprintf(path, PATH_MAX,
>> "%s/bus/event_source/devices/%s/alias",
>> +                        sysfs, dent->d_name);
>> +
>> +               if (!file_available(path))
>> +                       continue;
>> +
>> +               file = fopen(path, "r");
>> +               if (!file)
>> +                       continue;
>> +
>> +               if (fscanf(file, "%s", buf) != 1) {
>> +                       fclose(file);
>> +                       continue;
>> +               }
> 
> ditto as in the first patch.
> 

Got it, thanks!

>> +
>> +               fclose(file);
>> +               *event = strdup(dent->d_name);
>> +               *alias = strdup(buf);
>> +               return true;
>> +       }
> 
> dir is never closed.
> 

Oh yes, should add "closedir(dir);" at the end of function.

Thanks
Jin Yao

> Thanks,
> Riccardo
> 
>> +
>> +       return false;
>> +}
>> +
>> +static int test__checkevent_pmu_events_alias(struct evlist *evlist)
>> +{
>> +       struct evsel *evsel1 = evlist__first(evlist);
>> +       struct evsel *evsel2 = evlist__last(evlist);
>> +
>> +       TEST_ASSERT_VAL("wrong type", evsel1->core.attr.type == evsel2-
>>> core.attr.type);
>> +       TEST_ASSERT_VAL("wrong config", evsel1->core.attr.config == evsel2-
>>> core.attr.config);
>> +       return 0;
>> +}
>> +
>> +static int test_pmu_events_alias(char *event, char *alias)
>> +{
>> +       struct evlist_test e = { .id = 0, };
>> +       char name[2 * NAME_MAX + 20];
>> +
>> +       snprintf(name, sizeof(name), "%s/event=1/,%s/event=1/",
>> +                event, alias);
>> +
>> +       e.name  = name;
>> +       e.check = test__checkevent_pmu_events_alias;
>> +       return test_event(&e);
>> +}
>> +
>>   int test__parse_events(struct test *test __maybe_unused, int subtest
>> __maybe_unused)
>>   {
>>          int ret1, ret2 = 0;
>> +       char *event, *alias;
>>   
>>   #define TEST_EVENTS(tests)                             \
>>   do {                                                   \
>> @@ -2217,6 +2288,14 @@ do
>> {                                                     \
>>                          return ret;
>>          }
>>   
>> +       if (test_alias(&event, &alias)) {
>> +               int ret = test_pmu_events_alias(event, alias);
>> +               free(event);
>> +               free(alias);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>>          ret1 = test_terms(test__terms, ARRAY_SIZE(test__terms));
>>          if (!ret2)
>>                  ret2 = ret1;
> 
> 
