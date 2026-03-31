Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86413E0256
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950907; cv=none; b=HbAB5ROIavYIW5YFRH9vRLEsGwh3JYWbNEgR2BGtNdRpg/CTckUPh2k0+2gd0Di6Az5liHm8Dm67+Rf15vfQ4y3OubRvJBb/iEz1DPDx0GYnuWXSKzifjq+ws22CMQq0+kfbkZ/pDIDP+2ETW7JlSAMom6uVNP1pow+DImsUBi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950907; c=relaxed/simple;
	bh=1ShDOl4aohZX6Ilg9W+NEix5c26zPS53FKavDIRNnUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbdlhaU28IQsVnb10X0WTD6+56w/UWxfGB5NyQqJfZSPs6wRbEB+fDE8bWKsUF4PrV8f16qaKsiNf1TWP2LTep7pieyS7H7cWkcb8MbrTlZOAPxWnn6ybeUEqi8MAmYlI8gO+jNmGKOyxv79pq1csh94VTzNKoK/QLKFJy8zUJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XfBkfmKD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XfBkfmKD"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4887f49ec5aso5116675e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774950904; x=1775555704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HxyH1zkKrlLn+aBNtWDdoTBD+RA6cE3iL0Jbm7Vmczo=;
        b=XfBkfmKDQpGXKf98lppoev0JgrggQYNs5QEzyFTW51x/epf4FPCXjHS16PV9yZ+anq
         3CEnekY+a7yeCII8Vy+QN+acnvnTFc+DgmFyXOTMZqhn4Fc+T397MHC++MqinZWWM/NU
         t3yzy52Myo0WiMa6Wmq6MkTNbxstV5oFWGqopZDzBXzi6TIheRSjuNtnTtm8/hFvnJJk
         KX4wrXjYhcJ1El3naGaFGNLPit6uW4aqDgRnFqt+8/QzHQAF71Rql4zQp+1uG9O24UZX
         OMfN0dW9+rN6+FxMDw2elvUyLEL9N3Sl0tbqjXz9vR3S7g/fF+x5uvXt1P+sPnAUzQJv
         Uc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774950904; x=1775555704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxyH1zkKrlLn+aBNtWDdoTBD+RA6cE3iL0Jbm7Vmczo=;
        b=i1mbYtuvOE1AlUzsw3de54C85kt0ET7Q5WE22u5gfPNf/+ESGeEwvJqF2FjVREtPSH
         mhwyPiYUktAfk8cpO/750Y64Gi0XKhId6Kca9RyL3b9LMO30564YLlxkU3TCjvJ43leh
         OD990zH/t3sBaoZxkUsSYMz7XepWFEp9yHGIpfkrCcbGLbL2CfQzfhPOzmzXaw4NGeQb
         z5OvN8yIrCb2zyQ2kYNUmYQQkJq3OMbOnSCZ9LsldEAvxqrZ07RABBdztGlXOngoK/eu
         V6Djfc4zDO6g1hknkmHrVAk0z/ftztLEa7Z4atsq6pv5W0Trl6HDvc4Ju66QOgcLMwAJ
         g5Uw==
X-Gm-Message-State: AOJu0YzYq9R1ruxQbwTP19nDL9l1dkBGpn6C2oNrD4NuMFwHaSHETHuA
	ZBkVobwUmv0K4NYpFDzbR3vqx1icAskr+FsVpRxD7oq1hder2iE40CmTruaxyKAeaZU=
X-Gm-Gg: ATEYQzwj2cus5V/lGQCbsF06QLIdyrx0RiBS9RX0ha4ERs/iTrCfroylYXB3dHjn7u8
	kFUo6up1aWNQ1IOwTHBQau7lPNOr6O9uuKI+I0In6uwWHuRT9lyZooBUgL6I8xg10EeVtC7JL8r
	UBGrRDZLh2WzCA6QXuGR1xYqANpMYRTPcGqbdZ4IKjRZyqBcP/LWoII2MNGvhl82yITY/zx+3qu
	LxMm64qHZa/LlVCGlDnH2sJ8sPsOpWQvq4uH0I15IhrBr0/L1hJeec1d4F3TICA5Af1oUcyq93L
	1w/9Yh+G+MULG3KZ4+gMsfzDfGhhesH7F+2PhsJ+bs246bOMUuTFEpCrDeKvAGnaiTN1KRspDOq
	BoGpkcJpFrWZX0OEM1JmeGyzVFsYGYuxZW9dyEQ56szJvZdaWajFmTZtNjjLd13weLRdOnVrXI6
	FR3iEKry5JSUyca4Eq+TJGIiy4RscR
X-Received: by 2002:a05:600c:8485:b0:487:5c0:671f with SMTP id 5b1f17b1804b1-48727d733bfmr302463205e9.9.1774950903906;
        Tue, 31 Mar 2026 02:55:03 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a6ebsm29479475e9.6.2026.03.31.02.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 02:55:03 -0700 (PDT)
Message-ID: <703731ed-05f3-46f2-b074-655c9487a534@linaro.org>
Date: Tue, 31 Mar 2026 10:55:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf metricgroup: Correctly return syntax error
To: Leo Yan <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>
References: <20260327-perf_fix_metrics_group-v1-1-49e4b8ee9a08@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260327-perf_fix_metrics_group-v1-1-49e4b8ee9a08@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 27/03/2026 5:25 pm, Leo Yan wrote:
> On arm64 platforms, some CPU variants return zero for the number of slots
> when invoking tool_pmu__cpu_slots_per_cycle().  This leads to metric
> expression parsing failures, e.g.:
> 
>    metric expr 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES) for backend_bound
>    parsing metric: 100 * (STALL_SLOT_BACKEND / (CPU_CYCLES * #slots) - BR_MIS_PRED * 3 / CPU_CYCLES)
>    Failure to read '#slots' literal: #slots = nan
>    syntax error
> 
> expr__find_ids() returns a positive value for syntax errors, but this is
> not respected.  Fix this by checking for any non-zero return value from
> expr__find_ids().

What command does this impact exactly, and what does the new output look 
like?

Because "failure to read '#slots'" seems like ok output to me. I also 
saw this related commit where it seems like showing NAN is intentional:

https://lore.kernel.org/linux-perf-users/20260203230733.1474840-1-ctshao@google.com/



> 
> Do not add a Fixes tag, as this is a rare case that can only be reproduced
> by deliberately setting the PERF_CPUS env variable.

Slots is always 0 in guests so I think this might not be that rare, 
although that should be fixed in a different way.
Maybe a fixes tag is worthwhile until we fix #slots in guests somehow.

> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>
> ---
>   tools/perf/util/metricgroup.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 7e39d469111b2995f5a2636529d6985eac595f76..1119bb1c99dbd9d32601b8aeebed7d5638872366 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -909,10 +909,12 @@ static int __add_metric(struct list_head *metric_list,
>   		expr = metric_no_threshold ? pm->metric_name : pm->metric_threshold;
>   		visited_node.name = "__threshold__";
>   	}
> -	if (expr__find_ids(expr, NULL, root_metric->pctx) < 0) {
> +
> +	/* The expression parser returns a positive value on syntax error */
> +	if (expr__find_ids(expr, NULL, root_metric->pctx))
>   		/* Broken metric. */
>   		ret = -EINVAL;
> -	}
> +
>   	if (!ret) {
>   		/* Resolve referenced metrics. */
>   		struct perf_pmu *pmu;
> 
> ---
> base-commit: 54fcc7f6ec3944ae7c1b0246a999744e33839cdb
> change-id: 20260327-perf_fix_metrics_group-4be55b236f96
> 
> Best regards,

