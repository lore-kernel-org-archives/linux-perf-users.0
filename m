Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A258F278E5D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390729; cv=none; b=Muls/VWBwNS+I7RRuQHgJpRxfAx4ihGOSdUPwYNYLsQNygO6AFyU9mtb0iHVHCYSLRmYbi3iBEA/J6LV3AtwewC0SEnmY6GaRKC1g2AqdZPYhOcjYaZI7Rt2eCCTgDQFAb/I2/vpgrGSWUL6xq/zvtVyZQrlRMCi9x/asQ9KwEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390729; c=relaxed/simple;
	bh=TGeABG+Fxo5bWvm0touv8P9KtgJeqwXStuG1jicNL4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azjY1DCykxWqP6CLJvcNjkJUFsKF4jqn02HJasHRdaj9aWod9lXg1G1rinjLfKvLtB3ig1ZH/ZHHBRX/m9NEKT88YkfJ/pJhcTWcFjhyBbAxXJREiNX53InYaVfNa/HDGHCgtVU/FWqAQi/I84odBo9nia9PeouPI4jiLAntvto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mmRvwwBS; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmRvwwBS"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-435a11957f6so1787979f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 07:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770390727; x=1770995527; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7THg7qGGKH4Oa16ZjhKMQ6LVc9gjkrDpVzn2/FripOk=;
        b=mmRvwwBSS0yfpAF4raiWR0kYZQlj5Fp32flEW03Dn7gtelW/9HbRL793Awa9AGFdwK
         grXysbwY5h2RqTWE4m47fHisau6h2M707DgxlzsU7rPBtQf3jNIA40gI5BZ4S47LuEuw
         IeOPBNk/+VKlNlIqRAIImK1+tlRkMFdlcNaGUEyzfqQ/rUWZOPSM9PUiY2RLzhAKL8t7
         9VewR3WB6xqF+9uEvNtLfGrwVma9icAYX5RXDeFoD5AW2GImyv621SKwOraZNv/g4MIl
         2eAGeywCnh/xBjRlKqY/wFg16yqziOP8iErN+NgbRvY+2oE3IzFhWRuSpAwDdmmglFDh
         xuYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390727; x=1770995527;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7THg7qGGKH4Oa16ZjhKMQ6LVc9gjkrDpVzn2/FripOk=;
        b=AcFW02aFpiHdWKChZxktZEulP5kQESXaJcsbe7gTRq7rMy5yqHfFrJVyjLr6KwbCrE
         oEorEB+gjQ1AJCJLi1ycUKw3k0VX8Fbsdp5zIaRS+bJSncJP1VRKh26J/ZC7hSMYTy7e
         I+/KrnSFqvtLzgpRnbeuDi6kVfU5MQxttokDKuM1mKHbLCJ6uNRahh1W20D4AsWJWDkV
         2y05cClr44xTzdQ2AovXFeynPDxYxXCzGgzWIxRevr7eGHu2dtAjJL1tFd7YM137s5zz
         XrP3Ln6UgYxK9rhHGrvTlW6BetYb+TTRveJrXbufAH/V6pPgdyPEm8x5aTntXZuZFrtw
         m9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVDM3msAswOEukpyqj44Vplz6JffAuvjrdDMyA02jvV5l6m/Vdir9r1NoXlYZlIKKjVBxxAysS0S+lPVnjusEG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6LoB4Uq0oxx1xCEuJm6rQwiEk4bAd5rucvLpeEMcPOVMIcCEM
	+G36jniHgXyyoxR/ULLSw2QSZQ6MeMmYk15q7gXKmKg8YqXpPXJZQqJmpxhK+yLYZ7A=
