Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9411712
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 15:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347981; cv=none; b=c2Eu+VIBI2IlP8HFky49Z0KmFC6lJ1vYFaVImZgf7WVST9yZo9bE88CS1zT7xqy4n0ZifeVLtELDUIL1C1YoQlhTGq2YCu07Fyha0oNxvRQHOsdQVL+ilj8dgzSQTnPuBm+W5NTPTSbm8qmBy1qYYFl4nj1re3Fa3AoCXUzGah0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347981; c=relaxed/simple;
	bh=K2tTNsDAFnjRmB5hwiWA2XdJGz3dqint4tE3NfG5jHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BU6F3voH/dtssr9I8HVh6YXP1XgdfJIMuyzEKlgPFsM5MoWmBLwvE3vENi5L+rj70qqinWPtQnPjtxNW+I2yHGmX2M+UpFGrr65rcsNko4CS1cLYuo4EnT34vhCeHChh7Juum2piXwUWSdg4z4bOcVWYmsX21g7Rk3NSr2ePfZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IT+ABTs2; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IT+ABTs2"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a51481a598so556423f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 08:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750347978; x=1750952778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=twM7ghcw6YchvkMFUkyO21QRS89zzLFjkjMUnOcDIKE=;
        b=IT+ABTs29Ej81UvlAcPp0oWYA6UruEsb6KLft4GHbkPqstIiVbal1Fd7Xb6ORM9gDu
         x9bQQYT9JiU1pgX6Y0GVWLL6dGYhZp2TB0A1oYtZAb1Chnf1xVKlyG+z0LbJM1M3lKAu
         7/9Nx1FMVu4vsatS9+Ns7EVWultZq8OHHKrF2QBefhSfzA0IQQBIwShOVlTwGhDNag/Y
         hkXdqIVQbGzBGsmLWPs2MwhvGu6Mc+9cb8FdT4r/nvRnglhm3TR5yn5S5P2zyuJkm69o
         UCDoc6TkJHcLq/t2GooxfeimBQwJsvd0zX92ESiPQ17LtOYzkXHFKgEfUSO/meHzWBZs
         iXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750347978; x=1750952778;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=twM7ghcw6YchvkMFUkyO21QRS89zzLFjkjMUnOcDIKE=;
        b=BJaDAyTT7MzVTa82Q7VuwFQlcHdFEh/byxk56j9Sta5+24ThJgs8ccpF+9tFlyZHyq
         Tob4wwKKCwOsp9U8s20AwCijwjTKM6EsbCB4B6ZlUAfrMNPGiKHk+U4wkK2+k5qnqxvF
         044EehtJlL/rPSotzpLRw64kiOso0ZVtd+v8I3x82B4Q1xdvl0bJFr12KvXyOFy9hrOQ
         TnFzriuPjJOsrD+A3BBdoAaQWIbOS8mfMbL0Ub2MsA86k7MHrF8VOCxfU7IDiwQg2v8z
         Mcu1g7ZRDDM4L2u9Vj27Yeq68S5aOuMuSZfsOXHnETyZXly6rTrMU+w5qLtSaAis1gH3
         Jv9A==
X-Forwarded-Encrypted: i=1; AJvYcCVi57/Agw6AZi3uP1Rs/5n9qXOreDCmK/ePFNw1skmzVXZqX/ChkoLxRl+LEz12ObXwf20CCb4vfKRMPJxxI/Ga@vger.kernel.org
X-Gm-Message-State: AOJu0YwQMivJknA6BD5ZcfCrpmtBF+G95h+Ki+2E0YJagH9vnc7YFJ7d
	CSM/D2/z/3SfsqSU8iQWPuVWZckL78WD12RldMXC6FonHOEvambDq9bQgPD2TbIJ1so=
X-Gm-Gg: ASbGnctw/zDsMFSVrb5FBCm0P4RVreC70sE9pwC6i25dJPAK3FaoUV2Uy4Eg8+ZVRc/
	KtTqZVDUz7jrvNwV7pRfQn0FR4EZWABIecbkfk5ZTzz3CZNcQe0bqOHwFRN6xGc1kWjwnVdiPfQ
	597WKPLhDSh/iYWztENJIh/sM6RZ2UP2yP9YT9FjhHpTQMOolOM/avL+RgqcPQcQe3T4hQX2l7V
	y//5f2f9aXNg5L6hk/gb7W4N+Kioey/2it0MjaFZ8RtnJJaczi/RjTIjccCHBvUFpQm+Tcypd/r
	tgmmim8fc0FnN4XNR0zOisVIsViYV50SPjvMkRVT8sinRTX5oj9zc6qSK/Uw0FDkXGA=
