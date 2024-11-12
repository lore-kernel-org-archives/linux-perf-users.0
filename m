Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB77F477
	for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421325; cv=none; b=NRek/UsH/5R3mvKmbs8LJDJdxblC5MXt7uxiRo6VqXZWQLgXEcVpq0lNAr5W5oL2Qv6r3Ob5/qaFJYrlrFQ3FzOhDqvZI5gD4VfPYhNalqToax9VoDO6dW8VhoNfeT2lNEAOPUKoQEOznn4PEL2Ib4Uc23ep3yBx0F5p1ckqNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421325; c=relaxed/simple;
	bh=lDuxJWHUECOGu4iQOy08f4vLoe6c1BG43n3js22eo1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bl64qJ9FvBrk+oG/TKsbK89dJpJF8d91/P1zCtvgm3dTodRzzGxUlQ/zMfReoZ+cUgf0r3aUSVx9cfzsofattWQr+IPJOBCLKRSfWB32uGxz6AGVfDeeo6aK6HmYGA7zMiwsUZe8kSFwDeVXtLfehxcEfD3j6BbEFbOWCFlSeCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uVADMHq0; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uVADMHq0"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a4031f69fso938630766b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 12 Nov 2024 06:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731421322; x=1732026122; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=49JuiSy/r9JLkYwGyXAh5iEnbRjgdRPZ+au2eZbNRrI=;
        b=uVADMHq0/JMfwYFY2RayQhvHGdseR/rWCSKrfkG/NTmr8NMQkWOI2OTli/gHrqmHOh
         DeCxm7IxpY2kH2HyV/L5XtjRcZhTFb4NyqigHjJ6eKgmje32AS0fs9ZGSUs/qNS4tXSb
         8y3RzEEVoKpNKMOsR73jOW4QRepfS21CqAGmdINFf1/pmUCRx/KCoHOo2/BIDN5Iu212
         pu54uWz7jvLDGeDG5K0Soyhh65zgLh/+YKYHU2OIKjMMQCw+p1kbfn21msaFlXqvBf14
         CCbIe2tTftWmxiHYIiVJr1uVbphrHy9+yEN0y6Nien4kINiEmpgIsuITMS4H8MLvcOfh
         OU+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731421322; x=1732026122;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49JuiSy/r9JLkYwGyXAh5iEnbRjgdRPZ+au2eZbNRrI=;
        b=fhxxIhmDa4uh4FuZ9jztE1nLbA0lOCVA2UY0a7E6jU4BSWj1vBimz8fsaD37swuSqL
         mjrXSZheuvdoRkQjNv0GmLCYhkMnBWsOWH5MdFaVkwki1kBvWkR8WPe9qZfUft8Wp0sk
         ql7U6HskMQoe4dzoruGPN5JANFrwBEVts7l0BDqqe/NFncL/ko/3ons3h87nM5Bku5FU
         lGe+4YRSJ6Eea2eYdC8JTD7QaSGOqGgyebfp26WQO6bk4Wpzac1+G2CFGD9FjsuGNAlW
         o0v3Qz+pPqZbLhhJeUzmHXsj2+Y7cRGsMbqIthriaazLzkeI+a2pNQnQSJY3IMsyDWyT
         pcrw==
X-Gm-Message-State: AOJu0Yz9g1ItivPlbsd+B1Q3Pwyaitjjz1yOSy0XReJPSZCMjAgAUcgz
	Y7eNlagzFPhe5v07GWdNX66qmfgu4fa7pgJKF2GYWieUlzGo1FtjCjRtp/aVRic=
X-Google-Smtp-Source: AGHT+IETG01+m8sMSTYwKq7b6sSqzvzRvRFfCsmVZ8PvUWed37xWW7mS4gNJ68o4jFFPFcrEK3vkmw==
X-Received: by 2002:a17:907:7f28:b0:a9a:825:4c39 with SMTP id a640c23a62f3a-a9eeff0daacmr1578407566b.20.1731421321912;
        Tue, 12 Nov 2024 06:22:01 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a18539sm734101166b.27.2024.11.12.06.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 06:22:01 -0800 (PST)
