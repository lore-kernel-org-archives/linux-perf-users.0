Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B61459FA;
	Thu, 23 Oct 2025 01:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761181572; cv=none; b=CUL8N24aKPfDe/c7kYy32AGT8IU6Zv3qzbESWVGW1M+WAn+TG7w0aW3XQHVcARewPTKa61up0CzG/oHoMUalWD27AF+eOCgTQv/TUiGRlDBs9fBrYk/aZ/J/HVTOQ/9k5/WkeoI3bUq6QLStreHJE8rMdkNx/z5IbjZMnwbNueQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761181572; c=relaxed/simple;
	bh=ZX8m9kjrcUsYyQ4FD1d3RvxC2stOsNoYQXsteKbBNFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIINTxlMAGBkiU83Btrxe+hycwQi41qRAisSVZNPnB2sP4YpCH95pnukPvvcu7UzLDgzzKrZ2N8+/GFbUgAZa9WiTgJZKEGLaHrvtZDtltdcgfXxzkR/8uTyofFKHG9d2vmwPCw8US0BXcW+6FmlIBFCdwdgWfua9V7vkxxT4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mzyvGlSC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mzyvGlSC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761181571; x=1792717571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZX8m9kjrcUsYyQ4FD1d3RvxC2stOsNoYQXsteKbBNFY=;
  b=mzyvGlSCPeGmMVmxUJ2REx/XsLw5azJeq4jAPmLH54M9oazLu8wZry0Q
   6tl+onBYh8hJgoUESVHOq/3lbpJag+4AXnlJGefzVwgHPBi6s+o39+yzF
   rrJWuZ+7OK9JgiPhELOpiZg8BGzelXdg2aMf9oEJh1LayJWPla2tyK8OJ
   qElJpwg1pl19QPAKe/wzxvTCtGPRZp4HrYCeecQhX0b3biUMYjN+9F85U
   4S/4uMy1fM68r5uyyMezHlUmOTKc9evLhLd3yhrMBUME2CVWr1xZ4sQRF
   CzOClPBlDFrcs6SdttuoacXeQs7rsq2D5OtIcLjakTtGU1RoijMmUTTCv
   w==;
X-CSE-ConnectionGUID: 01QDCCPtTq+aqrLlfQ80/Q==
X-CSE-MsgGUID: asjRoc7OR2ac6jZOra7JQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74011897"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="74011897"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 18:06:10 -0700
X-CSE-ConnectionGUID: AXYumXuaSe6WYUf7DnY38A==
X-CSE-MsgGUID: ELne1++VRIG5BqpWAxOnnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="188306021"
Received: from unknown (HELO [10.238.3.234]) ([10.238.3.234])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 18:06:06 -0700
Message-ID: <e9fd0e89-03ca-4c67-aee6-9d1d2937269c@linux.intel.com>
Date: Thu, 23 Oct 2025 09:06:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 06/12] perf/x86/intel/ds: Factor out PEBS record
 processing code to functions
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-7-dapeng1.mi@linux.intel.com>
 <20251022114917.GT3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251022114917.GT3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/22/2025 7:49 PM, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 02:44:16PM +0800, Dapeng Mi wrote:
>> Beside some PEBS record layout difference, arch-PEBS can share most of
>> PEBS record processing code with adaptive PEBS. Thus, factor out these
>> common processing code to independent inline functions, so they can be
>> reused by subsequent arch-PEBS handler.
>>
>> Suggested-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/ds.c | 101 ++++++++++++++++++++++++-------------
>>  1 file changed, 66 insertions(+), 35 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index a80881a20321..41acbf0a11c9 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -2629,6 +2629,64 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>>  	}
>>  }
>>  
>> +static inline void __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
>> +						  struct pt_regs *regs,
>> +						  struct perf_sample_data *data,
>> +						  void *at, u64 pebs_status,
>> +						  struct perf_event *events[],
>> +						  short *counts, void **last,
>> +						  setup_fn setup_sample)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	struct perf_event *event;
>> +	int bit;
>> +
>> +	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
>> +		event = cpuc->events[bit];
>> +
>> +		if (WARN_ON_ONCE(!event) ||
>> +		    WARN_ON_ONCE(!event->attr.precise_ip))
>> +			continue;
>> +
>> +		if (counts[bit]++)
>> +			__intel_pmu_pebs_event(event, iregs, regs, data,
>> +					       last[bit], setup_sample);
>> +
>> +		last[bit] = at;
>> +		/*
>> +		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
>> +		 * could trigger interrupt throttle and clear all event pointers of
>> +		 * the group in cpuc->events[] to NULL. So snapshot the event[] before
>> +		 * it could be cleared. This avoids the possible NULL event pointer
>> +		 * access and PEBS record loss.
>> +		 */
>> +		if (counts[bit] && !events[bit])
>> +			events[bit] = cpuc->events[bit];
>> +	}
>> +}
>> +
>> +static inline void
>> +__intel_pmu_handle_last_pebs_record(struct pt_regs *iregs, struct pt_regs *regs,
>> +				    struct perf_sample_data *data, u64 mask,
>> +				    struct perf_event *events[],
>> +				    short *counts, void **last,
>> +				    setup_fn setup_sample)
>> +{
>> +	struct perf_event *event;
>> +	int bit;
>> +
>> +	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
>> +		if (!counts[bit])
>> +			continue;
>> +
>> +		event = events[bit];
>> +
>> +		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
>> +					    counts[bit], setup_sample);
>> +	}
>> +
>> +}
> These need to be __always_inline, like the other functions that take
> setup_fn. Otherwise the compiler might decide to not inline and then it
> can't constant propagate this function and we get indirect calls.

Indeed. Would change it. Thanks.


>
>
