Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A8912E1CA
	for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800184; cv=none; b=CNl+mBusBACHAUALiHBZQ6vIAlBkLmVy8G0n1JNn0WT7aafBJR+35NiVa9H3MH9ZfAMJANYUtguWtwmOOHgNrPVFl01lFllDbS1QnVf50bUMrSqjQSSD6Emxr+1uLuYF2hoIEXk1N6VBKTsaGuDMwnA4MXSCzZNnWGjIZzJSSqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800184; c=relaxed/simple;
	bh=y/Ufg8tbL4666xoI4ZdID9NsMGGJE6VSVdMuySd39Nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+2TENdtzrHSCI+da4zkzy99FXhRCgFHHAdv3kSuV/LJbYijeKsmuhNc8uZTRNRn9nDJq25gw4gbIb6g2jq1Bv4GegMiKoZKdavhfs/Evz3HsNozHTVZ2+bCstJVKlbmxNkqdLC/5ecfL7PQk1M0uMa+hLDIP75QIsF+7li9cMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qJ6GsUdF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJ6GsUdF"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso17704035e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 16 Aug 2024 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723800180; x=1724404980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lxnIiPj4rgSgy4iPiln/v688IPneiwiyQTCsnmUVp+Q=;
        b=qJ6GsUdF9DmhtJuP9JjFcedam/b39zteY5SvbdjBIlpNx1zGCZ10JFkpWNzxnuzu6T
         En8Yyx3IfWGuE1iaIE91z0muXcUhRtWeRnC14ublcuK6yzwqtgH+0POCffVj8JU7wzJD
         AkvQ5iFTYSKasET6dus8gGjM1bsfhumtMFHvb5ZhVEPQfaG8BpVxCqOZuSZf/kovwh2R
         ALvvhzkQGpHRJb0Fp4BAvOLklPDq3AMw4O/6UhXce05yN+a9A6szGk/IN7PlX4Dp3zgY
         13QEtC2FaCv7dCV0uj/tbZFccQpWPnhI9Ew8BIIlnrkUpe8HJOhauRdbP3W+QRXN1Kl7
         5VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723800180; x=1724404980;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lxnIiPj4rgSgy4iPiln/v688IPneiwiyQTCsnmUVp+Q=;
        b=NMda3q3dPkaXAx4rKcPJO6w6MHw2vFbM7+PxFhLZ+5UQ20iQYy6laTBUjJbWqyJTb2
         1uztlQjP5+Y+qzFWEbK3Bf1Fj5Hl73/7zz1TPnoEuxh3ozVg45IgzfcricCp7QE/YYj5
         rKWPeSbuxVMePUB5nA0oBsoyKBYj5tAyPmuj0XquO+t5QUMKFNvt+J0IRMRdruCjQd1Y
         QBR+FdxdNkJSWZeAWklOc8mjh1rYZ9P1C+oepjBtOX0HI21wLCvfZJnIFQTHnMDnqv5G
         4z6Wxnqz+EMyD1dYEkESVVvyv8wJM6EiCLMK4a22xnbANAGWxz7lL3sSpwZKsoXUjYuZ
         ny3A==
X-Forwarded-Encrypted: i=1; AJvYcCUXetSlquLKq08t9RyZlHf+v7FU2zFLEfMmo01Hkb6AUYwjy9tbZI+Osd7Dca3K0RDpS/GzKiPtB0c4AjAKs4m5T3Burh9Yl0sWczYuSTEfkg==
X-Gm-Message-State: AOJu0YxL/oI9OcUx+Els+cifmrDliRe0RiIbdh1eh/BRX6MLnn+wOMHS
	ysUsNQjvrxSVA7VZ6zDFz7z3V8t4HOImcit9evWyDXNC3r+bF+pQEPVwU2mUGPA=
X-Google-Smtp-Source: AGHT+IF+YHNaU9vL6pmPv8W6yXfeti4FATXv6vY1xmFi4uhJwkg/8PS66vkhIP9jsmfqOTwf5yPg6g==
X-Received: by 2002:a05:600c:4f95:b0:426:690d:d5b7 with SMTP id 5b1f17b1804b1-429ed7d646amr16479995e9.25.1723800179854;
        Fri, 16 Aug 2024 02:22:59 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a57asm3229900f8f.2.2024.08.16.02.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 02:22:59 -0700 (PDT)
