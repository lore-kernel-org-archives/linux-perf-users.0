Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CAA18A6B5
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720832; cv=none; b=aP8ADdWaHGh/d92z3kD1Dq5oFClp00Nrn72rvoR3fvS6UgkqPZIke0lZwvF8dNmujbN0V0VeOSfjtfeLuzW1e0XrF4qE4gIbD4bnBAAleqd+cKMkgHTKZ17WQqHYpmOxYCnh5PrDzRG1/AxS0X8zeIfQetyeoHORooOKjYl3MLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720832; c=relaxed/simple;
	bh=PyullqZk2NrriXcY6CBFMfbW7+XiGUFm8DUyVMWaVk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U4y5dEeC/PZ8OM/pAP5mpK4+RcbOPleQfV0B0EkUGEuPmmMxOOmt5SS85kJq/WWJtVwS6S0sjq7sLAFa+V4y+/tvEsW5p3dZ+IfqpRuKwwzo8k0zu+WNia8SAlo9f8E5UcJdB+d82+FGN1DxEo6UlRInlgBsAWZhF4vgtlU2S10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nrN3fTDf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nrN3fTDf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d447de11dso3295620f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Nov 2024 03:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730720829; x=1731325629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lh5+3KGOkaelrIB4Nl2tEoQoHe7RgDBZJ7Oaq3ExHpo=;
        b=nrN3fTDfe5xoy6oP6JIY/CdvjsmXpAqHqzWB85/a4SjJlQm637V/8xI+9ywb5Iz5uc
         tG0DrkTTUUG8Jxc6c6u/nVXa1WoCjQeG8iT6kxysRg5s8deh37Vc7ok0h81GxokMPMHe
         1M6uZkZbjJfu5Zc5EMLO+FS5H4xn9KY897K5sC5nL6N+2cWqV5Jxo60UPrdRehjQV14Y
         ryLi6kjkvtgKHGgd87POanMKdd1iRxtoJDCdO9B6/ky/nJsfr7vueIL6S8rzJcqjkq8A
         85qtKpft+Pq/tfLJ7/49XODpC8qqF5Sv4f3ezK9CzkMRVo2Fi47M2UP5+Pyod6HZeGU8
         3seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720829; x=1731325629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lh5+3KGOkaelrIB4Nl2tEoQoHe7RgDBZJ7Oaq3ExHpo=;
        b=ePB7ja5L+m+Gb0ouELevqcYTcIJTrOhrFkloVmwF6yiR2teYOgDiehSdyBlml1groT
         f1dqP1P1ZMavr8elLyIchFY809Cdy31nEkjqpqWF6cI9U0+QqA5kBLq/G7JqUMlnvbLa
         HieW/9jNKjDWu4XZ+edHpAltrEYqDpjkHcoLZmBGdRzamIZFDv44OBQNsUas48pC9/7F
         QYn+GqXvjxVhRTV2Ljp5iobtoSTlGKh36g2iEn6K5r2c/WQu/9XtLo4EeDxFDmfzbc3C
         kO7Oz7+TunXzqumT/lEt7PjNi8oZlE3e8mRUk1H0lbJaDGHxy+Cec7tOvcUC3xkgBesD
         HdTA==
X-Forwarded-Encrypted: i=1; AJvYcCWjHxZX7nOUbP6e1KQWCodmRhho2/QKmnZmxKEsGlzwySCB1U4QRuJCmUFnkdVBBWMFj2EvdkkEGhaHSk8GSRRS@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxhyBWBNRgQXpHo332TlDkQJEQt60Fz/AFSd/rrgFK0tqCdsv
	cCp7wMpbft5NzoFnhUWjU/948wDZyvGjOq2WcJIk7PJVQaVik+xo4fXdM2Wti/k=
X-Google-Smtp-Source: AGHT+IGpbkSWgNkUv+H2MDavqFNOI/hX8U3WpCkkxEpPxrbnjPpDbaoC59i6YBF7QSDjt9Pl6iuLIA==
X-Received: by 2002:a5d:64a1:0:b0:37d:4fe9:b6a7 with SMTP id ffacd0b85a97d-381bea1c1f4mr13084577f8f.36.1730720828889;
        Mon, 04 Nov 2024 03:47:08 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10b7c13sm13193474f8f.13.2024.11.04.03.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 03:47:08 -0800 (PST)
Message-ID: <ed15526d-9b1a-4204-92a3-4d319b03b790@linaro.org>
Date: Mon, 4 Nov 2024 11:47:06 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf arm-spe: Add support for SPE Data Source
 packet on AmpereOne
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Graham Woodward <graham.woodward@arm.com>
References: <20241031213533.11148-1-ilkka@os.amperecomputing.com>
 <20241031213533.11148-3-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241031213533.11148-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/10/2024 9:35 pm, Ilkka Koskinen wrote:
> Decode SPE Data Source packets on AmpereOne. The field is IMPDEF.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../util/arm-spe-decoder/arm-spe-decoder.h    |  9 +++
>   tools/perf/util/arm-spe.c                     | 65 +++++++++++++++++++
>   2 files changed, 74 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 358c611eeddb..4bcd627e859f 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -67,6 +67,15 @@ enum arm_spe_common_data_source {
>   	ARM_SPE_COMMON_DS_DRAM		= 0xe,
>   };
>   
> +enum arm_spe_ampereone_data_source {
> +	ARM_SPE_AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE    = 0x0,
> +	ARM_SPE_AMPEREONE_SLC                           = 0x3,
> +	ARM_SPE_AMPEREONE_REMOTE_CHIP_CACHE             = 0x5,
> +	ARM_SPE_AMPEREONE_DDR                           = 0x7,
> +	ARM_SPE_AMPEREONE_L1D                           = 0x8,
> +	ARM_SPE_AMPEREONE_L2D                           = 0x9,
> +};
> +
>   struct arm_spe_record {
>   	enum arm_spe_sample_type type;
>   	int err;
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 9586416be30a..700d4bc8d8ec 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -103,6 +103,30 @@ struct arm_spe_queue {
>   	u32				flags;
>   };
>   
> +struct arm_spe_source_mapping {
> +	u16 source;
> +	enum arm_spe_common_data_source common_src;
> +};
> +
> +#define MAP_SOURCE(src, common)				\
> +	{						\
> +		.source = ARM_SPE_##src,		\
> +		.common_src = ARM_SPE_COMMON_##common,  \
> +	}
> +
> +static int arm_spe__map_to_common_source(u16 source,
> +					 struct arm_spe_source_mapping *tbl,
> +					 int nr_sources)
> +{
> +	while (nr_sources--) {
> +		if (tbl->source == source)
> +			return tbl->common_src;
> +		tbl++;
> +	}
> +

Hi Ilkka,

I think a simple switch statement here would be easier to follow than 
the loop, custom macro and then having the mappings in some other place:

switch(source)
case 0x0: /* AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE */
   return DS_PEER_CORE;

etc...

> +	return -1;

And the default case can return 0xfff directly, which avoids the if else 
later only to convert this -1 back into 0xfff.

> +}
> +
>   static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>   			 unsigned char *buf, size_t len)
>   {
> @@ -443,6 +467,11 @@ static const struct midr_range common_ds_encoding_cpus[] = {
>   	{},
>   };
>   
> +static const struct midr_range ampereone_ds_encoding_cpus[] = {
> +	MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
> +	{},
> +};
> +
>   static void arm_spe__sample_flags(struct arm_spe_queue *speq)
>   {
>   	const struct arm_spe_record *record = &speq->decoder->record;
> @@ -532,6 +561,38 @@ static void arm_spe__synth_data_source_common(const struct arm_spe_record *recor
>   	}
>   }
>   
> +static struct arm_spe_source_mapping ampereone_sources[] = {
> +	MAP_SOURCE(AMPEREONE_LOCAL_CHIP_CACHE_OR_DEVICE, DS_PEER_CORE),
> +	MAP_SOURCE(AMPEREONE_SLC, DS_SYS_CACHE),
> +	MAP_SOURCE(AMPEREONE_REMOTE_CHIP_CACHE, DS_REMOTE),
> +	MAP_SOURCE(AMPEREONE_DDR, DS_DRAM),
> +	MAP_SOURCE(AMPEREONE_L1D, DS_L1D),
> +	MAP_SOURCE(AMPEREONE_L2D, DS_L2),
> +};
> +
> +/*
> + * Source is IMPDEF. Here we convert the source code used on AmpereOne cores
> + * to the common (Neoverse, Cortex) to avoid duplicating the decoding code.
> + */
> +static void arm_spe__synth_data_source_ampereone(const struct arm_spe_record *record,
> +						 union perf_mem_data_src *data_src)
> +{
> +	int common_src;
> +	struct arm_spe_record common_record;
> +
> +	common_src = arm_spe__map_to_common_source(record->source,
> +						   ampereone_sources,
> +						   ARRAY_SIZE(ampereone_sources));
> +	if (common_src < 0)
> +		 /* Assign a bogus value that's not used for common coding */
> +		common_record.source = 0xfff;
> +	else
> +		common_record.source = common_src;
> +
> +	common_record.op = record->op;
> +	arm_spe__synth_data_source_common(&common_record, data_src);
> +}
> +
>   static void arm_spe__synth_memory_level(const struct arm_spe_record *record,
>   					union perf_mem_data_src *data_src)
>   {
> @@ -606,6 +667,8 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>   	union perf_mem_data_src	data_src = { .mem_op = PERF_MEM_OP_NA };
>   	bool is_common = arm_spe__is_ds_encoding_supported(speq,
>   						common_ds_encoding_cpus);
> +	bool is_ampereone = arm_spe__is_ds_encoding_supported(speq,
> +						ampereone_ds_encoding_cpus);

I know this probably already works, but we don't really need is_common 
is_ampere etc, it will only grow anyway. All we need is a list of midrs 
and function pairs. That also avoids doing is_ampereone even after we 
already know is_common == true.

static const struct data_src[] = {
...
	DS(MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V2), common_ds),
	DS(MIDR_ALL_VERSIONS(MIDR_AMPERE1A), ampere_ds),
	{},
...
};

"arm_spe__is_ds_encoding_supported" then becomes a direct call to 
"arm_spe__synth_ds" and we can drop the is_ampereone and is_common vars. 
Then adding new ones doesn't require changing the function anymore.

>   
>   	if (record->op & ARM_SPE_OP_LD)
>   		data_src.mem_op = PERF_MEM_OP_LOAD;
> @@ -616,6 +679,8 @@ static u64 arm_spe__synth_data_source(struct arm_spe_queue *speq,
>   
>   	if (is_common)
>   		arm_spe__synth_data_source_common(record, &data_src);
> +	else if (is_ampereone)
> +		arm_spe__synth_data_source_ampereone(record, &data_src);
>   	else
>   		arm_spe__synth_memory_level(record, &data_src);
>   

