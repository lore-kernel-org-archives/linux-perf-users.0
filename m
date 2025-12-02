Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4236C1F30A4;
	Tue,  2 Dec 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764677735; cv=none; b=DA08mk/N8uUfnQxjX0/UqGu8SBme9lDrMoFlIqx2RyPwoqws/ysWAQezV96CIuyY8L+bkJMvw85qJJa33VxgOd9nCWZVClg7nbCK6r81QPyIMb3P9EsKzfa1mvFebFMDboMBfj0qgYTZ/oodY+ntIwcYjt2XYJxnmsTn35ND62E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764677735; c=relaxed/simple;
	bh=Ie25x5JbYN8NezWHISlKdW1BknwQWUEZ3k4+Gv5GsCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ8X2nkCJ9De2qR7YRK6Ck4qwdKWD7pYkU/qOi/NZ5c6m39OnoNFA/r4GROfWA25GaJN+w1GYGDRyE1WMRBpkdGOBawyslyp9Rkf0jqsqvBwSbqPWV/+5FI04FM6TepXh8R5aVk08EwjPtnMNaC//Gu3Q1B8ju3uRgyK8AQ9hkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C75CE153B;
	Tue,  2 Dec 2025 04:15:23 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C0DBE3F73B;
	Tue,  2 Dec 2025 04:15:30 -0800 (PST)
Date: Tue, 2 Dec 2025 12:15:28 +0000
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
Subject: Re: [PATCH 6/7] perf cs-etm: Don't hard code config attribute when
 configuring the event
Message-ID: <20251202121528.GX724103@e132581.arm.com>
References: <20251201-james-perf-config-bits-v1-0-22ecbbf8007c@linaro.org>
 <20251201-james-perf-config-bits-v1-6-22ecbbf8007c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-james-perf-config-bits-v1-6-22ecbbf8007c@linaro.org>

On Mon, Dec 01, 2025 at 04:41:09PM +0000, Coresight ML wrote:

[...]

> @@ -103,13 +103,20 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>  				      struct perf_cpu cpu)
>  {
>  	int err;
> -	__u64 val;
> -	u64 contextid = evsel->core.attr.config &
> -		(perf_pmu__format_bits(cs_etm_pmu, "contextid") |
> -		 perf_pmu__format_bits(cs_etm_pmu, "contextid1") |
> -		 perf_pmu__format_bits(cs_etm_pmu, "contextid2"));
> +	u64 ctxt, ctxt1, ctxt2;
> +	__u64 trcidr2;
>  
> -	if (!contextid)
> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid", &ctxt);
> +	if (err)
> +		return err;
> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid1", &ctxt1);
> +	if (err)
> +		return err;
> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "contextid2", &ctxt2);
> +	if (err)
> +		return err;

Seems to me, this is not right.  The current code checks any context
ID setting but it can tolerate if missing "contexid[*]" format.

After calling evsel__get_config_val(), if any "contextid[*]" format is
missed, it returns error and will diretly bail out.  As a result,
cs_etm_validate_context_id() will always return error.

> +
> +	if (!ctxt && !ctxt1 && !ctxt2)
>  		return 0;
>  
>  	/* Not supported in etmv3 */
> @@ -120,12 +127,11 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>  	}
>  
>  	/* Get a handle on TRCIDR2 */
> -	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2], &val);
> +	err = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2], &trcidr2);
>  	if (err)
>  		return err;
>  
> -	if (contextid &
> -	    perf_pmu__format_bits(cs_etm_pmu, "contextid1")) {
> +	if (ctxt1) {
>  		/*
>  		 * TRCIDR2.CIDSIZE, bit [9-5], indicates whether contextID
>  		 * tracing is supported:
> @@ -133,15 +139,14 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>  		 *  0b00100 Maximum of 32-bit Context ID size.
>  		 *  All other values are reserved.
>  		 */
> -		if (BMVAL(val, 5, 9) != 0x4) {
> +		if (BMVAL(trcidr2, 5, 9) != 0x4) {
>  			pr_err("%s: CONTEXTIDR_EL1 isn't supported, disable with %s/contextid1=0/\n",
>  			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>  			return -EINVAL;
>  		}
>  	}
>  
> -	if (contextid &
> -	    perf_pmu__format_bits(cs_etm_pmu, "contextid2")) {
> +	if (ctxt2) {
>  		/*
>  		 * TRCIDR2.VMIDOPT[30:29] != 0 and
>  		 * TRCIDR2.VMIDSIZE[14:10] == 0b00100 (32bit virtual contextid)
> @@ -149,7 +154,7 @@ static int cs_etm_validate_context_id(struct perf_pmu *cs_etm_pmu, struct evsel
>  		 * virtual context id is < 32bit.
>  		 * Any value of VMIDSIZE >= 4 (i.e, > 32bit) is fine for us.
>  		 */
> -		if (!BMVAL(val, 29, 30) || BMVAL(val, 10, 14) < 4) {
> +		if (!BMVAL(trcidr2, 29, 30) || BMVAL(trcidr2, 10, 14) < 4) {
>  			pr_err("%s: CONTEXTIDR_EL2 isn't supported, disable with %s/contextid2=0/\n",
>  			       CORESIGHT_ETM_PMU_NAME, CORESIGHT_ETM_PMU_NAME);
>  			return -EINVAL;
> @@ -163,10 +168,14 @@ static int cs_etm_validate_timestamp(struct perf_pmu *cs_etm_pmu, struct evsel *
>  				     struct perf_cpu cpu)
>  {
>  	int err;
> -	__u64 val;
> +	u64 val;
> +	__u64 trcidr0;
>  
> -	if (!(evsel->core.attr.config &
> -	      perf_pmu__format_bits(cs_etm_pmu, "timestamp")))
> +	err = evsel__get_config_val(cs_etm_pmu, evsel, "timestamp", &val);
> +	if (err)
> +		return err;
> +
> +	if (!val)
>  		return 0;

Similiar issue here.  The current code returns 0 if not find "timestamp"
format.  With this change, it returns error instead.

Thanks,
Leo
