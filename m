Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E82264A6E
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750416345; cv=none; b=cyrwDenKN2OO3JjhRlXV/nNYkk3tCVHJOb2srQMnzV/DtiS4E4gwa6MIbuzT4+Oatoq1x0XYiarP5bEbCLt3eGoLuN+WrlPSl4qpV0olKlL5bW060adp9bSZaqzAxw3WC91/0EL3fRW2nBLYmluKgaA42r+SPKAou5Npb/EaOOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750416345; c=relaxed/simple;
	bh=UgsBZT9kjcsGbt8VBofMUf6V+l1phuWkwbxJLElvWZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DE0d0ytP3CAC4NhrJ1CQoxf+dqO/AoWUXb66uN4Mp3mEGXSiB6j7+05vdf85+TA0goCtY2SgkEfh4NkPCa5IEtQ3coW1FxJ3BwT+pfjIG4gImBkQpugxCQ+vxY7sCGLYlZ8beC1ksUkw0knZEFD+EIgNqdzCyI+ca3n/NHpiOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jFaOFDMQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jFaOFDMQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a510432236so1321956f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Jun 2025 03:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750416341; x=1751021141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SKBMUgxG1IH2cC43C7CQlxG9+juo4HBXbKwgJd/KfcY=;
        b=jFaOFDMQLt+1vF1rzp8Kq7x0GHL4Yc5xNO8ceCINNNffX6JZPuPFgT58iFCvDS0c0P
         TK4GdPze2rnmcB/AzOGzWgDofcCaahVXyVVoOF0SDZi22ukfOfEhK9+veUsjGzYz+D4f
         rf9zdtD+7z/AMvE11pHMNA9mO874RVn6w7s1a2CWcP1BC80qwVzFpg0gWm/ihYwUA/A1
         jBHssuNnq0v0vCKzERPnd7lTNdbXVrmK4h5FtMXyM1ceh0pNo4jcusQKfHQ1ICHIYQzs
         ML0fPnSxC4Z8wzZyQk33wQnEOE10fA9N5juTMnYVyivmmv+mezU9m3Yy0vA2/y9MDFkd
         u/8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750416341; x=1751021141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKBMUgxG1IH2cC43C7CQlxG9+juo4HBXbKwgJd/KfcY=;
        b=M0CSCMV4rqfp8VVw147QCMzjAquClyzSUD/9PTi0xrNrx1+gZYh5/5F7K/sAeBQCMY
         hM/jzRoyq2pP4mpK50SfvC+ucp6S2QubAkPeN22n10VDEty9h/xKTJUEWr0kcDILIn/o
         z0RFw1J11en0JpUmuY40dd5PqHpZNW/HKPNzr3R5ZTl8P5mYnnsJH4a26ZO+xxZRMlxR
         czCHZRKnmj0C8CgKZZ8KmFQOPokn/7A9rM7WyWM/nGWfTLDfFlobZKFuNig6WAxxnNIE
         q6ZUiAOPpQ32FSsznXIOOeMes1au3A3j2wptNP6pmRRrUwKI7uZcgqS8+A88HPAaqdlI
         Vkcw==
X-Forwarded-Encrypted: i=1; AJvYcCWdNWfVQWo5ivNac/wr1IhzFCS2SSZywi6bCD8W8vYwJ34DOq9F68vawOCi9JMS7DErOdU29f31YKZtJxwN628A@vger.kernel.org
X-Gm-Message-State: AOJu0YzEN+gID4czWMV/DFt7A5D9xmGIxfxJQyEW7CRACj3QlbnqmG/i
	atCubHg+kyfZMhyjwgPNEdHg7tkDGCOx76L7cYbEHiUIvbkYrgqt4dltJbg3qfaMO9I=
