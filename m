Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE87333436D
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904888; cv=none; b=ZVnihFByqVfIwlrT6nz6KaQk7RBPCgP638uhNI4nkHoqv2PIkJ7410je15WE2zooQ7lNT2joVzstRyfiCpIWpHrFggfHNwMS2PR+Y0eLHlOlV5wNa+PGKRzc9EypGZLwCzgwtEHw2AlLLL4nYXoSELtcafcSO1wZG/3eTRKFa+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904888; c=relaxed/simple;
	bh=RxlkwJ3Ojt2di/C4sMLH7o3fnCk6IDvZ1msbl1LANHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUigpdKGOZD+HSOmZ/5lh9S4OpV/XPgrhmuHDQJNSniwXUhOazEsrEmp/FEV2ImoeJ6V5S4x0QnaNBct0xx2smT6wtvt5RrwjtVXOHQQeM+2/TiITwKpcNGe50abXuU8Zg1v5qCXo7J+58rZlMf9BDRQ+SZ4NO8bxmMJVW8BCsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YV9fPo2h; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV9fPo2h"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4298b49f103so829321f8f.2
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Oct 2025 03:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761904885; x=1762509685; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXkLRXL/09XSTQrXWbf80a0LR0KorpKiDD0bgtjB+w0=;
        b=YV9fPo2h3fbM/tKXpU2B05GgGTaHE1f9Cy0JtbhLQPI3iLcIti7wtdA3vpOVdh2JBx
         yclLSaGRiPcKPpyKa+yCoJk04n5aX7asY0MNea3NjJvYUBJ8nCx1UT6Hwh9zamW4A0/0
         9y5xbxzc2B7q9UwvQ/7C6Zs9u9sj1Pq68Do+yo2FEaC8UeSl/9OqoP/yeHW0UDPNtq9I
         2cCLElWRlc6WT3McHf/xcttvNs6hXzwa6Wu8wkKQ5T8nVDF0mawKGtbZcxqlEmMPVLZd
         j1lfq3h85Aw23c4zyK95dJZq5fwmXMt2FZx0FUHPfl2B3WaBsJ/SMbFp2lhMyzI3yfr3
         ZCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761904885; x=1762509685;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXkLRXL/09XSTQrXWbf80a0LR0KorpKiDD0bgtjB+w0=;
        b=mN/3lqh6LDSdSVutMbq3UBIY2jRtbCK/PnUNlcO6v8Wf+J1NMunqCXWz+pCGkbetBG
         hifI3+/8PTlozNhHx7QfZlPawR6JigaIOXepN3eOcR8yAJ7KmrnOvZdR+ZmwyzsW7zcS
         ec0gmLUEo66q53Q+scGHRR1JTKTbQWOMvnLm52DAApngYVpZ6+y+HQ/D49U3IYRh0a8y
         o1jeA51BUc2BhoMYTJpI5X34hcJWhKKp1Z3Kn+TrsZEUAIlb7ddG0szPrZGMxwoKOykY
         2N/wzIEA4iCgXDLW0Ogxdep73uePjO/b8nrSdCxssxF4Y4gWYG5S37wROgd0my/3fQKy
         e58g==
X-Forwarded-Encrypted: i=1; AJvYcCWbTjoNShMZ0p5dcT7/yt3jZkh99KmAA5bY+9ev+6JlzOd/MGgESdP08yPGiWHoI3foOZTBX1ldmRa3dw/niGa4@vger.kernel.org
X-Gm-Message-State: AOJu0YwfJSqcfstRy1hZNBAIvsMuTayq0U5DepC22XQl5gI/5q3ZNk7F
	aIRApLMLcw1WSt2TqI6ebta40uFEc+Bs0UGVlEvxcFkxAPlfEO2viMFoLnc5ZeBc3YI=
