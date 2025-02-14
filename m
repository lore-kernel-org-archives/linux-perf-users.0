Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0F818A6D7
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 10:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739527373; cv=none; b=aS28kgz2llMKx60mwjONBOa4M4/O4eGTJdKnGubspGoULeJrX0+VhJCKlcTFT72vy/Hw13c4y722qjlj8ZbTmq/kweeQftIL+d7nzNbEI/x8KanQsX+eRJfCWXe3qRRu+JS/Dzs3IQOEFYeaCXDhxOzqaXJ5dNAIoLtr1W7hEHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739527373; c=relaxed/simple;
	bh=6IIJKgD/OctiPI/Am9zaDQvl6XDddiVDhmizBXie3+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ziuji08XGRvWZXlXVeWRDAlfB5Oj6z+9MUeCf5ESh5gTjmM+/ADvwLKtUSTuCKeugzposijxA0ftUcFfJOZVIIVFjLX7ZYZDgkU7LskETXjw37IHL1CNRMJ/m/26jjwsJCsdygypHw5V0gf7dDlgm1dm3c7YDr4AbEZ4FjLCKK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RMNgjBdm; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RMNgjBdm"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4395f81db4dso11229935e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Feb 2025 02:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739527369; x=1740132169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WX8WwYpC/7CDpNuf00AfcD8uPd4813egQtu1K93XN+I=;
        b=RMNgjBdmi14GdXF/e/FXOgFkspcAfCbTV6mCByCmutlxIded49f6GkLeesW3gdp/Yw
         D/0cH5oMOQTqyO9QxDy4Mc20zgVLWO7YFbq7xC8fWUvR5050IE1uKIAYzgQ7G824Wg63
         1lkkjYfFHiSU4sdkA5RRu3DVsQDwXOfopaezW2XVyyDQYyqRuyzki56mbsMBK4hL+tTS
         RkH2yZodiqLDCsKfQdNxYXJJ+naScWDikIF8e2YQVZ2kz4KgsXDSM+S8pdQ8pnEo/St3
         iWPXAGzhJYGDtHWYMtKRI8RzgJa3ZGT9StPC6eVWu1I8twf9sTA85F0CPGXCMioyoDz8
         DWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739527369; x=1740132169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WX8WwYpC/7CDpNuf00AfcD8uPd4813egQtu1K93XN+I=;
        b=b2aJBVmMW4a0cTy+s/x6+4BBaL/T9ZnrQHjbX8q3AIGesICkhrPBN/c+M97UMWJjYn
         6qZLC91XH4o6rlfTsc1sl34wY9cMS5socrEW/aFZzU5FpMQfGPf5RuF4MZnlYdzsRrSu
         pXQhPB9WPz+kWHyL4pOilU45+Txtx9Rtg96G3efhw2RHW2CehpgOP7s52nJseVrOTjf5
         7Vsbk0DVo/fwr1pCgmVXwwmM9GS9EHL+a2spBpbTuBB5eeYEJvqPiifwjR2dOtPVfVHD
         5f6wuiT5dPgC7bil1p1NmxruQOgAAeJKDOybaSAUScwaw0LTWJyO/9pUSadq5DIUx5PR
         S1eA==
X-Gm-Message-State: AOJu0YwQ9DD+b1aWMsHiS9mfCb6GyoW9X198+xNl862uLKt9a3lDwWjo
	7/njo2YEhxR+rmXps+dY6M8eItYXro3/s+M6pU5apIvNTlenXZjh94fXaTP2ihU=
X-Gm-Gg: ASbGncuyfJm98tZjIgy7b1eFQ7WYaubdwELR4Ekw40LFHQENkgVkbOg8/ol+HocVP9R
	LFLJKDmGs61mP0lvl6uOMuijyquRi5wQnQi1YHODm3/7ZQVoMDl43mkmK8Be2qKBzWGlDn5itZF
	Vcv85soDT/c4gJHckkEk7XnxVIiarh3EIbjXvekB0n/lLsTUI9uNcDHyti2AF9nSB0u2jyfP2SW
	kU7TCOSwRqPDzmOo8bfm120wb5XkvT3PwkNKpwQTKKIqUbf4d1k6Y3PvIUi400DDIiyWrsMcDJ9
	ItALF2oOQy9ib5WC5RwNljlUtQ==
X-Google-Smtp-Source: AGHT+IGXbOvw8S2GyqkxFIBv52Dq7Q6IHtiiNKaFsB5EmhnCm9g3CNMhqRiW6G3yKYM1hCJUjhidtA==
X-Received: by 2002:a05:600c:a0c:b0:434:f1bd:1e40 with SMTP id 5b1f17b1804b1-43960e81b92mr70034575e9.6.1739527369462;
        Fri, 14 Feb 2025 02:02:49 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396b5267b6sm1615605e9.0.2025.02.14.02.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2025 02:02:47 -0800 (PST)
Message-ID: <1b8b234f-6435-45cf-83e7-8e86c84f075f@linaro.org>
Date: Fri, 14 Feb 2025 10:02:44 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] perf vendor events arm64: Add A720/A520
 events/metrics
To: Yangyu Chen <cyy@cyyself.name>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>,
 Yoshihiro Furudera <fj5100bi@fujitsu.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <tencent_5360DA048EE5B8CF3104213F8D037C698208@qq.com>
 <Z66YjGvjD_yzEHUg@google.com>
 <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <tencent_45B4E91CA370C563D6420A1A25F992056D09@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/02/2025 5:49 am, Yangyu Chen wrote:
