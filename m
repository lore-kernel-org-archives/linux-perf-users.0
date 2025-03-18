Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97835957
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 10:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742294832; cv=none; b=IUbWXI00sg0AHX5ST0L4Z9xXPe7WDZfEnlnQOmadmT16N3tcB6fad2rgoi/zIipddvrH2iuX9+sxjpqqAd8PRpyhk9u9WFhBxLWUSP5EZW9syaZgvT50WjWPEpfiBg5FpNArssPV3w4wGKt5LJvo0GWs2WhP4LrSdRj/e3i/9SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742294832; c=relaxed/simple;
	bh=Y34qxDTwNMg0m9MBtsSoqkiAcL4CddgiFLwuhpRSLZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lr4EGqrJt9osxy2FW1UXThiFCfP/wsjbu8eYdkUwv/co3oX5LZGxJ/Or8pygOpPnsSBZ9UKDWW5KM8oPboav5pupwPYLBao6C5om7ltTKt5qsrfizu3O8yrCDT2aXHoHLNNH3ug4Ax4zcRF6qcOFPA2oPTGu1657fwwCjZO8MAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QCBKcgP3; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QCBKcgP3"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-39130ee05b0so5323558f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 03:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742294824; x=1742899624; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wfB7k7gMEQrYDY7VtPxjD0ttrzFbn4Ekh8A5LusVLg=;
        b=QCBKcgP3h//TDCB8AcFEMwejhJ/kx5BpU1aKbmo1Xv23u7ms2l1buKTwYaXNwiqXrU
         6IWQa/7RAApEizxaokk6GNELjSF7QWKuADK1aG6FLQQXhlta3uvRRQXUtcAVqKn2uxio
         15b2pB7ahaoMx+TzVZEhFJf2Cm7scFO+F0QAFX7/EpW6fxPOiDuzyw5BPSuWTiUXN+g8
         3XbaxLHjZj2nvkwyDmeMWz98oHzh/Oj35tDfWBvqbk9JJtISbNQ8Tb04qzDq5gwuiXe3
         QfHz3CLi291khFmtMP63TRpWk2LYaTlu7VNn3RVaBV6xvYFGSrpGlPWQcVYyHr4uWwDY
         XWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742294824; x=1742899624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wfB7k7gMEQrYDY7VtPxjD0ttrzFbn4Ekh8A5LusVLg=;
        b=UecN1UIWN/icQS2mEgr1c6tk4vUZPsYYIV7oeA/XZrWwNgciv7Mxdw3DuI4WJIpmg8
         70XN02T5V/tQd/S+rDUmca3I4msvYd8fZIgbyXHGoDkSGhs2DttsPqg7qLJG/LRW87Pc
         fXa156CSqC3k+0Ilvd+/6Eclzkd3J0z2JPup4JLj+njcuhpyNP08KBwrtvM/u9HpfLnj
         /a6LtsnTIL47nbBn0f3UYvIo8yzocn6i3oPRSrOxwoK2yd14I7sIN7j1qVoosvfdeA3B
         AX8oewtIRFQPwri56h/mTJJstZKXYdxe6tIHoIljD7iS5XjVUG8/kTix38jCGHBuqhEq
         zY5g==
X-Forwarded-Encrypted: i=1; AJvYcCUMD1SKvpqGikAa//RdG+05v8W0o1Te5oFrnAdQJXvRu2nsGJ0wGyhP6eT9aiA03HDc7WnOBCBy5Ea5r11uukGL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhj/NTHZkaSd695TJhhM5ZiTgnWa06ptUNMuuLpwHLkowXtq4a
	n+EF+g/SwbMctknY4uLze111uhtlgECl5T6cczZhAHLvikIvNFqBIpIi1Tqibgo=
X-Gm-Gg: ASbGncsr/C7xwpwnWcqD+P/0jXE/vIR4AME/5vpxG4OI7bgIU8nXAL9enhCYCgnFvu3
	QChTC/1bHiQsyU2BC6pogg6J66DRkz9gaxECMtpPrnPBkVkmmk+zKeVnKXXH69eej5HuHb2g6Jo
	4cx3Lv3pzGBpc+miO1QEOHeGe0oj0VOZu1NMzPeFOW645kPXCrEjoucAeVH9kSJdEpWDO9TFzR1
	ABcHqisj4VfnrQweEUf1Iiw/+8wPZ8mzx3WhusmOWjwuZUwQZhi5EsGlMUELZGpAI95GNd5nhZx
	4+kuAf93wB7OG1/OaCltahM6LGdsbTsAGGwVlP4zGXJji3ntxyopzQ==
X-Google-Smtp-Source: AGHT+IG0L+hGt6w3IZk92zDd4DNaC/NC9eZTtg+wTxtfM4mV6V6YpzKmb5xSvPPVdoJTGLTCbNMaHQ==
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr14129706f8f.9.1742294824127;
        Tue, 18 Mar 2025 03:47:04 -0700 (PDT)
Received: from [192.168.1.247] ([145.224.67.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm17880141f8f.62.2025.03.18.03.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:47:03 -0700 (PDT)
Message-ID: <880bebc4-5a59-451e-beb2-60cee9a3efd5@linaro.org>
Date: Tue, 18 Mar 2025 10:47:02 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf vendor events arm64 AmpereOneX: Fix
 frontend_bound calculation
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>
References: <20250313201559.11332-1-ilkka@os.amperecomputing.com>
 <20250313201559.11332-3-ilkka@os.amperecomputing.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250313201559.11332-3-ilkka@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/03/2025 8:15 pm, Ilkka Koskinen wrote:
> frontend_bound metrics was miscalculated due to different scaling in
> a couple of metrics it depends on. Change the scaling to match with
> AmpereOne.
> 
> Fixes: 16438b652b46 ("perf vendor events arm64 AmpereOneX: Add core PMU events and metrics")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>   .../arch/arm64/ampere/ampereonex/metrics.json          | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> index c5d1d22bd034..5228f94a793f 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereonex/metrics.json
> @@ -229,19 +229,19 @@
>       },
>       {
>           "MetricName": "slots_lost_misspeculation_fraction",
> -        "MetricExpr": "(OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
> +        "MetricExpr": "100 * (OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #slots)",
>           "BriefDescription": "Fraction of slots lost due to misspeculation",
>           "DefaultMetricgroupName": "TopdownL1",
>           "MetricGroup": "Default;TopdownL1",
> -        "ScaleUnit": "100percent of slots"
> +        "ScaleUnit": "1percent of slots"
>       },
>       {
>           "MetricName": "retired_fraction",
> -        "MetricExpr": "OP_RETIRED / (CPU_CYCLES * #slots)",
> +        "MetricExpr": "100 * OP_RETIRED / (CPU_CYCLES * #slots)",
>           "BriefDescription": "Fraction of slots retiring, useful work",
>           "DefaultMetricgroupName": "TopdownL1",
>           "MetricGroup": "Default;TopdownL1",
> -        "ScaleUnit": "100percent of slots"
> +        "ScaleUnit": "1percent of slots"

I never considered that ScaleUnit could be an issue when the metric was 
included in other metrics with different scales. Seems like an easy trap.

Reviewed-by: James Clark <james.clark@linaro.org>

