Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ED614AB4;
	Wed, 15 May 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715776455; cv=none; b=VT9gymHgWH6QnTD3pEHbqPzMs3dIuvconsAkyg4kmalYFcVDWjKcE07U6vBW89E76xZ58gO9zZlkqB2URgR+8/biaK3CkNGu8VZXVkh4Q5JnwYQslruqzrvSAwKDDHj/vkHd6U4g0WR9zbCZYSeoj/pBdeRXA6aj7xDk+haYf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715776455; c=relaxed/simple;
	bh=1lJElHHqjV25hj6V/dktcSZwmnweHDqKnzO1SGhKrRc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=vE0c02lUx/TJER1u7iSivRz1z1hcrbNyfUHzkdoevCan7DdSwsPMaa7z/+NpFT0NLzfHh5yLebKYwSfVlzjurDkM4J2qhunF5rx7Jo/BGuV6lii7HBQJn2tmrJst3aW9CbIiwJMlBj9s6saZUmV60L78oBn63ARJfOx2cY34YQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WQQ4li11; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WQQ4li11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715776454; x=1747312454;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=1lJElHHqjV25hj6V/dktcSZwmnweHDqKnzO1SGhKrRc=;
  b=WQQ4li11GxU6Xhk5CYtvQju22BPKT1G3b0tk6ERZ4g3lMA5cOC+kJYlm
   ys8QApA6ZJeWs+p7y8eurEg/KyVrLmLr40JraWbz0SX5F3K4lotVRCXKa
   23daICQIsAhUuAd2gWT0VSzscil19kln90TVlQDxOctfDsUhV3FqBc4yN
   TA7395Zj4MwCBENi8lK9jB0LB7h0dCCsQXXotEaIZcDSrgW6twuJFFOch
   9ndi2ySssApShc42x0FpLWrVOajHluJgPFNM95LhCOiTYhveliW4EU5C4
   sRvFL3WSPaMsH0aAchQ2IW6lpafHruGAEfrXz9rdSdHktsZHqJGNbSN+o
   Q==;
X-CSE-ConnectionGUID: 2m03NuD6S/K8MUUg/PXhig==
X-CSE-MsgGUID: Cr4WlRHNQ2SJB6ibczJmJw==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="23221466"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="23221466"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 05:34:13 -0700
X-CSE-ConnectionGUID: gJLKzCL3TmSokeKOqGe34g==
X-CSE-MsgGUID: aUFOzMs0RLKbbXYTps5fMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31136084"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.246.48.7])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 05:34:07 -0700
Message-ID: <55624c6d-cdee-49ba-96b1-09598cb1bf68@intel.com>
Date: Wed, 15 May 2024 15:34:02 +0300
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 00/12] perf/core: Add ability for an event to "pause"
 or "resume" AUX area tracing
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240208113127.22216-1-adrian.hunter@intel.com>
 <52f3abd2-4f75-4147-bc7b-c98960d9494b@intel.com>
 <1cb114be-9585-4f85-af9f-4bafb2d15d2a@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <1cb114be-9585-4f85-af9f-4bafb2d15d2a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/24 13:39, Adrian Hunter wrote:
> On 11/04/24 15:02, Adrian Hunter wrote:
>> On 8/02/24 13:31, Adrian Hunter wrote:
>>> Hi
>>>
>>> Hardware traces, such as instruction traces, can produce a vast amount of
>>> trace data, so being able to reduce tracing to more specific circumstances
>>> can be useful.
>>>
>>> The ability to pause or resume tracing when another event happens, can do
>>> that.
>>>
>>> These patches add such a facilty and show how it would work for Intel
>>> Processor Trace.
>>>
>>> Maintainers of other AUX area tracing implementations are requested to
>>> consider if this is something they might employ and then whether or not
>>> the ABI would work for them.  Note, thank you to James Clark (ARM) for
>>> evaluating the API for Coresight.  Suzuki K Poulose (ARM) also responded
>>> positively to the RFC.
>>>
>>> Changes to perf tools are now (since V4) fleshed out.
>>>
>>>
>>> Changes in V5:
>>>
>>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>>> 	Added James' Ack
>>>
>>>     perf/x86/intel: Do not enable large PEBS for events with aux actions or aux sampling
>>> 	New patch
>>>
>>>     perf tools
>>> 	Added Ian's Ack
>>>
>>> Changes in V4:
>>>
>>>     perf/core: Add aux_pause, aux_resume, aux_start_paused
>>> 	Rename aux_output_cfg -> aux_action
>>> 	Reorder aux_action bits from:
>>> 		aux_pause, aux_resume, aux_start_paused
>>> 	to:
>>> 		aux_start_paused, aux_pause, aux_resume
>>> 	Fix aux_action bits __u64 -> __u32
>>>
>>>     coresight: Have a stab at support for pause / resume
>>> 	Dropped
>>>
>>>     perf tools
>>> 	All new patches
>>>
>>> Changes in RFC V3:
>>>
>>>     coresight: Have a stab at support for pause / resume
>>> 	'mode' -> 'flags' so it at least compiles
>>>
>>> Changes in RFC V2:
>>>
>>> 	Use ->stop() / ->start() instead of ->pause_resume()
>>> 	Move aux_start_paused bit into aux_output_cfg
>>> 	Tighten up when Intel PT pause / resume is allowed
>>> 	Add an example of how it might work for CoreSight
>>
>> Any more comments?
>>
> 
> Ping
> 

Kernel patch still applies.

There was a V6 for it:

	https://lore.kernel.org/linux-perf-users/20240216093128.77452-1-adrian.hunter@intel.com/

