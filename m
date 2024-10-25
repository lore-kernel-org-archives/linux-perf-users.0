Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE2E192592
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845345; cv=none; b=XmWlNoqYpcWBTqp6GeqJMg7KzLXEBTprek9D4lq94iyFFmgAS18a5c1LpiPgrDJjj2YCtpH/ZnKhCZ0beBIH++Q16Bh/pvfT1YxQUrowXbgrIOb7tkxIzmdfQfnYqCzvYelWKb8tIw35EePN0va59J427jNh9zrh4J+6H2E07Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845345; c=relaxed/simple;
	bh=EFsUeRfWqfPskfajyHVRxLGSjxxTSZN3OVAmT2dlNWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tRCc2Bcr2NzeJ6ehUL05CPObBB6O2Z9iiGuwd3jiYiOM3l7uqMlZ1jdx4HDwnrZaeRwCZn9kkBudhjiShc7/w4EqFpo+rs88XUqvX1AIk4yEjjFv4LeXiv+ipTsGzLIjLTOAegnEU1Tb4SFU8N/DjWuyoJsTwHrWzwQBZh4gFF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IETPZw0T; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IETPZw0T"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d4ba20075so1179036f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Oct 2024 01:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729845341; x=1730450141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5k2Y+wXN6Hav1m44Bf7BhVnqUudrumhttYGCCLQPyAo=;
        b=IETPZw0TlUi0Cg06CXK/CtVWAX0bNgV8l2G6g9PPCaa4qtaal3pu+ct04GNb6ur7Ar
         GIVvkm70EqLZz62TFh8upCW0F3+yQCFmKwpOEwdzP/B45XQBinu+H01Zpyf8NzEdVO2X
         4F9lTENVcqLrwc05fEBgVGdubS6wrABHecjLsvS1uhpA2CDtHEhM0JqTD4VJwcN3ilpR
         iA4THhpjJM9Krs5Y/GjfMLTbJXP27Kheo9DG0nIxfx40bY7CiXXHrSGDDRiGHSlpOOJy
         NB7NrBa2VRcH5vJy9SG1T6h+D8H5ZPSzcFYUT9lPdd4x3JoRVsqUaM/GnuxIFKMA13zb
         CwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845341; x=1730450141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5k2Y+wXN6Hav1m44Bf7BhVnqUudrumhttYGCCLQPyAo=;
        b=dOHRn+Hd9O92Lr7pd0NHZ4CegTrLDsN2LVwC/oaFztnK+Tf3N50t4WAKR0j+9f2+PQ
         i6uQhce8DRCD8Gzr4eVrExnFfTDgrn3sSFi5fj0fKlJOR6B++G2oa1Cf1hO6w1YGvZBU
         SY5UV0807PrBmGLQgLHayCU9+gwrWGhm2kiTrzHfwVp9FYO7e6k3uu39bSY5T78hZal9
         8WLflJunSUWr7uF6HskmTglzkBkWBnEQ4BA8t6pQPPFQLdOaPVZAXegtBXIX8bFEuj1T
         z1/jpcD7jqhxEStPy8QZCu5AwQrZd8dnX30RnbbqKDoGXAqPHR8AKL0siN+5rFasx9ia
         n+IA==
X-Gm-Message-State: AOJu0YxaxVH692FCswhKkPAQNRihzL/mdbfme30lV4cWm81kzO2iTSfs
	kATBJWjwLdrdMUV5by1g5vXmc+uIZX/TffbXwUha7rC91U/ftwmYVPTtRqd4geY=
X-Google-Smtp-Source: AGHT+IF1Dm7/LCI5G/4YSRLj2pNyCW0v5xHJasePqVKzqYtzpxJfSsCdFuesRxA5iyqBt/qELFK6fA==
X-Received: by 2002:adf:e2cb:0:b0:37c:d1c7:a0c0 with SMTP id ffacd0b85a97d-37efcf1af2amr5912704f8f.30.1729845341033;
        Fri, 25 Oct 2024 01:35:41 -0700 (PDT)
Received: from [192.168.68.136] ([145.224.65.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3c7f6sm945622f8f.41.2024.10.25.01.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 01:35:40 -0700 (PDT)
Message-ID: <963d58e4-c00e-40b5-bb64-97476807ed61@linaro.org>
Date: Fri, 25 Oct 2024 09:35:33 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf arm-spe: Add support for SPE Data Source packet on
 AmpereOne
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>
References: <20241024233035.7979-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241024233035.7979-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/10/2024 12:30 am, Ilkka Koskinen wrote:
> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
>   tools/perf/util/arm-spe.c                     | 61 +++++++++++++++++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 1443c28545a9..e4115b1e92b2 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -67,6 +67,15 @@ enum arm_spe_neoverse_data_source {
>   	ARM_SPE_NV_DRAM		 = 0xe,
>   };
>   
> +enum arm_spe_ampereone_data_source {
> +	ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE	= 0x0,
> +	ARM_SPE_AMPEREONE_SLC				= 0x3,
> +	ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE		= 0x5,
> +	ARM_SPE_AMPEREONE_DDR				= 0x7,
> +	ARM_SPE_AMPEREONE_L1D				= 0x8,
> +	ARM_SPE_AMPEREONE_L2D				= 0x9,
> +};
> +
>   struct arm_spe_record {
>   	enum arm_spe_sample_type type;
>   	int err;
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 138ffc71b32d..04bd21ad7ea8 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -515,10 +515,69 @@ static void arm_spe__synth_data_source_generic(const struct arm_spe_record *reco
>   		data_src->mem_lvl |= PERF_MEM_LVL_REM_CCE1;
>   }
>   
> +static const struct midr_range ampereone_source_spe[] = {
> +	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> +	{},
> +};
> +
> +static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
> +						 union perf_mem_data_src *data_src,
> +						 u64 midr)
> +{
> +	if (!is_midr_in_range_list(midr, ampereone_source_spe)) {
> +		arm_spe__synth_data_source_generic(record, data_src);
> +		return;
> +	}
[...]
>   static u64 arm_spe__synth_data_source(const struct arm_spe_record *record, u64 midr)
>   {
>   	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
>   	bool is_neoverse = is_midr_in_range_list(midr, neoverse_spe);
> +	bool is_ampereone = (read_cpuid_implementor() == ARM_CPU_IMP_AMPERE);
>   

Hi Ilkka,

I think this read_cpuid_implementor() is for the device that's running 
report, rather than record. You need to use the midr that's saved into 
the file.

But it looks like you've done that for is_midr_in_range_list(midr, 
ampereone_source_spe) above. Is it possible to just do that and not 
read_cpuid_implementor() and then it's done the same way as neoverse and 
also works off target?

Thanks

James

