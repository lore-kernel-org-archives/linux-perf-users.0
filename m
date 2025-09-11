Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918E353376
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757606916; cv=none; b=Oe4CVlP7Tk/zhBJet3+7ENSlQ0yv34IpxvYi/F4U1/iYWixghjkgdPoOB18mCpp3msnsD5AxS293x0sjUVKL7P3+TIMNT1I3q5tPGSBKdjZtMmEp1miq09bXOGA0iZHWF0uZ77+BmMG5ofEr/D7kg1huIimBGxgm9fCJWl5nAZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757606916; c=relaxed/simple;
	bh=M7q9wwrTbYg4+fXHTr/4BB9JhYNcqNO1gc+Tx06WpNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzPzue8bZWDc7FYfObffVnsK+t1sMCmhF5DjM4/fxwV/qj+zZWcc4SYvHCFPmi2VKzwP31dv5PLYKH5ry3GG0B2NCH9yly+Oc1Z+MQAMGyQ08KczsNAywZ4+beFC7ladwOuJ9DFsPaox/jW5Cxet6EofGOpCpuFLfWHHhVK1/7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wRaP/Ofd; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wRaP/Ofd"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so11215755e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757606913; x=1758211713; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrHTwyWRmcCmqZ+ZvtvvUN7JeKm53BmHzdcNZQjwcwU=;
        b=wRaP/OfdV2Qs/YInYlD4wvepIxOyAbtJECikhj1pbkpyQh2hAIEBGwex/1aBBD1Abc
         5GILzL1R2oDGLQ0jDWoXP3N6kedVOSOGA2ELNpREAZZdqxHaDfWilWPD6EF0DV+9WkQ0
         gwbtgtDlWMScs6cqTBH8GtlVedW2Mm5i78ZorXvvbW44fblNd4pc7KjaREFpSsA1EwNz
         nxH6jx3Yp1hHuO+e/GvetC1XGpS2LHwnOit0JfCJKIDFcos2S8Mq2jDObpmBQp1zKX/y
         aYr0rNluMG/ILJ51n5YBArncQtvTXhz34iuvS4Bedh2/RFFHkLZEnUB5nVM85gAxnbgR
         tDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757606913; x=1758211713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrHTwyWRmcCmqZ+ZvtvvUN7JeKm53BmHzdcNZQjwcwU=;
        b=DBNb8g6o8Ugcxhmjhhj73hBWh5LxdiUrUhgylFO35NNoZuK07HoklYtZPR5hTntvOf
         8nmgxlBIXmlzpJDh/Vg00lI5u777K1MY78gh7B1+cLREzaLKI0vyWHKTd4hnQuaIE/DL
         hmF3BSvvTSwfQfBQDs08OJq0VWHdyh3AOumYdFgEXAFHvSBT9IIikRePm7yej1//OVYd
         Qf76VWX2cz/d4Bq6GzgkbukvetwozB9CMbl63XkG1gEf8BEmkm8QS3Mhz21x0EJ2sl90
         luZAU8xS7NW2zo02eBeEIAQJg7shQ8o4Ot1xOQOZWS49/eMxkPpCAs5sitimF0UmmzUV
         vNFg==
X-Forwarded-Encrypted: i=1; AJvYcCX6aoOnJQV4QjFJ2tbEJGOZJhtb0nMLnaGwbm8qneRSXf8PmQEWHL/4q6J9MOvtJmk2nxaRLb0IdmvdOrjHIqgi@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUlSANUV+CQUg0tgRAC0NDp3mr9bEEHZSauvei++HQdgihDJm
	BFLBEeVeTx0I6v+ncg80CukaKHSfS7C4W8OBJmBzRYXanAnThmeoo0sHxyPc9QEJTC4=
