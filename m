Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD2D7D3EF;
	Thu, 18 Jul 2024 11:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721301557; cv=none; b=K/7Be9wGpwm59iW/r+J9Iw/hX/dOlf/fN17D+Ie0ArHl28IzmjbKS5ICnWbxGUmJ9u1mdsouRgoNRPOfnOvg2v0hBYYGPQDg/QS0eEdKeVxrtIo1U3xUoSH6NV0q5hwNZ4J96wUTAKTXf4hrzyTIkJePOdRizKvGB780SWwikYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721301557; c=relaxed/simple;
	bh=0AhJ90EdbnHIUUwth+DAtYzqSMzjIxsaALpFpmPbiqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJ05TELobTYlDdmVuK6hkSla0tEjHo4o3niEN+psNwq/UD1FOkEeZKk645+SlcCM3/ulkGqgYuLt0leqnjg9cFoC8nTKzHFOE0JgLMm5KyHX122UwTSPVN38TEKQmZGJ0oPvnRcKMlhVNSJc2DXyEOv6aetLsio7HEH4KaRShxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jCskHelQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jCskHelQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721301555; x=1752837555;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0AhJ90EdbnHIUUwth+DAtYzqSMzjIxsaALpFpmPbiqM=;
  b=jCskHelQB4AjDzA99hpp25Hb9v4wYfpE85Qi6AZpxlrQ2tlTay4Venk4
   v/b6k8XhJkS3qwxdD58zwkx4K33DRTOZIeu2tdP5N5+hbNtOmtBiM8WwV
   AhKuiTQqbQ50AO4WoVVNkSy+aEjjjYm2redUiSECGhc6RAS2eY+qadzjn
   hm9Lh2xiHqSybdhNGK7GRiXjz+RzZ8mxuT6cbPT/AcMJQsAGFRK8NtLUr
   Qsj+GFwwPS7jXKbSfWD1hS7wQWiAf8tnkf6hNqktKou58WwW5u9ZQMpGY
   v8kVZUq4TtOZwITUFuIqv9lB1PTse+cq3ndtL22ncT0bkJH906kUfSRYA
   w==;
X-CSE-ConnectionGUID: zlP5ul13SOuwVz3MSOeJXA==
X-CSE-MsgGUID: BlaPC0beQw6JilTF9KZMIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="30243872"
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="30243872"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 04:19:15 -0700
X-CSE-ConnectionGUID: sYHOG/iRSZO0WsTnDjF1Bw==
X-CSE-MsgGUID: QwXKpOj7RLeR8oUvmJ6iyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,217,1716274800"; 
   d="scan'208";a="88216115"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 04:19:08 -0700
Message-ID: <14cd68b2-eeee-42e3-87a6-c12d3814bd51@intel.com>
Date: Thu, 18 Jul 2024 14:19:03 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 02/13] perf/core: Add aux_pause, aux_resume,
 aux_start_paused
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240715160712.127117-1-adrian.hunter@intel.com>
 <20240715160712.127117-3-adrian.hunter@intel.com>
 <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240718093846.GJ26750@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/24 12:38, Peter Zijlstra wrote:
> On Mon, Jul 15, 2024 at 07:07:01PM +0300, Adrian Hunter wrote:
>> Hardware traces, such as instruction traces, can produce a vast amount of
>> trace data, so being able to reduce tracing to more specific circumstances
>> can be useful.
>>
>> The ability to pause or resume tracing when another event happens, can do
>> that.
>>
>> Add ability for an event to "pause" or "resume" AUX area tracing.
>>
>> Add aux_pause bit to perf_event_attr to indicate that, if the event
>> happens, the associated AUX area tracing should be paused. Ditto
>> aux_resume. Do not allow aux_pause and aux_resume to be set together.
>>
>> Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
>> event that it should start in a "paused" state.
>>
>> Add aux_paused to struct hw_perf_event for AUX area events to keep track of
>> the "paused" state. aux_paused is initialized to aux_start_paused.
>>
>> Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
>> callbacks. Call as needed, during __perf_event_output(). Add
> 
> Why in __perf_event_output() rather than in __perf_event_overflow().
> Specifically, before bpf_overflow_handler().
> 
> That is, what do we want BPF to be able to do here? To me it seems
> strange that BPF would be able to affect this functionality. You want
> this pause/resume to happen irrespective of how the rest of the event is
> processed, no?

The thought was to have the output match up with pause/resume, but it
doesn't really make much difference.

Putting it before the BPF handler is reasonable.

> 
>> aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
>> handler. Pause/resume in NMI context will miss out if it coincides with
>> another pause/resume.
> 
> I'm struggling here. That variable is only ever used inside that one
> function. So it must be self-recursion. Are you thinking something like:
> 
>   swevent_overflow()
>     ...
>       event_aux_pause()
>         <NMI>
> 	  event_overflow()
> 	    ...
> 	      event_aux_pause()
> 
> ?
> 
> Where two events in the group, one software and one hardware, are both
> trying to control the AUX thing?

Exactly that yes.

>                                  Because I don't think the PT-PMI ever
> gets here.

No it doesn't.  AUX pause/resume is something a non-AUX event in the
group does to the AUX event which is the group leader.

> 
>> To use aux_pause or aux_resume, an event must be in a group with the AUX
>> area event as the group leader.
> 
> 
>> @@ -402,6 +411,15 @@ struct pmu {
>>  	 *
>>  	 * ->start() with PERF_EF_RELOAD will reprogram the counter
>>  	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
>> +	 *
>> +	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
>> +	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
>> +	 * PERF_EF_RESUME.
>> +	 *
>> +	 * ->start() with PERF_EF_RESUME will start as simply as possible but
>> +	 * only if the counter is not otherwise stopped. Will not overlap
>> +	 * another ->start() with PERF_EF_RESUME nor ->stop() with
>> +	 * PERF_EF_PAUSE.
>>  	 */
>>  	void (*start)			(struct perf_event *event, int flags);
>>  	void (*stop)			(struct perf_event *event, int flags);
> 
> Notably, they *can* race with ->stop/start without EF_PAUSE/RESUME.

Yes that would be worth adding to the comments.

