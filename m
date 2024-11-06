Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191615383D;
	Wed,  6 Nov 2024 16:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730911621; cv=none; b=pONZmZ3NJOKwpSjDnMf0HCYJNhgOC9nxCYu39ScPjacuNtK4BSsixyVrmzLqc5apxsw/QnaGEgPDPnlJG5ii5YpDHdme0/OcyoLqSsJZA2/0Vq+m2i+PXqz44mR6x0pqjrgqFUDUAwwmEXrkJDhTLzssyNI3obHxkvN8cG0v9n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730911621; c=relaxed/simple;
	bh=f4kpoM+UckIWIVsdIZs5+Y5ZMUcHWZ7ptKWmdXVHOhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MrC67tQ2JmsZ5p99iY627orgUZ2EpRlYJNSsmKlTwCFf5POFyN4y+oXT7k4dS9IBrl4ak1kfYiccJBSuff1dfE0eEqhuoM98xWQE9JHDFfAtS8ONla5pIBG/E7JbbO9TdvcIQO3NkksLVrF3i7512e0AOP+hOHAEqRSP6hBG6OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZCM56cfg; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZCM56cfg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730911620; x=1762447620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f4kpoM+UckIWIVsdIZs5+Y5ZMUcHWZ7ptKWmdXVHOhU=;
  b=ZCM56cfgcEqBe1QKX71k7Q1Gnc+6ELv0J6lkhcsQ8wzq5KwvHZr6E/GD
   IFvsFBzwWJT578wsGOwSF9BNpNvMpb3/JWjV/zKcHx1UQ+Gcdgl4MnFRK
   EwZrIZIPthw7VlywQXk0akwDEWIz1PX1Ub7GhFuuzg2Z8N7+s7en/5RAY
   BJ1CMkQLwvIZSjzfQtO0qnS/6C4rt2cRDFUEA7QgcBIMmGZY2jt9Vjjuu
   YuIBWpXdVkznDc6VtpcaknX5TFATREKawjTkRWIbvv/Mk1XBiXgb3DExu
   3r19lW8rRCOAavk0ZAWj3XCKN/Ro5asvIU2xiRMsGkHWfqwSxYZV7gxJF
   w==;
X-CSE-ConnectionGUID: toPvrb4hQzOuuqm69irieA==
X-CSE-MsgGUID: TvB6JlAvTqa97BeAGscwIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="41341604"
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="41341604"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:47:00 -0800
X-CSE-ConnectionGUID: cVcVBIRQQ3qhN4SjFJ4J3Q==
X-CSE-MsgGUID: dNcRJR1qRveZXL8BCSBObg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,263,1725346800"; 
   d="scan'208";a="89499895"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2024 08:46:59 -0800
Received: from [10.212.82.230] (kliang2-mobl1.ccr.corp.intel.com [10.212.82.230])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 6CDCF20C0667;
	Wed,  6 Nov 2024 08:46:57 -0800 (PST)
Message-ID: <07ee39aa-309f-4414-aee0-cc5b86a66af7@linux.intel.com>
Date: Wed, 6 Nov 2024 11:46:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/22] Python generated Intel metrics
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Perry Taylor <perry.taylor@intel.com>, Samantha Alt
 <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>,
 Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
References: <20240926175035.408668-1-irogers@google.com>
 <bbbd024c-d2df-47ea-9587-f68e5bc45962@linux.intel.com>
 <CAP-5=fVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2bebNcGYTg@mail.gmail.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <CAP-5=fVX5wypmAAhR8LsE4nSWp5BmN_qhGf9+WCh2bebNcGYTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-10-09 12:02 p.m., Ian Rogers wrote:
> On Fri, Sep 27, 2024 at 11:34 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
>>
>>
>>
>> On 2024-09-26 1:50 p.m., Ian Rogers wrote:
>>> Generate twenty sets of additional metrics for Intel. Rapl and Idle
>>> metrics aren't specific to Intel but are placed here for ease and
>>> convenience. Smi and tsx metrics are added so they can be dropped from
>>> the per model json files.
>>
>> Are Smi and tsx metrics the only two metrics who's duplicate metrics in
>> the json files will be dropped?
> 
> Yes. These metrics with their runtime detection and use of sysfs event
> names I feel more naturally fit here rather than in the Intel perfmon
> github converter script.
> 
>> It sounds like there will be many duplicate metrics in perf list, right?
> 
> That's not the goal. There may be memory bandwidth computed in
> different ways, like TMA and using uncore, but that seems okay as the
> metrics are using different counters so may say different things. I
> think there is an action to always watch the metrics and ensure
> duplicates don't occur, but some duplication can be beneficial.


