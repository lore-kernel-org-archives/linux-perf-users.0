Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363111D6AA;
	Wed, 16 Apr 2025 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744782598; cv=none; b=Qe1STMLQm7mxcGcwlva0NKP48qUaFqPoPrPmZoHTU2XH16pV96/7i19OervttT2Gl9T5fkLOFm/X0OsUdzQRhb73glinyY8uN8pqv++W4n12SPio8pX35KqEbCJfwfdANRSHHmqETuNGe/GR8bNxyxs8/AOtDDcfHqT7aBPEyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744782598; c=relaxed/simple;
	bh=Rh3s1NfTtZpHTMOs4BVGQooSMtFNYmXpSVOJsb6wJbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuCtJ6aVfjBeGGlJAfghmcbvBmz7qY52L3DvheV3wdiSQnUODWicNjshxvFkAZxevVOxcMP7mwFFjC1EJBKoVjjrrhKdrEqruiwirYIT+9AiStu9Bz+8KQgCzBuLQjDgkOwCBT4UoVa8nTELoTomKQayvDUKxYrZf+q+8bMIQ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=npEBFpet; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="npEBFpet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744782596; x=1776318596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rh3s1NfTtZpHTMOs4BVGQooSMtFNYmXpSVOJsb6wJbo=;
  b=npEBFpetFL5gHhUwedWPsa6TdH2WUbXwjMACGM3SwLT7tnLEQdbG1OfT
   13wUi+uv8MYO51wZe6cduQGnv8h78cP32njE8/ezFj4r61O3dEoowYSvd
   KegG4ukqyk5mKqtQ6L7hAexU6wGBWvj9lH1jA3H+W/TYkAgx6sg+Iz5D4
   h/6Dv+o3ZB9ho38+kSM57pxS3f4iDR1aSTws3FhbPrxBPKzEQY467cEE5
   B2ItC0GGOG3KIx8NSlOA4tKh79WXlanZQ2cz3ZzAInf8/5Sh8UhZmHAW+
   5AgGVoF2Atwrn9nq166nLpxypvXwVnEWgrdTkLwjpptEejeipbfa7nqDt
   w==;
X-CSE-ConnectionGUID: eUpU3DdLRHyVjeKAOItFtg==
X-CSE-MsgGUID: 0gbS0Dl1QdW5R2cf5s0C5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46195701"
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="46195701"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 22:49:55 -0700
X-CSE-ConnectionGUID: ooGEVKwBTsCvSgncBiIKSg==
X-CSE-MsgGUID: C2Tn5zXQQISZ+56tjXk6cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,215,1739865600"; 
   d="scan'208";a="135323808"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 22:49:51 -0700
Message-ID: <c439699c-be19-4dc6-be28-e69e21bbacd4@linux.intel.com>
Date: Wed, 16 Apr 2025 13:49:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v3 15/22] perf/x86/intel: Support SSP register capturing
 for arch-PEBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
 <20250415114428.341182-16-dapeng1.mi@linux.intel.com>
 <20250415140734.GE4031@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250415140734.GE4031@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/15/2025 10:07 PM, Peter Zijlstra wrote:
> On Tue, Apr 15, 2025 at 11:44:21AM +0000, Dapeng Mi wrote:
>> Arch-PEBS supports to capture shadow stack pointer (SSP) register in GPR
>> group. This patch supports to capture and output SSP register at
>> interrupt or user space, but capturing SSP at user space requires
>> 'exclude_kernel' attribute must be set. That avoids kernel space SSP
>> register is captured unintentionally.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/core.c                | 15 +++++++++++++++
>>  arch/x86/events/intel/core.c          |  3 ++-
>>  arch/x86/events/intel/ds.c            |  9 +++++++--
>>  arch/x86/events/perf_event.h          |  4 ++++
>>  arch/x86/include/asm/perf_event.h     |  1 +
>>  arch/x86/include/uapi/asm/perf_regs.h |  4 +++-
>>  arch/x86/kernel/perf_regs.c           |  7 +++++++
>>  7 files changed, 39 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index 9c205a8a4fa6..0ccbe8385c7f 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -650,6 +650,21 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  			return -EINVAL;
>>  	}
>>  
>> +	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP))) {
>> +		/* Only arch-PEBS supports to capture SSP register. */
>> +		if (!x86_pmu.arch_pebs || !event->attr.precise_ip)
>> +			return -EINVAL;
>> +		/* Only user space is allowed to capture. */
>> +		if (!event->attr.exclude_kernel)
>> +			return -EINVAL;
>> +	}
> We should be able to support this for !PEBS samples by reading the MSR
> just fine, no?

Yes, It can be supported for !PEBS samples. I ever hesitated whether to add
support to capture SSP for !PEBS. Since there is a latency between counter
overflowing and SW reading SSP, the captured SSP may be inaccurate for
!PEBS samples. This makes it not so valuable considering we already support
it for PEBS sampling.

Anyway, we can support it in next version if it's necessary.


>
> ISTR making a similar comment last time.
