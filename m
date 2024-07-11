Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2ED15ECF9;
	Thu, 11 Jul 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720704913; cv=none; b=TLKgxVVKl/0YhXzzgjzEDV87jHiiL4BONbJlQlja9fvj3vVIr7xuct4PAv13l6KYupkAK/vm32Q/s3iyj2wrHhUCrCwSHzOWi7BjzDHbwdo2FanX9ioQ4iiK2dCU+/e1v/hrxQI0SmFjH8W0LJLEr4bWb9S0mCrgoZWRT11kv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720704913; c=relaxed/simple;
	bh=OD2Bzez/EdF1VxOldLtWBo8U+HaxjGLihzIL1aGCZ08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSATOKx0T3IeUtCuGppNhErRS+CvgTpLxTCmpPW4cJwr1MReNytpDYPvkgr7fm+9vV1iuDRM0nHGEthlxcoiIB9s4dXFNZazyVNqkpL7VtoAxLpomEg5eiK21a4ZhggGoTOzyAqN+KvGmf+tNKRxkbZq3ubkvFbWDC8QrTQPbj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfbvXzOq; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfbvXzOq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720704912; x=1752240912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OD2Bzez/EdF1VxOldLtWBo8U+HaxjGLihzIL1aGCZ08=;
  b=hfbvXzOqYAA1K/ZOzNXYx9dw+/umB5fFcL0wxCWOep+RNKOFbPoZdG1L
   TlcmxRGM0TtSa6HH7NjEtvcCcqU7gfFdtZiRzlMh74Eeh5gO86VqS7UG6
   fJo/M0oEE4JQN3phIPArybvFrfzQ1vGIhqsdFEE2KJUxZ9cxUo5ta4daa
   OACpSjNz++jLV+LfIM4oThRgxECwjRCh0DErui4d3ZNM+GUlfZB3Xyk1f
   bUsHij61X7M2K0y2hc0eh4e+vMV+kbWVTxiUAmh9iJa64erzGdtRuX3R7
   VSfvYSSzEyuFol10snQKDb4DR6EoXgCG5B4Ud3oKt61IUtUeNxF7/J8rK
   Q==;
X-CSE-ConnectionGUID: sGXTH4RoST2gpVXD2iJrsw==
X-CSE-MsgGUID: kQ+9MEPWQJW+082UXa3tCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="21954127"
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="21954127"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:35:11 -0700
X-CSE-ConnectionGUID: P8VmrkU6Tc2PskZJh5XJoQ==
X-CSE-MsgGUID: 4SGWfoqqR3KNPsv0O7ruoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,200,1716274800"; 
   d="scan'208";a="48526837"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.94.249.84])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2024 06:35:05 -0700
Message-ID: <0c59b36f-9b83-475f-b3b2-7fe3649412f4@intel.com>
Date: Thu, 11 Jul 2024 16:35:00 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V8 02/12] perf/x86/intel/pt: Add support for pause /
 resume
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
References: <20240628065111.59718-1-adrian.hunter@intel.com>
 <20240628065111.59718-3-adrian.hunter@intel.com>
 <20240701104659.GB20127@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240701104659.GB20127@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/07/24 13:46, Peter Zijlstra wrote:
> On Fri, Jun 28, 2024 at 09:51:01AM +0300, Adrian Hunter wrote:
> 
>> @@ -534,7 +537,20 @@ static void pt_config(struct perf_event *event)
>>  	reg |= (event->attr.config & PT_CONFIG_MASK);
>>  
>>  	event->hw.config = reg;
>> +
>> +	/*
>> +	 * Allow resume before starting so as not to overwrite a value set by a
>> +	 * PMI.
>> +	 */
>> +	WRITE_ONCE(pt->resume_allowed, 1);
> 	barrier();
>>  	pt_config_start(event);
> 	barrier();
>> +	/*
>> +	 * Allow pause after starting so its pt_config_stop() doesn't race with
>> +	 * pt_config_start().
>> +	 */
>> +	WRITE_ONCE(pt->pause_allowed, 1);
> 
> IIRC you need those barrier()s, because if the compiler 'helpfully'
> inlines the static pt_config_start(), you loose your sequence point and
> things can get re-ordered. WRITE_ONCE() only ensures the store is whole
> and ordered against other volatile ops, but not against much else.

Yes barriers are needed.  gcc even says:

	...an implementation is free to reorder and combine volatile
	accesses that occur between sequence points...

	Accesses to non-volatile objects are not ordered with respect
	to volatile accesses.

	https://gcc.gnu.org/onlinedocs/gcc/Volatiles.html

