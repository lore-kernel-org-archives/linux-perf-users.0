Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C648134E75A;
	Wed, 30 Sep 2026 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790730763; cv=none; b=JCiWZlm5QJlPHLtdgPKf3uXZQWAy5nMbY8sE/dMJvgckbtmYrY8EXmt/jDpiroS710NXgd3JkIOqbpCgn6L4auJBYBD7H8rztCiezT57cLFZo13hz8pHNbmD/9K9fLk8KgXpJ1hPRCavxwIqrwpWYu++pOL5i/tEre0BzRu8YEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790730763; c=relaxed/simple;
	bh=5nRbjZaUgx42IQXNVDkipkuZ7NaN6D0ouhAyZoZ7r2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ewzs/jYxXahtoJlwe7JykYbU1IneGlu7ZO4MKHDiwrdo2t8i54hb1wZTrbvBGJCC+KrBX4wh3sESB3MchmQXHhINDHcnU6Dvw8C5lEtsA4CmgCVXrHXGehm7sVgElgx9+t2dMH/AT/YsWc/G3q84dVBIRJ4TSioZWAizhIEriz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OfhWrY0A; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OfhWrY0A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790730761; x=1822266761;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5nRbjZaUgx42IQXNVDkipkuZ7NaN6D0ouhAyZoZ7r2A=;
  b=OfhWrY0AUNDyDLt4y8tkNwHJwBYTFbEmOniRGQkx8cslO9DYS0sRUlg+
   odoAPBUwQXqS8sgolQR5GoVULdTKdqZUN/8CsNYIsrMpB6s4fVlk3WDWk
   2GUIm63pHxGY0aBRCKlrpkKziKaY9TndCOw9Bv8IzQhjvCWAyBI+Og7TB
   0Px37yltAWO/11id5kffnHViJarfXWIFnfvuQM2WGZBYiKKgI1Bm9hI8l
   RAmIufsAyVjXGpnQANE0lqeVaBHIIshq7uvWrN8EjuXZM9181pRnd57Vt
   dYF4qfQKc8YpPkDdZoc/cFuw5WqtQQGqayZm3BvnClp7mpRUfkUXAXPn1
   w==;
X-CSE-ConnectionGUID: 7M55dzwHS5+JRpyQdM4ECA==
X-CSE-MsgGUID: F0Wzve2FRWCIgH57PBq9wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="116989758"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="116989758"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:12:40 -0700
X-CSE-ConnectionGUID: 5wHsfxrpSHOqd+DQtEJs0g==
X-CSE-MsgGUID: GhjST1o1SzWmPS+AdjlZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="272010266"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 18:12:36 -0700
Message-ID: <afe2daf9-8bb1-4c99-be8e-31c828b4b2d7@linux.intel.com>
Date: Wed, 30 Sep 2026 09:12:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] perf/x86/intel: Reject SAMPLE_READ for
 no-counter-snapshot ACR events
To: "Falcon, Thomas" <thomas.falcon@intel.com>,
 "alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "acme@kernel.org" <acme@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
 "Hunter, Adrian" <adrian.hunter@intel.com>,
 "namhyung@kernel.org" <namhyung@kernel.org>, "Rogers, Ian"
 <irogers@google.com>, "Eranian, Stephane" <eranian@google.com>
Cc: "Chen, Zide" <zide.chen@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
 "Mi, Dapeng1" <dapeng1.mi@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
 <20260928074309.898043-8-dapeng1.mi@linux.intel.com>
 <98d9d6347bd0704e8fa773b458e12c7a850c49cb.camel@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <98d9d6347bd0704e8fa773b458e12c7a850c49cb.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/30/2026 3:02 AM, Falcon, Thomas wrote:
> On Mon, 2026-09-28 at 15:43 +0800, Dapeng Mi wrote:
>> ACR events cannot always provide a reliable value through SAMPLE_READ.
>> For non-PEBS ACR events, another ACR overflow can auto-reload the counter
>> before software reads it, so software cannot sample the exact count before
>> the hardware reload.
>>
>> PEBS-backed ACR events are safe only when counter snapshot support is
>> available, because the value is captured in the PEBS record before the
>> counter is reloaded.
>>
>> Reject SAMPLE_READ for ACR event groups unless the event has PEBS
>> counter snapshot support, so perf does not report invalid counts.
>>
>> Reported-by: Andi Kleen <ak@linux.intel.com>
>> Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 59 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 377ff3912420..3fc3795534bf 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4974,6 +4974,53 @@ static inline int intel_set_branch_counter_constr(struct perf_event *event,
>>  	return 0;
>>  }
>>  
>> +static inline bool is_acr_sample_read_allowed(struct perf_event *event,
>> +					      bool group_has_sample_read)
>> +{
>> +	/*
>> +	 * ACR events cannot report an accurate count for non-PEBS events
>> +	 * or for PEBS events without counter snapshots: another ACR event
>> +	 * may overflow andauto-reload the counter before software can read
> Just wanted to point out the typo here. Other than that, this patch and the rest of the series look good to me...

Good catch. Thanks.

I'd like to wait one or two weeks to see if Peter and other guys have other
comments, and fix them all in version 2. 


>
> Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
>
>> +	 * the precise value.
>> +	 *
>> +	 * We keep the check simple and do not validate the acr_mask precisely
>> +	 * to determine whether the SAMPLE_READ event is actually auto-reloaded
>> +	 * by another ACR event. If a SAMPLE_READ event is in the group, the
>> +	 * ACR event must be a PEBS event with counter snapshots; otherwise it
>> +	 * is rejected.
>> +	 */
>> +	if (group_has_sample_read && is_sampling_event(event) &&
>> +	    (!event->attr.precise_ip || !is_pebs_counter_event_group(event)))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>> +static bool intel_pmu_allow_acr_sample_read(struct perf_event *event,
>> +					    bool group_has_sample_read)
>> +{
>> +	struct perf_event *leader = event->group_leader;
>> +	struct perf_event *sibling;
>> +
>> +	if (!is_acr_sample_read_allowed(leader, group_has_sample_read))
>> +		return false;
>> +
>> +	if (leader->nr_siblings) {
>> +		for_each_sibling_event(sibling, leader) {
>> +			if (!is_acr_sample_read_allowed(sibling,
>> +						group_has_sample_read))
>> +				return false;
>> +		}
>> +	}
>> +
>> +	/* event isn't installed as a sibling yet. */
>> +	if ((event != leader) &&
>> +	    !is_acr_sample_read_allowed(event, group_has_sample_read))
>> +		return false;
>> +
>> +	return true;
>> +}
>> +
>>  static int intel_pmu_hw_config(struct perf_event *event)
>>  {
>>  	int ret = x86_pmu_hw_config(event);
>> @@ -5117,6 +5164,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		struct perf_event *sibling, *leader = event->group_leader;
>>  		struct pmu *pmu = event->pmu;
>>  		bool has_sw_event = false;
>> +		bool has_sample_read = false;
>>  		int num = 0, idx = 0;
>>  		u64 cause_mask = 0;
>>  
>> @@ -5162,8 +5210,14 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		if (leader->attr.config2)
>>  			intel_pmu_set_acr_cntr_constr(leader, &cause_mask, &num);
>>  
>> +		if ((leader->attr.sample_type & PERF_SAMPLE_READ) ||
>> +		    (event->attr.sample_type & PERF_SAMPLE_READ))
>> +			has_sample_read = true;
>> +
>>  		if (leader->nr_siblings) {
>>  			for_each_sibling_event(sibling, leader) {
>> +				if (sibling->attr.sample_type & PERF_SAMPLE_READ)
>> +					has_sample_read = true;
>>  				if (!is_x86_event(sibling)) {
>>  					has_sw_event = true;
>>  					continue;
>> @@ -5175,6 +5229,7 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  				intel_pmu_set_acr_cntr_constr(sibling, &cause_mask, &num);
>>  			}
>>  		}
>> +
>>  		if (leader != event && event->attr.config2) {
>>  			if (has_sw_event)
>>  				return -EINVAL;
>> @@ -5184,6 +5239,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
>>  		if (hweight64(cause_mask) > hweight64(hybrid(pmu, acr_cause_mask64)) ||
>>  		    num > hweight64(hybrid(event->pmu, acr_cntr_mask64)))
>>  			return -EINVAL;
>> +
>> +		if (!intel_pmu_allow_acr_sample_read(event, has_sample_read))
>> +			return -EINVAL;
>> +
>>  		/*
>>  		 * In the second round, apply the counter-constraints for
>>  		 * the events which can cause other events reload.
