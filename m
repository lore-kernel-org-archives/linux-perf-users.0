Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B81448FD;
	Thu, 15 Aug 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704150; cv=none; b=p2wN22hmhw9u5+jOog9agCMAmmt43VOH4WYkdAVeFWBT+cI5dW0NPiStJ3a4Rqvw6VMy/zUWTB8fJhK19jQfGVoPsMD7XAoZjS9Z+UhJmTRvtXNrJAjnTOFvXiBeKrKmlmXWzBJT3V0o2PmYg9Xyb4aeljIOcTmwkmgS43sX3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704150; c=relaxed/simple;
	bh=sH6QnAl702Pa6jtq1WpXYAM+8fcYbnfY+emhpZgIWJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uImfUektE3hX+oB6/AIXBoEgAo4dRigUTQBOsEKPvYEb1pr0noaUOrv7tEkTmxKFmOuYbnRvfhq4HmmA6DK+2xn0+HdQ7Tz4BjyIsv8hZ6Qy1JEVMLx7Pu6VuMHczjbu0y7XjAkvW8TkIfPahCR2cKDpJgEq4+Vxe5rxLQnR3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KgPZcXQl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KgPZcXQl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723704149; x=1755240149;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sH6QnAl702Pa6jtq1WpXYAM+8fcYbnfY+emhpZgIWJE=;
  b=KgPZcXQlsVlT3KG9BayhKUxlFquTJzIes1tvLzPcbx7cY0OeBl7bPmz4
   ZdVao1BCzyTKgZYRnh6GHEGszC8idm9UF7MXaHwgtgCZ3GuZq01G5fPis
   oBi1xNq7YidVRQCKpx3NH0DGdSoZVgRDQySjAf7jKuWrqTjKwtu7mJxcW
   35xnGGBtPdF2B6kD4/UmLMeTsv24vZQwe3/lvp+PEC3ReBtl3K91Z7DN2
   e/ukvyp05ngq/GeFnH35SfTntT3HKMd+HdJ47LxtTM2KNICtjJWRC4gny
   xxSZ09oNXiuToOdP8kfYSnKXGwUYBVtB6tw3imdjABucYzrdCO8hlaJMZ
   A==;
X-CSE-ConnectionGUID: ANF1zOSGTZi0TcQ46btqnA==
X-CSE-MsgGUID: 6TMq6R4hQm6wZF+epXSqZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="33100982"
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="33100982"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:42:26 -0700
X-CSE-ConnectionGUID: 39JrdeVASwO2wsLWySoSmA==
X-CSE-MsgGUID: Sq41damTR8uzPn3it21WSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,148,1719903600"; 
   d="scan'208";a="59553296"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.225.1]) ([10.124.225.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 23:42:23 -0700
Message-ID: <ad0b8f56-8613-44d1-b37a-d05e2a4f6529@linux.intel.com>
Date: Thu, 15 Aug 2024 14:42:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 1/5] perf x86/topdown: Complete topdown slots/metrics
 events check
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240712170339.185824-1-dapeng1.mi@linux.intel.com>
 <20240712170339.185824-2-dapeng1.mi@linux.intel.com> <ZroQ7wiw6JB-sjps@x1>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <ZroQ7wiw6JB-sjps@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/12/2024 9:41 PM, Arnaldo Carvalho de Melo wrote:
> On Fri, Jul 12, 2024 at 05:03:35PM +0000, Dapeng Mi wrote:
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
> Looks ok, I made a comment below, please take a look
>  
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/evlist.c  |  8 ++---
>>  tools/perf/arch/x86/util/evsel.c   |  3 +-
>>  tools/perf/arch/x86/util/topdown.c | 48 +++++++++++++++++++++++++++++-
>>  tools/perf/arch/x86/util/topdown.h |  2 ++
>>  4 files changed, 55 insertions(+), 6 deletions(-)
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
>> index 3f9a267d4501..49f25d67ed77 100644
>> --- a/tools/perf/arch/x86/util/topdown.c
>> +++ b/tools/perf/arch/x86/util/topdown.c
>> @@ -32,6 +32,52 @@ bool topdown_sys_has_perf_metrics(void)
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
>> +	if (!strcasestr(info->name, "topdown"))
>> +		return 0;
>> +
>> +	str = strcasestr(info->str, "event=");
>> +	if (str)
>> +		sscanf(str, "event=%x", &event);
>> +
>> +	str = strcasestr(info->str, "umask=");
>> +	if (str)
>> +		sscanf(str, "umask=%x", &umask);
>> +
>> +	if (event == 0 && *config == (event | umask << 8))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +bool arch_is_topdown_metrics(const struct evsel *evsel)
>> +{
>> +	struct perf_pmu *pmu = evsel__find_pmu(evsel);
>> +	int config = evsel->core.attr.config;
> Humm, can we cache this information? I.e. have some evsel->is_topdown:1
> bit to avoid having to traverse all events if we call this multiple
> times for the same evsel? 

Arnaldo, I tried to add a variable in evsel structure to represent if the
evsel is a topdown metrics event, but unfortunately the helper argument
"evsel" has "const" qualifier, it forces the "evsel" structure can't be
modified. If we want to add this optimization, the entire call-chain
functions have to be modified and this would reduce the security of code as
well. Since this helper is not in a performance critical patch, I suppose
it won't introduce too much performance hit as the traverse. I would drop
this optimization and keep the original code.


>
> - Arnaldo
>
>> +	if (!pmu || !pmu->is_core)
>> +		return false;
>> +
>> +	if (perf_pmu__for_each_event(pmu, false, &config,
>> +				     compare_topdown_event))
>> +		return true;
>> +
>> +	return false;
>> +}
>>  
>>  /*
>>   * Check whether a topdown group supports sample-read.
>> @@ -44,7 +90,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
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
>> -- 
>> 2.40.1
>>
