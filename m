Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29723009C1;
	Tue,  6 Jan 2026 06:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682555; cv=none; b=Y+58HlKeryalrzoSyS4b3q6LTOHlJPRlRgXqAYPoVZDCp+PcorJtjvKooD7BI0EBtJmFDTVnvi2yfpVoaAouHDFPBKVNH28W3QFaCSXtfJykw1eoi+23p7wDrgsExwmgD9Z73j2CBCbHGZwVyFsc21rK0vhH43vurSx6/fazOYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682555; c=relaxed/simple;
	bh=wL02dPt6uSlozjtJuPH+I4FMjBycYsMX7HEGPitSIaA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=BOdMTg9PBzVa/2lX98/DlY9TxIgcTpQ4oMAkHmd2XCDdPSjpy1PqvzZE9e91eW16nzvMAxF03v3bDGhhe17pyVIZAz6FlsKAE64IAqwudgsuKg8a8P6yrJUcl02ODPhtKNfMQ/OadpQqaJHtje1QpbHOckSK2V/qRp6dfaWYxaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCZAdH45; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCZAdH45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767682554; x=1799218554;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=wL02dPt6uSlozjtJuPH+I4FMjBycYsMX7HEGPitSIaA=;
  b=MCZAdH45QDBjOasPa/108jErcQ6UzEGK4yBF+vvuG01xfHm0pVkl9gpj
   2LLS5KAYwvVH1kXMpv6VkMjZn7aAl8ePtvOFdEQCwUAljTo4XbD1CkEqK
   NmZBRzGPtm+oqQe4bxzMxZoe4vJ+4rkCbVppaNXiSwSOl8yo3R6pRYp7y
   iSWcpG5FAMRLUzSn4A/uhLuWB7ldYYhDI2K5o+epTdYEjRwLmWTXROJC9
   91IyuJKYEoyEmbLnLrHY4p9bffzALkXdgQxPwVGkeyOuwdq9DDb28mBnI
   qWb3+repSd1tB4fUQZSNd/ZIdSXnmGT0+yaAdYSh7RVNC4kb6N5VTwXWH
   g==;
X-CSE-ConnectionGUID: lVEURJsQRvC63Qzu7YqUmA==
X-CSE-MsgGUID: 2hwPuf6mTQ2JfbKDRiuqoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="71626601"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="71626601"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 22:55:53 -0800
X-CSE-ConnectionGUID: lkfMgAGKRMu8g54mlyWnag==
X-CSE-MsgGUID: 2C/1U+IdSjqB+bjRrGCYcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="233718788"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 22:55:48 -0800
Message-ID: <efb339aa-17c5-4f7a-98f5-fb2a0ed4b0e5@linux.intel.com>
Date: Tue, 6 Jan 2026 14:55:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 13/19] perf/x86: Enable SSP sampling using
 sample_regs_* fields
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>
 <3e56e2f1-42bd-45e6-90a7-4105386d63ed@amd.com>
 <2c621029-e0d1-4d54-8abc-c25ee9cfb215@linux.intel.com>
Content-Language: en-US
In-Reply-To: <2c621029-e0d1-4d54-8abc-c25ee9cfb215@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/24/2025 2:26 PM, Mi, Dapeng wrote:
> On 12/24/2025 1:45 PM, Ravi Bangoria wrote:
>> Hi Dapeng,
>>
>>> This patch enables sampling of CET SSP register via the sample_regs_*
>>> fields.
>>>
>>> To sample SSP, the sample_simd_regs_enabled field must be set. This
>>> allows the spare space (reclaimed from the original XMM space) in the
>>> sample_regs_* fields to be used for representing SSP.
>>>
>>> Similar with eGPRs sampling, the perf_reg_value() function needs to
>>> check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then
>>> determine whether to output SSP or legacy XMM registers to userspace.
>> 1. The userspace SSP is saved in REGS_INTR even though interrupt regs
>>    are of kernel context. Would it be better to pass 0 instead (see the
>>    _untested_ patch below).
>>
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
>> @@ -71,7 +71,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
>>  			}
>>  			if (idx == PERF_REG_X86_SSP) {
>> -				if (!perf_regs->cet)
>> +				if (!perf_regs->cet || !user_mode(regs))
> Hmm, I'm not sure if we should add the user_mode() check here. For non-PEBS
> case, the SSP value indeed comes from the user space SSP MSR
> (MSR_IA32_PL3_SSP) since SSP is not used in kernel now. But for arch-PEBS,
> I don't get a clear indication that the SSP value comes from kernel space
> SSP (MSR_IA32_PL0_SSP) or the user space SSP (MSR_IA32_PL3_SSP) from the
> ISE doc (section 11.4.3 "General-Purpose Register Group"). Let me double
> confirm with our HW experts. Thanks for raising this.

Double confirm with the HW experts, PEBS HW engine just snapshots the
active SSP value regardless its privilege level. So when counter overflows
at kernel space, PEBS could snapshot the kernel space SSP.

Since SSP is not enabled in kernel space right now, the kernel space SSP
PEBS snapshots should be 0. But for sanity of safety, would clear the PEBS
SSP data to 0 if it's not a user-space SSP snapshot.


>
>
>>  					return 0;
>>  				return perf_regs->cet->user_ssp;
>>  			}
>>
>> 2. Could a simple "--user-regs=ssp / --intr-regs=ssp" (without SIMD/eGPR
>>    regs) fallback to an RDMSR instead of XSAVE? Possibly as a future
>>    enhancement if the current patches are already upstream ready.
> Yeah, good suggestion. Dave ever raised the efficiency concern for using
> xsaves to reading SSP
> (https://lore.kernel.org/all/3921d500-36ce-409c-8730-6be86a40e334@intel.com/).
> I don't see there are security risks by using rdmsr to read SSP value
> (Please correct me if it's wrong), I would add an extra patch to implement
> this optimization in the tail of next version patch-set. Thanks.
>
Just think twice, I'm not sure if rdmsr would always have better efficiency
than xsaves instruction. xsaves employs the "init" and "modified"
optimizations (although the "modified" optimization won't really be applied
for this perf sampling case) and user space SSP value can be directly
gotten from cached task fpu state if kernel has cached it, instead of
reading SSP by xsaves from hardware.

Anyway, we may need some data. I would try to get some data after the
patch-set refactoring is done.


>> Thanks,
>> Ravi
