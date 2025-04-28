Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB8625E46C
	for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830608; cv=none; b=nOXwqO5z2n3lsc0aa4IAKZ/PMzsLSUyAuSTQwLAcEN5Ispl4K3v/WgKFra/DIwQ4dePqf2CYwIvpNfrFfXLcU3rE+PSsnsfBWOP/HrczTyc2De+tEl14glV24TvL3EiJPaSj/utejrHtK/tCjI0ovouqCodf2QQ4wBXw0+iE7/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830608; c=relaxed/simple;
	bh=SbDkUeMbMWy7d2cvvkwhlenq11GJmlAJAeJUSWm1BHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erE30vao6SoiDLRjfYRjleWrHY9bbGV2cP72jYa0kYctKq/dJhzHQuRst6qB1KVgrmEXEuDbikNZpujcWE0NHPRLyNeKDiTHacJqG61MWIi69XWELmJb7LwFOcfTvJfo95D7Qsfg9paP60Ytf5fjORrHt4UgdImPw+N/KMKJ/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jQ3XQkdt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jQ3XQkdt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so28752695e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Apr 2025 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745830604; x=1746435404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wlcZn0CPj7R0ttEruwhiQMdrF075DvIb6xYHf7nikhA=;
        b=jQ3XQkdtyFCsJWs5w8mDr/p99VxwF45t4Me9QZN/ZGxG3s69WoApj0SHFtNTCSDX1c
         rBo7y58sGw7ktvE0+K9BKzo5rMmAi5t4cwaXeNXRs0Nv+Pt39EqNlOT+vV7526vR5TFe
         gimPnsRa01/NaKnwurBJVFaWsjCb/cD+vLq2pSEaTZj7IMQaOOKVBZhXIRxRXM39I3kt
         fggF2TFOOXr1zXcngT7x2N7XRKoA/3eyoEkFXtxLLDuqGOQfDL0aSKXGr75pl3ATdh6/
         bUdnagVNF/H05u6Ebmcvjl34MRlpRLC/pFGzP6lM3ai+7Fib+KXRa5Vb09Ub8c+9vbr8
         9zLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745830604; x=1746435404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlcZn0CPj7R0ttEruwhiQMdrF075DvIb6xYHf7nikhA=;
        b=KbmU8g1LmGvOUzh/tIc69s44VGBIOMS/XWXiG/ihsqiOGiZWR4zt7fEupLuqX8LSr5
         J1t9/Cb2mlNI1u1xR4UbBMqPlvppxKAdud4xQ5rxrBcfLLXJcFr8+FS3hWqYVH8aT30/
         cESptANNiRW5uxnZaOMh67MQkhiIFP4n61CbhJUKGso5GSYepHs57BL0K4L6XrHw7bWZ
         NPVWxOl350goxH0RpJSmSEB+DXy1YHJIjcs+C7F7FBvHaeuleldQDbTn9ddndeabD7JW
         EAIdowkLFQx0AvORfsypuicv3g/kc7eodaQOP98+AebkIaf6eAvo0LCm09wBfWfBFvRJ
         p7+w==
X-Forwarded-Encrypted: i=1; AJvYcCVEaB18Xo+bYvIoGw8LDltKOFc9SrWdIkOBlDtVGKS0dWE1KhCJVNkPg8uYiwZ3M9c34wdinprNdPI9T9UfIqvC@vger.kernel.org
X-Gm-Message-State: AOJu0YyMxucM0XKO7G6xf6pGQkhaYiolBJQ8sN8EPIGwAY82gcqjJnFQ
	Y6K3SoNcCAOyqvhaHenBA/2uI1qeGiz8bBa6DQJ5SP8IlVKayuFxKCXlA1eZrCA=
X-Gm-Gg: ASbGncvjPhPX4M2NuAEX9VGxEVueW01yfNTha0ClKR9+Uet2EqBd8RhUiXuSzelfMed
	jKVW0GNm1tPuZoijMff7Kl8O9YspJERekmw3o2SVj/7wBPtTZEmEcD3LLZPZMOm5+Ub5O3k3IKG
	nElzUl0RDrZfIzez4ItCZFL+M6YEqYXIMBHxRCpUBwH1f7e1OxKvpO7F0gwLNgUBgDtw7puLIOv
	FwbDdZZYJI6RB3dpjklSeFxYVHpkAyYIpXH1SNBgMKCTKWQx4AP+yucMf83A7NpuUkuqkahjy4F
	/AfjbNP+mtzSVqIQsn6TDcRXQSqB1B2Ls6XylP4FPuA=
X-Google-Smtp-Source: AGHT+IGu1qPPHs8pclY4hh3uvAZNqEG6T4suIydOxG89FHHVlJPyRkl6PrbVo2UzUBPlfWOSb+09bQ==
X-Received: by 2002:a05:600c:1e04:b0:440:6a79:6df0 with SMTP id 5b1f17b1804b1-440ab848c1amr63152085e9.22.1745830604497;
        Mon, 28 Apr 2025 01:56:44 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a538f4e3sm116621855e9.36.2025.04.28.01.56.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Apr 2025 01:56:44 -0700 (PDT)