> 
>>  }
>>  
>>  static void pt_config_stop(struct perf_event *event)
>> @@ -1511,6 +1527,7 @@ void intel_pt_interrupt(void)
>>  		buf = perf_aux_output_begin(&pt->handle, event);
>>  		if (!buf) {
>>  			event->hw.state = PERF_HES_STOPPED;
>> +			pt->resume_allowed = 0;
>>  			return;
>>  		}
>>  
>> @@ -1519,6 +1536,7 @@ void intel_pt_interrupt(void)
>>  		ret = pt_buffer_reset_markers(buf, &pt->handle);
>>  		if (ret) {
>>  			perf_aux_output_end(&pt->handle, 0);
>> +			pt->resume_allowed = 0;
>>  			return;
>>  		}
>>  
> 
> Above you WRITE_ONCE() on ->resume_allowed, here you do not. Some *SAN
> thing or other is bound to get upset about things like that.
> 
>> @@ -1573,6 +1591,26 @@ static void pt_event_start(struct perf_event *event, int mode)
>>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>>  	struct pt_buffer *buf;
>>  
>> +	if (mode & PERF_EF_RESUME) {
>> +		if (READ_ONCE(pt->resume_allowed)) {
> 
> At this point I seem to have lost the plot, how do ->resume_allowed and
> ->aux_paused interact?

This is assuming there is no guaranteed order that events
in the group are started / stopped, so there is a need to
protect against pt being resumed when it is not yet configured,
or when it is in the process of being stopped.

Updates to event->hw.state don't happen at quite the right
places to be used instead, and the needs of resume are slightly
different to pause.

resume_allowed means pt is configured and so ->start(PERF_EF_RESUME)
can actually safely start pt. aux_paused is separate and takes
effect when there is a regular start.

> 
>> +			u64 status;
>> +
>> +			/*
>> +			 * Only if the trace is not active and the error and
>> +			 * stopped bits are clear, is it safe to start, but a
>> +			 * PMI might have just cleared these, so resume_allowed
>> +			 * must be checked again also.
>> +			 */
>> +			rdmsrl(MSR_IA32_RTIT_STATUS, status);
>> +			if (!(status & (RTIT_STATUS_TRIGGEREN |
>> +					RTIT_STATUS_ERROR |
>> +					RTIT_STATUS_STOPPED)) &&
>> +			   READ_ONCE(pt->resume_allowed))
>> +				pt_config_start(event);
>> +		}
>> +		return;
>> +	}
>> +
>>  	buf = perf_aux_output_begin(&pt->handle, event);
>>  	if (!buf)
>>  		goto fail_stop;
>> @@ -1601,6 +1639,16 @@ static void pt_event_stop(struct perf_event *event, int mode)
>>  {
>>  	struct pt *pt = this_cpu_ptr(&pt_ctx);
>>  
>> +	if (mode & PERF_EF_PAUSE) {
>> +		if (READ_ONCE(pt->pause_allowed))
>> +			pt_config_stop(event);
>> +		return;
>> +	}
>> +
>> +	/* Protect against racing */
> 
> No F1 cars allowed? Sure the comment can elucidate the reader as to what
> actual race one is concerned about, no?

Yeah this needs more comments.

> 
>> +	WRITE_ONCE(pt->pause_allowed, 0);
>> +	WRITE_ONCE(pt->resume_allowed, 0);
>> +
>>  	/*
>>  	 * Protect against the PMI racing with disabling wrmsr,
>>  	 * see comment in intel_pt_interrupt().
>> @@ -1659,8 +1707,12 @@ static long pt_event_snapshot_aux(struct perf_event *event,
>>  	/*
>>  	 * Here, handle_nmi tells us if the tracing is on
>>  	 */
>> -	if (READ_ONCE(pt->handle_nmi))
>> +	if (READ_ONCE(pt->handle_nmi)) {
>> +		/* Protect against racing */
>> +		WRITE_ONCE(pt->pause_allowed, 0);
>> +		WRITE_ONCE(pt->resume_allowed, 0);
> 
> barrier()?
> 
>>  		pt_config_stop(event);
>> +	}
>>  
>>  	pt_read_offset(buf);
>>  	pt_update_head(pt);
>> @@ -1677,8 +1729,11 @@ static long pt_event_snapshot_aux(struct perf_event *event,
>>  	 * Compiler barrier not needed as we couldn't have been
>>  	 * preempted by anything that touches pt->handle_nmi.
>>  	 */
>> -	if (pt->handle_nmi)
>> +	if (pt->handle_nmi) {
>> +		WRITE_ONCE(pt->resume_allowed, 1);
>>  		pt_config_start(event);
>> +		WRITE_ONCE(pt->pause_allowed, 1);
> 
> barrier() went missing again?
> 
>> +	}
>>  
>>  	return ret;
>>  }

