Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632BB2777FC;
	Tue, 11 Aug 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786412372; cv=none; b=NLxO8WwE4SvEyOLc+FkMwRdIHOIRGLBjDBfh52vyBiuUzBGOr0prlFhFNTVSc99utlWlYwZoXTD0Am2Qg+Bx6Dv6PhXHQMQ7SNXajQ68UlWFBhgGmCBW2DGDkAwlkSFmPxqrb99zfSvKUAUDiJg7axgu0UBp3bD0If7uL/JVI0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786412372; c=relaxed/simple;
	bh=pLlGowFccIUBAjhK1ul+E9LDkRzw09LPAz8jHeg0SUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ibhz9hjsTfa4UCYWIOHPXsNRFZmmUAEi16BruljQhoFpSkY8ruqRNFI7PKrD5rYaCpsD92Ssp9l5Ee+xS46/xsqwQ3WMyFCk5Ddar6wPcGe5+aH71SIChIr7f6wyuJdRetIHgqiwelXb6wW23Xx3zHfkolzjMkZHUi2XGiYFSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=agC8AKdd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agC8AKdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786412371; x=1817948371;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pLlGowFccIUBAjhK1ul+E9LDkRzw09LPAz8jHeg0SUU=;
  b=agC8AKddVl66I9YyOtlk3CDpvvtonRFc0/28a0OaY5lBfPASwGInFXJA
   y5FhKKTSAJORnD1jTWddUQYtkXTkhgC3Q7VLA3t07rZu5GcmZg5EILVjU
   COQTDh0ARBOzliB0fCAuxbNMfz3ZDGPE3oUaIrqrWFw2zEDoZ+AwJva5p
   Q4S6FNKVLn+dEb/I4Zz/lkcwEON6Y1jnHKCl6mj74+2mXUNaAX4RALyhZ
   /kIBk2XCyaLepw5p0fvenbm2tBcgFNDeFdSF66UOpJOUOlBDyqsNSMhy0
   HpQ16SMR7KhUulI0DDInfru7LbHVT17kRd+1jFOYbQgior72Flncj5REv
   A==;
X-CSE-ConnectionGUID: QjBpyTm2Snm2II2/KhcbzA==
X-CSE-MsgGUID: IhVS56tMQOuvZ/WDOcH3VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90752164"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="90752164"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:39:30 -0700
X-CSE-ConnectionGUID: FKLApZNkTsm1gT3BrVXuVg==
X-CSE-MsgGUID: l+X8GTsCTyOEM0B7GUvfaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="293136670"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 18:39:27 -0700
Message-ID: <da08527f-642b-4f77-89a6-43f42e12d114@linux.intel.com>
Date: Tue, 11 Aug 2026 09:39:23 +0800
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
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260810130130.GX776954@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 8/10/2026 9:01 PM, Peter Zijlstra wrote:
> On Fri, Jul 17, 2026 at 04:03:42PM +0800, Dapeng Mi wrote:
>> The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
>> not run concurrently. If it is reentered, one instance may observe stale
>> buffer state and potentially access out-of-bound memory.
>>
>> Most invocations happen in NMI context, which naturally prevents reentry.
>> However, drain_pebs() is also reachable from process context via
>> intel_pmu_drain_pebs_buffer().
>>
>> In those paths, the PMU is often already disabled, but not guaranteed.
>> For example, __intel_pmu_pebs_disable() only disables the target counter,
>> so other active counters can still raise a PMI and interrupt an in-flight
>> drain_pebs().
>>
>> Introduce __intel_pmu_quiesce() and __intel_pmu_resume() helpers and
>> use them in intel_pmu_drain_pebs_buffer() to disable the full PMU
>> around the drain_pebs() call, preventing reentry.
>>
> It is not at all clear to me where the exact recursion happens. (The
> word you're looking for was recursion, not concurrent).

Yes, the word "concurrently" is not accurate, reentry is the more accurate
word.

Currently drain_pebs() would be called in two places, one is the in the PMI
handler, like handle_pmi_common(). The other place is
intel_pmu_drain_pebs_buffer() which is from process context.

So when intel_pmu_drain_pebs_buffer() is calling drain_pebs(), if there is
an active PEBS event triggering PMI, it would interrupt current in-flight
drain_pebs() and lead to drain_pebs() reentry.

The good news is the global pmu has been disabled in most places before
calling intel_pmu_drain_pebs_buffer(), so no new PMI can be triggered to
interrupt current running drain_pebs() helper, but not all places does so,
like __intel_pmu_pebs_disable() where only the target counter has been
disabled instead of the whole PMU. So it's still possible tjat another
active PEBS event triggers PMI and interrupts current running drain_pebs().

Take the intel_pmu_drain_arch_pebs() as an example,

    base = cpuc->pebs_vaddr;
    top = cpuc->pebs_vaddr + (index.wr << ARCH_PEBS_INDEX_WR_SHIFT);
    ------> interrupted here ...  


    index.wr = 0;
    index.full = 0;
    index.en = 1;
    if (cpuc->n_pebs == cpuc->n_large_pebs)
        index.thresh = ARCH_PEBS_THRESH_MULTI;
    else
        index.thresh = ARCH_PEBS_THRESH_SINGLE;
    wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);

Assume the drain_pebs() is interrupted just after reading the top value by
a new PEBS PMI and the PMI handler would drain all the PEBS buffer. When
the PMI returns and the original drian_pebs() continues to execute but it
doesn't know the PEBS buffer has been cleared and may access some stale
data and lead to some unexpected errors.


