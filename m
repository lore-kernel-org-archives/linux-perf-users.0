Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B911C6F45
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Oct 2024 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790820; cv=none; b=dZyhFCYbMlc3vy71Jw0FHQXnlE870BXgBjTQKGbuuLVXhz5qFvhWAv2hpSj7ENJIgqXAkiw4l/PX73y83u9U+q6V7iAjqCYsvxJ0hpFyY7nFeRoX1SVLFBTOhuldY5KoXg6XZn7lfNzYh5hDlST7Wz70DwZEuvaHhL662C8SR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790820; c=relaxed/simple;
	bh=bHgH14tt31qsqFvh/zbZewblc8rFaP9IGjgnQtKbOdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=nHqb3u41f0sx22OUD3d36rPTQXsc9lzQ7Z5AJqAYNjcVQyyj/3SeFrDvJBpufzOMI8wRc5xeueRb1Y2vMFK9qQ+sP0qIUzQjXbL4eab+Ni3iZwLPXeinmFefwDToy1Mh2NGG+g/+rDiZe37LBxQefG9IUGS28xQ8oRBqudtE/g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dVvrqeiv; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVvrqeiv"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c8af23a4fcso294496a12.0
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Oct 2024 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727790816; x=1728395616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wn3DsWREdtnEOKLXXSzOMEDspeKI8CLijSVF0lV0dHw=;
        b=dVvrqeivMe2e3XTIemIH6agY3zwlHqhQ103XcOmWdhaUmxuhMpYiXs7Dct6UWHtyrr
         fgnmA8tZBPx4jcAkaZv8T6GehbZenDL12nmsxrCS8VRRgcCkQOSbK6fiERwJitlLEtc1
         c0WenqSMgjFs0oWkBA9LjqJHHAfueDGKOV0KuxxLYsQbvd2R/s6Xbm2SesqN+kqlXMsu
         wBIhvYLZFY4X3CNyl0xKsNdVLE6NPBM1Y1y6WSeAB0SLKRCjb+H0O47so7yO4CCVKF7e
         WYZ0H8DnJZ8tNhwGqslVY3LuzAjs8wtpTTR8B0ktIN0yYC8eTO0lQnWds88/hJlrfb0E
         592w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727790816; x=1728395616;
        h=content-transfer-encoding:in-reply-to:cc:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wn3DsWREdtnEOKLXXSzOMEDspeKI8CLijSVF0lV0dHw=;
        b=Ak7D0MN4aNk8vfkW8x94ePFS/AZi8F6iJ8iUq+gKiOJU+rtQTelA+5A1nScqZYPgwv
         IxVyFQoryIQGEfpHjUkbI/qfk9adxjjxFxulUX5sPghSHcQihBW4XvyNW3qQGUMOElpj
         rLvsNP+as4aRnNjtkqExjx7x4ST8SZjpUSTzLRHcA3fifrDekN+IWXWmc54nt0yHpqht
         dxrjUfakkHJDmgndV6mCfEKNJrmP9CErHShnKXBB2AqzsbUopC6drJkDUvaE0hdRqgKh
         abnYacpeHyWdVlDRd0/FYFhpX8wCDdmLr4C789BRAb3pvZbxbV3h9/GWjKuZ4veCF0em
         eOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvCpK1ddu4laHF8UCFELvAVQnaUPicphQg7OA6zgxUIfGpBrW9Gipz+l7/bjhNd0/9lXgzlQAtdOJljRoddiyq@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHJdCBDYuLI8JM/Nd3+NeQXeklwYvpcYLzrtp3OOOgpty2323
	QfbYjQxCxEMZEk212OpkEFUkHepW/gh0L9KPTg/Hf8N8nWw95n74Ysl1Y+aCKKg=
X-Google-Smtp-Source: AGHT+IGJ4gEVrFJHyR3Yr3exSTVS+L+q41Iy6m8FZ2dSxqFIVekAfLXejxAgfZjkFb0qfdXsWwxl6Q==
X-Received: by 2002:a50:8d88:0:b0:5c2:6c2d:3fb3 with SMTP id 4fb4d7f45d1cf-5c88261004bmr12674494a12.36.1727790816233;
        Tue, 01 Oct 2024 06:53:36 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c882405c9csm6480301a12.8.2024.10.01.06.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 06:53:35 -0700 (PDT)
Message-ID: <552951c4-7a8e-44df-af23-8eb112c17709@linaro.org>
Date: Tue, 1 Oct 2024 14:53:34 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] perf arm-spe: Support metadata version 2
To: Leo Yan <leo.yan@arm.com>
References: <20240928195547.59780-1-leo.yan@arm.com>
 <20240928195547.59780-5-leo.yan@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Besar Wicaksono <bwicaksono@nvidia.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20240928195547.59780-5-leo.yan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/09/2024 8:55 pm, Leo Yan wrote:
