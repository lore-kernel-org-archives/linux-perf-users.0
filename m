Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC69C27FD5D
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 10:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750415225; cv=none; b=lbOQlPIcnEU5uBVc+maB05pPpCbAt38qVwzQ/Bo6zSll8udIaHQFbJpgnhho6X73S0kbgrgDL9ZkumQHHkcGvzYZQ8WoDC3DS+IXiNJI63CNsxiGszzF07OeD7YEvhVrD4Um+wQQBZmmaEMQDNDaeaf45bX1gZwe/QJR5Yzg5BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750415225; c=relaxed/simple;
	bh=ieRzSVDs9M8jOoIoKfVPa4CmmscQ0oJ9ejkM+pC3ols=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQcBFt/j8eIosJZjChyHeTyodNXAeJMl88E6p52eJWlFN1yZwq2uQad6MZOV4CB4ybpGswZbYkxgUc0DrT5hRkhs6uWg5wfeTos9XgqZ/bvaRQUY9NVT6IMrkuhzpjmE6bfV3CKbERab5Sh2InHwwHVtdWlBRLi7w5tMOA0lkwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbRS2Mq4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbRS2Mq4"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a4f379662cso1499362f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750415222; x=1751020022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ffg0iXEA2G0pgrfFnPLVJ/IivgD9mYBR14NIBm41Bw=;
        b=PbRS2Mq44Gc90zyFMpofrkllQ5snQ3vjYgqLLgmV2QubdaICt+QsnnCD+0MkqI9g7J
         Cl6th8p+3J6+CUs5z3912IJ1zBtYJ2HTfFvR+962r/yunJwE/F09qrlFyMZaqk6GXPs4
         SGIdidC3TSfGQ7jYEpyGZRjcP6YReBkvA3m04mvolyhg6gSIArIneK8Iazr1XDzUMglS
         9nPvuUcO6leZ7tn3XEEpWjkkl1VzCdfQYk86xS07nN4MA8WuiRcrFevWxublf+vFX7ty
         ss6KYs75Gleb/3KJxljzW0FdH290Tz4mOcDxbIN0KoesK062SjurtPEgxt07IdnZv1RQ
         jM6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750415222; x=1751020022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ffg0iXEA2G0pgrfFnPLVJ/IivgD9mYBR14NIBm41Bw=;
        b=wL1McYefmB9xsYOq1dOJCbKv3Ag0Ri+Ir3phtPlrV0nAeLbGBqQNiVmJJOqCBx2pic
         PUM/FmCbV2/wMP+q/E4lJ4a/uehU4ubY0bF6xNKJwnpJzN2cekGkVygZq0PRh49OwVSS
         Wx0RHCwnXF+gVD/iSPkD6O4JmQ+atwuOdQ0Gg8QnmtitBMqr/kSjfD32mhQp9cII4CDq
         +LeRX5TqnbWi6J0aSPf+LB77YJhjhOVnFfND9ejrUZOvE/yybCJIihpUV4HHChfDMG1H
         GP3NZYTIJUWBtDZTHjTwLSgWfGLRVpEuBZgYd774cJ0ufqN7I4CElqXADEPMn6VoUJMu
         xUiw==
X-Forwarded-Encrypted: i=1; AJvYcCUPbkJP4cq4mSv1u3hKTf7OS6mcgrfRYaSpsa9G++GLgIT77fELd7d++n0mA9W4/Tz+mLlrJGXBL3YEpz4EiM7I@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5lqiaq4o5NtyDjBBVSZJcM3Oy2NSZ5g/CBS33HkG1oaR/v5oA
	MS8OvDwj/SjSCPUpc7Au1KzPZmBBG3gDVUxFCs3qcAjvBpx1nARJiysMGRoz842qOrpOkkrwoWZ
	KmRlA
