Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D46F2EE;
	Thu, 15 Aug 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723752966; cv=none; b=GzCa0klaHEkGG0kiRRiYo9CjNW9h73ZBRGCWaS35eoADss7+yIoGDuNXwBenB5iQl/1hMppm/UWT7SVPxLXY7WPqowvuh+Tmj2IUOn09vqbhovGaukfWC6X6c9YaXz/nE4xJ3ziTGjSqqi9Qb5qrfhMkzMbYxw9h6srmEAKPMKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723752966; c=relaxed/simple;
	bh=cSbBCuIDRGF4CUI7Gli5JdU+x83Cj176esArdUNYLn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3S7Gro8U89ZVVV8eMSzCT9XOK+8parMrakYEshvldmT2Pz3mmUT7nergXBWKGuYZRIMO39w/MkJsa6vIz6Ump6IRsqif0HcXY4k15ahGCJajUDsqgxhDnibdnFTr/SJ1UxJFt4LnMCTTsd7U+/qwiQBLHrkUHOUnAZZBQ1c2pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ecPQyfrJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ecPQyfrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723752963; x=1755288963;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cSbBCuIDRGF4CUI7Gli5JdU+x83Cj176esArdUNYLn0=;
  b=ecPQyfrJY9FC3GjnM/SuxtrCOcxl2hXmd3T7MCwzuSO/vUgIYifyHySM
   k8kov/yQDPg+13iJETn/kOktRtAdCKH6hFi1h6wbXJuW3LCuxNEzYwqR2
   wY16LnX2GzkAPQ4GNaeteNz4PyINf1N/6oZq+LH5s6sU1Q67NugvQWDlg
   451dd2FR0Z2qshYSEqvN4eBx+kgcPhVgug+vy420UHdXTE6yIfDldMBRi
   PKHRCvXywNriQj/QoN5mb9snuo7fVhkEKxzmq9P1JNC+1fZDQaJu6Hjm5
   139PrQnr6YyNw2FqIKIyY6SVZdWah9g4BxKHuQzYvjrx9CO4u0NG/CuPi
   g==;
