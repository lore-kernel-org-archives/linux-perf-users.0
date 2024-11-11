Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53B12CD96
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321920; cv=none; b=cGKHElF9oDp0cEm5c35Zng6R+Mmm2+fR27jZO32AseiWgNzMNsWdKAEC9PsIWN/HKCvin5qZzRc9TX6Wx986ZjpI1jWxrw5gLztYrpcixqWCzEGmq1oOBlxSyGEbPMOyLzaueCdyewOKXYXlztwwwlxzM1sHE7bdC7DUnCnCm2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321920; c=relaxed/simple;
	bh=V7eDzomyG2wbZJW2GZeYX1VviYt30rqJ90VV+jRG/Zs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5d3XNjy1DxewUHbOGGUHoGSbzzgKEachTVnD+sxPuHfEHMZMm6SO3YVukslYZ4QxK0VBc1+Y9pT3/wvBpBvERS/qsb5wlYiZYnU6rbnp/OOkZfFOYbQDa73tl+lwWytWwpfaDaH7WYxGfR/4dn3wAqodh9CAq7MQ3RiMoCxWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pmwZQXuH; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmwZQXuH"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso35214465e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731321917; x=1731926717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vkcwa4qxyt5fJEDceQ9OcHMtoLSfOU/SlGySwxlpX90=;
        b=pmwZQXuHY0C5XN6/HG8a/Znp02CtMirkgt/gmZUvn2pgtAGtOOPRSeMhDAKzzwZC6w
         RMfICb2gAyj6n6VqWnjBdS3QRnqKxAGsqiu+6lp5m4FrZ+hxLeu49mDL90XudnV3rAnP
         XiiS9SaAb8eFapSjYFn0/JUdLzr1d3ZRZPImGjnCkHUtnISp6kc77ozRpgf8V9x4R/xO
         I2rGSXJ4n9t/tTk54wZEhrJ7bSppr5RYdTPxuPeT4fuT1pkEUR2729vntZlyMVkdp8UT
         EAG+uuVzhAlPp9vZEcnF5ETm1tFDsrert/MFRy8UcfOoo1EjW7dkw2K/F67p1tjQXWon
         qgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731321917; x=1731926717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vkcwa4qxyt5fJEDceQ9OcHMtoLSfOU/SlGySwxlpX90=;
        b=QX/vdZpW/9lhS0h5/tXNOyqlVKv0G0dil72cQJW7sZJ4lRPzAdPO50g+m1YV48E6Ix
         S/2oMs9ewNNIkFgkyG/HqpT/wD6RUT3LTbhKlNcGZZGU7qATF6GsTFZLEEzsYCk2Af5e
         nNADR8xFj/CJpHeb3L7NPaa3NzegJN2hdXQe3VmAQZWuWUniq3OnPRHQYLLzmcYaCCYS
         IHId2idRwIm38uTezAkJxzmziqPGr7/0EeXLC52CsNihlhR4ZnZ/8+MWrZGPx7EfRyqH
         ee+lGmLtmljnn6JrbC0sM+J+yJuitUORIemI7sYY+PGlnH/X3PSUnj+Qi2hZyI0ia/Rg
         3wZg==
X-Gm-Message-State: AOJu0YxcWe5cDnPlp3LXsg/8DxPaU1sIttic93xOLi1iMvkD7GIrVoOv
	G0h7Pce9tMSsUSRYbZ8HG6P0KggR2jksTtBoNJyrf58gKq1sBqluMlhzqpokwAs=
X-Google-Smtp-Source: AGHT+IEb5YEM4IHTW47uj3GCrDsg6lFCD+yW156W1Y2eOGScCTJOLJ+vRIrE7CeEoirSjK/dQhpA8g==
X-Received: by 2002:a05:600c:a04:b0:431:40ca:ce5d with SMTP id 5b1f17b1804b1-432b75172d6mr94146055e9.23.1731321917388;
        Mon, 11 Nov 2024 02:45:17 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1f8sm213572885e9.30.2024.11.11.02.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Nov 2024 02:45:17 -0800 (PST)
