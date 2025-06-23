Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E21FC120;
	Mon, 23 Jun 2025 01:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643722; cv=none; b=B4oesrecNIs2u6DoC8nOqNtb5b8DDV7WZBuEeoBgMzFXhBtiIkjaZ2r6ncK1drP6j/GVfpdgVdxY3L4smfdgKAGqO3RNoarDz0bwUUlje4UJQqw4dNeOgxZRPjjeMbrcylCEslYcaNMOCSHV7ckE1ovgBoSQcZdvEJT40Ogv2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643722; c=relaxed/simple;
	bh=M3Ruphr6lSZtXhQ1e4wsMZHH34wIAIpL6cObSlk/37A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+H3j3C9TRTq6B8r4chE9XpcugYnQ6XwzJUycHl1nZV4DfmepHZiv+/T3EI0WnN3ybR3X8PYQHZ/jJZ5A9Y7y9bchtP2gHHbZ3fb1ehTvX3ugt1nksp7Ug8nVaYAfPW/hquYn1xTHYZKQ/MM8Mr+XopWf8Imv8fpgDKoCBbi6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUK47HKT; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUK47HKT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750643720; x=1782179720;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M3Ruphr6lSZtXhQ1e4wsMZHH34wIAIpL6cObSlk/37A=;
  b=cUK47HKT1NNi5HGZ6SsDn6sgCy4DtEsfwG7myLwLyrJ4scOLH+9bdxtV
   xzx2OZRJ2jaV3AZxBeQnrns0fUC6RI60EAQM4aFP6DU73mQlSEOo+oINV
   2rGzHJ5cMMI0SHl8WtQHXtBbSOMA49Jtwp892MtmncEVUcoCeKFNBFza8
   BWeR5ghzTCc4PZ9xTqr5c1AhyrRS6pvneQQv/rRgJF3yZtSTT2aXsAag/
   KxXW/YZPUpIKI4sKlJzSs53/+Ttf3HJTq29iyPYwnnPCkEHMstdliwgJq
   vakbGq/D+KUIA4+8CSajsLO7jQJDmXs45579gSZm7hkNj4+GoyKZpO0U+
   Q==;
X-CSE-ConnectionGUID: F2xatiUiRAWwxtkcpWCm6g==
X-CSE-MsgGUID: TVipZbXwQy+vZLOTwlDtlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52975316"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52975316"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:55:19 -0700
X-CSE-ConnectionGUID: qsJGoGGTQl6ucZIHvXFeJg==
X-CSE-MsgGUID: LwbpHG3VR2yG535nDWjIaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="188685383"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:55:17 -0700
Message-ID: <2136b1ae-6fd4-4037-95c3-3a8eb9f24e24@linux.intel.com>
Date: Mon, 23 Jun 2025 09:55:13 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 09/13] perf/x86/intel: Setup PEBS data configuration
 and enable legacy groups
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-10-dapeng1.mi@linux.intel.com>
 <20250621094134.GX1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250621094134.GX1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/21/2025 5:41 PM, Peter Zijlstra wrote:
> On Fri, Jun 20, 2025 at 10:39:05AM +0000, Dapeng Mi wrote:
>
>> +static inline void __intel_pmu_update_event_ext(int idx, u64 ext)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +	u32 msr = idx < INTEL_PMC_IDX_FIXED ?
>> +		  x86_pmu_cfg_c_addr(idx, true) :
>> +		  x86_pmu_cfg_c_addr(idx - INTEL_PMC_IDX_FIXED, false);
>> +
>> +	cpuc->cfg_c_val[idx] = ext;
>> +	wrmsrq(msr, ext);
>> +}
>> +static inline unsigned int x86_pmu_cfg_c_addr(int index, bool gp)
>> +{
>> +	u32 base = gp ? MSR_IA32_PMC_V6_GP0_CFG_C : MSR_IA32_PMC_V6_FX0_CFG_C;
>> +
>> +	return base + (x86_pmu.addr_offset ? x86_pmu.addr_offset(index, false) :
>> +					     index * MSR_IA32_PMC_V6_STEP);
>> +}
> This seems like an aweful lot of conditions just to get an ddress.
>
> Also, IIRC we have intel_pmu_v6_addr_offset() and that does: index *
> MSR_IA32_PMC_V6_STEP, so something is very redundant here.

Hmm, the intent of adding this helper is just to follow the existed helpers
like x86_pmu_event_addr(), but considering currently only
__intel_pmu_update_event_ext() need to touch the XXX_CFG_C MSRs, we may not
need to an dedicated helper. Would remove this helper.


>
>
>
