Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F92F3C3E
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881866; cv=none; b=a+3B6/e8pSkRpscBTfUzMllrIgQ3s5nBAsMRFZ8JZK96mc1ILsIV46BlMilGtkLLC1SbUbAEY51i49uA+3mmRD4CUQeRMzmMEmiUuV2QZ4z4RiiMguSHM6Dw6kMDSgWpPxy9bKpc1BLveXE4MbMd8gb5quYkAoaSq772LaVVmdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881866; c=relaxed/simple;
	bh=gCrCn0jqzgDlmPX6zwbnJcPde8lUj6hgZ9Pnt1vwXso=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=mOST207mrpCHFtzXUpljCPi++v7BgRT9A9UQIKdjfi9VlElksfhs4yfcAYcwfDkHXbOJl0lgdJQWeA/pfA9e4SLFB1h/q6SML5xPX7U2+3c9aktjKFkRHthVj4IBLBx4B5Nkw4ESwRVgz2EIzVNtxn3M1JneI414+S/lh0FkTqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UXcHrPKx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UXcHrPKx"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso37562285e9.3
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774881863; x=1775486663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8S8GbrJC0PV0rV1d1lJEMcJXpU04+a2ZuFS/J3C8pXs=;
        b=UXcHrPKxmjbvIEgX+C8JfZ40BxaKlhYuTeFv6XbbMGYiZUXQT5sVyyUM4wkJDcuRct
         Y65PEfJOCnCteZOW8SMlIOmvFWQXACNlmdJaouUXvGKkIItnpAncgZqx6Tba0t+kmhgJ
         0i2kg1Ktnea9MKTEhGaOHSl8FC0AMpbfXlKOYysDbNLpwh3R6iCBesN2pQgvz8VnQfd3
         SDs0iaTz+ME7qvmmtpn3lAXtlRYFzOBkEoj8ev7bD6syX66RoeTmI9SV2enDwLccP+k0
         AurDktUs+XxPwTLASQ+2iBZFxiBU2aqyy58dhXfROkqHQaygSGjF8dWulo+e8pY5E0VC
         bw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774881863; x=1775486663;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8S8GbrJC0PV0rV1d1lJEMcJXpU04+a2ZuFS/J3C8pXs=;
        b=QU9OeyTGfhz+HqpOAJkKP7bHi19j+mw4a+IrKe+7lkutOiNUFH4fLGUwmAP1NkNyNd
         VDa9YeQgoWd5ueJogSclmgrsdmzMrirodq0K2LqdhRITPKs2K2iy+8zrX34NeFggP/0D
         oLnMZTPZoHkMNhhfTC4pmw+5uFHvHSBP4OuStnGJlha11Bv2qLO4y301fL8tgvmOc3Hu
         8bMmJg4zOaRAXs4rzpYRo6SnUd/ew54Fb08UKavdVXNQdK+oa/BbCqBF2clYNDWPZLFG
         gwZBIw93eTRC3x6qeF9HGLhLOAO5+RbQbHAqitTnAi13sqT7dfsxlNK2xwAGly8BYVZN
         ZAjA==
X-Forwarded-Encrypted: i=1; AJvYcCUymuCTXH+Mnc4aek78zlUaQCrHkAmE3sO6Ou79iZrmGPy2NDVREPy5b+hMUmmmcU0/TRCnygiXG15+kCvM+iBr@vger.kernel.org
X-Gm-Message-State: AOJu0YyBBJiXcLeHO3sEN03HC/KTBp08atQxD8Rsc861srVLhGXhI55A
	OoNrC+AA6G0RV5I5aoj3r1WPO4ohT3HMw0864eFSSVI4x+hvAs9APExGdqrUZEEmDqA=