X-CSE-ConnectionGUID: VSVRkMvXSzmQvV532UpG4g==
X-CSE-MsgGUID: OcbfIqyOSiWslNweZAuZKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="33184986"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="33184986"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 13:16:02 -0700
X-CSE-ConnectionGUID: MtDydcQzRXOpoTyjhjYwNw==
X-CSE-MsgGUID: 6sgze5FVSqq6j3tyCH7mow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="64308605"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 13:16:03 -0700
Received: from [10.212.50.56] (kliang2-mobl1.ccr.corp.intel.com [10.212.50.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 3A62220CFEDA;
	Thu, 15 Aug 2024 13:16:00 -0700 (PDT)
Message-ID: <059d6217-10a5-4d2a-b639-90806c04a13b@linux.intel.com>
Date: Thu, 15 Aug 2024 16:15:59 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/x86/intel: Restrict period on Haswell
To: Thomas Gleixner <tglx@linutronix.de>, Li Huafei <lihuafei1@huawei.com>,
 peterz@infradead.org, mingo@redhat.com
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Vince Weaver <vincent.weaver@maine.edu>
References: <87sev7nom4.ffs@tglx>
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com> <87frr7nd28.ffs@tglx>
 <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com> <875xs2oh69.ffs@tglx>
 <166fdbdf-b24d-4267-b42d-f11348b87b1b@linux.intel.com> <87wmkhlk1l.ffs@tglx>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <87wmkhlk1l.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2024-08-15 2:26 p.m., Thomas Gleixner wrote:
> Kan!
> 
> On Thu, Aug 15 2024 at 11:39, Kan Liang wrote:
>> On 2024-08-14 6:47 p.m., Thomas Gleixner wrote:
>>> Now the conclusion of this fun exercise is:
>>>
>>>     1) The hardware behaves differently when the perf event happens
>>>        concurrently on HT siblings
>>
>> I think I found a related erratum.
> 
>> HSM154. Fixed-Function Performance Counter May Over Count Instructions
>> Retired by 32 When Intel® Hyper-Threading Technology is Enabled
>>
>> Problem: If, while Intel Hyper-Threading Technology is enabled, the
>> IA32_FIXED_CTR0 MSR
>> (309H) is enabled by setting bits 0 and/or 1 in the
>> IA32_PERF_FIXED_CTR_CTRL MSR
>> (38DH) before setting bit 32 in the IA32_PERF_GLOBAL_CTRL MSR (38FH) then
>> IA32_FIXED_CTR0 may over count by up to 32.
>>
>> Implication: When this erratum occurs, the fixed-function performance
>> counter IA32_FIXED_CTR0 may over count by up to 32.
> 
> Sure. That's only explaining half of the problem.
> 
> As I demonstrated in the non-contended case even with a count of 2 (I
> tried 1 too) the status bit is never set on the second check.
> 

Do you mean the below example? The status bit (32) of the fixed counter
0 is always set.


65.147782: x86_perf_event_set_period: idx:    32 period:         1 left:  2
65.147783: intel_pmu_handle_irq:      loops: 001 status: 100000000

65.147784: x86_perf_event_set_period: idx:    32 period:         1 left:  2
65.147784: intel_pmu_handle_irq:      loops: 002 status: 100000000

> Which is weird, because the number of instructions between setting the
> count and re-checking the status MSR is definitely larger than 2 (or 1).
> 
>> Workaround: The following sequence avoids this erratum (steps 1 and 2
>> are needed if the counter was previously enabled):
>> 1. Clear bit 32 in the IA32_PERF_GLOBAL_CTRL MSR (38FH) and clear bits 1
>> and 0 in the IA32_PERF_FIXED_CTR_CTRL MSR (38DH).
>> 2. Zero the IA32_FIXED_CTR0 MSR.
>> 3. Set bit 32 in the IA32_PERF_GLOBAL_CTRL MSR.
>> 4. Set bits 0 and/or 1 in the IA32_PERF_FIXED_CTR_CTRL MSR as desired.
>>
>> It should explains that the issue is gone with the magic number 32 or
>> disabling the Hyper-Threading.
> 
> It explains only half of it. If you use 32, then the counter is set to
> -32 so the overcount of 32 will still bring it to 0, which should set
> the status bit, no?

I think it's up to 32, not always 32.
I don't have more details regarding the issue. The architect of HSW has
left. I'm asking around internally to find the original bug report of
the erratum. Hope there are more details in the report.

> 
>> I also found a related discussion about 9 years ago.
>> https://lore.kernel.org/lkml/alpine.DEB.2.11.1505181343090.32481@vincent-weaver-1.umelst.maine.edu/
>> Vince tried the workaround but it seems not work.
> 
> Let me play with that. :)

Appreciate it.

> 
>>>     2) The frequency estimation algorithm is broken
>>
>> For the events which occurs frequently, e.g., instructions, cycles, yes,
>> the frequency estimation algorithm doesn't work well.
>>
>> But there are events that may not occur frequently. If a big init period
>> is set, it may be impossible to get the required freq for those events.
>>
>> It's really hard to pick a universal init period that works for all
>> events.
> 
> I understand that, but especially for RETIRED it's obvious :)
> 
>> I'm thinking perf may only calculate/pre-set a init period for the Linux
>> defined architectural events, e.g., instructions, cycles, branches,
>> cache related events, etc. For the other ARCH specific events, I'm
>> afraid the period has to start 1.
> 
> Yes, that would be way better than what we have now.

Great. I will post a patch to improve it.

> 
>>>
>>>     3) Using a 'limit' guestimate is just papering over the underlying
>>>        problems
>>
>> It's possible that a user set a small number with -c. If the number is
>> less than the 'limit', it needs to be adjusted to avoid HW failure.
>> I think the 'limit' is still required.
> 
> I'm not against the limit per se. I'm against guestimated limits which
> are thrown into the code without understanding the underlying problem.
> 
> The just paper over it up to the point where they bite back because the
> guestimate was off by $N.
> 

Got it.

Thanks,
Kan
