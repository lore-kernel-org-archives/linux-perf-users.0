Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362393009F2;
	Tue,  2 Dec 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674050; cv=none; b=GepXPq43HF4+ptH3QxHzhnGo5LkQSfcQaIrLU91lVtXiJQya6JrBhKaKiNdzaFNBnFTg1oZd4BVKO201wFlASJp25AAa+u+leR0EdHMoAczn4OV+y9ziR9NQ+KIh615+kQJzHU6TnpiZz2BdwoUgeTtd8A1mg+70qiT48tOiRD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674050; c=relaxed/simple;
	bh=TFmxFOm/qcb3majmSsxEA9IVMnSurizX2vzsaF999Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukwpGHrez13WBDfusqMHLBt9Go5GGnEcrHR/fv20uMxFHAeaHpobBP/xn0HQoySJbuzdJSO/24ioVLYB8Bbki60pSa94oS/SGYlml37vNR6SZ5wgHgTQGRk6eHbsYl7Y6cYFAf5NbwP+pf7B/8AkShriGB3wCCkUIFwTnecPfwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D160D153B;
	Tue,  2 Dec 2025 03:13:58 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9A213F59E;
	Tue,  2 Dec 2025 03:14:05 -0800 (PST)
Date: Tue, 2 Dec 2025 11:14:03 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/7] perf tools: apply evsel__set_config_if_unset() to
 all config fields
Message-ID: <20251202111403.GS724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-2-22ecbbf8007c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-james-perf-config-bits-v1-2-22ecbbf8007c@linaro.org>

On Mon, Dec 01, 2025 at 04:41:05PM +0000, Coresight ML wrote:

[...]

>  void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>  				const char *config_name, u64 val)
>  {
>  	u64 user_bits = 0, bits;
> -	struct evsel_config_term *term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
> +	struct evsel_config_term *term;
> +	struct perf_pmu_format *format = pmu_find_format(&pmu->format, config_name);
> +	__u64 *vp;

Should check (format == NULL) here and bail out for a unknown config name?

> +
> +	switch (format->value) {
> +	case PERF_PMU_FORMAT_VALUE_CONFIG:
> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG);
> +		vp = &evsel->core.attr.config;
> +		break;
> +	case PERF_PMU_FORMAT_VALUE_CONFIG1:
> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG1);
> +		vp = &evsel->core.attr.config1;
> +		break;
> +	case PERF_PMU_FORMAT_VALUE_CONFIG2:
> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG2);
> +		vp = &evsel->core.attr.config2;
> +		break;
> +	case PERF_PMU_FORMAT_VALUE_CONFIG3:
> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG3);
> +		vp = &evsel->core.attr.config3;
> +		break;
> +	case PERF_PMU_FORMAT_VALUE_CONFIG4:
> +		term = evsel__get_config_term(evsel, USR_CHG_CONFIG4);
> +		vp = &evsel->core.attr.config4;
> +		break;
> +	default:
> +		pr_err("Unknown format value: %d\n", format->value);
> +		return;
> +	}
>  
>  	if (term)
>  		user_bits = term->val.cfg_chg;
> @@ -1396,20 +1436,8 @@ void evsel__set_config_if_unset(struct perf_pmu *pmu, struct evsel *evsel,
>  		return;
>  
>  	/* Otherwise replace it */
> -	evsel->core.attr.config &= ~bits;
> -	evsel->core.attr.config |= field_prep(bits, val);
> -}
> -
> -static struct perf_pmu_format *
> -pmu_find_format(const struct list_head *formats, const char *name)
> -{
> -	struct perf_pmu_format *format;
> -
> -	list_for_each_entry(format, formats, list)
> -		if (!strcmp(format->name, name))
> -			return format;
> -
> -	return NULL;
> +	*vp &= ~bits;
> +	*vp |= FIELD_PREP(bits, val);
>  }
