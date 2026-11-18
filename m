Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794981726;
	b=urtvq/UdahFD3xlbtutgtBJPD0UT5EeUJC30ScDB6th/GdeYtz5BzjXYRPlNR2U4KpPi
	 JnAKfZyq3RrjiLWwWFFPzHcKiAxTS4vpQv7XPu8fvxqz4npb6HMJp7cB6ghXoCssiDMIF
	 Ga0Y7YC40YgJXfS3eT3qe9/GNB8x4bfniVnph3KpchNA61C6B31t5ndSZJlYujTGlvpnQ
	 6vTECWKwX6Oae5seQgd4jqOY8H368H2rV7BKTuNKtPollisyK4XEXIDxn5+bI20KIcxbz
	 zQYpntG7sg8YQDi4B9/Ax9ux2UN6/mKVI2X55w9SomCh8bzefmHT/i1/XQedIo8GL5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794981726;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=KaVB9aQueRrDHM8zzK1HKjvmCb5KTm+vzXMLRGqV+PI=;
	b=i8xTcgeDld6lams1zgksTllRaxscR1tubsZ94KEm/BKPdGOqyKvlyaqkGaQ8f9eZbhc0
	 7fyj4CFiN3Df+lVjqGmTp26mLYmVyXoc49TCJ12K87Ou19Cd82+aGVh8vwkRTPBQ0l0SX
	 faKXq935cV9xyxznubfuHCRFh3ohY6PLKt/d7kMFOQ6tFkilMUFZdedj7N+fzfbxURW1N
	 ZTWxvDvciFJIG0sCbRqbzpyadx9euxXzPMMhTDuWN8we/sctLx6IOfcfUnjValWmxn/zy
	 h1Ki1r66xTvZjmvD4lFplGuzO/X4kQsUn1y4X8MAD1jD4GckJXJToeTYy2CKmY3Yv6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lvz3snR7;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89D8606A336;
	Wed, 18 Nov 2026 06:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E89D8606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lvz3snR7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794981726; x=1826517726;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8F/6G5/GHxCIt7vwPlD6K7Cor0Kb2dXbkqf4sGKH3T0=;
  b=lvz3snR7eaicxUYHJk/WLcA6QB7lxj6c+ZVZuPO0VeINDjWUEp6ROGxS
   EM6BC0DD4C8BVzGuOVIq0ve8q4MSqtny++GJfOxM30vwITYmieGHiChrK
   orPdtkJv0sQNxQ0xRvTOOEdTcNI7DZ0aYv6hoiUVftcO3ZYlTGfamOzjT
   SoAgOafSFrlfVRarztbnmRPG9wn+OEH6gsElke/YZRtVJQO4lsAuaF+LR
   9u95aPys61Q9+ngxcdQ21ptNU0Bt4kgkF+qAFTOOrrxZma8V6+31Wd1CH
   awwcmT6/4eJoYowBca2IM2ESVkwxYShUsXpl08MB3VfWcw6nkA+Kara3i
   w==;
X-CSE-ConnectionGUID: wJlO30BiTXmzM1zZIyscpw==
X-CSE-MsgGUID: NMC91AKTR4aWdZ/7jQSLqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3666229"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3666229"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 22:02:05 -0800
X-CSE-ConnectionGUID: KauGCPQSThWd3JMzOY7ekw==
X-CSE-MsgGUID: 7yU9sM28TvyeYUYDqcjmSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="11958009"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 22:01:57 -0800
Message-ID: <a4decd8d-0eb4-41f8-b106-446ab6d3d4df@linux.intel.com>
Date: Wed, 18 Nov 2026 14:01:54 +0800
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
Subject: Re: [Patch v7 04/24] perf/x86/intel: Limit branch snapshots to valid
 entries