Message-ID: <6cbd2f1d-2aea-486c-a3cb-bb6eb08d8bdc@linaro.org>
Date: Fri, 16 Aug 2024 10:22:58 +0100
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
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fVSVe=C5dHaOV22+YOZ_JCD0mDoByoubSFY3w4au5zwQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 15/08/2024 6:29 pm, Ian Rogers wrote:
> On Wed, Aug 14, 2024 at 9:28 AM James Clark <james.clark@linaro.org> wrote:
>> On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
>>> On 01.08.24 21:05, Ian Rogers wrote:
>>>> On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
>>>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>>>
>>>>> [TLDR: This mail in primarily relevant for Linux kernel regression
>>>>> tracking. See link in footer if these mails annoy you.]
>>>>>
>>>>> On 22.11.23 00:43, Bagas Sanjaya wrote:
>>>>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
>>>>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
>>>>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
>>>>>
>>>>> #regzbot fix: perf parse-events: Make legacy events lower priority than
>>>>> sysfs/JSON
>>>>> #regzbot ignore-activity
>>>>
>>>> Note, this is still broken.
>>>
>>> Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
>>> this? Or is this a "we are screwed one way or another and someone has to
>>> bite the bullet" situation?
>>>
>>> Ciao, Thorsten
>>>
>>>> The patch changed the priority in the case
>>>> that you do something like:
>>>>
>>>> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
>>>>
>>>> but if you do:
>>>>
>>>> $ perf stat -e 'cycles' benchmark
>>>>
>>>> then the broken behavior will happen as legacy events have priority
>>>> over sysfs/json events in that case. To fix this you need to revert:
>>>> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
>>>> events over legacy"
>>>>
>>>> This causes some testing issues resolved in this unmerged patch series:
>>>> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
>>>>
>>>> There is a bug as the arm_dsu PMU advertises an event called "cycles"
>>>> and this PMU is present on Ampere systems. Reverting the commit above
>>>> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
>>>> __evlist__add_default") to fix ARM's BIG.little systems (opening a
>>>> cycles event on all PMUs not just 1) will cause the arm_dsu event to
>>>> be opened by perf record and fail as the event won't support sampling.
>>>>
>>>> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
>>>> fixes this by only opening the cycles event on core PMUs when choosing
>>>> default events.
>>>>
>>>> Rather than take this patch the revert happened as Linus runs the
>>>> command "perf record -e cycles:pp" (ie using a specified event and not
>>>> defaults) and considers it a regression in the perf tool that on an
>>>> Ampere system to need to do "perf record -e
>>>> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
>>>> will choose the cycles event correctly and with better precision the
>>>> pp for systems that support it, but it was still considered a
>>>> regression in the perf tool so the revert was made to happen. There is
>>>> a lack of perf testing coverage for ARM, in particular as they choose
>>>> to do everything in a different way to x86. The patch in question was
>>>> in the linux-next tree for weeks without issues.
>>>>
>>>> ARM/Ampere could fix this by renaming the event from cycles to
>>>> cpu_cycles, or by following Intel's convention that anything uncore
>>>> uses the name clockticks rather than cycles. This could break people
>>>> who rely on an event called arm_dsu/cycles/ but I imagine such people
>>>> are rare. There has been no progress I'm aware of on renaming the
>>>> event.
>>>>
>>>> Making perf not terminate on opening an event for perf record seems
>>>> like the most likely workaround as that is at least something under
>>>> the tool maintainers control. ARM have discussed doing this on the
>>>> lists:
>>>> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
>>>> but since the revert in v6.10 no patches have appeared for the v6.11
>>>> merge window. Feature work like coresight improvements and ARMv9 are
>>>> being actively pursued by ARM, but feature work won't resolve this
>>>> regression.
>>>>
>>
>> I got some hardware with the DSU PMU so I'm going to have a go at trying
>> to send some fixes for this. My initial idea was to try incorporate the
>> "not terminate on opening" change as discussed in the link directly
>> above. And then do the revert of the "revert of prefer sysfs/json".
> 
> Thanks, I think this would be good. The biggest issue is that none of
> the record logic expects a file descriptor to be not opened, deleting
> unopened evsels from the evlist breaks all the indexing into the
> mmaps, etc. Tbh, you probably wouldn't do the code this way if was
> written afresh. Perhaps a hashmap would map from an evsel to ring
> buffer mmaps, etc. Trying to avoid having global state and benefitting
> from encapsulation. I'd focus on just doing the expedient thing in the
> changes, which probably just means making the record code tolerant of
> evsels that fail to open and not modifying the evlist due to the risk
> it breaks the indices.
> 

Thanks for the tips.

> (To point out the obvious, this work wouldn't be necessary if arm_dsu
> event were renamed from "cycles" to "cpu_cycles" which would also make
> it more intention revealing alongside the arm_dsu's "bus_cycles" event
> name).
> 

I understand but I can imagine the following conversation if we rename that:

   User: "I updated my kernel and now my (non Perf) tool fails to open
          the DSU cycles event because it doesn't exist anymore"

   Linus/maintainers: "Oh ok yes that was a userspace breaking change,
                      lets revert it"

Just because Perf can handle 3 different names for cycles doesn't mean 
other tools can.

