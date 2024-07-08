Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1025EB665;
	Mon,  8 Jul 2024 13:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720445313; cv=none; b=beIwPPqW5+V8SIfI18Tgm+XXTeCkBT0q2mw0HxPt6T5Jqpz4V49P0nEapmay5csVos6Q/aRYEO1aUcDnz+VVbMrEFDs/ZONfhzFt3mc7O+QvxkMjCUQ3LMJcdyOUeIFelsztHv4ELXewVSkggpRSsuO00/nCUNy/v8fxnPM3I/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720445313; c=relaxed/simple;
	bh=ZTDXg4OQinuqoAKxEKT5YEUVgjuRVHhh+W+7j5PtCBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LOtMmfQK7uSDeqOY4Ej4OK6DfTK2tfr24GZ6Bjj+YfIy/HJ2rVtYp5VP1DLsTg8pITdTFDbF8jchp2YaDAn7kiwms1+kcX8j1mplLBfiXYKaV8Wbw1HzP391dl97EPdU/FtjqbNgy6iAmfvLNKg7rnOFvE9Yh/fJ6PymUmgYMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O5zs9cIA; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O5zs9cIA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720445312; x=1751981312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZTDXg4OQinuqoAKxEKT5YEUVgjuRVHhh+W+7j5PtCBk=;
  b=O5zs9cIAcV1TVs7/O9dKGzpJxOeCBEvh7GSAR3XGS2fGk1O7uti8y9Wj
   vFMV3d1niGH/eE8hXPd/yafpsUSByvrmhS64Mbd71IW5xV4MAqp+xJs3j
   YJy5iikHpBDe/GFjC2pLsJap4Z2O8a8uDbLiCo2bYqy44L+Zt+lngln1O
   WpLrJRzKBswu596jrrJdNCISDfOphYPmSrP6Ec5D7LSkNnBDbs53gD3UG
   Unc57XMatrd1BH50GigbwlBwInovrvYx2aUcoiNGtLPdmmXlpXVDY2yKL
   WhVJE6HneUE36iA9dD9CYtMu257Dwwi3Kplhei32GnOXonZeEh5MbH/hu
   w==;
X-CSE-ConnectionGUID: +xOVz17bTViiuu1EQkgymw==
X-CSE-MsgGUID: nhg+D+a4QQihiw/U7zmkow==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="17774873"
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="17774873"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 06:28:31 -0700
X-CSE-ConnectionGUID: RNEK6+qzRqe7kDck+n1zOQ==
X-CSE-MsgGUID: h4D1KXmWQtqBCKxaT9OQ8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,192,1716274800"; 
   d="scan'208";a="47578161"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 06:28:31 -0700
Received: from [10.212.126.29] (kliang2-mobl1.ccr.corp.intel.com [10.212.126.29])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 981BF20738D4;
	Mon,  8 Jul 2024 06:28:29 -0700 (PDT)
