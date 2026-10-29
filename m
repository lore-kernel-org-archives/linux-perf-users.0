Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267791;
	b=JZ0icpjmZNU/PE3f1LzHiq1/QZ0ZpxBz+hWX9wCJMPOXlB2NwmyqG0I9dKVU37qaNSlV
	 Ccd9R334MSKjG7w/bHzjQA/sm6M8Q9eQAFnI+zrFIYoOS+Hx5JiDsNswgQxmeVnQ7jU9t
	 F6WL2cP0UWNmNfmeM7roC3IhzGvDftkA67loC4hChqqnMw0BswyVrenWDBHNCl4vg8qj2
	 dONuNlNKKWrnYgz+DZopHgR29ECn4ArvMDojtgm/a6P2Lo+yIXTN4kRh4QNRt/WC7PGp/
	 tcWFWX1T9SholbSuLo55bsOMh9ha8eXiM7qrWpVipIW7SfhVYTLZZ+KcBbJZMCbUG9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267791;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KF3Zf3Cykfts2TbK8WZyR/MUwrLHSnrm/Y67M51a1rM=;
	b=WOq/zjVefd2EM3tgKpoKlR70YHfFK+NaQOG3Or8likIjJEji0LcwFFmszC2HuN0qGw8W
	 wOAl5PodvXuLCTlRNjGaTyRMvrSpKQlYO//Kp2Y1/TZl1JVes28AmAdCM5M0GvH4PoSo4
	 NEhi4Ti3zg5vuxmGaNP6npsYastOSBwgsXE69yZk0bO4m7rboAWoe9tI7MpSWsEoO6Tbo
	 3NmLjg2Um57dZlSgrdTzVhaGiZ85CToA+XTAlLQK0QY2dCuGUn3N5ke5VzZeeYbj2us1F
	 40/k5UeaRaCN9sBfEaxtHQKdwcs+/2McaMsVRGR9x+FJl7T84/8Lghxw3xzieo5iLOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U4OAYyvw;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F19E606A321;
	Thu, 29 Oct 2026 09:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F19E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U4OAYyvw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793267791; x=1824803791;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kR3ldE4ZOJmbjcyVdOxZzAlfKm7+NFARdgV9/T/pxwk=;
  b=U4OAYyvwuN7Be6YS9cf+SgfBKGHBwTbwKleoKki8qF5NNPY7BkiPfnwz
   aUI9zyEC00QrqMQPeag3cSVPy9EcH696K7Z61pli+xnFOpgQ0BP+sOo8n
   I2KkoPus5MgIfXXl70ASAXW7spQ9Y0YtcohuObedxUTX8tadSHj9M23h+
   qmddJ3EGfxSEL6hnjepnj0vxpUGzqCAiDQVn4+RV5XQiUsGJsYrAdyxD7
   hDe0vUoLm6NT3wn8qymWGAQQoNSenaz9uKj29Olihd9+wqI68fCiplymp
   3BLY+9ZgHGsFe6iznxYpCloSbuaHQJ9DnCiWbKfdiIBIITUmKoeyZc/h8
   A==;
X-CSE-ConnectionGUID: RogJ6kcRTxOg2Z2cXe6lmw==
X-CSE-MsgGUID: 3mYgwjKORYuK4xF7B1H38w==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1916998"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1916998"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:56:30 -0700
X-CSE-ConnectionGUID: zdlSamq5QmiVQA3upHNftA==
X-CSE-MsgGUID: wUExTh3tTfi7w2KPV+sFfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5435511"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 02:56:24 -0700
Message-ID: <041e5185-ff2d-4423-af5d-aed6628973c5@linux.intel.com>
Date: Thu, 29 Oct 2026 17:56:15 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 01/18] perf/x86: Disable LBR if x86_pmu.lbr_nr exceeds
 MAX_LBR_ENTRIES
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-2-dapeng1.mi@linux.intel.com>
 <20261029093845.GI1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029093845.GI1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/29/2026 5:38 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 12:38:57PM +0800, Dapeng Mi wrote:
>> Add a sanity check for x86_pmu.lbr_nr. If the hardware reports more LBR
>> entries than MAX_LBR_ENTRIES, disable LBR to avoid out-of-bounds access
>> in the cached LBR stack handling path.
> Cute, can this actually happen?

Currently it won't happen on real hardware since the maximum LBR stack
depth what hardware supports is 32. But it's better have this sanity check
assume the LBR stack depth could be extended to 64 or larger.


>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/amd/lbr.c    | 8 +++++++-
>>  arch/x86/events/intel/core.c | 7 +++++++
>>  2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
>> index a55646fcb846..96c5b5e56053 100644
>> --- a/arch/x86/events/amd/lbr.c
>> +++ b/arch/x86/events/amd/lbr.c
>> @@ -433,7 +433,13 @@ __init int amd_pmu_lbr_init(void)
>>  	ebx.full = cpuid_ebx(EXT_PERFMON_DEBUG_FEATURES);
>>  	x86_pmu.lbr_nr = ebx.split.lbr_v2_stack_sz;
>>  
>> -	pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
>> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
>> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
>> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
>> +		x86_pmu.lbr_nr = 0;
>> +	} else {
>> +		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
>> +	}
>>  
>>  	return 0;
>>  }
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 0a34d674df59..10c694db85ea 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -9023,6 +9023,13 @@ __init int intel_pmu_init(void)
>>  	 */
>>  	if (x86_pmu.lbr_tos && !check_msr(x86_pmu.lbr_tos, 0x3UL))
>>  		x86_pmu.lbr_nr = 0;
>> +
>> +	if (x86_pmu.lbr_nr > MAX_LBR_ENTRIES) {
>> +		pr_warn("LBR entries %d exceeds max %d, disable LBR.\n",
>> +			x86_pmu.lbr_nr, MAX_LBR_ENTRIES);
>> +		x86_pmu.lbr_nr = 0;
>> +	}
>> +
>>  	for (i = 0; i < x86_pmu.lbr_nr; i++) {
>>  		if (!(check_msr(x86_pmu.lbr_from + i, 0xffffUL) &&
>>  		      check_msr(x86_pmu.lbr_to + i, 0xffffUL)))
> Would it make sense to have but one copy of this check in
> init_hw_perf_events(), after calling into the micro-arch code?

Yes, that's what the previous version does, but Sashiko complains it's too
late.

"

Does zeroing x86_pmu.lbr_nr here in init_hw_perf_events() happen too late,
after intel_pmu_init() and amd_pmu_init() have already configured hardware
and driver state using the unvalidated x86_pmu.lbr_nr value?

"

https://lore.kernel.org/all/sashiko-outbox-179814@kernel.org/

It makes sense in some ways, so move the sanity check into the vendor init
in this version. 

Thanks.


