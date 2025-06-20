Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E6020F091
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415424; cv=none; b=PEh2VKZ6d2+K+Jja2PMykGsE4uuvC1AwET18RSx8+Zk/FlN67W/qPuAuS/WBy7sZkbGf/+Z8r3D/H205CPCM3KKFzWOUujERwms8q5JdxYOc1kfxUmqDINVVgxo9sYTbBFe+7n3Y5faI1qSUVUqoCcHcYmD7an/uKrG8V4MyO3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415424; c=relaxed/simple;
	bh=v9XkdxlZiQ3qLaKdypdipmAgfKC66yCBgSHHWmVnZU8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GljCL1FmjDuUq0ar76ucEunFPeyn1CQZzdD4GGEma1GzHqrwJKuyQU/zdC6WggoHZhDm6MdfmSOB2xqtXGPFcgyBAb8+CakxnVFIkJtnsz2wrzhqfaorGNyXkcKXHYVcRu7l60F1vTVKiRxmKx7ntaOjMMCHnSLhCu348AVAqfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B2UeHbZ8; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B2UeHbZ8"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450d668c2a1so18268445e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 03:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750415420; x=1751020220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fR2JiKduz29SihBHyUhqzOKWWeUFFTMa8sDNsxCND9o=;
        b=B2UeHbZ81Yyt1ghI7vlmNzg+yEq0kld48GaPjOzIvFMvdpOq7Pu+hJq0qXck3H57vt
         X6Vk7vplioL+LyiCCSNcdJcwlBBVWTkZmWID/Asp4YBBQyp6N49xrcW5+f0bAp1Xwaqa
         gJQFUtfBcGYjQoFJuLeqPc1go8FTXovDM+4N7BWYYAqVrJB3Ti44UrwaZWR6v2AzHmg6
         eRbEF8SoYF4WGxD8h4Rf/P2q3vzlRbJg+Ut+X9ZyWjxw3V47xocm/NqQf5PKJ59mNLuh
         G0vEVqhw0nAdqHLGXyPGbnKHXuDncc+hyG/UpiKTGkVALFNxoe8cBmzqDnG+FwrOgCVy
         gRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415420; x=1751020220;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fR2JiKduz29SihBHyUhqzOKWWeUFFTMa8sDNsxCND9o=;
        b=gDbCwjgd/mwaF0n5gCe8YeGxUEvj8rGhh2HcLWdN5iWP2TcemHNdEhhlWk1cWc2L1I
         zZG5ijz0iB5W/73+PLRk7Ogg6RGGh5PAaPolQnZWL1OmJZU1aRlT58TZMy4tLTCsMNoW
         WUrVK4ndXOCSZAnI8bLgfqFoVmv4CvJeXyafl9Dfvkjjmcc/36cPVRsNePj8JvIZ/Ty3
         Oo+aOmyq4LlpPIguJjL1dCMtNuNg4Cn3vcFCwoCgXM/gIa9baVXvmjXEheC8wB+gtWEh
         dtM/rYlYINGT9pmWOgjcG6fdiOykXctl3WkDNxq2zpemkrwvt5/nj5g2dTft8WLKYbnt
         G1zA==
X-Forwarded-Encrypted: i=1; AJvYcCXOOl1tWwVQ5wHYK9GtX4dFcTLL8yJcLY1Pby+xaR4Pv8pZmVmMmZg4bRJQohMorv70tN9V7H2DrH1dxEC5Tbd2@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcAGzBMaFv4C6ayX4DU9EN/hSWPIqXxo+ffhy4fROETyWrxrI
	pAy7/AI6W/NLw0wLEu4z2SJuIQNUgzQ7YT1pG9Pm26NX1vkAY7Xi18wNv2PgYXI/YoU=
X-Gm-Gg: ASbGnctXmzQUEhDjQYQOYtP3OMJqALGJluZTbKEmDGR1Wldw98FoqREJg4A5fbxmm7d
	SsqcvQz6Yiv8NpsUCNwZVTRxZFjKBRho41/z7kPhfYge3jCaifsXrX6BdFaKE4AQ8QCtlO21KFB
	dfGllJJV2CcxSTbuVzEyTOF9aYP9v0iGTOL199FMRGiIW1iXHesfyVU+HQ7dVL2hJCEiQ0+ZM2v
	S3DJK58IFyMs+c9DSK412rDeQ/ZGT88ppPH95YTErSu4fBlPB8PYHQUCulpcSzkhPQMZFLkSR6I
	Hze6ol4cd8fO30MI8ZASThhGkFjU5FKSGEqQ8Cdh3oTV1kLM4VR7bu1QPvpB6SSGQrg=
