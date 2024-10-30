Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9132187FE4
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730256359; cv=none; b=NUP9Ol8J3MO6+Mif7kjW6X6HiRcaUAEG542eNn9XwNV6og+eiK2vSEddztlAMTIwnU6re1JhJ7R5OqGAksbbD1kWi6ipaBLbe4ODLAUYj5q6pOsRI3KZ/pqrsamffCryt0TLXoIW+VlHP27nfSA7bejjsKM92Jod7by29AeJzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730256359; c=relaxed/simple;
	bh=t525uk5UWlE76ONcjXQt5v06PNoUYs+MyqvcfGngJUU=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m0fhAqTWvD8L39L2zRdl0b8czq8IeUfD3aBbAC1iCZEOpjzWcg0Of3QoH7R4rHW+vVjRwfi2aJHWkoHcZMzsz+VZMKV5fEaAL6jayT8tZwz9PmglcXISJKgr+BXFqjmLlxYN5vNTZZwSB/ufSNFyQ5fCK99irdPw5IgVmg7R0FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XdWhj0nl9z1ync6;
	Wed, 30 Oct 2024 10:45:57 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 7607B1402E1;
	Wed, 30 Oct 2024 10:45:48 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 30 Oct 2024 10:45:47 +0800
CC: <yangyicong@hisilicon.com>, <acme@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <linux-perf-users@vger.kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <leo.yan@arm.com>,
	<amadio@gentoo.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
To: Namhyung Kim <namhyung@kernel.org>
References: <20241024133236.31016-1-yangyicong@huawei.com>
 <ZyF5_Hf1iL01kldE@google.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>
Date: Wed, 30 Oct 2024 10:45:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZyF5_Hf1iL01kldE@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/10/30 8:12, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Oct 24, 2024 at 09:32:36PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> When building with custom libtraceevent, below errors occur:
>> $ make -C tools/perf NO_LIBPYTHON=1 PKG_CONFIG_PATH=<custom libtraceevent>
>> In file included from util/session.h:5,
>>                  from builtin-buildid-list.c:17:
>> util/trace-event.h:153:10: fatal error: traceevent/event-parse.h: No such file or directory
>>   153 | #include <traceevent/event-parse.h>
>>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> <snip similar errors of missing headers>
>>
>> This is because the include path is missed in the cflags. Add it.
>>
>> Fixes: 0f0e1f445690 ("perf build: Use pkg-config for feature check for libtrace{event,fs}")
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>> Another problem occurs when building on my old Ubuntu 18.04.1 (4.15 kernel)
>> is that linux/mount.h (which is introduced in the later kernel version) is
>> missing. It's included in tools/include/uapi/linux/fs.h which header is
>> introduced recently. Does it make sense to have a copy of mount.h in tools/include?
>>
>>  tools/perf/Makefile.config | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 4ddb27a48eed..53fc5f787a77 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -1194,7 +1194,7 @@ endif
>>  ifneq ($(NO_LIBTRACEEVENT),1)
>>    $(call feature_check,libtraceevent)
>>    ifeq ($(feature-libtraceevent), 1)
>> -    CFLAGS += -DHAVE_LIBTRACEEVENT
>> +    CFLAGS += -DHAVE_LIBTRACEEVENT $(shell $(PKG_CONFIG) --cflags libtraceevent)
> 
> Does this solve the problem?  On my machine, it returns this:
> 
>   $ pkg-config --cflags libtraceevent
>   -I/usr/include/traceevent 
> 
>   $ ls /usr/include/traceevent/
>   event-parse.h  event-utils.h  kbuffer.h  trace-seq.h
> 
> So the include path should be "/usr/include" or we should include
> <event-parse.h> directly.  We may update the every include statements
> but just curious how it solved your problem.
> 

I think you're right, we should use the path according to the pkg-config outputs.
But it's a different problem, for me it's due to the missing of the include path
(my libtraceevent is not under the system path). With the fix you proposed and drop
the change in my patch:

$ PKG_CONFIG_PATH=/home/yangyicong/Community/libtraceevent/install/usr/local/lib/aarch64-linux-gnu/pkgconfig/ pkg-config --cflags-only-I libtraceevent
-I/home/yangyicong/Community/libtraceevent/install/usr/local/include/traceevent
$ PKG_CONFIG_PATH=/home/yangyicong/Community/libtraceevent/install/usr/local/lib/aarch64-linux-gnu/pkgconfig/ make -C tools/perf NO_LIBPYTHON=1
In file included from bench/../util/session.h:5,
                 from bench/synthesize.c:12:
bench/../util/trace-event.h:153:10: fatal error: event-parse.h: No such file or directory
  153 | #include <event-parse.h>
      |
[...]

Checked how we handle with libtracefs currently:
 ifeq ($(feature-libtracefs), 1)
    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs) # we've added the cflags from pkg-config
    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)

Thanks.

> Thanks,
> Namhyung
> 
> 
>>      LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtraceevent)
>>      EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtraceevent)
>>      LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent).0.0
>> -- 
>> 2.24.0
>>
> .
> 
