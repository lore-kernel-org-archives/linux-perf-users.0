Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C32080D4
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 10:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443933; cv=none; b=aMRVMVmhrL3HvMolEvzOSu6in3NUXbY/mkx+zH/vmwMi9FK7eIFoTO1c2EXwe+g+NZ3qZmKrvkE9E+DS8lRMapXWDRvoCrS8HAMV77NgIiwj6Zetr0UCGgHc3dQ7TxF9Li2vPcnRQTbKb3GI2t3fvipfqL445o+mkzx65cLbECY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443933; c=relaxed/simple;
	bh=NNwffCnuthUEjMjoVnRCHsMOFoRrFLd5Mhj8Yauwhdg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qx6pH7Ko5udpVldVoOqkmxtWSDSm2kVobmRJvqCZEJhMWBuwVU8Ia8kCQw+39gv8K2wKVHJE8daEh6PLmFVnSkgECzsRE3g4UzoQMq0Y84F/GXn8PWPx7Vj17/x5+13dpVloU5l6xuVurWxO/y8U7NpJooKxGn763ho6j5VcZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ql+NBd07; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ql+NBd07"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso7749855e9.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739443929; x=1740048729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfW5BGT5pTjwhGTP5m8htmZ9lluyeh+guldKWayNHGg=;
        b=Ql+NBd07wdb2Wocy3/1v4nmddOreDXblFy8bt9LFQAgaMtumy9PoPw/TQO0gi0kXyZ
         WmpDSe3A7cmnbEuuZ2SoalS8Ec9vf2RntUiPDVpw+ihmlLuLmuwV+VCDRxYfhK6uTbu0
         ARS4ZVT6JxsvIRkQHSAfKurRgumkV5ppGtRN7kk7TXWYUhBGF7OEazHrR796YDpztpVf
         PR+j5EkjVgqYQj+/YdBC45JZypvPjnpfRfJT7DsliPsXiBguXbA998zaTJpBTSkltxeV
         GRvuAUZJmVvaDMbkR6bF/yCsBwxAvgF5zfSUHuQ6T87nHkiwrJuL46joem0tMS4tVVUh
         mgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443929; x=1740048729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfW5BGT5pTjwhGTP5m8htmZ9lluyeh+guldKWayNHGg=;
        b=ht2W767USw0pA1jPgh9I2kzJR8B5yDi7O5xGFGHA2u8HW8fsn4YxHtqF05B6S4E04q
         kmwsl5B03SUiXnvzo4IxSIvEsNFBDviIoLMr9p79ETbxjPNFUreK67QwyP7TquKMZqRq
         OEcwB7i8mrgGLvS5KpTbmf1kj5MpjNScnqKWEWghm8t3wGcSeJ007+X+fjfx9bl1uSc1
         //4G07UdgMXTRQI42bs55sVjgsLN7ZtuaNybeVGCx9khsK7RN0SeWZ7Ye/CGNCgCxaUM
         cZZkAR46551CHol/D3XQrZVFfL65j9GX7/sSa5SXjm659AVgDMpMFDYq372hNkXbgGFd
         b/BA==
X-Forwarded-Encrypted: i=1; AJvYcCWsZrqum3OcyXWsx23Fmmyz1GHHpnuUvsmc4InLmKbtWBDxBnQdAYREhPGUN8htJnN3mhyyKp7RTUg7GBbY1A3K@vger.kernel.org
X-Gm-Message-State: AOJu0Yzha8W2etAR8aQ1RB3SJNnBYPJTmH6dfaFELoCcWictTLyvUiA4
	ZTXl0MUz3caF8Gi9r5aMaFQY0H7ESx4vviLH3x10UtdGPchl7mIFdlJC+634OTs=
X-Gm-Gg: ASbGnct0jQk5sqbaKHNM2HA6JUP1l0stPk10PztE9EcT3866wk2VnrSxWdkN+gHgXJo
	EEmg+4IHPX8jdm07Djoql+CqP3yvz3SVMOp3N0znmIi3UuYULaD4MoWU4d3X5uiOm8ANHs7AU+/
	q2DNGOkwTs7xb0t9GsElLlrZU4WPFdK4S7vORWAms0TiepbejZ6FXuYuUsoGR2sMPM8/lvIYLrq
	ftkCtFZ26VBWZM5sRJhCjqrCGLWHDKFl6OlEEf6lKWuNfHR4CY8NVv3ln/uMMSR38aSJqp4PBNS
	cHpj+sqxobdmCvSbr5EyCO0ddw==