Message-ID: <821ea427-aeef-4269-9af8-4cdb8cf32ca8@linux.intel.com>
Date: Mon, 8 Jul 2024 09:28:28 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/5] perf x86/topdown: Complete topdown slots/metrics
 events check
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-2-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240708144204.839486-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-07-08 10:42 a.m., Dapeng Mi wrote:
> It's not complete to check whether an event is a topdown slots or
> topdown metrics event by only comparing the event name since user
> may assign the event by RAW format, e.g.
> 
> perf stat -e '{instructions,cpu/r400/,cpu/r8300/}' sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>      <not counted>      instructions
>      <not counted>      cpu/r400/
>    <not supported>      cpu/r8300/
> 
>        1.002917796 seconds time elapsed
> 
>        0.002955000 seconds user
>        0.000000000 seconds sys
> 
> The RAW format slots and topdown-be-bound events are not recognized and
> not regroup the events, and eventually cause error.
> 
> Thus add two helpers arch_is_topdown_slots()/arch_is_topdown_metrics()
> to detect whether an event is topdown slots/metrics event by comparing
> the event config directly, and use these two helpers to replace the
> original event name comparisons.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/evlist.c  |  8 +++---
>  tools/perf/arch/x86/util/evsel.c   |  3 ++-
>  tools/perf/arch/x86/util/topdown.c | 43 +++++++++++++++++++++++++++++-
>  tools/perf/arch/x86/util/topdown.h |  2 ++
>  4 files changed, 50 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
> index b1ce0c52d88d..332e8907f43e 100644
> --- a/tools/perf/arch/x86/util/evlist.c
> +++ b/tools/perf/arch/x86/util/evlist.c
> @@ -78,14 +78,14 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>  	if (topdown_sys_has_perf_metrics() &&
>  	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>  		/* Ensure the topdown slots comes first. */
> -		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
> +		if (arch_is_topdown_slots(lhs))
>  			return -1;
> -		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
> +		if (arch_is_topdown_slots(rhs))
>  			return 1;
>  		/* Followed by topdown events. */
> -		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
> +		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>  			return -1;
> -		if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
> +		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>  			return 1;
>  	}
>  
> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
> index 090d0f371891..181f2ba0bb2a 100644
> --- a/tools/perf/arch/x86/util/evsel.c
> +++ b/tools/perf/arch/x86/util/evsel.c
> @@ -6,6 +6,7 @@
>  #include "util/pmu.h"
>  #include "util/pmus.h"
>  #include "linux/string.h"
> +#include "topdown.h"
>  #include "evsel.h"
>  #include "util/debug.h"
>  #include "env.h"
> @@ -44,7 +45,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>  	    strcasestr(evsel->name, "uops_retired.slots"))
>  		return false;
>  
> -	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
> +	return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
>  }
>  
>  int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
> index 3f9a267d4501..e805065bb7e1 100644
> --- a/tools/perf/arch/x86/util/topdown.c
> +++ b/tools/perf/arch/x86/util/topdown.c
> @@ -32,6 +32,47 @@ bool topdown_sys_has_perf_metrics(void)
>  }
>  
>  #define TOPDOWN_SLOTS		0x0400
> +bool arch_is_topdown_slots(const struct evsel *evsel)
> +{
> +	if (evsel->core.attr.config == TOPDOWN_SLOTS)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int compare_topdown_event(void *vstate, struct pmu_event_info *info)
> +{
> +	int *config = vstate;
> +	int event = 0;
> +	int umask = 0;
> +	char *str;
> +

The compare is only needed for the "topdown" event.
Check the name first before the sscanf and compare.

	if (!strcasestr(info->name, "topdown"))
		return 0;

> +	str = strcasestr(info->str, "event=");
> +	if (str)
> +		sscanf(str, "event=%x", &event);
> +
> +	str = strcasestr(info->str, "umask=");
> +	if (str)
> +		sscanf(str, "umask=%x", &umask);
> +
> +	if (strcasestr(info->name, "topdown") && event == 0 &&
> +	    *config == (event | umask << 8))
> +		return 1;
> +
> +	return 0;
> +}
> +
> +bool arch_is_topdown_metrics(const struct evsel *evsel)
> +{
> +	struct perf_pmu *pmu = evsel__find_pmu(evsel);
> +	int config = evsel->core.attr.config;
> +

The topdown events are only available for the core PMU.
You may want to return earlier for the !core PMUs.

	if (!pmu || !pmu->is_core)
		return false;

Thanks,
Kan
> +	if (pmu && perf_pmu__for_each_event(pmu, false, &config,
> +					    compare_topdown_event))
> +		return true;
> +
> +	return false;
> +}
>  
>  /*
>   * Check whether a topdown group supports sample-read.
> @@ -44,7 +85,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
>  	if (!evsel__sys_has_perf_metrics(leader))
>  		return false;
>  
> -	if (leader->core.attr.config == TOPDOWN_SLOTS)
> +	if (arch_is_topdown_slots(leader))
>  		return true;
>  
>  	return false;
> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
> index 46bf9273e572..1bae9b1822d7 100644
> --- a/tools/perf/arch/x86/util/topdown.h
> +++ b/tools/perf/arch/x86/util/topdown.h
> @@ -3,5 +3,7 @@
>  #define _TOPDOWN_H 1
>  
>  bool topdown_sys_has_perf_metrics(void);
> +bool arch_is_topdown_slots(const struct evsel *evsel);
> +bool arch_is_topdown_metrics(const struct evsel *evsel);
>  
>  #endif
