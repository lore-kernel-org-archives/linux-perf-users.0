Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5050801
	for <linux-perf-users@vger.kernel.org>; Thu,  1 May 2025 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746096481; cv=none; b=jZPY35Y4rEt5CbC8mXN5fdbZDeQFOpkCIU4QJuFBtrgrHjjXtOeL/RzoyKHww5M6vURlby+RBXkgQLM1RJb8P3OMIApdIKTva5TolX8vrkYLoTDqEGInRuJURWq920et8NHwIOkH0C8vW+UnJv9eniJDe09IGliWC0IrbRSsIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746096481; c=relaxed/simple;
	bh=kBfb3axVpUkipYau/Mq9SyypPgXCwVamodootrN8gC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NiuAYMHd7d8rmJDtjwwO68bhYiVdbCxOTD80Kd1/J+iJthcFP3i609jhJYZPnS0X/7RJhiAURYQQSvvA7gQQa+Wbm7jUrpUPwuCXRs+OnRd7PC+rII/3lrhiusHoKmQiPlY0AYA2OAyfYEJpJASCrQjZrhsb3CDOhgFBluSZPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tdX1caYj; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tdX1caYj"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39ee682e0ddso416949f8f.1
        for <linux-perf-users@vger.kernel.org>; Thu, 01 May 2025 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746096477; x=1746701277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=si3fNE9GQSrIDtSL2LXUzl+e8wIwmtqlcMDREI82glc=;
        b=tdX1caYjewZmnHdV07NfxYjvFz/jiJ5xcbd/NVERKfBaQZ+9qLAmN9oQGrutzQON76
         6QI+px/FM/Ckt8TOx1/3LYgDxAVhkv6dNQEeupy+AFApqw1qU7wtUpvwTZdSFvUD71IN
         vJHSYVVBprnkOaqK6M/tBIllQ1TfEBWmeV8t9cV1T5qJyHwikqCLlXDlqxx6yZan7/Jd
         FO8IB4uJ+fqeMv0Y6aN9YT5s3cYHKAcJ1sOt/O7kIAAeVfn1J9vV1FLyzG8JhiBOrsWD
         +k7ysQsHW7Li8BzJPOMPKLHjkQlNOyi1IrkxkGtp0AoXQ7j1LU8UPihdw7Ey82we7ksG
         oAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746096477; x=1746701277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=si3fNE9GQSrIDtSL2LXUzl+e8wIwmtqlcMDREI82glc=;
        b=vb/HWVMCmEfmjy6/U9/8a7v3dmfGg6bYkPnCPW3DpDxkfVjsEZmowLM71IvWQZVV0P
         xYCz21kFy/eNpc6C3EZaUWJjjbuJpuvhWBp17jWyAV0T+C6Iboarjy79XZDUxwSTXxsu
         IpZj0rquH0sM8dXc32iR+A1LEM+pU34GuUnGTISw76vUHLn0vGCnnqJt6A8d8gBABp5/
         08xUeqKiYo17Y5UYO1SEhvQKZC3sfashcdqkWsANtrK77VLDtcRc4wqmKBUB+h6FYZH9
         kn9UxGusWKRqhPmHGM+NwzphyTPOweaK6yqIb6YVWwWlG8qDOJkTuhb7XHI9kppiRhYX
         gMcA==
X-Forwarded-Encrypted: i=1; AJvYcCVYGw7nAgRTcjOlLqNhx56aHw3SNYUAyZUG8q1RadmI6l5FtBV9u6eoo2KrIooTSlMdVcDaZGmqrZunc7jiwnuz@vger.kernel.org
X-Gm-Message-State: AOJu0YxspcMoFWyfrb8Ia0IMupjxiDDMEss8GMhPLOEjmXpDbhQc7n5U
	g7lLEsM46TaqRVxorXHDzH857EFc5ua8XwQenHwNhfuGXSOzgdhTqt2hrZARadw=
X-Gm-Gg: ASbGnct1+HVPmwjYUVvMfP6qyTQfArh6NLT8hJaslfC2e16805+gSiWVQhRBPG8dy1t
	8agQhCflXI3HIRH85ZL88DmKt1BPILcYo+1dxX4MGjoQt/pMH0MrT5W7PiCddM1k2kvrT5tCtbd
	K+k31h7d9ki2T/kfkT8UNz3w3lxmyhtCNY66GTW2dp3UMdl8TC9eMDYP2O93EjyGKxqe+7tR+Vk
	WyUxZWUDoDFgMF3zxT/ztMuvBxX7crhB9dNXPCDrv5C2nIYGEUPnX0vK55HVAzp4HbV3m/xbSB4
	9MvcIs2eK7+/+duOVysFA3nNpO7FXr88XqG2zvs1XiAfIl/1v6txCQ==
X-Google-Smtp-Source: AGHT+IHslO86ZF1CU2IPZPf6KTthtEvUGuil8yHuz65YUqPluNBK+P3P3sk3bArImylFI/g6oEQAvQ==
X-Received: by 2002:a05:6000:1ac8:b0:391:3f4f:a169 with SMTP id ffacd0b85a97d-3a08ff3c000mr5090505f8f.32.1746096477139;
        Thu, 01 May 2025 03:47:57 -0700 (PDT)
Received: from [192.168.1.3] ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a095a8f92fsm520512f8f.90.2025.05.01.03.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 May 2025 03:47:56 -0700 (PDT)
Message-ID: <a7c2ff21-4399-4cff-83d9-2fb0da0b5a08@linaro.org>
Date: Thu, 1 May 2025 11:47:55 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf: Allocate non-contiguous AUX pages by default
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
 Liang Kan <kan.liang@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20250429213133.922495-1-yabinc@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250429213133.922495-1-yabinc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/04/2025 10:31 pm, Yabin Cui wrote:
