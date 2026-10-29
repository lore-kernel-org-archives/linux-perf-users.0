Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268549;
	b=BVhL6rIzUBDWdaSqtpy90X2INEAoYN4zITCiNKm8yMGUAlfD4W5uRes09vTbXyZE5R+s
	 bUXnfUkIVndPqJWWTdgyWu4JACA/dUlkjaDe++vFCKqw2f2fTco+QorCw2OnF97g3Ofsb
	 p9tG1/bsukovGhd0MGKpqtzLUKVde4nFbaUNSZggEGY29XHZ4/Q64UE+KwrZwrgxzxSSK
	 +YHS61O8WhktYd5hTUHmlnKqI8ylIQmGIvmtHNh0TFvjYoBP6jsSBa11/Ck8pC1fgruaj
	 rjaWxgFe3y87nF3MZj9W7Gt85vfumQwsIb5AyOkbUbYjioJve1b2iayqcm1ssq4Se8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268549;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=EBtBh4mi9vfTbizUgXJjG0zB1ZY51XtTcnlDNfbxwEI=;
	b=mkrS0qGnQtDe6sUbOBXYPT1Tayjq+7i8Ku5s5A0uF6JoIhzAm2ae3/FBZoMVL9ZBFout
	 71IGjYGryKb665SBK5voOoVISDQIDwvOEjztiZW56JXQaPMnq3mH4jKPFoVkfK40GndbB
	 fPElxAgwCcCcIRkNopT3M6jCqH4O2P31VTiu04cp199vggfRiFtzqZO73tucG7JAtVyZO
	 qm2L6Mnd97pJVGpVRmOR+b145uaa0XBZZg45tEUgOzOARxk7nZ+DWehGMqB8HoAbjRbvF
	 qRYtBbDGans+DyNJoz9wGdOQXcIArsOv4BVQs1AcB7byESdVjRNDmRJG3IiTb4pVeWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ULYsBLem;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EF1606A31D;
	Thu, 29 Oct 2026 10:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4EF1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ULYsBLem
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793268549; x=1824804549;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b4PAL6AHf0COge9APUPqFWFOQ7xTd5l7qZ8iH4onfc8=;
  b=ULYsBLemL/z+49FpSWPFw4wrWjerDcpy8RZ4WqZlYZRgwC0dcKyhf4yH
   HnZLj1wFiLpJcb2Hqkuq0odZPmwFl5XvfJcAy2FR5S15EEhm6hrTodfpm
   RaGwW3XHCy/+qfEWRNL2dhL6Z8+QaVa1AE+YjPo8H7JolcLf3WCji10gk
   386ojjqNUVxAQ/K1D0x9UGxriUBmmvW95DoJfAsc2uFdQNVgTO8uMN0wS
   Jw3o8rETR9q3dF+1Di7nkM37O9Hid/rQRK/DqKR41nch/q4JS9obiBudj
   3nQ2A7EEQHoEwfFBOfuTsJe1n01pACCJZJs+JQrhwxNhEZY5O9W4fxA60
   A==;
X-CSE-ConnectionGUID: C/Y+QrxOSGmx7pU9tS2K4A==
X-CSE-MsgGUID: xPbCGLnlQoKsFNiQLX1QNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2011259"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2011259"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:09:09 -0700
X-CSE-ConnectionGUID: nqn9YPXVTj2KUUBYURLt5A==
X-CSE-MsgGUID: 7FXHWvNtSg2LbKodpgZiEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="4982772"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:09:03 -0700
Message-ID: <efb39a39-5302-49ee-b7d3-a9ef574ab7d9@linux.intel.com>
Date: Thu, 29 Oct 2026 18:09:00 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 02/18] perf/x86/intel: Validate LBR XSAVE state before
 updating LBR stack
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Sandipan Das <sandipan.das@amd.com>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 Ananth Narayan <ananth.narayan@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-3-dapeng1.mi@linux.intel.com>
 <20261029094044.GJ1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029094044.GJ1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/29/2026 5:40 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 12:38:58PM +0800, Dapeng Mi wrote:
>> intel_pmu_arch_lbr_read_xsave() doesn't check if the LBR data is present
>> in the xsave area. If LBR data is in the INIT state, the LBR data may not
>> be really written into the xsave area.
>>
>> Add an explicit LBR XSAVE state presence check before updating the cached
>> LBR stack. Also clear the cached LBR stack when intel_pmu_lbr_reset() is
>> called, in addition to resetting the hardware LBR register file, to prevent
>> stale LBR data from being reused after a context switch or similar
>> transition.
>>
>> Fixes: c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR read")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/lbr.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 0b446d8912e4..a2e4ba7e1a4f 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -193,6 +193,8 @@ void intel_pmu_lbr_reset(void)
>>  {
>>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>>  
>> +	cpuc->lbr_stack.nr = 0;
>> +
>>  	if (!x86_pmu.lbr_nr)
>>  		return;
>>  
> This also clears the stack if there is no LBR; was that on purpose? The
> Changelog is silent on this point.

Yes, it's on purpose. The intent is to clear the cached software LBR stack
as well when resetting the hardware LBR stack. This is to avoid leak the
LBR stack information in some unexpected cases. In theory, it can be placed
after the !x86_pmu.lbr_nr, I hope the software LBR stack can always be
cleared regardless of there is LBR user or not.

My fault, I missed to describe this change in the change log. I would add
it in next version.

Thanks.


>
>> @@ -1010,9 +1012,15 @@ static void intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc)
>>  		intel_pmu_store_lbr(cpuc, NULL);
>>  		return;
>>  	}
>> +	xsave->header.xfeatures = 0;
>>  	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
>>  
>> -	intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>> +	if (xsave->header.xfeatures & XFEATURE_MASK_LBR) {
>> +		intel_pmu_store_lbr(cpuc, xsave->lbr.entries);
>> +	} else {
>> +		/* Clear the LBR stack to avoid leaking stale entries. */
>> +		cpuc->lbr_stack.nr = 0;
>> +	}
>>  }
>>  
>>  void intel_pmu_lbr_read(void)
>> -- 
>> 2.34.1
>>
