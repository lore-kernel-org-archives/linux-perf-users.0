Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93132A3F9;
	Mon, 15 Dec 2025 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784614; cv=none; b=kk4yC9bujpe7usB/6Y5fE4SSiav0Fie9VoXz+CBiqd04mb1munKB3u/a+SUilY1pGNKAhaCGgKUn+xEzAsjbVM5rgK1VTItijYo7G1YP4Lh5tQKd46Gne8RgZEmGhY40TIfPtpiGrswpfRcPRzyY//nH5DuqQNByX7ZW5Vi0aiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784614; c=relaxed/simple;
	bh=TTcTtT2SLtxQ/CZ1EDtBGuh2lQ+Z66X4KW+p40xsc6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EfIws6I2x+QE2epGPxi9WxQsFSI7eDYm/CB3SRW5a0lW+KvLau/EALK6c4VO4HNiP2gP3ltK8d/8WuiDWHW1DSV/XxxjkwlDc/WZce2oaNw9EiQeLYXnWwFjowEa2jXXY3bvePkqc2osd7xPMiiuy9BhvP7L0sib1uQoJM9hbMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXRdod7V; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXRdod7V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765784612; x=1797320612;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TTcTtT2SLtxQ/CZ1EDtBGuh2lQ+Z66X4KW+p40xsc6Y=;
  b=nXRdod7VBwHys8KjiFybI9jtzy/F8V7Zlgr8mefekh34sojdj4XqY9RI
   zY1gFu1AgesNf1qcY46JLrW6btua0wONen6yoSk3dAPfsEm1Y/ibp3WNw
   KO5FleLuEKzKvCCTMPH0UXiA+V5gpESVf92pw45StDiMfmcLRPCdlDTF9
   BREJAKl6Y+7QfY2xrMOxBBdnk+vjwkbiPbYIr9zS8rubCw777Uesze6+3
   CDA9Ip7eHYTf7pgcPKp8EZkQj1dvk9OHMbWA5zz0IBdZi6GwcBWCjOjxl
   /VoRmO9aZCp8ThkJO9s4CVhqOGxEARZ1b5FIoFWrfTs4e+yE3PN0BcxWX
   w==;
X-CSE-ConnectionGUID: QGE4hhtbSEqv7naMykjMuQ==
X-CSE-MsgGUID: x2z799spQHu32RyA3VcFYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="67715372"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="67715372"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 23:43:31 -0800
X-CSE-ConnectionGUID: t6vDFQBURXSfmBwr1UpjYA==
X-CSE-MsgGUID: 2wJMmcebRKmSwoWl35Fm9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="196920350"
Received: from unknown (HELO [10.238.18.1]) ([10.238.18.1])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2025 23:43:28 -0800
Message-ID: <defbd409-a3b6-4e12-8070-f9ae9ddeed66@linux.intel.com>
Date: Mon, 15 Dec 2025 15:43:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86: Prevent NULL event deref in handle_pmi_common()
To: Peter Zijlstra <peterz@infradead.org>, evan.li@linux.alibaba.com
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 kitta <kitta@linux.alibaba.com>
References: <20251212084943.2124787-1-evan.li@linux.alibaba.com>
 <20251212104404.GO3911114@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251212104404.GO3911114@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 12/12/2025 6:44 PM, Peter Zijlstra wrote:
> On Fri, Dec 12, 2025 at 04:49:43PM +0800, evan.li@linux.alibaba.com wrote:
>> From: Evan Li <evan.li@linux.alibaba.com>
>>
>> handle_pmi_common() may observe an active bit set in cpuc->active_mask
>> while the corresponding cpuc->events[] entry has already been cleared,
>> which leads to a NULL pointer dereference.
>>
>> This can happen when interrupt throttling stops all events in a group
>> while PEBS processing is still in progress. perf_event_overflow() can
>> trigger perf_event_throttle_group(), which stops the group and clears
>> the cpuc->events[] entry, but the active bit may still be set when
>> handle_pmi_common() iterates over the events.
>>
>> The following change:
>>
>> 7e772a93 ("perf/x86: Fix NULL event access and potential PEBS record loss")
>>
>> moved cpuc->events[] clearing from x86_pmu_stop() to x86_pmu_del() and
>> relied on cpuc->active_mask/pebs_enabled checks. However,
>> handle_pmi_common() can still encounter a NULL cpuc->events[] entry
>> despite the active bit being set.
> How? What is doing del() concurrently with the pmi?

As long as stop() is called before del(), the corresponding bit in
active_mask should be cleared. Perhaps it's because x86_pmu_start() is
called first and x86_pmu_enable() is still not called and PMI arrives? 
Anyway I can't figure out why this issue could happen. @kitta @evan could
you please share how to reproduce this issue? I would try to reproduce this
issue locally. Thanks.


>