X-Gm-Gg: ASbGnctuqbAU56BiUZ1c7ULC11U2qLljtLAsCDT24EE5kljq7lNEsjbyr1socXsmcFY
	ReqeG6bY/3pSnFHRHyBqgEhEwhNqJo1BNBBOWzcI+GBQdkU1ND2GiPw1ASsYEQAgQqWobCn6dI/
	WObcvQManhWaKDLaU3NsZ1Z2rFnr1e30P21SzcQCFGiUGhyFgrDYft10ahwlOK8DOGgsgHzBjdl
	dnuHlOCyc4TjNm847zpwvgvQHkHVNA9HPVHhgNPv2R7rjYx0TQSr1omOFEnl3aba9kF+/c8YroX
	U0RLrGQ4utxoFYRmGtkclyJkYMU/ONln0Dp75vLfQLZB79xIwTFeK9BzqofO/gwk7jA=
X-Google-Smtp-Source: AGHT+IGY+SB4ZBG7c1vRa8LWTNDxjzu/yUDXbu3C2egw8C1VI0GTMDtixMHZ8nT+Uycz7iEtBensWg==
X-Received: by 2002:a05:6000:288d:b0:3a5:8905:2dd9 with SMTP id ffacd0b85a97d-3a6d1331316mr1932398f8f.51.1750416341422;
        Fri, 20 Jun 2025 03:45:41 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6d118a1f2sm1660123f8f.83.2025.06.20.03.45.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jun 2025 03:45:41 -0700 (PDT)
Message-ID: <f5f70b05-dd8b-4e46-a6ee-e2710a9cf1ee@linaro.org>
Date: Fri, 20 Jun 2025 11:45:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/12] perf arm_spe: Refactor
 arm_spe__get_metadata_by_cpu()
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
 <20250613-arm_spe_support_hitm_overhead_v1_public-v1-10-6faecf0a8775@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250613-arm_spe_support_hitm_overhead_v1_public-v1-10-6faecf0a8775@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/06/2025 4:53 pm, Leo Yan wrote:
> Handle "CPU=-1" (per-thread mode) in the arm_spe__get_metadata_by_cpu()
> function. As a result, the function is more general and will be invoked
> by a sequential change.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/arm-spe.c | 30 ++++++++++++++----------------
>   1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 2ab38d21d52f73617451a6a79f9d5ae931a34f49..8e93b0d151a98714d0c5e5f6ceec386a2aa63ad0 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -324,6 +324,19 @@ static u64 *arm_spe__get_metadata_by_cpu(struct arm_spe *spe, u64 cpu)
>   	if (!spe->metadata)
>   		return NULL;
>   
> +	/* CPU ID is -1 for per-thread mode */
> +	if (cpu < 0) {
> +		/*
> +		 * On the heterogeneous system, due to CPU ID is -1,
> +		 * cannot confirm the meta data.
> +		 */
> +		if (!spe->is_homogeneous)
> +			return NULL;
> +
> +		/* In homogeneous system, simply use CPU0's metadata */
> +		return spe->metadata[0];
> +	}
> +
>   	for (i = 0; i < spe->metadata_nr_cpu; i++)
>   		if (spe->metadata[i][ARM_SPE_CPU] == cpu)
>   			return spe->metadata[i];
> @@ -924,22 +937,7 @@ static bool arm_spe__synth_ds(struct arm_spe_queue *speq,
>   		cpuid = perf_env__cpuid(spe->session->evlist->env);
>   		midr = strtol(cpuid, NULL, 16);
>   	} else {
> -		/* CPU ID is -1 for per-thread mode */
> -		if (speq->cpu < 0) {
> -			/*
> -			 * On the heterogeneous system, due to CPU ID is -1,
> -			 * cannot confirm the data source packet is supported.
> -			 */
> -			if (!spe->is_homogeneous)
> -				return false;
> -
> -			/* In homogeneous system, simply use CPU0's metadata */
> -			if (spe->metadata)
> -				metadata = spe->metadata[0];
> -		} else {
> -			metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
> -		}
> -
> +		metadata = arm_spe__get_metadata_by_cpu(spe, speq->cpu);
>   		if (!metadata)
>   			return false;
>   
> 

Reviewed-by: James Clark <james.clark@linaro.org>

