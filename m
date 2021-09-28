Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A567C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 20:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2923B61209
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 20:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbhI1U3C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:29:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3886 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbhI1U3B (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 16:29:01 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HJrZk5t57z67Cp2;
        Wed, 29 Sep 2021 04:24:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 22:27:19 +0200
Received: from [10.47.26.77] (10.47.26.77) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 21:27:18 +0100
Subject: Re: [PATCH] perf jevents: Fix sys_event_tables to be freed like
 arch_std_events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210928102938.69681-1-likexu@tencent.com>
 <YVMB5kt8XG+OdJ1M@kernel.org>
 <c547bc2d-ab7c-1e89-5d12-bd5d875f7aa5@huawei.com>
 <YVMVwDt3QHBPfT/T@kernel.org> <YVMXHM0F/y2ptX8C@kernel.org>
 <3949dfa2-d684-47af-ffa7-71b07141f64d@huawei.com>
 <YVNXTuq1PpLpMH/R@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bd98c9f3-de67-7ca5-534c-f7fd6cc69915@huawei.com>
Date:   Tue, 28 Sep 2021 21:30:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YVNXTuq1PpLpMH/R@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.26.77]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/09/2021 18:56, Arnaldo Carvalho de Melo wrote:
>>>   ‘save_arch_std_events’:
>>> pmu-events/jevents.c:473:39: warning: unused parameter ‘data’ [-Wunused-parameter]
>>>     473 | static int save_arch_std_events(void *data, struct json_event *je)
>>>         |                                 ~~~~~~^~~~
>>> At top level:
>>> pmu-events/jevents.c:93:13: warning: ‘free_sys_event_tables’ defined but not used [-Wunused-function]
>>>      93 | static void free_sys_event_tables(void)
>>>         |             ^~~~~~~~~~~~~~~~~~~~~
>>>
>>>
>>> -------------------------------------
>>>
>>> I'll add this to perf/core, as this isn't a strict fix, so can wait for
>>> v5.16.
>> Hi Arnaldo,
>>
>> OK, would you also consider reusing CFLAGS:
>>
>> --- a/tools/perf/pmu-events/Build
>> +++ b/tools/perf/pmu-events/Build
>> @@ -9,10 +9,12 @@ JSON          =  $(shell [ -d $(JDIR) ] &&
>> \
>> JDIR_TEST      =  pmu-events/arch/test
>> JSON_TEST      =  $(shell [ -d $(JDIR_TEST) ] &&                       \
>>                         find $(JDIR_TEST) -name '*.json')
>> -
>> +HOSTCFLAGS_jevents += $(CFLAGS)
> Humm, we have to check if CFLAGS doesn't come with cross-build options,
> i.e. IIRC we have to use HOSTCFLAGS instead. Unsure if there is some
> *CFLAGS variable that gets the common part, where these -Wall and
> -Wextra, -Werror could go.

not sure. As I see, the bulk of flags we have in CFLAGS comes from 
EXTRA_WARNINGS in scripts/Makefile.include; but CFLAGS seems to also 
include EXTRA_CLAGS, which are for cross-builds (see perf/Makefile.config)

So maybe we just need to use EXTRA_WARNINGS for HOST_CFLAGS

>   
>> I tried it, and there are more things to fix for jevents.o. Let me know your
>> preference and if any help required to fix any errors up.
> I fixed the one I found, see below, I'll test build what I have in
> perf/core and push it, then you can continue from there, after checking
> this HOSTCFLAGS/CFLAGS issue.
> 
> - Arnaldo
> 
>>From 0e46c8307574a8e2dac8d7ba97e0f6f4bbee67a5 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo<acme@redhat.com>
> Date: Tue, 28 Sep 2021 14:15:01 -0300
> Subject: [PATCH 1/1] perf jevents: Add __maybe_unused attribute to unused
>   function arg
> 
> The tools/perf/pmu-events/jevents.c file isn't being compiled with
> -Werror and -Wextra, which will be the case soon, so before we turn
> those compiler flags on, fix what it would flag.
> 
> Cc: Alexander Shishkin<alexander.shishkin@linux.intel.com>
> Cc: Ingo Molnar<mingo@redhat.com>
> Cc: Jiri Olsa<jolsa@redhat.com>
> Cc: Like Xu<like.xu.linux@gmail.com>
> Cc: Mark Rutland<mark.rutland@arm.com>
> Cc: Namhyung Kim<namhyung@kernel.org>
> Cc: Peter Zijlstra<peterz@infradead.org>
> Signed-off-by: Arnaldo Carvalho de Melo<acme@redhat.com>
> To: John Garry<john.garry@huawei.com>

thanks.

Reviewed-by: John Garry <john.garry@huawei.com>

> ---
>   tools/perf/pmu-events/jevents.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
> index 6731b3cf0c2fc9b7..323e1dfe2436c049 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -45,6 +45,7 @@
>   #include <sys/resource.h>		/* getrlimit */
>   #include <ftw.h>
>   #include <sys/stat.h>
> +#include <linux/compiler.h>
>   #include <linux/list.h>
>   #include "jsmn.h"
>   #include "json.h"
> @@ -470,7 +471,7 @@ static void free_arch_std_events(void)
>   	}
>   }
>   
> -static int save_arch_std_events(void *data, struct json_event *je)
> +static int save_arch_std_events(void *data __maybe_unused, struct json_event *je)
>   {
>   	struct event_struct *es;

