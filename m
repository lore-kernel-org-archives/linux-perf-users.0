Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BC277CA9
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416910; cv=none; b=GPO+09njSTBINFmwJ2h3+1TfB7PcJY1xu8GxKfRG4AIur80W8GasUUmyCtQ/4zz3AtHG2roPn/q5HF+DTYqSp/ttYDyJvSvER03MUi71wq62TAkIqXhOoyD/sxF+k4ODmKXxb8mzTcxxq88fbtnyHUxTt7nJCKGxrvCd01wX6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416910; c=relaxed/simple;
	bh=u41veYoPX46IiOfG6t/jJ51VQdkRfUOipQYIBKO4OYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYP3X3UuaZZSh/TZ+vVLGxSyKW7mDWAzBHhBE8fh4oHA8MRzB8OKhuPSdbVxM1dlNYIJLHswo5DzILrTVsyXnywXsA5B/ypoUoMCzhZb9u9cYLIbms24YatoYEgkoWQg9iBLszynG4ydtjfH8GvPTgWbKQBUjI3BiJEJ0l1DkNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=COLUs+ro; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="COLUs+ro"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453426170b6so16774015e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 03:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750416906; x=1751021706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJR7m6FuaArEkYSPieCF/QiYN4u0ZRybWkkRgblwJQE=;
        b=COLUs+roD/cDR24O26NmhNxzwJVom2RHLwCOV6rwls6qbGMeueW0D+wJJ4HOzATk/P
         BlABWBIv0ORzFnKumaQ2zvpjeTwStjmgKM1PGfD3i53fYh4nIWHRnTCcSq8D+EQbVhF3
         kkVGLGnSk5je7vNBw2FyJ8cftlsFmRVRktUpTdcHNsRV4Y8AVzEZt0NMfYcuyfJ27NHK
         mONjrmYDgmKskcEgw+tFGyliGCDBMzEiwfATArW5Blu/c5kW9lB+JAJWPfvjPrFxjaDC
         OsOwN5LZgabcuuWtJWWWUiAvcp0RVmv3ENxaVfhrgVcYDquu6IyqQyURoOKDJriAqRTg
         ztfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750416906; x=1751021706;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJR7m6FuaArEkYSPieCF/QiYN4u0ZRybWkkRgblwJQE=;
        b=iEiCANjZ5qWn6pTYZw86MlYIsAND65RxAlXluxrsJH41OnzrWXHkHV3VytIh62Bngt
         DI7NbqdivxsY0BokM8Hzc7dShhwaq6PG6P8rDLadS9JXyqlnQLwJagk2uc4MBFGRj8uv
         +3G/M2XK/X1jm/Z7Hmay9PYSqs2eXECJlMz6/+Rjs/MdNgnxjqYerwyAbiG23P41dRNW
         Xj9XXFRk3DdiwhbREPbw0pnYSLswRiL6kuGAWWje8httScQLWsiUYHN9KI+j1kvLsc9N
         1oPaMpxvVHc/1ffbhISXqXlwvu/Rvbs+MfrqbupnYaG1aFiYJNkfOsyW2WpX21ygSPd8
         J61Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0vY4n5SSTxjf190Zog+tHcSHBWG1KKNU/lY1FOcONiHDWdVnQ3OjMe3H6D3PnUIDD8vlDKLXiQEwpLMeDlrIr@vger.kernel.org
X-Gm-Message-State: AOJu0YzJpzlXHEzxYjPcrAKTLC1XeaD4+ITq5mCEDSZ6WHk199qytZaa
	8GxORnrWRoKIjGlx8IQNmdyVxIYN5VAPnCcg4htWnkF0IGNEuFkG25JklmCvi9bYSA4=
X-Gm-Gg: ASbGnctFuq/XFZkvZNZc36XFcHwZnlMyp+G2CwdQ0FsfnlHWzMdZJEdLG4mlowAt48f
	fwVoz7T5B9wzYEhsRohIHmHmt8glbnH6HJfE6Ge1F5O6ms0lncIYYsTH/cM4iJWsgcJKFYmccbj
	2/+CbN/b4IC0j/bUcvq2tU5GIs8sRjpVQr7MdJZ5HAYXCFcE4y5Grv/ZW94XJdrN0VLAzfGRSY3
	nD0gmndKY/Via3ryQ6Gl/5M9hd+8OvIMBafV7ZjqUa6FCZwlxWIh6bpxogkk3wPlJsYlSTAqs/g
	MT/2ixG30KEdB6ko4jrREPUNWwl2IaB5OlkhNJd9EeRTdmAf4tiQjH1PdPhG32wDxVM=
X-Google-Smtp-Source: AGHT+IGU5P55fYF+8k78k2aw4YAOudyds2cdvLpevXXeEWUDV6rw8epDKgJrfdPoNbdTLd+47jdQOg==
X-Received: by 2002:a05:6000:41f6:b0:3a4:c71a:8119 with SMTP id ffacd0b85a97d-3a6d27eed6emr1802208f8f.25.1750416906262;
        Fri, 20 Jun 2025 03:55:06 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d0f104bbsm1748016f8f.4.2025.06.20.03.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:55:05 -0700 (PDT)
