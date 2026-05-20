Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869912C08D0;
	Wed, 20 May 2026 02:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779242943; cv=none; b=thTrvJPNi9ZcpqPqrydcmqUeQVTcdtNRT6O+ujtfJoaD5qbod3sXYBz4r8cIwJdyRmg+c2x49jsoz2yAoJb3/bRsm17KWzeZxWTDjgAUzdx8kloOdhZq+qrxGAqfqgYupDbfPGIni5Z9vtRkjgU3WahVVhnUBhWJNNI/ppEd6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779242943; c=relaxed/simple;
	bh=3aKYVI2VuwvWtTXsgttO0I2tblnCy3v1ZLmGgsBCiuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ljw9Ru1DpqzOeP08c+wo1G++JQekaINSnE2OwsATD22YvE2vKqBrARUrWrN1myIazmwncsygYa57zs4D/YK64X1GoxhukhagS6yIqYsjmyCa6EgkheB0WhI9ciXB/d2oxns2taKWFRHEexz/TWcTb53YTnBuRTXIse1drHzEn3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B6FufziQ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B6FufziQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779242942; x=1810778942;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3aKYVI2VuwvWtTXsgttO0I2tblnCy3v1ZLmGgsBCiuA=;
  b=B6FufziQ3tw0pmSsxTG+4/WEBbOQW/jJpd+yrowNn4gXFJxGnGo7HiGI
   xiFi2qLgfrM2MlOfZi4k5tfRXZzwQ6isLlGhN8LJiaRQtS/AliBJiNd6P
   YmVhal61Vt7LR5X+vh4vPyvIVgZ6turHv6Th9M+zxq4X8zNtLypXfcfvP
   opn/Bwh48lN4Lvejw2+3FaxJMQ5jHqP3ffyBFiznVNONXgcr1f2Ku/PI7
   3MAcHy0R4aFwtwQV5DIvC5FRV9eY6ELammOIbIpolttIEkQmK2X3S1TUy
   uLJdgg8+lMOXt1ITIUjwdiMGEnHY6Sa9EHIutHnIXxZKKEH0PRg/6FH5F
   A==;
X-CSE-ConnectionGUID: 1iO3gHtfRkuO5OSJhQ3FYQ==
X-CSE-MsgGUID: 6sjpIW5LTgu0z166ZBG73g==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79983327"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79983327"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:09:01 -0700
X-CSE-ConnectionGUID: u+n11fM+RcGhWXw7Tfr9wA==
X-CSE-MsgGUID: sfp68GNET8yJm+gxi9CW7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="239839722"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 19:08:57 -0700
Message-ID: <2e51f20b-1338-4317-a71a-f52f050b5154@linux.intel.com>
Date: Wed, 20 May 2026 10:08:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] perf/x86/intel: Update event constraints and
 cache_extra_regs[] for SPR
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
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
 <20260515061143.338553-3-dapeng1.mi@linux.intel.com>
 <9bcfb336-00f4-4f26-bca1-fa08d74a6828@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <9bcfb336-00f4-4f26-bca1-fa08d74a6828@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/20/2026 6:25 AM, Chen, Zide wrote:
>
> On 5/15/2026 11:11 PM, Dapeng Mi wrote:
>> Update perf hard-coded event constraints and cache_extra_regs[] for
>> Sapphire rapids according to the latest SPR perfmon events (v1.39).
>>
>> Emerald Rapids (EMR) and Granite Rapids (GNR) share exactly same event
>> constraints and extra MSR values with SPR. No extra changes are needed
>> for EMR and GNR.
>>
>> Please note the change could temporarily impact other platforms which
>> share the hard coded data structures, but it would be fixed in
>> subsequent patches soon.
> This may make bisection difficult. Would it be possible to reorder the
> patches to avoid this? For example, moving patch 6/11 ahead of this
> patch to avoid impacting Lunar Lake.

