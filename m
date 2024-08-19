Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D6175D38
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079394; cv=none; b=KfKpY/7ADmWCErQSx2ovSk3ng1GOzUTziDg//GaN4FPwHSAWSImN5WptUmPBW8D3BoZhdVSJH0zHNcVJCbZfj7S2wY6Jvh6y62sUIqIOuIw8dm596ig2SK/Krtjkzpb7RHVle4j3BgI3KME1UyZ1QLAl6RUh1oxA1wfehiEPjps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079394; c=relaxed/simple;
	bh=m6Lbd1U8eB3Ekmm2HipipZMtXUArebtYkqA3T6GgcAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BAGZgmLXKnP1oouEdt1hMz1Bh+wAMQxktiAEAroA26HwPX4DvDTsFOY6VTfRPn+U3Ox8HOhVur7N5htMwtGKemAjZS11C1jb8jMIy+P61x6YIercSP2KmCI1/Ox+c5tph+3XxTH/2W7AlMAWHphHBGqgG6iN+ZCkRjly37Zbfy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Am0a0ZTw; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Am0a0ZTw"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f16767830dso48308151fa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Aug 2024 07:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724079390; x=1724684190; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JM59c779k9A5Ix0ziandjnofYroORXfacX93knOAgLw=;
        b=Am0a0ZTwc7fbUzFh/yFbNLRBNEOmTodVwa4GvIgeTNXLYcM8zoYMg0+HzrONv3gfeQ
         DW6NPFnQ8OSMEh7BD6snSs3bBW0GwmegMGODYT2ard/q/bHmkkIRb2vD0L7oJscsYjjf
         vQYiYj2ITCTr0fZMkLBCSaicHOf7UxyN0xR4g6Rdv7q6/cDId4kl9fOM2iwN2n7Y9Sj4
         JvuPIfbGOrY19cCgrr03Yy6o4pngYFV4RVyPQuPhu4+3x7aM0pVf/zMVvlCQgK0Ni9Yz
         h13S8IgKO+Mkt06nNC0nyBDyqurPTlwNhLcagJatRfj9wzDnYpYhlKP76LJbSWyE2FCW
         Hrsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724079390; x=1724684190;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JM59c779k9A5Ix0ziandjnofYroORXfacX93knOAgLw=;
        b=rl/RpWRhjmbHOVl4+AVTYeN1K/q8l5BkwwYUFzrvDIY44YVtaltTHi8ZHPYYrKTbT7
         8AMbIzTxMol6/m8eB0V0Pop7G5dDQaPsMYRKWuBRRT3XSUJbdI67RUkQPusYUkC0n2pj
         0lu6xvZ9noo97nhz/tReeXPC9yJP9ZfvQ/p9yz2POWHd/pvevErpVSMTAEdxHEB/Fran
         R1yBOjLMIfa3zBU+B6aKau0LOEMDBTUJkKWUMkc8Oh03/7PgRZf5ytA4ColJuslO8GEq
         hLYta7bWePAQoOy48gZzwVpOrCCXTLvbumgEFBZyo0FhASuOjFC1sSJpI83+HSVQ44ba
         hGPw==
X-Forwarded-Encrypted: i=1; AJvYcCXnVoGfqO0jp9QOE3o6EzrDlhtQ+OifeATSeDLRWogYkCPGjr7O53ROXtTFUnjNeBstsnW18k3qe1Zi5i4e345DvLWWxEf7v9//AHseZyAMYw==
X-Gm-Message-State: AOJu0Yx87o9+s1tqHXIpXQmG3wJ9qJFy37iDRO54Ku6TVTF13/pKTHRL
	3aoxhc0AQ6lEA7+xpI0TiJDTVlhjmi8TecnOhJRRXdyK5/wMIpl/jgNC8V778o8=
