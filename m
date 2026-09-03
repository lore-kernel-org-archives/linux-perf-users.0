Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F7B45562E
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 08:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424775; cv=none; b=p+WR9no9gD2xIx8D0TiW7NzSAltjJbMv04VtJobVs/Uc5Fbp6Nh+gMwy3cXvWAm9ASp5ckmOOAxOcowx39bhLlUael2bCXrOhVkaWNhHvRMKqMH2/hkL00AZAeGMPar/AMKuRh1RyZjumIAvbmvc0hJQnvBiGo8Psky1EMUtHe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424775; c=relaxed/simple;
	bh=LPpuxlWIT1z7uHXc6opXY8P9Wyk4YaW1Xuw4V99O8wI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvOAha9JrlJ+zWCswnyJ0tDRClqwVeGyesXpuOwtyjkIl0qd/XI+XPeTt9B62pWPVU/XwZxp0jjQtjSV4WO5tHNrBLphZW+Ey+AsOcOKtNKCdZlDeApPuQiDyG3zg8cXuShV9uY0gX0Tm97TkxOKhfaNSk+OnMyQC3nrGGhsjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVrDUO11; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVrDUO11"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788424773; x=1819960773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LPpuxlWIT1z7uHXc6opXY8P9Wyk4YaW1Xuw4V99O8wI=;
  b=XVrDUO11cgtB/U5SM0nmf7UXUQ2ivw+J/KZVd6kTYsJkYgWu7TqMhBMn
   Q2Qf4QuLhVpueJS1emBfUoJDiKXJTMHbybf4MC6BaI/T7svLb1wKNSWNm
   WiqSpzNSyb1axHIrTVN7cxgeRjwhKP9zhpunqDT1lu5eaTMR1YwEUKOoH
   hPmhsSSkF6yzNI7nAtvzCl9tpeEVBHlH+8G0R+PDXkxZb+vRxGGsNsSyV
   W9HMSgbqTJujFiiPVD8ox2ZL4L9zSYs3WNG6NOeVyP80/p7EfrMsS0jf3
   xEFEjpqMRZjtEVyzxPYD3hGlwqDNi09do+Zcomjj833EWCAkCuBLbgMHi
   g==;
X-CSE-ConnectionGUID: TuyeFkj8TVyVcSs42ED33A==
X-CSE-MsgGUID: c1eGUKyrQxyoDrsqjloOHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88824615"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88824615"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:39:32 -0700
X-CSE-ConnectionGUID: SxCGjFwzRKSyj5KngTndzQ==
X-CSE-MsgGUID: L3/MX/UAR7y0dF7Vqcez/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="267896703"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 01:39:32 -0700
Message-ID: <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com>
Date: Thu, 3 Sep 2026 16:39:29 +0800
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
To: Namhyung Kim <namhyung@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Gennady Kupava <gennady.kupava@gmail.com>,
 linux-perf-users@vger.kernel.org
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com> <apbs8gywyAfFVzqm@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <apbs8gywyAfFVzqm@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/1/2026 11:19 PM, Namhyung Kim wrote:
> Hello,
>
> On Mon, Aug 31, 2026 at 10:35:06AM +0530, Ravi Bangoria wrote:
>>>>> 2. perf: precise events and DWARF call graphs are mutually exclusive on this
>>>>>    hardware, so arguably perf should simply not let the two be combined.  I
>>>>>    would suggest two rules rather than one, because a blanket refusal would
>>>>>    make the common case worse:
>>>>>
>>>>>    - for the default event, drop the P when --call-graph dwarf is requested,
>>>>>      silently and on PMUs where precision means IBS.  Otherwise a plain
>>>>>      "perf record -g --call-graph dwarf" starts failing outright on every AMD
>>>>>      box, which is worse than today.  The s390 case in evlist.c suggests this
>>>>>      kind of substitution is considered acceptable;
>>>>>
>>>>>    - if the user asked for a precise event explicitly and also asked for
>>>>>      DWARF call chains, refuse with a message that says why and what to do,
>>>>>      instead of quietly producing a useless result.
>>>>>
>>>>>    Note that this should be scoped to IBS.  On Intel, PEBS records the whole
>>>>>    register set, so precise events and DWARF unwinding work together there
>>>>>    and nothing needs restricting.  Frame-pointer call graphs are also fine
>>>>>    with precise events - only the leaf frame is off.
>>>> I think we can enable both precise IP and dwarf callchains by using
>>>> PERF_SAMPLE_REGS_INTR.  For unwinding, it should use PERF_REG_X86_IP
>>>> from the REGS_INTR instead of sample.ip
>>> Ok, it seems we already do this in the perf tools but it looks like the
>>> kernel already overwrote the PERF_REG_X86_IP with the precise IP.  I
>>> feel like we should fix the kernel.
>> This should resolve the DWARF unwinding issue with IBS PMUs:
>>
>> --- a/arch/x86/events/amd/ibs.c
>> +++ b/arch/x86/events/amd/ibs.c
>> @@ -1523,8 +1523,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>>  			goto out;
>>  		}
>>  
>> -		set_linear_ip(&regs, ibs_data.regs[1]);
>> -		regs.flags |= PERF_EFLAGS_EXACT;
>> +		if (event->attr.sample_type & PERF_SAMPLE_IP) {
>> +			data.ip = ibs_data.regs[1];
>> +			data.sample_flags |= PERF_SAMPLE_IP;

We may not set PERF_SAMPLE_IP here, otherwise the kernel address leakage
check in perf_instruction_pointer() could be bypassed.


>> +			regs.flags |= PERF_EFLAGS_EXACT;
>> +		}
>>  	}
>>  
>>  	if (((ibs_caps & IBS_CAPS_BIT63_FILTER) ||
>> ---
> Right, that's what I thought.  And I believe we should do similar on
> Intel and not update other registers.

For Intel PEBS, the call-chain would always use the interrupt regs instead
of the PEBS regs, so there would be no issues for Intel PEBS.

    /*
     * We must however always use iregs for the unwinder to stay sane; the
     * record BP,SP,IP can point into thin air when the record is from a
     * previous PMI context or an (I)RET happened between the record and
     * PMI.
     */
    perf_sample_save_callchain(data, event, iregs);

Thanks.


>
>> However, there's no way to address the stack being out of sync with the
>> IBS RIP, since the IBS HW does not capture GPRs alongside the sample.
> I think it's ok and we don't need to sync IP and stack.  The dwarf
> unwind should start from stack and we can see the skid between IP and
> the first entry of the callchain.
>
> Thanks,
> Namhyung