Message-ID: <ccac5d65-b01f-4624-97cd-e350ce6de840@linaro.org>
Date: Tue, 12 Nov 2024 14:21:59 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
To: Ian Rogers <irogers@google.com>, Atish Kumar Patra <atishp@rivosinc.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ben Gainey <ben.gainey@arm.com>, Junhao He <hejunhao3@huawei.com>,
 linux-riscv@lists.infradead.org, beeman@rivosinc.com,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>
References: <20241026121758.143259-1-irogers@google.com>
 <CAP-5=fXf9HtqKZyvfXNbKLTB-dL_Ax5Hd0_Gn1J-y0T1SE9wLQ@mail.gmail.com>
 <78eb729c-7594-460f-9d79-97fb683d8b5e@linaro.org>
 <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
 <d9bfd75a-003a-4f65-abba-b8bcaad13682@linaro.org>
 <CAP-5=fUHjxL5QbsyQQU-3EYiVhiO6wt=F5MfSfDcAffKP7WWAg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fUHjxL5QbsyQQU-3EYiVhiO6wt=F5MfSfDcAffKP7WWAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/2024 5:19 pm, Ian Rogers wrote:
> On Mon, Nov 11, 2024 at 2:45 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 08/11/2024 6:37 pm, Atish Kumar Patra wrote:
>>> On Fri, Nov 8, 2024 at 4:16 AM James Clark <james.clark@linaro.org> wrote:
>>>>
>>>>
>>>>
>>>> On 07/11/2024 18:51, Ian Rogers wrote:
>>>>> On Sat, Oct 26, 2024 at 5:18 AM Ian Rogers <irogers@google.com> wrote:
>>>>>>
>>>>>> At the RISC-V summit the topic of avoiding event data being in the
>>>>>> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
>>>>>> events being the priority when no PMU is provided so that legacy
>>>>>> events maybe supported via json. Originally Mark Rutland also
>>>>>> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
>>>>>> M? processors, but James Clark more recently tested this and believes
>>>>>> the driver issues there may not have existed or have been resolved. In
>>>>>> any case, it is inconsistent that with a PMU event names avoid legacy
>>>>>> encodings, but when wildcarding PMUs (ie without a PMU with the event
>>>>>> name) the legacy encodings have priority.
>>>>>>
>>>>>> The patch doing this work was reverted in a v6.10 release candidate
>>>>>> as, even though the patch was posted for weeks and had been on
>>>>>> linux-next for weeks without issue, Linus was in the habit of using
>>>>>> explicit legacy events with unsupported precision options on his
>>>>>> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
>>>>>> where ARM decided to call the events bus_cycles and cycles, the latter
>>>>>> being also a legacy event name. ARM haven't renamed the cycles event
>>>>>> to a more consistent cpu_cycles and avoided the problem. With these
>>>>>> changes the problematic event will now be skipped, a large warning
>>>>>> produced, and perf record will continue for the other PMU events. This
>>>>>> solution was proposed by Arnaldo.
>>>>>>
>>>>>> Two minor changes have been added to help with the error message and
>>>>>> to work around issues occurring with "perf stat metrics (shadow stat)
>>>>>> test".
>>>>>>
>>>>>> The patches have only been tested on my x86 non-hybrid laptop.
>>>>>
>>>>> Hi Atish and James,
>>>>>
>>>>> Could I get your tags for this series?
>>>>>
>>>
>>> Hi Ian,
>>> Thanks for your patches. It definitely helps to have a clean slate
>>> implementation
>>> for the perf tool. However, I have some open questions about other use cases
>>> that we discussed during the RVI Summit.
>>>
>>>>> The patches were originally motivated by wanting to make the behavior
>>>>> of events parsed like "cycles" match that of "cpu/cycles/", the PMU is
>>>>> wildcarded to "cpu" in the first case. This was divergent because of
>>>>> ARM we switched from preferring legacy (type = PERF_TYPE_HARDWARE,
>>>>> config = PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=<core PMU's
>>>>> type>, config=<encoding from event>) when a PMU name was given. This
>>>>> aligns with RISC-V wanting to use json encodings to avoid complexity
>>>>> in the PMU driver.
>>>>>
>>>>
>>>> I couldn't find the thread, but I remember fairly recently it was
>>>> mentioned that RISC-V would be supporting the legacy events after all,
>>>> maybe it was a comment from Atish? I'm not sure if that changes the
>>>> requirements for this or not?
>>>>
>>>> I still can't really imagine how tooling would work if every tool has to
>>>> maintain the mappings of basic events like instructions and branches.
>>>> For example all the perf_event_open tests in ltp use the legacy events.
>>>>
>>>
>>> No it has not changed. While this series helps to avoid clunky vendor
>>> specific encodings
>>> in the driver for perf tool, I am still unsure how we will manage
>>> other applications
>>> (directly passing legacy events through perf_event_open or
>>> perf_evlist__open) will work.
>>>
>>> I have only anecdotal data about folks relying perf legacy events
>>> directly to profile
>>> their application. All of them use mostly cycle/instruction events though.
>>> Are there any users who use other legacy events directly without perf tool ?
>>>
>>> If not, we may have only cycle/instruction mapping in the driver and
>>> rely on json for everything else.
>>> The other use case is virtualization. I have been playing with these
>>> patches to find a clean solution to
>>> enable all the use cases. If you have any other ideas, please let me know.
>>>
>>
>> Yeah I would expect it's mostly cycles and instructions. I searched a
>> bit for PERF_COUNT_HW_BRANCH_MISSES and only found tool/developer type
>> usages, which I suppose we could expect to have to handle the mappings
>> like perf. Although it's not the easiest thing to search for and
>> obviously that only includes open source.
>>
>> Usages do exist though, there are people posting on stack overflow using
>> it, and other various bug tracker listings. So you would expect those
>> same users to have to use raw event codes and some switch statement to
>> pick the right one for their hardware, or use Perf.
> 
> I don't have any magic to solve this. My thoughts:
> 
> 1) I thought legacy events were just going to hang around forever,
> although the name hinting they'd kind of been deprecated. At LPC '23
> Atish and Mark Rutland originally asked for the sysfs/json to be the
> preference. I thought Kan was going to push back given the upheaval,
> especially updating every test expectation. It went through but we're
> in this weird state where wildcard events are encoded using legacy and
> PMU specifying events aren't. What this series hopes to solve.
> 
> 2) I think it is important that perf tool be a reference
> implementation where others can look (strace, etc.) to base their
> implementation. Moving perf to sysfs/json is 1 step closer to legacy
> event deprecation. Please yell if deprecation isn't what is wanted as
> personally other than cleanliness I don't mind. If we do decide not to
> have sysfs/json be the priority then I think it sensible to revert the
> changes making it the priority for events that specify a PMU. I'd like
> some level of consistency.

Personally this change feels like it's encouraging fragmentation, the 
cleanest would be if RISC-V supports the legacy events like the other 
platforms. It's not a huge set of events anyway, and then existing 
software continues to work in addition to Perf continuing to work.

If we're still thinking that RISC-V will support the legacy events 
anyway in the future, then it weakens the argument to change this and 
risk any breakages that fall out of it.

I'm also not sure whether they really are legacy or just a common base 
set of events. Since the extended type thing was added even the legacy 
events support hybrid, so it's not like they expired from lack of 
features. Even if we claim they're legacy, is that really ever going to 
make them go away?

Although I admit nobody has come out with a definitive use case that 
doesn't use either the cycles or instructions events, so maybe its all fine.

> 
> 3) I'd like event parsing to be a library that is as easy to link
> against as libbpf (i.e. not a viral license). Event parsing is really
> just mapping an event name to 1 or more perf_event_attr. The PMU
> abstraction is tied into the event parsing, but this has only been
> more true recently. The evsel/evlist is tied into event parsing but
> that feels separable. As most json isn't distributed under a viral
> license this feels achievable, then I suspect most tools can use this
> library rather than have to reinvent a wheel.
> 
> Still looking for tags :-)
> 
> Thanks,
> Ian