Message-ID: <c72dd890-8f24-47e8-ab3a-13d4d71209e7@linaro.org>
Date: Fri, 20 Jun 2025 11:55:04 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] perf arm_spe: Allow parsing both data source and
 events
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-12-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-12-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Current code skips to parse events after generating data source. The
> reason is the data source packets have cache and snooping related info,
> the afterwards event packets might contain duplicate info.
> 
> This commit changes to continue parsing the events after data source
> analysis. If data source does not give out memory level and snooping
> types, then the event info is used to synthesize the related fields.
> 
> As a result, both the peer snoop option ('-d peer') and hitm options
> ('-d tot/lcl/rmt') are supported by Arm SPE in the perf c2c.
> 

Reviewed-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 69 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 8a889f727f9cd5351b4ca027935112eddd16ea6c..8fde6f6cbce92aabf20d25b01ee2ade4aae7ea61 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -909,40 +909,54 @@ static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
>   {
>   	struct arm_spe *spe = speq->spe;
>   
> -	if (data_src->mem_op == PERF_MEM_OP_LOAD)
> -		arm_spe__synth_ld_memory_level(record, data_src);
> -	if (data_src->mem_op == PERF_MEM_OP_STORE)
> -		arm_spe__synth_st_memory_level(record, data_src);
> +	/*
> +	 * The data source packet contains more info for cache levels for
> +	 * peer snooping. So respect the memory level if has been set by
> +	 * data source parsing.
> +	 */
> +	if (!data_src->mem_lvl) {
> +		if (data_src->mem_op == PERF_MEM_OP_LOAD)
> +			arm_spe__synth_ld_memory_level(record, data_src);
> +		if (data_src->mem_op == PERF_MEM_OP_STORE)
> +			arm_spe__synth_st_memory_level(record, data_src);
> +	}
>   
>   	if (!data_src->mem_lvl) {
>   		data_src->mem_lvl = PERF_MEM_LVL_NA;
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
>   	}
>   
> -	if (record->type & ARM_SPE_DATA_SNOOPED) {
> -		if (record->type & ARM_SPE_HITM)
> -			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> -		else
> -			data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> -	} else {
> -		u64 *metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
> -
> -		/*
> -		 * Set NA ("Not available") mode if no meta data or the
> -		 * SNOOPED event is not supported.
> -		 */
> -		if (!metadata ||
> -		    !(metadata[ARM_SPE_CAP_EVENTS] & ARM_SPE_DATA_SNOOPED))
> -			data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> -		else
> -			data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +	/*
> +	 * If 'mem_snoop' has been set by data source packet, skip to set
> +	 * it at here.
> +	 */
> +	if (!data_src->mem_snoop) {
> +		if (record->type & ARM_SPE_DATA_SNOOPED) {
> +			if (record->type & ARM_SPE_HITM)
> +				data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +			else
> +				data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> +		} else {
> +			u64 *metadata =
> +				arm_spe__get_metadata_by_cpu(spe, speq->cpu);
> +
> +			/*
> +			 * Set NA ("Not available") mode if no meta data or the
> +			 * SNOOPED event is not supported.
> +			 */
> +			if (!metadata ||
> +			    !(metadata[ARM_SPE_CAP_EVENTS] & ARM_SPE_DATA_SNOOPED))
> +				data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> +			else
> +				data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +		}
>   	}
>   
>   	if (record->type & ARM_SPE_REMOTE_ACCESS)
>   		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>   }
>   
> -static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
> +static void arm_spe__synth_ds(struct arm_spe_queue *speq,
>   			      const struct arm_spe_record *record,
>   			      union perf_mem_data_src *data_src)
>   {
> @@ -961,19 +975,18 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>   	} else {
>   		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
>   		if (!metadata)
> -			return false;
> +			return;
>   
>   		midr = metadata[ARM_SPE_CPU_MIDR];
>   	}
>   
>   	for (i = 0; i < ARRAY_SIZE(data_source_handles); i++) {
>   		if (is_midr_in_range_list(midr, data_source_handles[i].midr_ranges)) {
> -			data_source_handles[i].ds_synth(record, data_src);
> -			return true;
> +			return data_source_handles[i].ds_synth(record, data_src);
>   		}
>   	}
>   
> -	return false;
> +	return;
>   }
>   
>   static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
> @@ -992,8 +1005,8 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>   	else
>   		return 0;
>   
> -	if (!arm_spe__synth_ds(speq, record, &data_src))
> -		arm_spe__synth_memory_level(speq, record, &data_src);
> +	arm_spe__synth_ds(speq, record, &data_src);
> +	arm_spe__synth_memory_level(speq, record, &data_src);
>   
>   	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
>   		data_src.mem_dtlb = PERF_MEM_TLB_WK;
> 

