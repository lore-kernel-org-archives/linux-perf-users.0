Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221E629408
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739809263; cv=none; b=izqxDbgGBsfs7S95PR9WI31rIbLmc6DLLtZAt9nGgXNDGv+lAyHFUX3DjdAdX/BZ1Zjue5sMWdpsWM6aGDbdaeYzPWHNdcSO5tVepvldyIzcOr1eRUIATO5FF63voNGxsEQ9TUDlRT4YJoupQ/jNbXxqZXw48SOWwZOoZxoZSQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739809263; c=relaxed/simple;
	bh=mMQiqIZgNYnfxi6+lZiIaD/Lw2SsAOZGHC7m3aM1XaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jVmWcM4exRu0SIhhnPMybCu9SRssqb2nF4CIYb5S2tVs0daJmgjTf7dzO7jy3PGBE7KKrbhtu0mNL2WSJvDm2fouFgl4qsXI1LglnpUMbxCQYNhqvWcAJTxG1p3XEzjh0m0pSPOpXH4olu1q6jNmuZ3MBqlNsp4CH9o1CPeIjGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YgInNHpi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YgInNHpi"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4396a4d5e3bso30237835e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739809259; x=1740414059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hliszru8I65AnPHW7tmPd8zU3hebz8wd15dEVYUIRXU=;
        b=YgInNHpiFNWy046DAIzsFlX7oAvuTXVldv5+bbfaQs8v5OM/jmB7yXaWFD+Z/C6QMd
         nBYW7A3G+oI8p5HGbCuGPGeEDysfiBu/67974qScDilyhwE8VuQrlH66xmWlIR1Q9048
         76ABH8bNbzg6bp94N5Y2oRwjjTAII+K0ghadmyAbUNGh5sCZM6wnVVb3JwjDE89j1l5/
         gKX2GDWycz/hQDG0tmwWROsZHV89P4LjHM5KBAQFAhjZShxUWclrtq6qxBpImuv+3jKo
         yzUpdRWwNk97RwKnKOH5u1Y1tMYXbZonQ0IMzjXQaCbz+r2jEu37vQhAZ4oXOaFKUN7R
         Z2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739809259; x=1740414059;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hliszru8I65AnPHW7tmPd8zU3hebz8wd15dEVYUIRXU=;
        b=LPGFxdn29YU6rxY/6OVUbSMWmzTWEI1zP51CJFoT7IfHUVGttEfhUNmn0N3smzNqoB
         +hdWjcvlLkcBQXuhnwTCFyJkfyF6dCvbUpAmROhMlpfq/oxsDnxTgvC1ApcG9Hbz/jz0
         /5jCvCIrzlU99Nij295xIPU8w+quPl8Skvz/mfrEgjQMLVSXyF0GNSNmIxbh6H578hWz
         k4oJAzEtzrTP1QkX7lChS/rvKqHAuaDDiqtQ/pHnS+xB/wYt+rW5Ps6qBaCKaig2rHy0
         Swoj8/px1PTa0+qI385tZZ+YZuiUaaxTwUGC3Bk8cuwdofavYjaXSuc+G4CMoHJOkqdZ
         q+vg==
X-Forwarded-Encrypted: i=1; AJvYcCWiIhF2I2ktJkT9bokUVDq73bc/rHyw9FtJw9kMbh1f3bcKWdaSriJU9L4+bN2CnZkVnTGpOXvnDiQnZ5qCOYpA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw99PHgVHfgeKfHGIkNHGBeVoRRU5uIUGp9Bxx74MPqEfYMKYtv
	KuNJ2FUUZIOMbxl1JByoWNikealEC1hvT8Ooi1EswBvStgDgLjm6F1wi5ePhgfA=
X-Gm-Gg: ASbGncv5LWgvM6gexRrteX69dVl75N+whjCc8P3MOuquD47oDKnmTZoW8AJ4mpn6A5+
	AK3rRxUtq1nYGOsOhO/BMF8m2SiWPOQ+2DX+G5upvU/spV73KP6jipoiTSh3Ye4bP8YOJfqDn/2
	6h7F3ka3vn4/h7sexaMJIkDYqU5IaIX19iPBm8+l6fNeDdFysCYd80ieb3FnvCnb2QWh9O5/HeI
	CGuSKFs/4biy313lpdTZnK6hmOdDEzQD3A3ehbeERtaXspyb+keEQAX6hlpiIiAib8ZUhBgTCrV
	NdAHxiQ5cR1LMNsKZoRlZbWspw==
X-Google-Smtp-Source: AGHT+IGdNrAgcV9AT4395Oyj88ssWQXJfojFnIpoXQA8wy4Csu5ENmq+Sh9avVfhPt2Ol9bspdhIfg==
X-Received: by 2002:a05:600c:1d23:b0:439:6b57:c68 with SMTP id 5b1f17b1804b1-4396e6df8bemr92447005e9.17.1739809259341;
        Mon, 17 Feb 2025 08:20:59 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a06d22csm157199225e9.22.2025.02.17.08.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 08:20:58 -0800 (PST)
