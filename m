Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C02459E6
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415835; cv=none; b=rAIknYK8Bz4V7ICNaemd7tInsQzeNGm3o5sZQffTa7O+1Unep3ylXRpVz7w0rtYUuH2TrZhgJ7Tni0gBm7CIol/AwJwIaSBj+aDmzwtr7YInKZRHsT530Y5bAdJO3SZ9xJ749KGPBQjKPptxucDXyTNDkkYxUMVKjdG3TIZxGn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415835; c=relaxed/simple;
	bh=oNdeGaXxjd6Um74cj5dEzEAMSt9cJf6WVAALrACPjhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qe633SjaXSj+ZUBbdcPnOr8Va7NRQI8ZP32bU7IlLiCnnsEoIL97ucVONj1yqCFDA5KIpM7W/7G0saIpsPZHcQhTuj6e66BLAk1256ne8CAYZrGYlh3XI5rfDSTik5r5nzw0gaNG6f/L433Sa1OVvOn6uq2zvaRf4WzRN9GSOAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yy49Hkil; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yy49Hkil"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so18506225e9.3
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 03:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750415832; x=1751020632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Qw4uHb2miFMURj+GlOF0mgNf4WXU9GXeO7JmqKsLUU=;
        b=Yy49Hkil+0RZpw9Mpx7K+0QBk3MWeSL3eZnDgO7s5R4ypWxKfJSwYKAwb6FF53/2s3
         RZSmsyfwSQbxeYJUwMPqpB1n5MJD7oYpkl1V7z2NLZ69HKpllCmvGv031TX8NkZiqV1X
         p6W8/lwlqwXbxGb8hgBKUW9wCGkP8JIF2ww+k2Lbd67ad9Suw626Z87IAH6rYC5aLavT
         nXh5VqbR5NRcobb678B9J+q1+rMuvpMk/Vz5SA5yONokmrZz/o9zyKh+MsbqOvBN3Dka
         XE7kFViPQFV7UVZMP60JNSiP8sFdqMarKgYIt48lFpsnlEIn2ZoLEASc3ztN4noK0Q+J
         yG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415832; x=1751020632;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Qw4uHb2miFMURj+GlOF0mgNf4WXU9GXeO7JmqKsLUU=;
        b=rOkTfCdI8lXssVrSXfLeiZ3ax5WUgE6xwe4gWhHdygymWy+e/l0MqL4li46aVVWzK+
         kpjAnAIZKq0860qzUa3yHl8okH4/LJhn7bexARVY66bZaw+ekUJHk4kqFzIqmdSArIia
         iPLp0lHpmBjRDxo/+fOYHMjt7GPT/Dq1D/CIyrsf+V8hX+WcLiXRhwGY0SV5c8mNw2N0
         LVLhPSjGl2v4YeP5RlpOr/+UTAWTNh4PCN6MA8+VcaNWW8+rExNSnZ0ONsvB8pQwVQnp
         ld1WUOMhKCCCA877EIWF6NUdDcb2lotNEQ9Os8ZGSvPovsnlwPUQSZT8t1Oavzpdono1
         h8/g==
X-Forwarded-Encrypted: i=1; AJvYcCWMk9d3FMmXlyEtK+IYP7iHbP9DjLFru9NPLO8kkVFrdMIVNfqGODLyWq5pa0TazmXbSwtff8JhL1pTjBESAPDN@vger.kernel.org
X-Gm-Message-State: AOJu0YxrANwCll3G9rtRFxXt+RHcZ7OKGKJx/5GTEQQJJpitF9EMk7z9
	cb8RlMtaOhgMRp0pqXWtcjzSjrbYxyiESwETmnZsVMGmnP9eOmg6Sc9FP22CDAB8kVU=
X-Gm-Gg: ASbGncvS7T8mMWjU1lkIS6/t2JxotcN8yESP6DYtLdvQLyXwFqGaFfucfsx5EjOp8dX
	z2OL/qDmbIhQ8jk/SwOkC+UN1bjAOlSNhkhm2ijzKnYxvAi2TGtCah+VUc5kdU2leemQxB/QYlg
	Lq5cOLsIfzp6YAnjsTSNTj3RiMPoXz301EVYmTcy6lSW7g2ycZqth87/Gtw5IWldLffB3Jwxxip
	Sg7hxuYOfA1sVdVklRjsUxY1G0aatJXAZVAAFnMqQqryAXYuvtNzTYMXoVCEPYUe96d5t43BRPi
	g++9Ha4f1Dq/SExM+A8MCHZec3TvGJrSdVPX4ZO4BzLRc5R4l8s23MYP4TLMfEYXfM0=
