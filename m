Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3CD18D63E
	for <linux-perf-users@vger.kernel.org>; Wed,  7 Aug 2024 03:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000705; cv=none; b=nSPolRRE5ZObx542FrWCKjg0cnYXn1OcG9cgNl9pp7K0GQ2RLmxjPqAKqloZghUGBu0vsq576uHS75Xhwm9Ld+LGiS316bqC/oFKVjqNQ9ocjBTV/v9lE6zvUhELKy8x1VzB4CCQNe2DIHvvxkGDe6V+WAxT5yU2NOd0lvCtync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000705; c=relaxed/simple;
	bh=kLudHR9zWdtNCI6JY4gze8TzelxmZmAOYT96NkhlFOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=M05sVQJT2UA1/FQmGJ067l6G/oY3/Dh6j4fRwZ9+XT3kBtaDs8q95EhM5PGOqlFAcNEU9C/GdYeKa2mykhkO0j7eNCK/3Pf4LzJZPgbBIwPz9RtkesnGVZvHBV+d2QqZhfz7brS6TdveZOzxfSSPXhRf4XnutZzHyf1JXfdSuss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NjP/T7Vg; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NjP/T7Vg"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-260fed6c380so805988fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 06 Aug 2024 20:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000703; x=1723605503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fE2Eet5ycBOR0gve8hnkWEMsxXduyT8qepRNCtnfyQ4=;
        b=NjP/T7VgKXrd8tmg1R/8QEkTMqIw/9QSwo5hsPuwj/BoT4Gpxhi7uc9AcWkHKMtSB/
         papwSx3TbZCPToknQA01M0Ea5QfDBQ+F9d9Yz4NcR3ORQyF1r2h4EgwYobP5zyJH6WTH
         Jcn8MiRzi+uaJeTQmHMYWzYSOwHJ+EHnDP5OrFMTBWELUX85SdcVHMjsEepeCOb6Y6D+
         t678DjCJdUS2XAfoUkXXf+MD7p9MgwTCyzr8+SDxBgKubHfb7R+YPW3n+0yuyuEoLKVS
         VY05+BlLcHiXqnszoTJzB0pWVQpqKk8WtmVci/V26cTZcGQ9s96FpKylVM1mstH2g3rU
         rRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000703; x=1723605503;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fE2Eet5ycBOR0gve8hnkWEMsxXduyT8qepRNCtnfyQ4=;
        b=pD8lkFjNTwei6kLrH6RB8oKyf/7thI5AsyKxDhSSUKW06pvuhSf0EqqCJBFFt/seGw
         0T2AQlTUIe8si5lx2XGi8hgsShcU+OXUIHpjgy7yK30UyCAhmloztVDEfJoBva2uPh/o
         f1uG3N4E4+v6KeM049Y3A0J0qU/xUL1Tnv0MgyGI7Gonu5zlTILDxOmuD1wbL0w+DhrI
         ztgNFZonAHbUA/iVTW80ceP98A8jdq83iEqCMDUJ3OGk+urBKJFY8mNdNBkSkyczrgim
         cfv13kADpz+sgthHSikVBqYTRz9gJQEY4oy4RqiOSv/Oa5CYxXjlYMWCt2dm8r+5O+Wv
         8RYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0cAnJvLuSc0AoSVHEGWLAI+xRexZNmBj0+6GwxUt9kkjknlniXMxVH3SLnptZfw/yvcb5xngy/+VIeH05TcVrhGqHDn96c+M1qgIW8uKMSQ==
X-Gm-Message-State: AOJu0Ywo0efxcycjSI9Rdkl06mHX029adPkp3bxOQTOScmRmG+48p9Mm
	6zT15ngNXKr7Gfr+5+AcHyplWsdGqBQm94v9wS0TqIgkpiUqQgzJ24mDSWc/i9U=