Hmm, it's hard to fix it by just reordering the patches. Currently the
hard-coded event data structures of previous generations would be reused by
later generations. If there are some differences between the older and
later generations, only the differences are overwritten. So even we move
the patch 6/11 ahead of this patch, it still impacts other platforms.

Besides, the "impact" here doesn't mean it must cause issues, it may fix
the incorrect hard-coded event configurations (This should be most of the
cases), sometimes the new changes may be still inaccurate for other
platforms which reuse the hard-coded event structures, but it doesn't make
things worse.

Strictly speaking, I don't think this could cause the bisection issue. For
a certain platform,  we still can figure out which commit causes the issues
by bisection.

IMO, it seems there is no way to ensure the change won't impact other
platforms except putting all changes into a single patch which is obviously
not accepted.

Thanks.


>
>> SPR perfmon events:
>> https://github.com/intel/perfmon/blob/main/SPR/events/sapphirerapids_core.json
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 23 ++++++++++++++---------
>>  1 file changed, 14 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 1390d1da985b..b3ccc785a4f6 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -356,11 +356,12 @@ static struct extra_reg intel_glc_extra_regs[] __read_mostly = {
>>  
>>  static struct event_constraint intel_glc_event_constraints[] = {
>>  	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
>> -	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
>> +	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
>>  	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
>> -	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
>> +	FIXED_EVENT_CONSTRAINT(0x0200, 1),	/* pseudo CPU_CLK_UNHALTED.THREAD */
>> +	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
>>  	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
>> -	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
>> +	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
>>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
>>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
>>  	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
>> @@ -380,9 +381,13 @@ static struct event_constraint intel_glc_event_constraints[] = {
>>  
>>  	INTEL_UEVENT_CONSTRAINT(0x01a3, 0xf),
>>  	INTEL_UEVENT_CONSTRAINT(0x02a3, 0xf),
>> +	INTEL_UEVENT_CONSTRAINT(0x05a3, 0xf),
>> +	INTEL_UEVENT_CONSTRAINT(0x06a3, 0xf),
>>  	INTEL_UEVENT_CONSTRAINT(0x08a3, 0xf),
>> +	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0xf),
>>  	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
>>  	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
>> +	INTEL_UEVENT_CONSTRAINT(0x01cd, 0xfe),
>>  	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x1),
>>  	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
>>  	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
>> @@ -714,18 +719,18 @@ static __initconst const u64 glc_hw_cache_extra_regs
>>  {
>>   [ C(LL  ) ] = {
>>  	[ C(OP_READ) ] = {
>> -		[ C(RESULT_ACCESS) ] = 0x10001,
>> -		[ C(RESULT_MISS)   ] = 0x3fbfc00001,
>> +		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
>> +		[ C(RESULT_MISS)   ] = 0x3fbfc00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
>>  	},
>>  	[ C(OP_WRITE) ] = {
>> -		[ C(RESULT_ACCESS) ] = 0x3f3ffc0002,
>> -		[ C(RESULT_MISS)   ] = 0x3f3fc00002,
>> +		[ C(RESULT_ACCESS) ] = 0x3f3ffc0002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
>> +		[ C(RESULT_MISS)   ] = 0x3f3fc00002,	/* OCR.DEMAND_RFO.L3_MISS */
>>  	},
>>   },
>>   [ C(NODE) ] = {
>>  	[ C(OP_READ) ] = {
>> -		[ C(RESULT_ACCESS) ] = 0x10c000001,
>> -		[ C(RESULT_MISS)   ] = 0x3fb3000001,
>> +		[ C(RESULT_ACCESS) ] = 0x104000001,	/* OCR.DEMAND_DATA_RD.LOCAL_DRAM */
>> +		[ C(RESULT_MISS)   ] = 0x730000001,	/* OCR.DEMAND_DATA_RD.REMOTE_DRAM */
>>  	},
>>   },
>>  };