> perf always allocates contiguous AUX pages based on aux_watermark.
> However, this contiguous allocation doesn't benefit all PMUs. For
> instance, ARM SPE and TRBE operate with virtual pages, and Coresight
> ETR allocates a separate buffer. For these PMUs, allocating contiguous
> AUX pages unnecessarily exacerbates memory fragmentation. This
> fragmentation can prevent their use on long-running devices.
> 
> This patch modifies the perf driver to allocate non-contiguous AUX
> pages by default. For PMUs that can benefit from contiguous pages (
> Intel PT and BTS), a new PMU capability, PERF_PMU_CAP_AUX_PREFER_LARGE
> is introduced to maintain their existing behavior.
> 
> Signed-off-by: Yabin Cui <yabinc@google.com>
> ---
> Changes since v1:
> In v1, default is preferring contiguous pages, and add a flag to
> allocate non-contiguous pages. In v2, default is allocating
> non-contiguous pages, and add a flag to prefer contiguous pages.
> 
> v1 patchset:
> perf,coresight: Reduce fragmentation with non-contiguous AUX pages for
> cs_etm
> 
>   arch/x86/events/intel/bts.c |  3 ++-
>   arch/x86/events/intel/pt.c  |  3 ++-
>   include/linux/perf_event.h  |  1 +
>   kernel/events/ring_buffer.c | 18 +++++++++++-------
>   4 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
> index a95e6c91c4d7..9129f00e4b9f 100644
> --- a/arch/x86/events/intel/bts.c
> +++ b/arch/x86/events/intel/bts.c
> @@ -625,7 +625,8 @@ static __init int bts_init(void)
>   		return -ENOMEM;
>   
>   	bts_pmu.capabilities	= PERF_PMU_CAP_AUX_NO_SG | PERF_PMU_CAP_ITRACE |
> -				  PERF_PMU_CAP_EXCLUSIVE;
> +				  PERF_PMU_CAP_EXCLUSIVE |
> +				  PERF_PMU_CAP_AUX_PREFER_LARGE;
>   	bts_pmu.task_ctx_nr	= perf_sw_context;
>   	bts_pmu.event_init	= bts_event_init;
>   	bts_pmu.add		= bts_event_add;
> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index fa37565f6418..37179e813b8c 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c
> @@ -1866,7 +1866,8 @@ static __init int pt_init(void)
>   
>   	pt_pmu.pmu.capabilities		|= PERF_PMU_CAP_EXCLUSIVE |
>   					   PERF_PMU_CAP_ITRACE |
> -					   PERF_PMU_CAP_AUX_PAUSE;
> +					   PERF_PMU_CAP_AUX_PAUSE |
> +					   PERF_PMU_CAP_AUX_PREFER_LARGE;
>   	pt_pmu.pmu.attr_groups		 = pt_attr_groups;
>   	pt_pmu.pmu.task_ctx_nr		 = perf_sw_context;
>   	pt_pmu.pmu.event_init		 = pt_event_init;
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0069ba6866a4..56d77348c511 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -301,6 +301,7 @@ struct perf_event_pmu_context;
>   #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
>   #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
>   #define PERF_PMU_CAP_AUX_PAUSE			0x0200
> +#define PERF_PMU_CAP_AUX_PREFER_LARGE		0x0400
>   
>   /**
>    * pmu::scope
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 5130b119d0ae..d76249ce4f17 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -679,7 +679,7 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>   {
>   	bool overwrite = !(flags & RING_BUFFER_WRITABLE);
>   	int node = (event->cpu == -1) ? -1 : cpu_to_node(event->cpu);
> -	int ret = -ENOMEM, max_order;
> +	int ret = -ENOMEM, max_order = 0;
>   
>   	if (!has_aux(event))
>   		return -EOPNOTSUPP;
> @@ -689,8 +689,8 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>   
>   	if (!overwrite) {
>   		/*
> -		 * Watermark defaults to half the buffer, and so does the
> -		 * max_order, to aid PMU drivers in double buffering.
> +		 * Watermark defaults to half the buffer, to aid PMU drivers
> +		 * in double buffering.
>   		 */
>   		if (!watermark)
>   			watermark = min_t(unsigned long,
> @@ -698,16 +698,20 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
>   					  (unsigned long)nr_pages << (PAGE_SHIFT - 1));
>   
>   		/*
> -		 * Use aux_watermark as the basis for chunking to
> +		 * For PMUs that prefer large contiguous buffers,
> +		 * use aux_watermark as the basis for chunking to
>   		 * help PMU drivers honor the watermark.
>   		 */
> -		max_order = get_order(watermark);
> +		if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PREFER_LARGE)
> +			max_order = get_order(watermark);
>   	} else {
>   		/*
> -		 * We need to start with the max_order that fits in nr_pages,
> +		 * For PMUs that prefer large contiguous buffers,
> +		 * we need to start with the max_order that fits in nr_pages,
>   		 * not the other way around, hence ilog2() and not get_order.
>   		 */
> -		max_order = ilog2(nr_pages);
> +		if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PREFER_LARGE)
> +			max_order = ilog2(nr_pages);

Doesn't this one need to be 'PERF_PMU_CAP_AUX_PREFER_LARGE | 
PERF_PMU_CAP_AUX_NO_SG', otherwise the NO_SG test further down doesn't 
work for devices that only have NO_SG and not PREFER_LARGE.

NO_SG implies PREFER_LARGE behavior, except that NO_SG additionally hard 
fails if it can't do it in one alloc. But I think you shouldn't have to 
set them both to get the correct behavior.

