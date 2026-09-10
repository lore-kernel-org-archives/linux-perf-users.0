Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1390A3D994;
	Thu, 10 Sep 2026 00:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998573; cv=none; b=a7Yr0zWT1moEUBImdPnY3psPbbAKGDTpPBwAWMJRaQJROMtYvIYpNtHXRrwQt0FFuMXYr0fIB1QUi9tixwi9UsFaNO9mgnFVJbXmeI77DjAL45+RKkhmnolgvCpRFiMZo4atUnmKcIFOBofTPuN3lFkjWe+lXN5434f+VK/YV1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998573; c=relaxed/simple;
	bh=QqVacQ+lFCLSZRaZI9uu1f0m82qVqudTlvZs6n4sljg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pt7gmIslOERl1GPEmH47WsTCWDLkjZuYN8EUDXa4zNy1m32Ga4yUftIv+K4ByznpGzq4eRPBoHZHiLYXLf8p9Y5rESRYCvaKpIQlw4MOiB1LEZTojelHwJTNkjEe9ZI6lL9YagMB4wH4wva8brV7PRlxVBVDzbEjQtCh6KOj868=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IhT0Oz8q; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IhT0Oz8q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788998571; x=1820534571;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QqVacQ+lFCLSZRaZI9uu1f0m82qVqudTlvZs6n4sljg=;
  b=IhT0Oz8qYBoe4XBH20lNv7gIZGnIk2UK1FcdVH8zy87ZINjFuKkUW94i
   CbikSf5iTna93Pg+CjXDiVtM7IVvSkAAo29b3KCjo70DEubx+RtId9sIu
   qMl3oKWGeqxa3z6ySZRkuhY5qfZH6lHCkGRdN51zMztJFzt4jVD8aReNn
   sf1eiECYaH1dvi6nn2/PEzpn33OPKNtySomWekQ2B6QhXD+cgV826Z9dG
   jdBzrrh/pARpGEDT/wn416lToF2eehNDXMlbkSkus7EEWyAmxZ3rWVFgo
   ACsqAtsOoOAbh7MGY/pxMYxw1Cg8aoXH+TA+3TIMj9X7wsnFlJMhVHGX/
   A==;
X-CSE-ConnectionGUID: AmTCzm63Rky4C8NJvYeVGQ==
X-CSE-MsgGUID: j0Xhkj1rTxyl6utIemC+MQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="112211664"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="112211664"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 17:02:51 -0700
X-CSE-ConnectionGUID: B8KfwCAPShyZ8ihT1yp2Nw==
X-CSE-MsgGUID: 3LKJ08ijTy+j5Nng/kNF/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="309721618"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 17:02:48 -0700
Message-ID: <43d9adcb-9ad5-4b45-b93c-b6eef1c6154b@linux.intel.com>
Date: Thu, 10 Sep 2026 08:02:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] perf/x86/intel: Prevent drain_pebs() reentry
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260813064346.335458-1-dapeng1.mi@linux.intel.com>
 <d6ccff7d-df31-4308-b60b-8ec5f630415e@linux.intel.com>
 <20260909130331.GT4121339@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260909130331.GT4121339@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 9/9/2026 9:03 PM, Peter Zijlstra wrote:
> On Wed, Sep 09, 2026 at 07:09:11PM +0800, Mi, Dapeng wrote:
>> Hi Peter,
>>
>> Could you please review and queue this patch if it's good enough? This
>> version addresses your comments. Thanks.
>>
>>
>> On 8/13/2026 2:43 PM, Dapeng Mi wrote:
>>> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
>>> not be reentered. If so, one instance may observe stale buffer state and
>>> potentially access out-of-bound memory.
>>>
>>> Most invocations happen in NMI context, which naturally prevents reentry.
>>> However, drain_pebs() is also reachable from process context via
>>> intel_pmu_drain_pebs_buffer().
>>>
>>> In those paths, the PMU is often already disabled, but not guaranteed.
>>> For example, __intel_pmu_pebs_disable() only disables the target counter,
>>> so other active counters can still raise a PMI and interrupt an in-flight
>>> drain_pebs(). Here is an example,
>>>
>>> __perf_addr_filters_adjust()
>>>   perf_event_stop()
>>>     __perf_event_stop()
>>>       x86_pmu_stop() (event->pmu->stop)
>>>         intel_pmu_disable_event()
>>>           intel_pmu_pebs_disable()
>>>             __intel_pmu_pebs_disable()
>>>               intel_pmu_drain_large_pebs()
>>>                 intel_pmu_drain_pebs_buffer()
>>>
>>> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
>>> use them in intel_pmu_drain_large_pebs() to disable the full PMU
>>> around the intel_pmu_drain_pebs_buffer() call, preventing reentry.
>>>
>>> Also add a warning in intel_pmu_drain_pebs_buffer() when the full PMU is
>>> not disabled.
>>>
>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Ah yes. Can you get me a Fixes tag to go with this?

Sure. Here it is. Thanks.

Fixes: b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
PEBS_DATA_CFG")