X-Gm-Gg: ASbGnctRmapXY2e8IpY5rCgKB/aIyP5rPlzz9JNX46f77q94su9nyV/7BPqUPuSK2KE
	wMF0EVJCEqa/7U+C6iYqCnbkMQ8Nwhclb+51QGDOTZbMa9gGc/xgCbGUfUBHHF5mXxFi0y4/SxD
	69E+jUp2dhX/o65LcMrA2f3NN2tghRw2AkLDPqk/IX+YJUZvBgAM3GOxDFV1GuybUA3fde2QGm6
	87mACFAH8gtgb7H3TGNLYKx5YRT+H7err8vEBt/cRgBVzM6cN4emoBKaZ0BNf6IVS6SQmGr70bg
	kYFJPhJb3UIiIBKJ/WmQW9cbM3IOf0ULWSteQ5/NDmJH3OVWoO4pdcBikvWOKAROf6uP3mqirbT
	/Z4PJgkPP2oS3qdooNI9iJv4W9SPJ0aSXe4uF02vH8jOiySb4
X-Google-Smtp-Source: AGHT+IExjhwjUgqrY49LySsRqAJm8YC5ZRKGtAm/z9Pw2/iVB4FhrUIv+Mv6vy9Kr6j7/votc74ImA==
X-Received: by 2002:a05:600c:1c9a:b0:45b:9c93:d21d with SMTP id 5b1f17b1804b1-45f211c9bcbmr384085e9.8.1757606912643;
        Thu, 11 Sep 2025 09:08:32 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c4490sm28511385e9.19.2025.09.11.09.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 09:08:32 -0700 (PDT)
Message-ID: <4d645f83-0ec1-4b31-81dc-431b6c6f205f@linaro.org>
Date: Thu, 11 Sep 2025 17:08:31 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] perf arm_spe: Improve CPU number retrieving in
 per-thread mode
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, German Gomez
 <german.gomez@arm.com>, Ali Saidi <alisaidi@amazon.com>
References: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-0-58e5677a412b@arm.com>
 <20250731-arm_spe_support_hitm_overhead_v1_public-v4-12-58e5677a412b@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250731-arm_spe_support_hitm_overhead_v1_public-v4-12-58e5677a412b@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/07/2025 2:25 pm, Leo Yan wrote:
> In per-thread mode on a homogeneous system, the current code simply
> picks the first metadata entry for data source parsing.
> 
> This change improves that by using the PMU type to find the matching PMU
> event. From there, it reads the CPU map and uses the first CPU ID to
> fetch the metadata.
> 
> Although this makes no difference when there's only one Arm SPE PMU, it
> helps for future support of multiple SPE events.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index db681dd2aed205655e77f3dfcd7eb3c33f20277a..2ac10b8008527a066c9b2f67a22eb8511af9239a 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -914,6 +914,9 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>   			      union perf_mem_data_src *data_src)
>   {
>   	struct arm_spe *spe = speq->spe;
> +	struct perf_cpu_map *cpus;
> +	struct perf_cpu perf_cpu;
> +	int16_t cpu_nr;
>   	u64 *metadata = NULL;
>   	u64 midr;
>   	unsigned int i;
> @@ -935,13 +938,21 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>   			if (!spe->is_homogeneous)
>   				return false;
>   
> -			/* In homogeneous system, simply use CPU0's metadata */
> -			if (spe->metadata)
> -				metadata = spe->metadata[0];
> +			cpus = perf_pmus__find_by_type(spe->pmu_type)->cpus;

You can't run perf_pmus__find_by_type() at this point because we're 
decoding and might not even be running on the same system or even 
architecture.

If we've already determined that it's homogeneous I don't think this is 
much of an improvement anwyay. Looks like handling multiple SPE 
instances needs a lot more work than this. We should skip doing it in 
this patchset and do it properly on its own later.

> +			if (!cpus)
> +				return false;
> +
> +			/* In a homogeneous system, fetch the first CPU in the map. */
> +			perf_cpu = perf_cpu_map__cpu(cpus, 0);
> +			if (perf_cpu.cpu == -1)
> +				return false;
> +
> +			cpu_nr = perf_cpu.cpu;
>   		} else {
> -			metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
> +			cpu_nr = speq->cpu;
>   		}
>   
> +		metadata = arm_spe__get_metadata_by_cpu(spe, cpu_nr);
>   		if (!metadata)
>   			return false;
>   
> 

