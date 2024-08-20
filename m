Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8918A92F
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724144292; cv=none; b=OkIu5+4en1VljEVy9xMZj6mFDFInePZxkBBecE3M0cp1tu9zSZjnmuJ/LqRJfveJ6Oede9SjdgPt3sWKl25syItp2PhwAUocDqe4/NScTY8FZN1uCSdsme24gNq+lqq3HAIrO2SOZjaT053c4SxZXLs/AWQBf+bAvazdd8JDqho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724144292; c=relaxed/simple;
	bh=Nn6lToXjCLBUIz9mPmdCv9pONWpqarqMr82oNo/1kEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lw90n/Duj4oLHySJH90FoKKeihN8iLZO+yEewTHDOJT3xpUgYehhPKicxOvZurTvfeXu8/Z8kquI/toEIbc+JSV5DPi9liHmKwqtuuwM4epWl3Pe2baoPLR6t+6dtzHdrspYGE765vck930cZ4RJKvp4VTElQi3k8ElfwKkZ378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vvyn5Byw; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vvyn5Byw"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so378347266b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Aug 2024 01:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724144288; x=1724749088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GjIeCVxVL/L5LzkDpW1Nn64LN86LnITHRGCTH6jvrdg=;
        b=vvyn5BywgAWDdM4a3QrdKyrA3ykBPn2kopjW9BzHhtnDpnnoO+ySBEsTo3szH6r4JV
         yOdVE6kBi7yl6Fc/9vtpaZ7FVa8R31LCNBMvobEpAmj2MLODgZLnisywAdvuWjz3OyzG
         SXQyzL7Fw1ACMgpROopZeQskhMRC96lopgWxcuqZ/xTz9OFrQ/4gHziQCJLXvAvFjCCE
         X/Vv4spJMbjabC2BWazOpyTOKf+CaTtkUUvqMsBS0TdZWJREyaNC+7vuPP3B23nQax3f
         bxk1SNm6oQ4y4at/xVDv04wMxc702+uDkG9oPn8SWN8nZA1qEGmqamsAEEJFeItVeFKf
         Xs9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724144288; x=1724749088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjIeCVxVL/L5LzkDpW1Nn64LN86LnITHRGCTH6jvrdg=;
        b=QGqbAKp3GcxV203XD/RjEtUkOU0eofgKZs4pW/bb7bYCqK4PCMlfc28as83VKD2kmB
         SkC7W2e49ZxaKtSIJeIj3t3OnguCRQvRlCOmpBEvk8bomnhscMRLKLFTYzJ5y82Y4zcm
         vsPVtpwMN1RV9AplLYwt6DkIwdwX5K258fNv7DPug771WdDW/q7tzxVYjIxyoYYYyXHv
         r1E+NIVUOfH6Fm14fDwphxXTuAbyVkUBSft+gl5+yIuKJ7zpxNvEBZECLUkxPFfGAaXQ
         uI6iZQE4hHOkrPThI9SIeO6VYD0/sqE8Oe6NuuHj7fjcIMyGz1U80SSbGwv289QKZ6yL
         +hMQ==
X-Forwarded-Encrypted: i=1; AJvYcCV630Aj7gJ1VMK3dMY4GLqiKQ6/6dnFSvCz1noR0dJodzlmz2tdlVxwCcvrcuYqrwWgD+Gxc7GgusuFaZ+xNMzW@vger.kernel.org
X-Gm-Message-State: AOJu0YyIx7XCM7w29kbV6CDSiZdx9AktQrRXslk5hAnufUF2dDWJKhPW
	jU/nHs/gUJet15Ce6VcGttVh6qBkdvf4/5v2SDCi/O3d1wcfKw0x+FuH526tva4=
X-Google-Smtp-Source: AGHT+IE+Z+OTlESB+rPa6O5pfSTCelawOC5oEgQzUUerQ26h7Uh+ksIcV7mTpa9Wx7DyTWPGnCLbvQ==
X-Received: by 2002:a17:907:efe5:b0:a77:c84b:5a60 with SMTP id a640c23a62f3a-a839292f6d0mr1048226766b.26.1724144287627;
        Tue, 20 Aug 2024 01:58:07 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946441sm741107066b.148.2024.08.20.01.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 01:58:07 -0700 (PDT)
