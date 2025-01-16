Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BB314901B;
	Thu, 16 Jan 2025 21:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064206; cv=none; b=Z9qrUKHjtWi/6Oc5YoRBafikIXkw85uykGdF+syu5kfpnHHU6nRf3L0cstYfG8qi9EgyEOASa+2Ios9Bi/Nl5DVxVn6GtADcppJJH+30S8Vi+V1n17CbHfhvfplcznB5okWlrj5TnjQkIhNwjjHVC1sxOup2X2TWw7rFgBR7b8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064206; c=relaxed/simple;
	bh=0or8MCVZR7HtooRHEHmtCe8ADy7yjC3GZJkJFUnSx1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpEknJfy+O1cVVnD4thFR4YF2tDSxYyNZX35eIcwlG+GYOtx8r2Zat3751bHYHF8X6gnbyJzHFBMg8WdVgppHBIbNgaLkJmqo8Yrh7lgkSUhoz5LEBQoXmZLIZHI//Tv/TTAQR2qFvvFlZ2Yt5+R8C9QoOXfJQ25BB6iMGWMhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hl7q7K/b; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hl7q7K/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737064205; x=1768600205;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0or8MCVZR7HtooRHEHmtCe8ADy7yjC3GZJkJFUnSx1A=;
  b=hl7q7K/bSXpmWDlgLmTlbNU+nsWzTHZX3Issk8/MkzliPz1kEio/5ppr
   RDzSxbbjtsSgr9KNUii43jqlRNAz4m7BtC+d/jLHg+u85e04QkMa86QBP
   ut0j33gDwdOmzyHMq4R6NZZ8VYIFqSX6pnjhwFIwxOP+4OAnd3QRMW38g
   NpHBybj8I8RKP6A/5/YeseYQKZcDiaHS3GY3wNjGVtQnDaO5GH6+IFvse
   wH52ARgnzL2aXb9Kuh0g4QH+F2MoC+7xpxR1J4ehZni1qu7oRbvBXAYnn
   SbAqBEtT8ftEWkaqfM4G8OHTY/SLQaHpy7CcmJjobwm6FIEqbtykOMFAV
   g==;
X-CSE-ConnectionGUID: nrX8upStThiyN4hW8s77wQ==
X-CSE-MsgGUID: kzsfh7yKQWSA4/IBg6HV0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41156989"
X-IronPort-AV: E=Sophos;i="6.13,210,1732608000"; 
   d="scan'208";a="41156989"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:50:05 -0800
X-CSE-ConnectionGUID: qFONw28pQDqYUd7aBe/duA==
X-CSE-MsgGUID: 3uPxrQeSTyGtu7wvA4EkpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128868218"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 13:50:04 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7AFDD20B5713;
	Thu, 16 Jan 2025 13:50:02 -0800 (PST)
Message-ID: <7f0ed750-b4b3-4adc-98d2-1e9cccd3bf02@linux.intel.com>
Date: Thu, 16 Jan 2025 16:50:01 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
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
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250116205659.GA15641@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-16 3:56 p.m., Peter Zijlstra wrote:
> On Thu, Jan 16, 2025 at 09:42:25PM +0100, Peter Zijlstra wrote:
>> On Thu, Jan 16, 2025 at 10:55:46AM -0500, Liang, Kan wrote:
>>
>>>> Also, I think I found you another bug... Consider what happens to the
>>>> counter value when we reschedule a HES_STOPPED counter, then we skip
>>>> x86_pmu_start(RELOAD) on step2, which leave the counter value with
>>>> 'random' crap from whatever was there last.
>>>>
>>>> But meanwhile you do program PEBS to sample it. That will happily sample
>>>> this garbage.
>>>>
>>>> Hmm?
>>>
>>> I'm not quite sure I understand the issue.
>>>
>>> The HES_STOPPED counter should be a pre-existing counter. Just for some
>>> reason, it's stopped, right? So perf doesn't need to re-configure the
>>> PEBS__DATA_CFG, since the idx is not changed.
>>
>> Suppose you have your group {A, B, C} and lets suppose A is the PEBS
>> event, further suppose that B is also a sampling event. Lets say they
>> get hardware counters 1,2 and 3 respectively.
>>
>> Then lets say B gets throttled.
>>
>> While it is throttled, we get a new event D scheduled, and D gets placed
>> on counter 2 -- where B lives, which gets moved over to counter 4.
>>
>> Then our loops will update and remove B from 2, but because
>> throttled/HES_STOPPED it will not start it on counter 4.
>>>> Meanwhile, we do have the PEBS_DATA_CFG thing updated to sample counter
>> 1,3 and 4.
>>
>> PEBS assist happens, and samples the uninitialized counter 4.
> > Also, by skipping x86_pmu_start() we miss the assignment of
> cpuc->events[] so PEBS buffer decode can't even find the dodgy event.
> 

Yes, counter 4 includes garbage before the B is started again.
But the cpuc->events[counter 4] is NULL either.

The current implementation ignores the NULL cpuc->events[]. The stopped
B should not be mistakenly updated.

+static void intel_perf_event_pmc_to_count(struct perf_event *event, u64
pmc)
+{
+	int shift = 64 - x86_pmu.cntval_bits;
+	struct hw_perf_event *hwc;
+	u64 delta, prev_pmc;
+
+	/*
+	 * The PEBS record doesn't shrink on pmu::del().
+	 * See pebs_update_state().
+	 * Ignore the non-exist event.
+	 */
+	if (!event)
+		return;


Thanks,
Kan

