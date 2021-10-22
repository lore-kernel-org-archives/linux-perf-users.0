Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED73DC433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 09:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE80260F02
	for <linux-perf-users@archiver.kernel.org>; Fri, 22 Oct 2021 09:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbhJVJob (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 22 Oct 2021 05:44:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4020 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhJVJob (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Oct 2021 05:44:31 -0400
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HbK6101Khz67mB7;
        Fri, 22 Oct 2021 17:38:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 11:42:12 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 10:42:11 +0100
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
To:     Jiri Olsa <jolsa@redhat.com>
CC:     <peterz@infradead.org>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mingo@redhat.com>, <irogers@google.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kjain@linux.ibm.com>, <james.clark@arm.com>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
 <YXFhr2YoVp9GPsDM@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <86aee893-0b6b-bce3-d1aa-3b66365592d1@huawei.com>
Date:   Fri, 22 Oct 2021 10:42:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YXFhr2YoVp9GPsDM@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml731-chm.china.huawei.com (10.201.108.82) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 21/10/2021 13:48, Jiri Olsa wrote:
>> +HOSTCFLAGS += -Wall
>> +HOSTCFLAGS += -Wextra
>> +
>>   # Enforce a non-executable stack, as we may regress (again) in the future by
>>   # adding assembler files missing the .GNU-stack linker note.
>>   LDFLAGS += -Wl,-z,noexecstack
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index 7df13e74450c..118bcdc70bb4 100644
>> --- a/tools/perf/Makefile.perf
>> +++ b/tools/perf/Makefile.perf
>> @@ -226,7 +226,7 @@ else
>>   endif
>>   
>>   export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
>> -export HOSTCC HOSTLD HOSTAR
>> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
>>   
>>   include $(srctree)/tools/build/Makefile.include
>>   
>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>> index a055dee6a46a..d5c287f069a2 100644
>> --- a/tools/perf/pmu-events/Build
>> +++ b/tools/perf/pmu-events/Build
>> @@ -1,7 +1,7 @@
>>   hostprogs := jevents
>>   
>>   jevents-y	+= json.o jsmn.o jevents.o
>> -HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
>> +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
> so the the host cflags are made of:
> 
> host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
> 

ok, so IIRC, then the rule for building .o from .c in 
tools/build/Makefile.build will pick up HOSTCFLAGS through this 
variable, so we then don't need to explicitly mention it in the 
per-target rule, so can have this as before in pmu-events/Build

HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include

right?

(Indeed I guess that we can get rid of -I$(srctree)/tools/include as well)

Thanks,
John


> can't you use KBUILD_HOSTCFLAGS?
> 
> also perhaps we could rename KBUILD_HOSTCFLAGS to HOSTCFLAGS?
> the name seems like leftover from kbuild move
> 
> jirka
> 
>>   pmu-events-y	+= pmu-events.o
>>   JDIR		=  pmu-events/arch/$(SRCARCH)
>>   JSON		=  $(shell [ -d $(JDIR) ] &&	



