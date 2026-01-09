Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F291DE3B7;
	Fri,  9 Jan 2026 02:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924572; cv=none; b=CRwtvb1PW7LVLMWyheJ4Fnr9alUrHCb7cN/7K43jJijkGZEyTXGuO+rE3AHh68B8HrvnV1mJ3Z7mMqd/bcN+LJKAi2se4rxQ6vF4nu5KQ2ii7LHcrqiEXcWrsvzBsytbkS125dSznMU0FFR8Um70DfHxaQXL5tFAtkhVTA33bVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924572; c=relaxed/simple;
	bh=m0h5YF/Qtb5rEl0SD1soau4DiBlmKWi/q25PBF1IXo4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWD4/Q0JQLgDx05sDVr6XsbxYEfFWZeQOcq4OM//wDjT0iXZO4AQrs0xkxE7oYxSfE4SbTud5VpuA2aG8Wh8OUcg3REKG+QNz1c0Puf46QV8LGNaTH4SENz1RMPeQzpupuK2/i9V0SGjUQWZ3AMpKEFPhRlzpNh9ksV6g4/6G0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4BfsbLm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4BfsbLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767924572; x=1799460572;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m0h5YF/Qtb5rEl0SD1soau4DiBlmKWi/q25PBF1IXo4=;
  b=M4BfsbLmbGOEBch4H6Aw45fzWFOQqDOvn0WBPDd7F8qXGYORiDg+3+Fx
   KcJ5ctZjNlyxEe45SjXRYImZ0bs8Zqs9Sx77xQJ9FXJKVo24mBLe68hfM
   tE68u5qpZQE7eWUv69HgYDrhsL9PjYPc0b9zOKzXVxmH/gJRsEm+t/Opv
   XVBUF2pdaz/BHk6IKD5e9cS6o4uukWWkVC/wRtxWRqgSeXxelGq4tMN+7
   AQogGtt8SbZEYzkzTTTcLBwTtJO9JHjmrMHuP818zM/tbsBl0hpSXOjCs
   MPN7fCA9U49Ov/yMHn55GSB0QRTEMVMNMVufBMgL+GPxBkgkhfG3i+IXg
   w==;
X-CSE-ConnectionGUID: nuMPpUhESd2AAMCXqnaLGg==
X-CSE-MsgGUID: lVmT7Z0gRz+n6XbYIBHMOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="86895193"
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="86895193"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 18:09:31 -0800
X-CSE-ConnectionGUID: X4fkGQ62RxOIr9ejo4Gl+A==
X-CSE-MsgGUID: sT//9fFZQ16IwF9jM5rKUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,211,1763452800"; 
   d="scan'208";a="203384811"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 18:09:27 -0800
Message-ID: <84956f69-ba22-41f0-a70b-0a28858f64b5@linux.intel.com>
Date: Fri, 9 Jan 2026 10:09:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] perf/x86/intel: Add core PMU support for Novalake
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
 <20251120053431.491677-6-dapeng1.mi@linux.intel.com>
 <18cc180b-7ce0-46d1-a6f6-af9368f3cc40@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <18cc180b-7ce0-46d1-a6f6-af9368f3cc40@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/9/2026 3:35 AM, Chen, Zide wrote:
>
> On 11/19/2025 9:34 PM, Dapeng Mi wrote:
>> This patch enables core PMU support for Novalake, covering both P-core
>> and E-core. It includes Arctic Wolf-specific counters, PEBS constraints,
>> and the OMR registers table.
>>
>> Since Coyote Cove shares the same PMU capabilities as Panther Cove, the
>> existing Panther Cove PMU enabling functions are reused for Coyote Cove.
>>
>> For detailed information about counter constraints, please refer to
>> section 16.3 "COUNTER RESTRICTIONS" in the ISE documentation.
>>
>> ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 99 ++++++++++++++++++++++++++++++++++++
>>  arch/x86/events/intel/ds.c   | 11 ++++
>>  arch/x86/events/perf_event.h |  2 +
>>  3 files changed, 112 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 9f2a93fe23df..a3a1e6e670f8 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -232,6 +232,29 @@ static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
>>  	EVENT_CONSTRAINT_END
>>  };
>>  
>> +static struct event_constraint intel_arw_event_constraints[] __read_mostly = {
>> +	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
>> +	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
>> +	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
>> +	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
>> +	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
>> +	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
>> +	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
>> +	INTEL_UEVENT_CONSTRAINT(0x01b7, 0x1),
>> +	INTEL_UEVENT_CONSTRAINT(0x02b7, 0x2),
>> +	INTEL_UEVENT_CONSTRAINT(0x04b7, 0x4),
>> +	INTEL_UEVENT_CONSTRAINT(0x08b7, 0x8),
> Should be these?
>
> INTEL_UEVENT_CONSTRAINT(0x03b7, 0x4),
> INTEL_UEVENT_CONSTRAINT(0x04b7, 0x8),

No, it's a bit mask. Each bit of bits[3:0] corresponds an OMR extra MSR.
Just found there are conflicts about the ARW OMR events umask in ISE.

The table 16-2 "OMR Events Supported by Arctic Wolf Microarchitecture"
indicates the umask of these 4 OMR events are 0x1/0x2/0x4/0x8, but the
umask of OMR events in table 16-9 "Event Counter Restrictions for Arctic
Wolf Microarchitecture" are described to 0x1/0x2/0x3/0x4. I believe the
umasks described in table 16-2 are correct and it's a typo in table 16-9.

I would double check with PME team and let them update the ISE. Thanks.


>