X-Google-Smtp-Source: AGHT+IGk+fSWw92c++bpc7i/Gr3gKNqNYiyBN3xJ51nLOgbmRzfZpzuDswRZUzq8qOvuayUU7X849g==
X-Received: by 2002:a05:6000:2c13:b0:3a4:dd16:a26d with SMTP id ffacd0b85a97d-3a5723a56e7mr19198135f8f.38.1750347978077;
        Thu, 19 Jun 2025 08:46:18 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a54d1fsm19577766f8f.2.2025.06.19.08.46.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 08:46:17 -0700 (PDT)
Message-ID: <86dbeae7-7219-4c6d-9ef9-38838bd088ce@linaro.org>
Date: Thu, 19 Jun 2025 16:46:16 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/12] perf arm_spe: Add "events" entry in meta data
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-6-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-6-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Add a new "events" entry in the meta data and dump it in raw data mode.
> 
> After:
> 
>    # perf script -D
>    ...
> 
>    0 0 0x470 [0x1f0]: PERF_RECORD_AUXTRACE_INFO type: 4
>      Header version     :2
>      Header size        :4
>      PMU type v2        :11
>      CPU number         :8
>        Magic            :0x1010101010101010
>        CPU #            :0
>        Num of params    :4
>        MIDR             :0x410fd0f0
>        PMU Type         :11
>        Min Interval     :256
>        Events           :0xffff000003fefffe
> 

Pending possibly renaming this field on patch 2

Reviewed-by: James Clark <james.clark@linaro.org>


>    ...
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/arch/arm64/util/arm-spe.c | 5 +++++
>   tools/perf/util/arm-spe.c            | 1 +
>   tools/perf/util/arm-spe.h            | 2 ++
>   3 files changed, 8 insertions(+)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 4f2833b62ff55f3fd1dff3f032d6e06528460939..5cce5f29d8c7936cc4f424a09d50536644c17be9 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -121,12 +121,17 @@ static int arm_spe_save_cpu_header(struct auxtrace_record *itr,
>   		/* No Arm SPE PMU is found */
>   		data[ARM_SPE_CPU_PMU_TYPE] = ULLONG_MAX;
>   		data[ARM_SPE_CAP_MIN_IVAL] = 0;
> +		data[ARM_SPE_CAP_EVENTS] = 0;
>   	} else {
>   		data[ARM_SPE_CPU_PMU_TYPE] = pmu->type;
>   
>   		if (perf_pmu__scan_file(pmu, "caps/min_interval", "%lu", &val) != 1)
>   			val = 0;
>   		data[ARM_SPE_CAP_MIN_IVAL] = val;
> +
> +		if (perf_pmu__scan_file(pmu, "caps/events", "%lu", &val) != 1)
> +			val = 0;
> +		data[ARM_SPE_CAP_EVENTS] = val;
>   	}
>   
>   	free(cpuid);
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index fdef6f743cf3c76b1dcdd57f5a2c297642fdd21a..55b8391990467c8b7818bb63de3545d94d021bb7 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -1532,6 +1532,7 @@ static const char * const metadata_per_cpu_fmts[] = {
>   	[ARM_SPE_CPU_MIDR]		= "    MIDR             :0x%"PRIx64"\n",
>   	[ARM_SPE_CPU_PMU_TYPE]		= "    PMU Type         :%"PRId64"\n",
>   	[ARM_SPE_CAP_MIN_IVAL]		= "    Min Interval     :%"PRId64"\n",
> +	[ARM_SPE_CAP_EVENTS]		= "    Events           :0x%"PRIx64"\n",
>   };
>   
>   static void arm_spe_print_info(struct arm_spe *spe, __u64 *arr)
> diff --git a/tools/perf/util/arm-spe.h b/tools/perf/util/arm-spe.h
> index 390679a4af2fb61419bc881b5dc43c01f1dd77d7..a47d3d8fc97e07d1bb41a6776133d0676c335613 100644
> --- a/tools/perf/util/arm-spe.h
> +++ b/tools/perf/util/arm-spe.h
> @@ -47,6 +47,8 @@ enum {
>   	ARM_SPE_CPU_PMU_TYPE,
>   	/* Minimal interval */
>   	ARM_SPE_CAP_MIN_IVAL,
> +	/* Supported events */
> +	ARM_SPE_CAP_EVENTS,
>   	ARM_SPE_CPU_PRIV_MAX,
>   };
>   
> 

