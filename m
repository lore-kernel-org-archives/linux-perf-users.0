Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EA42ED846;
	Mon,  8 Jun 2026 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886780; cv=none; b=UvY5JbO07GknRmT48yLl57y5XuvKUdUOL2ZGp9vFY5oHG9rny2N3KlXssD+rAURc0wQUp0yVVwLmZzS9dSfeQo03OtMCktSsBlQoX7aykN929LiRu9mOlyLqL4gemSqIzozzPi4u5B/jmf2+Ul7zQQly48FjP8zU5awPEsgfjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886780; c=relaxed/simple;
	bh=2Lx2/MLzItPK8amRTwlCnpC96Esd4YLTuv+Rwl5T9wk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kT1FLpcfgfTFayB8HHOT52G+Hsvz6SoUlp0AWslk/dj2D34/DDBn0pIA8X8XmgYqZRiZ04PB8nMmcn82mOykI0KIeTTO6EZBUV7d6Q9AOV9RTakpPfcGUi9LCqzA60y24BhaCCyex3XFqMDPUpNbHEjkpQeAVCWoMhFmVFyWtX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NoUxfEtl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NoUxfEtl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780886778; x=1812422778;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Lx2/MLzItPK8amRTwlCnpC96Esd4YLTuv+Rwl5T9wk=;
  b=NoUxfEtlMbgi7oH80W4ifNR86FViRurNuu0aqmKHlMG74qYqw3vODuzz
   SpbILjA1JWIlQvIhjkijo40+tCMTi9qtdV0kBH8aAJE76o/0pA0ETkRpi
   DpTIXLUrstx2YiJDS7t2HojteSzwwrokF2iad/0u11qBEhYzl8Uv00x5s
   HM+Q41C0+WLtJNhpIP99LSDOtyVIIUvNKVq+MD3uCZZavUdPs+UQhwcnC
   mXBAtGijhhK+VujwdIGVTypi9w1g/+0WmJTR87zhisdAH5+hooP8/W7XP
   inVVF+2OY67aJxAbIVpddrkVjAH8Egk8HJ4p/+N+1m7RgSfbu0yneQK0y
   g==;
X-CSE-ConnectionGUID: qP4KH/s/ROiemoFJ38FUgw==
X-CSE-MsgGUID: QqW/FeGaSpGFdjp2wQ8aDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81472458"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81472458"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:46:18 -0700
X-CSE-ConnectionGUID: tjTovQNdRlqFzE5Mf9gVQg==
X-CSE-MsgGUID: qVGVQ1GTSz+gtCOVwL9zUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="244300563"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:46:14 -0700
Message-ID: <64abd498-8ce2-45fa-b41e-c95aa0bc8b40@linux.intel.com>
Date: Mon, 8 Jun 2026 10:46:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf/x86/intel: Drop fixed-counter PEBS constraints
 for baseline PEBS
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
 <20260605011136.2043393-8-dapeng1.mi@linux.intel.com>
 <350ebaf7-91b1-4550-be4d-a07a96c4a955@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <350ebaf7-91b1-4550-be4d-a07a96c4a955@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/6/2026 4:32 AM, Chen, Zide wrote:
>
> On 6/4/2026 8:11 PM, Dapeng Mi wrote:
>> On SPR guests where pebs_baseline is not advertised, running:
>>
>> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
>> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
>>
>> can trigger:
>>
>> unchecked MSR access error: WRMSR to 0x3f1 ... in\
>> 	 intel_pmu_pebs_enable_all()
>>
>> Root cause:
>> SPR-specific PEBS constraints allow fixed-counter scheduling,
>> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
>> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
>> so enabling such events reaches an invalid MSR programming path.
>>
>> Fix:
>> Drop fixed-counter entries from the PEBS constraint table. Without
>> pebs_baseline, those fixed-counter PEBS events now resolve to empty
>> constraints and are not scheduled/enabled, avoiding the warning and the
>> broken guest PEBS path.
> Seems this exposes a more general issue: constraints derived from
> host capabilities may not be applicable to a guest, since the guest may
> only has a subset of the host capabilities.
>
> For example, an event could be constrained to GP counter 7, while that
> counter is not exposed to the guest. Currently this is not gated and
> failures may only surface later during event programming.

Yes, but just for these pre-defined static constraints, it won't really
cause issue. If an event is constrained to GP counter 7 but there is no
such counter, then the event won't be really scheduled and enabled on the
counter. 


>
> Instead of dropping the constraints, should we validate counter
> availability in intel_pebs_constraints() or
> intel_get_event_constraints(), etc., and in a more generic way?

Yes, this is actually what the previous version did. In previous version,
we would leverage the dynamic constraints to limit the events additionally,
but just think twice, it's not best and simplest way to handle this issue.
It needs to allocate extra memory to store the dynamic constraints.


>
>
>> This is safe because, in pebs_baseline-capable cases, PEBS constraint
>> lookup already falls back to non-PEBS constraints when needed, and
>> fixed-counter constraints are effectively shared there.
> Can it really be removed without any consequences?
>
> If it is architecturally required that INST_RETIRED.PREC_DIST must run
> on fixed counter 0, then the constraint should be preserved. I think.

"INST_RETIRED.PREC_DIST" would still be constrained to fixed counter 0 by
the non-PEBS constraints, like the below constraints in corresponding
intel_icl_event_constraints[].

```

static struct event_constraint intel_icl_event_constraints[] = {
    FIXED_EVENT_CONSTRAINT(0x00c0, 0),    /* INST_RETIRED.ANY */
    FIXED_EVENT_CONSTRAINT(0x01c0, 0),    /* old INST_RETIRED.PREC_DIST */
    FIXED_EVENT_CONSTRAINT(0x0100, 0),    /* pseudo INST_RETIRED.ANY */

   ......

```

Currently as long as the PMU support PMU_FL_PEBS_ALL flag (adaptive PEBS
and arch-PEBS), if an event can't find the corresponding constraints for
PEBS constraints table, then it would fallback to the non-PEBS constraints,
like below code in intel_pebs_constraints() shows,

```

    /*
     * Extended PEBS support
     * Makes the PEBS code search the normal constraints.
     */
    if (x86_pmu.flags & PMU_FL_PEBS_ALL)
        return NULL;

```

If PMU doesn't support PMU_FL_PEBS_ALL flag on adaptive PEBS or arch-PEBS
hardware base, just like what currently KVM guest does, the PEBS
functionality is actually broken, and PEBS events should not be enabled.

Thanks.


>
>
>> Reported-by: Yi Lai <yi1.lai@intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/ds.c | 13 -------------
>>  1 file changed, 13 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index cb72af9b61ce..5db15a92017a 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -1447,10 +1447,6 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_icl_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
>> -
>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
>> @@ -1473,9 +1469,6 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_glc_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>> -
>>  	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
>>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
>>  	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
>> @@ -1500,9 +1493,6 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_lnc_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>> -
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
>>  
>> @@ -1534,9 +1524,6 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
>>  };
>>  
>>  struct event_constraint intel_pnc_pebs_event_constraints[] = {
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
>> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
>> -
>>  	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
>>  	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
>>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