X-Google-Smtp-Source: AGHT+IGrcCthqm0ioH86WkDuKawZp+7l51060VVgntKbeJZgzMtH2dkN5uKRibR7xMjW8qMY6Mo5bg==
X-Received: by 2002:a05:600c:871b:b0:453:ec2:c7b2 with SMTP id 5b1f17b1804b1-45365e3dfc0mr17238275e9.7.1750415420300;
        Fri, 20 Jun 2025 03:30:20 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4536470415csm20680135e9.31.2025.06.20.03.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:30:19 -0700 (PDT)
Message-ID: <3ede12b2-7d70-4e8d-8d6c-694c53d19098@linaro.org>
Date: Fri, 20 Jun 2025 11:30:19 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/12] perf arm_spe: Separate setting of memory levels for
 loads and stores
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-8-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-8-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> For a load hit, the lowest-level cache reflects the latency of fetching
> a data. Otherwise, the highest-level cache involved in refilling
> indicates the overhead caused by a load.
> 
> Store operations remain unchanged to keep the descending order when
> iterating through cache levels.
> 
> Split into two functions: one is for setting memory levels for loads and
> another for stores.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/arm-spe.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index b2296cd025382ea36820641164ec71b13a4e7a0e..8f18af7336db53b00b450eb4299feee350d0ecb9 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -45,6 +45,9 @@
>   #define arm_spe_is_cache_level(type, lvl) \
>   	((type) & ARM_SPE_CACHE_EVENT(lvl))
>   
> +#define arm_spe_is_cache_hit(type, lvl) \
> +	(((type) & ARM_SPE_CACHE_EVENT(lvl)) == ARM_SPE_##lvl##_ACCESS)
> +
>   #define arm_spe_is_cache_miss(type, lvl) \
>   	((type) & ARM_SPE_##lvl##_MISS)
>   
> @@ -828,9 +831,38 @@ static const struct data_source_handle data_source_handles[] = {
>   	DS(hisi_hip_ds_encoding_cpus, data_source_hisi_hip),
>   };
>   
> -static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
> -					union perf_mem_data_src *data_src)
> +static void arm_spe__synth_ld_memory_level(const struct arm_spe_record *record,
> +					   union perf_mem_data_src *data_src)
> +{
> +	/*
> +	 * To find a cache hit, search in ascending order from the lower level
> +	 * caches to the higher level caches. This reflects the best scenario
> +	 * for a cache hit.
> +	 */
> +	if (arm_spe_is_cache_hit(record->type, L1D)) {
> +		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +	} else if (arm_spe_is_cache_hit(record->type, LLC)) {
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +	/*
> +	 * To find a cache miss, search in descending order from the higher
> +	 * level cache to the lower level cache. This represents the worst
> +	 * scenario for a cache miss.
> +	 */
> +	} else if (arm_spe_is_cache_miss(record->type, LLC)) {
> +		data_src->mem_lvl = PERF_MEM_LVL_L3 | PERF_MEM_LVL_MISS;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +	} else if (arm_spe_is_cache_miss(record->type, L1D)) {
> +		data_src->mem_lvl = PERF_MEM_LVL_L1 | PERF_MEM_LVL_MISS;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +	}
> +}
> +
> +static void arm_spe__synth_st_memory_level(const struct arm_spe_record *record,
> +					   union perf_mem_data_src *data_src)
>   {
> +	/* Record the greatest level info for a store operation. */
>   	if (arm_spe_is_cache_level(record->type, LLC)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L3;
>   		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, LLC) ?
> @@ -842,6 +874,15 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>   				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
>   	}
> +}
> +
> +static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
> +					union perf_mem_data_src *data_src)
> +{
> +	if (data_src->mem_op == PERF_MEM_OP_LOAD)
> +		arm_spe__synth_ld_memory_level(record, data_src);
> +	if (data_src->mem_op == PERF_MEM_OP_STORE)
> +		arm_spe__synth_st_memory_level(record, data_src);
>   
>   	if (!data_src->mem_lvl) {
>   		data_src->mem_lvl = PERF_MEM_LVL_NA;
> 

