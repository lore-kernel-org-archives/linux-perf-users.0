Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793324923;
	b=a9SqNa8I9VV+atYcTAcYZO6xIT/RRwk4pc1dqex8RK0Q4nGw54Q2XpRI5eUrJMG7DjGn
	 vU1tKSJm00EJnaOZ2t6HlgTIX9CNqClvaUMw8Fy0V90iMJfpbWy9m4h/fRZRgs/qw8ltU
	 dVjOMTPkzzYTMZa6BM6EeSQE4OKX8H7LpStQlx2QwrcqncOI3gkayIHqL83aS6Ubn0fsn
	 qDvJYPvGjyNJEBaGVj58jsmsC+/5+2GewRl455Fp1wRB+0u6d6XLgRZQFoklgAJQ+Iddk
	 l/OTBEBUIpK+diQyxQgke+0i19e2N2hrntftoyQO46dMSv4xRIfvjy61L22QcBywdXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793324923;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=y4o/EsnxY0SY7rtLWtq0wJX82Fy5P9Pi53zxkBBKFHI=;
	b=ZQVjx533RbqDICoou+bwuq8iLrTtTGnSccrHPB4TL/S/3lC8/oN97JTHn6dScuvK0VAM
	 Kemexvwt8+wo01QgJgbnGI/cKvVh3pV5kH0Oi+EQDFhfh2zFdhueUrDS4jxombSvyGPHk
	 FKrq3+BJ+sLNcnpZZqivkRYQrUz7i7nSGOp7EWwE7lM8XmRQXdy9tmIA55xlWiaU9pnr+
	 nUkl1b3Log23xP1xx4RNAXLEIyAeeq3vnexoStoKgGIKIY3vDJ9p/DZHxrB+h5IfmzNb1
	 tlMz8OYkTmenLNNdorgkc0zfZOqZnOSlus4i0lkMD+HvDJtwiWPescTHeUa6tYU5MxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iu24F7NV;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF66606A31C;
	Fri, 30 Oct 2026 01:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF66606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Iu24F7NV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793324923; x=1824860923;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sAZfOPO0S7HgTGtb+/QN9sTJTEowvDLb9h5MJGm61OU=;
  b=Iu24F7NVwZUaeweCLAy443dt9xeNfGev5L1S2/0hIda5yUUCJKvvamcA
   MXvHl3uY+0fqJJXtubTAkwC5M5WB2nZsSvkOdXb1EAAp94WRWnrFXl/RS
   mtLX6x1JJiRjGJnr5E3ifL6P4RXJLgTkZf1BHY8nmJ2KSvorzKDeVA/em
   K8lplywqB2LSwFms6b30Wk8WTUZ0Sccr4dJ1zGJmEb5IhjCPCvqcSv9Pm
   Dmdzrf7Uy0j69fFX53Qu6fPUve1sJ7zR3L4LgsBzjC951RF+kTFIalK/o
   z/wgmT7oJeDrJmTPhiVpcHMwjOBctbX2sue3QSDI1e5rtoNmlE+JDpz9h
   A==;
X-CSE-ConnectionGUID: EdZ/qlYCSACrgXL1FB++hQ==
X-CSE-MsgGUID: lB4MvQl7SdWJs5udXAGvbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2080594"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2080594"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:48:42 -0700
X-CSE-ConnectionGUID: A3ZKGLD/TkmdOXMV4NDh8A==
X-CSE-MsgGUID: ZeX8eC6/QBOInhCNNZu6QA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5198350"
Received: from unknown (HELO [10.238.2.61]) ([10.238.2.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 18:48:39 -0700
Message-ID: <8a2082d0-5f83-4352-8fee-fb71bf179b88@linux.intel.com>
Date: Fri, 30 Oct 2026 09:48:36 +0800
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
Subject: Re: [Patch v5 12/18] perf/x86/intel: Always snapshot live hardware
 LBR state for BPF
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
 <20261029043914.1395147-13-dapeng1.mi@linux.intel.com>
 <20261029105622.GN1779021@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20261029105622.GN1779021@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/29/2026 6:56 PM, Peter Zijlstra wrote:
> On Thu, Oct 29, 2026 at 12:39:08PM +0800, Dapeng Mi wrote:
>> __intel_pmu_snapshot_branch_stack() is intended to capture the current
>> live hardware LBR state for the BPF path. However, that snapshot is
>> currently skipped when all LBR users are PEBS events.
>>
>> BPF LBR snapshotting now uses its own dedicated LBR stack, so there is
>> no longer a risk of clobbering the shared default LBR stack. As a
>> result, always snapshot the live hardware LBR state for the BPF path.
>>
>> Fixes: c22ac2a3d4bd ("perf: Enable branch record for software events")
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
>>  arch/x86/events/intel/core.c | 10 ++++++++--
>>  arch/x86/events/intel/lbr.c  |  9 ---------
>>  2 files changed, 8 insertions(+), 11 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 482a148916bf..110fff65bd50 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4069,8 +4069,14 @@ static int intel_pmu_handle_irq(struct pt_regs *regs)
>>  
>>  	loops = 0;
>>  again:
>> -	intel_pmu_lbr_read(&cpuc->lbr_stack,
>> -			   cpuc->lbr_entries, cpuc->lbr_counters);
>> +	/*
>> +	 * No need to read the LBR stack when all LBR users are PEBS events,
>> +	 * since the PEBS handler updates it.
>> +	 */
>> +	if (cpuc->lbr_users != cpuc->lbr_pebs_users) {
>> +		intel_pmu_lbr_read(&cpuc->lbr_stack,
>> +				   cpuc->lbr_entries, cpuc->lbr_counters);
>> +	}
>>  
>>  	/*
>>  	 * Do not clear the LBR frozen status here; keep LBR frozen
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 63f0504f9d2a..790580f96040 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1050,15 +1050,6 @@ void intel_pmu_lbr_read(struct perf_branch_stack *lbr_stack,
>>  		return;
>>  	}
>>  
>> -	/*
>> -	 * Don't read when all LBRs users are using adaptive PEBS.
>> -	 *
>> -	 * This could be smarter and actually check the event,
>> -	 * but this simple approach seems to work for now.
>> -	 */
>> -	if (cpuc->lbr_users == cpuc->lbr_pebs_users)
>> -		return;
>> -
>>  	x86_pmu.lbr_read(cpuc, lbr_stack, lbr_entries);
>>  
>>  	intel_pmu_lbr_filter(cpuc, lbr_stack, lbr_entries, lbr_counters);
> AFAICT AMD could be similarly modified, it currently unconditionally
> reads the LBR stack, irrespective of lbr_users.

Yes, LBR stack is only needed to snapshot when lbr_users > 0.

Thanks.


