Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5654A19ADA2;
	Wed, 26 Feb 2025 02:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538492; cv=none; b=mCmClLtL9M7wZUw2WI6Tu2B6OqDIccc3AMMt9y0Odbc5WK1ADfG9bhejTkeRhYPM1SSmYQmXCTyDW8pqJDqN0sxv8YLkjWZt6jEyiktFBPsVFs22MlL/UV2c+7HR3x3dKnwTMdozcdKoBDjeJV7UBkySlKZ/+GA91ar1+Cwo7QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538492; c=relaxed/simple;
	bh=V8y25v+1F2+s34M2jg0QgqYF/zc3itcB1hTBuAz6DE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpKWv3JydnA5ldleZyaOY9cr2Pp+bgyPwEhM2uaxA/ixK1gij85k9/0rrL7FMAAXRmwL57Sd3Kobw9oGRSkDJvKJgFNVEkCuIUDP6+kFP91lqM7lD6z4Psqo2ZK3Y2vwfbio5pz4cbgofv5ojogjOtLb6bQNYq4ziJ1Og9Z8Q/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3C/1Ecx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3C/1Ecx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740538490; x=1772074490;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V8y25v+1F2+s34M2jg0QgqYF/zc3itcB1hTBuAz6DE4=;
  b=m3C/1Ecx5Ug2ZRQGCL7k0auqw10U/JujIZfgXzOieXwZELcZ932k73Jx
   g+SwbTBpSfb9TrMN4+xDJml4e145meLNQn7Y6HUqpv4ePHlqnxkQNgdKZ
   iaU6Bd9GV1OcdA464eeVmJ1ocqdlEks090gOigREcVohnN032m8hMvr4g
   Pn1okXBIlVb67wmt/o919zdeMUvNgn2dE5ncaP42pGAA5z2+Ups3vF5O6
   jC8wIGsrPHkAuG27CaAs1Pz874RuxXUZWS56xqU6DSLKeDtX4PnAPNgIv
   /69Jk17K0dPu+iMIakjZtiV2PHe4E1uzo6cfYlJC9x3iFUS9m6RvtPr69
   Q==;
X-CSE-ConnectionGUID: GbIZ0D4PQeq8b1rmlOySHg==
X-CSE-MsgGUID: oVCjs965QD2Fc6Px6fxM2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="52369156"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="52369156"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:54:49 -0800
X-CSE-ConnectionGUID: HW/niNfFSyeKC5+Z6bTokg==
X-CSE-MsgGUID: 7DRKwY1uRAKoMdxhE86hmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116583114"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:54:46 -0800
Message-ID: <ec26fba4-978e-47c6-b0c1-17e387d701e1@linux.intel.com>
Date: Wed, 26 Feb 2025 10:54:43 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or
 record fragments
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
 <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225103927.GJ11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/25/2025 6:39 PM, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:04PM +0000, Dapeng Mi wrote:
>> A significant difference with adaptive PEBS is that arch-PEBS record
>> supports fragments which means an arch-PEBS record could be split into
>> several independent fragments which have its own arch-PEBS header in
>> each fragment.
>>
>> This patch defines architectural PEBS record layout structures and add
>> helpers to process arch-PEBS records or fragments. Only legacy PEBS
>> groups like basic, GPR, XMM and LBR groups are supported in this patch,
>> the new added YMM/ZMM/OPMASK vector registers capturing would be
>> supported in subsequent patches.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c      |   9 ++
>>  arch/x86/events/intel/ds.c        | 219 ++++++++++++++++++++++++++++++
>>  arch/x86/include/asm/msr-index.h  |   6 +
>>  arch/x86/include/asm/perf_event.h | 100 ++++++++++++++
>>  4 files changed, 334 insertions(+)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 37540eb80029..184f69afde08 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -3124,6 +3124,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
>>  			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
>>  	}
>>  
>> +	/*
>> +	 * Arch PEBS sets bit 54 in the global status register
>> +	 */
>> +	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
>> +				 (unsigned long *)&status)) {
> Will arch_pebs hardware ever toggle bit 62?

No, arch-PEBS won't touch anything of debug store related.


>
>> +		handled++;
>> +		x86_pmu.drain_pebs(regs, &data);
> 		static_call(x86_pmu_drain_pebs)(regs, &data);

Sure.


>
>> +	}
>
