Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C749248F64
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606966; cv=none; b=WXAv6T6qh+MqZpkCI58KlmR+Nm0svQo9fI00X3jXRMJnDGQGalVV0/j9h0fx/lL5Huz+o4zq8RtvMbj6f0n1k5NjJl3CD5fggpdJURfx+XLnmlMvkxKtZooxDKsFscyjoqVMn/A32p2IgucaRVS5RVbFQFdReO5EQnjHy0b7OcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606966; c=relaxed/simple;
	bh=K5B8osKOHadixSqo4a5TlrTTV0Rm8FTPkd3/G6QNof8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jy3sRP+f3g0jllRd384PaJBwnvxcjTkP/Gz4Jn2kt3koXRk5gPrXHzNyrpPEodfK/BL1OyzaUzpFDfFWrXLGJWNBFwUpM/OzWwsH7kFaHgxJxTdLjA6WBVKxBM9ITPFfoY9alcn6qG3TC3wCA0GSxyl0YjV3hN0lbUHebcnujcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RHDAnu0b; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHDAnu0b"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3df35a67434so657546f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757606963; x=1758211763; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDJ6GaR8btOeox+OA2bzSS79dpgrA+s1+6/cQu5Nvyg=;
        b=RHDAnu0bWwA5wIucn6p4rUjqy8+/xu/RT5t5/8svSbtFzfjQBFiXbtnT3a0ZraXNnh
         OqykZDCaV31evMjPxFNnS/zt0GP7/cj/lmcXMsgkXtEm/NUQ7UR2dK6ONbppstwZ/P8b
         7ApzwwVxLaEAZkQSUQ1RIqOCkHKT/Akr8g1KXgoCVy9l2HWOCqoZJWn6OiFX1ICkOmi1
         XrI6bEPJbJIDoussJNysGEhlXni8wgTAMS7Alpj9pW+msVS7GOsC771SZn/6xlhcmQv6
         ZtN/DULG/0EE1Jt3shIRNdxMO2y3VguDlmOq07W6gPSUuHpgQnt6j0yrfKRFYE0LxcXA
         AAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606963; x=1758211763;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HDJ6GaR8btOeox+OA2bzSS79dpgrA+s1+6/cQu5Nvyg=;
        b=SjxOOiHyQrF7h0tiYIoqXhlCqeZn5we2SHI/SL469RAZDSDHzVMRNuMK2NKKlGztPn
         7lLNQbAoGWCsxnV+TMN2SeSGp9A7F9lCN6t2nZX22ThAyPIUPFzQLcbsELjjNJU47gmu
         7nWuA5cSkkQBLViqSBe3Wu1A3ZyzJnxSddislhMlrP73Kemz1l+aMfong9khbdo3I11D
         yAPtQXpENwJgu3Trw5tvFo/4cRxqkL+7B3uw7BHM468SMY1ZMq2EBKJTrRvDXip8ZCgS
         SQYWELDRGqyvp7SfNkP/tOJxMbU5Kb3ThEROZV0x+lKFRCKczfSTmezwcauShJFt/KNI
         iTJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj+KgCsKYXVL970qpiaSXBlW5UUG3p/4C4yDYzFv/gfD+3R0x3bhfe2/17MSpsFES2PxnboXI8DCv50DrlRp7c@vger.kernel.org
X-Gm-Message-State: AOJu0YzhKoJmkYMLTy9O+fIZ0CIe7hsbnExnBaCwYZdQGDd2jPxW26LG
	c4oHVkDH/N7vjnwMHVuo749kpArNKRWsOjLO21n2xXt8aNnY1vk0Z+6bfO85Hj9hmDk=
X-Gm-Gg: ASbGncswi3Bdl7ZID04D4jcNJsJrM5IlqryoFoh4caEcPRWpnWQguNZ7SIzslLdF2Aq
	ur7qqOyTZuBaYXCZ4ooNe/1xeqrxRCZLdeUOld7fhWSQnyN2hpBl8Pj+WD1OpOzIPLwZ5358ojH
	30X1/QilLUu+I8hJ6fsj1TC5YWgTKZNAkwCG1Me+xgO2kmtWP3T6JJUagvR4wbY+0apd8xWfoja
	pbIVZeQLeMwjvzBydBFEL1rForuCgDyGZPN2FL6g3eRYRf6APGbKzXa7kPp+f5+vTPj/M+B5Y2o
	0/L2YhbYBjtoku20c1CYr32rQeRVt7vezK6jrRHgvS/mkriuUndkvtaxissCaFlK9FxRQM3mpfJ
	2fTSbllARpHpz7gbjNLfRGPjlBuKzvMx2e5KOSA==
