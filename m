Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1284B322B;
	Mon,  7 Apr 2025 19:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054635; cv=none; b=Q5p57i5nd8Lau+wPpGttd1pP+4fedin3ZYqBG2jA5Z6S8tSkiA4pJU2i76ofddGOwMGsCqsov3ofYTpy/JBoWPJbh94UD1r0VuA/O0L2LlZevfR6f4pgfWPaAhW0XeEAlOW4LM/rr82tiS6klm556MYKC4Fi+lNT6gWhdpaesFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054635; c=relaxed/simple;
	bh=HjwarU8zVf5V8BaST0tniwaLzZx9LCBq/SilvNIuTHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Z8WN8jX5qkwSr47bnMc5suZyAmpufGszMtWZqDkdkVJsiyo0h6eVCTvXbnPfBCyOAwxFoshWwBZyhFX6gLXyDCsJ6OxR8ukfPZrJL5ViopkcI2X7977erFz+2QgDmott/7U9+NQncPmvnw/f7SKjIBzZ/pksmv0TMgU8XkdUHXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd2dR38p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd2dR38p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744054634; x=1775590634;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=HjwarU8zVf5V8BaST0tniwaLzZx9LCBq/SilvNIuTHw=;
  b=Sd2dR38pyHsxh7Hqi5SUehh9bGzIo5PY9NQlJw3peV7iV13/PCvV+dED
   WJvAzZ/E2Pw1FumTO2o8kG4U+sVJWZ+u5+vGE49amvEQGKm7Qb52vFYoB
   qPIs5xqWEusclWdFC+F9+juYg2l2gQqq/ujzC/P0uggdaeU4XaUxGhieA
   /mi2vokfmN7iyw7UaaXhLbARG7AXkn0yRvQ4yAu2zHcxFB6ZjOiCtCW5z
   ERdFRrLyrfQjwTi9mAKJB3ZYMwttnEltlEKENI1Ge2L/iNMJWb7oM/mUC
   H5Soh4whT3e2IN36zdlAcak/u9f6p2mzP3LRcN1OGy2LYGthSccEGliyg
   Q==;
X-CSE-ConnectionGUID: CGfmKvHeTLaUq1luveraxA==
X-CSE-MsgGUID: US190fsrTpeLqh3FsXvhEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="44605813"
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="44605813"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:37:13 -0700
X-CSE-ConnectionGUID: Diuess4BSVaNXjm4s78FDA==
X-CSE-MsgGUID: VcogT0mRTziODGA6uI5/sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,196,1739865600"; 
   d="scan'208";a="128045556"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 12:37:12 -0700
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7C91C20B5736;
	Mon,  7 Apr 2025 12:37:10 -0700 (PDT)
Message-ID: <b7e707fb-c362-4005-9ff5-e69928732eec@linux.intel.com>
Date: Mon, 7 Apr 2025 15:37:09 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] perf intel-tpebs: Add support for updating
 counts in evsel__tpebs_read
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, James Clark <james.clark@linaro.org>,
 Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>,
 Howard Chu <howardchu95@gmail.com>, Levi Yun <yeoreum.yun@arm.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250407050101.1389825-1-irogers@google.com>
 <20250407050101.1389825-11-irogers@google.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250407050101.1389825-11-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-04-07 1:00 a.m., Ian Rogers wrote:
