Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80668199FC2;
	Tue,  3 Sep 2024 15:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377040; cv=none; b=sFWdeI8u1NXaxd1THPTpc1LmdKcq1RCipx4HI7/N/FiNwoI764UgvSgkg/spaRs1a+6BjndPAlESBd6m1KBY6QiYEeXb/fiESytmyl7T20nxeuYoYjxehV0nQmxgdLD5GDbIqvg/ggljlRETbsMvmq1utSCH0r8C4EfrO1o+Dc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377040; c=relaxed/simple;
	bh=rwT7nh24GG6CU6+ZSsx1Ol8xnZyh47g1g/jeJizY3e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I+akJndIJ6upiRUJgWU9McM2ZvbSZgWOt3BJaVkxo7AwOZdzZt2vwGMxrysTBz5wjMZ+Hy+WyJJnKOYpodIhB+fhLBiuK9ieA8aH7BWZKzGe902k8IHqf+6zilQj4WebkfaHX9zGBMOPaUJ7bBTYsaoDuugOPIFB+7lNPvCcLss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BO8aIvT1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BO8aIvT1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725377039; x=1756913039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rwT7nh24GG6CU6+ZSsx1Ol8xnZyh47g1g/jeJizY3e8=;
  b=BO8aIvT1MgxZ6U23Kj4X/kdkbCYEbt/CrPI2AzxgFh25mwBOy9qE8lr0
   /kgQkHeGGrxXGbwqQlt9ZZtAhBC7ZsHqkBAudh1JCJrVabZRvwPhAMbHx
   +UY8jsK2Jqbwd73UoBz5jypai6cgWxzEbkv7sZqp847EzJ6Pwka+dVbsV
   2soU//pBs9qcdTnrX76kNQc2Y+0T0K+zVpR1u+DK7YNs0Msj0qdZeYwZc
   43qiiCJV9kcnw43xnnp/8yJb9A7yGxRkWcOCbht2Mv/dwLsxxjQxwagQt
   gRl+S3YMZ/yLcaHL/xo0zFr2zm3Z1/i3kPgrvH2ozPbd3Odvxk3M+hiqU
   g==;
X-CSE-ConnectionGUID: Px+DbyNMRY++b4UCwB4ksA==
X-CSE-MsgGUID: YkC+CrZQSu+5gu1cizF64g==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="34593247"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="34593247"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:23:58 -0700
X-CSE-ConnectionGUID: rdrWDKdYSjGMsv2T6ZNbbQ==
X-CSE-MsgGUID: Dp2lNgzIRvu+JZ5K3WgdoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64619276"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 08:23:57 -0700
Received: from [10.212.53.225] (kliang2-mobl1.ccr.corp.intel.com [10.212.53.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 4E55520CFEE3;
	Tue,  3 Sep 2024 08:23:55 -0700 (PDT)
Message-ID: <902656fb-1ff2-4501-9252-7920691cc552@linux.intel.com>
Date: Tue, 3 Sep 2024 11:23:53 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] perf: New start period for the freq mode
To: Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>
Cc: mingo@redhat.com, tglx@linutronix.de, acme@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 ravi.bangoria@amd.com, sandipan.das@amd.com, atrajeev@linux.vnet.ibm.com,
 luogengkun@huaweicloud.com, ak@linux.intel.com
References: <20240829152036.3923842-1-kan.liang@linux.intel.com>
 <ZtFjFpg0MCcLbgnq@google.com>
 <20240902103838.GF4723@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240902103838.GF4723@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-09-02 6:38 a.m., Peter Zijlstra wrote:
> On Thu, Aug 29, 2024 at 11:13:42PM -0700, Namhyung Kim wrote:
>> Hi Kan,
>>
>> On Thu, Aug 29, 2024 at 08:20:36AM -0700, kan.liang@linux.intel.com wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> The freq mode is the current default mode of Linux perf. 1 period is
>>> used as a start period. The period is auto-adjusted in each tick or an
>>> overflow to meet the frequency target.
>>>
>>> The start period 1 is too low and may trigger some issues.
>>> - Many HWs do not support period 1 well.
>>>   https://lore.kernel.org/lkml/875xs2oh69.ffs@tglx/
> 
> So we already have x86_pmu::limit_period and pmu::check_period to deal
> with this. Don't they already capture the 1 and increase it where
> appropriate?

The limit_period only checks the minimum acceptable value for HW. If the
value is lower than that, I think HW errors may be triggered. It's a
mandatory request.

However, it doesn't make it a perfect start value, which perf uses in
the default freq mode.
As you can see in Thomas's experiment, it doesn't trigger HW issue to
set the start period to 1. But the message "perf: interrupt took too
long (2503 > 2500), lowering ..." is printed. That should be a false
alarm. To avoid it, 32 is finally used for the limit_period.
https://lore.kernel.org/lkml/87plq9l5d2.ffs@tglx/

We cannot always use this way to address the above issue.
- It's impossible to test all the platforms to find a perfect "32" for
each platform.
- Some events may need a very low period. We cannot set the limit_period
too high.

Furthermore, a low start period for the frequently occurring event
challenges both HW and virtualization, which has a longer path to handle
a PMI.

I think we need a better start period for the default freq mode.

Yes, there is already a pmu::check_period which is period related. I
will check if it can be modified to feedback a start value somehow.


> 
>>> - For an event that occurs frequently, period 1 is too far away from the
>>>   real period. Lots of the samples are generated at the beginning.
>>>   The distribution of samples may not be even.
> 
> Which is why samples include a WEIGHT option IIRC.
>

The WEIGHT gives all kinds of latency to understand it. But it doesn't
help changing the distribution.


>> Sounds like a per-pmu callback is fine.  PMUs don't have the callback
>> (including SW) can use 1 same as of now.
> 
> This, but also, be very careful to not over-estimate, because ramping up
> is fast, but having to adjust down can take a while.

Sure.

Thanks,
Kan