X-Gm-Gg: ASbGncuj7EIwGennlAvYW4E3vZUcx8Na71Pv1rB8UKB+tVREXlTnz91vb6avOYbvDiy
	T33F+cBAE1htpxmDXfImvd1kqaVQwtaLiIvsfEMFcgbTjrc4TQpkylbXj7Z4yKuj8gdwoQjXgzE
	6SrrRfkNtCdsoSPHNTaB5ac2ossGrpap7mBcjy5VpUY3gSS7t3Dyft/YvxXdco2xeXAw/+mJiO4
	nA+wp7jsRDldfqAOYjtA6ykv69TbbTcPvho5s8/Z6L1nYCVahmjyo4dC34eBqAbSMejRiRT62q0
	GQzxRlZAFXXv9RC8+mUiaauQU9271+zLRzj5A5E5GCirvLpWlwijyNXIS2a8Zszm4FQU2lKkJaF
	gIw==
X-Google-Smtp-Source: AGHT+IHE8BSpoZxO7KuVCVXUe3qb6bi6sj1JXY7eEQFY8+4LrfXFVw++FIBjk+kGTF27zg9cp2n8Jg==
X-Received: by 2002:a05:6000:4906:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3a6d12e6a3emr1737494f8f.45.1750415222121;
        Fri, 20 Jun 2025 03:27:02 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364705748sm20361355e9.28.2025.06.20.03.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:27:01 -0700 (PDT)
Message-ID: <4d96e0a9-23af-4fdc-b5a2-945b258c45cf@linaro.org>
Date: Fri, 20 Jun 2025 11:27:00 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] perf arm_spe: Refine memory level filling
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-7-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-7-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> This commit introduces macros for detecting cache level and cache miss.
> 
> Populates the 'mem_lvl_num' field which is a later added attribute for
> representing memory level. Set NA ("not available") to memory levels if
> memory hierarchy info is absent.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/arm-spe.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 55b8391990467c8b7818bb63de3545d94d021bb7..b2296cd025382ea36820641164ec71b13a4e7a0e 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -39,6 +39,15 @@
>   
>   #define is_ldst_op(op)		(!!((op) & ARM_SPE_OP_LDST))
>   
> +#define ARM_SPE_CACHE_EVENT(lvl) \
> +	(ARM_SPE_##lvl##_ACCESS | ARM_SPE_##lvl##_MISS)
> +
> +#define arm_spe_is_cache_level(type, lvl) \
> +	((type) & ARM_SPE_CACHE_EVENT(lvl))
> +
> +#define arm_spe_is_cache_miss(type, lvl) \
> +	((type) & ARM_SPE_##lvl##_MISS)
> +
>   struct arm_spe {
>   	struct auxtrace			auxtrace;
>   	struct auxtrace_queues		queues;
> @@ -822,20 +831,21 @@ static const struct data_source_handle data_source_handles[] = {
>   static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>   					union perf_mem_data_src *data_src)
>   {
> -	if (record->type & (ARM_SPE_LLC_ACCESS | ARM_SPE_LLC_MISS)) {
> +	if (arm_spe_is_cache_level(record->type, LLC)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L3;
> -
> -		if (record->type & ARM_SPE_LLC_MISS)
> -			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
> -		else
> -			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
> -	} else if (record->type & (ARM_SPE_L1D_ACCESS | ARM_SPE_L1D_MISS)) {
> +		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, LLC) ?
> +				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L3;
> +	} else if (arm_spe_is_cache_level(record->type, L1D)) {
>   		data_src->mem_lvl = PERF_MEM_LVL_L1;
> +		data_src->mem_lvl |= arm_spe_is_cache_miss(record->type, L1D) ?
> +				     PERF_MEM_LVL_MISS : PERF_MEM_LVL_HIT;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_L1;
> +	}
>   
> -		if (record->type & ARM_SPE_L1D_MISS)
> -			data_src->mem_lvl |= PERF_MEM_LVL_MISS;
> -		else
> -			data_src->mem_lvl |= PERF_MEM_LVL_HIT;
> +	if (!data_src->mem_lvl) {
> +		data_src->mem_lvl = PERF_MEM_LVL_NA;
> +		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
>   	}
>   
>   	if (record->type & ARM_SPE_REMOTE_ACCESS)
> 