Can we give a common prefix for all the automatically generated metrics,
e.g., general_ or std_?
As you said, there may be different metrics to calculate the same thing.

With a common prefix, we can clearly understand where the metrics is
from. In case, there are any issues found later for some metrics. I can
tell the end user to use either the TMA metrics or the automatically
generated metrics.
If they count the same thing, the main body of the metric name should be
the same.

Thanks,
Kan

> 
>> Also, is it an attempt to define some architectural metrics for perf?
> 
> There are many advantages of using python to generate the metric json,
> a few are:
> 1) we verify the metrics use events from the event json,
> 2) the error prone escaping of commas and slashes is handled by the python,
> 3) metric expressions can be spread over multiple lines and have comments.
> It is also an advantage that we can avoid copy-pasting one metric from
> one architectural metric json to another. This helps propagate fixes.
> 
> So, it's not so much a goal to have architectural metrics but its nice
> that we avoid copy-paste. Somewhere where I've tried to set up common
> events across all architectures is with making tool have its own PMU.
> Rather than have the tool PMU describe events using custom code it
> just reuses the existing PMU json support:
> https://github.com/googleprodkernel/linux-perf/blob/google_tools_master/tools/perf/pmu-events/arch/common/common/tool.json
> 
>> How do you decide which metrics should be added here?
> 
> The goal is to try to make open source metrics that Google has
> internally. I've set up a git repo for this here:
> https://github.com/googleprodkernel/linux-perf
> Often the source of the metric is Intel's documentation on things like
> uncore events, it's just such metrics aren't part of the perfmon
> process and so we're adding them here. Were all these metrics on the
> Intel github it'd be reasonable to remove them from here. If Intel
> would like to work on or contribute some metrics here, that's also
> fine. I think the main thing is to be giving users useful metrics.
> 
> Thanks,
> Ian
> 
>>> There are four uncore sets of metrics and
>>> eleven core metrics. Add a CheckPmu function to metric to simplify
>>> detecting the presence of hybrid PMUs in events. Metrics with
>>> experimental events are flagged as experimental in their description.
>>>
>>> The patches should be applied on top of:
>>> https://lore.kernel.org/lkml/20240926174101.406874-1-irogers@google.com/
>>>
>>> v4. Experimental metric descriptions. Add mesh bandwidth metric. Rebase.
>>> v3. Swap tsx and CheckPMU patches that were in the wrong order. Some
>>>     minor code cleanup changes. Drop reference to merged fix for
>>>     umasks/occ_sel in PCU events and for cstate metrics.
>>> v2. Drop the cycles breakdown in favor of having it as a common
>>>     metric, spelling and other improvements suggested by Kan Liang
>>>     <kan.liang@linux.intel.com>.
>>>
>>> Ian Rogers (22):
>>>   perf jevents: Add RAPL metrics for all Intel models
>>>   perf jevents: Add idle metric for Intel models
>>>   perf jevents: Add smi metric group for Intel models
>>>   perf jevents: Add CheckPmu to see if a PMU is in loaded json events
>>>   perf jevents: Mark metrics with experimental events as experimental
>>>   perf jevents: Add tsx metric group for Intel models
>>>   perf jevents: Add br metric group for branch statistics on Intel
>>>   perf jevents: Add software prefetch (swpf) metric group for Intel
>>>   perf jevents: Add ports metric group giving utilization on Intel
>>>   perf jevents: Add L2 metrics for Intel
>>>   perf jevents: Add load store breakdown metrics ldst for Intel
>>>   perf jevents: Add ILP metrics for Intel
>>>   perf jevents: Add context switch metrics for Intel
>>>   perf jevents: Add FPU metrics for Intel
>>>   perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
>>>   perf jevents: Add mem_bw metric for Intel
>>>   perf jevents: Add local/remote "mem" breakdown metrics for Intel
>>>   perf jevents: Add dir breakdown metrics for Intel
>>>   perf jevents: Add C-State metrics from the PCU PMU for Intel
>>>   perf jevents: Add local/remote miss latency metrics for Intel
>>>   perf jevents: Add upi_bw metric for Intel
>>>   perf jevents: Add mesh bandwidth saturation metric for Intel
>>>
>>>  tools/perf/pmu-events/intel_metrics.py | 1046 +++++++++++++++++++++++-
>>>  tools/perf/pmu-events/metric.py        |   52 ++
>>>  2 files changed, 1095 insertions(+), 3 deletions(-)
>>>

