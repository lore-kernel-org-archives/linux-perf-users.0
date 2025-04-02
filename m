Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E3E39FD9;
	Wed,  2 Apr 2025 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607399; cv=none; b=XTZHMivsf7OjUyzvb0tmCcY+0cS6S2ZXxMt7Tm9Ggza1wDyko51SUFhmMhRmZHzpM9DcmDuWidtExhB+DS9pOoFP92JOfYr2QuzwSSMdTTBmYSPnriDWxqgDfyuk5/Nxp+gHjcizUlAj+S+PmiaA42mxP0pGQhyu0L7MVrnjS1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607399; c=relaxed/simple;
	bh=Agn5aIC+UecWPsNBD+cdpqGxkV91aebLchMrY17IwdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O88dGVa/UZtW96Aln4QZYSBnsXKY19RphYnlN/wRns9dBrciSWTvWCr5DXzJiEr1//VFkrMatmlTMp31NpRLg3rnE09h3H9BTeYOZYP6QezA+5hcnH3aX+TF8J/etV873d3UDNWrPIRx1q0ZXq8RnVzltRUfCFW+mOf+bZfLru8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7BMGh9Q; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7BMGh9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743607399; x=1775143399;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Agn5aIC+UecWPsNBD+cdpqGxkV91aebLchMrY17IwdE=;
  b=Q7BMGh9QA+DGFvoAmVrvFtUxSMel41DVBF0lCCUZszGpEY5cFXShOxNQ
   MpcnZFnjkhN+7iyQuyKtdFPZ2FPjpr6OPj2N4DaTDEAPy0qrHaZjLt0tf
   dpktx4CWAfydLHqXyPxY1j/IQnqjwFjju7MfUTflRIxfAlEVouvSviwle
   e0uW6O6E5bnchFUdbzqRIuKhMFH97DJ5O+PD3xBnaC9tIjkX5QL87HlMC
   c/CSiuLsA+NhvZI2caM7OLqMlF8a+mdBOCtqA71pID8Hf/aqPRyQ0/gfc
   MuTKjax9178oqtl3FnriN5R+9TIr0dHV8JwK93klnQX+7ALsj223Q4XKk
   w==;
X-CSE-ConnectionGUID: vlcKkkWhTpCuxQtUI0NYyw==
X-CSE-MsgGUID: aw7cjXz9Ts6jsRzAm1+pRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44875679"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44875679"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:23:18 -0700
X-CSE-ConnectionGUID: PmUwmW5hRFevmQz7BX717w==
X-CSE-MsgGUID: XxgHLJR9T+ipQ/TXGpO+yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="126628542"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:23:18 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 511DB20B5736;
	Wed,  2 Apr 2025 08:23:13 -0700 (PDT)
Message-ID: <28016335-385c-48b9-8767-9b087a0ec4cc@linux.intel.com>
Date: Wed, 2 Apr 2025 11:23:12 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/5] perf stat: Better hybrid support for the NMI
 watchdog warning
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>,
 Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>,
 James Clark <james.clark@linaro.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250318041442.321230-1-irogers@google.com>
 <20250318041442.321230-2-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250318041442.321230-2-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-03-18 12:14 a.m., Ian Rogers wrote:
> Prior to this patch evlist__has_hybrid would return false if the
> processor wasn't hybrid or the evlist didn't contain any core
> events. If the only PMU used by events was cpu_core then it would
> true even though there are no cpu_atom events. For example:
> 
> ```
> $ perf stat --cputype=cpu_core -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}' true
> 
>  Performance counter stats for 'true':
> 
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
>      <not counted>      cpu_core/cycles/                                                        (0.00%)
> 
>        0.001981900 seconds time elapsed
> 
>        0.002311000 seconds user
>        0.000000000 seconds sys
> ```
> 
> This patch changes evlist__has_hybrid to return true only if the
> evlist contains events from >1 core PMU. This means the NMI watchdog
> warning is shown for the case above.

Nit:
The function name may still bring confusions.
It may be better to change the function name as well, e.g.,
evlist__has_hybrid_pmus()? It implies more than one PMU.

Thanks,
Kan>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/stat-display.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> index e852ac0d9847..f311f1960e29 100644
> --- a/tools/perf/util/stat-display.c
> +++ b/tools/perf/util/stat-display.c
> @@ -825,13 +825,25 @@ static bool is_mixed_hw_group(struct evsel *counter)
>  static bool evlist__has_hybrid(struct evlist *evlist)
>  {
>  	struct evsel *evsel;
> +	struct perf_pmu *last_core_pmu = NULL;
>  
>  	if (perf_pmus__num_core_pmus() == 1)
>  		return false;
>  
>  	evlist__for_each_entry(evlist, evsel) {
> -		if (evsel->core.is_pmu_core)
> +		if (evsel->core.is_pmu_core) {
> +			struct perf_pmu *pmu = evsel__find_pmu(evsel);
> +
> +			if (pmu == last_core_pmu)
> +				continue;
> +
> +			if (last_core_pmu == NULL) {
> +				last_core_pmu = pmu;
> +				continue;
> +			}
> +			/* A distinct core PMU. */
>  			return true;
> +		}
>  	}
>  
>  	return false;

