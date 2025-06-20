Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C992F289E1B
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416685; cv=none; b=nQaXv8h2yPW/t6pIYiDsmgDb08N2Ngu5e1tx7oik3ZitgQDW8Xfk95u52lirLNLXoADMQVotPUQ5pZUk4Nz4ibtSan3MlIqGnlc9pFDHfQvooN9KheY7GICwsGF0xSb8cuCRvvSK7Qj2TFI7ANJ1RXsnyFVQMpu75/wdC/B5Ge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416685; c=relaxed/simple;
	bh=A0IAJd+3UQLtZQuplCIdEy/7Llwe+P7D4JlnG8Rd1VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FjmmnDewVfRUsrua8qj/qYffay77VhKAFNJNY2zjzWpD8zAGvWlvCy149yC7HgilAzFpnWxeKnoFkKaFrPNYBlFmC3Zl9AxVU85k8yLmgIjB+wbHnbOpvSqMx3CAiEaPlLnhhCs+XQIGZ9qCpa0tS7Y8MXCF2iDrsq9PeaHxC+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eoR/HF99; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eoR/HF99"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so9975345e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750416682; x=1751021482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wuLrjbbKOgaIzal22l5ckDSrq4FJ56tyusFUaCNNOC8=;
        b=eoR/HF99nkHhbEpW+l6fgEw9xBXuRUMrc8FPi5WHCYBqKmqeIVMcKdaxQvv8wiyHPz
         PF/u0ND0xrwxsydHFRroDkTdNDhRYZBRoX2stGq0b0YYfWxo+NdJKc+APG4aIREhfEip
         6AQaybinwFFeyw+B1VTsgRJHXdV1ITj3CBv0teBqEbajcodaMnYbyU+TZkB+wF+GTo6/
         LFnb+CGldQIh3bncz/Ekqcq39jlc0eGTPAT8ZTIJL8Rl1xPCDqQJy1Xkkm+G8+r2RQVr
         uZHcIYUkCJNjWFnUMFQt7oHf2a0NucbLwV0Y4QQ0xrjxmXsMKMwcZKqG69ZlEC84K48A
         IWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750416682; x=1751021482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuLrjbbKOgaIzal22l5ckDSrq4FJ56tyusFUaCNNOC8=;
        b=hpCNs2F1zvcRgWLk+TAiXgs72MkXVU4HmTu5tpSzVl3+bsSu24b5HKxydmoMZ8piKE
         xYFn5FOA5+JdHxXr9D9Gcj8/sWRE7qE9ZLlATM3Ph2t70y6MQJJO+UwkW4SCS/HLT8qI
         e6jfAkba3OqLOPaU83kG7UO6IUaIr0fYyoZvxldHkAJ3yhd0hCgkW2kUefEBPJXSQLmR
         L2GKtEqbjy/Cu6AILfAXBGHr1N5yjNobIOoc05qGvyGVTf5ZhHGVim8D43hptLGipVnW
         u/hyripebfxEWSsm2JNPwfg21bbhZTO9uVzScMjq2eKWvfTnkN0Tn5qp6zUMfSpFsJWF
         ntkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXhhR5XueFcowFBIgQ52PkbyZirc0SLeMw4N+JUYm6+Zlx2DyuLz9WhhvHDgyKbjJ8Q5c7M5WWa5Afd9PuQqpWg@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPh3TvUDoRqjwTrFIjqe48j8oVQ1yqV6vcrR/8twRKtGhTobO
	2iCkapAoxvku9u+oOZDHbx2XLWzQc5ZkXjjQWXFar3ZbPP7obfDGwznCLaWfVCGRq1w=
X-Gm-Gg: ASbGncvb7fd0cKCGAc+kqHKRKIQ4iL7EiVZdt6tVGdMpJ/jVCzrcuLyuKomIdCZOsOy
	Twgg7bTOmsOV6p5qGAYnOux47d4oJQilt/Q5JdXJ9sxRmtIxGEmup69AyKFD9S1P2mJUNYicyBs
	3sR9Qrs/4poAee0ETinic9ptK7yZmX9DTm5mVjefvoqkgN2EByA/pkRBMRmNiByas1SXFQGmgP4
	TGYEUO4ifElRo8Z7h3Gq/tKshsrGaVb37rgAzgFy4hJyF0jOqBamKIT6JfTxv3MAZGbxT1lUHCF
	ZQ6aBw2Ta/96fdkWJFa5krC9Cw3bdsAd1oiL7VhvUzGQvMxTOVjzOJYao8xhxOuvekZfY0pPRkV
	IPg==
