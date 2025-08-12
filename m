Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DB226AE4;
	Tue, 12 Aug 2025 02:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967261; cv=none; b=S/fCnA7NCz+shhl8azZ4md8KXRUa3HNgqwKzL3Ad04bfWOyyXXNfXCLGQj6eOjP595S8vnYGVSHgw2McTLXvJeJKxXWcUNYFXJeeeMBbkboRIBb7VYZK0TYapIDS3uFAMw5/OBTtAifWG6PikFjEE9ESbnRW84+fucUAYrW4pp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967261; c=relaxed/simple;
	bh=ipU4tkivIWVjXkLzIis3cdU2nC0PURH4EsgEHObYApk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjDTxwNQ49NNoaW0zl7AJuBuuEsWgYEP/mIwtPVJUZLAd3i7jh3yGZ5R5Fi07oISd+/hZgdpDRCU6tse10gPZf/0fvyL5QMon9cfQO8ofSEL1EXlBbqTHkAiWe+NL+WOUeZ29aahEB7J0tFVpPDbjifbUquAv1WqObh76itjLuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QuHp82zb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QuHp82zb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754967259; x=1786503259;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ipU4tkivIWVjXkLzIis3cdU2nC0PURH4EsgEHObYApk=;
  b=QuHp82zboIktMc57hNTQYxWzZZP2WcyLWNdwnOIiUEOK9gMccNwVnu+5
   pAAZmg5QnJYAv6Wi9pDGsVDTuaWOw1ohKLxlSuF8Zcz5a+3RzUh01b1WC
   x8gY/E1ge/7tuMc+paoHmS8Mnmth/2rcaDEIzv6RvEHNhwm7r3riEvLyH
   LvhtXqkt10Gb9Koz17Jjkd4ISeepE6VdfwTJiULYkuMeuFS9JcbZMt5q7
   jcipAz68zEQktc1A5CWGkN67F9rGhJ5ML5VRu6HW20dXGmc433R+FSYVN
   z2Z/YkUTDuQ6IM87xNPxcozwKTckPDpX0Qu5Z76nP7rcAiD+1Zj8Ta7MI
   w==;
X-CSE-ConnectionGUID: jexBO2IARCGXkiRc558WkQ==
X-CSE-MsgGUID: owwmwJBITDyvTvnhj4YVVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57378373"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="57378373"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:54:17 -0700
X-CSE-ConnectionGUID: BeFes1TKQ16OLyo16tXmzg==
X-CSE-MsgGUID: Qaqgm6p5SDmqv4Z23ehx1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166457488"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.106]) ([10.124.240.106])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:54:13 -0700
Message-ID: <0e20478c-8e84-479c-9885-1c440c5429c3@linux.intel.com>
Date: Tue, 12 Aug 2025 10:54:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 6/6] perf/x86/intel: Add ICL_FIXED_0_ADAPTIVE bit into
 INTEL_FIXED_BITS_MASK
To: "Liang, Kan" <kan.liang@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20250811090034.51249-1-dapeng1.mi@linux.intel.com>
 <20250811090034.51249-7-dapeng1.mi@linux.intel.com>
 <8c32c5be-02a4-4f4c-9a81-1afe649e88bb@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <8c32c5be-02a4-4f4c-9a81-1afe649e88bb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 8/12/2025 8:00 AM, Liang, Kan wrote:
