Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793948840;
	b=hNZsrcz7DdLXRqiKShbqQF0IQolCGVBKwFtQZceUHoLU2Sa/nmKIQnq6jASrtadmeMKr
	 KsYNAEEbyB3RuoHsI1PAI0BDkvzs93qInS1jHLXABjfQfzMsbsjaQL1NKqYC1fSceCOuv
	 ooKLUGJoWGhf4v1Sg77G+F1vrpgoKTqyceA+mxkRE5dic7sV/4P2m8zR/bgyP/f4rXWuo
	 Lq9GHc2Wa+qfDMwHT4v+84Z+v5JDRxTwi8e0zJ9fiHPSU0elLw3Uvu4AZJMj7EBHlZhTN
	 tsb8tfuJOqPXAPKKbmcrfFXtXKchdKU6CP/FoDzFSO3hCK8kdRUoogmqmAN+EdsvijQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793948840;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Zc+3YvyVljRF2wCC5ReTQTHDEIZMfGYDGiyjt0kQoBc=;
	b=NDguMHGc8PqUkhKW9irnTfI/YAPsZREr+QLGIInPDsed6nUhkhnvJONz9MksOo5II04p
	 8DmpVhpss1cmo9SK3eHyqmH6hiS0ZnvZd4ngS+KVuByi4HsRC4+o7YEa+K2Q3uTFpL5nt
	 5QHPmEBFgUotu9VfFXYb+HZIKfONJLqprUNIQ0UsXrE9hILMEeEG5ypwCUwNTqV+fIUkR
	 bgKBy2WkiMRqYUVulZ08ddfhtHUE3mfY3n04fwbif/a6UZGPTF2nVRjyLhc7IwgUWehZP
	 upLQvHWNyJNSqj/FHFe0uI6/tJzowyEiZPmlhpehWXyf3ig6N63itXEM/o+6Z8aE26w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="kxYTn/d2";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5DC606A32E;
	Fri,  6 Nov 2026 07:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E5DC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kxYTn/d2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793948839; x=1825484839;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Ogc44+PrMm9JaehxvQFyal3jUrT3uzIlfVMGfE+oOI=;
  b=kxYTn/d2IwXLBhPyz8sSreP37ao/5cuPTLi1pBorQgqtCVbwBmzaNzxo
   Xm3ZiAd0v05JKEVP8IzycdA5b1Hvw+siM59tTCt/PunHozsWggUXSnIhG
   dOM5++3z175WI+ZHDcPzC1boLVzfVYoHcrextaQyvSJgCaSMmTAsn4vc2
   9lIJCKRvuChDDnIe0PEsBPhIIgsHwp0yZ0W+ROnudSulkC409Db82Y2aq
   Fe04prdgzO29ZEIeMpRpgx43bWmsXELNkmQff8e3vwSgYeVddZNKU0JCs
   Uv8hclFEAolw2q/QFAxHIdgUETtk+rQbvquo6IwHU5kSeMiuN9Yxd9y9g
   Q==;
X-CSE-ConnectionGUID: nLPCMJ4JT5+5WlcwhK7n1w==
X-CSE-MsgGUID: GavXxd2CQ/yiJkcb4lwDQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2857079"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2857079"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:07:19 -0800
X-CSE-ConnectionGUID: kKG2rLztRbyQcweQi7IEDw==
X-CSE-MsgGUID: 3rdCzIQTTzu+1HG2KAbl+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="8965633"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 23:07:17 -0800
Message-ID: <4857ec01-42bf-4ba3-bb27-eedbfd94f61b@linux.intel.com>
Date: Fri, 6 Nov 2026 15:07:15 +0800
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
Subject: Re: [Patch v6 06/20] perf/x86/amd: Avoid re-enabling PMU and LBR for
 BPF when disabled
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
 <20261106043257.842864-7-dapeng1.mi@linux.intel.com>
 <sashiko-outbox-200787@kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <sashiko-outbox-200787@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/6/2026 1:01 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf/x86/amd: amd_pmu_v2_snapshot_branch_stack() leaves cpuc->enabled set
