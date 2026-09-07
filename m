Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F41394492
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Sep 2026 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762207; cv=none; b=t25dmUcbThGzvhZHSEY4hOTtEqFUhKBUkJbVOLMKMaKRc34yJVlnaNmTBUg98NQUALHA+CxNk/SIex9jCm3W8j6PkBUycGuu9QAvU/CWZJ7Jxi/SuUTEzUXKt0tvGnG3obePb1F6MseFV9GcFsHYbf4LACZYcOtdEGfrtzjo9ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762207; c=relaxed/simple;
	bh=B4Xs1PGJZgKpxRPHccy7aSsE3uh+amUIJa+R8Lzis34=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SwZw8eJ1eeB8bdHHM3RW/ktbeCEaRQtX4e+RfBKfV2j4ouGsIqFJp7lDT1Lp933WhGjY28oST86VAUqilNwT2CzxuX0y2Q/GPQ5ldHeH6CrIpL6zEHT1wdEqk38uksXJsud3mrV3hwYn03u/yot5WFM4XLscm1ZqVVUTsE6Kzbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEGEKOq7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEGEKOq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788762201; x=1820298201;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=B4Xs1PGJZgKpxRPHccy7aSsE3uh+amUIJa+R8Lzis34=;
  b=PEGEKOq7YMqb8hlpZGk/r4I9LTh3ohh15CDK8bklWI4dPTx/uzm7AoLA
   /2s7woF+SBj7EtUsW3DOL0wgOJrBbhULC6E8RfuysbF8bewjQEmmzEy3I
   xBMjHIbYkGzU74Ggxr8iseyf3tny2JmTsoRtlFx40ln3he1VEObb+y2KT
   M2ZIfvTUgkZg6stxJUaIewppQcQAek55pbomq19FD0RRhD71wHiKY/cMz
   I3yDydQknPabyYVU1u8DhNz91qSL51NPN1i0tR3TQvtXlocD9pF2hShzX
   fynyFCp/oNAF67SdNLhCw40H3QQE9O2IEU2E01YazU1Jk5rTJrhNlgtmk
   w==;
X-CSE-ConnectionGUID: PwwfmQolSaebcBMynCr5vA==
X-CSE-MsgGUID: oE2Ub4W7S8CTX7rVBhhMEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="111935921"
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="111935921"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:23:20 -0700
X-CSE-ConnectionGUID: 0DceHAuRRwWhaUZri/RiPg==
X-CSE-MsgGUID: TM1DdvmnTJGQJlIpLRGKMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,266,1779174000"; 
   d="scan'208";a="268884380"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2026 23:23:19 -0700
Message-ID: <f1d6a335-b1d5-4793-b7c8-6bc9091d98ce@linux.intel.com>
Date: Mon, 7 Sep 2026 14:23:16 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Gennady Kupava <gennady.kupava@gmail.com>,
 linux-perf-users@vger.kernel.org
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com> <apbs8gywyAfFVzqm@google.com>
 <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com>
 <7b4cba95-dacc-4cf1-953f-c59e06e693d0@amd.com>
 <a5d3798c-7d62-43d0-88c6-eec26bd4f63d@linux.intel.com>
Content-Language: en-US
In-Reply-To: <a5d3798c-7d62-43d0-88c6-eec26bd4f63d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/3/2026 7:59 PM, Mi, Dapeng wrote:
> On 9/3/2026 7:36 PM, Ravi Bangoria wrote:
>>>>> This should resolve the DWARF unwinding issue with IBS PMUs:
>>>>>
>>>>> --- a/arch/x86/events/amd/ibs.c
>>>>> +++ b/arch/x86/events/amd/ibs.c
>>>>> @@ -1523,8 +1523,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>>>>>  			goto out;
>>>>>  		}
>>>>>  
>>>>> -		set_linear_ip(&regs, ibs_data.regs[1]);
>>>>> -		regs.flags |= PERF_EFLAGS_EXACT;
>>>>> +		if (event->attr.sample_type & PERF_SAMPLE_IP) {
>>>>> +			data.ip = ibs_data.regs[1];
>>>>> +			data.sample_flags |= PERF_SAMPLE_IP;
>>> We may not set PERF_SAMPLE_IP here, otherwise the kernel address leakage
>>> check in perf_instruction_pointer() could be bypassed.
>> Yes. I realized this wouldn't be straightforward, since the privilege
>> level might change between when the HW captures the sample and when the
>> NMI is delivered. So, any perf code that depends on user_mode() (e.g.
>> perf_exclude_event(), _REGS_USER, _REGS_INTR, header->misc, etc.) may
>> regress with the above change. In addition, guest entry/exit occurring
>> between sample capture and NMI delivery further complicates the problem.
>>
>>>> Right, that's what I thought.  And I believe we should do similar on
>>>> Intel and not update other registers.
>>> For Intel PEBS, the call-chain would always use the interrupt regs instead
>>> of the PEBS regs, so there would be no issues for Intel PEBS.
>>>
>>>     /*
>>>      * We must however always use iregs for the unwinder to stay sane; the
>>>      * record BP,SP,IP can point into thin air when the record is from a
>>>      * previous PMI context or an (I)RET happened between the record and
>>>      * PMI.
>>>      */
>>>     perf_sample_save_callchain(data, event, iregs);
>> This wouldn't take care of _STACK_USER, right?
> Yes, I just realized this is not fully correct for Intel PEBS after sending
> the comments.
>
> On Intel platforms, for SAMPLE_STACK_USER, the IP/SP/BP is consistent and
> they all comes from PEBS, so the DWARF unwinding has no issues. But for
> SAMPLE_CALLCHAIN, it's not consistent, the IP is overwritten by PEBS while
> the BP/SP are still gotten from PMI. So the kernel call-chain unwinding
> could not work.

The statement about SAMPLE_CALLCHAIN is not correct. Just went though the
code carefully, the kernel has already returned a IP chain to user space
for SAMPLE_CALLCHAIN requirement, which doesn't need to current IP/SP/BP
registers to reconstruct the call chain. So We only need to ensure the PMI
context registers are reported for SAMPLE_STACK_USER requirement. Thanks.


>
> Suppose we need to follow below 2 rules to ensure the correct call-chain
> unwinding and register snapshot consistency.
>
> 1. All registers including IP should come from either PEBS or PMI, must not
> be mixed. This ensures to get an consistent registers snapshot.
>
> 2. Either SAMPLE_CALLCHAIN or SAMPLE_STACK_USER is required, the PMI
> registers snapshot must be used. This proves the correct DWARF unwinding.
>
> How's your idea?
>
> Thanks.
>
>
>> Thanks,
>> Ravi
