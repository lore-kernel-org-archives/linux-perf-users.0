Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0513C6A6;
	Tue,  9 Jul 2024 01:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720490330; cv=none; b=Xu60iB3BAApmIbz+6ZYi/DhQjksl6eXsI/fVWJ3rs6FoNNSreFOocnJfnDdvRE7cXa+DQ/y+U6cYcni+jbz6He47eZFZMP03zPJe9dJiflGS2y5lUpt59GfJzOmOxYeNBpJCodl7saY7IHYYBgkndCCI4lnW2unGUl+J7Ab9HII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720490330; c=relaxed/simple;
	bh=Zc+BFdezUEGq50mDu4EXD/nLArIEc+7EWIsIbNsSghw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRHqgcgm6lhnJ6VNmaVpsu29SlFmbz5l9CZRaS4Zrab8SRA1co8T3WvTLvzECKR1RUM/mnctYs2RPDMuiFjYxvQe8/d8zaLes5B1POxKetPJs9qKx98plcIVi6HJ2G8J3HGXZ2Jefi0g6kx4kxDdsYE5Exo3nykm5tM3Faeg5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j6k1Hk3l; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j6k1Hk3l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720490328; x=1752026328;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zc+BFdezUEGq50mDu4EXD/nLArIEc+7EWIsIbNsSghw=;
  b=j6k1Hk3lf+zwhMXkDG1tYXptbf++BIXqWub0C1f7YbhtkbBu8IDUmflD
   9GBtHCFPaaVEbgF640q0tUWzRwP5aTW0a5I4hJaI5zXeEJyDxfXL/GINQ
   hozdS+3cO0B7eDZjwhKC+AQbJlI9q+If630ZotyTJenhY3H7PKc0HjkOg
   MNhq8m76OTU1zdNt5wwIoM/QsdhjP+O38yx7MNhtoH9duc0nxh1M6sZHN
   w0TCnsEjpIguqbLr4vx57CLrTSZBKo48LYHzuqThxtFRztu9tfKWhGlmv
   fIkY3jJbO7ZMCnmNuHPSM77ZRi2c+dNFummqnkcfC+zU0dbb8pRgijs/1
   A==;
X-CSE-ConnectionGUID: WpXPXL8fRROZaWleEiYRmQ==
X-CSE-MsgGUID: oBpXhuNdTVmvris9ONIg6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11127"; a="28388792"
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="28388792"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:58:47 -0700
X-CSE-ConnectionGUID: BI29zawvT+6x6vsfXqrhEA==
X-CSE-MsgGUID: hsuL/474TBi6VJ013cxzXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,193,1716274800"; 
   d="scan'208";a="52873582"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:58:44 -0700
Message-ID: <751d5d08-c3b3-42eb-840b-259dbf83fc11@linux.intel.com>
Date: Tue, 9 Jul 2024 09:58:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/5] perf x86/topdown: Complete topdown slots/metrics
 events check
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongwei Ma <yongwei.ma@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>
References: <20240708144204.839486-1-dapeng1.mi@linux.intel.com>
 <20240708144204.839486-2-dapeng1.mi@linux.intel.com>
 <821ea427-aeef-4269-9af8-4cdb8cf32ca8@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <821ea427-aeef-4269-9af8-4cdb8cf32ca8@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/8/2024 9:28 PM, Liang, Kan wrote:
>
> On 2024-07-08 10:42 a.m., Dapeng Mi wrote:
>> It's not complete to check whether an event is a topdown slots or
>> topdown metrics event by only comparing the event name since user
>> may assign the event by RAW format, e.g.
>>
>> perf stat -e '{instructions,cpu/r400/,cpu/r8300/}' sleep 1
>>
>>  Performance counter stats for 'sleep 1':
>>
>>      <not counted>      instructions
>>      <not counted>      cpu/r400/
>>    <not supported>      cpu/r8300/
>>
>>        1.002917796 seconds time elapsed
>>
>>        0.002955000 seconds user
>>        0.000000000 seconds sys
>>
>> The RAW format slots and topdown-be-bound events are not recognized and
>> not regroup the events, and eventually cause error.
>>
>> Thus add two helpers arch_is_topdown_slots()/arch_is_topdown_metrics()
>> to detect whether an event is topdown slots/metrics event by comparing
>> the event config directly, and use these two helpers to replace the
>> original event name comparisons.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/evlist.c  |  8 +++---
>>  tools/perf/arch/x86/util/evsel.c   |  3 ++-
>>  tools/perf/arch/x86/util/topdown.c | 43 +++++++++++++++++++++++++++++-
>>  tools/perf/arch/x86/util/topdown.h |  2 ++
>>  4 files changed, 50 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> index b1ce0c52d88d..332e8907f43e 100644
>> --- a/tools/perf/arch/x86/util/evlist.c
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -78,14 +78,14 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>  	if (topdown_sys_has_perf_metrics() &&
>>  	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>>  		/* Ensure the topdown slots comes first. */
>> -		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
>> +		if (arch_is_topdown_slots(lhs))
>>  			return -1;
>> -		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
>> +		if (arch_is_topdown_slots(rhs))
>>  			return 1;
>>  		/* Followed by topdown events. */
>> -		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
>> +		if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>>  			return -1;
>> -		if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
>> +		if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>>  			return 1;
>>  	}
>>  
>> diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
>> index 090d0f371891..181f2ba0bb2a 100644
>> --- a/tools/perf/arch/x86/util/evsel.c
>> +++ b/tools/perf/arch/x86/util/evsel.c
>> @@ -6,6 +6,7 @@
>>  #include "util/pmu.h"
>>  #include "util/pmus.h"
>>  #include "linux/string.h"
>> +#include "topdown.h"
>>  #include "evsel.h"
>>  #include "util/debug.h"
>>  #include "env.h"
>> @@ -44,7 +45,7 @@ bool arch_evsel__must_be_in_group(const struct evsel *evsel)
>>  	    strcasestr(evsel->name, "uops_retired.slots"))
>>  		return false;
>>  
>> -	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
>> +	return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
>>  }
>>  
>>  int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
>> diff --git a/tools/perf/arch/x86/util/topdown.c b/tools/perf/arch/x86/util/topdown.c
>> index 3f9a267d4501..e805065bb7e1 100644
>> --- a/tools/perf/arch/x86/util/topdown.c
>> +++ b/tools/perf/arch/x86/util/topdown.c
>> @@ -32,6 +32,47 @@ bool topdown_sys_has_perf_metrics(void)
>>  }
>>  
>>  #define TOPDOWN_SLOTS		0x0400
>> +bool arch_is_topdown_slots(const struct evsel *evsel)
>> +{
>> +	if (evsel->core.attr.config == TOPDOWN_SLOTS)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +static int compare_topdown_event(void *vstate, struct pmu_event_info *info)
>> +{
>> +	int *config = vstate;
>> +	int event = 0;
>> +	int umask = 0;
>> +	char *str;
>> +
> The compare is only needed for the "topdown" event.
> Check the name first before the sscanf and compare.
>
> 	if (!strcasestr(info->name, "topdown"))
> 		return 0;

Yes, thanks.


>> +	str = strcasestr(info->str, "event=");
>> +	if (str)
>> +		sscanf(str, "event=%x", &event);
>> +
>> +	str = strcasestr(info->str, "umask=");
>> +	if (str)
>> +		sscanf(str, "umask=%x", &umask);
>> +
>> +	if (strcasestr(info->name, "topdown") && event == 0 &&
>> +	    *config == (event | umask << 8))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +bool arch_is_topdown_metrics(const struct evsel *evsel)
>> +{
>> +	struct perf_pmu *pmu = evsel__find_pmu(evsel);
>> +	int config = evsel->core.attr.config;
>> +
> The topdown events are only available for the core PMU.
> You may want to return earlier for the !core PMUs.
>
> 	if (!pmu || !pmu->is_core)
> 		return false;

Sure. Thanks.


>
> Thanks,
> Kan
>> +	if (pmu && perf_pmu__for_each_event(pmu, false, &config,
>> +					    compare_topdown_event))
>> +		return true;
>> +
>> +	return false;
>> +}
>>  
>>  /*
>>   * Check whether a topdown group supports sample-read.
>> @@ -44,7 +85,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
>>  	if (!evsel__sys_has_perf_metrics(leader))
>>  		return false;
>>  
>> -	if (leader->core.attr.config == TOPDOWN_SLOTS)
>> +	if (arch_is_topdown_slots(leader))
>>  		return true;
>>  
>>  	return false;
>> diff --git a/tools/perf/arch/x86/util/topdown.h b/tools/perf/arch/x86/util/topdown.h
>> index 46bf9273e572..1bae9b1822d7 100644
>> --- a/tools/perf/arch/x86/util/topdown.h
>> +++ b/tools/perf/arch/x86/util/topdown.h
>> @@ -3,5 +3,7 @@
>>  #define _TOPDOWN_H 1
>>  
>>  bool topdown_sys_has_perf_metrics(void);
>> +bool arch_is_topdown_slots(const struct evsel *evsel);
>> +bool arch_is_topdown_metrics(const struct evsel *evsel);
>>  
>>  #endif
