Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D6072622
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 14:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771510527; cv=none; b=fIos1BAo/Sb5IhLPQ7DRwFyeBnVVHa/6BPZufBaOrCMqp0t/82s//J3+RtNMVLLna7Y6bEQx3Yd6eTkbCbcT0IVHs1ReZFw8pR+eXrz+b03e080wRs/KIF/ITT+xViW2EEvK9tpsKaC5Jl2aj5N5s0FWUWj5H+RZ0v9rClUVe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771510527; c=relaxed/simple;
	bh=gKKhSwpdIK7JuP/bPs04ENR83wfPje47C0AWE3eI414=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qNa57rxebM/xstnyUn5G5TBIi6pACz+E/XyNvLgdr/JZ8ahW+lV1boK0G6t8MOhp6orQjx5D50rPatnjg3twKJ4YlEl9eHHYmlxA1EvVmm7Jq5LU4t/6ja3Utn/VOZJrzf+5iSGEhxWAZyVL5dERK1gkJ/KVRDJamwu6lUNnyW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rCZxeVQw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rCZxeVQw"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6580dbdb41eso1227418a12.0
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Feb 2026 06:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771510524; x=1772115324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wWERID7Ml99UJJW0whYVuGDsSB2aN5R/H1f4BW4+Uk=;
        b=rCZxeVQwxkcqYBf1zKrptxbG/47TqCpasMdQQnHqHovIvlBdwKyxE89qvNHmgwZPcD
         zJTGJPGyBZ9zOkWLQ0UGrt7j3PQ3AWO1PrdVYAeZsCA7T7oiXjxBbprotCrjrS4Jp5hk
         WgSeksY1OMaDLxb6odsuwd3iyaCtiNNAVW1j8PpHvyqdUMPAWDzCGc5SbhIiazV+dM6w
         hLqCxvlsAU8dVSuL2czQNSTiPhrFordaTzJFgXTZTuvFf90Wp1qnefgZ70cVrqIK1U07
         N10fjc1O6jaZMJ8NwVRZg4fsF9TTEO0Ia5nvID++HZlOQ21mPOHkqxbaAhK9YXzJKDFA
         TOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771510524; x=1772115324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wWERID7Ml99UJJW0whYVuGDsSB2aN5R/H1f4BW4+Uk=;
        b=iTbgi14SCyIHgCnkhWuxByL6ezLZxtDe/J+zEN3TgRwij7kJ7ZfDAqRWylXCmDqUeV
         wyNtfCSNxg2hDqup3VnVIomVqWFLYjgxTpWG3feK5VhHYyLRc4CxOhmyerbNCK7Or6fG
         KG7GWJ3DrGYVnhOwa23ls2yJDRgdnK4JoFw7HhLWR1vdOS6RfHZ6MXLOCHU7WQ/SsB6W
         pIPCmONC/RR3P2E/gs9XeX2eGL/9I7TvYsI9ON/3UzzroIPYF6xK9SVYw6g3nax5//Dc
         NJsHWw5aUl7RzIZp1dtr6YJqyOVxJEcrFw6/V6iNMwryu5umFI+U88LoIbPy5yHo5HS9
         kxjA==
X-Forwarded-Encrypted: i=1; AJvYcCWCHtYfZqGgHYnTqSr5I+2YcHPDrxITVR1sKe4tkPGVx3dtV/uzLAxRMVBviV4Xnp1HjwkrNo6on024aeQvXPQH@vger.kernel.org
X-Gm-Message-State: AOJu0YwXrVIyyEYZJN8Vyb5/Kwt8UiZ6geq5fNaLotiOMeywAbt0B6Ga
	8OTxT9FL1UxDMjYXE+1ACLuer54K0bg8a7IJpixk7eTiRf/XwcJMU09b7GQB9uJnNZA=
X-Gm-Gg: AZuq6aIaSxsLvOjSZhnK5FcQgTfjL3gXBswwttEhPB8pMv4xwbsFnUeD3N30/91jzEY
	GNbKzRaJbtB7klzerq8gxTQjfFt4+rVxoy5zug9VoKnBEKxv34yczZDAhDaV0Lffotsul0F/jRS
	osB33zTCORANji2XHd7JdVJ2mXSu/nRMxaAwol1MK/IeNvdkxZT/9fUJFOw8Lj7ugZM/GeXcZB7
	Cl4Qs94ug5bsQMbJ/wMgHm6QcwKkuvB47Ani4OuFL10gWjKPSAz5cjKsSfUxKYxY7O/oXmyZOKf
	RempXLHBqToLFgn8OfrGm3oxjuHVBrjaXuHFAwQzvrDKNAasPXm+kiGJqw1ftQCKSnNbFCyPkn0
	Bp+Sxhl9RegBfczZvAu9tg1L2J01ku5l6gWCYzPIKRnfbR4UvvdpY4qFCMXhVENzXMvoPTKitWM
	OuZwS5jvZ4XnGcOpgUQo6x0gjLC5jO