X-Google-Smtp-Source: AGHT+IEF6QONHUMg2SXvjSO3dQFckJ8Bm0mqnGeVgafpCQ/hKom7svtIBg7u7cwUr2vDb5+1ayMDZg==
X-Received: by 2002:a05:600c:c4aa:b0:453:a95:f07d with SMTP id 5b1f17b1804b1-453654cb7b3mr25608665e9.10.1750415831697;
        Fri, 20 Jun 2025 03:37:11 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453632312a3sm30717055e9.1.2025.06.20.03.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:37:11 -0700 (PDT)
Message-ID: <c9ebcc02-cbe7-403f-a427-b1209e3c041a@linaro.org>
Date: Fri, 20 Jun 2025 11:37:10 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] perf arm_spe: Fill memory levels for FEAT_SPEv1p4
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-9-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-9-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Starting with FEAT_SPEv1p4, Arm SPE provides information on Level 2 data
> cache and recently fetched events. This patch fills in the memory levels
> for these new events.
> 
> The recently fetched events are matched to line-fill buffer (LFB). In
> general, the latency for accessing LFB is higher than accessing L1 cache
> but lower than accessing L2 cache. Thus, it locates in the memory
> hierarchy information between L1 cache and L2 cache.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h |  3 +++
>   tools/perf/util/arm-spe.c                         | 14 ++++++++++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 03da55453da8fd2e7b9e2dcba3ddcf5243599e1c..90c76928c7bf1b35cec538abdb0e88d6083fe81b 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -25,6 +25,9 @@
>   #define ARM_SPE_SVE_PARTIAL_PRED	BIT(EV_PARTIAL_PREDICATE)
>   #define ARM_SPE_SVE_EMPTY_PRED		BIT(EV_EMPTY_PREDICATE)
>   #define ARM_SPE_IN_TXN			BIT(EV_TRANSACTIONAL)
> +#define ARM_SPE_L2D_ACCESS		BIT(EV_L2D_ACCESS)
> +#define ARM_SPE_L2D_MISS		BIT(EV_L2D_MISS)
> +#define ARM_SPE_RECENTLY_FETCH		BIT(EV_RECENTLY_FETCHED)

FETCH -> FETCHED

Reviewed-by: James Clark <james.clark@linaro.org>

>   
>   enum arm_spe_op_type {
>   	/* First level operation type */
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 8f18af7336db53b00b450eb4299feee350d0ecb9..2ab38d21d52f73617451a6a79f9d5ae931a34f49 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -842,6 +842,12 @@ static void arm_spe__synth_ld_memory_level(const struct arm_spe_record *record,
>   	if (arm_spe_is_cache_hit(record->type, L1D)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +	} else if (record->type & ARM_SPE_RECENTLY_FETCH) {
> +		data_src->mem_lvl = PERF_MEM_LVL_LFB | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_LFB;
> +	} else if (arm_spe_is_cache_hit(record->type, L2D)) {
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
>   	} else if (arm_spe_is_cache_hit(record->type, LLC)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> @@ -853,6 +859,9 @@ static void arm_spe__synth_ld_memory_level(const struct arm_spe_record *record,
>   	} else if (arm_spe_is_cache_miss(record->type, LLC)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_MISS;
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +	} else if (arm_spe_is_cache_miss(record->type, L2D)) {
> +		data_src->mem_lvl = PERF_MEM_LVL_L2 | PERF_MEM_LVL_MISS;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
>   	} else if (arm_spe_is_cache_miss(record->type, L1D)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_MISS;
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> @@ -868,6 +877,11 @@ static void arm_spe__synth_st_memory_level(const struct arm_spe_record *record,
>   		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, LLC) ?
>   				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +	} else if (arm_spe_is_cache_level(record->type, L2D)) {
> +		data_src->mem_lvl = PERF_MEM_LVL_L2;
> +		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, L2D) ?
> +				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L2;
>   	} else if (arm_spe_is_cache_level(record->type, L1D)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L1;
>   		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, L1D) ?
> 

