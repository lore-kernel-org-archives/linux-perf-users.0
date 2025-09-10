Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF182D77E6
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 09:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757495276; cv=none; b=ozClHUckss4eySscv5btaAIjoSSp1uZ/R5spnQ/uZ8etpSy26PGV94OY8wTUVevcseaCxGvSfJhytcwhZzfnFF8QRI5gFPXbBPrULPyMCvxQx3iewPbitvqp2OWt0dX24lHoL7U7SDcevmiYoEN4TQ8ZHRw+U9RJnwzeL6Cc3LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757495276; c=relaxed/simple;
	bh=/KqdALodTvjwyORqZoZyMhakuzS/aLa1iSvmfExarKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oCbe8h1TXEN+NSH7RuXrCe9ghAiLwOwB8rrq+MICVNvFtH8Vnb9KfvhN9CfR/7PT2oNP7dJ9dSis63ChbqEOOGdbLFLmR/nj2zsUu66BKiZV1TqQCXYZUk2oFsMoSSYfHyHHqL2Ox7AKANhRj+xdjPU0Tqu/zoT/XUKHh9+raiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBILnl95; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBILnl95"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dde353b47so19180335e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Sep 2025 02:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757495272; x=1758100072; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZBBmutpjOIPvfZmjaAjseI7obq3YWyXTkmlz+MKTww=;
        b=EBILnl95nPIYk/viFeNuqWCIgBxqGpZtgcRojsOwJrvGc3upeDovdzZEaGUp0c/88w
         aWUF8gsVSD3t5mxWajgF0NKbPRS1oysuzcwDHfEwr1IITURJ1gssjwRwR/o1nd9/KNa/
         HTV6N7i0WOv/4IHr6mcCk2Ewse1NYEcrRgXO4mhfvYwhipwjxsFsLGbdA2UdB1EXuY+X
         sSd96sY4hu/waa75DlbrARyM37QwOyZo2Sg8ENoowwAVLNqbybWwPRv6CfsXm8+jBIug
         Gbp4WcpgeFG3zpaBk/r9oSAlsLSd1d1n10Pf95Fqyo3pvLCGhPeNkoAbZKYC0xHPTjU+
         bYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757495272; x=1758100072;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZBBmutpjOIPvfZmjaAjseI7obq3YWyXTkmlz+MKTww=;
        b=hMVt/2fa/Vs7kZ3NBdM5Z/rzA6wimb77Kx4Iq0R/F1sY3Ut+JQmjUHke8NYlmEFLV3
         jDAIR+xWrGIL9aQDAnVvlqSMxRPumGYowej0lrvUqw+NEb2eJF8I/KVu6ywB8FQmMYmT
         4HkJLP8/XwBusBMa+psd8wZ8MMkFTkYB8uT+8UucpT1aUqoV6QIEnOMcqbg0A31y6v84
         m4bzCvI6RRmcrShqprpLrdq+2ytc0bD/tvbp6m6039A+7R7ItLwpJNyN95xawX9BV+91
         XqXk6Xie4qOgrptOz5rrtZex98zisC3sWpTv9Nrs2KltpwwsgTonIg6K2YTRz0Xbir3Q
         cZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxk2dHvrscRbo9nAzTUc7eDGb4+cw/Kk9bmoZ5SM00hD0kJul30eF22+PkTuTO3Gk7Mr6H8hIqFRaZFVpAF5Or@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGZ3gTDA5hhYIINbQQ0P4l6lCy4K2W2cozVBc+OQ8n1SisFms
	rU+mGlDiHAS7rkOmj9vWmtOQZeZswYVZLnasGV254bYLR4pa7jpWAib9OvZA+JX6LCM=
