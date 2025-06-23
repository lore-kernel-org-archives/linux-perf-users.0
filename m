Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6D19A;
	Mon, 23 Jun 2025 01:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641452; cv=none; b=hj2D0duFGtstaV/hADlqpOgR+l4Y/vKPC3yyR5ZfdX46cU1hc59bhftsEcGhcbYLXEsIdHZEq1j/BZnfVd98B9KgZb3k+Uw9eRGhuO/YqcvNdATG2MxuJVV+nmCpvb7IIfzL8Z5EodZRm3Nr76dy7QgoHCTX1ypGpf8mRznGrbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641452; c=relaxed/simple;
	bh=GMCBoZMulpjxiLy8cBhLZG3VWdf79Ci7wuDXKwKF1fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKNuabqt8NUaDyzS74GaQt1YsULU2k6nkgP8NlBFUZ3d5TCHIw7gt3R7kn5pV/g5jd9uaMDh5eh9GrSDe2eV6aMfchYZRuKYtzpqu+EWSlEsFGorg6ljPYp1Cg4ASmGhbJcrDp+XuIzFKxA2uY3S4/Fupxh1excgMNqlVxH1cBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JEpDYmiQ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JEpDYmiQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750641451; x=1782177451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMCBoZMulpjxiLy8cBhLZG3VWdf79Ci7wuDXKwKF1fQ=;
  b=JEpDYmiQZ3tjFrOs2V3ayRA7GMTR9vw/YrSuBNl4Y/gWRj9Sb+9T5dgZ
   oNlOQHPW5qO6bHQKu+RTfE3dUp1sU67CF7mhzvptCllSTiPabmiiaeVCQ
   oMpjCtpS0U9+AlfzVmIdonizqhjMFs35ah0YR9NTV3FXhPw5n9fcf5Foc
   KbAVqStQOJfbzPDDyLWcNbaqvodhc3Z0SNJznLF6u0z9VKwgXMCJISJrM
   XdxJ1CahC1mjNCLK56bBkGZ5D25n0xQ+3tVoW2PP//8uiKb+q5uRtFsLk
   Iv6I4rb8vWE7Hi9tk+M/lNHhWYlbFuHGNxBfXmUUwrIdiT/D4zrXdJ8G8
   Q==;
X-CSE-ConnectionGUID: cJeat3Y4SviYQDrTM/eelQ==
X-CSE-MsgGUID: e765NTaVSbeTRb4iYSUDaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52921837"
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="52921837"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:17:30 -0700
X-CSE-ConnectionGUID: dOCoXtziT7W1YO1wZ0GYuw==
X-CSE-MsgGUID: 1YDDZ47rQSCKuaK22nCnKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,257,1744095600"; 
   d="scan'208";a="155832133"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.144]) ([10.124.245.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 18:17:26 -0700
Message-ID: <8f6effaf-0a4b-411e-8e12-57f3c83069c2@linux.intel.com>
Date: Mon, 23 Jun 2025 09:17:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 07/13] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250620103909.1586595-1-dapeng1.mi@linux.intel.com>
 <20250620103909.1586595-8-dapeng1.mi@linux.intel.com>
 <20250621092001.GT1613376@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250621092001.GT1613376@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/21/2025 5:20 PM, Peter Zijlstra wrote:
> On Fri, Jun 20, 2025 at 10:39:03AM +0000, Dapeng Mi wrote:
>
>> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
>> index b6eface4dccd..72b925b8c482 100644
>> --- a/arch/x86/events/intel/ds.c
>> +++ b/arch/x86/events/intel/ds.c
>> @@ -625,13 +625,22 @@ static int alloc_pebs_buffer(int cpu)
>>  	int max, node = cpu_to_node(cpu);
>>  	void *buffer, *insn_buff, *cea;
>>  
>> -	if (!x86_pmu.ds_pebs)
>> +	if (!intel_pmu_has_pebs())
>>  		return 0;
>>  
>> -	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
>> +	/*
>> +	 * alloc_pebs_buffer() could be called by init_arch_pebs_buf_on_cpu()
>> +	 * which is in atomic context.
>> +	 */
>> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);
>>  	if (unlikely(!buffer))
>>  		return -ENOMEM;
> Here we go again.. that is CPU_STARTING context, that has IRQs disabled
> and as such no allocation is allowed. Not even GFP_ATOMIC -- this will
> break PREEMPT_RT.

Thanks. So we could have to follow what current legacy PEBS does and defer
the PEBS buffer allocation until creating perf events
(x86_reserve_hardware()). 