Message-ID: <f03715ac-a4ac-415d-8daa-1914384319fb@linaro.org>
Date: Mon, 28 Apr 2025 09:56:42 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: Allow non-contiguous AUX buffer pages via PMU
 capability
To: Yabin Cui <yabinc@google.com>, Leo Yan <leo.yan@arm.com>,
 Ingo Molnar <mingo@redhat.com>
Cc: Ingo Molnar <mingo@kernel.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Mike Leach <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>
References: <20250421215818.3800081-1-yabinc@google.com>
 <20250421215818.3800081-2-yabinc@google.com>
 <48640298-effa-42d4-9137-a18a51637f03@linaro.org>
 <aAeQcgmL-iqGbG_g@gmail.com> <20250422141026.GH28953@e132581.arm.com>
 <CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <CALJ9ZPNLgEBxOmDim-vztUknEETwdL-Z2gJ8K9s44TiPgKZgHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/04/2025 8:52 pm, Yabin Cui wrote:
> On Tue, Apr 22, 2025 at 7:10 AM Leo Yan <leo.yan@arm.com> wrote:
>>
>> On Tue, Apr 22, 2025 at 02:49:54PM +0200, Ingo Molnar wrote:
>>
>> [...]
>>
>>>> Hi Yabin,
>>>>
>>>> I was wondering if this is just the opposite of
>>>> PERF_PMU_CAP_AUX_NO_SG, and that order 0 should be used by default
>>>> for all devices to solve the issue you describe. Because we already
>>>> have PERF_PMU_CAP_AUX_NO_SG for devices that need contiguous pages.
>>>> Then I found commit 5768402fd9c6 ("perf/ring_buffer: Use high order
>>>> allocations for AUX buffers optimistically") that explains that the
>>>> current allocation strategy is an optimization.
>>>>
>>>> Your change seems to decide that for certain devices we want to
>>>> optimize for fragmentation rather than performance. If these are
>>>> rarely used features specifically when looking at performance should
>>>> we not continue to optimize for performance? Or at least make it user
>>>> configurable?
>>>
>>> So there seems to be 3 categories:
>>>
>>>   - 1) Must have physically contiguous AUX buffers, it's a hardware ABI.
>>>        (PERF_PMU_CAP_AUX_NO_SG for Intel BTS and PT.)
>>>
>>>   - 2) Would be nice to have continguous AUX buffers, for a bit more
>>>        performance.
>>>
>>>   - 3) Doesn't really care.
>>>
>>> So we do have #1, and it appears Yabin's usecase is #3?
> 
> Yes, in my usecase, I care much more about MM-friendly than a little potential
> performance when using PMU. It's not a rarely used feature. On Android, we
> collect ETM data periodically on internal user devices for AutoFDO optimization
> (for both userspace libraries and the kernel). Allocating a large
> chunk of contiguous
> AUX pages (4M for each CPU) periodically is almost unbearable. The kernel may
> need to kill many processes to fulfill the request. It affects user
> experience even
> after using PMU.
> 
> I am totally fine to reuse PERF_PMU_CAP_AUX_NO_SG. If PMUs don't want to
> sacrifice performance for MM-friendly, why support scatter gather mode? If there
> are strong performance reasons to allocate contiguous AUX pages in
> scatter gather
> mode, I hope max_order is configurable in userspace.
> 
> Currently, max_order is affected by aux_watermark. But aux_watermark
> also affects
> how frequently the PMU overflows AUX buffer and notifies userspace.
> It's not ideal
> to set aux_watermark to 1 page size. So if we want to make max_order user
> configurable, maybe we can add a one bit field in perf_event_attr?
> 
>>
>> In Yabin's case, the AUX buffer work as a bounce buffer.  The hardware
>> trace data is copied by a driver from low level's contiguous buffer to
>> the AUX buffer.
>>
>> In this case we cannot benefit much from continguous AUX buffers.
>>
>> Thanks,
>> Leo

Hi Yabin,

So after doing some testing it looks like there is 0 difference in 
overhead for max_order=0 vs ensuring the buffer is one contiguous 
allocation for Arm SPE, and TRBE would be exactly the same. This makes 
sense because we're vmapping pages individually anyway regardless of the 
base allocation.

Seems like the performance optimization of the optimistically large 
mappings is only for devices that require extra buffer management stuff 
other than normal virtual memory. Can we add a new capability 
PERF_PMU_CAP_AUX_PREFER_LARGE and apply it to Intel PT and BTS? Then the 
old (before the optimistic large allocs change) max_order=0 behavior 
becomes the default again, and PREFER_LARGE is just for those two 
devices. Other and new devices would get the more memory friendly 
allocations by default, as it's unlikely they'll benefit from anything 
different.


Thanks
James