Message-ID: <6ff76e96-ac29-454d-9134-5b120c8e5854@linaro.org>
Date: Tue, 20 Aug 2024 09:58:06 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
To: Atish Kumar Patra <atishp@rivosinc.com>, Ian Rogers <irogers@google.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Clark <james.clark@arm.com>, "cc: Marc Zyngier" <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
 <CAP-5=fVSVe=C5dHaOV22+YOZ_JCD0mDoByoubSFY3w4au5zwQg@mail.gmail.com>
 <6cbd2f1d-2aea-486c-a3cb-bb6eb08d8bdc@linaro.org>
 <CAP-5=fXX10Jra-LogXL0M3O5OU_YpBaA=7S54upENzJ86Y5Hvw@mail.gmail.com>
 <CAHBxVyGz5Cjd_QH4AWWZ=cQnQ0KKCJeLcT+aKO5QUxpGegdRLw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAHBxVyGz5Cjd_QH4AWWZ=cQnQ0KKCJeLcT+aKO5QUxpGegdRLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 17/08/2024 2:38 am, Atish Kumar Patra wrote:
> On Fri, Aug 16, 2024 at 8:30 AM Ian Rogers <irogers@google.com> wrote:
>>
>> On Fri, Aug 16, 2024 at 2:23 AM James Clark <james.clark@linaro.org> wrote:
>>>
>>>
>>>
>>> On 15/08/2024 6:29 pm, Ian Rogers wrote:
>>>> On Wed, Aug 14, 2024 at 9:28 AM James Clark <james.clark@linaro.org> wrote:
>>>>> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
>>>>>> On 01.08.24 21:05, Ian Rogers wrote:
>>>>>>> On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
>>>>>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>>
>>>>>>>> [TLDR: This mail in primarily relevant for Linux kernel regression
>>>>>>>> tracking. See link in footer if these mails annoy you.]
>>>>>>>>
>>>>>>>> On 22.11.23 00:43, Bagas Sanjaya wrote:
>>>>>>>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
>>>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
>>>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
>>>>>>>>
>>>>>>>> #regzbot fix: perf parse-events: Make legacy events lower priority than
>>>>>>>> sysfs/JSON
>>>>>>>> #regzbot ignore-activity
>>>>>>>
>>>>>>> Note, this is still broken.
>>>>>>
>>>>>> Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
>>>>>> this? Or is this a "we are screwed one way or another and someone has to
>>>>>> bite the bullet" situation?
>>>>>>
>>>>>> Ciao, Thorsten
>>>>>>
>>>>>>> The patch changed the priority in the case
>>>>>>> that you do something like:
>>>>>>>
>>>>>>> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
>>>>>>>
>>>>>>> but if you do:
>>>>>>>
>>>>>>> $ perf stat -e 'cycles' benchmark
>>>>>>>
>>>>>>> then the broken behavior will happen as legacy events have priority
>>>>>>> over sysfs/json events in that case. To fix this you need to revert:
>>>>>>> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
>>>>>>> events over legacy"
>>>>>>>
>>>>>>> This causes some testing issues resolved in this unmerged patch series:
>>>>>>> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
>>>>>>>
>>>>>>> There is a bug as the arm_dsu PMU advertises an event called "cycles"
>>>>>>> and this PMU is present on Ampere systems. Reverting the commit above
>>>>>>> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
>>>>>>> __evlist__add_default") to fix ARM's BIG.little systems (opening a
>>>>>>> cycles event on all PMUs not just 1) will cause the arm_dsu event to
>>>>>>> be opened by perf record and fail as the event won't support sampling.
>>>>>>>
>>>>>>> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
>>>>>>> fixes this by only opening the cycles event on core PMUs when choosing
>>>>>>> default events.
>>>>>>>
>>>>>>> Rather than take this patch the revert happened as Linus runs the
>>>>>>> command "perf record -e cycles:pp" (ie using a specified event and not
>>>>>>> defaults) and considers it a regression in the perf tool that on an
>>>>>>> Ampere system to need to do "perf record -e
>>>>>>> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
>>>>>>> will choose the cycles event correctly and with better precision the
>>>>>>> pp for systems that support it, but it was still considered a
>>>>>>> regression in the perf tool so the revert was made to happen. There is
>>>>>>> a lack of perf testing coverage for ARM, in particular as they choose
>>>>>>> to do everything in a different way to x86. The patch in question was
>>>>>>> in the linux-next tree for weeks without issues.
>>>>>>>
>>>>>>> ARM/Ampere could fix this by renaming the event from cycles to
>>>>>>> cpu_cycles, or by following Intel's convention that anything uncore
>>>>>>> uses the name clockticks rather than cycles. This could break people
>>>>>>> who rely on an event called arm_dsu/cycles/ but I imagine such people
>>>>>>> are rare. There has been no progress I'm aware of on renaming the
>>>>>>> event.
>>>>>>>
>>>>>>> Making perf not terminate on opening an event for perf record seems
>>>>>>> like the most likely workaround as that is at least something under
>>>>>>> the tool maintainers control. ARM have discussed doing this on the
>>>>>>> lists:
>>>>>>> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
>>>>>>> but since the revert in v6.10 no patches have appeared for the v6.11
>>>>>>> merge window. Feature work like coresight improvements and ARMv9 are
>>>>>>> being actively pursued by ARM, but feature work won't resolve this
>>>>>>> regression.
>>>>>>>
>>>>>
>>>>> I got some hardware with the DSU PMU so I'm going to have a go at trying
>>>>> to send some fixes for this. My initial idea was to try incorporate the
>>>>> "not terminate on opening" change as discussed in the link directly
>>>>> above. And then do the revert of the "revert of prefer sysfs/json".
>>>>
>>>> Thanks, I think this would be good. The biggest issue is that none of
>>>> the record logic expects a file descriptor to be not opened, deleting
>>>> unopened evsels from the evlist breaks all the indexing into the
>>>> mmaps, etc. Tbh, you probably wouldn't do the code this way if was
>>>> written afresh. Perhaps a hashmap would map from an evsel to ring
>>>> buffer mmaps, etc. Trying to avoid having global state and benefitting
>>>> from encapsulation. I'd focus on just doing the expedient thing in the
>>>> changes, which probably just means making the record code tolerant of
>>>> evsels that fail to open and not modifying the evlist due to the risk
>>>> it breaks the indices.
>>>>
>>>
>>> Thanks for the tips.
>>>
>>>> (To point out the obvious, this work wouldn't be necessary if arm_dsu
>>>> event were renamed from "cycles" to "cpu_cycles" which would also make
>>>> it more intention revealing alongside the arm_dsu's "bus_cycles" event
>>>> name).
>>>>
>>>
>>> I understand but I can imagine the following conversation if we rename that:
>>>
>>>     User: "I updated my kernel and now my (non Perf) tool fails to open
>>>            the DSU cycles event because it doesn't exist anymore"
>>>
>>>     Linus/maintainers: "Oh ok yes that was a userspace breaking change,
>>>                        lets revert it"
>>>
>>> Just because Perf can handle 3 different names for cycles doesn't mean
>>> other tools can.
>>
>> cycles was a bad event name, dsu is a terrible name for what is mainly
>> the l3 cache, the risk that the two are combined get broken I'm fine
>> with as neoverse users with uncore permissions are say much rarer than
>> Apple M users. Having a cycles and a bus_cycles event is already
>> ambiguous, they sound the same. Renaming cycles to cpu_cycles would be
>> best.
>>
>>>>> FWIW I don't think Juno currently is broken if the kernel supports
>>>>> extended type ID? I could have missed some output in this thread but it
>>>>> seems like it's mostly related to Apple M hardware. I'm also a bit
>>>>> confused why the "supports extended type" check fails there, but maybe
>>>>> the v6.9 commit 25412c036 from Mark is missing?
>>>>
>>>> So I think your later emails clarify Arnaldo is probably missing:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/drivers/perf/arm_pmu.c?h=perf-tools-next&id=5c816728651ae425954542fed64d21d40cb75a9f
>>>>
>>>> Fwiw, the Apple M hardware issue came to me by way of Mark Rutland
>>>> (iirc), this regression report, etc. My understanding is that Apple M
>>>> has something like a v2 ARM PMU and the legacy events are encoded
>>>> incorrectly in the driver for this. The regression in v6.5 happened
>>>
>>> I'm not sure about that. The M PMU events may be incomplete, but the two
>>> that are there have a mapping that looks sane:
>>>
>>>     static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
>>>          PERF_MAP_ALL_UNSUPPORTED,
>>>          [PERF_COUNT_HW_CPU_CYCLES]      = M1_PMU_PERFCTR_CPU_CYCLES,
>>>          [PERF_COUNT_HW_INSTRUCTIONS]    = M1_PMU_PERFCTR_INSTRUCTIONS,
>>>          /* No idea about the rest yet */
>>>     };
>>>
>>> And they map to the same named events:
>>>
>>>     static struct attribute *m1_pmu_event_attrs[] = {
>>>          M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CPU_CYCLES),
>>>          M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INSTRUCTIONS),
>>>          NULL,
>>>     };
>>>
>>> So in this case I can't see using legacy vs sysfs events making a
>>> difference. Maybe there is some other case that was mentioned in a
>>> previous thread that I missed though.
>>
>> No idea, iirc Mark Rutland requested not to use legacy events for Apple M.
>>
>>>> because ARM's core PMUs had previously been treated as uncore PMUs,
>>>> meaning we wouldn't try to program legacy events on them. Fixing the
>>>> handling of ARM's core PMUs broke Apple M due to the broken legacy
>>>> event mappings. Why not fix the Apple M PMU driver? Well there was
>>>> anyway a similar RISC-V issue reported by Atish Patra (iirc) where the
>>>> RISC-V PMU driver wants to delegate the mapping of legacy events to
>>>> the perf tool so the driver needn't be aware of all and future RISC-V
>>>> configurations. The fix discussed with Mark, Atish, etc. has been to
>>>> swap the priority of legacy and sysfs/json events so that the latter
>>>> has priority. We need the revert of the revert as currently we only do
>>>> this if a PMU is specified with an event, not for the general wildcard
>>>> PMUs case that most people use. There was huge fallout from flipping
>>>
>>> Yep makes sense to do the revert if RISC-V isn't going to support any
>>> legacy events. Although from what I understand that would technically
>>> only require JSON to be the highest priority? Because putting named
>>> events in sysfs still requires kernel involvement so doesn't get you any
>>> further than supporting the legacy events?
>>
>> The sysfs and json event handling is interwoven, for example you can
>> add to a sysfs event with json information. There are basically two
>> approaches in the event parser, hardcoded legacy things and event
>> names (optionally with PMU names). I'm trying to get rid of the
>> hardcoded legacy things as they were fine when you had a single core
>> type, but I want to have events everywhere - say instructions and
>> cycles on a GPU so we can IPC on a GPU. For RISC-V as long as the
>> legacy events are covered as names in json and json/sysfs has priority
>> over legacy then things will be fine.
>>
> 
> RISC-V does want to support legacy events as that's how users on other
> architectures are used to
> run perf. It would be weird if we don't support it.
> 
> Our initial reasoning behind relying on json for legacy events to
> avoid vendor specific encodings for these
> events in the driver. Unlike other ISAs, RISC-V ISA doesn't define an
> event encoding for these legacy
> events. As a result every platform vendor will have custom encoding.
> Managing them in the driver is
> cumbersome. Many thanks to Ian for posting the patches to reverse the
> priority which works fine for RISC-V.
> 
> However, I understand that it is easier said than done and some use
> cases are broken. We also discovered
> there are few other use cases which still have the same problem even
> if we solve the bigger problem via json parsing
> for legacy events.
> 
> 1. Any other user profiling application that invokes perf system calls
> directly may also try to just legacy event attributes in
> perf_event_attr.
> Android simpleperf application also falls in this category. We need to
> describe the platform specific encoding somewhere for these
> applications.
> 

I think this use case is important. Not just for profiling applications 
but even something that wants to monitor itself. I imagine opening 
PERF_COUNT_HW_CPU_CYCLES or INSRUCTIONS is actually somewhat common, and 
I don't think every application that wants to do perf system calls 
should have to maintain JSON mappings for all platforms. That doesn't 
sound feasible to me, unless there is a smart way to do it? Maybe the 
mappings could be in libperf or something? But then that still requires 
everyone to add that as a dependency and keep it up to date. By that 
point you might as well just add them in the kernel and keep the 
existing interface.

James
