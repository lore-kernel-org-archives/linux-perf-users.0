Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FC18BC3B;
	Wed, 26 Feb 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584717; cv=none; b=I5gGuNRDuvIl5nmR5L45MXNBzJygfK1uxTofcwRxEYq7RN7UcdE1g61VCCLdORJGWyImkjSoUHbYnygjtD+sYkG2VGItcw49YixgdGG1a4DQAAvCsiEwSNSwJVEEaYXgeqppaZPVJB4IGuq+noMSc8tL9ZPFjYCH1YBgD+VZZuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584717; c=relaxed/simple;
	bh=5TQxHnU3PBtTgmCj+sOng8yLc1UM9OVCIbeacuaMWx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaut/WA/nt8vntVVsq+IATHUyjOOBs5fWZVLu+RYzDhfHv7gfFCXN3bfq+MqD5Qq5vChg+FxusVgLZKvSJ9qacfJd4o35n/cNez/ZSGF95WQp77deptwCnIdadP+hrTpHeQs7op5oZBWQPvoCgrlcnOtttiitU+X9RCoj3ocdOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PoXEKjx2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PoXEKjx2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740584716; x=1772120716;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5TQxHnU3PBtTgmCj+sOng8yLc1UM9OVCIbeacuaMWx0=;
  b=PoXEKjx2MkbF53eUBlkLpTPp68c3tqt5tuMh4o5Xlx1HDBgR4IrT9r8r
   oil9/OuXg7xr0q0f+2Jjo6HXqCMG0O19jDkithspD9m3mjn6hBHDoZigW
   gHbYAzuLE/vrYNa/MMmXxC50yyQPSoMJYEOtjkoEwljTmcSBLcm00E6qg
   rQoeyXEwFkHWoZPork4NJC0iWo98FGQ4lGxME9HylzvNLrfKDKp163+0C
   jXeTe8/qdGNHYmZZ1PySmoY4tlljJki2+MpvKMVpUU4tpP67rYMKeAy5e
   Gf1f+LLuXncu/XQle+puMks2W5HUIK+hjLROQJl1PAtdythRiuSbDrWfe
   w==;
X-CSE-ConnectionGUID: evzAvKm9R8OHbxo5Zm4ZbQ==
X-CSE-MsgGUID: EdY906JsQ1WR2PaQ1En/Vw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="40615225"
X-IronPort-AV: E=Sophos;i="6.13,317,1732608000"; 
   d="scan'208";a="40615225"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:45:15 -0800
X-CSE-ConnectionGUID: PO5srzFSSYG0iOuEhjmA2w==
X-CSE-MsgGUID: hm4D1+xDSCSWsx30DxOf4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147662030"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 07:45:15 -0800
Received: from [10.246.136.14] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.14])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 0B4D920B5713;
	Wed, 26 Feb 2025 07:45:12 -0800 (PST)
Message-ID: <98112b48-5ca6-4077-a842-83d1407f1860@linux.intel.com>
Date: Wed, 26 Feb 2025 10:45:11 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
To: Peter Zijlstra <peterz@infradead.org>,
 "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
 <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
 <20250225110012.GK31462@noisy.programming.kicks-ass.net>
 <c1450cf4-f367-4675-9f5e-90416a996af1@linux.intel.com>
 <20250226093558.GR11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250226093558.GR11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025-02-26 4:35 a.m., Peter Zijlstra wrote:
> On Wed, Feb 26, 2025 at 01:20:37PM +0800, Mi, Dapeng wrote:
> 
>>> Also, should that workaround have been extended to also include
>>> GLOBAL_STATUS_PERF_METRICS_OVF in that mask, or was that defect fixed
>>> for every chip capable of metrics stuff?
>>
>> hmm,  per my understanding, GLOBAL_STATUS_PERF_METRICS_OVF handling should
>> only be skipped when fixed counter 3 or perf metrics are included in PEBS
>> counter group. In this case, the slots and topdown metrics have been
>> updated by PEBS handler. It should not be processed again.
>>
>> @Kan Liang, is it correct?
> 
> Right, so the thing is, *any* PEBS event pending will clear METRICS_OVF
> per:
> 
>                 status &= x86_pmu.intel_ctrl | GLOBAL_STATUS_TRACE_TOPAPMI;
> 

Yes, we have to add it for both legacy PEBS and ARCH PEBS.

An alternative way may change the order of handling the overflow bit.

The commit daa864b8f8e3 ("perf/x86/pebs: Fix handling of PEBS buffer
overflows") has moved the "status &= ~cpuc->pebs_enabled;" out of PEBS
overflow code.

As long as the PEBS overflow is handled after PT, I don't think the
above is required anymore.

It should be similar to METRICS_OVF. But the PEBS counters snapshotting
should be specially handled, since the PEBS will handle the metrics
counter as well.

@@ -3211,7 +3211,8 @@ static int handle_pmi_common(struct pt_regs *regs,
u64 status)
 	/*
 	 * Intel Perf metrics
 	 */
-	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned
long *)&status)) {
+	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned
long *)&status) &&
+	
!is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS])) {
 		handled++;
 		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}


Thanks,
Kan


