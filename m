Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA2247F79A
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Sep 2026 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788436783; cv=none; b=MuAdJ21yjialutRulyygFcGKXclp5Bawvyea2jTWkT58FWV/A7YXM/uU2daqNVXKlfop5DNknlpM2uc+ddPQTa+nrNAFWIrr2wosSf0KC0VH0XBCsMZ1p+BuAbh0w6coXTndm24pC7wNuyHc1DtFasd9F6aGS75qISO/1kA2cWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788436783; c=relaxed/simple;
	bh=cxhm65cNP8DiOqf111ohz9UmvwiIiLJcCoD17zOK5FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xp2iEq9nw7EBjDq7eta2bP3kClAYPazPBM2WnclmKJu41340NH7/QmaXuYBpVjhwXoxt/7AxrhUrR3Dkd2YdjYtckULEz/U1XHmDyXZQIeSsUoOsjbk5AEFCFXAK/VgrtR2l7gPgC5KwBf3vgJVOwQ6rg4Zj4Y+HRky3+hC4vNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlmIOvQB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlmIOvQB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788436782; x=1819972782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cxhm65cNP8DiOqf111ohz9UmvwiIiLJcCoD17zOK5FU=;
  b=SlmIOvQB9bFMsrOBeBhG5keSioli42QQeAdrD0kcQRoyixupmrpWBkPX
   lcKGLKzVxVTgs0Xj+0Nm5fkHwGH0OhWrHW8XwQQMBdDseeT5ncNqf+QDb
   oDh7DXbKpK2ajD8Kejgr1+s/FszAERlgwXwCiKQ80x3M3WPFQwXHZxOlj
   3wy1miYE2q8pByhfJuncEEdUGw392F4xHkr8yV/hr9wA8N8V0NCIPkFj6
   jS9XLrmGS1Hz5UOTBhgR6kzkJXXVSu2n8vBLPc7Gpg9z/tC5AJQjj9wjh
   0SbJqUePap4z6x6yITdBAa5ujCEb6VSp8b483v3UlJw0Z9iFrLnlbVpPN
   g==;
X-CSE-ConnectionGUID: qd57WPkjRqq1+OQrXGxhNw==
X-CSE-MsgGUID: nxcun5VURuqSLZzW6YKlKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106437036"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="106437036"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:59:34 -0700
X-CSE-ConnectionGUID: 4k8rw4G1QaWcFxHYj6Gfug==
X-CSE-MsgGUID: DX2eDsh0Q8WFcsjAQM2vWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294572006"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.239]) ([10.124.241.239])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 04:59:33 -0700
Message-ID: <a5d3798c-7d62-43d0-88c6-eec26bd4f63d@linux.intel.com>
Date: Thu, 3 Sep 2026 19:59:29 +0800
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
To: Ravi Bangoria <ravi.bangoria@amd.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Gennady Kupava <gennady.kupava@gmail.com>,
 linux-perf-users@vger.kernel.org
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com> <apbs8gywyAfFVzqm@google.com>
 <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com>
 <7b4cba95-dacc-4cf1-953f-c59e06e693d0@amd.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <7b4cba95-dacc-4cf1-953f-c59e06e693d0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 9/3/2026 7:36 PM, Ravi Bangoria wrote:
>>>> This should resolve the DWARF unwinding issue with IBS PMUs:
>>>>
>>>> --- a/arch/x86/events/amd/ibs.c
>>>> +++ b/arch/x86/events/amd/ibs.c
>>>> @@ -1523,8 +1523,11 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
>>>>  			goto out;
>>>>  		}
>>>>  
>>>> -		set_linear_ip(&regs, ibs_data.regs[1]);
>>>> -		regs.flags |= PERF_EFLAGS_EXACT;
>>>> +		if (event->attr.sample_type & PERF_SAMPLE_IP) {
>>>> +			data.ip = ibs_data.regs[1];
>>>> +			data.sample_flags |= PERF_SAMPLE_IP;
>> We may not set PERF_SAMPLE_IP here, otherwise the kernel address leakage
>> check in perf_instruction_pointer() could be bypassed.
> Yes. I realized this wouldn't be straightforward, since the privilege
> level might change between when the HW captures the sample and when the
> NMI is delivered. So, any perf code that depends on user_mode() (e.g.
> perf_exclude_event(), _REGS_USER, _REGS_INTR, header->misc, etc.) may
> regress with the above change. In addition, guest entry/exit occurring
> between sample capture and NMI delivery further complicates the problem.
>
>>> Right, that's what I thought.  And I believe we should do similar on
>>> Intel and not update other registers.
>> For Intel PEBS, the call-chain would always use the interrupt regs instead
>> of the PEBS regs, so there would be no issues for Intel PEBS.
>>
>>     /*
>>      * We must however always use iregs for the unwinder to stay sane; the
>>      * record BP,SP,IP can point into thin air when the record is from a
>>      * previous PMI context or an (I)RET happened between the record and
>>      * PMI.
>>      */
>>     perf_sample_save_callchain(data, event, iregs);
> This wouldn't take care of _STACK_USER, right?

Yes, I just realized this is not fully correct for Intel PEBS after sending
the comments.

On Intel platforms, for SAMPLE_STACK_USER, the IP/SP/BP is consistent and
they all comes from PEBS, so the DWARF unwinding has no issues. But for
SAMPLE_CALLCHAIN, it's not consistent, the IP is overwritten by PEBS while
the BP/SP are still gotten from PMI. So the kernel call-chain unwinding
could not work.

Suppose we need to follow below 2 rules to ensure the correct call-chain
unwinding and register snapshot consistency.

1. All registers including IP should come from either PEBS or PMI, must not
be mixed. This ensures to get an consistent registers snapshot.

2. Either SAMPLE_CALLCHAIN or SAMPLE_STACK_USER is required, the PMI
registers snapshot must be used. This proves the correct DWARF unwinding.

How's your idea?

Thanks.


>
> Thanks,
> Ravi
