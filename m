Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676423FF8B9;
	Tue, 11 Aug 2026 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442452; cv=none; b=U8ZnXAB1b4XKPzod1aZ9bO3UjGY/oVOY8GqPfjM6TIT0+Nc6v0xDiWwLFhlmXuL/eHXWgyNQhOsPFavH6diPKFUa/DndcBrj8laZ8fukOJt6wBL30wH1nL77z47s3sdHCxf06h1G7Sb8g/NDrRu9Kvt8K3SyTgr6LV7SIb/naWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442452; c=relaxed/simple;
	bh=8z7Gr9KgOcLFhQaN4wUA4jQMler2ga0zyQl+HbzwmRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjIBC3hB0SH3oAlHvH8j33wLaWFYXrvFspA2sTyhbYP1YUVl3RoOzHajabUabDYUtpQZMnb/Mhs86nQqOQ3VhIO1T38bQqtsPklnoenC0ORKdyNfv0ACGMJ2AX2l0+i84G75kTF+Bbc58YUBubpRxCKS/Nez4LtjsDSlxZgdutg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeHn5K+V; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeHn5K+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786442451; x=1817978451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8z7Gr9KgOcLFhQaN4wUA4jQMler2ga0zyQl+HbzwmRQ=;
  b=FeHn5K+VziBmLell45M/LdspAUahIyQz9ofORgB4q4EWDKCuUI08ASPa
   AU0SFPVRR1e9dBNTfEJG6hcvmjVu9mWha7/03wTf7LudkfPwJtamLv0qd
   6rkue9iRaDl4Q4HYUikPXV//GokluvroBeSfOl69YjuEYQp/rDDlqJXNs
   A0k3StaUEs0+jA2psKqmaS/vOIz9B/Xne0C1mTFmBJffrZzNHZPImH6yY
   805c952X/KJ7G2jM5lpcCpqrV3JcxlC56GjnoBUf2MOB2H1BbePaa6dMb
   Rjjwh2ALpAR1eTwy4GWTGvvjlzH4Zlt65n7DYpeu/lVYJW3mjTR4EwvzK
   g==;
X-CSE-ConnectionGUID: 4ECUS79jQ+K0iNSblALDEg==
X-CSE-MsgGUID: CO1Vk7acQ2Oisgt6I0cQEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="112514907"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="112514907"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:00:50 -0700
X-CSE-ConnectionGUID: Ccw5j7sYQVqVYCaxasQlBA==
X-CSE-MsgGUID: Ol81jUP6QeG5WbbTWlOtXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="301517516"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 03:00:46 -0700
Message-ID: <8a1b03a0-c45e-4a86-af20-bcd15ccb7f8e@linux.intel.com>
Date: Tue, 11 Aug 2026 18:00:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 8/8] perf/x86/intel: Prevent drain_pebs() reentry
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
 <20260810130130.GX776954@noisy.programming.kicks-ass.net>
 <da08527f-642b-4f77-89a6-43f42e12d114@linux.intel.com>
 <20260811082256.GT48970@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260811082256.GT48970@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/11/2026 4:22 PM, Peter Zijlstra wrote:
> On Tue, Aug 11, 2026 at 09:39:23AM +0800, Mi, Dapeng wrote:
>> On 8/10/2026 9:01 PM, Peter Zijlstra wrote:
>>> On Fri, Jul 17, 2026 at 04:03:42PM +0800, Dapeng Mi wrote:
>>>> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
>>>> not run concurrently. If it is reentered, one instance may observe stale
>>>> buffer state and potentially access out-of-bound memory.
>>>>
>>>> Most invocations happen in NMI context, which naturally prevents reentry.
>>>> However, drain_pebs() is also reachable from process context via
>>>> intel_pmu_drain_pebs_buffer().
>>>>
>>>> In those paths, the PMU is often already disabled, but not guaranteed.
>>>> For example, __intel_pmu_pebs_disable() only disables the target counter,
>>>> so other active counters can still raise a PMI and interrupt an in-flight
>>>> drain_pebs().
>>>>
>>>> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
>>>> use them in intel_pmu_drain_pebs_buffer() to disable the full PMU
>>>> around the drain_pebs() call, preventing reentry.
>>>>
>>> It is not at all clear to me where the exact recursion happens. (The
>>> word you're looking for was recursion, not concurrent).
>> Yes, the word "concurrently" is not accurate, reentry is the more accurate
>> word.
>>
>> Currently drain_pebs() would be called in two places, one is the in the PMI
>> handler, like handle_pmi_common(). The other place is
>> intel_pmu_drain_pebs_buffer() which is from process context.
>>
>> So when intel_pmu_drain_pebs_buffer() is calling drain_pebs(), if there is
>> an active PEBS event triggering PMI, it would interrupt current in-flight
>> drain_pebs() and lead to drain_pebs() reentry.
> What is the actual callchain here?
>
> Because the one I'm thinking off is:
>
>   perf_ctx_disable();
>   perf_ctx_sched_task_cb()
>     x86_pmu_sched_task()
>       intel_pmu_sched_task()
> 	intel_pmu_pebs_sched_task()
> 	  intel_pmu_drain_pebs_buffer();
>   perf_ctx_enable();
>
> And that one has the full pmu disabled, because of context switch etc.
> And then there is one in perf_read():
>
>   pmu->read()
>     intel_pmu_read_event()
>       pmu_enabled = cpuc->enabled;
>       cpuc->enabled = 0;
>       if (pmu_enabled)
>         intel_pmu_disable_all();
>       intel_pmu_drain_pebs_buffer();
>       cpuc->enabled = pmu_enabled;
>       if (pmu_enabled)
>         intel_pmu_enable_all();
>
> So what specific callchain is going sideways?

Yes, the whole PMU would be disabled for these 2 call-chains.

But for the helper __intel_pmu_pebs_disable(), it seems the whole PMU is
not disabled, only the target counter has been stopped. Here is one call-chain.

__perf_addr_filters_adjust()
  perf_event_stop()
    __perf_event_stop()
      x86_pmu_stop() (event->pmu->stop)
        intel_pmu_disable_event()
          intel_pmu_pebs_disable()
            __intel_pmu_pebs_disable()
              intel_pmu_drain_large_pebs()
                intel_pmu_drain_pebs_buffer()


>
