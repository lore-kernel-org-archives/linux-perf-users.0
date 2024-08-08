Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79A18CBE9
	for <linux-perf-users@vger.kernel.org>; Thu,  8 Aug 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113614; cv=none; b=oBMFs2mkTVPWG3A3Mpw9e1CRtb/2I33V5VVTIGzkwcD8PwoxQbs8b5JdeuJ1HGFU00l4u/cymTf+z4KCtk5tRE50PKI/Qwio0BqBTa89rpcsVPhr5dBrN1qWBfZgaScI9LgyaTIK85lkJBhnrt3xR+oIIUgfQYD8xlmfeUrtDAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113614; c=relaxed/simple;
	bh=93EvhuTl9ahqB5emxkAMtf9z0ofEgXEiFiod3siNX7I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A3df49XfbSV4/rQKGXAynE3nLTu0AK4AagwwNz4GVbYsvTkJqwBYgFAgWtPIOqkigHNXriGcnz7m8sVUyR6uw0KmFLN+lSBZjf/xKYWDUur3EksKjU+2P1omXkHOPcUv/NmqlMdVRii275vTKFUq8iRGYjff0wj1oIvfBPWahes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIK9K2KT; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIK9K2KT"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-428243f928cso5273935e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 08 Aug 2024 03:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723113611; x=1723718411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Vywnv2khWwNnQXbEb1k0L/IQrqUeraWcCrhITh2GYs=;
        b=MIK9K2KT8LuLBxskCnDtBcQbyvCV33fYpsicldzOmBRoBfJkMrDJm0eAwESrD3Lme5
         oFOPzOUkBAnEz7NtiUMyY2GKx/x0Sp6xoR60r13hH8VpceEk3rViglWH7Fyt+SZFdPco
         wcg3ea0EPgj/mWKJhHhMr3zsUIi8LjwfPklpSobbVcghlw8SunHvJo2pC8CE32n0HAQj
         3KBFYKE82mWwH6+5ND7fvDdXak+6RyXkrqvmdLDsdMlreKdkcCYmhcRtARojBGkLmwu9
         rTdQkqSs8T5MsdRFdCLGbvRTBtG8TInLN9vUS8JqzuoslbTnaSI0ZaxA64XegpqDmWN3
         /gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723113611; x=1723718411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Vywnv2khWwNnQXbEb1k0L/IQrqUeraWcCrhITh2GYs=;
        b=fm4Btdhf8RV+PJ8QTuqzG/j3uUjY08FKyo5DDR2BaQRAqlc7rgmAJ7JQugbyvPUqPT
         3nwocTzbXZnCe1w2QvY6B29BVaQPGTi7L3d8xSBgvuDV0HABgrGkBGvHhZ937uVS6E/L
         egf/wiKxXbfY3Uqrs8aEd6MQ6TnuuWkBHMejXeFMiB7cuGnkHFBBf8kspU1RcjeIyaNC
         +q9CZSkWQ3daHLXL2osS6JEoWGHAmnEZSLFvqV3UYTq1rjw/8zrt6rq8dXvOU1VA8S5y
         Il0zMz4iwWAKB7pzptJipHPqzGm/PSyKvU30dc0HF2pA0sOKpx1s9w6CgUaduK4xOrxm
         udhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAR7rG5TMQJ/XUwf8a8hrCFP/a3Xa8VcNopdwWqS63a+RDDDcb1NUMm4saI4erc3bHGKaPyhmfIW+cHsVczb3o7ufUj5a4+g1llkbnlrLXDA==
X-Gm-Message-State: AOJu0YyxR0b+aN0utfSte/kcWOL1rInitsjtlHSrfzPmrmCAEkUWFIp0
	ifnk8lMI7g080HFZpd3TJLBV/ZtKv+wafLFcJlWHKx0LpWspfiR9QUcemCJJjkE=
X-Google-Smtp-Source: AGHT+IEGxZsKPo0MfhXCCFxSfCW7K4JInkbw4e4NnCHx4wlQJHciyyD/pmRe1wNjUVMP3CXg9q2VBw==
X-Received: by 2002:a05:6000:1007:b0:367:9614:fb99 with SMTP id ffacd0b85a97d-36d273bfaf4mr1044354f8f.10.1723113610569;
        Thu, 08 Aug 2024 03:40:10 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d271569d1sm1459252f8f.18.2024.08.08.03.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 03:40:10 -0700 (PDT)
Message-ID: <67ac1ce4-7d95-4215-ae49-c32869bfe6eb@linaro.org>
Date: Thu, 8 Aug 2024 11:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] arm64: Add support for Armv9.4 PMU fixed
 instruction counter
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Oliver Upton <oliver.upton@linux.dev>, Zenghui Yu <yuzenghui@huawei.com>
References: <20240731-arm-pmu-3-9-icntr-v3-0-280a8d7ff465@kernel.org>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240731-arm-pmu-3-9-icntr-v3-0-280a8d7ff465@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2024 5:51 pm, Rob Herring (Arm) wrote:
> This series adds support for the optional fixed instruction counter
> added in Armv9.4 PMU. Most of the series is a refactoring to remove the
> index to counter number conversion which dates back to the Armv7 PMU
> driver. Removing it is necessary in order to support more than 32
> counters without a bunch of conditional code further complicating the
> conversion.
> 
> Patch 1 changes struct arm_pmu.num_events to a bitmap of events, and
> updates all the users. This removes the index to counter conversion
> on the PMUv3 and Armv7 drivers.
> 
> Patch 2 updates various register accessors to use 64-bit values matching
> the register size.
> 
> Patches 3-4 update KVM PMU register accesses to use shared accessors
> from asm/arm_pmuv3.h.
> 
> Patches 5-6 rework KVM and perf PMU defines for counter indexes and
> number of counters.
> 
> Patch 7 finally adds support for the fixed instruction counter.
> 
> I tested this on FVP with VHE host and a guest. Also ran kvm-unittests
> in Arm's kernelCI.
> 

I ran the Perf tests and poked around a bit with PMUs and chaining 
events (on non-fixed instruction counter hardware):

Tested-by: James Clark <james.clark@linaro.org>