> This commit is to support metadata version 2 and at the meantime it is
> backward compatible for version 1's format.
> 
> The metadata version 1 doesn't include the ARM_SPE_HEADER_VERSION field.
> As version 1 is fixed with two u64 fields, by checking the metadata
> size, it distinguishes the metadata is version 1 or version 2 (and any
> new versions if later will have). For version 2, it reads out CPU number
> and retrieves the metadata info for every CPU.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 95 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 70989b1bae47..52cee7401ff4 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -78,6 +78,10 @@ struct arm_spe {
>   
>   	unsigned long			num_events;
>   	u8				use_ctx_pkt_for_pid;
> +
> +	u64				**metadata;
> +	u64				metadata_ver;
> +	u64				metadata_nr_cpu;
>   };
>   
>   struct arm_spe_queue {
> @@ -1016,6 +1020,73 @@ static int arm_spe_flush(struct perf_session *session __maybe_unused,
>   	return 0;
>   }
>   
> +static u64 *arm_spe__alloc_per_cpu_metadata(u64 *buf, int per_cpu_size)
> +{
> +	u64 *metadata;
> +
> +	metadata = zalloc(per_cpu_size);
> +	if (!metadata)
> +		return NULL;
> +
> +	memcpy(metadata, buf, per_cpu_size);
> +	return metadata;
> +}
> +
> +static void arm_spe__free_metadata(u64 **metadata, int nr_cpu)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_cpu; i++)
> +		zfree(&metadata[i]);
> +	free(metadata);
> +}
> +
> +static u64 **arm_spe__alloc_metadata(struct perf_record_auxtrace_info *info,
> +				     u64 *ver, int *nr_cpu)
> +{
> +	u64 *ptr = (u64 *)info->priv;
> +	u64 metadata_size;
> +	u64 **metadata = NULL;
> +	int hdr_sz, per_cpu_sz, i;
> +
> +	metadata_size = info->header.size -
> +		sizeof(struct perf_record_auxtrace_info);
> +
> +	/* Metadata version 1 */
> +	if (metadata_size == ARM_SPE_AUXTRACE_V1_PRIV_SIZE) {
> +		*ver = 1;
> +		*nr_cpu = 0;
> +		/* No per CPU metadata */
> +		return NULL;
> +	}
> +
> +	*ver = ptr[ARM_SPE_HEADER_VERSION];
> +	hdr_sz = ptr[ARM_SPE_HEADER_SIZE];
> +	*nr_cpu = ptr[ARM_SPE_CPUS_NUM];
> +
> +	metadata = calloc(*nr_cpu, sizeof(*metadata));
> +	if (!metadata)
> +		return NULL;
> +
> +	/* Locate the start address of per CPU metadata */
> +	ptr += hdr_sz;
> +	per_cpu_sz = (metadata_size - (hdr_sz * sizeof(u64))) / (*nr_cpu);
> +
> +	for (i = 0; i < *nr_cpu; i++) {
> +		metadata[i] = arm_spe__alloc_per_cpu_metadata(ptr, per_cpu_sz);
> +		if (!metadata[i])
> +			goto err_per_cpu_metadata;
> +
> +		ptr += per_cpu_sz / sizeof(u64);
> +	}
> +
> +	return metadata;
> +
> +err_per_cpu_metadata:
> +	arm_spe__free_metadata(metadata, *nr_cpu);
> +	return NULL;
> +}
> +
>   static void arm_spe_free_queue(void *priv)
>   {
>   	struct arm_spe_queue *speq = priv;
> @@ -1050,6 +1121,7 @@ static void arm_spe_free(struct perf_session *session)
>   	auxtrace_heap__free(&spe->heap);
>   	arm_spe_free_events(session);
>   	session->auxtrace = NULL;
> +	arm_spe__free_metadata(spe->metadata, spe->metadata_nr_cpu);
>   	free(spe);
>   }
>   
> @@ -1267,15 +1339,24 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>   	const char *cpuid = perf_env__cpuid(session->evlist->env);
>   	u64 midr = strtol(cpuid, NULL, 16);
>   	struct arm_spe *spe;
> -	int err;
> +	u64 **metadata = NULL;
> +	u64 metadata_ver;
> +	int nr_cpu, err;
>   
>   	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_info) +
>   					min_sz)
>   		return -EINVAL;
>   
> +	metadata = arm_spe__alloc_metadata(auxtrace_info, &metadata_ver,
> +					   &nr_cpu);
> +	if (!metadata && metadata_ver != 1) {
> +		pr_err("Failed to parse Arm SPE metadata.\n");
> +		return -EINVAL;
> +	}
> +
>   	spe = zalloc(sizeof(struct arm_spe));
>   	if (!spe)
> -		return -ENOMEM;
> +		goto err_free_metadata;
>   

Hi Leo,

There's a build error here:

util/arm-spe.c:1402:6: error: variable 'err' is used uninitialized 
whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
         if (!spe)
             ^~~~


>   	err = auxtrace_queues__init(&spe->queues);
>   	if (err)
> @@ -1284,8 +1365,14 @@ int arm_spe_process_auxtrace_info(union perf_event *event,
>   	spe->session = session;
>   	spe->machine = &session->machines.host; /* No kvm support */
>   	spe->auxtrace_type = auxtrace_info->type;
> -	spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	if (metadata_ver == 1)
> +		spe->pmu_type = auxtrace_info->priv[ARM_SPE_PMU_TYPE];
> +	else
> +		spe->pmu_type = auxtrace_info->priv[ARM_SPE_SHARED_PMU_TYPE];

I thought V2 saved the type per-CPU, so I wasn't that clear on the 
SHARED_PMU_TYPE vs ARM_SPE_PMU_TYPE use here. Maybe it's just a naming 
issue? If it's a placeholder value to generate events can it be the same 
name as the V1 enum, that way it's clearer that it's the same thing.

Like: ARM_SPE_PMU_TYPE_V2


Other than that, for the whole set:

Reviewed-by: James Clark <james.clark@linaro.org>

