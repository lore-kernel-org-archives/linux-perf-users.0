Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8315A3E51E4
	for <linux-perf-users@vger.kernel.org>; Wed,  6 May 2026 09:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058726; cv=none; b=GWEjMzBNYzmq5VJKmfU+J1Jm8a3lLxtr0neeuyoiG6OpH9SLBzMIbSA4+/jT+BfyqlbwPBPuMhbPEx7JsVw8/HfUXpFBfvQxfRmYdITizeyAtGvsbS8FCQfcRohWLEi60lji6T419XtNG+Aud/OLPAsTH/stblWNbELiZY66MhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058726; c=relaxed/simple;
	bh=S6CyaflhVu+7b07zQv386pkZjsmEYcwyz/yevIup+Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T8dL7xhiYICZs/wKxVyCBirQym0VxAwmJFkiKisPl/XAoGmEZxLKHcrZ1XyWuiDZ2o6RK77LVFg33tVNiULHyW4dSl1WwzNBzKGTTxXXlItYVEKViz8W4VVAN/AltF7npqn2SOX1RHzD6MClTwiVwkWILf/lh7Zuu7DhK99YUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zBOBOz7X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zBOBOz7X"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso72743745e9.3
        for <linux-perf-users@vger.kernel.org>; Wed, 06 May 2026 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778058723; x=1778663523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ILI/pwZTzIpkG8gF/uYw57HiIJriPB+qcuONqdjgJMk=;
        b=zBOBOz7XAbF9gl8SQ9gjp5Sxi3DhRDG1lh4SSGspby/gJRXhHPeZPVw+L7FLp4IZbz
         /rsh6RqCD98nXtrvQQDIakimvZODQjzejlThaMXCkClUs1ZzQSKSgxl1hHhRUOfp6lDd
         1E1cUoiCsQXRbadtUTN0wJCxQv/Zp6SsKibP6I3xeeOSp475qFXjgHZZY4kJ1tPPJA3r
         veRxF4g8YA3Oeey6SAdVlrclLpNnpk/dYRfpDwqLlesaPmDYJuGJBcelO/bxmUzWlqXg
         WmxG7sNXXXExtYfSQ8pBs/DC7EonDbN6PmOTlCbmUqRe5swjA4s0MOM6c/9hi9TyGqs9
         jZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778058723; x=1778663523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILI/pwZTzIpkG8gF/uYw57HiIJriPB+qcuONqdjgJMk=;
        b=OprmMoRSQMqQiOHgomK3xSRyQCyRmziuCaH999SMqZQogl5LSWgaOyclFRFJIBzLmi
         koeP1HGAbezlyrXZ7Zy8MqE9/eVlQjBTZGmjcxPSGWZtGOkwqBdVclqTMhdbaQlHIq9V
         fV7afFtChy19mSRJk9lguZAsyfcGttdtmvtPRCaL+4ivMRC3LmULXVKNRhpSrxBhz7J4
         ZSCnM3nvTfNUXCG1pufRbA1j+HF8FEE5i9Rf4drBWpUhDQU89kC4TR+OWZEBiPPExUjx
         YmeEChDBfQFs8ttJ5BdxqDksaYJc3N59RqaG4OoPeDS7txavk2VihtTC9SvZRyVd5poG
         Cdbw==
X-Forwarded-Encrypted: i=1; AFNElJ8RhzBvrxk6yAHdn0KwhLWcM4IBrpokbXV3j+OFegI0sLLIk0F5xCQbflue0fJGwP4W1hYCC9rdwisP7Cjgx7lM@vger.kernel.org
X-Gm-Message-State: AOJu0YwbXA69m3BR4M9o5DKh9T/feDUPEnHCTpRHXPGQBvrKuwXB4W0S
	CqO+AtG8hSQOVsGGwJxZzUAGTwKqKilqfLaNgD5W5uPlJ1jbs2XnEe2WP1uFpVXvASw=
X-Gm-Gg: AeBDietT3MtZ6nsckuxr0KyBoR9yIlt8LLslLy5VIx1YBszpggVBqk2p03eQ3NqFLbT
	4F2U1xnVqSn5uAAIDRdbYsdKJz31/BOsqSoXWsRqonKaCrn2sAeXiNrA9JOO8jNTLjPS6VUkfY+
	SVYs9ZMB86oIPqAbTFZhoxHnsdhTRikyeKRL+7zLpbE1DI+YTvDr2KzjFH6vTWowyI7EfvDd1UR
	qfwcrt7UuBmEBuBBjCaI8Zlc5zaAwUk9oZbPTin06N+pyw06FcOj0KvdheArqYmsEgyna1HFYN3
	PiOKDjD5ViOAa4vQnX8ca2gVsGBTwEJMfPw1qKxXd0pLvVG0nBplBEIrBdFwLc8jvYEYVH0gXHR
	YTeCzUyPaynLXUNl3tMUKhi2rNu/zPaVtTH6ivtzm0v9OJLMMRRtEtgCLj0O72/Rc9KrsBC/DsW
	lUnq8+lykqp5ZZDRoqRQp4JpJk3NoX28kVXiV1Qaxq5hLP+CbC6g==
X-Received: by 2002:a05:600c:a305:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48e51e08362mr29787585e9.2.1778058722965;
        Wed, 06 May 2026 02:12:02 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5382a327sm61200995e9.0.2026.05.06.02.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:12:02 -0700 (PDT)
Message-ID: <8c5343a3-a110-420b-9b61-3e4dd0e3c902@linaro.org>
Date: Wed, 6 May 2026 10:12:01 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
To: Ian Rogers <irogers@google.com>
Cc: adrian.hunter@intel.com, leo.yan@arm.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 thomas.falcon@intel.com, namhyung@kernel.org, acme@kernel.org
References: <acyWR2GAWIY7TKyD@google.com>
 <20260430161725.3131665-1-irogers@google.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260430161725.3131665-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/04/2026 5:17 pm, Ian Rogers wrote:
> Only uncore PMUs can have an identifier, so add an optimized
> perf_pmus__scan routine for that case to avoid all PMU types being
> created.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/util/metricgroup.c | 11 +++--------
>   tools/perf/util/pmus.c        | 18 +++++++++++++++++-
>   tools/perf/util/pmus.h        |  1 +
>   3 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 4db9578efd81..5a489e97c413 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -415,14 +415,9 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>   	if (!pm->metric_expr || !pm->compat)
>   		return 0;
>   
> -	while ((pmu = perf_pmus__scan(pmu))) {
> -
> -		if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, pmu->id))
> -			continue;
> -
> -		return d->fn(pm, table, d->data);
> -	}
> -	return 0;
> +	/* Only process with the iterator if there is a a PMU that matches the ID. */
> +	pmu = perf_pmus__scan_for_uncore_id(pmu, pm->compat);
> +	return pmu ? d->fn(pm, table, d->data) : 0;
>   }
>   
>   int metricgroup__for_each_metric(const struct pmu_metrics_table *table, pmu_metric_iter_fn fn,
> diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> index 9a2023ceeefd..5e3f571450fe 100644
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

Reviewed-by: James Clark <james.clark@linaro.org>

