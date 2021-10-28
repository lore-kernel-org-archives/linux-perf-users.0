Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B5BC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0ED610CF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 08:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhJ1I03 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:26:29 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4035 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1I03 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 04:26:29 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hfz4B2whkz6H6r9;
        Thu, 28 Oct 2021 16:19:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Thu, 28 Oct 2021 10:23:59 +0200
Received: from [10.202.227.179] (10.202.227.179) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 09:23:59 +0100
Subject: Re: [PATCH v2 2/2] perf jevents: Enable warnings through HOSTCFLAGS
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "irogers@google.com" <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        "james.clark@arm.com" <james.clark@arm.com>
References: <1634807805-40093-1-git-send-email-john.garry@huawei.com>
 <1634807805-40093-3-git-send-email-john.garry@huawei.com>
 <YXFhr2YoVp9GPsDM@krava> <86aee893-0b6b-bce3-d1aa-3b66365592d1@huawei.com>
 <YXaXvGgvs4gr8Cgi@krava> <YXbZa8SaQta9pzHS@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <32d98804-7e56-e73b-4c66-8776dbf58ddf@huawei.com>
Date:   Thu, 28 Oct 2021 09:23:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YXbZa8SaQta9pzHS@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.179]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 25/10/2021 17:20, Arnaldo Carvalho de Melo wrote:
> Em Mon, Oct 25, 2021 at 01:40:44PM +0200, Jiri Olsa escreveu:
>> On Fri, Oct 22, 2021 at 10:42:11AM +0100, John Garry wrote:
>>> On 21/10/2021 13:48, Jiri Olsa wrote:
>>>>> +HOSTCFLAGS += -Wall
>>>>> +HOSTCFLAGS += -Wextra
>>>>> +
>>>>>    # Enforce a non-executable stack, as we may regress (again) in the future by
>>>>>    # adding assembler files missing the .GNU-stack linker note.
>>>>>    LDFLAGS += -Wl,-z,noexecstack
>>>>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>>>>> index 7df13e74450c..118bcdc70bb4 100644
>>>>> --- a/tools/perf/Makefile.perf
>>>>> +++ b/tools/perf/Makefile.perf
>>>>> @@ -226,7 +226,7 @@ else
>>>>>    endif
>>>>>    export srctree OUTPUT RM CC CXX LD AR CFLAGS CXXFLAGS V BISON FLEX AWK
>>>>> -export HOSTCC HOSTLD HOSTAR
>>>>> +export HOSTCC HOSTLD HOSTAR HOSTCFLAGS
>>>>>    include $(srctree)/tools/build/Makefile.include
>>>>> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
>>>>> index a055dee6a46a..d5c287f069a2 100644
>>>>> --- a/tools/perf/pmu-events/Build
>>>>> +++ b/tools/perf/pmu-events/Build
>>>>> @@ -1,7 +1,7 @@
>>>>>    hostprogs := jevents
>>>>>    jevents-y	+= json.o jsmn.o jevents.o
>>>>> -HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
>>>>> +HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include $(HOSTCFLAGS)
>>>> so the the host cflags are made of:
>>>>
>>>> host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
>>>>
>>>
>>> ok, so IIRC, then the rule for building .o from .c in
>>> tools/build/Makefile.build will pick up HOSTCFLAGS through this variable, so
>>> we then don't need to explicitly mention it in the per-target rule, so can
>>> have this as before in pmu-events/Build
>>>
>>> HOSTCFLAGS_jevents.o	= -I$(srctree)/tools/include
>>>
>>> right?
>>>
>>> (Indeed I guess that we can get rid of -I$(srctree)/tools/include as well)
>>
>> hm, the -I.. should stay no? I don't see that
>> it's being added soem other way
>>
>> jirka
>>
> 
> Probably this change from KBUILD_HOSTCFLAGS back to HOSTCFLAGS should
> come with this;
> 
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Fixes: 96f14fe738b69dd9 ("kbuild: Rename HOSTCFLAGS to KBUILD_HOSTCFLAGS")
> 
> Right?

Maybe, but then renaming back from KBUILD_HOSTCFLAGS -> HOSTCFLAGS seems 
odd as a fix

Anyway, now that this original series is in perf/core, I'll send patches 
on top with this change, cc'ing Laura and Masahiro

Thanks!
