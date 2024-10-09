Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A218C34D;
	Wed,  9 Oct 2024 09:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467786; cv=none; b=YIl86go74bWdSUe7rQM05GmfsxlcxOw4kFi2mSZ1gJdZBZkaTe5+/GWkDj7Fv5Rx+fJ+BCrESvbLBt1bYVJSJBROtAz/Vvz3R/WfX+2j7W4dRpBTdt2ehUVsreftiESQVedatnT8PnjtRMmU1y2o5Nz/fosJqWxbBBR2H9lsWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467786; c=relaxed/simple;
	bh=y0d+4PRZlIm3w+alJ2H9M9+DXNCCvCfSAX/7MDPXZ7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hAMJ0Uzg398q1Wq49v/dD+hWRzODeiLJOf2HksbdY9C1sVTTK8VK6L69ubbhA9qkuQ8szgCCZ8xA0z4zSXo0iFbiO0NV7UqTABOtopSdVd88ZFt64+C3Lj7koXmnkKfdmijSq2HHRWCrf2Uaz0oei4Rd0v73y8y4YGqTCn/iruA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDiKCIHU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDiKCIHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728467785; x=1760003785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y0d+4PRZlIm3w+alJ2H9M9+DXNCCvCfSAX/7MDPXZ7Y=;
  b=aDiKCIHUGUkmtF+cZY7UgLUX+xT3wd8fIiyGbj7dBPo9+iYVeirCs+QD
   eg25JvH1O2JZOdKPMrkDFO820nSoc+aoU1GMOhIJdrcj5rwBiNLYkB37y
   bd0N5Y4mLZ7rsgLCF68VcbdSJ6FJpCi1PiWGmZ21wxSnmVDROcudmYkb5
   B1QjY79ZfPxf66/FZJv7UoTFluyaSGQRHkljGp8kQZoYg+nwAjZ6feFVz
   Mu3Y91sN3YVf78bY9XO2D2tAOfH+g7O7EyhieZ6TFESBWh8bS8/nAfQh0
   qY9l9QlvlAZpJA9IHskNVjtZsSV0S2b5Qbw4QhPrMKG0KzETHbjP/h3Ff
   Q==;
X-CSE-ConnectionGUID: i3k29aLBQqqEisehaDc+Jg==
X-CSE-MsgGUID: J4GfSRtwScq1FARVuedDxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="38323335"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="38323335"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:56:24 -0700
X-CSE-ConnectionGUID: 9gjHf5Y6RHuwEUCfNOrXDg==
X-CSE-MsgGUID: UIKRr/jmQeKCvsLje0KkLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76507538"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 02:56:21 -0700
Message-ID: <579b6865-7095-468b-8d36-210f9d4d93d8@linux.intel.com>
Date: Wed, 9 Oct 2024 17:56:18 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 1/6] perf x86/topdown: Complete topdown slots/metrics
 events check
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20240913084712.13861-1-dapeng1.mi@linux.intel.com>
 <20240913084712.13861-2-dapeng1.mi@linux.intel.com>
 <CAP-5=fVFe30xEt6JAg6rUTsAKZpg=7LBSQJSBd=BZszwufjFFw@mail.gmail.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <CAP-5=fVFe30xEt6JAg6rUTsAKZpg=7LBSQJSBd=BZszwufjFFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/8/2024 1:55 PM, Ian Rogers wrote:
> On Thu, Sep 12, 2024 at 10:21 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
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
>> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  tools/perf/arch/x86/util/evlist.c  |  8 ++---
>>  tools/perf/arch/x86/util/evsel.c   |  3 +-
>>  tools/perf/arch/x86/util/topdown.c | 48 +++++++++++++++++++++++++++++-
>>  tools/perf/arch/x86/util/topdown.h |  2 ++
>>  4 files changed, 55 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
>> index cebdd483149e..79799865a62a 100644
>> --- a/tools/perf/arch/x86/util/evlist.c
>> +++ b/tools/perf/arch/x86/util/evlist.c
>> @@ -78,14 +78,14 @@ int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
>>         if (topdown_sys_has_perf_metrics() &&
>>             (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
>>                 /* Ensure the topdown slots comes first. */
>> -               if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
>> +               if (arch_is_topdown_slots(lhs))
>>                         return -1;
>> -               if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
>> +               if (arch_is_topdown_slots(rhs))
>>                         return 1;
>>                 /* Followed by topdown events. */
>> -               if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
>> +               if (arch_is_topdown_metrics(lhs) && !arch_is_topdown_metrics(rhs))
>>                         return -1;
>> -               if (!strcasestr(lhs->name, "topdown") && strcasestr(rhs->name, "topdown"))
>> +               if (!arch_is_topdown_metrics(lhs) && arch_is_topdown_metrics(rhs))
>>                         return 1;
>>         }
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
>>             strcasestr(evsel->name, "uops_retired.slots"))
>>                 return false;
>>
>> -       return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
>> +       return arch_is_topdown_metrics(evsel) || arch_is_topdown_slots(evsel);
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
>>  #define TOPDOWN_SLOTS          0x0400
>> +bool arch_is_topdown_slots(const struct evsel *evsel)
>> +{
> Perhaps: assert(evsel__find_pmu(evsel)->is_core);

assert? we don't need an assert as this helper just detects if a evsel is
slots event and it's reasonable if the evsel is not. But it's nice to add
the is_core check. Thanks.


>
>> +       if (evsel->core.attr.config == TOPDOWN_SLOTS)
>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>> +static int compare_topdown_event(void *vstate, struct pmu_event_info *info)
>> +{
>> +       int *config = vstate;
>> +       int event = 0;
>> +       int umask = 0;
>> +       char *str;
>> +
>> +       if (!strcasestr(info->name, "topdown"))
>> +               return 0;
>> +
>> +       str = strcasestr(info->str, "event=");
>> +       if (str)
>> +               sscanf(str, "event=%x", &event);
>> +
>> +       str = strcasestr(info->str, "umask=");
>> +       if (str)
>> +               sscanf(str, "umask=%x", &umask);
>> +
>> +       if (event == 0 && *config == (event | umask << 8))
>> +               return 1;
>> +
>> +       return 0;
>> +}
>> +
>> +bool arch_is_topdown_metrics(const struct evsel *evsel)
>> +{
>> +       struct perf_pmu *pmu = evsel__find_pmu(evsel);
>> +       int config = evsel->core.attr.config;
>> +
>> +       if (!pmu || !pmu->is_core)
>> +               return false;
>> +
>> +       if (perf_pmu__for_each_event(pmu, false, &config,
>> +                                    compare_topdown_event))
>> +               return true;
>> +
>> +       return false;
>> +}
>
> Doing a linear search over every event is painful perf_pmu__have_event
> will try to binary search. The search rejects all events without
> "topdown" in their name, it then sees if the event code is 0 and the
> event|umask match the sysfs/json event. Is there ever a case the
> "topdown" string isn't at the beginning of the string? If it is it

Currently all topdown events would start with "topdown" prefix.


> should be possible to binary search to the start of the topdown
> events.
>
> Strictly you shouldn't hard code the config positions of event and
> umask, they are in the format list:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.h?h=perf-tools-next#n113
> There is code doing similar to this here:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next#n2285
> but it avoids the scanf, uses formats...
> It seems reasonable this code should reject all non-zero configs
> before searching all core PMU events. It could also use
> perf_pmu__name_from_config. So:
> ```
> bool evsel__is_topdown_metric_event(const struct evsel *evsel)
> {
>    struct perf_pmu *pmu;
>    const char *name_from_config;
>
>    if (evsel->core.attr.config & 0xFF != 0) /* All topdown events have
> an event code of 0. */
>      return false;
>
>   pmu  = evsel__find_pmu(evsel);
>   if (!pmu || !pmu->is_core)
>      return false;
>
>   name_from_config = perf_pmu__name_from_config(pmu, config);
>   return name_from_config && !strcasestr(name_from_config, "topdown);
> }
> ```

Good point! would cook a patch to implement this. Thanks.


> We could tweak perf_pmu__name_from_config to be pased a  "filter". In
> this case the filter would skip events without topdown in their name,
> without doing a config comparison.
>
> If later we change perf_pmu__name_from_config to say sort events in a
> list by config, then this code could take advantage of that. Perhaps
> for now there should just be an optional "prefix" that can be used to
> binary search to the events.
> ```
>   name_from_config = perf_pmu__name_from_config(pmu, config,
> /*prefix=*/"topdown");
> ```
>
> Thanks,
> Ian
>
>>  /*
>>   * Check whether a topdown group supports sample-read.
>> @@ -44,7 +90,7 @@ bool arch_topdown_sample_read(struct evsel *leader)
>>         if (!evsel__sys_has_perf_metrics(leader))
>>                 return false;
>>
>> -       if (leader->core.attr.config == TOPDOWN_SLOTS)
>> +       if (arch_is_topdown_slots(leader))
>>                 return true;
>>
>>         return false;
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
