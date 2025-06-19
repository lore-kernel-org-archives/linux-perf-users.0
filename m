Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792D22756A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 11:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332741; cv=none; b=Nh64WkWNLckoRgwAudgLDBUu2ea3fSGDwHdASwldJvCGy3WJO2rndkEDePbWVFyJexxIbgkpjgdOgrctjCplO1QM3E9GHLPjVVDcf5joSaIt+wqNQhImiss2ve15q/oT8795WVDqf1J3mqzxHfBe8bQh5XbiHjwei8IPiXmudeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332741; c=relaxed/simple;
	bh=ril/UTkihH4nxaEpjl5cJ8aM3mZePTAsuV8jcrJvwAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dKIR9HjiUTxxoK1iT1emuD2zq9XXZYU0TGK0ANf1HTmVw0LjbXOsxVVkUTTdmAU98WnW3DyglGUMTB1/W8qINlQjb8RLfU8X61ud8WX+nnhIZxybqW0SNgWqw3CA/NUzF6MrsfQvELfqBnh2WNvCP5FTr9APVQzr1F3jtw91zKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XtwWT9FW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtwWT9FW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so600424f8f.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750332737; x=1750937537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4X0rJxof+2GJrC9KukcEIGboMkLQCIpBwzQ5S+QwNnU=;
        b=XtwWT9FWCVLuCDb6U/teFTRJc3shc/6oJO8QRKcXI/0isdIwol25PRM2J8r+uSuykf
         daAI234qNdeK47C5KIGcANjFizmrMBzyQjqAr8DIRC0yno6g+fjXmTovD0o+YIvzR+zj
         fomeJEd+luXQxqBTHRJk5vTiuQLTQ4ZfuldVE4ZJmlgkKOJOvsxxWcIJx7ut5A2Osx6y
         3usbwlyTO5qJfSgUfFOafHMGGh97CKZam5OoCoaojMOyJbAEooYnzqhZQ8drhEIPTeYH
         XBHnWdhN3MkPst4QkB5LqEjpIxTb2yma56/7XOQKv3DfY8Xydy4xJAU8OJLrQEGLIQTs
         lFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750332737; x=1750937537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4X0rJxof+2GJrC9KukcEIGboMkLQCIpBwzQ5S+QwNnU=;
        b=sJTa/KFUReLG/3sVYGOyXCZYGCVdvDcAjRKZjYpXJ9Nrx923/L02Oc2bC9TdmnRTiH
         wZiwho4zIZPL3vB2eDslpQ4ejJ3I+era0ocXZILy2xc+KYuH8bmKkP9CDPp/To0b8Vsd
         HdJ4/YsWK2NsD/PYJWKRbKGxnHYCP26N6yzTxm2KE4Gi2EcOv9jh461SpVnFa6TrhI9s
         vy6ociTw6Vzq5JtTR2/EI7CIcnaPkKdQ5LP3FsKr695gXiKwFPU2BTHQkpUWM8QSOgT6
         Qu2hx+AGJfX6O1l7vemNFcPLGzG1nmdoybXc5Cicx+cAlw+vKeC1ONOy4n0fDy0Xgxpf
         nfhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHZSKP45tlbeZdcWwmAHIu3DpU37w7f6GzKu4YXK+hEPBun3+iNQ3zMGAjWWJbD0SRK+epVUQno6rLWsrm/+RE@vger.kernel.org
X-Gm-Message-State: AOJu0YwBcG9+W0Jaf26IvZWY/wHypOtCnPXPQOLSK+wt7bkypqm9REZk
	BZEZkuCm9eLN2rn1Cewbf26uwyDY9fk5KPVx+Y62/nLs+TjSjqq+2yJ/Nez8RFccXHI=
X-Gm-Gg: ASbGncsYkwSM55fW0AMoWdHRZR7Jz5QdPYnBPhBQhc9VazujPgzBuNQQ5LLuPAep4dl
	qX1htsp5M7HGKODX/ck3KijlYjtN9cyAEOXzh78Tsgt0tAufY9FYtvQQ397hzcmcgVnj8MK8BlY
	FlZ7aV9MOYQ2qZ+Muji77pTZ7Aj/LVu7qKwAjLIziFOUZNKgdyEgiOCJB9Ro1xWiYm4jgczUdXY
	+/mGLIpZJojnxk8C+xxdgzcriFNxQLNC/mxULTKeV3tP09o44JueKDRGz+Lo4YkvKdDnw22s/09
	hKb5HZ/PoWUf+5RKGuz5DgF4mKVIrBGjz/f/L9px/rp6Cn7I4PBwU3fpPLy3kmgF3mU=
