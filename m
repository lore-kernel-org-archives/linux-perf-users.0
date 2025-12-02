Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE4B3115BD
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764680391; cv=none; b=gQR3VMMYd1vIcQ+eADW+KxZuKaFSdZqd6GucAW52CaZOGXJTFGdKe9rKgtE2C3GxcXXUJdDWmEX1lzv5H3Bi20B4Yq4rATWkoAoVDa0mo+ewIYcMhcjr3SzZ3fI4hn0h8iBvOpHHT0DWyhA8d9umG8jdu+MEeN0QXHEceLfYigI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764680391; c=relaxed/simple;
	bh=FhcoGrTVLlYrtuJI2SCflJBzTrwBba81B0g0O8R/w3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=o+G8Z/fkkH05QX8XTEm2GjwFkKxdF8ixZvXxpkxHNYaXiaHkaNo07HB6FXEwHeRo/oYSHbqM/unuvD/tXe/HTq/+38vI5Be1X5I3WCwjzU2gBMx+kYTIQUpLXOPLfqgvVYDpSz14KyM8XiKBe/zGuYY3XszdWBuWTUlnNHGUhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DgELA0uM; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DgELA0uM"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42e2b80ab25so1512885f8f.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Dec 2025 04:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764680388; x=1765285188; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z+ls4lUKyqIXh7xVjbyit136L3KGyzdT9oph+fPZ8XY=;
        b=DgELA0uMVCAA40gTvdO2FxVsqLO/c9BWd/mJOtns7t3o/CKc3+ywcTNVWv5IHMvK+3
         0mz7BejMF+V9TsbLa4LdCpGvlfKx/TooxYpI1QFUNUQtiNyMv4l4xLUyEu86rwmiLSv3
         zC4m0TDru//o+tgDCyLj+v2wd/sbBOv9liFj4Wz5VuvA9IPQSuhrJpKIjDjwkrhn4wI+
         pR3Bj3Jygfkg1QhpREUJOsPchLC5OxaaicYOISc5YTlrc4hSMxe80t5Y4e1+Wflz//OG
         /v7xzN4RnSE4BHfFpBrz4Td+5v7Dx3/ZxFycEWIHy7dPIK4sI5Lwx8JY8b0fPPoFEWY3
         Tzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764680388; x=1765285188;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+ls4lUKyqIXh7xVjbyit136L3KGyzdT9oph+fPZ8XY=;
        b=rHLqNYLRrMGbVjAjbdmQ9G/A9us1nyacqj44cstCvgdc8C4oTTE1B1O8/HHizRypju
         GJFOh7ShAIPshftts1phxqZgKDtsYn5JciWI2VqGG84rx+zX0EEbL8jL2+2jMyV8gBmQ
         YJ0DvJGSm5hUdJ+VXnK/Pmz2x2lOqfsZvoLY+Go7VEUh2DF9ER2JworA0IC8DA8o2x4e
         Rz+1zmY2m3Ija5Lj0TuGfRBAnkktuZmU8HQAl2kwASHG6/UKgumrLwJPCFbQytqkDg0k
         DWYdI27JlkF/vQMoG8PuXz2b+RndTE7Tkd5XmvYxPLRgP+lSDH/0P+7XZaA6Cp7zYNOG
         xT+A==
X-Forwarded-Encrypted: i=1; AJvYcCXeG5kH6LmejquFzEYA8KSdPzV85d6bxZx+MVfPFET55eROz2/eR3yrglFSM4UZ15rgsq5K+wmo+k7w6YLtKX82@vger.kernel.org
X-Gm-Message-State: AOJu0YwhAzfsoHl6UhKtf5qYYyJr2sgN2J2W0kgeEz6+0QdFY43Eistg
	9jrZFzKDvTAukSJEN7t6jdUJFCYbH4jECsrXt38xARRpfcQIB5pOc9M/1u2GGFy7/rU=
X-Gm-Gg: ASbGncs1WdiTAm83HSaCtJks5uKMmQxo4llm62LGXv0jOrLh6wiQFO9hL1eof3fXwxL
	ep99KrrFW4TWvLilarIkvzhgRyStUaK3vTC/y6/U174U/su5l/Rr5xJkqIcSSLgEFJoh1QMzqZN
	TBiUQZCNvZSrW4kRUKmUqg5UXIO3pqPDjLGqRxIMzqED1FEs/NFr5gQolwK4Kd8RaTk5wiyDpQj
	nwiKZFifRvNXZD97wPPBS3HyD6pf6oAAIlfcwdkL737XiQB3VajTVMWrgr1APkfZ+XDyWw7EJ6X
	fN0YE+QvWhyWqWt3BdTWUzNWmId/pMm/tdXeuU8Nzotrw85/L1C4xgkixZQR3Ae2NXm9OSgchIT
	RCfQHtizwmOPDF0HMD2NOITVd/6GYVzuSpRbXvJ0PSPYoi0j6BwhGduAag4mZyyzihaGZCFGj0E
	Oogvbr+2n0/KzSGTDf