X-Google-Smtp-Source: AGHT+IEhqAGu6HSyKB3/fepgVDrCilC+gjvcZG8WQ+oe3Y4rEIKh+7uFpKIAj0+wIFk+UY9AcDvGlg==
X-Received: by 2002:a2e:b353:0:b0:2ec:3d74:88ca with SMTP id 38308e7fff4ca-2f3be5988bemr62301571fa.25.1724079389434;
        Mon, 19 Aug 2024 07:56:29 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbde48a9sm5636436a12.25.2024.08.19.07.56.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 07:56:28 -0700 (PDT)
Message-ID: <f6067724-eec2-484a-ad15-e714d7f46e3f@linaro.org>
Date: Mon, 19 Aug 2024 15:56:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
To: Ian Rogers <irogers@google.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Clark <james.clark@arm.com>, "cc: Marc Zyngier" <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Atish Patra <atishp@rivosinc.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
 <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
 <CAP-5=fVSVe=C5dHaOV22+YOZ_JCD0mDoByoubSFY3w4au5zwQg@mail.gmail.com>
 <6cbd2f1d-2aea-486c-a3cb-bb6eb08d8bdc@linaro.org>
 <CAP-5=fXX10Jra-LogXL0M3O5OU_YpBaA=7S54upENzJ86Y5Hvw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fXX10Jra-LogXL0M3O5OU_YpBaA=7S54upENzJ86Y5Hvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 16/08/2024 4:30 pm, Ian Rogers wrote:
> On Fri, Aug 16, 2024 at 2:23 AM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 15/08/2024 6:29 pm, Ian Rogers wrote:
>>> On Wed, Aug 14, 2024 at 9:28 AM James Clark <james.clark@linaro.org> wrote:
>>>> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
>>>>> On 01.08.24 21:05, Ian Rogers wrote:
>>>>>> On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
>>>>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>>>
>>>>>>> [TLDR: This mail in primarily relevant for Linux kernel regression
>>>>>>> tracking. See link in footer if these mails annoy you.]
>>>>>>>
>>>>>>> On 22.11.23 00:43, Bagas Sanjaya wrote:
>>>>>>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
>>>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
>>>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
>>>>>>>
>>>>>>> #regzbot fix: perf parse-events: Make legacy events lower priority than
>>>>>>> sysfs/JSON
>>>>>>> #regzbot ignore-activity
>>>>>>
>>>>>> Note, this is still broken.
>>>>>
>>>>> Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
>>>>> this? Or is this a "we are screwed one way or another and someone has to
>>>>> bite the bullet" situation?
>>>>>
>>>>> Ciao, Thorsten
>>>>>
>>>>>> The patch changed the priority in the case
>>>>>> that you do something like:
>>>>>>
>>>>>> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
>>>>>>
>>>>>> but if you do:
>>>>>>
>>>>>> $ perf stat -e 'cycles' benchmark
>>>>>>
>>>>>> then the broken behavior will happen as legacy events have priority
>>>>>> over sysfs/json events in that case. To fix this you need to revert:
>>>>>> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
>>>>>> events over legacy"
>>>>>>
>>>>>> This causes some testing issues resolved in this unmerged patch series:
>>>>>> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
>>>>>>
>>>>>> There is a bug as the arm_dsu PMU advertises an event called "cycles"
>>>>>> and this PMU is present on Ampere systems. Reverting the commit above
>>>>>> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
>>>>>> __evlist__add_default") to fix ARM's BIG.little systems (opening a
>>>>>> cycles event on all PMUs not just 1) will cause the arm_dsu event to
>>>>>> be opened by perf record and fail as the event won't support sampling.
>>>>>>
>>>>>> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
>>>>>> fixes this by only opening the cycles event on core PMUs when choosing
>>>>>> default events.
>>>>>>
>>>>>> Rather than take this patch the revert happened as Linus runs the
>>>>>> command "perf record -e cycles:pp" (ie using a specified event and not
>>>>>> defaults) and considers it a regression in the perf tool that on an
>>>>>> Ampere system to need to do "perf record -e
>>>>>> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
>>>>>> will choose the cycles event correctly and with better precision the
>>>>>> pp for systems that support it, but it was still considered a
>>>>>> regression in the perf tool so the revert was made to happen. There is
>>>>>> a lack of perf testing coverage for ARM, in particular as they choose
>>>>>> to do everything in a different way to x86. The patch in question was
>>>>>> in the linux-next tree for weeks without issues.
>>>>>>
>>>>>> ARM/Ampere could fix this by renaming the event from cycles to
>>>>>> cpu_cycles, or by following Intel's convention that anything uncore
>>>>>> uses the name clockticks rather than cycles. This could break people
>>>>>> who rely on an event called arm_dsu/cycles/ but I imagine such people
>>>>>> are rare. There has been no progress I'm aware of on renaming the
>>>>>> event.
>>>>>>
>>>>>> Making perf not terminate on opening an event for perf record seems
>>>>>> like the most likely workaround as that is at least something under
>>>>>> the tool maintainers control. ARM have discussed doing this on the
>>>>>> lists:
>>>>>> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
>>>>>> but since the revert in v6.10 no patches have appeared for the v6.11
>>>>>> merge window. Feature work like coresight improvements and ARMv9 are
>>>>>> being actively pursued by ARM, but feature work won't resolve this
>>>>>> regression.
>>>>>>
>>>>
>>>> I got some hardware with the DSU PMU so I'm going to have a go at trying
>>>> to send some fixes for this. My initial idea was to try incorporate the
>>>> "not terminate on opening" change as discussed in the link directly
>>>> above. And then do the revert of the "revert of prefer sysfs/json".
>>>
>>> Thanks, I think this would be good. The biggest issue is that none of
>>> the record logic expects a file descriptor to be not opened, deleting
>>> unopened evsels from the evlist breaks all the indexing into the
>>> mmaps, etc. Tbh, you probably wouldn't do the code this way if was
>>> written afresh. Perhaps a hashmap would map from an evsel to ring
>>> buffer mmaps, etc. Trying to avoid having global state and benefitting
>>> from encapsulation. I'd focus on just doing the expedient thing in the
>>> changes, which probably just means making the record code tolerant of
>>> evsels that fail to open and not modifying the evlist due to the risk
>>> it breaks the indices.
>>>
>>
>> Thanks for the tips.
>>
>>> (To point out the obvious, this work wouldn't be necessary if arm_dsu
>>> event were renamed from "cycles" to "cpu_cycles" which would also make
>>> it more intention revealing alongside the arm_dsu's "bus_cycles" event
>>> name).
>>>
>>
>> I understand but I can imagine the following conversation if we rename that:
>>
>>     User: "I updated my kernel and now my (non Perf) tool fails to open
>>            the DSU cycles event because it doesn't exist anymore"
>>
>>     Linus/maintainers: "Oh ok yes that was a userspace breaking change,
>>                        lets revert it"
>>
>> Just because Perf can handle 3 different names for cycles doesn't mean
>> other tools can.
> 
> cycles was a bad event name, dsu is a terrible name for what is mainly
> the l3 cache, the risk that the two are combined get broken I'm fine
> with as neoverse users with uncore permissions are say much rarer than
> Apple M users. Having a cycles and a bus_cycles event is already
> ambiguous, they sound the same. Renaming cycles to cpu_cycles would be
> best.
> 
>>>> FWIW I don't think Juno currently is broken if the kernel supports
>>>> extended type ID? I could have missed some output in this thread but it
>>>> seems like it's mostly related to Apple M hardware. I'm also a bit
>>>> confused why the "supports extended type" check fails there, but maybe
>>>> the v6.9 commit 25412c036 from Mark is missing?
>>>
>>> So I think your later emails clarify Arnaldo is probably missing:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/drivers/perf/arm_pmu.c?h=perf-tools-next&id=5c816728651ae425954542fed64d21d40cb75a9f
>>>
>>> Fwiw, the Apple M hardware issue came to me by way of Mark Rutland
>>> (iirc), this regression report, etc. My understanding is that Apple M
>>> has something like a v2 ARM PMU and the legacy events are encoded
>>> incorrectly in the driver for this. The regression in v6.5 happened
>>
>> I'm not sure about that. The M PMU events may be incomplete, but the two
>> that are there have a mapping that looks sane:
>>
>>     static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
>>          PERF_MAP_ALL_UNSUPPORTED,
>>          [PERF_COUNT_HW_CPU_CYCLES]      = M1_PMU_PERFCTR_CPU_CYCLES,
>>          [PERF_COUNT_HW_INSTRUCTIONS]    = M1_PMU_PERFCTR_INSTRUCTIONS,
>>          /* No idea about the rest yet */
>>     };
>>
>> And they map to the same named events:
>>
>>     static struct attribute *m1_pmu_event_attrs[] = {
>>          M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CPU_CYCLES),
>>          M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INSTRUCTIONS),
>>          NULL,
>>     };
>>
>> So in this case I can't see using legacy vs sysfs events making a
>> difference. Maybe there is some other case that was mentioned in a
>> previous thread that I missed though.
> 
> No idea, iirc Mark Rutland requested not to use legacy events for Apple M.
> 