> Rename to reflect evsel argument and for consistency with other tpebs
> functions. Update count from prev_raw_counts when
> available. Eventually this will allow inteval mode support.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c       | 11 ++------
>  tools/perf/util/intel-tpebs.c | 52 ++++++++++++++---------------------
>  tools/perf/util/intel-tpebs.h |  2 +-
>  3 files changed, 25 insertions(+), 40 deletions(-)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 554252ed1aab..1d343f51225b 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1718,11 +1718,6 @@ static int evsel__read_one(struct evsel *evsel, int cpu_map_idx, int thread)
>  	return perf_evsel__read(&evsel->core, cpu_map_idx, thread, count);
>  }
>  
> -static int evsel__read_retire_lat(struct evsel *evsel, int cpu_map_idx, int thread)
> -{
> -	return tpebs_set_evsel(evsel, cpu_map_idx, thread);
> -}
> -
>  static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
>  			     u64 val, u64 ena, u64 run, u64 lost)
>  {
> @@ -1730,8 +1725,8 @@ static void evsel__set_count(struct evsel *counter, int cpu_map_idx, int thread,
>  
>  	count = perf_counts(counter->counts, cpu_map_idx, thread);
>  
> -	if (counter->retire_lat) {
> -		evsel__read_retire_lat(counter, cpu_map_idx, thread);
> +	if (evsel__is_retire_lat(counter)) {
> +		evsel__tpebs_read(counter, cpu_map_idx, thread);
>  		perf_counts__set_loaded(counter->counts, cpu_map_idx, thread, true);
>  		return;
>  	}
> @@ -1889,7 +1884,7 @@ int evsel__read_counter(struct evsel *evsel, int cpu_map_idx, int thread)
>  		return evsel__hwmon_pmu_read(evsel, cpu_map_idx, thread);
>  
>  	if (evsel__is_retire_lat(evsel))
> -		return evsel__read_retire_lat(evsel, cpu_map_idx, thread);
> +		return evsel__tpebs_read(evsel, cpu_map_idx, thread);
>  
>  	if (evsel->core.attr.read_format & PERF_FORMAT_GROUP)
>  		return evsel__read_group(evsel, cpu_map_idx, thread);
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index e3227646a9cc..452ce3698221 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -415,49 +415,39 @@ int evsel__tpebs_open(struct evsel *evsel)
>  	return ret;
>  }
>  
> -
> -int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread)
> +int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread)
>  {
> -	__u64 val;
> +	struct perf_counts_values *count, *old_count = NULL;
>  	struct tpebs_retire_lat *t;
> -	struct perf_counts_values *count;
> +	uint64_t val;
> +
> +	/* Only set retire_latency value to the first CPU and thread. */
> +	if (cpu_map_idx != 0 || thread != 0)
> +		return 0;
> +
> +	if (evsel->prev_raw_counts)
> +		old_count = perf_counts(evsel->prev_raw_counts, cpu_map_idx, thread);
>  
> -	/* Non reitre_latency evsel should never enter this function. */
> -	if (!evsel__is_retire_lat(evsel))
> -		return -1;
> +	count = perf_counts(evsel->counts, cpu_map_idx, thread);
>  
>  	/*
>  	 * Need to stop the forked record to ensure get sampled data from the
>  	 * PIPE to process and get non-zero retire_lat value for hybrid.
>  	 */
>  	tpebs_stop();
> -	count = perf_counts(evsel->counts, cpu_map_idx, thread);
>  
>  	t = tpebs_retire_lat__find(evsel);
> -
> -	/* Set ena and run to non-zero */
> -	count->ena = count->run = 1;
> -	count->lost = 0;
> -
> -	if (!t) {
> -		/*
> -		 * Set default value or 0 when retire_latency for this event is
> -		 * not found from sampling data (record_tpebs not set or 0
> -		 * sample recorded).
> -		 */
> -		count->val = 0;
> -		return 0;
> +	val = rint(t->val);
> +
> +	if (old_count) {
> +		count->val = old_count->val + val;
> +		count->run = old_count->run + 1;
> +		count->ena = old_count->ena + 1;
> +	} else {
> +		count->val = val;
> +		count->run++;
> +		count->ena++;
>  	}

It seems utilizing the prev_raw_counts has been used in other place,
e.g., hwmon_pmu. Is it possible to factor out a common function for it?

Thanks,
Kan> -
> -	/*
> -	 * Only set retire_latency value to the first CPU and thread.
> -	 */
> -	if (cpu_map_idx == 0 && thread == 0)
> -		val = rint(t->val);
> -	else
> -		val = 0;
> -
> -	count->val = val;
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/intel-tpebs.h b/tools/perf/util/intel-tpebs.h
> index 5c671181ec60..218a82866cee 100644
> --- a/tools/perf/util/intel-tpebs.h
> +++ b/tools/perf/util/intel-tpebs.h
> @@ -12,6 +12,6 @@ extern bool tpebs_recording;
>  
>  int evsel__tpebs_open(struct evsel *evsel);
>  void evsel__tpebs_close(struct evsel *evsel);
> -int tpebs_set_evsel(struct evsel *evsel, int cpu_map_idx, int thread);
> +int evsel__tpebs_read(struct evsel *evsel, int cpu_map_idx, int thread);
>  
>  #endif /* __INTEL_TPEBS_H */

