Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B287D1C5F1B
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Apr 2026 05:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776747834; cv=none; b=HvfbYOmldpcN4C0eRnQzxVwAfbCRd+i971Hx3oCodIdTxoEZvIAl/mPtBw97D0JUoDLUwy1SPf6d88gGKPlYnjnTpGwuAzKh/X56gzcSAlrVHte6OCX/jBIrVqw7yXLRCw3u319etT19wnntNU9ROeoBp2f/c0DhF9Ms9S8Cz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776747834; c=relaxed/simple;
	bh=xwMKmWiI4a6VfwuR3Q9PRfDn8JfujjN/eAGvdJrq3ew=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WOF2DWYIKvfyNjeV7KBawERPHfBElPE0aff5rVX/L8aD2JTkH2Yo0cnDzmVqLNVodUdQH0jC+qKRJcjJ7Sx2y/eCEHq4wcuenjlNegAKPdzS+4YIGjPq2G5SHHAtOLUF4gy/wqMXYKKAp3xizY38GFb4+0Hv5uAKYUmGGF+zCBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jr94sFhu; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jr94sFhu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776747833; x=1808283833;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=xwMKmWiI4a6VfwuR3Q9PRfDn8JfujjN/eAGvdJrq3ew=;
  b=Jr94sFhuwvTXediV8DMF1xErhvFzPxTlcx0x0Zbn6angx2OmSNYHIlri
   KqF+iOUpVNACbucs2LmX8hCaMfeCmV91haOnHS1SSzkfgIQ02zRDL8tLa
   VK3mvTEVhdDuzECJ8IGSuO3G9MUmBImbNNQRh09UqMffg3LlcnF+A40k1
   mgqiGuvKgq0/BREoMkizNNYkghTrF7IKo69uOtih7Cy5nedb1ZzNUOuIz
   BCSyHQ+bz4mbKACfX+Pak1vUcmf+dQhzQMle2ET6ihXV4f9NQ4c7zjEya
   vsGHFGcwhVPuyJb6aAoSzTiaZy6w/wxHecXx4vufoeAMujOhmvE6qL9pq
   A==;
X-CSE-ConnectionGUID: 7jiqJ8BkTcOecsqbcNE5Gw==
X-CSE-MsgGUID: Pj+6ifO8QVa0luTnP6lOGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="76838112"
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="76838112"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 22:03:52 -0700
X-CSE-ConnectionGUID: 4HJyDC6VTLyUbswsUb1p2A==
X-CSE-MsgGUID: YgYpZ6wTQEaRL+HcrslMUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,191,1770624000"; 
   d="scan'208";a="232205989"
Received: from unknown (HELO [10.238.3.127]) ([10.238.3.127])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 22:03:51 -0700
Message-ID: <3a54cbc0-a707-438f-b87e-5f608b5c26db@linux.intel.com>
Date: Tue, 21 Apr 2026 13:03:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 1/4] perf/x86/intel: Clear stale ACR mask before
 updating new mask
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260420024528.2130065-2-dapeng1.mi@linux.intel.com>
 <20260420032402.A8971C19425@smtp.kernel.org>
 <717f00c7-be8d-4f69-88ab-5a060a6a7e65@linux.intel.com>