X-Google-Smtp-Source: AGHT+IGscgmO9lGvKECfXYxarz54H8vd6b6Z8s96skxFG4vOheFhB/1RykCLMjNWz27fHa4U3hWjMg==
X-Received: by 2002:a05:6000:1887:b0:42b:3cd2:e9bc with SMTP id ffacd0b85a97d-42cc1d352d7mr43033216f8f.39.1764680388191;
        Tue, 02 Dec 2025 04:59:48 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a310sm34376220f8f.26.2025.12.02.04.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 04:59:47 -0800 (PST)
Message-ID: <653a7555-18e6-4066-993d-412a63a63f51@linaro.org>
Date: Tue, 2 Dec 2025 12:59:46 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] perf arm-spe: Don't hard code config attribute
To: Leo Yan <leo.yan@arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-7-22ecbbf8007c@linaro.org>
 <20251202122835.GY724103@e132581.arm.com>
 <20251202124240.GA724103@e132581.arm.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Mike Leach <mike.leach@linaro.org>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251202124240.GA724103@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 12:42 pm, Leo Yan wrote:
> On Tue, Dec 02, 2025 at 12:28:35PM +0000, Coresight ML wrote:
>> On Mon, Dec 01, 2025 at 04:41:10PM +0000, Coresight ML wrote:
>>> Use the config attribute that's published by the driver instead of
>>> hard coding "attr.config".
>>>
>>> Signed-off-by: James Clark <james.clark@linaro.org>
>>> ---
>>>   tools/perf/arch/arm64/util/arm-spe.c | 15 ++++++++-------
>>>   1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>>> index d5ec1408d0ae..6c3dc97fde30 100644
>>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>>> @@ -256,7 +256,7 @@ static __u64 arm_spe_pmu__sample_period(const struct perf_pmu *arm_spe_pmu)
>>>   
>>>   static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
>>>   {
>>> -	u64 bit;
>>> +	u64 pa_enable_bit;
>>>   
>>>   	evsel->core.attr.freq = 0;
>>>   	evsel->core.attr.sample_period = arm_spe_pmu__sample_period(evsel->pmu);
>>> @@ -288,9 +288,10 @@ static void arm_spe_setup_evsel(struct evsel *evsel, struct perf_cpu_map *cpus)
>>>   	 * inform that the resulting output's SPE samples contain physical addresses
>>>   	 * where applicable.
>>>   	 */
>>> -	bit = perf_pmu__format_bits(evsel->pmu, "pa_enable");
>>> -	if (evsel->core.attr.config & bit)
>>> -		evsel__set_sample_bit(evsel, PHYS_ADDR);
>>> +
>>> +	if (!evsel__get_config_val(evsel->pmu, evsel, "pa_enable", &pa_enable_bit))
>>> +		if (pa_enable_bit)
>>> +			evsel__set_sample_bit(evsel, PHYS_ADDR);
>>
>> Hmm... I am a bit concerned for the evsel__get_config_val() usage
>> throughout the series.
>>
>> evsel__get_config_val() returns a whole config value rather than the
>> bit field specified by the format name.  If other bits (but not the
>> "pa_enable" bit) are set in the same config set, would it wrongly set
>> the PHYS_ADDR sample bit?
> 
> I saw you used FIELD_GET() to read specific bit field in
> evsel__get_config_val().  This is not concerned anymore.
> 
> Sorry for noise.
> 
>> Seems to me, for reading specific format, perf_pmu__format_bits() is
>> more suitable than evsel__get_config_val().
> 
> For me, this comment is still valid, given perf_pmu__format_bits()
> will always exist.
> 

perf_pmu__format_bits() only returns the mask for the format attribute 
that's published by the kernel. It never changes depending on what 
options the user provides and doesn't even say which config field that 
mask applies to. It's fairly useless on its own and should probably be 
made private to pmu.c if we manage to refactor its uses out of 
intel-pt.c. Although they're a bit more involved there than here so I 
won't touch it now.

evsel__get_config_val() returns the value that the user provided for a 
named attribute which is what we need to do here.

> Thanks,
> Leo