X-Google-Smtp-Source: AGHT+IHPZ3rpyl9xqgnBk9lwQ4vqX9miW8Mb4X3QmnXktFb1xvjAPNm56H7S+6nNvI4nTnLVjGSlTg==
X-Received: by 2002:a05:6000:2007:b0:3e4:957d:d00 with SMTP id ffacd0b85a97d-3e646256c26mr14998738f8f.58.1757606962339;
        Thu, 11 Sep 2025 09:09:22 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607e2eb5sm3024223f8f.58.2025.09.11.09.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:09:21 -0700 (PDT)
Message-ID: <52e91a70-2626-4348-b7d3-db26cb3289d3@linaro.org>
Date: Thu, 11 Sep 2025 17:09:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] perf arm_spe: Refactor
 arm_spe__get_metadata_by_cpu()
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, German Gomez
 <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
 <20250731-arm_spe_support_hitm_overhead_v1_public-v4-13-58e5677a412b@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-13-58e5677a412b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2025 2:25 pm, Leo Yan wrote:
> Handle "CPU=-1" (per-thread mode) in the arm_spe__get_metadata_by_cpu()
> function. As a result, the function is more general and will be invoked
> by a sequential change.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 55 ++++++++++++++++++++++-------------------------
>   1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 2ac10b8008527a066c9b2f67a22eb8511af9239a..3c32b9bc9c983370e37d871adeaa610bf5905c1d 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -317,15 +317,38 @@ static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
>   	return 0;
>   }
>   
> -static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, u64 cpu)
> +static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, int cpu)
>   {
> +	struct perf_cpu_map *cpus;
> +	struct perf_cpu perf_cpu;
>   	u64 i;
>   
>   	if (!spe->metadata)
>   		return NULL;
>   
> +	/* CPU ID is -1 for per-thread mode */
> +	if (cpu < 0) {
> +		/*
> +		 * On the heterogeneous system, due to CPU ID is -1,
> +		 * cannot confirm the data source packet is supported.
> +		 */
> +		if (!spe->is_homogeneous)
> +			return NULL;
> +
> +		cpus = perf_pmus__find_by_type(spe->pmu_type)->cpus;
> +		if (!cpus)
> +			return NULL;
> +
> +		/* In a homogeneous system, fetch the first CPU in the map. */
> +		perf_cpu = perf_cpu_map__cpu(cpus, 0);
> +		if (perf_cpu.cpu == -1)
> +			return NULL;
> +
> +		cpu = perf_cpu.cpu;
> +	}
> +
>   	for (i = 0; i < spe->metadata_nr_cpu; i++)
> -		if (spe->metadata[i][ARM_SPE_CPU] == cpu)
> +		if (spe->metadata[i][ARM_SPE_CPU] == (u64)cpu)
>   			return spe->metadata[i];
>   
>   	return NULL;
> @@ -914,9 +937,6 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>   			      union perf_mem_data_src *data_src)
>   {
>   	struct arm_spe *spe = speq->spe;
> -	struct perf_cpu_map *cpus;
> -	struct perf_cpu perf_cpu;
> -	int16_t cpu_nr;
>   	u64 *metadata = NULL;
>   	u64 midr;
>   	unsigned int i;
> @@ -929,30 +949,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>   		cpuid = perf_env__cpuid(perf_session__env(spe->session));
>   		midr = strtol(cpuid, NULL, 16);
>   	} else {
> -		/* CPU ID is -1 for per-thread mode */
> -		if (speq->cpu < 0) {
> -			/*
> -			 * On the heterogeneous system, due to CPU ID is -1,
> -			 * cannot confirm the data source packet is supported.
> -			 */
> -			if (!spe->is_homogeneous)
> -				return false;
> -
> -			cpus = perf_pmus__find_by_type(spe->pmu_type)->cpus;
> -			if (!cpus)
> -				return false;
> -
> -			/* In a homogeneous system, fetch the first CPU in the map. */
> -			perf_cpu = perf_cpu_map__cpu(cpus, 0);
> -			if (perf_cpu.cpu == -1)
> -				return false;
> -
> -			cpu_nr = perf_cpu.cpu;
> -		} else {
> -			cpu_nr = speq->cpu;
> -		}
> -
> -		metadata = arm_spe__get_metadata_by_cpu(spe, cpu_nr);
> +		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
>   		if (!metadata)
>   			return false;
>   
> 

Reviewed-by: James Clark <james.clark@linaro.org>