X-Gm-Gg: ASbGncvrvviPKmOzdzCYs4tb2Eo4cjj7PAdEJGXNGz816DWRbemYofhN8u08mZhsF5a
	yrdnbgcEPkEeKO9SawYdvNoDbvPqjwpNRilZ+YIJYM5WSNoerv73I1pGNYrAlPf7DYzOX5FWXFD
	tjaaU9cZyA/MLPigNnicfka2Xx8+MUNK66BJDEGqbDaZ2DDc4y8zyu251v72Re0tCH0TMKb7onq
	p19aJeRpb8zTAeZqyrAbtu+NdIXt6+TL5umKF6mfNq2gY0a0iVXtBkyQ2DeAwyXvSu4i7MADXyl
	0wl7AFQF+jU50zagoLdY8ZvO9RVt611n4VXrDr9OFpi1A4S0/k1Mty6r1eMWY43l0v2GYhJ1D2h
	hzvF3G0DbE97YLkzsl8E2gzCf0I6p4lp7iXZ4eA==
X-Google-Smtp-Source: AGHT+IEG71ndzP2J+YPiEtMfuV9I+O4GNXaDUWAmn6I8ie847qJ1Bh8O6y5TTlHM2Sn0Ba4AliZgNw==
X-Received: by 2002:a05:600c:a05:b0:45d:d5c6:97b4 with SMTP id 5b1f17b1804b1-45ded2fb475mr47976605e9.9.1757495272369;
        Wed, 10 Sep 2025 02:07:52 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9caasm6457092f8f.19.2025.09.10.02.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 02:07:51 -0700 (PDT)
Message-ID: <6a24df18-832c-41b8-8226-5dc5b3c9995d@linaro.org>
Date: Wed, 10 Sep 2025 10:07:50 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64 AmpereOneX: Fix typo - should be
 l1d_cache_access_prefetches
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
References: <20250909210120.9823-1-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250909210120.9823-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 09/09/2025 10:01 pm, Ilkka Koskinen wrote:
> Add missing 'h' to l1d_cache_access_prefetces
> 
> Also fix a couple of typos and use consistent term in brief descriptions
> 
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----

The same typos are in arch/arm64/ampere/ampereone/metrics.json as well.

Reviewed-by: James Clark <james.clark@linaro.org>

>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> index 5228f94a793f..6817cac149e0 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> @@ -113,7 +113,7 @@
>       {
>           "MetricName": "load_store_spec_rate",
>           "MetricExpr": "LDST_SPEC / INST_SPEC",
> -        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speclatively executed",
> +        "BriefDescription": "The rate of load or store instructions speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "100percent of operations"
>       },
> @@ -132,7 +132,7 @@
>       {
>           "MetricName": "pc_write_spec_rate",
>           "MetricExpr": "PC_WRITE_SPEC / INST_SPEC",
> -        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speclatively executed",
> +        "BriefDescription": "The rate of software change of the PC speculatively executed to overall instructions speculatively executed",
>           "MetricGroup": "Operation_Mix",
>           "ScaleUnit": "100percent of operations"
>       },
> @@ -195,14 +195,14 @@
>       {
>           "MetricName": "stall_frontend_cache_rate",
>           "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
> -        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and cache miss",
> +        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and cache miss",
>           "MetricGroup": "Stall",
>           "ScaleUnit": "100percent of cycles"
>       },
>       {
>           "MetricName": "stall_frontend_tlb_rate",
>           "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
> -        "BriefDescription": "Proportion of cycles stalled and no ops delivered from frontend and TLB miss",
> +        "BriefDescription": "Proportion of cycles stalled and no operations delivered from frontend and TLB miss",
>           "MetricGroup": "Stall",
>           "ScaleUnit": "100percent of cycles"
>       },
> @@ -391,7 +391,7 @@
>           "ScaleUnit": "100percent of cache acceses"
>       },
>       {
> -        "MetricName": "l1d_cache_access_prefetces",
> +        "MetricName": "l1d_cache_access_prefetches",
>           "MetricExpr": "L1D_CACHE_PRFM / L1D_CACHE",
>           "BriefDescription": "L1D cache access - prefetch",
>           "MetricGroup": "Cache",

