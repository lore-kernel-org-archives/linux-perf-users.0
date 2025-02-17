Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE0A19CC02;
	Mon, 17 Feb 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780417; cv=none; b=TZFZKIc8mGUSXqb+pb/q/pyrMUXo+WkF9Z2g/0rFali1rlMfG2+4XUacO5ADT9vg8sPxLRIRbubl85oX+ktZ6y454Bg3Lqt706pySryjSqneQfuQeC41sel1mKxEZXsCiXU625SlbDB0D9p/+faKPAB590YNBlft0EW/78ijUpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780417; c=relaxed/simple;
	bh=TvcxyVay6Lj7lTROLA2RkNt18bqPLK2uhonK8RJ0e38=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR2SPZbMV02wTPhCoG6g9pFqcJ9ZTk6vCdJu09wcIDJM7CSaCUsz0xA9JjOyi6IBYDzB+Ueqwr9pf7+bRJFH6Mk70FO6g4eL+vFNbAQtRXBdP9A2KJxFiIaxo78cfbYYZbSriqrZpUhM1PvO2GycqSv3+M+5HWL4uosvTsmzJmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F4D31007;
	Mon, 17 Feb 2025 00:20:34 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 576B53F5A1;
	Mon, 17 Feb 2025 00:20:14 -0800 (PST)
Date: Mon, 17 Feb 2025 08:20:08 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf arm-spe: Report error if set frequency
Message-ID: <20250217082008.GA8144@e132581.arm.com>
References: <20250205183009.224182-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205183009.224182-1-leo.yan@arm.com>

On Wed, Feb 05, 2025 at 06:30:09PM +0000, Leo Yan wrote:
> When users set the parameter '-F' to specify frequency for Arm SPE, the
> tool reports error:
> 
>   perf record -F 1000 -e arm_spe_0// -- sleep 1
>   Error:
>   Invalid event (arm_spe_0//) in per-thread mode, enable system wide with '-a'.
> 
> The output logs are confused and it does not give the correct reminding.
> Arm SPE does not support frequency setting given it adopts a statistical
> based approach.
> 
> Alternatively, Arm SPE supports setting period.  This commit adds a
> for frequency setting.  It reports error and reminds users to set period
> instead.
> 
> After:
> 
>   perf record -F 100 -e arm_spe_0// -- sleep 1
>   Arm SPE: Frequency is not supported. Check manual 'man perf-record' on how to set period.
> 
> Signed-off-by: Leo Yan <leo.yan@arm.com>

Gentle ping.

> ---
>  tools/perf/arch/arm64/util/arm-spe.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 4301181b8e45..baef0812dc19 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -40,6 +40,19 @@ struct arm_spe_recording {
>  	bool			*wrapped;
>  };
>  
> +/* Iterate config list to detect if the "freq" parameter is set */
> +static bool arm_spe_is_set_freq(struct evsel *evsel)
> +{
> +	struct evsel_config_term *term;
> +
> +	list_for_each_entry(term, &evsel->config_terms, list) {
> +		if (term->type == EVSEL__CONFIG_TERM_FREQ)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * arm_spe_find_cpus() returns a new cpu map, and the caller should invoke
>   * perf_cpu_map__put() to release the map after use.
> @@ -389,6 +402,13 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>  				return -EINVAL;
>  			}
>  			opts->full_auxtrace = true;
> +
> +			if (opts->user_freq != UINT_MAX ||
> +			    arm_spe_is_set_freq(evsel)) {
> +				pr_err("Arm SPE: Frequency is not supported. "
> +				       "Check manual 'man perf-record' on how to set period.\n");
> +				return -EINVAL;
> +			}
>  		}
>  	}
>  
> -- 
> 2.34.1
> 