Message-ID: <d9bfd75a-003a-4f65-abba-b8bcaad13682@linaro.org>
Date: Mon, 11 Nov 2024 10:45:14 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
To: Atish Kumar Patra <atishp@rivosinc.com>, Ian Rogers <irogers@google.com>
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAHBxVyFXWpczMmWJbpWoLUjQ4nfNC2_h1yZqSd7kSr6N8Rvm5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 08/11/2024 6:37 pm, Atish Kumar Patra wrote:
> On Fri, Nov 8, 2024 at 4:16 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 07/11/2024 18:51, Ian Rogers wrote:
>>> On Sat, Oct 26, 2024 at 5:18 AM Ian Rogers <irogers@google.com> wrote:
>>>>
>>>> At the RISC-V summit the topic of avoiding event data being in the
>>>> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
>>>> events being the priority when no PMU is provided so that legacy
>>>> events maybe supported via json. Originally Mark Rutland also
>>>> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
>>>> M? processors, but James Clark more recently tested this and believes
>>>> the driver issues there may not have existed or have been resolved. In
>>>> any case, it is inconsistent that with a PMU event names avoid legacy
>>>> encodings, but when wildcarding PMUs (ie without a PMU with the event
>>>> name) the legacy encodings have priority.
>>>>
>>>> The patch doing this work was reverted in a v6.10 release candidate
>>>> as, even though the patch was posted for weeks and had been on
>>>> linux-next for weeks without issue, Linus was in the habit of using
>>>> explicit legacy events with unsupported precision options on his
>>>> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
>>>> where ARM decided to call the events bus_cycles and cycles, the latter
>>>> being also a legacy event name. ARM haven't renamed the cycles event
>>>> to a more consistent cpu_cycles and avoided the problem. With these
>>>> changes the problematic event will now be skipped, a large warning
>>>> produced, and perf record will continue for the other PMU events. This
>>>> solution was proposed by Arnaldo.
>>>>
>>>> Two minor changes have been added to help with the error message and
>>>> to work around issues occurring with "perf stat metrics (shadow stat)
>>>> test".
>>>>
>>>> The patches have only been tested on my x86 non-hybrid laptop.
>>>
>>> Hi Atish and James,
>>>
>>> Could I get your tags for this series?
>>>
> 
> Hi Ian,
> Thanks for your patches. It definitely helps to have a clean slate
> implementation
> for the perf tool. However, I have some open questions about other use cases
> that we discussed during the RVI Summit.
> 
>>> The patches were originally motivated by wanting to make the behavior
>>> of events parsed like "cycles" match that of "cpu/cycles/", the PMU is
>>> wildcarded to "cpu" in the first case. This was divergent because of
>>> ARM we switched from preferring legacy (type = PERF_TYPE_HARDWARE,
>>> config = PERF_COUNT_HW_CPU_CYCLES) to sysfs/json (type=<core PMU's
>>> type>, config=<encoding from event>) when a PMU name was given. This
>>> aligns with RISC-V wanting to use json encodings to avoid complexity
>>> in the PMU driver.
>>>
>>
>> I couldn't find the thread, but I remember fairly recently it was
>> mentioned that RISC-V would be supporting the legacy events after all,
>> maybe it was a comment from Atish? I'm not sure if that changes the
>> requirements for this or not?
>>
>> I still can't really imagine how tooling would work if every tool has to
>> maintain the mappings of basic events like instructions and branches.
>> For example all the perf_event_open tests in ltp use the legacy events.
>>
> 
> No it has not changed. While this series helps to avoid clunky vendor
> specific encodings
> in the driver for perf tool, I am still unsure how we will manage
> other applications
> (directly passing legacy events through perf_event_open or
> perf_evlist__open) will work.
> 
> I have only anecdotal data about folks relying perf legacy events
> directly to profile
> their application. All of them use mostly cycle/instruction events though.
> Are there any users who use other legacy events directly without perf tool ?
> 
> If not, we may have only cycle/instruction mapping in the driver and
> rely on json for everything else.
> The other use case is virtualization. I have been playing with these
> patches to find a clean solution to
> enable all the use cases. If you have any other ideas, please let me know.
> 

Yeah I would expect it's mostly cycles and instructions. I searched a 
bit for PERF_COUNT_HW_BRANCH_MISSES and only found tool/developer type 
usages, which I suppose we could expect to have to handle the mappings 
like perf. Although it's not the easiest thing to search for and 
obviously that only includes open source.

Usages do exist though, there are people posting on stack overflow using 
it, and other various bug tracker listings. So you would expect those 
same users to have to use raw event codes and some switch statement to 
pick the right one for their hardware, or use Perf.