>
> On 2025-08-11 2:00 a.m., Dapeng Mi wrote:
>> ICL_FIXED_0_ADAPTIVE is missed to be added into INTEL_FIXED_BITS_MASK,
>> add it and opportunistically refine fixed counter enabling code.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> Tested-by: Yi Lai <yi1.lai@intel.com>
>> ---
>>  arch/x86/events/intel/core.c      | 10 +++-------
>>  arch/x86/include/asm/perf_event.h |  6 +++++-
>>  arch/x86/kvm/pmu.h                |  2 +-
>>  3 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index cdd10370ed95..1a91b527d3c5 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -2849,8 +2849,8 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  	struct hw_perf_event *hwc = &event->hw;
>> -	u64 mask, bits = 0;
>>  	int idx = hwc->idx;
>> +	u64 bits = 0;
>>  
>>  	if (is_topdown_idx(idx)) {
>>  		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> @@ -2889,14 +2889,10 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
>>  
>>  	idx -= INTEL_PMC_IDX_FIXED;
>>  	bits = intel_fixed_bits_by_idx(idx, bits);
>> -	mask = intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
>> -
>> -	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip) {
>> +	if (x86_pmu.intel_cap.pebs_baseline && event->attr.precise_ip)
>>  		bits |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
>> -		mask |= intel_fixed_bits_by_idx(idx, ICL_FIXED_0_ADAPTIVE);
>> -	}
>>  
> This changes the behavior. The mask will always include the ADAPTIVE bit
> even on a platform which doesn't support adaptive pebs.
> The description doesn't mention why it's OK.

The mask is used to clear the old fixed bits, the ICL_FIXED_0_ADAPTIVE bit
needs to be cleared regardless of if the platform really supports it. I
would enhance the commit message to describe this.


>
> Thanks,
> Kan> -	cpuc->fixed_ctrl_val &= ~mask;
>> +	cpuc->fixed_ctrl_val &= ~intel_fixed_bits_by_idx(idx, INTEL_FIXED_BITS_MASK);
>>  	cpuc->fixed_ctrl_val |= bits;
>>  }
>>  
>> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
>> index f8247ac276c4..49a4d442f3fc 100644
>> --- a/arch/x86/include/asm/perf_event.h
>> +++ b/arch/x86/include/asm/perf_event.h
>> @@ -35,7 +35,6 @@
>>  #define ARCH_PERFMON_EVENTSEL_EQ			(1ULL << 36)
>>  #define ARCH_PERFMON_EVENTSEL_UMASK2			(0xFFULL << 40)
>>  
>> -#define INTEL_FIXED_BITS_MASK				0xFULL
>>  #define INTEL_FIXED_BITS_STRIDE			4
>>  #define INTEL_FIXED_0_KERNEL				(1ULL << 0)
>>  #define INTEL_FIXED_0_USER				(1ULL << 1)
>> @@ -48,6 +47,11 @@
>>  #define ICL_EVENTSEL_ADAPTIVE				(1ULL << 34)
>>  #define ICL_FIXED_0_ADAPTIVE				(1ULL << 32)
>>  
>> +#define INTEL_FIXED_BITS_MASK					\
>> +	(INTEL_FIXED_0_KERNEL | INTEL_FIXED_0_USER |		\
>> +	 INTEL_FIXED_0_ANYTHREAD | INTEL_FIXED_0_ENABLE_PMI |	\
>> +	 ICL_FIXED_0_ADAPTIVE)
>> +
>>  #define intel_fixed_bits_by_idx(_idx, _bits)			\
>>  	((_bits) << ((_idx) * INTEL_FIXED_BITS_STRIDE))
>>  
>> diff --git a/arch/x86/kvm/pmu.h b/arch/x86/kvm/pmu.h
>> index ad89d0bd6005..103604c4b33b 100644
>> --- a/arch/x86/kvm/pmu.h
>> +++ b/arch/x86/kvm/pmu.h
>> @@ -13,7 +13,7 @@
>>  #define MSR_IA32_MISC_ENABLE_PMU_RO_MASK (MSR_IA32_MISC_ENABLE_PEBS_UNAVAIL |	\
>>  					  MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
>>  
>> -/* retrieve the 4 bits for EN and PMI out of IA32_FIXED_CTR_CTRL */
>> +/* retrieve a fixed counter bits out of IA32_FIXED_CTR_CTRL */
>>  #define fixed_ctrl_field(ctrl_reg, idx) \
>>  	(((ctrl_reg) >> ((idx) * INTEL_FIXED_BITS_STRIDE)) & INTEL_FIXED_BITS_MASK)
>>  
>
