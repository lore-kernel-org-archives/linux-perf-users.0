Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C650223702
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 11:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332512; cv=none; b=WPME01b2E08HLa6U1GDYU7mqVlcjMbCTga0Yp8qsnotqUO9ypgL1s4Z8G6KnnKhz19OmkNjukkEGvNJbP0v5Pyzbh51SnPmS7YBOgRRrDVbgx33zFBDsSmPniJjrQP8yvtPwRKRNevt5h5i4en6tQKjofUWnRTMwCumka3xm8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332512; c=relaxed/simple;
	bh=/m484UUaQRxvgkJcgREk1OmMS+WmxdgY9pwy+OMkhQM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Yr8XQu/kTXOrlg90EXXNtyuPxGlb4Y7orvCw6d5H5ZlrvuWZO599Saxo6TaI8YcLAScBG58WMIKBa5fourAKMb5kn8pKSAF1eBrR/swG00Iu+eokm6gTZzCtxynTsrY0D4BCFJeDGu34W0z1B6IVLrcgtKWMkoX4lm4+HyZt4So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nb8fcmnb; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nb8fcmnb"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so370413f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 04:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332508; x=1750937308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MpNMm7+iraDtlv3r4NZ2iAVcnI6OhAJlxqB6Otbd2KQ=;
        b=nb8fcmnb+PWZExIFKprOHUAHkbxwKth532r3Gk0IPVjl95YVQO+3HN5RMjs1qVWHXp
         07EPAbiP2e0nCSldsFPFZpD4aWx25FuysweUX39OUMfzomv0Q2Q1KWlVqkyc+hNihk+Y
         x2GPrDi4xIBb6mCsyh6RMJjF4QjJSU833kWqSud+xNIIYHb40EetvZmY9vmIgM7oNdZw
         ugQ4cnPfk4bYwF5oAqjaFGCKmc/DMAjtBfbLDTNX2TVHBEnqtcGn+NT2PI0vAuNO17iy
         ltMe1W7gb6p+eAuf3cWG/QAk5WxhqhEb4RuZXuQllPkjCRU7xZ7qjx+ZSEY951Zw+3fZ
         3Tig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332508; x=1750937308;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpNMm7+iraDtlv3r4NZ2iAVcnI6OhAJlxqB6Otbd2KQ=;
        b=Fa+f/3oKV2zwn3zeMaQUCdlM7s8RB8IKBxYcUngWuJONMknKBlm0oy0rYhY1HDwm6S
         ck4sDf83rqu60M4e8Fsmf8CMXS8OphEFauAdvWYOfBC8EW36dh5wLiIZhPm+eKE7+cm8
         HM0cs5jR3SG/i+Sr/hywxzHmBW/5GNQNvh8ZZzQYxZm82H7fvJVdVRqbfliSZ+9e70uA
         jpF+4dxrin/2FW0BG5j02ZhS1axuKXlk3uoWOd7ASHhFlA7/8Tz1UeX9LccdyMFFY0Ed
         BnxPaTz0SC7WUPecJF2cHutG2npZoxRfQUDseo8JUiySOb8GkyIpebKVDlgu6nrkrORa
         6sYw==
X-Forwarded-Encrypted: i=1; AJvYcCVUPKVrXNah2IW9f0ao6+GKZpZp6WsoUP1zrDEhoR/lj3RpSAC5+iHBYXMDG4YYKHsQ1h2tvSStvZRciVZDPsHQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxOQTUsaXuMzTpE3QTQAitfMiqc18iHYHrPxegudHfLQ+ywwV/D
	ox2F17ZbaYqhkjOJb1ou1RMrv+PUH54dvOMdUtNp+VNSJKHdbDp3ON67Jjj0kqbMxqs=
X-Gm-Gg: ASbGncu4XaHFYaZciExWzqeyJmYmTzGflR17q74DXa9mNTHrrBUI+RqK9xahXWt9GSK
	+BUYOhcZiVFzsJKfL24Yh1fhXqLzo7PtOleDMhsR5s3S9D24Az1eENqGBX2M123vEiT1vcOn0Kv
	6IHgVNfBvu5IHVlo7tUKNo9YrJo+q9DJM8+KGiiuTL/zoTs4JO0f3ySge9cmpE7JCHEkkMNo9So
	+bzDIOAYMs0AtHtF9bSBJ3NdWmCN9nsK49D5kT8753lk+crlfgXOLgA6oxm5nk9UYRVGnvh9x9N
	8EWzgm+9UbTWLMFfijMvh9mdOZ2vFJrdcPLfNQLGIOA0DTSE1qV3kyR40kzjEE4eRsVPH4zSLhB
	s5A==
X-Google-Smtp-Source: AGHT+IHC0sbX9Z9VqfAmAZiUDmN26P+ig5+XGpKEWeMktgLCD/97lAcJvUfJW5zzgit7Gtv3T8jF7w==
X-Received: by 2002:a05:6000:4304:b0:3a4:dc42:a0c3 with SMTP id ffacd0b85a97d-3a572e9e438mr17317684f8f.56.1750332508563;
        Thu, 19 Jun 2025 04:28:28 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a6ee12sm19274954f8f.31.2025.06.19.04.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:28:28 -0700 (PDT)
Message-ID: <3a833298-10a1-4c6a-8a90-6836c47a1dcb@linaro.org>
Date: Thu, 19 Jun 2025 12:28:27 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] drivers/perf: arm_spe: Store event reserved bits in
 driver data
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-0-6faecf0a8775@arm.com>
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-1-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-1-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Store the reserved event bits in the driver structure. This cached value
> avoids redundant calls to arm_spe_pmsevfr_res0() each time a profiling
> session is created.
 > > Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/perf/arm_spe_pmu.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 3efed8839a4ec5604eba242cb620327cd2a6a87d..be2ed326bb794d7e5dd1d6cfa89330753ced3ca5 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -77,6 +77,7 @@ struct arm_spe_pmu {
>   	u16					pmsver;
>   	u16					min_period;
>   	u16					counter_sz;
> +	u64					pmsevfr_res0;

IMO this is a premature optimization and we shouldn't store things that 
are only transformations of some other already stored value. It becomes 
another thing to worry about when it's valid to read and to potentially 
keep it up to date etc.

It's just one new one now, but eventually you end up with tons of them 
and then someone forgets to update a dependent one when the parent value 
changes and it makes a mess.

And arm_spe_pmu_event_init() isn't even a particularly hot path.

>   
>   #define SPE_PMU_FEAT_FILT_EVT			(1UL << 0)
>   #define SPE_PMU_FEAT_FILT_TYP			(1UL << 1)
> @@ -722,10 +723,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
>   	    !cpumask_test_cpu(event->cpu, &spe_pmu->supported_cpus))
>   		return -ENOENT;
>   
> -	if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
> +	if (arm_spe_event_to_pmsevfr(event) & spe_pmu->pmsevfr_res0)
>   		return -EOPNOTSUPP;
>   
> -	if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
> +	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
>   		return -EOPNOTSUPP;
>   
>   	if (attr->exclude_idle)
> @@ -1103,6 +1104,8 @@ static void __arm_spe_pmu_dev_probe(void *info)
>   		spe_pmu->counter_sz = 16;
>   	}
>   
> +	spe_pmu->pmsevfr_res0 = arm_spe_pmsevfr_res0(spe_pmu->pmsver);
> +
>   	dev_info(dev,
>   		 "probed SPEv1.%d for CPUs %*pbl [max_record_sz %u, align %u, features 0x%llx]\n",
>   		 spe_pmu->pmsver - 1, cpumask_pr_args(&spe_pmu->supported_cpus),
> 