To: bot+bpf-ci@kernel.org, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
 ak@linux.intel.com, eranian@google.com, sandipan.das@amd.com,
 andrii@kernel.org, song@kernel.org, ravi.bangoria@amd.com,
 ananth.narayan@amd.com
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 bpf@vger.kernel.org, dapeng1.mi@intel.com, zide.chen@intel.com,
 thomas.falcon@intel.com, xudong.hao@intel.com, sashiko-bot@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
 eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20261118031453.1353625-5-dapeng1.mi@linux.intel.com>
 <61848b4bb02d2dcb5f78b813f31a4f395805c864c1152c52374abc2ca1a1ff51@mail.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <61848b4bb02d2dcb5f78b813f31a4f395805c864c1152c52374abc2ca1a1ff51@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/18/2026 12:10 PM, bot+bpf-ci@kernel.org wrote:
>> perf/x86/intel: Limit branch snapshots to valid entries
> TL;DR: Resetting the shared lbr_stack.nr in intel_pmu_lbr_read() may corrupt
> an in-flight host adaptive-PEBS branch-stack sample when KVM vLBR is active
> and a BPF program calls bpf_get_branch_snapshot(); a later patch fixes it.
>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
> [ ... ]
>
>> @@ -1026,14 +1026,19 @@ void intel_pmu_lbr_read(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>> +	if (!cpuc->lbr_users || vlbr_exclude_host()) {
>> +		/* Reset lbr_stack.nr to prevent stale data leakage. */
>> +		cpuc->lbr_stack.nr = 0;
>> +		return;
>> +	}
>> +
> Can this reset of cpuc->lbr_stack.nr corrupt a host adaptive-PEBS sample
> that is still in flight?
>
> Before this patch the vlbr_exclude_host() case returned without writing
> anything.  Now the BPF snapshot path writes to the same per-CPU struct
> that a PMI-time sample may still point at:
>
> intel_pmu_handle_irq()
>   handle_pmi_common() -> x86_pmu_drain_pebs
>     __intel_pmu_pebs_last_event()
>       setup_pebs_adaptive_sample_data()
>         intel_pmu_store_pebs_lbrs(lbr)   /* cpuc->lbr_stack.nr = N */
>         intel_pmu_lbr_save_brstack()
>           perf_sample_save_brstack()     /* data->dyn_size += N entries */
>                                          /* data->br_stack = &cpuc->lbr_stack */
>       perf_event_overflow()
>         __perf_event_overflow()
>           bpf_overflow_handler()
>             BPF prog -> bpf_get_branch_snapshot()
>               __intel_pmu_snapshot_branch_stack()
>                 intel_pmu_lbr_read()     /* vlbr_exclude_host(): nr = 0 */
>           overflow_handler() -> perf_output_sample()
>             perf_output_put(handle, data->br_stack->nr);       /* now 0 */
>             perf_output_copy(handle, data->br_stack->entries, ...);
>
> The record header was sized for N branch entries, but nr is now 0 and no
> entries are written, so the PEBS LBR data for that sample is lost and the
> tail of the record is never written.
>
> This looks reachable when KVM's vLBR event is active (it sets
> INTEL_PMC_IDX_FIXED_VLBR in intel_ctrl_exclude_host_mask) alongside a host
> PEBS event using PERF_SAMPLE_BRANCH_STACK, with a perf_event BPF program
> calling bpf_get_branch_snapshot().  Before this patch the same sequence
> produced a consistent sample.
>
> The !cpuc->lbr_users half of the condition does not look affected, since
> any event whose sample references cpuc->lbr_stack is counted in lbr_users.
>
> The series appears to fix this later in 61909a79de63 ("perf/x86/intel:
> Use a dedicated LBR stack for BPF snapshotting"), where
> intel_pmu_lbr_read() takes the stack to fill as a parameter.  Is it worth
> avoiding the shared-stack write in this patch, so that the intermediate
> commit does not have this window?

Yeah, the patch order can be refined. But I'm not sure if it's worthy to
post a new version just for the patch sequence. Anyway, I would refine this
patch order if there is a new version. Thanks.


>
>>  	/*
>>  	 * Don't read when all LBRs users are using adaptive PEBS.
>>  	 *
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44231525404
