Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572231DDD1;
	Thu, 27 Feb 2025 06:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637793; cv=none; b=YXaFYXg1sP4XUz3ieEFtAW28VYI0KQ5xXHvnrKjTPKHqI0ZHiWh1Zm3YNCrwzk8H7nn6mTXVkMVTTnwnzmpxkv2UknUKGj4btyNQI4/aSYRy+/ayu56PwiG0W0YUqWkugrK0McWdIMsMd0zGip1t5YT3zVB8k8DOLvqITQGedOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637793; c=relaxed/simple;
	bh=QV5luIf4clZu6a3ezewLN5zdGtF4+Z8x4nBbvixp0Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7VzU147Q1b0kna0uMwf774NOKJvqH1UMxe+HqKDoLCkagK4r9TpHKiCUdpzUzwxdNulQWnWET6DNpzAfHgE2pJC+6SItMUpliOjMPCg+YI/lK31iLopNJGC6h6X4vafSpa8hItdHrZg56Hr6Utv3acbJOiK4S929aM/s6bSkUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fsw5hj4p; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fsw5hj4p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740637792; x=1772173792;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QV5luIf4clZu6a3ezewLN5zdGtF4+Z8x4nBbvixp0Bo=;
  b=Fsw5hj4pIa//K2/pIh0Bdl0nxrURyZbLnLek/+bZYjfLQb6MnD70YQvc
   s9ISaxfKyvItd1iuA5x9FImOYWs5O4/oeviWBEiEyPtWJ7A2g3f5il3pg
   Sgax0orVB9vhhgg7kQKV1W0fYnr2YZXMTBXTu7Sy49EQKgJqTxUVqpOCw
   tYDbKvfoRlFqM7IM53Wbech8A+i7jtPCsHcUWHTuuaSenL8G6+WTytMV3
   JOUrLjfdp2Mp4Ab0gtRf7CgZRd30RescgvvdEvETzYW3T/wDAySKA5VJ9
   y2KWFgRq1NNDOZI4/0V1r5XMkSxbhHJArL8L+mS/EYdemCFsAL7C7NX3H
   w==;
X-CSE-ConnectionGUID: /xmaFi0LSJek6Lv+zbZDDA==
X-CSE-MsgGUID: 7p9BIeBzSfKDyJbzhRS60Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="52502142"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; 
   d="scan'208";a="52502142"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:29:43 -0800
X-CSE-ConnectionGUID: nG/4VjfLRZepwwUHYOxylA==
X-CSE-MsgGUID: 6D6JBzN2SnevNsAblFQ/lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117430118"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.245.128]) ([10.124.245.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 22:29:40 -0800
Message-ID: <92ecca66-e0ca-42d8-a54a-f3e5d016e42a@linux.intel.com>
Date: Thu, 27 Feb 2025 14:29:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 15/24] perf/x86/intel: Add SSP register support for
 arch-PEBS
To: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Eranian Stephane
 <eranian@google.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-16-dapeng1.mi@linux.intel.com>
 <20250225115450.GO11590@noisy.programming.kicks-ass.net>
 <Z74rqf5V6bfTZxhG@tassilo>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <Z74rqf5V6bfTZxhG@tassilo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/26/2025 4:44 AM, Andi Kleen wrote:
> On Tue, Feb 25, 2025 at 12:54:50PM +0100, Peter Zijlstra wrote:
>> On Tue, Feb 18, 2025 at 03:28:09PM +0000, Dapeng Mi wrote:
>>
>>> @@ -651,6 +651,16 @@ int x86_pmu_hw_config(struct perf_event *event)
>>>  			return -EINVAL;
>>>  	}
>>>  
>>> +	/* sample_regs_user never support SSP register. */
>>> +	if (unlikely(event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
>>> +		return -EINVAL;
>> We can easily enough read user SSP, no?
> Not for multi record PEBS.
>
> Also technically it may not be precise.

Yes, If need to support to capture user space SSP, then PEBS has to fall
back to only capture single record.

Andi, you said "it may not be precise", could you please give more details?
I didn't get this. Thanks.


>
> -andi
>
