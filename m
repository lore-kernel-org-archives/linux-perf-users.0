Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C19220C49E
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 10:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745317294; cv=none; b=MwmrmR3JFs6IdpJQp9ZqAVkzpEnS2BNqFRy4FQWfWGFhVLVMJqtizeUm5LIM5PQqF4h/i3V4VQ8q5YkI2ZsFGVk+qSEh2S8fFpu+LSX9heuP95q4pQDKnzhKq5rtLwccVrsZ+iinmOiYw5mdCdTGqSFa3Qp8cCS2U1fGlq61w0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745317294; c=relaxed/simple;
	bh=vPaSK1YJPMimS0f/8osQJzDVTRZjiow/jJ+CiwFH3dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e/qixx9JzjwSX2JzU3ZQELthYdKMj9j5uBT83f1YkjSc5FaViZlsLbHK6WZBYffjdFTtE+kOhMR1LW05VnBp5IMCj+yDYiaiMICShwFzHZXz/BnsrGjmxFTCyLXBXDb9g4tDJJCNpBCVs0Q7Ti+eLqhJ3qlifJnjKCMwxQULVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SoDqO9dq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoDqO9dq"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39c0dfad22aso3469967f8f.2
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Apr 2025 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745317290; x=1745922090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JvWmQrsXg9zHl1MPjQw5tN8WwrpI48NyLqFNhUg6Edg=;
        b=SoDqO9dq0Aa2aew459oPiT2uYtaMADhxTOXvHOJMHiTApHI7ULln7G+pqna6lVlU+C
         NAzXtEpAGlGZmcTRSBCl9kCqoc9cnOscNy/QZvs6fklL4qDTDETydZ+QfiAg93zcNH1U
         wF9VZdiI4dqwx1ncEHTdPW+wE7SnN2LL5lX8Egm5NNmiSN1rdA66ETpMlgKDfdUpLAQw
         +KORWQArmNMTjlwst9DTeQd2o3hXaMmbm15PHboGdd7nvuro6BVUTtknD1VRM7jW2Rpw
         iMNTKWAwS4OIvZAcGXnTSCpUO7S/m5O/M36AKFB2iXrn0oVoaaDXtr0ILX/x2GyImcMF
         C6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745317290; x=1745922090;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JvWmQrsXg9zHl1MPjQw5tN8WwrpI48NyLqFNhUg6Edg=;
        b=arcnq6B2mP3pxZ3GREephkYgAHZBzpAC6Qs9GgJDZuBAwy5IFPjIHuTa4CHIRorr7H
         5e7qrDdFIE3Zz3uL1HVa5uASySRZkb7ZintSn07znvwu0Ar+1bYZaQ7JfJs8O673EUiC
         wEe3/7AP1JXTFU7PGbSl3747gTnx08zYp5ZIlRpMkR9jWM0ewdwngu9QvXVLHUTA78bL
         O/hcnTUG/VStACY/BioATi67upZjEMJKdBVXOwstBZDsg7XP/7O6OeUk2V00UVkmHpnQ
         EzXZydANmL7r/GYTdsxPTlRcD0DPlG61mhuqmEGDreHpjintxhtaUAOM1QClgQzO9bZ3
         S+OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf9qCyccOgCjKA4ISm0AiiTIA4ADPiVAmzC7qGArhlDQHmYqJLWHgAWNaSPfg3NG1ApCosS8wOVZ0xF5JJhxko@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0hrbeVydH02iZB3P91GWW16kejQeLmKHt/M0e6SNV+L9oq9WP
	HwO0iLipiDaw9/jM8p0zbf/uf59GxnX+Hizig2NZyBlsTTDSHpTLFT4wc+bd6ho=
X-Gm-Gg: ASbGncuPrKJWxn76MEtlG3sQnyUWLtgYewKqcsfMl3OaBlkMqkRhxaAjqbnh1Y3Ua2M
	k3PY+jz90hAM1JTuRQ7d7nxlGYlxqu9ZtUoQwoQAkELZJ+UkozYWnw+JG6N+qDXPZxNVLLu3gJB
	0nqejq/qJW/gSsWl1/1GTMWTxZ3uWAzR0l95L2a/xaZPGnBwrbfFA4rC45PYjswkqzWChHFlbMF
	/MGwuoYDwgutk/3CVqqXtKvEonzorfnOOvMzF9vCbbaqi8MYI3wvoJYAQqGCDFn5j7t46EYDDyz
	i7h8ppA8FPnMjN4S6i1j/77/etpR//MBUCpZ30jKZg4=
X-Google-Smtp-Source: AGHT+IFaqQKcJYU0wnjYmq4qKpdD7Qb4L05M0qqkdyijsfGrapNInK3N9dhMXV0eheuNB4H3XoJVdQ==
X-Received: by 2002:a5d:6daf:0:b0:39a:c9cb:819f with SMTP id ffacd0b85a97d-39efbae0e1fmr10293740f8f.37.1745317289921;
        Tue, 22 Apr 2025 03:21:29 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bf20sm14488732f8f.48.2025.04.22.03.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 03:21:29 -0700 (PDT)
Message-ID: <48640298-effa-42d4-9137-a18a51637f03@linaro.org>
Date: Tue, 22 Apr 2025 11:21:28 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf: Allow non-contiguous AUX buffer pages via PMU
 capability
To: Yabin Cui <yabinc@google.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Liang Kan <kan.liang@linux.intel.com>
References: <20250421215818.3800081-1-yabinc@google.com>
 <20250421215818.3800081-2-yabinc@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250421215818.3800081-2-yabinc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/04/2025 10:58 pm, Yabin Cui wrote:
> For PMUs like ARM ETM/ETE, contiguous AUX buffers are unnecessary
> and increase memory fragmentation.
> 
> This patch introduces PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES, allowing
> PMUs to request non-contiguous pages for their AUX buffers.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
>   include/linux/perf_event.h  | 1 +
>   kernel/events/ring_buffer.c | 6 ++++++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0069ba6866a4..26ca35d6a9f2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -301,6 +301,7 @@ struct perf_event_pmu_context;
>   #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>   #define PERF_PMU_CAP_AUX_PAUSE			0x0200
> +#define PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES	0x0400
>   
>   /**
>    * pmu::scope
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 5130b119d0ae..87f42f4e8edc 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -710,6 +710,12 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>   		max_order = ilog2(nr_pages);
>   		watermark = 0;
>   	}
> +	/*
> +	 * When the PMU doesn't prefer contiguous AUX buffer pages, favor
> +	 * low-order allocations to reduce memory fragmentation.
> +	 */
> +	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_NON_CONTIGUOUS_PAGES)
> +		max_order = 0;
>   
>   	/*
>   	 * kcalloc_node() is unable to allocate buffer if the size is larger

Hi Yabin,

I was wondering if this is just the opposite of PERF_PMU_CAP_AUX_NO_SG, 
and that order 0 should be used by default for all devices to solve the 
issue you describe. Because we already have PERF_PMU_CAP_AUX_NO_SG for 
devices that need contiguous pages. Then I found commit 5768402fd9c6 
("perf/ring_buffer: Use high order allocations for AUX buffers 
optimistically") that explains that the current allocation strategy is 
an optimization.

Your change seems to decide that for certain devices we want to optimize 
for fragmentation rather than performance. If these are rarely used 
features specifically when looking at performance should we not continue 
to optimize for performance? Or at least make it user configurable?

Thanks
James

