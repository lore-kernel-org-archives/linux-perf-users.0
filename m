Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C33026059D;
	Wed, 11 Feb 2026 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770788870; cv=none; b=j/1cG9rHojw3LII3HX/y1Ufjx0BJxT5w+wIzFr/2O3c//MJfVbCyRN7CzeS7xXjAjri+x3ewLwdUz/oq9Def+pZD2CUCae3ICBsbZHbtnv2vQIB3hk4VU7TDyKx+FuX+QqsV2DmqeCqt5aeJeliTvXm/pxYFD8pBcRySKrdAfuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770788870; c=relaxed/simple;
	bh=4jRjiu5zKQfiZkAkZWwruDQKtnbpnRMxjOMw+V1lzPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JGKV0fCFn2lUiqCmFuS/U8ZmQK2xRAmeO68pQ1LnNu0GuHfkmWd2ciR0Df035+8rIjsQrXBPgdux0xZZqznfyouSjMt7adFo3oAmiAxqMN4cZL2q8UadJ8JOPkp0xvA6LesBqD2unD3QFSFIvE6a7g9E7+gJhesRNPqDOcnLqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cdhwFbS3; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cdhwFbS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770788869; x=1802324869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4jRjiu5zKQfiZkAkZWwruDQKtnbpnRMxjOMw+V1lzPI=;
  b=cdhwFbS3HUDMMbmYyPxeDcuc7zLmdi+SLBGrEurmNmhAtXnHu401ArEz
   BelG4xforZpsXVjvBP68yBenmGdlwKHw7qZcKAEAAoA8fwazsJxSbPbUy
   iADaaeXMXfLGquhQQisMDVmvRvn6SR1GCFYEb/Gn0AW+fuJfP56gHzCSJ
   QvBpKUvCQgYxjUr/RoRy1yinP1w0gHaLKQ6cjEjOsDdTiNwkEplFsrs3+
   utUwl6S8AdB/JdYow9z7EUFM4znWR6oGuGjarMZDnfOW2yukAkWh/s5iu
   oCpxE69bgsizqpR6Rbbz5EZ/8yC1qMp3rCbcFwFCq3vyyEoSBaU48Jff7
   w==;
X-CSE-ConnectionGUID: HxbEr59FTDyYObS7R3ETUw==
X-CSE-MsgGUID: W2a/RIf4S7qVKUphcur34w==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="72029109"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="72029109"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 21:47:43 -0800
X-CSE-ConnectionGUID: bqo2cnHTT9uun0/aCjIkCg==
X-CSE-MsgGUID: UsTUuX/OS1OBS6/x7zSEtw==
X-ExtLoop1: 1
Received: from unknown (HELO [10.124.240.14]) ([10.124.240.14])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2026 21:47:37 -0800
Message-ID: <586f9204-1b37-422c-b964-dc62f720aa41@linux.intel.com>
Date: Wed, 11 Feb 2026 13:47:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v6 01/22] perf/x86/intel: Restrict PEBS_ENABLE writes to
 PEBS-capable counters
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
 <20260209072047.2180332-2-dapeng1.mi@linux.intel.com>
 <20260210153643.GA3931095@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260210153643.GA3931095@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/10/2026 11:36 PM, Peter Zijlstra wrote:
> On Mon, Feb 09, 2026 at 03:20:26PM +0800, Dapeng Mi wrote:
>> Before the introduction of extended PEBS, PEBS supported only
>> general-purpose (GP) counters. In a virtual machine (VM) environment,
>> the PEBS_BASELINE bit in PERF_CAPABILITIES may not be set, but the PEBS
>> format could be indicated as 4 or higher. In such cases, PEBS events
>> might be scheduled to fixed counters, and writing the corresponding bits
>> into the PEBS_ENABLE MSR could cause a #GP fault.
>>
>> To prevent writing unsupported bits into the PEBS_ENABLE MSR, ensure
>> cpuc->pebs_enabled aligns with x86_pmu.pebs_capable and restrict the
>> writes to only PEBS-capable counter bits.
> This seems very wrong. Should we not avoid getting those bits set in the
> first place?

Hmm, yes. I originally thought it's fine to block the access these invalid
bits in PEBS_ENABLE MSR, but I agree it should be blocked as early as possible.

Currently the intel_pebs_constraints() helper doesn't check if the returned
matched PEBS constraint contains the fixed counter indexes when extended
PEBS is not supported.

We may need the below change (just build and not tested yet). 

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 94ada08360f1..bc36808bdb7b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1557,6 +1557,14 @@ struct event_constraint
*intel_pebs_constraints(struct perf_event *event)
        if (pebs_constraints) {
                for_each_event_constraint(c, pebs_constraints) {
                        if (constraint_match(c, event->hw.config)) {
+                               /*
+                                * If fixed counters are suggested in the
constraints,
+                                * but extended PEBS is not supported,
emptyconstraint
+                                * should be returned.
+                                */
+                               if ((c->idxmsk64 & ~PEBS_COUNTER_MASK) &&
+                                   !(x86_pmu.flags & PMU_FL_PEBS_ALL))
+                                       break;
                                event->hw.flags |= c->flags;
                                return c;
                        }

Thanks.


>
> That is; the fact that we set those cpuc->pebs_enabled bits indicates
> that we 'successfully' scheduled PEBS counters. And then we silently
> disable PEBS when programming the hardware.
>
> Or am I reading this wrong?
>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>
>> V6: new patch.
>>
>>  arch/x86/events/intel/core.c |  6 ++++--
>>  arch/x86/events/intel/ds.c   | 11 +++++++----
>>  2 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index f3ae1f8ee3cd..546ebc7e1624 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3554,8 +3554,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  		 * cpuc->enabled has been forced to 0 in PMI.
>>  		 * Update the MSR if pebs_enabled is changed.
>>  		 */
>> -		if (pebs_enabled != cpuc->pebs_enabled)
>> -			wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>> +		if (pebs_enabled != cpuc->pebs_enabled) {
>> +			wrmsrq(MSR_IA32_PEBS_ENABLE,
>> +			       cpuc->pebs_enabled & x86_pmu.pebs_capable);
>> +		}
>>  
>>  		/*
>>  		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index 5027afc97b65..57805c6ba0c3 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1963,6 +1963,7 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  	struct hw_perf_event *hwc = &event->hw;
>> +	u64 pebs_enabled;
>>  
>>  	__intel_pmu_pebs_disable(event);
>>  
>> @@ -1974,16 +1975,18 @@ void intel_pmu_pebs_disable(struct perf_event *event)
>>  
>>  	intel_pmu_pebs_via_pt_disable(event);
>>  
>> -	if (cpuc->enabled)
>> -		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>> +	pebs_enabled = cpuc->pebs_enabled & x86_pmu.pebs_capable;
>> +	if (pebs_enabled)
>> +		wrmsrq(MSR_IA32_PEBS_ENABLE, pebs_enabled);
>>  }
>>  
>>  void intel_pmu_pebs_enable_all(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	u64 pebs_enabled = cpuc->pebs_enabled & x86_pmu.pebs_capable;
>>  
>> -	if (cpuc->pebs_enabled)
>> -		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>> +	if (pebs_enabled)
>> +		wrmsrq(MSR_IA32_PEBS_ENABLE, pebs_enabled);
>>  }
>>  
>>  void intel_pmu_pebs_disable_all(void)
>> -- 
>> 2.34.1
>>
