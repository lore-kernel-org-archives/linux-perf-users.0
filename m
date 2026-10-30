Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793321806;
	b=Z6CSX84GiBUHH2R3br+8o8X3ecDyPZ+rNCWupChBBA2p6yJz8Uljk1RvRDZg1hT9+KUw
	 rV6QaPodPz+CfRnZ82TUsURdcZPmotKKbhK69WC7JxOgao1ZXcREXDNLHz11Tu5TjRfMX
	 6g/uuHe2kvLvuRw5vfBUcpTmzHB8Ttf4Bv/+tVyyE3AsmOP9dohRfS49hI7oRNt4vieJB
	 CPvyuK5C1Df6Sj4g9T1a8GgssVNavFlVgLugG54dQzt8QxIdsPr8Z1WRMRmdAvJQuS7pF
	 bVIPQx7/XJoJXdM+jDYETDMWrG41Oad4da0P2GLTWQxTtffMo9T68mKesx0HopjQeTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793321806;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=xyb+69pYULmueBFnWcg46WwXw3RsTh6y1EVYsQDuyFQ=;
	b=ET8m0WFxam/3JrbNw59wawxgPZUsVKQCjcHrmALhQmtqnw0yvb2roBnz8zTm2DyPSEpI
	 1ZqmzgzQiVBzCkNP/Ok8kzFaeJLuwd3ZUoi22ZOoOvr3MZUJ8M+is75BBuEjRHUYfpi7/
	 Vmz0AyXKHPCBTLxnKwzhGe3v5ly8nPIABfE0EsF/wd7dsRjHSCL1a7PLGI15QKfbRlcXB
	 AyGRlGZI6hxahsWH7s12HlOq7yGwIkcxSMdo1x/xOyhjYhYkLxPTgX999Y94kg9tZvbL5
	 0rSxhzZE/hLgiboPoImXjGG4J6GccEqFRtluFYFewLm5UXmiwL05SFvof75hmm+E/Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nYIqapg3;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3979606A31A;
	Fri, 30 Oct 2026 00:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3979606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nYIqapg3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793321805; x=1824857805;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z3nw8QlyMetFne7VntyxtnLKzIox2A/5WbJcshmhr/A=;
  b=nYIqapg3FV7uBBOw7RC0KqJ/sl/m5/eQTR4jJR4vNkNlZA2rFQPVAehN
   Hd2pbhbcUve70av7boKBDlxNMTsDM5c6jwUkopfGIg/0SgggBtw5vS92O
   KxlIMt4j5lSDR5ind0HRNmBciKXPg4M+aUlWseuWM6lC4uyf8Sl3KLrCv
   7P1Jf7P3ziSoiAAAxzkrGBzZ4OmBzxUsXTqoSCH6wBtf4wKLS1+czUN/v
   pRZImE9Bog0My3cXpbtTAN356pXBYNH+8xx2ZlVrCaTCHObS6Jz7KtgKB
   IeeJQJRgO/SJfMkFZuoXqqt5jSaOToCcCPqHkkRb+FjS1LVcDD5/cEt1b
   w==;
X-CSE-ConnectionGUID: vBRL7H3PRtefO9M67UOzsQ==
X-CSE-MsgGUID: UrOsY41XQTKtsZREp08AsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1964833"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1964833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 17:56:44 -0700
X-CSE-ConnectionGUID: OoK+BY8NT8ajXUR5wneWmA==
X-CSE-MsgGUID: 4jdV3FrhSqWX5C2IczAjIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5419851"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 17:56:39 -0700
Message-ID: <955e7368-d7fa-4c37-8927-ecd6cbc837c9@linux.intel.com>
Date: Fri, 30 Oct 2026 08:56:37 +0800
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
Subject: Re: [Patch v5 09/18] perf/x86/intel: Keep LBR frozen throughout PMI
 handling
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
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Sashiko <sashiko-bot@kernel.org>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-10-dapeng1.mi@linux.intel.com>
 <20261029102930.GK1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029102930.GK1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/29/2026 6:29 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 12:39:05PM +0800, Dapeng Mi wrote:
>> For the platforms which has 4+ PMU version, streamline LBR freeze is
>> supported. The PERF_GLOBAL_STATUS.LBR_FRZ bit is set to freeze LBR once
>> a PMU counter overflow. However, the current PMI handler clears the LBR
>> freeze bit too early, allowing branch operations that occur during PMI
>> handling to be recorded into the LBR stack.
>>
>> This can pollute or overwrite the intended branch snapshot, especially
>> when bpf_get_branch_snapshot() is invoked from bpf_overflow_handler().
>> In that case, branches recorded while processing the PMI are mixed into
>> the original LBR data.
>>
>> Defer unfreezing until after PMI handling completes so the LBR remains
>> frozen for the entire PMI path and no branch activity from the handler
>> is recorded.
>>
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/all/sashiko-outbox-179823@kernel.org/
>> Fixes: 425507fa5f32 ("perf/x86/intel/lbr: Optimize v4 LBR unfreezing")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 15dcf8b78de9..a67297148bb6 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4062,7 +4062,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>>  	loops = 0;
>>  again:
>>  	intel_pmu_lbr_read();
>> -	intel_pmu_ack_status(status);
>> +
>> +	/*
>> +	 * Do not clear the LBR frozen status here; keep LBR frozen
>> +	 * throughout PMI handling.
>> +	 */
>> +	intel_pmu_ack_status(status & ~GLOBAL_STATUS_LBRS_FROZEN);
>> +
>>  	if (++loops > 100) {
>>  		static bool warned;
>>  
>> @@ -4081,10 +4087,13 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>>  	 * Repeat if there is more work to be done:
>>  	 */
>>  	status = intel_pmu_get_status();
>> -	if (status)
>> +	if (status & ~GLOBAL_STATUS_LBRS_FROZEN)
>>  		goto again;
>>  
>>  done:
>> +	if (status & GLOBAL_STATUS_LBRS_FROZEN)
>> +		intel_pmu_ack_status(status & GLOBAL_STATUS_LBRS_FROZEN);
>> +
>>  	if (mid_ack)
>>  		apic_write(APIC_LVTPC, APIC_DM_NMI);
>>  	/* Only restore PMU state when it's active. See x86_pmu_disable(). */
> Given the whole PMU is disabled per __intel_pmu_disable_all(), all that
> can really happen is for more bits to be set, right? I mean, any counter
> cleared on the first ack_status, will never be re-set, it already fired
> and its disabled. All that can happen is that the disable is 'delayed'
> and a counter can maybe fire a little bit after the disable; getting
> missed on the first go.
>
> Can we really get more than 1 extra loop there?
>
> I'm sure this code has changed lots since we added that loop thing
> there.
>
> Anyway, if we can never get more than 1 extra loop, we can probably move
> the ack to the end, without having to do a second.
>
> I suppose this isn't something you have to do now, but keep it on the
> todo list or something?

Sure. I would investigate the history and check if it can be removed.


