Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070278F4A;
	Mon,  1 Jun 2026 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780281130; cv=none; b=jkmgEZ273f5IzF/ks95mRuwTF0t5XbNM1ezrVlDct/IySYpWRE7lvWVrKXkfEf3xO6JI0NUh83FwDbByPCVlmOfXtz2K/Zap2oQ+1L4M9beJEr2ZnQXU3070CezUvp7Vl2KjV2lz11A8DOnT99jTqBeeUA+p91owqI2V6BJINzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780281130; c=relaxed/simple;
	bh=0RTfnPIMbRs4ANC+JmrnqhBpg/7ejDATv/Z330s2Xmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NO7eUW6LizJs/YYFSmGaWEmNvo0muoifRrNJsPv+AixDQqsC2nMDV5lNFDWpEAZXAnXnsGCE0UK53sL4L52OHlWomKLXsNNx+Ix3kvnJWRyTIb3rVxRwIEU78ugcVQzMFZPkDXAsFZYEoUZYdqXtTQFJTcPWhIMF794ynfcJDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ml9f2vuh; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ml9f2vuh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780281128; x=1811817128;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0RTfnPIMbRs4ANC+JmrnqhBpg/7ejDATv/Z330s2Xmg=;
  b=Ml9f2vuhCPpBZ3h16y9cWJUhcg3R+xJW4uX3EVm1iK2244oyhu3bQlRK
   zq5XWXz0HjLB8Q0GGiZ6lu+KJ0gtYpQkeADfhYqbf1UHGE8b9LZVyM5i2
   D9N9ZDw175tq6BI0ttZVTWwgfUMPVwEiR3E11uZaP9lZLxDhPbt0Z0Kbb
   IKNrFWq+L5CndkNQo3rNMDQBm7cTPNpwkY7atpciidJOYpggY1YRWNBi5
   PM7NTK86Jc8Ox0qGhnm+8MkrDJMQ4yUrwUVM/eu6xXOUTn6ImnFBmtNjP
   YbtKti8wJvCXPgsccFcbnwuPaJlnyOCy9xwHVOkbnzzjpsQ8CuNPkKoJc
   g==;
X-CSE-ConnectionGUID: QvnQGURXSp2H3BTgMuF9dQ==
X-CSE-MsgGUID: tSBziUL/TAeb44+aGdWKIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="92508797"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="92508797"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 19:32:07 -0700
X-CSE-ConnectionGUID: dJzZd2p0ShKnkYxm9MHhmw==
X-CSE-MsgGUID: pfn+WUdTQ1u4+GWbyAPfOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="240443996"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2026 19:32:02 -0700
Message-ID: <5f60950a-0cad-4d05-9997-3a8af307992a@linux.intel.com>
Date: Mon, 1 Jun 2026 10:31:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 07/23] x86/fpu/xstate: Add xsaves_nmi() helper
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
 <20260529075645.580362-8-dapeng1.mi@linux.intel.com>
 <20260529113218.GJ3493090@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529113218.GJ3493090@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 7:32 PM, Peter Zijlstra wrote:
> On Fri, May 29, 2026 at 03:56:29PM +0800, Dapeng Mi wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Add xsaves_nmi() to save supported xsave states in NMI handler.
>>
>> This function is similar to xsaves(), but should only be called within
>> a NMI handler. This function returns the actual register contents at
>> the moment the NMI occurs.
>>
>> Currently the perf subsystem is the sole user of this helper. It uses
>> this function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers
>> which would be added in subsequent patches.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/include/asm/fpu/xstate.h |  1 +
>>  arch/x86/kernel/fpu/xstate.c      | 23 +++++++++++++++++++++++
>>  2 files changed, 24 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
>> index 7a7dc9d56027..38fa8ff26559 100644
>> --- a/arch/x86/include/asm/fpu/xstate.h
>> +++ b/arch/x86/include/asm/fpu/xstate.h
>> @@ -110,6 +110,7 @@ int xfeature_size(int xfeature_nr);
>>  
>>  void xsaves(struct xregs_state *xsave, u64 mask);
>>  void xrstors(struct xregs_state *xsave, u64 mask);
>> +void xsaves_nmi(struct xregs_state *xsave, u64 mask);
>>  
>>  int xfd_enable_feature(u64 xfd_err);
>>  
>> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
>> index a7b6524a9dea..4394091c4791 100644
>> --- a/arch/x86/kernel/fpu/xstate.c
>> +++ b/arch/x86/kernel/fpu/xstate.c
>> @@ -1474,6 +1474,29 @@ void xrstors(struct xregs_state *xstate, u64 mask)
>>  	WARN_ON_ONCE(err);
>>  }
>>  
>> +/**
>> + * xsaves_nmi - Save selected components to a kernel xstate buffer in NMI
>> + * @xstate:	Pointer to the buffer
>> + * @mask:	Feature mask to select the components to save
>> + *
>> + * This function is similar to xsaves(), but should only be called within
>> + * a NMI handler. This function returns the actual register contents at
>> + * the moment the NMI occurs.
>> + *
>> + * Currently, the perf subsystem is the sole user of this helper. It uses
>> + * the function to snapshot SIMD (XMM/YMM/ZMM) and APX eGPRs registers.
>> + */
>> +void xsaves_nmi(struct xregs_state *xstate, u64 mask)
>> +{
>> +	int err;
>> +
>> +	if (!in_nmi())
>> +		return;
>> +
>> +	XSTATE_OP(XSAVES, xstate, (u32)mask, (u32)(mask >> 32), err);
>> +	WARN_ON_ONCE(err);
>> +}
> Sashiko raises a fun point vs skid; if an exclude_kernel=1 event trips
> inside the kernel this can potentially leak a whole pile of kernel regs.
>
> But of course the same thing is true for the existing setup. So perhaps
> that doesn't need to concern us now.
>
> There used to be discussions about this case, and I think we had generic
> code to sanitize such boundary events, but I can't seem to find that in
> the current tree.
>
> Mark, ISTR you were involved at some point, any idea what happened?

Just consult this question if current code has such kind of boundary check
with Gemini, his answer is no.

Currently perf_sample_regs_intr() unconditionally save the intr regs and
set the ABI, a simple way to mitigate this security risk may be like this,

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1654c493be56..e6116eab44c5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7920,10 +7920,21 @@ static void perf_sample_regs_user(struct perf_regs
*regs_user,
 }

 static void perf_sample_regs_intr(struct perf_regs *regs_intr,
-                                 struct pt_regs *regs)
+                                 struct pt_regs *regs,
+                                 bool exclude_kernel)
 {
-       regs_intr->regs = regs;
-       regs_intr->abi  = perf_reg_abi(current);
+       /*
+        * Hardware skid can lead to PMI is delivered after
+        * the CPU has already entered kernel mode. In that case,
+        * user-space sampling must not expose kernel register state.
+        */
+       if (exclude_kernel && !user_mode(regs)) {
+               regs_intr->abi = PERF_SAMPLE_REGS_ABI_NONE;
+               regs_intr->regs = NULL;
+       } else {
+               regs_intr->regs = regs;
+               regs_intr->abi  = perf_reg_abi(current);
+       }
 }

The PERF_SAMPLE_REGS_ABI_NONE would prevent the later code to sample and
expose the SIMD registers further. 

Thanks.


>