X-Received: by 2002:a17:907:72c6:b0:b87:39d:2bb4 with SMTP id a640c23a62f3a-b903dd049b9mr353165066b.59.1771510523782;
        Thu, 19 Feb 2026 06:15:23 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8fc7626bfesm556068366b.44.2026.02.19.06.15.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:15:23 -0800 (PST)
Message-ID: <2d5f6207-afa2-4880-b34d-f03b5ebf3b5f@linaro.org>
Date: Thu, 19 Feb 2026 14:15:22 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Anshuman Khandual <Anshuman.Khandual@arm.com>,
 Rob Herring <Rob.Herring@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>,
 Robin Murphy <Robin.Murphy@arm.com>, Leo Yan <leo.yan@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Williams <Michael.Williams@arm.com>,
 Alexandru Elisei <Alexandru.Elisei@arm.com>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <aYD08d42SewAAQCB@willie-the-truck>
 <aebe99ad-1189-4372-83e3-385f33829bd2@linaro.org>
 <aYHXCkFZcVm1L_25@willie-the-truck>
 <e7d53952-59f6-4990-83fb-1182641af29f@linaro.org>
 <705acb39-2eef-4e61-aec1-b9503e788299@linaro.org>
 <aZcIy1Or4c5-i7Tm@willie-the-truck>
 <7b692e5c-d376-4023-80e0-76c9d9c0604f@linaro.org>
 <aZcYLZ9wETnRDJ7P@willie-the-truck>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <aZcYLZ9wETnRDJ7P@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/02/2026 2:03 pm, Will Deacon wrote:
> On Thu, Feb 19, 2026 at 01:51:26PM +0000, James Clark wrote:
>> On 19/02/2026 12:57 pm, Will Deacon wrote:
>>> On Thu, Feb 19, 2026 at 12:08:27PM +0000, James Clark wrote:
>>>> I'm back to drag this up again. So I think all of the above discussion
>>>> relies on the ordering given by the indirect read needed for the "might
>>>> ignore a direct write..." part. But it's _might_ ignore a direct write, it's
>>>> possible for an implementation to not do that, so there are two possible
>>>> implementations:
>>>>
>>>> #1 Where there is an indirect read to give the write ignore outcome
>>>> #2 Where there is no write ignore outcome so it doesn't require an
>>>>      indirect read
>>>>
>>>> For #2 there's nothing to force the ordering. We're writing to two different
>>>> registers (PMBPTR_EL1 and PMBLIMITR_EL1) and we have to have the
>>>> PMBLIMITR_EL1 write come second for the buffer to be considered configured
>>>> correctly. For example if the old value of PMBPTR_EL1 is higher than the new
>>>> PMBLIMITR_EL1 and the write to PMBLIMITR_EL1 happens first then it's
>>>> misconfigured. That's why we think we need the isb() here.
>>>
>>> I thought profiling was disabled in these cases, so why is it
>>> misconfigured?
>>>
>>> If it is misconfigured, what can go wrong given that we're either stopped
>>> or pmscr is clear?
>>>
>>> Will
>>
>> It is stopped in the interrupt handler because PMBSR_EL1.S = 1. But in
>> arm_spe_pmu_start(), PMBSR_EL1.S = 0 so it's not stopped. And with
>> PMBPTR_EL1 still being set to the value from the last session it could be
>> higher than PMBLIMITR_EL1.
>>
>> PMSCR_EL1 doesn't affect SPEProfilingStopped(), it's only:
>>
>>    boolean stopped = (PMBSR_EL1.S == '1');
>>
>> The conditions for when the buffer needs to be configured correctly from
>> R24557 are:
>>
>>    ProfilingBufferEnabled() && !SPEProfilingStopped() &&
>>      PMBLIMITR_EL1.FM != DISCARD
>>
>> I think even if PMSCR_EL1 is clear you can still get a buffer management
>> error, even if no samples were going to be written into the buffer. It just
>> says:
>>
>>    While the Profiling Buffer is enabled, profiling is not stopped, and
>>    Discard mode is not enabled, all of the following must be true:
>>
>>    * The current write pointer must be at least one sample record below
>>      the write limit pointer.
> 
> ... but doesn't that mean that R24557 is a breaking change to the
> architecture? The current Arm ARM doesn't appear to require this,
> existing software doesn't honour it so why should we hack extra barriers
> into Linux?
> 
> Will

Yes I suppose it is. The current Arm ARM doesn't require it, but R24577 
is in the "known issues" document for the Arm ARM, so it's saying the 
ARM is incorrect here and you shouldn't trust what it says.

   Arm Architecture Reference Manual for A-profile architecture: Known
   issues

   This document includes the Known Issues for the following documents:

     Arm Architecture Reference Manual for A-profile architecture
     (DDI0487)

Presumably the fix will make it into the Arm ARM eventually. There is 
certainly a discussion to be had about whether this is a good change to 
make or not, but at this point I'm only concerned with making the driver 
correct using all of the information that is currently published.

I suppose there is a chance that this could be deleted from the known 
issues and not make it into a future Arm ARM. TBH I have no experience 
or feeling to say how likely that would be.

Purely from a software point of view, ignoring the new rule despite it 
being published here doesn't feel like it would be right.


