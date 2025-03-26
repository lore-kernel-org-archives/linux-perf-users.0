Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52E23E23F
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743010720; cv=none; b=cqRiBfOMHMGzNct8ZekvtdZa7Vg1Lq2u/Xn+uj7WtVDalugCoNatPB7ez3TpyY1abVcmV4MoGEKwUtOiOCStX1WTCd8+Z+9wJfDP6gwcA8qZJ0PT6aukDiDHyMx+RRVQBo0Vfetui/Nd1m2WEWhKr03Ds8cXoG934Y4NzexpgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743010720; c=relaxed/simple;
	bh=2oIE0G5XW4T1LPwCREw3CNOAFjNp0UmQyd+rq0p3SvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuGEM5oby90YMubdOEOkuGINiPxRMXZbFecnZAQOYBlLCIIUqoSjDHfCZLgnnO60I79QBvPx8Ajj2RqnEw6X6T4tDOxlauDbF5cNwCw9LREz/OdII4zhLtYn+XUhZWejvRZJPs9mW/n1a87UCSg9ErT+qQU9GhjW+9Woon0rtmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAf8GKhs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAf8GKhs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43d0618746bso838035e9.2
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Mar 2025 10:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743010716; x=1743615516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8qVND4tenJBQx/xK/Ve6LMeZrg3oeI6UK9LzOuingT0=;
        b=qAf8GKhs0mwZ5APlu1v6/MlD3HXENHCsRwusJcb2T7JaxMCsb20kceDcdrvEyfYgJf
         zAEynptz/CFcxNrXFHvTQXP3Q1HoP8n5CwBEvhY2vHmbeIwVPzm0LOrGb4Xg4q8zAgLb
         fpH25XTmjLsrkFDyGb1gjjWqi7T7p3BYlFW8R4MWW50qZCu7VRZ8vCgVlYC1N82glLW3
         QqK/G2jFgfSEJ3jpJusF6XYYiWqRCXiQDDxXg/4DTd7f+BG6l/6iGNX0tJY1XYdFDj9d
         Ww5h9TAekOIIeCo+wgdQoEN8m4yH4Q3DAgAqfEo9oOFHcetzq4ViBfy10+m9j+hqG6/i
         k8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743010716; x=1743615516;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8qVND4tenJBQx/xK/Ve6LMeZrg3oeI6UK9LzOuingT0=;
        b=dCfbvLaGzB1msrRBzb8LNEhwJNnAKpWr9lDM7kmjA9QHN5XZTYaPTROf8seTe4iWNv
         LIq48LhbLzEMA8DgMVlKxkPPCkEBKmOwugW4HrAAavxHCiOFpvfYB1LqpOzItJ0wMbzX
         7mW2rBdUmOrLEh/HNm/Bh7zkq9grmGtfljrjTUk9KBmXmVS/t1q5izj/gjw5oMBUc04J
         9NkEE/NdqBVij79fgxVo006UvPvMBnHarKgWPVHEq3NE4MkFa/WDVtgKz65GHxQWMHkT
         Vs0HyaE9UmdDLydNbiG8V6toSU5TuVox6QJbltRm7z9KN1y3RF5Klok/u0zKC2Ctw5XH
         5NHA==
X-Forwarded-Encrypted: i=1; AJvYcCUEXPzlMcUlPjLnduKmyxrVexhVQ+u/5UUS22zpzlfJTeo9ZU2kqID93BkhpVAU1uoJN4K58tW0S1Oet3JmpaoD@vger.kernel.org
X-Gm-Message-State: AOJu0YxquM4AlcdSUX+YHEDZSIR023JspBKaUyGNk6D2yAD4f6pOitt+
	d2XhQ1fBB2E1XhRpgIECQSL4cf80E5aDPkUd+jcqYUktvSIox0PvD8XJ4NQcoJM=
X-Gm-Gg: ASbGncsxRAWRmdH0HDKgUBGIH+zXQ0cHjFo3Xr1EkuNvxk6yQ6lkcPU6uWT4HnVk+fl
	OtzdOdSNSLV3ExV19+ci81sZd0Q1A4ng6JiIdw+FvY0kf1dEGwgz2EGPDrDFwYJWO3zvmlk0pIJ
	uaX+YARGqEWbVLGrdWvkxKRqnjJj91slEYWC+JNMHXP0GUCCa2demuuLcalYbO3nwnkKbNhGiHz
	u2p4R6JXaa75zoqV9rvKHsXrfJzCmIEACrJzd4trT2JbVjZ7ezOIHKWdYBXvTH4DS2tu9RgcqLw
	p28Z9NYPiCHY8IkW/k41lPrEHYodwzbOxyGZjMy5oYXNo4cRtQ==
X-Google-Smtp-Source: AGHT+IFWImSgAxE2tnY9m2ZViZ+epH+rNo6E42n/cKyi3Pxy880VgCejpCzrgRBe13sBLMsd3ILXAQ==
X-Received: by 2002:a05:600c:1e0d:b0:43d:10c:2f60 with SMTP id 5b1f17b1804b1-43d8524f43cmr2296105e9.24.1743010716400;
        Wed, 26 Mar 2025 10:38:36 -0700 (PDT)
Received: from [192.168.1.247] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a6326sm17050515f8f.29.2025.03.26.10.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 10:38:36 -0700 (PDT)
Message-ID: <f7d543f6-2660-460f-88ac-741dd47ed440@linaro.org>
Date: Wed, 26 Mar 2025 17:38:34 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 5/8] KVM: arm64: Introduce module param to
 partition the PMU
