Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03656C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB2D261B6F
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Nov 2021 15:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbhKOP4i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Nov 2021 10:56:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4095 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhKOP4g (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Nov 2021 10:56:36 -0500
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HtDCl2dwkz686dD;
        Mon, 15 Nov 2021 23:49:55 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 16:53:36 +0100
Received: from [10.47.82.31] (10.47.82.31) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 15 Nov
 2021 15:53:35 +0000
Subject: Re: [PATCH] perf tools: Enable warnings through HOSTCFLAGS
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, <jolsa@redhat.com>,
        <masahiroy@kernel.org>, Laura Abbott <labbott@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <irogers@google.com>
References: <1635525041-151876-1-git-send-email-john.garry@huawei.com>
 <YYbXMd3N4+aXYLTJ@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <591edce2-5aaa-22bc-6fd3-5a247f623eb3@huawei.com>
Date:   Mon, 15 Nov 2021 15:53:33 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <YYbXMd3N4+aXYLTJ@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.82.31]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 06/11/2021 19:27, Arnaldo Carvalho de Melo wrote:
> Em Sat, Oct 30, 2021 at 12:30:41AM +0800, John Garry escreveu:
>> The tools build system uses KBUILD_HOSTCFLAGS symbol for obvious purposes.
>>
>> However this is not set for anything under tools/
>>
>> As such, host tools apps built have no compiler warnings enabled.
>>
>> Declare HOSTCFLAGS for perf tools build, and also use that symbol in
>> declaration of host_c_flags. HOSTCFLAGS comes from EXTRA_WARNINGS, which
>> is independent of target platform/arch warning flags.
>>
>> Suggested-by: Jiri Olsa <jolsa@redhat.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> --
>> Using HOSTCFLAGS, as opposed to KBUILD_HOSTCFLAGS, is going opposite
>> direction to commit 96f14fe738b6 ("kbuild: Rename HOSTCFLAGS to
>> KBUILD_HOSTCFLAGS"), so would like further opinion from Laura and
>> Masahiro.
> 
> Laura's redhat e-mail bouncedm updated it to her kernel.org one, Laura,
> Masahiro, would you please comment? Jiri?

Any opinion on this one? Shall I just resend ... ? or just apply it if 
no one cares too much :)

Thanks,
John

> 
> - Arnaldo
>   
>> diff --git a/tools/build/Build.include b/tools/build/Build.include
>> index 2cf3b1bde86e..c2a95ab47379 100644
>> --- a/tools/build/Build.include
>> +++ b/tools/build/Build.include
>> @@ -99,7 +99,7 @@ cxx_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(CXXFLAGS) -D"BUILD_STR(s)=\#s" $(CXX
>>   ###
>>   ## HOSTCC C flags
>>   
>> -host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(KBUILD_HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
>> +host_c_flags = -Wp,-MD,$(depfile) -Wp,-MT,$@ $(HOSTCFLAGS) -D"BUILD_STR(s)=\#s" $(HOSTCFLAGS_$(basetarget).o) $(HOSTCFLAGS_$(obj))
>>   
>>   # output directory for tests below
>>   TMPOUT = .tmp_$$$$
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 4a9baed28f2e..9b95ba09657f 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -17,6 +17,7 @@ detected     = $(shell echo "$(1)=y"       >> $(OUTPUT).config-detected)
>>   detected_var = $(shell echo "$(1)=$($(1))" >> $(OUTPUT).config-detected)
>>   
>>   CFLAGS := $(EXTRA_CFLAGS) $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>> +HOSTCFLAGS := $(filter-out -Wnested-externs,$(EXTRA_WARNINGS))
>>   
>>   include $(srctree)/tools/scripts/Makefile.arch
>>   
>> @@ -211,6 +212,7 @@ endif
>>   ifneq ($(WERROR),0)
>>     CORE_CFLAGS += -Werror
>>     CXXFLAGS += -Werror
>> +  HOSTCFLAGS += -Werror
>>   endif
>>   
>>   ifndef DEBUG
>> @@ -292,6 +294,9 @@ CXXFLAGS += -ggdb3
>>   CXXFLAGS += -funwind-tables
>>   CXXFLAGS += -Wno-strict-aliasing
>>   
>> +HOSTCFLAGS += -Wall
>> +HOSTCFLAGS += -Wextra
>> +
>>   # Enforce a non-executable stack, as we may regress (again) in the future by
>>   # adding assembler files missing the .GNU-stack linker note.
>>   LDFLAGS += -Wl,-z,noexecstack
>> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
>> index a3966f290297..8ca656aa8b06 100644
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
>> -- 
>> 2.17.1
> 

