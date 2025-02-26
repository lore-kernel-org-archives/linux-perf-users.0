Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FE725D537;
	Wed, 26 Feb 2025 05:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740548941; cv=none; b=P0LU9SN5kp5Y3f2+fCTAWkqZVFs62RDF6IJOiIWK+abbiwSVT3hj+HkFBV0DsSeGiPi9hVBaQInBdDzoS2zka3Lyk+POh+FvbALXsTacdzsNwhpiRjEad+9F71bQv6UuX3t07fJhd6h4r9u6DVAd1wNnWEJKF22TlkX1on7yl8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740548941; c=relaxed/simple;
	bh=zPgLN2h8wA8jlabEkTaZIJuJQjqvtT9aeOXGXQilveY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ECkmGU0g0MtFamFscgnsjOA0+dr4qo5pvoPtaVRe+bFVtyXhOYs08pLy+dbgLqeAxRTXjif7X0k4QsQT66fozMXT2ZX0qoBaCv0XVz+sfB1JdN2e11xMXQqDlrn7+UNTQUrrJSqBztbBJ5E4IfnVIDqEOhYOa5DPaD5/uNzK+Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bd8iXGKE; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bd8iXGKE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740548940; x=1772084940;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zPgLN2h8wA8jlabEkTaZIJuJQjqvtT9aeOXGXQilveY=;
  b=Bd8iXGKEku0IHdhWrlGZQHGY2t7Y8+0lmV0ef/gcUlINv9FrzHc9qSE2
   wqv3lsLq73QFml/UnpUwXG6Do2/UHA33YtL7LX0UFRpTv2nN0ZQu0Kn4S
   sxrxkUD131TcNAf+TjsBQQpTV/6l1aWsCas6Q+4ztj3XkFeypd/Dwx8Qa
   kRa+tuiswD9Dc6obhUc2t4vnKaDHnl5OR2ue11wP2SaxSoKMXK8F0ktMy
   yosgCK8Lvmt5BS4zJYvCRG1MVZbXQ84bXEqzFHLq27ZPVwO1M7dvLkTMx
   vH7CGkh2UinbegkKs1smOGi5XyOBKni+4rwnRASVpQWCVI6L4GBSQqAOK
   w==;
X-CSE-ConnectionGUID: mysc6ZLuRq+1nlXsoumJug==
X-CSE-MsgGUID: xTQnio58Q0G5eSNyP8T20A==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58802820"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="58802820"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:48:59 -0800
X-CSE-ConnectionGUID: 1DRYZDTcSeuxzTxpu/Fc8g==
X-CSE-MsgGUID: mxslI4j8SouFIWmaoKSoSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117529939"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:48:55 -0800
Message-ID: <2e1b48d7-1528-4de0-affa-e6c13e0ce1b1@linux.intel.com>
Date: Wed, 26 Feb 2025 13:48:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 12/24] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-13-dapeng1.mi@linux.intel.com>
 <20250225111805.GL11590@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20250225111805.GL11590@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/25/2025 7:18 PM, Peter Zijlstra wrote:
> On Tue, Feb 18, 2025 at 03:28:06PM +0000, Dapeng Mi wrote:
>> Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
>> buffer physical address. This patch allocates arch-PEBS buffer and then
>> initialize IA32_PEBS_BASE MSR with the buffer physical address.
> Not loving how this patch obscures the whole DS area thing and naming.

arch-PEBS uses a totally independent buffer to save the PEBS records and
don't use the debug store area anymore. To reuse the original function as
much as possible and don't mislead users to think arch-PEBS has some
relationship with debug store, the original key word "ds" in the function
names are changed to "BTS_PEBS". I know the name maybe not perfect, do you
have any suggestion? Thanks.


>
>
>> @@ -624,13 +604,18 @@ static int alloc_pebs_buffer(int cpu)
>>  	int max, node = cpu_to_node(cpu);
>>  	void *buffer, *insn_buff, *cea;
>>  
>> -	if (!x86_pmu.ds_pebs)
>> +	if (!intel_pmu_has_pebs())
>>  		return 0;
>>  
>> -	buffer = dsalloc_pages(bsiz, GFP_KERNEL, cpu);
>> +	buffer = dsalloc_pages(bsiz, preemptible() ? GFP_KERNEL : GFP_ATOMIC, cpu);
> But this plain smells bad, what is this about?

In initial implementation, alloc_pebs_buffer() could be called in 
init_debug_store_on_cpu() which may be in a irq context. But it was dropped
in latest implementation. So this change is not needed any more. Would drop
it in next version.


>
>>  	if (unlikely(!buffer))
>>  		return -ENOMEM;
>>  
>> +	if (x86_pmu.arch_pebs) {
>> +		hwev->pebs_vaddr = buffer;
>> +		return 0;
>> +	}
>> +
>>  	/*
>>  	 * HSW+ already provides us the eventing ip; no need to allocate this
>>  	 * buffer then.