The point I was trying to make here was that there isn't _technically_ 
any user facing bug on Apple M with both a new kernel and new perf, 
despite the issues Mark mentioned.

I think there's a bit more subtlety in Mark's request. Using sysfs is 
only required for old kernels that don't support extended type ID, and 
it's not specific to apple M, that's for everywhere. The other case he 
mentioned was when the events are slightly different but with the same 
name as legacy, which isn't the case here specifically but is already 
fixed by  ("perf parse-events: Make legacy events lower priority than 
sysfs/JSON") (v6.8).

>>> because ARM's core PMUs had previously been treated as uncore PMUs,
>>> meaning we wouldn't try to program legacy events on them. Fixing the
>>> handling of ARM's core PMUs broke Apple M due to the broken legacy
>>> event mappings. Why not fix the Apple M PMU driver? Well there was
>>> anyway a similar RISC-V issue reported by Atish Patra (iirc) where the
>>> RISC-V PMU driver wants to delegate the mapping of legacy events to
>>> the perf tool so the driver needn't be aware of all and future RISC-V
>>> configurations. The fix discussed with Mark, Atish, etc. has been to
>>> swap the priority of legacy and sysfs/json events so that the latter
>>> has priority. We need the revert of the revert as currently we only do
>>> this if a PMU is specified with an event, not for the general wildcard
>>> PMUs case that most people use. There was huge fallout from flipping
>>
>> Yep makes sense to do the revert if RISC-V isn't going to support any
>> legacy events. Although from what I understand that would technically
>> only require JSON to be the highest priority? Because putting named
>> events in sysfs still requires kernel involvement so doesn't get you any
>> further than supporting the legacy events?
> 
> The sysfs and json event handling is interwoven, for example you can
> add to a sysfs event with json information. There are basically two
> approaches in the event parser, hardcoded legacy things and event
> names (optionally with PMU names). I'm trying to get rid of the
> hardcoded legacy things as they were fine when you had a single core
> type, but I want to have events everywhere - say instructions and
> cycles on a GPU so we can IPC on a GPU. For RISC-V as long as the
> legacy events are covered as names in json and json/sysfs has priority
> over legacy then things will be fine.
> 
>> Seems like there is another reason to do the revert though as Mark
>> mentioned: That now directly specifying the PMU eg "-e
>> arm_cortex_a56/cycles/" opens a legacy event if the event matches one,
>> which is not the best thing to do. But the revert fixes this AFAIK, so
>> while having the priority JSON/legacy/sysfs might work for RISC-V it
>> wouldn't work for a platform that wants a slightly different sysfs event
>> than legacy but with the same name. And the priority should be
>> JSON/sysfs/legacy.
> 
> The priority for events with a PMU is the sysfs/json has a priority
> over legacy names, so I don't understand what you're saying here. Your
> example shouldn't be broken. The revert is for the case where no PMU
> is specified, where the priority is the opposite which is at best
> inconsistent.
> 

Yep you're right, I got confused with the original bug report which is 
now old. With commit a24d9d9dc ("perf parse-events: Make legacy events 
lower priority than sysfs/JSON") (v6.8) named PMUs do prioritize sysfs.

>>> the priority particularly on Intel as all test expectations needed
>>> updating. I've sent out similar fixes that need incorporating when the
>>> revert is reverted. Ideally tools/perf/tests/parse-events.c would be
>>> updated to cover ARM's PMUs that don't follow the normal pattern that
>>> the core PMU is called "cpu" (this would mean that we were testing
>>> event parsing on ARM was WAI wrt encoding priorities, BIG.little,
>>> etc).
>>>
>>>> I sent a small fix the other day to make perf stat default arguments
>>>> work on Juno, and didn't notice anything out of the ordinary:
>>>> https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e54ca43f6@linaro.org/T/#t
>>>> I agree that change is quite narrow but it does incrementally improve
>>>> things for the time being. It's possible that it would become redundant
>>>> if I can just include Ian's change to use strings for Perf stat.
>>>
>>> I'd prefer we didn't merge this as we'd need to rebase:
>>> https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/
>>> and those changes would then delete the code introduced. I'm fine with
>>> adding the tests.
>>>
>>> There are more exotic heterogeneous core things upcoming, probably
>>> also from ARM, and the thought of duplicating the default attribute
>>> logic and event parsing constraints is just something I'd prefer not
>>> to have to do.
>>>
>>
>> Yep I don't have any strong feelings about this. Even if we don't merge
>> it it helped me understand the code and the issue a bit.
>>
>> I think one thing I assumed about your change was that there was some
>> dependency on these other changes. But the more I look at it I think
>> it's actually fine on it's own?
> 
> Which change? If the change is trying to use "cycles" to open on all
> PMUs because it will be wild carded then it will run into the priority
> issue.
> 

Just patch 3 here: 
https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/

I assume it works because we don't open on uncore right now. But I'm 
still rebasing and testing it. So we could merge that, and then when we 
do the priority revert along with the fix to ignore the DSU error it 
will continue to work.

>> Using the cycles string actually works today, even on Apple M. The only
>> real remaining issue is softening the error for failure to open, but
>> that's _after_ doing the revert of the revert and is separate.
>>
>> I will re-test that one today with fresh eyes.
> 
> Perhaps it is other legacy events, not cycles and instructions. There
> must have been a reason for this regression report but I don't have an
> Apple M CPU to test on.
> 

This regression report is for various (admittedly extremely confusing) 
combinations of kernels and perfs without the following patches:

5c81672865 ("arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability")
    (v6.6 kernel release)

25412c036 ("perf print-events: make is_event_supported() more robust")
    (v6.9 Perf release for Apple M)

a24d9d9dc ("perf parse-events: Make legacy events lower priority than
             sysfs/JSON")
    (v6.8 Perf)

With all of those applied everything is fixed even on Apple M. I don't 
think anything needs to be fixed for the bare "-e cycles" that you 
mentioned at the beginning of the chain because that never regressed, it 
actually never worked on big.LITTLE until 5c81672865, and after that 
using legacy was fine. I don't think Mark actually wants bare "cycles" 
to _not_ use legacy either because it never did. He only mentioned what 
happens when you really do want to target a PMU with a name (already 
fixed in a24d9d9dc).

> Thanks,
> Ian
