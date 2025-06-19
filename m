Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718EB235064
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750342388; cv=none; b=HxXo0JpMZfGHWeNl+RKb/pL730ePSDCkGKxhb1RNnskLCvOPzvk4v6jbrQrwL7cikktKNPxBeuTFpb7798zWsGMtuXKhuQSf9uAoN6qnziX6NSw3T8RG+T1KVfnI7jKu6ep7cTiNr+Z6D0gNlsV3IQjMD9urn3fYpc34KinThQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750342388; c=relaxed/simple;
	bh=6f6jIhoTMQoQeHL5TPSKRnPHfL/zMMXA78ki2OK7vVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W8M3109D08KFyC1YQwFplRSmShzdkMfAFko/RUqbPNfEkNuA6HRd2m6S5DyWEHEcV2SEj9TpHaVNaPJ/p1gq1dsrpf0TPkuzQx4b+CWA0ihN1w9C39PqM1A1Xfawf3BcLqJxl4i9bmayrQjseftPmJ46z6p/4iVvYFUkM8SuDL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fayyzkeX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fayyzkeX"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-451d7b50815so6591795e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750342385; x=1750947185; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b3GCxL+YDPcqeTX4EEB9vPwJWOeC12f9UGGf8/tKF5A=;
        b=fayyzkeXNEOu52db/rwg8u9j3cRkkgg9UN0CmREOKPIFgS9qQo2y77nWJokMX1A8KJ
         6+IWn+m1vji0J2aV4vIjlVRdbrTJwyqTQ6U7XsdWEA9R+anzNh5RqgLJAXAJUFB8SztJ
         H7xAxGMsF4RAX8Wwp2uDqAW6/f119ME9SAwLuLjxqfKx6Qwc5sPihuUmTk6A2j4pRe71
         Gdvtfn6F7Co8Jm4WuxyjLj5upsgADCyYpnvaQJcESVT2fkMvgYTLxLEgts9y4FLSVhXA
         4oOvT/Dwb73077okL27CcohV7mSb3aSSb/eHP5Nvxoc4BqYeSJ5SvMLrCVZMpR+McLrZ
         Js5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750342385; x=1750947185;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b3GCxL+YDPcqeTX4EEB9vPwJWOeC12f9UGGf8/tKF5A=;
        b=uDcXoeU+KiPad4rnfe4qcyEC8Uyrt8P7f2gJujkQGKS9on+/IrPEPOAJFiTDmKy7n6
         U8IfQYvfclY+yHmw4U1YFw4QbyvUrCGL8aut9ibZvCBjrtBxHGDcAlhIvv7GBa7HiaOf
         vlCnCpJEOvKzevEnYxckp2b16mXkNbczKNuZEObwGu019Km8eZ4UhaFN9jWlmRGu26g1
         SRJipBVqvcX9JQ2uPJDZB32qQ6AIhDLP94dZ46/A/EmVRgnlQxIWoaxjzXE/OSNLosdk
         Vq9eml3pSnVccn2LuXVx9OYk1wo4qLERBtS6ZkwMCS9IGBlxRkrgNGH92ZnWINf0NlB2
         xu3g==
X-Forwarded-Encrypted: i=1; AJvYcCWgjcJz9CPQDIxXMc/Ixnvg8UwXlm2oofxsmaG+PF6DGwuaDF8RDdAkyJvNZUTEcKvNgdGOdSKPdsL+W/rHOexb@vger.kernel.org
X-Gm-Message-State: AOJu0YxwO9O3VNRUwWkk+OazJV9EkJmHP11q83e+o0akmiXwHZ0bye1A
	FP6BCjPP0Lb5yiKZjdPUTmi8onc+pMf7EKBNjLgGDoW0dfMehxkMjYUtVGG3CDFetDE=
X-Gm-Gg: ASbGncv/wbtpVIYVeDlBeX71zHHedQyUwfhViXGsD+QISYP3KFiZSxqRiMpUKVgrU6S
	Mrk6Auw8fbaqECzTqWfQveRp0yccqK7O6471d9w7IMOMeMh5AfuSb+g6RG1YJHZ0HXcOjG3HZ/S
	BojvL3RiMn8CE6LA3+nbugHP3gib83F/ZmiPhL2WJyTvFrq4yocMswcuaanbjfpN0imPaV4jSo9
	hb+PRGZxZaycNHzslBgHg/5xYUBJ8XdLYFyNLArhPHYn9cNP6/4NUfTbq/S6W9UzWVCJI9WUiIo
	hdffURYNVdrTb7oOEKmYZ4weqlMTAXu+0nr6aUrg2aJ/kfxJtXRnY75jUbe7W7ysgOHxg1juzdn
	6RA==
X-Google-Smtp-Source: AGHT+IFPKpBZ4TxXKzFWe6qKBcJNNZnH9SxfGUNf9G9XY2OEy3rLY6Z/IKXAVI7xVSnp9YfkfkOQGg==
X-Received: by 2002:a05:600c:8012:b0:43b:ce36:7574 with SMTP id 5b1f17b1804b1-4533cae684fmr215134985e9.11.1750342384744;
        Thu, 19 Jun 2025 07:13:04 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ef6edbesm27883605e9.20.2025.06.19.07.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:13:04 -0700 (PDT)
