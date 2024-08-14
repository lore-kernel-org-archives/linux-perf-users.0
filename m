Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1851B5811
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 16:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652927; cv=none; b=OqNpu9T+DRXGasJZ5gdBnP3r3G4g+wTAjLCfipvlMlS3HHs7B5CKnchPDc8SqFxtjsKph1zBnrid3oV7g9iZSgHVgXdxDzzLWvxT9lPpx7bWRu3WTbes8L1iy2awGKSyNcYFnxS7cqstz95gK38qWdhvR3lVKBkD+VQalDIiWzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652927; c=relaxed/simple;
	bh=NKfwsZeTlnXRMDvq8E5vaLoO5hPrCvbfTXzCITw9KOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bB8gweybeUYg+65hXlkHxgxTPhUnpkXl95S3BkFaPPoubdJgI3mGpTqt3GNy7pdtCvXOcS5gcPdrBnyQ2Dj1Di7vJR5f6fzIAlHf6WSKrkNJoJ0rlSpy1CpjoW1oO7eQRyTPP/t+//xjZf+ahwADLoc6kOd5rohLUs9ptcN17UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GXJTyyCQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXJTyyCQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428ec6c190eso52351955e9.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Aug 2024 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723652924; x=1724257724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ClfwenGLJtFMHfZRAp5xBKpkrKx7yBYttQI6ee32yHs=;
        b=GXJTyyCQ6YT7s0eWG77FPvxHk4mLT6Wr+dULrejIK1eBN5uaXKhXDwWul81IQme8az
         9l4QB9Doa2565L8JhZvxZLDRNWiKZsttBwplLZSYKNSrckHehL/FilEVVDXqeSWz01X2
         YUXPQhhhRULNmHeINhae/m0LQmnBsJJQGY56iyy24tPKBZniBE1Cv5Y3JhvxPXCV7PnM
         XoxpkKCmDsp4uoaJ9iK8EOHJdJufrBcAX5vpW1QF2THI3cEu+DNxnjgvXOf7+6xyc+w6
         4D9QkQHnrR5geyV4zn4LdTOSLe76TVMUqvJR5C2Mx80RNIosAncBuCzDwJcIr9xIRQtf
         jWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652924; x=1724257724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ClfwenGLJtFMHfZRAp5xBKpkrKx7yBYttQI6ee32yHs=;
        b=Q9NPSQPive2LO9t+k6BheS4ZzVvjM61Yg8aJUJIWHdwHXICUbULdoz9V2YInRNTuTM
         9mEbsw4enTd5CILPy+1U8BYTR6cFaSmJUKR4D8J1Ugz3yL1vf02phwyEZeliI/dCM8Tv
         33rpgSRqvaTbfqxZWS2cWjQYOlEiGdDctk2LTI2X7I/imp/ITy6OAVoAb/uPXFZn19i9
         TU8YOYdyQnu6C8HloRzRIsKWq8WIAHU8Y5bE5jrH0Ao/8JVBFqQ6AboHtOcND7f8uhr+
         7fGXBXG1dn2ux0B8YpUfnjZp3VXKUmZoOYcXAX/062lUMl8kIpauxZT2rL/RLCQ8I19a
         0HFg==
X-Gm-Message-State: AOJu0YysEoVMTZ4BlJlTKftbwK5bG3YxswI352j4mOOui6le1IlmTIst
	K1M+o4td5bGbT2+irzckn07csAR2+mB4LWXz8Vibt8zejFgchZwe5h7qwvZVrdQ=
X-Google-Smtp-Source: AGHT+IFvN9G5J/WAGwqQb+FfIdaSv/o6JbQZtqSoFJqYXKwjyr2vAVPTq3A4iENCVN6KuTwWS4rSPw==
X-Received: by 2002:a05:600c:a07:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-429e0f80bc3mr8847605e9.28.1723652923491;
        Wed, 14 Aug 2024 09:28:43 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429d877f234sm48235275e9.1.2024.08.14.09.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 09:28:43 -0700 (PDT)
Message-ID: <0de3b572-f5f7-42e4-b410-d1e315943a3c@linaro.org>
Date: Wed, 14 Aug 2024 17:28:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
To: Thorsten Leemhuis <regressions@leemhuis.info>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Ian Rogers <irogers@google.com>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Linux perf Profiling <linux-perf-users@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 James Clark <james.clark@arm.com>, "cc: Marc Zyngier" <maz@kernel.org>,
 Hector Martin <marcan@marcan.st>, Asahi Linux <asahi@lists.linux.dev>,
 Ian Rogers <irogers@google.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 "to: Mark Rutland" <mark.rutland@arm.com>
References: <08f1f185-e259-4014-9ca4-6411d5c1bc65@marcan.st>
 <ZV1AnNB2CSbAUFVg@archie.me>
 <a9c14dfd-3269-4758-9174-4710bef07088@leemhuis.info>
 <CAP-5=fXqx_k1miPTkcAmS3z2GBPt2KeDtP5fknmdDghZqxXPew@mail.gmail.com>
 <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <714ed350-0e6c-4922-bf65-36de48f62879@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 07/08/2024 9:54 am, Thorsten Leemhuis wrote:
> On 01.08.24 21:05, Ian Rogers wrote:
>> On Wed, Dec 6, 2023 at 4:09 AM Linux regression tracking #update
>> (Thorsten Leemhuis) <regressions@leemhuis.info> wrote:
>>>
>>> [TLDR: This mail in primarily relevant for Linux kernel regression
>>> tracking. See link in footer if these mails annoy you.]
>>>
>>> On 22.11.23 00:43, Bagas Sanjaya wrote:
>>>> On Tue, Nov 21, 2023 at 09:08:48PM +0900, Hector Martin wrote:
>>>>> Perf broke on all Apple ARM64 systems (tested almost everything), and
>>>>> according to maz also on Juno (so, probably all big.LITTLE) since v6.5.
>>>
>>> #regzbot fix: perf parse-events: Make legacy events lower priority than
>>> sysfs/JSON
>>> #regzbot ignore-activity
>>
>> Note, this is still broken.
> 
> Hmmm, so all that became somewhat messy. Arnaldo, what's the way out of
> this? Or is this a "we are screwed one way or another and someone has to
> bite the bullet" situation?
> 
> Ciao, Thorsten
> 
>> The patch changed the priority in the case
>> that you do something like:
>>
>> $ perf stat -e 'armv8_pmuv3_0/cycles/' benchmark
>>
>> but if you do:
>>
>> $ perf stat -e 'cycles' benchmark
>>
>> then the broken behavior will happen as legacy events have priority
>> over sysfs/json events in that case. To fix this you need to revert:
>> 4f1b067359ac Revert "perf parse-events: Prefer sysfs/JSON hardware
>> events over legacy"
>>
>> This causes some testing issues resolved in this unmerged patch series:
>> https://lore.kernel.org/lkml/20240510053705.2462258-1-irogers@google.com/
>>
>> There is a bug as the arm_dsu PMU advertises an event called "cycles"
>> and this PMU is present on Ampere systems. Reverting the commit above
>> will cause an issue as the commit 7b100989b4f6 ("perf evlist: Remove
>> __evlist__add_default") to fix ARM's BIG.little systems (opening a
>> cycles event on all PMUs not just 1) will cause the arm_dsu event to
>> be opened by perf record and fail as the event won't support sampling.
>>
>> The patch https://lore.kernel.org/lkml/20240525152927.665498-1-irogers@google.com/
>> fixes this by only opening the cycles event on core PMUs when choosing
>> default events.
>>
>> Rather than take this patch the revert happened as Linus runs the
>> command "perf record -e cycles:pp" (ie using a specified event and not
>> defaults) and considers it a regression in the perf tool that on an
>> Ampere system to need to do "perf record -e
>> 'armv8_pmuv3_0/cycles/pp'". It was pointed out that not specifying -e
>> will choose the cycles event correctly and with better precision the
>> pp for systems that support it, but it was still considered a
>> regression in the perf tool so the revert was made to happen. There is
>> a lack of perf testing coverage for ARM, in particular as they choose
>> to do everything in a different way to x86. The patch in question was
>> in the linux-next tree for weeks without issues.
>>
>> ARM/Ampere could fix this by renaming the event from cycles to
>> cpu_cycles, or by following Intel's convention that anything uncore
>> uses the name clockticks rather than cycles. This could break people
>> who rely on an event called arm_dsu/cycles/ but I imagine such people
>> are rare. There has been no progress I'm aware of on renaming the
>> event.
>>
>> Making perf not terminate on opening an event for perf record seems
>> like the most likely workaround as that is at least something under
>> the tool maintainers control. ARM have discussed doing this on the
>> lists:
>> https://lore.kernel.org/lkml/f30f676e-a1d7-4d6b-94c1-3bdbd1448887@arm.com/
>> but since the revert in v6.10 no patches have appeared for the v6.11
>> merge window. Feature work like coresight improvements and ARMv9 are
>> being actively pursued by ARM, but feature work won't resolve this
>> regression.
>>

I got some hardware with the DSU PMU so I'm going to have a go at trying 
to send some fixes for this. My initial idea was to try incorporate the 
"not terminate on opening" change as discussed in the link directly 
above. And then do the revert of the "revert of prefer sysfs/json".

FWIW I don't think Juno currently is broken if the kernel supports 
extended type ID? I could have missed some output in this thread but it 
seems like it's mostly related to Apple M hardware. I'm also a bit 
confused why the "supports extended type" check fails there, but maybe 
the v6.9 commit 25412c036 from Mark is missing?

I sent a small fix the other day to make perf stat default arguments 
work on Juno, and didn't notice anything out of the ordinary: 
https://lore.kernel.org/linux-perf-users/dac6ad1d-5aca-48b4-9dcb-ff7e54ca43f6@linaro.org/T/#t
I agree that change is quite narrow but it does incrementally improve 
things for the time being. It's possible that it would become redundant 
if I can just include Ian's change to use strings for Perf stat.

Of course I only think I have a handle on the issue right now, seems 
like it has a lot of moving parts and something else always comes up. If 
I hit a wall at some point I will come back here.

Thanks
James