>> FWIW I don't think Juno currently is broken if the kernel supports
>> extended type ID? I could have missed some output in this thread but it
>> seems like it's mostly related to Apple M hardware. I'm also a bit
>> confused why the "supports extended type" check fails there, but maybe
>> the v6.9 commit 25412c036 from Mark is missing?
> 
> So I think your later emails clarify Arnaldo is probably missing:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/commit/drivers/perf/arm_pmu.c?h=perf-tools-next&id=5c816728651ae425954542fed64d21d40cb75a9f
> 
> Fwiw, the Apple M hardware issue came to me by way of Mark Rutland
> (iirc), this regression report, etc. My understanding is that Apple M
> has something like a v2 ARM PMU and the legacy events are encoded
> incorrectly in the driver for this. The regression in v6.5 happened

I'm not sure about that. The M PMU events may be incomplete, but the two 
that are there have a mapping that looks sane:

   static const unsigned m1_pmu_perf_map[PERF_COUNT_HW_MAX] = {
	PERF_MAP_ALL_UNSUPPORTED,
	[PERF_COUNT_HW_CPU_CYCLES]	= M1_PMU_PERFCTR_CPU_CYCLES,
	[PERF_COUNT_HW_INSTRUCTIONS]	= M1_PMU_PERFCTR_INSTRUCTIONS,
	/* No idea about the rest yet */
   };

And they map to the same named events:

   static struct attribute *m1_pmu_event_attrs[] = {
	M1_PMU_EVENT_ATTR(cycles, M1_PMU_PERFCTR_CPU_CYCLES),
	M1_PMU_EVENT_ATTR(instructions, M1_PMU_PERFCTR_INSTRUCTIONS),
	NULL,
   };

So in this case I can't see using legacy vs sysfs events making a 
difference. Maybe there is some other case that was mentioned in a 
previous thread that I missed though.

> because ARM's core PMUs had previously been treated as uncore PMUs,
> meaning we wouldn't try to program legacy events on them. Fixing the
> handling of ARM's core PMUs broke Apple M due to the broken legacy
> event mappings. Why not fix the Apple M PMU driver? Well there was
> anyway a similar RISC-V issue reported by Atish Patra (iirc) where the
> RISC-V PMU driver wants to delegate the mapping of legacy events to
> the perf tool so the driver needn't be aware of all and future RISC-V
> configurations. The fix discussed with Mark, Atish, etc. has been to
> swap the priority of legacy and sysfs/json events so that the latter
> has priority. We need the revert of the revert as currently we only do
> this if a PMU is specified with an event, not for the general wildcard
> PMUs case that most people use. There was huge fallout from flipping

Yep makes sense to do the revert if RISC-V isn't going to support any 
legacy events. Although from what I understand that would technically 
only require JSON to be the highest priority? Because putting named 
events in sysfs still requires kernel involvement so doesn't get you any 
further than supporting the legacy events?

Seems like there is another reason to do the revert though as Mark 
mentioned: That now directly specifying the PMU eg "-e 
arm_cortex_a56/cycles/" opens a legacy event if the event matches one, 
which is not the best thing to do. But the revert fixes this AFAIK, so 
while having the priority JSON/legacy/sysfs might work for RISC-V it 
wouldn't work for a platform that wants a slightly different sysfs event 
than legacy but with the same name. And the priority should be 
JSON/sysfs/legacy.

> the priority particularly on Intel as all test expectations needed
> updating. I've sent out similar fixes that need incorporating when the
> revert is reverted. Ideally tools/perf/tests/parse-events.c would be
> updated to cover ARM's PMUs that don't follow the normal pattern that
> the core PMU is called "cpu" (this would mean that we were testing
> event parsing on ARM was WAI wrt encoding priorities, BIG.little,
> etc).
> 
>> I sent a small fix the other day to make perf stat default arguments
>> work on Juno, and didn't notice anything out of the ordinary:
>> https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e54ca43f6@linaro.org/T/#t
>> I agree that change is quite narrow but it does incrementally improve
>> things for the time being. It's possible that it would become redundant
>> if I can just include Ian's change to use strings for Perf stat.
> 
> I'd prefer we didn't merge this as we'd need to rebase:
> https://lore.kernel.org/lkml/20240510053705.2462258-4-irogers@google.com/
> and those changes would then delete the code introduced. I'm fine with
> adding the tests.
> 
> There are more exotic heterogeneous core things upcoming, probably
> also from ARM, and the thought of duplicating the default attribute
> logic and event parsing constraints is just something I'd prefer not
> to have to do.
> 

Yep I don't have any strong feelings about this. Even if we don't merge 
it it helped me understand the code and the issue a bit.

I think one thing I assumed about your change was that there was some 
dependency on these other changes. But the more I look at it I think 
it's actually fine on it's own?

Using the cycles string actually works today, even on Apple M. The only 
real remaining issue is softening the error for failure to open, but 
that's _after_ doing the revert of the revert and is separate.

I will re-test that one today with fresh eyes.

>> Of course I only think I have a handle on the issue right now, seems
>> like it has a lot of moving parts and something else always comes up. If
>> I hit a wall at some point I will come back here.
> 
> Thanks,
> Ian
