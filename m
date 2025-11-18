Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CD02BE644;
	Tue, 18 Nov 2025 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464955; cv=none; b=UAeNSedeze1N/WJx6I38xEcIAIy2GRBq4IH1ww7vJqBvmEMMslInUPH2jWA73fz5ZxCJfebJl8YfOiXFa/8IfFjq0HQy52ca2dYPBLTJ+AQvOgjS/JSmyO4D1qGlSm6cVhFE+I5hv1iwKHlOm4Mhf3P9dpRSwsAIBvrm+ElXT7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464955; c=relaxed/simple;
	bh=XcPTj8O6i84df0epizn8R0b7mWSC6hLRdTGzhWuFChA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XgR9exuBkNHZWDgiSUDm6yIkYRwiivPgk85tJRsCKKOgtnBEiI9DEy6RRUBmb5V2SKb9qjwziPsqp+Rjz0XzNfpvboOg0MuuY2QpGmD/hiku/5rIj8mKmyJTJIuIhYV29DsbaNiBBnzFnF0H6ZDrvVzfvdD5vaEL79KwD7JJwXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IVPI6tUW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IVPI6tUW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763464954; x=1795000954;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XcPTj8O6i84df0epizn8R0b7mWSC6hLRdTGzhWuFChA=;
  b=IVPI6tUWCxR1cYQi/3oTLboY+S1/jhggmah/DLYb4Vi7Pv2MkHi0rHOg
   DJIAjEscjqKEyewUV0E/aMj2UGK3sz954cNgsbDCLDrgfSOOaLk5sHt9b
   X75eEvQ8zmb5nQAjIasZmwu0/+kKXDTzNcu+756zk7cuwMWP3E/Mpznwv
   alcb8ttuSnPFIxku1NlOVH5BcJ9DquB+5vt4fXR5hvfRSrSnIj5L/7GxF
   HOLjP7GEMstPEAwzSk3zj+ElXN7NrT1yYi8ZleRkWBJqpKAmVTubVndVq
   1qY6/50vdDHns2ezFNHGgthmocRqVSWlq0Dc6fMF7oTtWRS1z/sZB5g9A
   w==;
X-CSE-ConnectionGUID: 18SD1lkQSiqYl4tKsmm5yQ==
X-CSE-MsgGUID: Ic8gkgynQ7KzOzDsYfCNPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="65414375"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="65414375"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 03:22:32 -0800
X-CSE-ConnectionGUID: +m502a7QQImov0dHMYxTbA==
X-CSE-MsgGUID: +SLceNaBQWuQjelYYKboCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191173168"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.213]) ([10.124.240.213])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 03:22:27 -0800
Message-ID: <baf8aceb-5caa-4c3b-80f0-43a4a1449a23@linux.intel.com>
Date: Tue, 18 Nov 2025 19:22:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: Fix 0 count issue of cpu-clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20251112080526.3971392-1-dapeng1.mi@linux.intel.com>
 <20251118110309.GP3245006@noisy.programming.kicks-ass.net>
 <20251118110417.GI4068168@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251118110417.GI4068168@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/18/2025 7:04 PM, Peter Zijlstra wrote:
> On Tue, Nov 18, 2025 at 12:03:09PM +0100, Peter Zijlstra wrote:
>> On Wed, Nov 12, 2025 at 04:05:26PM +0800, Dapeng Mi wrote:
>>
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index f6a08c73f783..77d3af5959c1 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -11964,7 +11964,7 @@ static int cpu_clock_event_add(struct perf_event *event, int flags)
>>>  
>>>  static void cpu_clock_event_del(struct perf_event *event, int flags)
>>>  {
>>> -	cpu_clock_event_stop(event, flags);
>>> +	cpu_clock_event_stop(event, flags | PERF_EF_UPDATE);
>>>  }
>>>  
>>>  static void cpu_clock_event_read(struct perf_event *event)
>>> @@ -12043,7 +12043,7 @@ static int task_clock_event_add(struct perf_event *event, int flags)
>>>  
>>>  static void task_clock_event_del(struct perf_event *event, int flags)
>>>  {
>>> -	task_clock_event_stop(event, PERF_EF_UPDATE);
>>> +	task_clock_event_stop(event, flags | PERF_EF_UPDATE);
>>>  }
>> I think it can both just be: PERF_EF_UPDATE. The only pmu::del() caller
>> hands in flags=0, but if there were to be flags added, we'd have to
>> audit all del methods anyway.
>>
>> Also, the few comments we do have already note that ->del() must do
>> ->stop(EF_UPDATE).
> Updated patch now sits in queue/perf/urgent.

Hi Peter,

Thanks for merging. If we decide not to or the "flags", then the last
sentence "Besides, or flags with PERF_EF_UPDATE for task-clock although
currently the flags argument would always be 0." in the commit message
should be dropped as well. :)

https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?h=perf/urgent&id=cfaecad27435b4eb6a22bb9d008fec4984e03a21

Thanks,

Dapeng Mi

