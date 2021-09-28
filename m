Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74AC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 13:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA62761139
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Sep 2021 13:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbhI1Naq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:30:46 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3884 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhI1Nap (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 28 Sep 2021 09:30:45 -0400
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HJgJR16hZz67kg2;
        Tue, 28 Sep 2021 21:26:31 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 15:29:04 +0200
Received: from [10.47.85.67] (10.47.85.67) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 28 Sep
 2021 14:29:03 +0100
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <3949dfa2-d684-47af-ffa7-71b07141f64d@huawei.com>
Date:   Tue, 28 Sep 2021 14:32:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YVMXHM0F/y2ptX8C@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.85.67]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/09/2021 14:22, Arnaldo Carvalho de Melo wrote:
>   jevents-y      += json.o jsmn.o jevents.o
> -HOSTCFLAGS_jevents.o   = -I$(srctree)/tools/include
> +HOSTCFLAGS_jevents.o   = -I$(srctree)/tools/include -Wall -Wextra
>   pmu-events-y   += pmu-events.o
>   JDIR           =  pmu-events/arch/$(SRCARCH)
>   JSON           =  $(shell [ -d $(JDIR) ] &&                            \
> ⬢[acme@toolbox perf]$
> 
> I get this before applying Xu's patch:
> 
>    LINK    /tmp/build/perf/libbpf.a
> pmu-events/jevents.c: In function ‘save_arch_std_events’:
> pmu-events/jevents.c:473:39: warning: unused parameter ‘data’ [-Wunused-parameter]
>    473 | static int save_arch_std_events(void *data, struct json_event *je)
>        |                                 ~~~~~~^~~~
> At top level:
> pmu-events/jevents.c:93:13: warning: ‘free_sys_event_tables’ defined but not used [-Wunused-function]
>     93 | static void free_sys_event_tables(void)
>        |             ^~~~~~~~~~~~~~~~~~~~~
> 
> 
> -------------------------------------
> 
> I'll add this to perf/core, as this isn't a strict fix, so can wait for
> v5.16.

Hi Arnaldo,

OK, would you also consider reusing CFLAGS:

--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -9,10 +9,12 @@ JSON          =  $(shell [ -d $(JDIR) ] && 
                \
JDIR_TEST      =  pmu-events/arch/test
JSON_TEST      =  $(shell [ -d $(JDIR_TEST) ] &&                       \
                        find $(JDIR_TEST) -name '*.json')
-
+HOSTCFLAGS_jevents += $(CFLAGS)

I tried it, and there are more things to fix for jevents.o. Let me know 
your preference and if any help required to fix any errors up.

Thanks!