X-Gm-Gg: ATEYQzyxAG90/zyERHtn7XmbHYkNuwvYcgsPJ8RyU2sScHSyifncrIHXHi24rzMh7PN
	1E5+QXDQl2if+X/cEJoz12QDfC8ZSGxTkR2QbdgcbJsPHY26fSw8LO7qK/SGuCcTHXduzhUxBFL
	Ix6NNUdQ3UGlUpHRnFHof3j2EYKjZIJS6N2PV/Topj9DiHxtQLmkbHUYelNEoxmAcvAuJaWS0In
	EAM2wXesIqwVX1gli15vIVwpE5c7Y0up6QBeSRagw32U8RKkg0pfuLEO0A7/d6Fr5Ky84VIxVVt
	sIiv3WBcNxpw7h2M6QFbVwGP8NvKiu0EvmFJcvnS9c78Dllsimg12ZYAwkr2MJpxxA+xuvX5s4l
	fMNP+RCmhZwDqROOUlwW7GHhUJUUoh7ceq4EfTjzZIFN5NMGn44UU2ucpB4RFVG/pWY1DadOP8t
	5E1Yzf5ZLgEU0n0sNft/JxJqmxZb0l6Bm/UAlEo+A=
X-Received: by 2002:a05:600c:529b:b0:485:3ec6:e634 with SMTP id 5b1f17b1804b1-48727d84100mr199442355e9.15.1774881862629;
        Mon, 30 Mar 2026 07:44:22 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48739fac087sm139524085e9.1.2026.03.30.07.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 07:44:22 -0700 (PDT)
Message-ID: <dcf5a92b-ef14-43d5-9f21-568252fd630b@linaro.org>
Date: Mon, 30 Mar 2026 15:44:21 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
To: Ian Rogers <irogers@google.com>
References: <20260326224454.2101190-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Leo Yan <leo.yan@arm.com>, Thomas Falcon <thomas.falcon@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260326224454.2101190-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/03/2026 10:44 pm, Ian Rogers wrote:
> Only uncore PMUs can have an identifier, so add an optimized
> perf_pmus__scan routine for that case to avoid all PMU types being
> created.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/metricgroup.c |  8 ++------
>   tools/perf/util/pmus.c        | 18 +++++++++++++++++-
>   tools/perf/util/pmus.h        |  1 +
>   3 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 7e39d469111b..769b38400832 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -410,13 +410,9 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>   	if (!pm->metric_expr || !pm->compat)
>   		return 0;
>   
> -	while ((pmu = perf_pmus__scan(pmu))) {
> -
> -		if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, pmu->id))
> -			continue;
> -
> +	while ((pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat)))
>   		return d->fn(pm, table, d->data);
> -	}
> +
>   	return 0;
>   }
>   
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 98be2eb8f1f0..9859d7056fb7 100644
> --- a/tools/perf/util/pmus.c
> +++ b/tools/perf/util/pmus.c
> @@ -409,7 +409,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const c
>   	if (!pmu) {
>   		/*
>   		 * Core PMUs, other sysfs PMUs and tool PMU can have any name or
> -		 * aren't wother optimizing for.
> +		 * aren't worth optimizing for.
>   		 */
>   		unsigned int to_read_pmus =  PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
>   			PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
> @@ -486,6 +486,22 @@ static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
>   	return NULL;
>   }
>   
> +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat)
> +{
> +	if (!pmu) {
> +		/* Only uncore PMUs can have identifiers. */
> +		unsigned int to_read_pmus = PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
> +
> +		pmu_read_sysfs(to_read_pmus);
> +		pmu = list_prepare_entry(pmu, &other_pmus, list);
> +	}
> +	list_for_each_entry_continue(pmu, &other_pmus, list) {
> +		if (pmu->id && pmu_uncore_identifier_match(compat, pmu->id))
> +			return pmu;
> +	}
> +	return NULL;
> +}
> +
>   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
>   {
>   	struct perf_pmu *pmu = NULL;
> diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> index 7cb36863711a..0d55edb3f2fc 100644
> --- a/tools/perf/util/pmus.h
> +++ b/tools/perf/util/pmus.h
> @@ -23,6 +23,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu);
>   struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
>   struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, const char *event);
>   struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *pmu, const char *wildcard);
> +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, const char *compat);
>   
>   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str);
>   