X-Gm-Gg: AZuq6aI9CF53tFimfQTwO3gNCHWmbEo5g/Acj9L4Sl3pZs0cnth/0AzteIQZu1aVajl
	McE28qy1BU6+hn0KrhfNwegj9o1UPHqpkaixm0yeChs/rK1Ly0pk8PoZS98ASmtJkBLyMUb5lNc
	egKUxvQOyzULCP1xg5fI1Qj1z7Pn2LLiCDPdTD0Igg3FduqGkr4O/psupaxlZKvbTV+s9WDvtGC
	XcTF0L5cgfTHK8St4/m1oGjcNKOVU5uTbmAOXJv0jyoNA3UML2Mfc/iUKE3LNSxhVHeC+ydzipi
	JJwqkhE1NCLBLYR4qzaT4P1AYl0N0ZMPcaEgE3txn/tR5Kl/W3ROjGiGP6hmRUzXr1QdeLn87UN
	ZLPc34CeYkrH6TDoFFac1RLJnqPZMQAEiUkaKcxB0+2xWvcS1T1IkYAVmfCzvCGW981GkLLcMGU
	ve61nbJQU+l0vXomKPBzZdD/m4h1M=
X-Received: by 2002:a05:6000:240e:b0:436:23a2:5e25 with SMTP id ffacd0b85a97d-4362938fe8dmr4932542f8f.44.1770390726896;
        Fri, 06 Feb 2026 07:12:06 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b25casm6941427f8f.4.2026.02.06.07.12.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 07:12:06 -0800 (PST)
Message-ID: <293a4d85-a320-4280-9607-5b9d08ba555b@linaro.org>
Date: Fri, 6 Feb 2026 15:12:05 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf tests: mmap: skip rdpmc tests when sysfs disabled
To: Qiao Zhao <qzhao@redhat.com>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org, leo.yan@linux.dev,
 namhyung@kernel.org, mpetlan@redhat.com, acme@kernel.org,
 vincent.weaver@maine.edu
References: <20260203141608.14128-1-qzhao@redhat.com>
 <9d7eb5cf-e998-4b77-9b8d-7f0ff6b2da36@linaro.org>
 <CAATMXfm88MZ3Fhc0upRQ_5D2Vy+g8CscVAwhfY7nbM9oX93Qvw@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CAATMXfm88MZ3Fhc0upRQ_5D2Vy+g8CscVAwhfY7nbM9oX93Qvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 05/02/2026 2:14 am, Qiao Zhao wrote:
> Hi James,
> 
> Thanks for the review and the question.
> 
> I did try modifying the check according to your suggestion, i.e. changing
> the condition like:
> +      if (!rdpmc_supported && (pc->cap_user_rdpmc || pc->index)) {
> However, with this change the tests regress on ARM, the results are:
> --- start ---
> User space counter reading 1
> User space counter reading for PMU armv8_pmuv3_0
> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> unsupported counter access 1]
> ---- end ----
> 126.4: User space counter disabling instructions                     : FAILED!
> --- start ---
> User space counter reading 0
> User space counter reading for PMU armv8_pmuv3_0
> User space counter reading for PMU armv8_pmuv3_0 [Failed unexpected
> unsupported counter access 1]
> ---- end ----
> 126.5: User space counter disabling cycles                           : FAILED!
> 
> On ARM, cap_user_rdpmc represents a PMU capability and may remain
> set even when user rdpmc access is disabled via sysfs/sysctl. In that case
> the mmap page reports: cap_user_rdpmc = 1 and index = 0, which is an

That's a slightly annoying difference to x86 then, which makes it a bit 
harder to test.

> expected and valid state when rdpmc is disabled.
> The intention of the existing check: if (!rdpmc_supported &&
> pc->cap_user_rdpmc && pc->index) is only to catch the inconsistent case
> where rdpmc is reported as unsupported, but the mmap page still exposes
> a fully usable rdpmc state (i.e. both capability and a valid PMC index). This
> avoids flagging the ARM case above while still detecting real inconsistencies.
> 
> With the current logic, the tests now either pass or are skipped as expected
> on ARM, and there is no behavior change observed on x86_64.
> 
> Thanks,
> Qiao
> 