X-Google-Smtp-Source: AGHT+IG5fVMEopdEziHI+RGidETpM3IE7UHI2UOJ/hAkd2zj3k25GLKI+2A0L4NRM5cb36+ALaJzpQ==
X-Received: by 2002:a05:600c:1e8a:b0:442:f956:53f9 with SMTP id 5b1f17b1804b1-453659dde93mr22342415e9.18.1750416682104;
        Fri, 20 Jun 2025 03:51:22 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d117c02fsm1736693f8f.50.2025.06.20.03.51.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:51:21 -0700 (PDT)
Message-ID: <dc919865-317c-49c8-a6b4-8ce2a6cf9c0a@linaro.org>
Date: Fri, 20 Jun 2025 11:51:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] perf arm_spe: Set HITM flag
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-11-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-11-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Since FEAT_SPEv1p4, Arm SPE provides extra two events "Cache data
> modified" and "Data snooped".
> 
> Set the snoop mode as:
> 
> - If both the "Cache data modified" event and the "Data snooped" event
>    are set, which indicates a load operation that snooped from a outside
>    cache and hit a modified copy, set the HITM flag to inspect false
>    sharing.
> - If the snooped event bit is not set, and the snooped event has been
>    supported by the hardware, set as NONE mode (no snoop operation).
> - If the snooped event bit is not set, and the event is not supported or
>    absent the events info in the meta data, set as NA mode (not
>    available).
> 
> Don't set any mode for only "Cache data modified" event, as it hits a
> local modified copy.
> 

Reviewed-by: James Clark <james.clark@linaro.org>

> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe-decoder/arm-spe-decoder.h |  2 ++
>   tools/perf/util/arm-spe.c                         | 26 +++++++++++++++++++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 90c76928c7bf1b35cec538abdb0e88d6083fe81b..a2b48b0c87712f232587023eeaa66a9b83aed382 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -28,6 +28,8 @@
>   #define ARM_SPE_L2D_ACCESS		BIT(EV_L2D_ACCESS)
>   #define ARM_SPE_L2D_MISS		BIT(EV_L2D_MISS)
>   #define ARM_SPE_RECENTLY_FETCH		BIT(EV_RECENTLY_FETCHED)
> +#define ARM_SPE_DATA_SNOOPED		BIT(EV_DATA_SNOOPED)
> +#define ARM_SPE_HITM			BIT(EV_CACHE_DATA_MODIFIED)
>   
>   enum arm_spe_op_type {
>   	/* First level operation type */
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 8e93b0d151a98714d0c5e5f6ceec386a2aa63ad0..8a889f727f9cd5351b4ca027935112eddd16ea6c 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -903,9 +903,12 @@ static void arm_spe__synth_st_memory_level(const struct arm_spe_record *record,
>   	}
>   }
>   
> -static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
> +static void arm_spe__synth_memory_level(struct arm_spe_queue *speq,
> +					const struct arm_spe_record *record,
>   					union perf_mem_data_src *data_src)
>   {
> +	struct arm_spe *spe = speq->spe;
> +
>   	if (data_src->mem_op == PERF_MEM_OP_LOAD)
>   		arm_spe__synth_ld_memory_level(record, data_src);
>   	if (data_src->mem_op == PERF_MEM_OP_STORE)
> @@ -916,6 +919,25 @@ static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>   		data_src->mem_lvl_num = PERF_MEM_LVLNUM_NA;
>   	}
>   
> +	if (record->type & ARM_SPE_DATA_SNOOPED) {
> +		if (record->type & ARM_SPE_HITM)
> +			data_src->mem_snoop = PERF_MEM_SNOOP_HITM;
> +		else
> +			data_src->mem_snoop = PERF_MEM_SNOOP_HIT;
> +	} else {
> +		u64 *metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
> +
> +		/*
> +		 * Set NA ("Not available") mode if no meta data or the
> +		 * SNOOPED event is not supported.
> +		 */
> +		if (!metadata ||
> +		    !(metadata[ARM_SPE_CAP_EVENTS] & ARM_SPE_DATA_SNOOPED))
> +			data_src->mem_snoop = PERF_MEM_SNOOP_NA;
> +		else
> +			data_src->mem_snoop = PERF_MEM_SNOOP_NONE;
> +	}
> +
>   	if (record->type & ARM_SPE_REMOTE_ACCESS)
>   		data_src->mem_remote = PERF_MEM_REMOTE_REMOTE;
>   }
> @@ -971,7 +993,7 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>   		return 0;
>   
>   	if (!arm_spe__synth_ds(speq, record, &data_src))
> -		arm_spe__synth_memory_level(record, &data_src);
> +		arm_spe__synth_memory_level(speq, record, &data_src);
>   
>   	if (record->type & (ARM_SPE_TLB_ACCESS | ARM_SPE_TLB_MISS)) {
>   		data_src.mem_dtlb = PERF_MEM_TLB_WK;
> 