X-Gm-Gg: ASbGncum+Evv7gSJrIoZRDQ06H4LbKGs3CziTKZ96Vvz5cW8LmsaQvotoOpHURRtxZG
	NViF+MfVbqjyhd0VJmJj/n4q7h3jiAkuiar4TMFfOFLPxFBCLSUuKJh9yCH2NBUs7snK0zt/hfz
	T3EyCDLuTYtMhZazFjTdwj9yx1Eh3E4QINAtQyMAm9fZmCYOrhLLnyoeaZTE4+294iD3rJYLAPW
	jeofufOYbvrhpSDfTPrSKJ/zxap3gdb+5WLrVzkYMJDGNX71AM+Wk1YGAwMHbPuD2la/oCdNtMf
	YxlPS3dxoexTsQFsXiBq7oNmsHpPOg045jJIoAyroNCFJsxmjq/qBOABKx27TkXm1tbaMII+5EX
	svzVQeIwMlKhXL6lyP0ukuF7wtZKRVI0a3RXRL4Fux0X9HdV1Taq7MJEyjV6cgHxCU/DIKvfS7L
	W0tLL0YQ==
X-Google-Smtp-Source: AGHT+IHILJYq01/jPqFwMyYGkOIuHAOSQvgFVwRuLZ95ODjEyBBLX/lDvwSOY0yg1h/riowuUMPwIg==
X-Received: by 2002:a05:6000:471c:b0:429:c4ce:eeaa with SMTP id ffacd0b85a97d-429c4ceefd6mr167558f8f.60.1761904885065;
        Fri, 31 Oct 2025 03:01:25 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13e1d8bsm2600821f8f.25.2025.10.31.03.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 03:01:24 -0700 (PDT)
Message-ID: <7fbec952-dfbc-4d6d-a6af-819ec9c81dd5@linaro.org>
Date: Fri, 31 Oct 2025 10:01:23 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/perf: Fix spelling typo in tools/perf
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, john.g.garry@oracle.com, will@kernel.org,
 mike.leach@linaro.org, leo.yan@linux.dev, peterz@infradead.org,
 mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com
References: <20251031025810.1939-1-chuguangqing@inspur.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251031025810.1939-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 31/10/2025 2:58 am, Chu Guangqing wrote:
> The json file incorrectly used "acceses" instead of "accesses".
> 
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   .../arch/arm64/ampere/ampereonex/metrics.json    | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> index 6817cac149e0..a29aadc9b2e3 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> @@ -388,55 +388,55 @@
>           "MetricExpr": "L1D_CACHE_RW / L1D_CACHE",
>           "BriefDescription": "L1D cache access - demand",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_access_prefetches",
>           "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
>           "BriefDescription": "L1D cache access - prefetch",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_demand_misses",
>           "MetricExpr": "L1D_CACHE_REFILL_RW / L1D_CACHE",
>           "BriefDescription": "L1D cache demand misses",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_demand_misses_read",
>           "MetricExpr": "L1D_CACHE_REFILL_RD / L1D_CACHE",
>           "BriefDescription": "L1D cache demand misses - read",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_demand_misses_write",
>           "MetricExpr": "L1D_CACHE_REFILL_WR / L1D_CACHE",
>           "BriefDescription": "L1D cache demand misses - write",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "l1d_cache_prefetch_misses",
>           "MetricExpr": "L1D_CACHE_REFILL_PRFM / L1D_CACHE",
>           "BriefDescription": "L1D cache prefetch misses",
>           "MetricGroup": "Cache",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "ase_scalar_mix",
>           "MetricExpr": "ASE_SCALAR_SPEC / OP_SPEC",
>           "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) scalar operations",
>           "MetricGroup": "Instructions",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       },
>       {
>           "MetricName": "ase_vector_mix",
>           "MetricExpr": "ASE_VECTOR_SPEC / OP_SPEC",
>           "BriefDescription": "Proportion of advanced SIMD data processing operations (excluding DP_SPEC/LD_SPEC) vector operations",
>           "MetricGroup": "Instructions",
> -        "ScaleUnit": "100percent of cache acceses"
> +        "ScaleUnit": "100percent of cache accesses"
>       }
>   ]