Message-ID: <a5d99e7f-1d8d-41f1-976d-7d67a0d5decb@linaro.org>
Date: Mon, 17 Feb 2025 16:20:57 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/11] perf arm-spe: Fill branch operations and events
 to record
To: Leo Yan <leo.yan@arm.com>
References: <20250214111936.15168-1-leo.yan@arm.com>
 <20250214111936.15168-9-leo.yan@arm.com>
Content-Language: en-US
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Graham Woodward
 <graham.woodward@arm.com>, Paschalis.Mpeis@arm.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250214111936.15168-9-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 14/02/2025 11:19 am, Leo Yan wrote:
> The new added branch operations and events are filled into record, the
> information will be consumed when synthesizing samples.
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   .../util/arm-spe-decoder/arm-spe-decoder.c     | 18 ++++++++++++++++++
>   .../util/arm-spe-decoder/arm-spe-decoder.h     | 10 ++++++++--
>   2 files changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index ba807071d3c1..52bd0a4ea96d 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -207,6 +207,18 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   				break;
>   			case SPE_OP_PKT_HDR_CLASS_BR_ERET:
>   				decoder->record.op |= ARM_SPE_OP_BRANCH_ERET;
> +				if (payload & SPE_OP_PKT_COND)
> +					decoder->record.op |= ARM_SPE_OP_BR_COND;

I think this results in memory events being synthesised for these 
samples because of a bug in arm_spe__synth_data_source(). 
ARM_SPE_OP_BR_COND overlaps with bits from other packet types like 
ARM_SPE_OP_LD:

	if (record->op & ARM_SPE_OP_LD)
		data_src.mem_op = PERF_MEM_OP_LOAD;

arm_spe__synth_data_source() needs to only interpret that as a data 
source packet if ARM_SPE_OP_LDST is set. This was reported by Mike 
Williams but you have the privilege of hitting it for real first.

> +				if (payload & SPE_OP_PKT_INDIRECT_BRANCH)
> +					decoder->record.op |= ARM_SPE_OP_BR_INDIRECT;
> +				if (payload & SPE_OP_PKT_GCS)
> +					decoder->record.op |= ARM_SPE_OP_BR_GCS;
> +				if (SPE_OP_PKT_CR_BL(payload))
> +					decoder->record.op |= ARM_SPE_OP_BR_CR_BL;
> +				if (SPE_OP_PKT_CR_RET(payload))
> +					decoder->record.op |= ARM_SPE_OP_BR_CR_RET;
> +				if (SPE_OP_PKT_CR_NON_BL_RET(payload))
> +					decoder->record.op |= ARM_SPE_OP_BR_CR_NON_BL_RET;
>   				break;
>   			default:
>   				pr_err("Get packet error!\n");
> @@ -238,6 +250,12 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>   			if (payload & BIT(EV_MISPRED))
>   				decoder->record.type |= ARM_SPE_BRANCH_MISS;
>   
> +			if (payload & BIT(EV_NOT_TAKEN))
> +				decoder->record.type |= ARM_SPE_BRANCH_NOT_TAKEN;
> +
> +			if (payload & BIT(EV_TRANSACTIONAL))
> +				decoder->record.type |= ARM_SPE_IN_TXN;
> +
>   			if (payload & BIT(EV_PARTIAL_PREDICATE))
>   				decoder->record.type |= ARM_SPE_SVE_PARTIAL_PRED;
>   
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 4bcd627e859f..85b688a97436 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -24,6 +24,8 @@ enum arm_spe_sample_type {
>   	ARM_SPE_REMOTE_ACCESS		= 1 << 7,
>   	ARM_SPE_SVE_PARTIAL_PRED	= 1 << 8,
>   	ARM_SPE_SVE_EMPTY_PRED		= 1 << 9,
> +	ARM_SPE_BRANCH_NOT_TAKEN	= 1 << 10,
> +	ARM_SPE_IN_TXN			= 1 << 11,
>   };
>   
>   enum arm_spe_op_type {
> @@ -52,8 +54,12 @@ enum arm_spe_op_type {
>   	ARM_SPE_OP_SVE_SG		= 1 << 27,
>   
>   	/* Second level operation type for BRANCH_ERET */
> -	ARM_SPE_OP_BR_COND	= 1 << 16,
> -	ARM_SPE_OP_BR_INDIRECT	= 1 << 17,
> +	ARM_SPE_OP_BR_COND		= 1 << 16,
> +	ARM_SPE_OP_BR_INDIRECT		= 1 << 17,
> +	ARM_SPE_OP_BR_GCS		= 1 << 18,
> +	ARM_SPE_OP_BR_CR_BL		= 1 << 19,
> +	ARM_SPE_OP_BR_CR_RET		= 1 << 20,
> +	ARM_SPE_OP_BR_CR_NON_BL_RET	= 1 << 21,
>   };
>   
>   enum arm_spe_common_data_source {

