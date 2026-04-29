Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618524C81;
	Wed, 29 Apr 2026 00:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777423867; cv=none; b=ockDu0CXPl7QDBOGc61IiGa1jNbK8cB+GhmxQYxLi+5dmJ+3jjeU7I8qKINJHk2QGdsz25MLepaZJBpM97unqS/qd0i5fwjYbJNT2pboEIoFbMjqGX71j2kO+VoMY137o7vkWRRkpaOODTuguhMa0PiguD+b+Xhc53l7WR1miSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777423867; c=relaxed/simple;
	bh=dIQ/IsHr4gkr+1mqbHwrXDV+B7k/NrE/9rSnMvxmUAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOGVjMdn4FmrlhUwFTSogQEKpddKMhVYifnLXoS0jd+rv8jZ6m+UAVhQL2SWYfN6kE/opmOEm3Qr/JI6sVEWV2ZWxy7BqePLnhehZ/nCjY0jb595pij/+cl1RhNBY1ykuTLnAXV5uY4k1QcM2hiV0TtvybYGsheWN6l52E/eEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K/gRJlQH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K/gRJlQH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777423866; x=1808959866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dIQ/IsHr4gkr+1mqbHwrXDV+B7k/NrE/9rSnMvxmUAI=;
  b=K/gRJlQHLstC8kNHlHoMcCJHd+mUnEqUpp8zfpFXD+R4BDGtVGe2VQRY
   kjpt+K3QSujLaEnNYKJy7DP+NC8490lnpFqGHGV714MntoaCDwjAttLkw
   4S7yAK3TcG4QksT84eZvMKlAHOsy+bHjtV3rbvTuzwFbunym1AL30Uz0w
   mOd3hX7FbaV890jZmrbGGsn8ZuWjkE1hdHyVpGPhPKRAQXm9TJfQetvER
   fZNSuix8vapuoA8oguZCPiHa88EG6PMgvGFVqSM6VSjxOrsLXK4MOyjqF
   rm4rWGfadcbH6rl2fQaITP3mYf/s8GL8iysiS+xdNhnLyEws9vge+ASMa
   w==;
X-CSE-ConnectionGUID: 0Zzy64VMSmq9ociMQ+n3mg==
X-CSE-MsgGUID: zgGwH3/oTHeD/VbqUvgjUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="65878141"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="65878141"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 17:51:05 -0700
X-CSE-ConnectionGUID: 9RB1WYAjQQKcP0WZIqxXGA==
X-CSE-MsgGUID: M/3qZkrZSw+RYYk3kaeBxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="229515466"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 17:51:01 -0700
Message-ID: <e32c7f64-9b12-4db2-a67e-92fd33cf9683@linux.intel.com>
Date: Wed, 29 Apr 2026 08:50:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 4/4] perf/x86/intel: Consolidate MSR_IA32_PERF_CFG_C
 tracking
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260427085513.3728672-1-dapeng1.mi@linux.intel.com>
 <20260427085513.3728672-5-dapeng1.mi@linux.intel.com>
 <20260428130040.GZ3102624@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260428130040.GZ3102624@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 4/28/2026 9:00 PM, Peter Zijlstra wrote:
> On Mon, Apr 27, 2026 at 04:55:13PM +0800, Dapeng Mi wrote:
>> Both Auto Counter Reload (ACR) and Architectural PEBS use the PERF_CFG_C
>> MSRs to configure event behavior. Currently, the driver maintains two
>> independent variables acr_cfg_c and cfg_c_val to cache the values intended
>> for these MSRs.
>>
>> Using separate variables to track a single hardware register state is
>> error-prone and can lead to configuration conflicts. Consolidate the
>> tracking into a single cfg_c_val variable to ensure a unified and
>> consistent view of the PERF_CFG_C MSR state.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> So the earlier patches deserve to be in perf/urgent, but this one
> doesn't actually fix anything and goes in perf/core ?

Yes, I suppose so. 

But Sashiko found a new corner issue. 

"

If Event A moves to a new counter but Event B itself does not move,
match_prev_assignment() would evaluate to true for Event B, and
x86_pmu_start() would be skipped.

Does this mean the updated hw.config1 for Event B is never written to the
physical hardware MSR, breaking the Auto Counter Reload functionality?

"

and the Patch 1/4 can be further optimized and simplified.

I would post an new version patchset to fix all these.

Thanks.


>
