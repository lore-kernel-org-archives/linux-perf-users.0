Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1AB2E03EC
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579212; cv=none; b=jJ1Kqdr3WiFDpUBjQwONWPNjrWyO5V95MKJw9KsmaYBUJhtFinexpaHlYlnTUmmry4vDmgXEbzBkUOVEfB89IRSEmC3t5ijA4w6eqF6SRtNiOnC9Ov6get9hnHc2cvh+sbGzjgWyVBIogA6Y5fui8JZ9O6fFrqFox6zDHn9ZExw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579212; c=relaxed/simple;
	bh=DKTBpuEONVJR70U9ttKIpABJQPw9PwFQNxY5yDfots8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V7+krXuduj1dboRFtxgnaxa2VSeVfBZ/6rRI5kd8wai0cVx2lxKoES55h+Jf5qLJbQnFrhBsAs6MRHH4Ril0Zi6b6VV8TXGerjmG+TSs0fBLisZKnVG4wvidseu5sr94ZNCAf+3UaM0jld6aADWomVgoz7yvTk7R+cj4aCCiWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZhHfrSZr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZhHfrSZr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so2974655e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 11 Sep 2025 01:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757579209; x=1758184009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QmswRsDV85LAGSgZM1TnGtsRJLjTs07m6UjoRfbX1i8=;
        b=ZhHfrSZrU9rxPAR/2seHDjO/jneCvPL/eItUmibDvM41muqCVCSGbnoamC9QNot1lv
         30kxWfCZbjCE2LiFblOga0gDqVIf0c3NDenoEY6SXEiHSQP8+JcQAOKfy6jqqt48w/J9
         qETttRW2H6LJBhQB7PLOeO7zMvNDTyK7mdDVaFFfMs/Xb7y47mi0pNhx/59+Eo2bcUxd
         Wq5zalP8LAxhFvNf4elVCZUTw7hORTygV0GhCcqNJwYe4Ex83TVtKCKAlJ7ssOrIe2ob
         iV6JaG24fIp8wyFpiW9ClHjeMQTIHRJ+lH3bjgn9rdcsq2Yyo6C+kZhPGNLbmh2P+jvb
         BANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757579209; x=1758184009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QmswRsDV85LAGSgZM1TnGtsRJLjTs07m6UjoRfbX1i8=;
        b=MHEKWgFa67zQ95En2Cyw8rIy4WfQQRRoRPI6yaSswQhRTA9NC4wCS6/DdNAbiRDv5y
         +yrKsi9z4O/hgInLeroD6BvLIlxEJwamxAtJ9+cOlwAYiwatHNR3ZZwOP8wbbH5fwi8p
         5mYuJz1p0w0B12VeV4etBhLqI+XBQFkjtl4dqAwgIDAlFqLfEWAnkRVmAAWjPuZVa0dt
         36znu9a4hRmc1jjOse4qkOcEwoInKpahleCMbavNOrvTeQGnfhuHmKh4n0nvBjkwD5eG
         Qfpu3UC8cw5EJKlcthsPY6dzeuw0uD2CsU4/cZr0pktcuhlmISz2bX6Y7MbS+HJPWOYM
         nkwA==
X-Forwarded-Encrypted: i=1; AJvYcCU95rDq0jNqPYQ+G+iZKO8OvSljzhUzqpesZw68/QD2Fb/XCcoM7Zc/XyqyLO5FXvFT/OJpHck24Tp8g75k3+2l@vger.kernel.org
X-Gm-Message-State: AOJu0YxkYZGxpQG4GjabbfXUUFIaHYGWq2VgzEIRzhRkBA3M5GI6/kGg
	s1GGPzKq3waJb4aJnnDaCOK7W19mXyn1Jtaqw/z6HfMBSoWhmIZilHT2K2e8xk0nvwk=
X-Gm-Gg: ASbGncuGGerYJzb7oISCcun+GD7qbHqajg25ycDOLpdJ9u6Uq6K+SE12RHSZIDMLTPR
	pnTHg9T6oHIklFrU/aXyUpFSdFrXVEIwYuWbQlWOj/Shf2Z9BHMy0usE16aaRBZKtfAzrvRBZ6p
	x+i3moW9s6qEZ38YPbDauJ5wKnZsS3ZdtKcGrvsM7Ozh91GgeHJRbjrMX/Bp3S/JUptLzCEhDIK
	C1iWjs/ulv+iQWh+EbnPPiIM4PRlYuXn8dbjUK7sfhDoM2pgY7oO4S5i7BXM/GFwDIbZUyUb41Q
	4ijL9UtwFo1geunmUU4mUHG8COwozcwD5fmqa9liQ5EsjJRWshe4KKfLgI/pi2SkBnyJBr5Fr/z
	FW9zqiQKwzEmcgRsR+T03k9Yx66Y=
X-Google-Smtp-Source: AGHT+IE7R9n09fdDc3gxKWMG8ZdQt1MVhy5CILGt7inGxYTFXeK21MqYcM9OgweBeDIjjRUpvgvRaA==
X-Received: by 2002:a05:600c:870f:b0:45b:8453:d7e with SMTP id 5b1f17b1804b1-45de072e865mr174352905e9.6.1757579208672;
        Thu, 11 Sep 2025 01:26:48 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ce5sm13955765e9.16.2025.09.11.01.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 01:26:48 -0700 (PDT)
Message-ID: <fc2ee38c-b163-4b7e-9ba2-c2b93d0fc691@linaro.org>
Date: Thu, 11 Sep 2025 09:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] perf vendor events arm64 AmpereOne: Fix typos in
 metrics' descriptions
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
 "Liang, Kan" <kan.liang@linux.intel.com>
References: <20250910195214.50814-1-ilkka@os.amperecomputing.com>
 <20250910195214.50814-3-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250910195214.50814-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/09/2025 8:52 pm, Ilkka Koskinen wrote:
> While fixing a typo in "l1d_cache_access_prefetches" in AmpereOneX,
> a few other typos were found in metrics' descriptions too. While AmpereOne
> doesn't have the metric, it did have the typos in the descriptions.
> 
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../pmu-events/arch/arm64/ampere/ampereone/metrics.json   | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> index afcdad58ef89..324104438e78 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> @@ -113,7 +113,7 @@
>       {
>   	"MetricName": "load_store_spec_rate",
>   	"MetricExpr": "((LDST_SPEC / INST_SPEC) * 100)",
> -	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
> +	"BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "1percent of operations"
>       },
> @@ -132,7 +132,7 @@
>       {
>   	"MetricName": "pc_write_spec_rate",
>   	"MetricExpr": "((PC_WRITE_SPEC / INST_SPEC) * 100)",
> -	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
> +	"BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "1percent of operations"
>       },
> @@ -195,14 +195,14 @@
>       {
>   	"MetricName": "stall_frontend_cache_rate",
>   	"MetricExpr": "((STALL_FRONTEND_CACHE / CPU_CYCLES) * 100)",
> -	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
> +	"BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
>   	"MetricGroup": "Stall",
>           "ScaleUnit": "1percent of cycles"
>       },
>       {
>   	"MetricName": "stall_frontend_tlb_rate",
>   	"MetricExpr": "((STALL_FRONTEND_TLB / CPU_CYCLES) * 100)",
> -	"BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
> +	"BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
>   	"MetricGroup": "Stall",
>           "ScaleUnit": "1percent of cycles"
>       },

Reviewed-by: James Clark <james.clark@linaro.org>

