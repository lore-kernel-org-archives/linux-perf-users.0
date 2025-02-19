Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BE1F4176
	for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739978745; cv=none; b=Bd/04beo4yEcAp0dep0Sf8dIoA2C0mvFgPy9235WBNfNFfWho/ZoYfAD3W+gYcYztNpVB+Qe8EKJSQhezv6fd4PAkhDEC2vwWVl4p9LrqFnANUPAyVpOBknOCe1gblMuCm2kiL39SqOlC7lSzck931FMvMvdN9aockKjam0ZRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739978745; c=relaxed/simple;
	bh=XRVPAVWN0HDcStW6xUkCUHkrgRmZ4Z0xi6MQYld+xpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI5pr0OtVoBmUCLh7uyiUWCqkFe+DwSZVue3WgkIu/o/+CRILTj7j4Q9q4hvvdUyIfDb1bRnqVJMpVt/VlvxLsAAZbrW5oqs3OTjoCMj6akw3YYncYB+y3+Wl0BxWCFSXEw9z4CmwSFpRcrnCB2SdHaMAKJ/LkGREeEBAs4FXDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fR1pSFvp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fR1pSFvp"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso657480f8f.0
        for <linux-perf-users@vger.kernel.org>; Wed, 19 Feb 2025 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739978742; x=1740583542; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TVboDbTS95QyZTgZm/sSOHGaAKi+IOHygPp3tuwMR8=;
        b=fR1pSFvpgqGfnKsXQsi7CVR4DTQP1ZDJe1w9ZEk4zUZueoO+Um9kn1MvSGd/jER3qx
         P8b6VzhTRMxG/b2F9Ge67LmK/4IiyLryRkeOCdBV+j1G/zOdE72JK+P9PNC2fWUU2k4h
         NyQJ8L0smDADjxmTkUlR6m+fLUcbRxs3Ffi9u+57D2d8pfDiT47SfGxgwtW4KkljqyAF
         /gA1AjVreVYyfcm0qEnlPHgRMw6pDNGd9caPzrHynKMdn5Hmm9nm3WWErXXXGwStqDy5
         sG1RMWyTy4ZquSi1ej6REwkg05nBkXJ3Q46jehGfFH+eQyWZDp5w79DSvCfG1SP4ghuL
         secw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739978742; x=1740583542;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TVboDbTS95QyZTgZm/sSOHGaAKi+IOHygPp3tuwMR8=;
        b=aNXkrJn+isQJ4veckcfJG1JZARMsoNBefFXgQM8gtsjFDhx75bMzjXCu2DdXLrR+vu
         7bYxi4iy3azi2XejG2E8mlj5+KKxAUj2IaSD4fWQO66GFeGSrt37tXweGUrGf+rmURMJ
         52SaSq/ftpUE8algrI2gUHEgxjUSDskJ4XcFMGal5cJ6/sd3MNaBHHEqbOd5l5eZ2aqF
         2mMGqON4aoF0LMFb+9OTeIB6T5qH670ZdA6ImjV3iLxPvZZxfFuYq6YbmUzd+cPbs9lu
         4yqYMRxij0L0ZgR5LjPGz/Ls7h5/I4eaO37gD/iwGoPtwHmHKtJxyKF54PWW2POt2cMl
         McoA==
X-Forwarded-Encrypted: i=1; AJvYcCVIYEtKdJNWLOm0Y27y5TcAlwoZ2MqYTlSBkRAZcszFium6sHBGr2HHRM7nU+s2FQ3glA0jzAXPORAp2QQNIbcs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw04vQ2/zyHSbZlUBN/u5Tp/40zf6w+/hbXzQUIRx0NHKUGCsDD
	wt+JmLg8uaB8lZtSSUJIWTgRByA1W+KulLckJNs7I8ZEZRUoDRyPGSUZgHXAs25KZmJ94VOuV6L
	11OM=
X-Gm-Gg: ASbGncsq+HvX6sbLR+j+r0abSmw3CfjHIwt0vJeOW9Wirx89rj/I6xzoMJnyjlHgVZT
	7pxJMWoDqiU5U3AT80RoJ4tyxOztsq2mAmgZqR4bnAsBucih6+NXHIeUrd64gL76XYsEM7hHkqy
	cDmrEu9s8qDJG0gjkp15akxsIFmm+nRMub1c2Bx6KxZC4KEMmwhHIvagIfp5Ec5GxHvkFwM5LmT
	0AP+GzFz0VW66Ai2rh5b28rruVY7HeOZ5KtS+5T4+a1jJS6aRS+t+psi5PnW38d4LrRoolmzejh
	PJz9/DGNemH6A1t+XrnWwL+VuQ==
X-Google-Smtp-Source: AGHT+IHUdFK1lvkIKfQXed2a/KYhYlsDONXCYFg5p0+CqyAxqO1bS9PwbNrEGNiXbD3YDFKA1AvLhw==
X-Received: by 2002:a5d:5f49:0:b0:38f:2b52:f059 with SMTP id ffacd0b85a97d-38f57d95940mr3673454f8f.27.1739978741585;
        Wed, 19 Feb 2025 07:25:41 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd51sm18138198f8f.29.2025.02.19.07.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 07:25:41 -0800 (PST)