> 
> 
>> On 14 Feb 2025, at 09:12, Namhyung Kim <namhyung@kernel.org> wrote:
>>
>> Hello,
>>
>> On Thu, Feb 13, 2025 at 11:11:01PM +0800, Yangyu Chen wrote:
>>> This patchset adds the perf JSON files for the Cortex-A720 and Cortex-A520
>>> processors. Some events have been tested on Raxda Orion 6 with Cix P1 SoC
>>> (8xA720 + 4xA520) running mainline Kernel with ACPI mode.
>>
>> I'm curious how the name of PMUs look like.  It is cortex_a720 (or a520)?
> 
> The name of PMUs comes from Arm's documentation. I have included these
> links in each patch.
> 
>> I remember there's a logic to check the length of hex digits at the end.
>>
> 
> Could you provide more details about this?
> 
>> Ian, are you ok with this?
>>

I think they wouldn't be merged because they're core PMUs, so should be 
fine? Even though they would otherwise be merged because they're more 
than 3 hex digits.

>> Thanks,
>> Namhyung
>>
>>>
>>> Yangyu Chen (2):
>>>   perf vendor events arm64: Add Cortex-A720 events/metrics
>>>   perf vendor events arm64: Add Cortex-A520 events/metrics
>>>
>>> .../arch/arm64/arm/cortex-a520/bus.json       |  26 ++
>>> .../arch/arm64/arm/cortex-a520/exception.json |  18 +
>>> .../arm64/arm/cortex-a520/fp_operation.json   |  14 +
>>> .../arch/arm64/arm/cortex-a520/general.json   |   6 +
>>> .../arch/arm64/arm/cortex-a520/l1d_cache.json |  50 ++
>>> .../arch/arm64/arm/cortex-a520/l1i_cache.json |  14 +
>>> .../arch/arm64/arm/cortex-a520/l2_cache.json  |  46 ++
>>> .../arch/arm64/arm/cortex-a520/l3_cache.json  |  21 +
>>> .../arch/arm64/arm/cortex-a520/ll_cache.json  |  10 +
>>> .../arch/arm64/arm/cortex-a520/memory.json    |  58 +++
>>> .../arch/arm64/arm/cortex-a520/metrics.json   | 373 +++++++++++++++
>>> .../arch/arm64/arm/cortex-a520/pmu.json       |   8 +
>>> .../arch/arm64/arm/cortex-a520/retired.json   |  90 ++++
>>> .../arm64/arm/cortex-a520/spec_operation.json |  70 +++
>>> .../arch/arm64/arm/cortex-a520/stall.json     |  82 ++++
>>> .../arch/arm64/arm/cortex-a520/sve.json       |  22 +
>>> .../arch/arm64/arm/cortex-a520/tlb.json       |  78 ++++
>>> .../arch/arm64/arm/cortex-a520/trace.json     |  32 ++
>>> .../arch/arm64/arm/cortex-a720/bus.json       |  18 +
>>> .../arch/arm64/arm/cortex-a720/exception.json |  62 +++
>>> .../arm64/arm/cortex-a720/fp_operation.json   |  22 +
>>> .../arch/arm64/arm/cortex-a720/general.json   |  10 +
>>> .../arch/arm64/arm/cortex-a720/l1d_cache.json |  50 ++
>>> .../arch/arm64/arm/cortex-a720/l1i_cache.json |  14 +
>>> .../arch/arm64/arm/cortex-a720/l2_cache.json  |  62 +++
>>> .../arch/arm64/arm/cortex-a720/l3_cache.json  |  22 +
>>> .../arch/arm64/arm/cortex-a720/ll_cache.json  |  10 +
>>> .../arch/arm64/arm/cortex-a720/memory.json    |  54 +++
>>> .../arch/arm64/arm/cortex-a720/metrics.json   | 436 ++++++++++++++++++
>>> .../arch/arm64/arm/cortex-a720/pmu.json       |   8 +
>>> .../arch/arm64/arm/cortex-a720/retired.json   |  90 ++++
>>> .../arch/arm64/arm/cortex-a720/spe.json       |  42 ++
>>> .../arm64/arm/cortex-a720/spec_operation.json |  90 ++++
>>> .../arch/arm64/arm/cortex-a720/stall.json     |  82 ++++
>>> .../arch/arm64/arm/cortex-a720/sve.json       |  50 ++
>>> .../arch/arm64/arm/cortex-a720/tlb.json       |  74 +++
>>> .../arch/arm64/arm/cortex-a720/trace.json     |  32 ++
>>> .../arch/arm64/common-and-microarch.json      |  15 +
>>> tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
>>> 39 files changed, 2263 insertions(+)
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/bus.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/exception.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/fp_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/general.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1d_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l1i_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l2_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/l3_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/ll_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/memory.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/metrics.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/pmu.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/retired.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/spec_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/stall.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/sve.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/tlb.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a520/trace.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/bus.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/exception.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/fp_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/general.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1d_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l1i_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l2_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/l3_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/ll_cache.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/memory.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/metrics.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/pmu.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/retired.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spe.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/spec_operation.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/stall.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/sve.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/tlb.json
>>> create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a720/trace.json
>>>
>>> -- 
>>> 2.47.2
>>>
> 