Message-ID: <ad01491f-7dfc-4741-87a1-237030183195@linaro.org>
Date: Thu, 19 Jun 2025 15:13:03 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] perf arm_spe: Directly propagate raw event
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-4-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-4-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Two separate sets of event bits are defined: one for used in the code
> for generating samples and another for the backend decoder. Reduce
> the redundancy by using the raw event bits directly in the frontend
> code.
> 
> To avoid overflow issues, change the type of the event variable from
> enum to u64.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 37 +----------------------
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 28 ++++++++---------
>   2 files changed, 14 insertions(+), 51 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 688fe6d7524416420a7c18d5f8a268492ce7c3b8..96eb7cced6fd1574f5d823e4c67b9051dcf183ed 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -229,42 +229,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   			}
>   			break;
>   		case ARM_SPE_EVENTS:
> -			if (payload & BIT(EV_L1D_REFILL))
> -				decoder->record.type |= ARM_SPE_L1D_MISS;
> -
> -			if (payload & BIT(EV_L1D_ACCESS))
> -				decoder->record.type |= ARM_SPE_L1D_ACCESS;
> -
> -			if (payload & BIT(EV_TLB_WALK))
> -				decoder->record.type |= ARM_SPE_TLB_MISS;
> -
> -			if (payload & BIT(EV_TLB_ACCESS))
> -				decoder->record.type |= ARM_SPE_TLB_ACCESS;
> -
> -			if (payload & BIT(EV_LLC_MISS))
> -				decoder->record.type |= ARM_SPE_LLC_MISS;
> -
> -			if (payload & BIT(EV_LLC_ACCESS))
> -				decoder->record.type |= ARM_SPE_LLC_ACCESS;
> -
> -			if (payload & BIT(EV_REMOTE_ACCESS))
> -				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
> -
> -			if (payload & BIT(EV_MISPRED))
> -				decoder->record.type |= ARM_SPE_BRANCH_MISS;
> -
> -			if (payload & BIT(EV_NOT_TAKEN))
> -				decoder->record.type |= ARM_SPE_BRANCH_NOT_TAKEN;
> -
> -			if (payload & BIT(EV_TRANSACTIONAL))
> -				decoder->record.type |= ARM_SPE_IN_TXN;
> -
> -			if (payload & BIT(EV_PARTIAL_PREDICATE))
> -				decoder->record.type |= ARM_SPE_SVE_PARTIAL_PRED;
> -
> -			if (payload & BIT(EV_EMPTY_PREDICATE))
> -				decoder->record.type |= ARM_SPE_SVE_EMPTY_PRED;
> -
> +			decoder->record.type = payload;
>   			break;
>   		case ARM_SPE_DATA_SOURCE:
>   			decoder->record.source = payload;
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 881d9f29c1380b62486f0cd81498750ba06c4b50..03da55453da8fd2e7b9e2dcba3ddcf5243599e1c 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -13,20 +13,18 @@
>   
>   #include "arm-spe-pkt-decoder.h"
>   
> -enum arm_spe_sample_type {
> -	ARM_SPE_L1D_ACCESS		= 1 << 0,
> -	ARM_SPE_L1D_MISS		= 1 << 1,
> -	ARM_SPE_LLC_ACCESS		= 1 << 2,
> -	ARM_SPE_LLC_MISS		= 1 << 3,
> -	ARM_SPE_TLB_ACCESS		= 1 << 4,
> -	ARM_SPE_TLB_MISS		= 1 << 5,
> -	ARM_SPE_BRANCH_MISS		= 1 << 6,
> -	ARM_SPE_REMOTE_ACCESS		= 1 << 7,
> -	ARM_SPE_SVE_PARTIAL_PRED	= 1 << 8,
> -	ARM_SPE_SVE_EMPTY_PRED		= 1 << 9,
> -	ARM_SPE_BRANCH_NOT_TAKEN	= 1 << 10,
> -	ARM_SPE_IN_TXN			= 1 << 11,
> -};
> +#define ARM_SPE_L1D_ACCESS		BIT(EV_L1D_ACCESS)
> +#define ARM_SPE_L1D_MISS		BIT(EV_L1D_REFILL)
> +#define ARM_SPE_LLC_ACCESS		BIT(EV_LLC_ACCESS)
> +#define ARM_SPE_LLC_MISS		BIT(EV_LLC_MISS)
> +#define ARM_SPE_TLB_ACCESS		BIT(EV_TLB_ACCESS)
> +#define ARM_SPE_TLB_MISS		BIT(EV_TLB_WALK)
> +#define ARM_SPE_BRANCH_MISS		BIT(EV_MISPRED)
> +#define ARM_SPE_BRANCH_NOT_TAKEN	BIT(EV_NOT_TAKEN)
> +#define ARM_SPE_REMOTE_ACCESS		BIT(EV_REMOTE_ACCESS)
> +#define ARM_SPE_SVE_PARTIAL_PRED	BIT(EV_PARTIAL_PREDICATE)
> +#define ARM_SPE_SVE_EMPTY_PRED		BIT(EV_EMPTY_PREDICATE)
> +#define ARM_SPE_IN_TXN			BIT(EV_TRANSACTIONAL)
>   
>   enum arm_spe_op_type {
>   	/* First level operation type */
> @@ -100,7 +98,7 @@ enum arm_spe_hisi_hip_data_source {
>   };
>   
>   struct arm_spe_record {
> -	enum arm_spe_sample_type type;
> +	u64 type;
>   	int err;
>   	u32 op;
>   	u32 latency;
> 