Message-ID: <2834c9d7-f401-4b29-8f92-22193eb9ce31@linaro.org>
Date: Wed, 19 Feb 2025 15:25:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
To: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Yangyu Chen <cyy@cyyself.name>, linux-perf-users@vger.kernel.org,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com>
 <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
 <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
 <CAP-5=fVAhLLH-a0_wLo8dPoMLOb6rOJiTgGh-OFZJJoaLFE-8Q@mail.gmail.com>
 <fe46069e-c52e-45ee-b4b3-8b929fb83b31@linaro.org>
 <Z7UHieRRnvRb5_oU@google.com>
 <CAP-5=fWXmNoFLyWv+vo7hhLSqTDy7hf+-huKRD9OUWnO-GESRw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAP-5=fWXmNoFLyWv+vo7hhLSqTDy7hf+-huKRD9OUWnO-GESRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 18/02/2025 10:33 pm, Ian Rogers wrote:
> On Tue, Feb 18, 2025 at 2:19 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> On Tue, Feb 18, 2025 at 09:30:23AM +0000, James Clark wrote:
>>>
>>>
>>> On 18/02/2025 12:41 am, Ian Rogers wrote:
>>>> On Fri, Feb 14, 2025 at 2:02 AM James Clark <james.clark@linaro.org> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 14/02/2025 5:49 am, Yangyu Chen wrote:
>>>>>>
>>>>>>
>>>>>>> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
>>>>>>>
>>>>>>> Hello,
>>>>>>>
>>>>>>> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
>>>>>>>> This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
>>>>>>>> processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
>>>>>>>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
>>>>>>>
>>>>>>> I'm curious how the name of PMUs look like.  It is cortex_a720 (or a520)?
>>>>>>
>>>>>> The name of PMUs comes from Arm's documentation. I have included these
>>>>>> links in each patch.
>>>>>>
>>>>>>> I remember there's a logic to check the length of hex digits at the end.
>>>>>>>
>>>>>>
>>>>>> Could you provide more details about this?
>>>>>>
>>>>>>> Ian, are you ok with this?
>>>>>>>
>>>>>
>>>>> I think they wouldn't be merged because they're core PMUs, so should be
>>>>> fine? Even though they would otherwise be merged because they're more
>>>>> than 3 hex digits.
>>>>
>>>> Do we know the PMU names? If they are cortex_a520 and cortex_a720 then
>>>
>>> It will be "armv9_cortex_a720" from this line:
>>>
>>>    PMUV3_INIT_SIMPLE(armv9_cortex_a720)
>>
>> I see, thanks!
>>
>>>
>>>> this comment at least reads a little stale:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n76
>>>> ```
>>>> /*
>>>> * There is a '_{num}' suffix. For decimal suffixes any length
>>>> * will do, for hexadecimal ensure more than 2 hex digits so
>>>> * that S390's cpum_cf PMU doesn't match.
>>>> */
>>>> ```
>>>> James is right that core PMUs aren't put on the same list as uncore/other PMUs.
>>
>> Ok, then I guess we're good.
> 
> I think you may be able to do things that look odd, like today the
> "i915" PMU can be called just "i", I think the a520/a720 naming will
> allow "armv9_cortex/cycles/" as an event name, then open it on two
> PMUs if they are present. 

I assumed that was the intended behavior. It seems fairly useful to be 
able to open on ones with common prefixes.

> We may only show one PMU in perf list as
> that code I think assumes they're the same PMU as they only differ by
> suffix:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n384

Yeah that is the case. I didn't realise it when looking at the previous 
fixes to keep the suffixes in perf stat output.

> I can imagine aggregation possibly being broken, but I think that
> works off the number of PMUs not the names of the PMUs, so it should
> be okay. Probably the only thing broken that matter is perf list when
> you have a BIG.little system with a520 and a720, this may be broken
> with say a a53 and a72 today as both of those suffix lengths are >2,
> but maybe they use the "armv8._pmuv3_0", "armv8._pmuv3_1", etc. naming
> convention. I suspect the >2 here:

Also the case for a53 and a72 right now. Even "perf list --unit 
armv8_cortex_a57" doesn't work because we deduplicate before filtering. 
Adding -v fixes it though because that disables deduplication. Perhaps 
we can change it to disable it with the --unit argument?

> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmus.c?h=perf-tools-next#n80
> would still work and be correct if it were >4. If that changes then
> this will also need to change:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/Documentation/ABI/testing/sysfs-bus-event_source-devices?h=perf-tools-next#n12

That could be an easy fix. If >4 is enough to still get rid of all the 
uncore duplicates I can make the change?

> 
> Thanks,
> Ian
> 
>>
>> Thanks,
>> Namhyung
>>