To: Colton Lewis <coltonlewis@google.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Cc: kvm@vger.kernel.org, robh@kernel.org, linux@armlinux.org.uk,
 catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
 oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, mark.rutland@arm.com, pbonzini@redhat.com,
 shuah@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <gsnt1pulnepv.fsf@coltonlewis-kvm.c.googlers.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <gsnt1pulnepv.fsf@coltonlewis-kvm.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 25/03/2025 6:32 pm, Colton Lewis wrote:
> Hi James,
> 
> Thanks for the review.
> 
> James Clark <james.clark@linaro.org> writes:
> 
>> On 13/02/2025 6:03 pm, Colton Lewis wrote:
>>> For PMUv3, the register MDCR_EL2.HPMN partitiones the PMU counters
>>> into two ranges where counters 0..HPMN-1 are accessible by EL1 and, if
>>> allowed, EL0 while counters HPMN..N are only accessible by EL2.
> 
>>> Introduce a module parameter in KVM to set this register. The name
>>> reserved_host_counters reflects the intent to reserve some counters
>>> for the host so the guest may eventually be allowed direct access to a
>>> subset of PMU functionality for increased performance.
> 
>>> Track HPMN and whether the pmu is partitioned in struct arm_pmu
>>> because both KVM and the PMUv3 driver will need to know that to handle
>>> guests correctly.
> 
>>> Due to the difficulty this feature would create for the driver running
>>> at EL1 on the host, partitioning is only allowed in VHE mode. Working
>>> on nVHE mode would require a hypercall for every register access
>>> because the counters reserved for the host by HPMN are now only
>>> accessible to EL2.
> 
>>> The parameter is only configurable at boot time. Making the parameter
>>> configurable on a running system is dangerous due to the difficulty of
>>> knowing for sure no counters are in use anywhere so it is safe to
>>> reporgram HPMN.
> 
> 
>> Hi Colton,
> 
>> For some high level feedback for the RFC, it probably makes sense to
>> include the other half of the feature at the same time. I think there is
>> a risk that it requires something slightly different than what's here
>> and there ends up being some churn.
> 
> I agree. That's what I'm working on now. I justed wanted an iteration or
> two in public so I'm not building on something that needs drastic change
> later.
> 
>> Other than that I think it looks ok apart from some minor code review 
>> nits.
> 
> Thank you
> 
>> I was also thinking about how BRBE interacts with this. Alex has done
>> some analysis that finds that it's difficult to use BRBE in guests with
>> virtualized counters due to the fact that BRBE freezes on any counter
>> overflow, rather than just guest ones. That leaves the guest with branch
>> blackout windows in the delay between a host counter overflowing and the
>> interrupt being taken and BRBE being restarted.
> 
>> But with HPMN, BRBE does allow freeze on overflow of only one partition
>> or the other (or both, but I don't think we'd want that) e.g.:
> 
>>    RNXCWF: If EL2 is implemented, a BRBE freeze event occurs when all of
>>    the following are true:
> 
>>    * BRBCR_EL1.FZP is 1.
>>    * Generation of Branch records is not paused.
>>    * PMOVSCLR_EL0[(MDCR_EL2.HPMN-1):0] is nonzero.
>>    * The PE is in a BRBE Non-prohibited region.
> 
>> Unfortunately that means we could only let guests use BRBE with a
>> partitioned PMU, which would massively reduce flexibility if hosts have
>> to lose counters just so the guest can use BRBE.
> 
>> I don't know if this is a stupid idea, but instead of having a fixed
>> number for the partition, wouldn't it be nice if we could trap and
>> increment HPMN on the first guest use of a counter, then decrement it on
>> guest exit depending on what's still in use? The host would always
>> assign its counters from the top down, and guests go bottom up if they
>> want PMU passthrough. Maybe it's too complicated or won't work for
>> various reasons, but because of BRBE the counter partitioning changes go
>> from an optimization to almost a necessity.
> 
> This is a cool idea that would enable useful things. I can think of a
> few potential problems.
> 
> 1. Partitioning will give guests direct access to some PMU counter
> registers. There is no reliable way for KVM to determine what is in use
> from that state. A counter that is disabled guest at exit might only be
> so temporarily, which could lead to a lot of thrashing allocating and
> deallocating counters.
> 
> 2. HPMN affects reads of PMCR_EL0.N, which is the standard way to
> determine how many counters there are. If HPMN starts as a low number,
> guests have no way of knowing there are more counters
> available. Dynamically changing the counters available could be
> confusing for guests.
> 

Yes I was expecting that PMCR would have to be trapped and N reported to 
be the number of physical counters rather than how many are in the guest 
partition.

> 3. If guests were aware they could write beyond HPMN and get the
> counters allocated to them, nothing stops them from writing at counter
> N and taking as many counters as possible to starve the host.
> 

Is that much different than how it is now with virtualized PMUs? As in, 
the guest can use all of the counters and the host's events will have to 
contend with them.

You can still have a module param, except it's more of a limit to the 
size of the partition rather than fixing it upfront. The default value 
would be the max number of counters, allowing the most flexibility for 
the common use case where it's unlikely that both host and guests are 
contending for all counters. But if you really want to make sure the 
host doesn't get starved you can set it to a lower value.

All this does sound a bit like it could be done on top of the simple 
partitioning though. And it's mainly for making BRBE more accessible, 
which I'm not 100% convinced that the blackout windows are that big of a 
problem. We could say BRBE may have some holes if the host happens to be 
using counters at the same time, and if you want to be certain of no 
holes, use a host with partitioned counters.

James

