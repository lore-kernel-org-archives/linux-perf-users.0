Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A09D3597C;
	Thu, 23 Jan 2025 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737646588; cv=none; b=OVMxC7AQxpLjZSJHIetS0YhhzexdT5lzoV+iHRdIZMhd0X/XPzDD4httSgfX6EAg7PpADteQHWBZfx1MrrBUPBjUE0TzpiYzENeqAhVe60eW2uLqRg4fRcvCk8plLSKZBDjvzSUEuG2iTTlye3aHDTW2zdcgMtXNWMVrRnNlPEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737646588; c=relaxed/simple;
	bh=0YHTZ86RBn50qvBOSFKWmEYbZbB8FwtVbm3cb44e/O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXe08hQKkBbbUPAvIcO2wccY2gnFiXy4e9Zn19AaoSt5XAbvzWFYIszMVwwUd8NswKdt/YDJQ63mrPNoWZmTsg4HoBe/mIaewMyiko+n1LQ3PyLK0RfUaJoMlBuSeXiKtpDoaArQWpaZoSgDfZt1Ht09rUX3viM6Xq7gfJuZ0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HInR86aV; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HInR86aV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737646587; x=1769182587;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0YHTZ86RBn50qvBOSFKWmEYbZbB8FwtVbm3cb44e/O8=;
  b=HInR86aVAqw1LOaTzz//I/lQ7i+/RsHusqJ3fuJqdISSRJ3LD4uFgD/N
   VmL2CNaQNhjx2nixO6AJjGlKaGLz99FY/aLRcFhZJAlSnr4/h2refJhGy
   rCJ+wwZ+uG/XglGEH/YG1w1oKOViV9xHUGDF1n+dE2y5yRMYfEPJlYdVt
   MmlbxkDUUZcZnRMwipyALNfB1XKMqCDa+ssROrwvrBGwXd1CaVz/5XOWi
   VE3lh6Ji83BsMBG4KXgUB6fojvyKiVJW5xDr+E1arXrmXFmvMn4eSsHqk
   loGFXS1Cn28rFV76SsMiiWiN8vYz9D2ihqMnkh6OnOueKFAE4pT9RxdSG
   Q==;
X-CSE-ConnectionGUID: N8jz+Pk3Q5Cq3SXMt5QfQA==
X-CSE-MsgGUID: bMsULTsHReK5Z22Ntlwneg==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="55695726"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="55695726"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:36:26 -0800
X-CSE-ConnectionGUID: 5jx2EMEqRamHAAkOR2y3LQ==
X-CSE-MsgGUID: WRM2jJfXTcuzo8l7+GcUjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="138352476"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 07:36:26 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id E886B20B5713;
	Thu, 23 Jan 2025 07:36:24 -0800 (PST)
Message-ID: <ab878ced-9f8e-470b-b3fd-f12f7f042519@linux.intel.com>
Date: Thu, 23 Jan 2025 10:36:23 -0500
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
 <7f0ed750-b4b3-4adc-98d2-1e9cccd3bf02@linux.intel.com>
 <20250123091407.GJ3808@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250123091407.GJ3808@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-23 4:14 a.m., Peter Zijlstra wrote:
> On Thu, Jan 16, 2025 at 04:50:01PM -0500, Liang, Kan wrote:
>>
>>
>> On 2025-01-16 3:56 p.m., Peter Zijlstra wrote:
>>> On Thu, Jan 16, 2025 at 09:42:25PM +0100, Peter Zijlstra wrote:
>>>> On Thu, Jan 16, 2025 at 10:55:46AM -0500, Liang, Kan wrote:
>>>>
>>>>>> Also, I think I found you another bug... Consider what happens to the
>>>>>> counter value when we reschedule a HES_STOPPED counter, then we skip
>>>>>> x86_pmu_start(RELOAD) on step2, which leave the counter value with
>>>>>> 'random' crap from whatever was there last.
>>>>>>
>>>>>> But meanwhile you do program PEBS to sample it. That will happily sample
>>>>>> this garbage.
>>>>>>
>>>>>> Hmm?
>>>>>
>>>>> I'm not quite sure I understand the issue.
>>>>>
>>>>> The HES_STOPPED counter should be a pre-existing counter. Just for some
>>>>> reason, it's stopped, right? So perf doesn't need to re-configure the
>>>>> PEBS__DATA_CFG, since the idx is not changed.
>>>>
>>>> Suppose you have your group {A, B, C} and lets suppose A is the PEBS
>>>> event, further suppose that B is also a sampling event. Lets say they
>>>> get hardware counters 1,2 and 3 respectively.
>>>>
>>>> Then lets say B gets throttled.
>>>>
>>>> While it is throttled, we get a new event D scheduled, and D gets placed
>>>> on counter 2 -- where B lives, which gets moved over to counter 4.
>>>>
>>>> Then our loops will update and remove B from 2, but because
>>>> throttled/HES_STOPPED it will not start it on counter 4.
>>>>>> Meanwhile, we do have the PEBS_DATA_CFG thing updated to sample counter
>>>> 1,3 and 4.
>>>>
>>>> PEBS assist happens, and samples the uninitialized counter 4.
>>>> Also, by skipping x86_pmu_start() we miss the assignment of
>>> cpuc->events[] so PEBS buffer decode can't even find the dodgy event.
>>>
>>
>> Yes, counter 4 includes garbage before the B is started again.
>> But the cpuc->events[counter 4] is NULL either.
>>
>> The current implementation ignores the NULL cpuc->events[]. The stopped
>> B should not be mistakenly updated.
> 
> Ah, indeed. I was so close.
> 
> One question though -- is this value ever exposed otherwise? I had a
> quick look and I don't think we support PERF_SAMPLE_RAW for PEBS, but
> what about PEBS-to-PT ? 
>

The counters snapshotting feature is only available on the latest
platforms, lunar lake/arrow lake, and future platforms with Arch PEBS.

The PEBS-to-PT is not enumerated on lunar lake/arrow lake. (It actually
never works on hybrid.) It will be deprecated on Arch PEBS as well.
So we don't need to worry about the PEBS-to-PT.

> Anywya, let me go find this v10 thing :-)

Thanks.

Kan

