Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650471C1735;
	Tue, 21 Jan 2025 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473110; cv=none; b=jBwabmwXD2Wgs2LH1excV+JS8//Z+iRHKeaTP15e//V7tEy13Pv5gu3d3RzW7HaLwDaNkayA5JQxo4OokzHhM5rGebhO9EJYXbxgCLDXahVrQWogzTWqx9VenJIKdHz44ZK+v//d1UTngTq6NhBujgqGtlBbchCmvP5/nlz3xk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473110; c=relaxed/simple;
	bh=ZvYrvPoCdOMPwJGbJxu9v191ZljnAWqGwNKeqQ4ZkA4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TuJBFFTDlsxF+/5TaACCYSzxER4wIQxBpbDPRg/8HD2gtxZ38gRjxX7rPWTwOj8llV+a/bPY3Mm7RXDTMeRRZFsbfS3Br5XhGTiQ/F3IBcvASb/We1eEXKhXUgLVL/gC58JceKNc71NafVYEoB5N9saRyoIifGrwYhpuTqZBVbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FjPkVxEJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FjPkVxEJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737473110; x=1769009110;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=ZvYrvPoCdOMPwJGbJxu9v191ZljnAWqGwNKeqQ4ZkA4=;
  b=FjPkVxEJiceB3Gtt1S95uL+ZinAENa3EOGuLsxirqg1QwnzydftfkoLK
   KDTSxLlqWHVlvx3hWJAx3lVFaHJEJq8NKNNMiLYqHigUDH1UOaHOgamat
   NJpEJCRWOXZIojXMm6WilklslSTedWEqUjoHB15KT0zLKbjFg1m8IQVbr
   lnXO9tMQlEJKliZw/a8ZYFHH2pi8FivSVI/FjQNVYWAOX5OoUZMeI+5mo
   j9HePYbnuthy0VnAnNoHckXmSjrIx7FQgHeEmieCo8iSV0IzkdbiXOdo8
   9eRRtysSXYbI38vjTFw4tti74wEo5mDkVN9+DCh2Ln2M2O0w0KMUKDCYn
   w==;
X-CSE-ConnectionGUID: n+V/jflBTZqYv7vVwokYWA==
X-CSE-MsgGUID: xsuW3FWFTL+mUoa7MpgFjg==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="48386659"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="48386659"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:25:09 -0800
X-CSE-ConnectionGUID: PfoxyYwYSUq/2S4rHWhAWQ==
X-CSE-MsgGUID: RI8zPYDZSAm94N269yMgYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="106665031"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 07:25:06 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id DB40F20B5713;
	Tue, 21 Jan 2025 07:25:04 -0800 (PST)
Message-ID: <e05bb0c7-cbbb-422a-882c-1dfa648b29e9@linux.intel.com>
Date: Tue, 21 Jan 2025 10:25:03 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
From: "Liang, Kan" <kan.liang@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, ak@linux.intel.com, eranian@google.com,
 dapeng1.mi@linux.intel.com
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
 <20250115184318.2854459-3-kan.liang@linux.intel.com>
 <20250116114751.GJ8362@noisy.programming.kicks-ass.net>
 <be90e73b-eedf-4ff0-a832-b579e003cac9@linux.intel.com>
 <20250116204225.GA7232@noisy.programming.kicks-ass.net>
 <20250116205659.GA15641@noisy.programming.kicks-ass.net>
 <7f0ed750-b4b3-4adc-98d2-1e9cccd3bf02@linux.intel.com>
Content-Language: en-US
In-Reply-To: <7f0ed750-b4b3-4adc-98d2-1e9cccd3bf02@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-16 4:50 p.m., Liang, Kan wrote:
> 
> 
> On 2025-01-16 3:56 p.m., Peter Zijlstra wrote:
>> On Thu, Jan 16, 2025 at 09:42:25PM +0100, Peter Zijlstra wrote:
>>> On Thu, Jan 16, 2025 at 10:55:46AM -0500, Liang, Kan wrote:
>>>
>>>>> Also, I think I found you another bug... Consider what happens to the
>>>>> counter value when we reschedule a HES_STOPPED counter, then we skip
>>>>> x86_pmu_start(RELOAD) on step2, which leave the counter value with
>>>>> 'random' crap from whatever was there last.
>>>>>
>>>>> But meanwhile you do program PEBS to sample it. That will happily sample
>>>>> this garbage.
>>>>>
>>>>> Hmm?
>>>>
>>>> I'm not quite sure I understand the issue.
>>>>
>>>> The HES_STOPPED counter should be a pre-existing counter. Just for some
>>>> reason, it's stopped, right? So perf doesn't need to re-configure the
>>>> PEBS__DATA_CFG, since the idx is not changed.
>>>
>>> Suppose you have your group {A, B, C} and lets suppose A is the PEBS
>>> event, further suppose that B is also a sampling event. Lets say they
>>> get hardware counters 1,2 and 3 respectively.
>>>
>>> Then lets say B gets throttled.
>>>
>>> While it is throttled, we get a new event D scheduled, and D gets placed
>>> on counter 2 -- where B lives, which gets moved over to counter 4.
>>>
>>> Then our loops will update and remove B from 2, but because
>>> throttled/HES_STOPPED it will not start it on counter 4.
>>>>> Meanwhile, we do have the PEBS_DATA_CFG thing updated to sample counter
>>> 1,3 and 4.
>>>
>>> PEBS assist happens, and samples the uninitialized counter 4.
>>> Also, by skipping x86_pmu_start() we miss the assignment of
>> cpuc->events[] so PEBS buffer decode can't even find the dodgy event.
>>
> 
> Yes, counter 4 includes garbage before the B is started again.
> But the cpuc->events[counter 4] is NULL either.
> 
> The current implementation ignores the NULL cpuc->events[]. The stopped
> B should not be mistakenly updated.
> 
> +static void intel_perf_event_pmc_to_count(struct perf_event *event, u64
> pmc)
> +{
> +	int shift = 64 - x86_pmu.cntval_bits;
> +	struct hw_perf_event *hwc;
> +	u64 delta, prev_pmc;
> +
> +	/*
> +	 * The PEBS record doesn't shrink on pmu::del().
> +	 * See pebs_update_state().
> +	 * Ignore the non-exist event.
> +	 */
> +	if (!event)
> +		return;
> 
> 

I've sent a V10 to address all the comments in V9.
The above case is explained in the comments of
intel_perf_event_update_pmc() in V10.
https://lore.kernel.org/lkml/20250121152303.3128733-4-kan.liang@linux.intel.com/

Please take a look and let me know if it's not sufficient to handle the
case.

Thanks,
Kan