X-Google-Smtp-Source: AGHT+IGJVrLHFBFugL14B4WFHZ1t59fWsvRGspwqUSmcgvP8GTGmEKak9VjxtxP8UxFP+FgS9dzCOg==
X-Received: by 2002:a05:6000:18a4:b0:3a4:ea9a:1656 with SMTP id ffacd0b85a97d-3a572398df5mr17250936f8f.10.1750332737273;
        Thu, 19 Jun 2025 04:32:17 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b089b5sm19043643f8f.48.2025.06.19.04.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 04:32:16 -0700 (PDT)
Message-ID: <3431e6e3-a80b-4ce0-94c4-56739a5ed2d9@linaro.org>
Date: Thu, 19 Jun 2025 12:32:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] drivers/perf: arm_spe: Expose events capability
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-2-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-2-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Expose an events entry in the caps folder to inform user space which
> events are valid.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   drivers/perf/arm_spe_pmu.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index be2ed326bb794d7e5dd1d6cfa89330753ced3ca5..b59c394b715bc49af0ae30c521f97813a046755d 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -116,6 +116,7 @@ enum arm_spe_pmu_capabilities {
>   	SPE_PMU_CAP_FEAT_MAX,
>   	SPE_PMU_CAP_CNT_SZ = SPE_PMU_CAP_FEAT_MAX,
>   	SPE_PMU_CAP_MIN_IVAL,
> +	SPE_PMU_CAP_EVENTS,
>   };
>   
>   static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
> @@ -123,7 +124,7 @@ static int arm_spe_pmu_feat_caps[SPE_PMU_CAP_FEAT_MAX] = {
>   	[SPE_PMU_CAP_ERND]	= SPE_PMU_FEAT_ERND,
>   };
>   
> -static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
> +static u64 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
>   {
>   	if (cap < SPE_PMU_CAP_FEAT_MAX)
>   		return !!(spe_pmu->features & arm_spe_pmu_feat_caps[cap]);
> @@ -133,6 +134,8 @@ static u32 arm_spe_pmu_cap_get(struct arm_spe_pmu *spe_pmu, int cap)
>   		return spe_pmu->counter_sz;
>   	case SPE_PMU_CAP_MIN_IVAL:
>   		return spe_pmu->min_period;
> +	case SPE_PMU_CAP_EVENTS:
> +		return ~spe_pmu->pmsevfr_res0;
>   	default:
>   		WARN(1, "unknown cap %d\n", cap);
>   	}
> @@ -149,7 +152,7 @@ static ssize_t arm_spe_pmu_cap_show(struct device *dev,
>   		container_of(attr, struct dev_ext_attribute, attr);
>   	int cap = (long)ea->var;
>   
> -	return sysfs_emit(buf, "%u\n", arm_spe_pmu_cap_get(spe_pmu, cap));
> +	return sysfs_emit(buf, "%llu\n", arm_spe_pmu_cap_get(spe_pmu, cap));
>   }
>   
>   #define SPE_EXT_ATTR_ENTRY(_name, _func, _var)				\
> @@ -165,6 +168,7 @@ static struct attribute *arm_spe_pmu_cap_attr[] = {
>   	SPE_CAP_EXT_ATTR_ENTRY(ernd, SPE_PMU_CAP_ERND),
>   	SPE_CAP_EXT_ATTR_ENTRY(count_size, SPE_PMU_CAP_CNT_SZ),
>   	SPE_CAP_EXT_ATTR_ENTRY(min_interval, SPE_PMU_CAP_MIN_IVAL),
> +	SPE_CAP_EXT_ATTR_ENTRY(events, SPE_PMU_CAP_EVENTS),

Would "event_filters" be a better name? Technically an SPE version can 
support a filter but the event itself might not be implemented.

>   	NULL,
>   };
>   
> 