But "rdpmc_supported = pc->cap_user_rdpmc && pc->index" here:

   if (saved_user_read_state == USER_READ_UNKNOWN)
       rdpmc_supported = pc->cap_user_rdpmc && pc->index;

So I'm still not sure I get checking rdpmc_supported with those exact 
two things again.

In fact I looked more closely and the test is already setup to write to 
<pmu>/rdmpc to run the test twice with it both enabled and disabled in
set_user_read(). We only return USER_READ_UNKNOWN in that function on 
perf_user_access platforms, but only because that function doesn't know 
the place to enable it is /proc/sys/kernel/perf_user_access.

So actually we should modify set_user_read() to try enabling in both 
places, and then the test can test enabled and disabled outcomes on Arm 
as well as x86. Now that we know there is this other file we can make 
the original intention of the test work with it, rather that just adding 
a skip and not testing anything.

> On Wed, Feb 4, 2026 at 5:40 PM James Clark <james.clark@linaro.org> wrote:
>>
>>
>>
>> On 03/02/2026 2:16 pm, Qiao Zhao wrote:
>>> Some architectures control user-space rdpmc access via sysfs or sysctl,
>>> for example /proc/sys/kernel/perf_user_access on arm64/riscv or the
>>> rdpmc attribute under event_source devices on x86_64.
>>>
>>> The mmap-based rdpmc tests currently assume rdpmc availability purely
>>> based on perf_event configuration, which leads to false failures when
>>> the system globally disables rdpmc access.
>>>
>>> Introduce a helper to detect rdpmc availability via sysfs and skip
>>> user space counter reading tests when rdpmc is disabled by the system.
>>>
>>> The check is only applied to USER_READ_ENABLED tests. User-read disabled
>>> tests continue to run unconditionally, as they validate perf_event mmap
>>> semantics independent of rdpmc availability.
>>>
>>> Additionally, tighten the unsupported rdpmc check to require a valid
>>> counter index, avoiding false failures when cap_user_rdpmc is set but
>>> no counter is assigned.
>>>
>>> v1->v2
>>> - Check rdpmc availability via sysfs before running USER_READ_ENABLED tests
>>> - Handle both perf_user_access and rdpmc sysfs interfaces
>>> - Avoid false failures when cap_user_rdpmc is set but no counter index exists
>>>
>>> Testing:
>>> - arm64: rdpmc disabled by perf_user_access (tests correctly skipped)
>>> - x86_64: no behavior change compared to v1
>>>
>>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>

[...]

>>>                if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index)) {
>>>                        pr_err("User space counter reading for PMU %s [Failed unexpected supported counter access %d %d]\n",
>>>                                pmu->name, pc->cap_user_rdpmc, pc->index);
>>> @@ -307,7 +348,7 @@ static int test_stat_user_read(u64 event, enum user_read_state enabled)
>>>                        goto cleanup;
>>>                }
>>>
>>> -             if (!rdpmc_supported && pc->cap_user_rdpmc) {
>>> +             if (!rdpmc_supported && pc->cap_user_rdpmc && pc->index) {

This weakens the test on x86 though. If they behave differently you 
might want to just skip it on platforms with 
/proc/sys/kernel/perf_user_access and add another test for them that 
pc->index shouldn't be set if it's not supported, but ignore cap_user_rdpmc.

>>>                        pr_err("User space counter reading for PMU %s [Failed unexpected unsupported counter access %d]\n",
>>>                                pmu->name, pc->cap_user_rdpmc);
>>>                        ret = TEST_FAIL;
>>
>> Not sure I understand this test, shouldn't it be (pc->cap_user_rdpmc ||
>> pc->index)? As in, you don't expect either of them to be set if
>> !rdpmc_supported. But then it's the exact opposite of the one above so I
>> don't think it does anything.
>>
>> Either way the test now passes or skips properly on Arm:
>>
>> Tested-by: James Clark <james.clark@linaro.org>
>>
>>
> 