> --
>
> commit dbf85e8b6a5abeff651d80166ad0c339896c5b42
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/amd: Avoid re-enabling PMU and LBR for BPF when disabled
>
> This commit updates amd_pmu_v2_snapshot_branch_stack() to save cpuc->enabled
> and cpuc->lbr_enabled before disabling the PMU and LBR, and only re-enable
> them if they were previously enabled.
>
>> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
>> index bf631f60757cc..851d8a938f522 100644
>> --- a/arch/x86/events/amd/core.c
>> +++ b/arch/x86/events/amd/core.c
>> @@ -932,22 +932,28 @@ static int amd_pmu_v2_snapshot_branch_stack(struct perf_branch_entry *entries, u
>>  {
>>  	struct cpu_hw_events *cpuc;
>>  	unsigned long flags;
>> +	int pmu_enabled;
>> +	int lbr_enabled;
>>  
>>  	/*
>>  	 * The sequence of steps to freeze LBR should be completely inlined
>>  	 * and contain no branches to minimize contamination of LBR snapshot
>>  	 */
>>  	local_irq_save(flags);
>> +	cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	pmu_enabled = cpuc->enabled;
>> +	lbr_enabled = cpuc->lbr_enabled;
>>  	amd_pmu_core_disable_all();
>>  	__amd_pmu_lbr_disable();
>>  
>> -	cpuc = this_cpu_ptr(&cpu_hw_events);
>> -
>>  	amd_pmu_lbr_read();
>>  	cnt = min(cnt, cpuc->lbr_stack.nr);
>>  	memcpy(entries, cpuc->lbr_entries, sizeof(struct perf_branch_entry) * cnt);
>>  
>> -	amd_pmu_v2_enable_all(0);
>> +	if (lbr_enabled)
>> +		amd_pmu_lbr_enable_all();
>> +	if (pmu_enabled)
>> +		amd_pmu_core_enable_all();
> [Severity: Medium]
> As reported by Sashiko on v5 [1], while __amd_pmu_lbr_disable() clears
> cpuc->lbr_enabled = 0, amd_pmu_core_disable_all() only clears the hardware
> global control MSR and leaves cpuc->enabled set to 1.
>
> If a BPF program in non-NMI context calls bpf_get_branch_snapshot() ->
> amd_pmu_v2_snapshot_branch_stack() while cpuc->enabled is 1, local_irq_save()
> does not mask NMIs. If an NMI arrives while amd_pmu_v2_snapshot_branch_stack()
> is reading LBR MSRs or copying entries, perf_event_nmi_handler() ->
> amd_pmu_v2_handle_irq() will see cpuc->enabled == 1 and re-enable the core PMU
> counters on exit:

This issue should never happen in reality since amd_pmu_core_disable_all()
would disable PMU, so no PMI can be interrupt the BPF LBR snapshot.



>
> arch/x86/events/amd/core.c:amd_pmu_v2_handle_irq() {
> 	pmu_enabled = cpuc->enabled;
> 	cpuc->enabled = 0;
>
> 	/* Stop counting but do not disable LBR */
> 	amd_pmu_core_disable_all();
> 	...
> done:
> 	cpuc->enabled = pmu_enabled;
>
> 	/* Resume counting only if PMU is active */
> 	if (pmu_enabled)
> 		amd_pmu_core_enable_all();
> }
>
> Similarly, if an NMI triggers a nested BPF call to
> amd_pmu_v2_snapshot_branch_stack(), the nested call will also observe
> cpuc->enabled == 1 and call amd_pmu_core_enable_all() before returning to the
> outer snapshot.
>
> Should amd_pmu_v2_snapshot_branch_stack() clear cpuc->enabled = 0 after saving
> pmu_enabled and restore cpuc->enabled = pmu_enabled before re-enabling the
> core PMU, matching amd_pmu_v2_handle_irq()?
>
> [1] https://lore.kernel.org/r/20261029043914.1395147-7-dapeng1.mi@linux.intel.com
>
