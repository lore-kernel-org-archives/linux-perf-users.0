Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7EFC08;
	Mon, 27 Jan 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737992304; cv=none; b=iQX8EMFmuxXXCjxeLKUbGnT5aTGvix65UVbbpFDFVPmSmvCHWVciynGYyw+LL6LMGu1TNVhH3oGjxLc4gHBpZtUjTf2m39jTk5PSclWNyCITq7NjzYmIYm3Vm22roLrktFlwPmC2cMHPtTMu7jthGnS54QCThGS0MfqhZ4ShOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737992304; c=relaxed/simple;
	bh=PJ15fGEiQ+1OKAs6Vayxn17ILLcq6+XFfwGZtQpPHA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6F2dEGxtlKeQ40DUc7KpGm876L/6ZBFSXhiSXJs3VgS4DqDVuCTQgg+0BUiQ0/uWz+K3Ti221J5n7WdxUBDTYhnYrjL0x/+TCh7Ga3CTbmhD0AqiQhbYBGjjISRhaU1wAU7RZc6hkjLaR8SwD+Lp4wMhC6We7qMrsV1SNb7PIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VVRvUkOt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VVRvUkOt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737992303; x=1769528303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PJ15fGEiQ+1OKAs6Vayxn17ILLcq6+XFfwGZtQpPHA4=;
  b=VVRvUkOtlnKsdJmBpp2WoKf3cCwGAbGPRTmaXCCrEIIMIkrQQc/d72qi
   fAm8SIocZeekVjIqJz9vpRzjFS+ET4OlyESZ45/8qoyrrkLlAxAcKegeu
   k+ekH4+HwIohTJ8jW+0SHV5GxCuYcybGhAAXctoFuca/l/fcXVuY5sr/k
   KJ+KzMirYcviVkAgxUq32wst610v9RL01iju3VamUgzG9KAYDVfJT1MX/
   FrnX4IsMxd7/SloddJ7KD8XksaMGXHn8vpfQNIUao0+TxzZxwdrGOQKoo
   JyYxEl4o7WxaORZtj2XRj/TFOpkoQbOyAAuzvtYdM69Liu/bz4ykebXVg
   A==;
X-CSE-ConnectionGUID: mGRsVY9bRDeiKY+Aqb22cg==
X-CSE-MsgGUID: Fcn3x3/ASP2Z7GmoQFyMYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="63813190"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; 
   d="scan'208";a="63813190"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:38:22 -0800
X-CSE-ConnectionGUID: 6j2blAj5SA+u1r05fK/YuQ==
X-CSE-MsgGUID: ZkWgCDl6RWyfdBhg9vxRrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108910180"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 07:38:23 -0800
Received: from [10.246.136.10] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.10])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id B461E20B5713;
	Mon, 27 Jan 2025 07:38:20 -0800 (PST)
Message-ID: <4b66b490-3931-4e3d-9968-cd9de04a6b1a@linux.intel.com>
Date: Mon, 27 Jan 2025 10:38:19 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/20] perf/x86/intel: Add SSP register support for
 arch-PEBS
To: Andi Kleen <ak@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
 <20250123140721.2496639-14-dapeng1.mi@linux.intel.com>
 <Z5MiIWZhXpUwQgnG@tassilo>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <Z5MiIWZhXpUwQgnG@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-01-24 12:16 a.m., Andi Kleen wrote:
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> index f40b03adb5c7..7ed80f01f15d 100644
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
>> @@ -646,6 +646,16 @@ int x86_pmu_hw_config(struct perf_event *event)
>>  			return -EINVAL;
>>  	}
>>  
>> +	/* sample_regs_user never support SSP register. */
>> +	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
>> +		return -EINVAL;
> 
> Why not? It's somewhere.

The current REGS_USER only returns the registers in the struct pt_regs.
The ssp is not part of it. So it is only supported in the REGS_INTR. Is
it enough?

If we want to support ssp with REGS_USER, I think a arch-specific
function should be required early to avoid the perf_sample_regs_user().

Thanks,
Kan