Content-Language: en-US
In-Reply-To: <717f00c7-be8d-4f69-88ab-5a060a6a7e65@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/20/2026 2:29 PM, Mi, Dapeng wrote:
> On 4/20/2026 11:24 AM, sashiko-bot@kernel.org wrote:
>> Sashiko AI review found 1 potential issue(s):
>> - [High] Unvalidated user input in ACR setup leads to cross-user hardware state corruption and PMU DoS
>> --
>>
>> commit 67dc3d7b096879ed6418f54978bf45536496156f
>> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>>
>> perf/x86/intel: Clear stale ACR mask before updating new mask
>>
>> This commit zeroes out the ACR mask (event->hw.config1) for all scheduled
>> events before applying a new mask. This ensures that bits from a previous
>> stale ACR mask do not persist and pollute the hardware state during event
>> rescheduling.
>>
>>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>>> index 4768236c054bb..774ae9a4eeaf8 100644
>>> --- a/arch/x86/events/intel/core.c
>>> +++ b/arch/x86/events/intel/core.c
>>> @@ -3334,6 +3334,12 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>>>  	struct perf_event *event, *leader;
>>>  	int i, j, idx;
>>>  
>>> +	/* Clear stale ACR mask first. */
>>> +	for (i = 0; i < cpuc->n_events; i++) {
>>> +		event = cpuc->event_list[i];
>>> +		event->hw.config1 = 0;
>>> +	}
>>> +
>> Does this new clearing loop inadvertently amplify an existing regression where
>> a single user can disable Auto Counter Reload for all processes on the same CPU?
>>
>> Looking further down in the same function, the code iterates over
>> user-controlled bits from event->attr.config2:
>>
>> arch/x86/events/intel/core.c:intel_pmu_acr_late_setup() {
>>     ...
>>     for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
>>         if (i + idx >= cpuc->n_events ||
>>             !is_acr_event_group(cpuc->event_list[i + idx]))
>>             return;
>>         __set_bit(cpuc->assign[i + idx], (unsigned long *)&event->hw.config1);
>>     }
>>     ...
>> }
>>
>> Because idx is derived from the user-controlled event->attr.config2 mask
>> without being validated against the actual size of the event group, a
>> user could provide an artificially large idx.
>>
>> The validation in intel_pmu_hw_config() only checks the weight of the mask
>> using hweight64(), rather than checking the actual bit indices, leaving this
>> exposed. Subsequent patches in the series do not fix this.
>>
>> If the computed index hits a non-ACR event or exceeds cpuc->n_events, the
>> loop triggers an early return. Since the newly added code zeroes out
>> event->hw.config1 for all scheduled events before this loop, wouldn't this
>> early return leave all subsequent valid ACR events with a cleared mask?
>>
>> Additionally, if the out-of-bounds idx points to another user's valid ACR
>> group, is_acr_event_group() returns true, and the code proceeds to update
>> the event->hw.config1 with the victim's hardware counter index.
>>
>> Could this also result in cross-user state corruption of event->hw.config1
>> when the event overflows and cross-reloads the victim's counter?
> That looks a real potential issue. Current validation for the acr_mask
> needs to be enhanced. The acr_mask from user space should not exceeds the
> index bitmap of current ACR events group.
> Thanks.

The following changes would be done to address all current found issues.
 - Calculate the indices bitmap for each ACR events group. Any bits in
    the user-space mask not present in the group's bitmap are now dropped.
 - Instead of an early return on invalid bits, drop only the invalid
    portions and continue iterating through all ACR events to ensure full
    configuration.
 - Explicitly clear the stale hardware ACR mask for each event prior to
    writing the new configuration.

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4768236c054b..1a2c268018a2 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3332,23 +3332,41 @@ static void intel_pmu_enable_event(struct
perf_event *event)
 static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
 {
        struct perf_event *event, *leader;
-       int i, j, idx;
+       int i, j, k, bit, idx;
+       u64 group_mask;

        for (i = 0; i < cpuc->n_events; i++) {
                leader = cpuc->event_list[i];
                if (!is_acr_event_group(leader))
                        continue;

-               /* The ACR events must be contiguous. */
+               /* Find the last event of the ACR group. */
                for (j = i; j < cpuc->n_events; j++) {
                        event = cpuc->event_list[j];
                        if (event->group_leader != leader->group_leader)
                                break;
-                       for_each_set_bit(idx, (unsigned long
*)&event->attr.config2, X86_PMC_IDX_MAX) {
-                               if (i + idx >= cpuc->n_events ||
-                                   !is_acr_event_group(cpuc->event_list[i
+ idx]))
-                                       return;
-                               __set_bit(cpuc->assign[i + idx], (unsigned
long *)&event->hw.config1);
+               }
+
+               /* Figure out the group indices bitmap. */
+               group_mask = 0;
+               for (k = i; k < j; k++)
+                       group_mask |= BIT_ULL(cpuc->assign[k]);
+
+               /*
+                * Translate the user-space ACR mask (attr.config2) into
the physical
+                * counter bitmask (hw.config1) for each ACR event in the
group.
+                * NOTE: ACR event contiguity is guaranteed by
intel_pmu_hw_config().
+                */
+               for (k = i; k < j; k++) {
+                       event = cpuc->event_list[k];
+                       event->hw.config1 = 0;
+                       for_each_set_bit(bit, (unsigned long
*)&event->attr.config2, X86_PMC_IDX_MAX) {
+                               idx = i + bit;
+                               if (idx >= cpuc->n_events ||
+                                   !(BIT_ULL(cpuc->assign[idx]) &
group_mask) ||
+                                   !is_acr_event_group(cpuc->event_list[idx]))
+                                       continue;
+                               __set_bit(cpuc->assign[idx], (unsigned long
*)&event->hw.config1);
                        }
                }
                i = j - 1;


>
>
>>>  	for (i = 0; i < cpuc->n_events; i++) {
>>>  		leader = cpuc->event_list[i];
>>>  		if (!is_acr_event_group(leader))
