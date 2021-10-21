Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFCFC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B16611F2
	for <linux-perf-users@archiver.kernel.org>; Thu, 21 Oct 2021 15:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhJUPwg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 21 Oct 2021 11:52:36 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4018 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhJUPwe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 21 Oct 2021 11:52:34 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HZsK54kcGz67wr9;
        Thu, 21 Oct 2021 23:46:17 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 17:50:10 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 21 Oct 2021 16:50:10 +0100
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
Message-ID: <f4330522-f36e-21f4-5967-0ef67de7418f@huawei.com>
Date:   Thu, 21 Oct 2021 16:50:09 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YXFhr2YoVp9GPsDM@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
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
> can't you use KBUILD_HOSTCFLAGS?

Maybe. However, it seems to be empty when building perf/pmu-events. Even 
in building tools/objtool - which currently references it - it is empty 
AFAICS. I'm not sure if it's being imported properly.

Thanks,
John

> 
> also perhaps we could rename KBUILD_HOSTCFLAGS to HOSTCFLAGS?
> the name seems like leftover from kbuild move