X-Google-Smtp-Source: AGHT+IE3cVCMFeTiplAdl6oIol2hwK+z0KRfMjE6tnhaJF9qrn7yWiTvmVjpIcI0wTDSh3lcSVhCfg==
X-Received: by 2002:a05:600c:19cf:b0:439:5573:9348 with SMTP id 5b1f17b1804b1-439581b88ccmr64782085e9.22.1739443929479;
        Thu, 13 Feb 2025 02:52:09 -0800 (PST)
Received: from [192.168.68.163] ([145.224.90.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439617ffa28sm13991045e9.14.2025.02.13.02.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 02:52:08 -0800 (PST)
Message-ID: <5f4e90f2-1956-4f12-b2f4-b355012beb6e@linaro.org>
Date: Thu, 13 Feb 2025 10:52:07 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf vendor events arm64: Fix incorrect CPU_CYCLE in
 metrics expr
To: Yangyu Chen <cyy@cyyself.name>, linux-perf-users@vger.kernel.org,
 irogers@google.com, namhyung@kernel.org
Cc: acme@kernel.org, adrian.hunter@intel.com,
 alexander.shishkin@linux.intel.com, fj3333bs@aa.jp.fujitsu.com,
 fj5100bi@fujitsu.com, john.g.garry@oracle.com, jolsa@kernel.org,
 kan.liang@linux.intel.com, leo.yan@linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, mike.leach@linaro.org, mingo@redhat.com,
 peterz@infradead.org, will@kernel.org
References: <tencent_D4ED18476ADCE818E31084C60E3E72C14907@qq.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <tencent_D4ED18476ADCE818E31084C60E3E72C14907@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 13/02/2025 8:44 am, Yangyu Chen wrote:
> Some existing metrics for Neoverse N3 and V3 expressions use CPU_CYCLE
> to represent the number of cycles, but this is incorrect. The correct
> event to use is CPU_CYCLES.
> 
> I encountered this issue while working on a patch to add pmu events for
> Cortex A720 and A520 by reusing the existing patch for Neoverse N3 and
> V3 by James Clark [1] and my check script [2] reported this issue.
> 
> [1] https://lore.kernel.org/lkml/20250122163504.2061472-1-james.clark@linaro.org/
> [2] https://github.com/cyyself/arm-pmu-check
> 
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>

Thanks for the fix. I'll report this issue on the source data.

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   .../perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json | 6 +++---
>   .../perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
> index 1f7c9536cb88..eb3a35f244e7 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n3/metrics.json
> @@ -169,7 +169,7 @@
>       },
>       {
>           "MetricName": "fp_ops_per_cycle",
> -        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE",
> +        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by any instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -383,7 +383,7 @@
>       },
>       {
>           "MetricName": "nonsve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by an instruction that is not an SVE instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -421,7 +421,7 @@
>       },
>       {
>           "MetricName": "sve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by SVE instructions. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
> index d022ae25c864..4a671f55eaf3 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-v3/metrics.json
> @@ -169,7 +169,7 @@
>       },
>       {
>           "MetricName": "fp_ops_per_cycle",
> -        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLE",
> +        "MetricExpr": "(FP_SCALE_OPS_SPEC + FP_FIXED_OPS_SPEC) / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by any instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -383,7 +383,7 @@
>       },
>       {
>           "MetricName": "nonsve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_FIXED_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by an instruction that is not an SVE instruction. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"
> @@ -421,7 +421,7 @@
>       },
>       {
>           "MetricName": "sve_fp_ops_per_cycle",
> -        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLE",
> +        "MetricExpr": "FP_SCALE_OPS_SPEC / CPU_CYCLES",
>           "BriefDescription": "This metric measures floating point operations per cycle in any precision performed by SVE instructions. Operations are counted by computation and by vector lanes, fused computations such as multiply-add count as twice per vector lane for example.",
>           "MetricGroup": "FP_Arithmetic_Intensity",
>           "ScaleUnit": "1operations per cycle"