X-Google-Smtp-Source: AGHT+IHbxAwiDPJlX+k/+E1BzkquXnhpCyIJ012NgXGz/j6wtGgw6uI4NaJcmNz3dgXMt7T/NScxyw==
X-Received: by 2002:a05:6870:e316:b0:250:7465:d221 with SMTP id 586e51a60fabf-26891d3a84cmr20931815fac.28.1723000702717;
        Tue, 06 Aug 2024 20:18:22 -0700 (PDT)
Received: from [10.70.146.105] ([203.208.189.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed3389bsm7543742b3a.213.2024.08.06.20.18.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:18:22 -0700 (PDT)
Message-ID: <a6ae5450-9293-40d2-a643-bb7c783e6c44@bytedance.com>
Date: Wed, 7 Aug 2024 11:18:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] perf: build: Fix build feature-dwarf_getlocations
 fail for old libdw
Content-Language: en-US
To: Leo Yan <leo.yan@arm.com>
References: <20240806114801.1652417-1-yangjihong@bytedance.com>
 <20240806114801.1652417-3-yangjihong@bytedance.com>
 <2e9a74b5-9403-425d-8d98-9469e290d297@arm.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Yang Jihong <yangjihong@bytedance.com>
In-Reply-To: <2e9a74b5-9403-425d-8d98-9469e290d297@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

On 8/7/24 05:28, Leo Yan wrote:
> On 8/6/2024 12:48 PM, Yang Jihong wrote:
>>
>> For libdw versions below 0.177, need to link libdl.a in addition to
>> libbebl.a during static compilation, otherwise feature-dwarf_getlocations
>> compilation will fail.
>>
>> Before:
>>
>>    $ make LDFLAGS=-static
>>      BUILD:   Doing 'make -j20' parallel build
>>    <SNIP>
>>    Makefile.config:483: Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.157
>>    <SNIP>
>>
>>    $ cat ../build/feature/test-dwarf_getlocations.make.output
>>    /usr/bin/ld: /usr/lib/gcc/x86_64-linux-gnu/9/../../../x86_64-linux-gnu/libebl.a(eblclosebackend.o): in function `ebl_closebackend':
>>    (.text+0x20): undefined reference to `dlclose'
>>    collect2: error: ld returned 1 exit status
> 
> Indeed. Thanks for pointing out this.
> 
>> After:
>>
>>    $ make LDFLAGS=-static
>>    <SNIP>
>>      Auto-detecting system features:
>>    ...                                   dwarf: [ on  ]
>>    <SNIP>
>>
>>      $ ./perf probe
>>     Usage: perf probe [<options>] 'PROBEDEF' ['PROBEDEF' ...]
>>        or: perf probe [<options>] --add 'PROBEDEF' [--add 'PROBEDEF' ...]
>>        or: perf probe [<options>] --del '[GROUP:]EVENT' ...
>>        or: perf probe --list [GROUP:]EVENT ...
>>    <SNIP>
>>
>> Fixes: 536661da6ea1 ("perf: build: Only link libebl.a for old libdw")
>> Signed-off-by: Yang Jihong <yangjihong@bytedance.com>
>> ---
>>   tools/build/feature/Makefile | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
>> index b18513ec4da6..1fc651cae9e5 100644
>> --- a/tools/build/feature/Makefile
>> +++ b/tools/build/feature/Makefile
>> @@ -179,7 +179,7 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
>>     # Elfutils merged libebl.a into libdw.a starting from version 0.177,
>>     # Link libebl.a only if libdw is older than this version.
>>     ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
>> -    DWARFLIBS += -lebl
>> +    DWARFLIBS += -lebl -ldl
>>     endif
> 
> One critical thing is the ordering of libs. We must put libdl after libebl,
> otherwise, the building still fails (based on my test).
> 
> Given libdl is a general lib, I think it is good to add a line after the
> `endif` wrapper and with a comment, something like:
> 
>     ifeq ($(shell test $(LIBDW_VERSION_2)0 -lt 1770; echo $$?),0)
>        DWARFLIBS += -lebl
>     endif
> 
>     # Must put -ldl after -lebl for dependency
>     DWARFLIBS += -ldl
> 
> Please update the file tools/perf/Makefile.config for consistency.

Okay, will change in next version.

Thanks,
Yang
