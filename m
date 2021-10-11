Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4780C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 17:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9289860F3A
	for <linux-perf-users@archiver.kernel.org>; Mon, 11 Oct 2021 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhJKRDC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 13:03:02 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3965 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJKRDA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 11 Oct 2021 13:03:00 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HSlMx1p68z67fKq;
        Tue, 12 Oct 2021 00:57:33 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 19:00:58 +0200
Received: from [10.47.95.202] (10.47.95.202) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 18:00:57 +0100
Subject: perf tools jevents build flags (was Re: [PATCH] perf jevents: Fix
 sys_event_tables to be freed like arch_std_events)
From:   John Garry <john.garry@huawei.com>
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
 <bd98c9f3-de67-7ca5-534c-f7fd6cc69915@huawei.com>
Message-ID: <e5c0123b-31d2-5f07-52a4-724ae89747c1@huawei.com>
Date:   Mon, 11 Oct 2021 18:03:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <bd98c9f3-de67-7ca5-534c-f7fd6cc69915@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.95.202]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 28/09/2021 21:30, John Garry wrote:
>>>
>>> OK, would you also consider reusing CFLAGS:
>>>
>>> --- a/tools/perf/pmu-events/Build
>>> +++ b/tools/perf/pmu-events/Build
>>> @@ -9,10 +9,12 @@ JSON          =  $(shell [ -d $(JDIR) ] &&
>>> \
>>> JDIR_TEST      =  pmu-events/arch/test
>>> JSON_TEST      =  $(shell [ -d $(JDIR_TEST) ] &&                       \
>>>                         find $(JDIR_TEST) -name '*.json')
>>> -
>>> +HOSTCFLAGS_jevents += $(CFLAGS)
>> Humm, we have to check if CFLAGS doesn't come with cross-build options,
>> i.e. IIRC we have to use HOSTCFLAGS instead. Unsure if there is some
>> *CFLAGS variable that gets the common part, where these -Wall and
>> -Wextra, -Werror could go.
> 
> not sure. As I see, the bulk of flags we have in CFLAGS comes from 
> EXTRA_WARNINGS in scripts/Makefile.include; but CFLAGS seems to also 
> include EXTRA_CLAGS, which are for cross-builds (see perf/Makefile.config)
> 

Hi Arnaldo,

I'm just looking at enabling warning cflags for jevents again.

So how about this:

--->8----


Subject: [PATCH] perf pmu-events: Enable jevents warnings through HOSTCFLAGS


diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ae2e3d8b832..65934984f032 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> 
$(OUTPUT).config-detected)
  detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)

  CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
+HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))

  include $(srctree)/tools/scripts/Makefile.arch

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7df13e74450c..118bcdc70bb4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -226,7 +226,7 @@ else
  endif

  export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
-export HOSTCC HOSTLD HOSTAR
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS

  include $(srctree)/tools/build/Makefile.include

diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index a055dee6a46a..d5c287f069a2 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,7 @@
  hostprogs := jevents

  jevents-y	+= json.o jsmn.o jevents.o
-HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
+HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
  pmu-events-y	+= pmu-events.o
  JDIR		=  pmu-events/arch/$(SRCARCH)
  JSON		=  $(shell [ -d $(JDIR) ] &&				\
-- 
2.26.2

---8<---

The newly generated warnings in jevents.c are pretty straightforward to 
tidy up.

Thanks,
John
