Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606713CABC;
	Wed, 14 Aug 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723659318; cv=none; b=A9fcgh+bvICgSD+J4XSjDBYNaNe7YX+q+nFb3NYsLPjPlXGI/XCuSzbrro23XE5xxiykKxA1MvUzkrVyDZtJ3sOO3Y59GpgPB7rXkZiaj06f82f5/Wib1387wCjexd4OhKcIrtZXtcAYl43DMJ8vlCYKjgP0805MF8ZFdXRlMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723659318; c=relaxed/simple;
	bh=is7S2/rJ4MTcclVdO3VVsiHsnMVP/hqoxQUNrq2oNUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtlT0kHeY7X9RfKV0miuCgW2LhJu+7L+SOnaHz3WTfTR/6f9nF/mgBNGLeLXZcjSLHuC31S39UOWwbIshdM4TghKmUChcOiYNwyBxrthxhiXLUVLuUu8xtW5ymS/lnnLJIgzj/5b9q+Z+NPxV+zYd7JMCOs3Cg1/VEaogJiNbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+RD1Ec0; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+RD1Ec0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723659317; x=1755195317;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=is7S2/rJ4MTcclVdO3VVsiHsnMVP/hqoxQUNrq2oNUg=;
  b=i+RD1Ec0pO+8Ehhjk0o7OkiOOGMo2KnzHLpvydUZP4Cdwoqov92IFsqi
   3Feq1IqCPPcy3dte+LqMBjpbCmIc6g2d0LM02p/zPdfU9xKWt4TDjx4CY
   eEL/Wb+o8A4Uf+c1X5jI9oeOx2vO/OL0KA3gVNV94bp0JiYojihIUZd9u
   nHXds35bPyMGRHhpP7Erdnl81IU+NrLm1ZfDBzcgCnGtpPc2SEpIbYzY4
   TXKkO5fW3FOH/8LRHzEJXhxf5zs43NJpEqhhYd9Tz8wWqZONlY9rFcANm
   8gYeWoHTp9beqhZCArfEliC+3T7pAclAXqbEINFLG6uvpVXXXUd3wu4PF
   Q==;
X-CSE-ConnectionGUID: DCwE11ZoRjeZc9d88/jrPA==
X-CSE-MsgGUID: hNyLFZdQQMOH4ofXDV6KSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="32525568"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="32525568"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 11:15:16 -0700
X-CSE-ConnectionGUID: CPZA/4CmT8+ybdwBjwyLRg==
X-CSE-MsgGUID: poKIMBO7RS6shBqh0/JtHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="58767112"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 11:15:15 -0700
Received: from [10.212.17.191] (kliang2-mobl1.ccr.corp.intel.com [10.212.17.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 57C7120CFED8;
	Wed, 14 Aug 2024 11:15:13 -0700 (PDT)
Message-ID: <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com>
Date: Wed, 14 Aug 2024 14:15:11 -0400
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
 linux-kernel@vger.kernel.org
References: <87sev7nom4.ffs@tglx>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <87sev7nom4.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-14 10:52 a.m., Thomas Gleixner wrote:
> Li!
> 
> On Tue, Aug 13 2024 at 21:13, Li Huafei wrote:
>> On 2024/8/1 3:20, Thomas Gleixner wrote:
>>>> My machine has 32 physical cores, each with two logical cores. During
>>>> testing, it executes the CVE-2015-3290 test case 100 times concurrently.
>>>>
>>>> This warning was already present in [1] and a patch was given there to
>>>> limit period to 128 on Haswell, but that patch was not merged into the
>>>> mainline.  In [2] the period on Nehalem was limited to 32. I tested 16
>>>> and 32 period on my machine and found that the problem could be
>>>> reproduced with a limit of 16, but the problem did not reproduce when
>>>> set to 32. It looks like we can limit the cycles to 32 on Haswell as
>>>> well.
>>>
>>> It looks like? Either it works or not.
>>
>> It worked for my test scenario. I say "looks like" because I'm not sure
>> how it circumvents the problem, and if the limit of 32 no longer works
>> if I increase the number of test cases executed in parallel. Any
>> suggestions?
> 
> If you read back through the email history of these limits, then you can
> see that too short periods cause that problem on Broadwell due to a
> erratum, which is explained on top of the BDW limit.
> 
> Now looking at the HSW specification update specifically erratum HSW11:
> 
>   Performance Monitor Precise Instruction Retired Event May Present
>   Wrong Indications
> 
>   Problem:
>          When the Precise Distribution for Instructions Retired (PDIR)
>          mechanism is activated (INST_RETIRED.ALL (event C0H, umask
>          value 00H) on Counter 1 programmed in PEBS mode), the processor
>          may return wrong PEBS or Performance Monitoring Interrupt (PMI)
>          interrupts and/or incorrect counter values if the counter is
>          reset with a Sample- After-Value (SAV) below 100 (the SAV is
>          the counter reset value software programs in the MSR
>          IA32_PMC1[47:0] in order to control interrupt frequency).
> 
>   Implication:
>          Due to this erratum, when using low SAV values, the program may
>          get incorrect PEBS or PMI interrupts and/or an invalid counter
>          state.
> 
>   Workaround:
>          The sampling driver should avoid using SAV<100.
> 
> IOW, that's exactly the same issue as the BDM11 erratum.
> 
> Kan: Can you please go through the various specification updates and
> identify which generations are affected by this and fix it once and
> forever in a sane way instead of relying on 'tried until it works by
> some definition of works' hacks. These errata are there for a reason.

Sure. I will check all the related erratum and propose a fix.

> 
> 
> But that does not explain the fallout with that cve test because that
> does not use PEBS. It's using fixed counter 0.

The errata also mentions about the PMI interrupts, which may imply
non-PEBS case. I will double check with the architect.

According to the description of the patch, if I understand correctly, it
runs 100 CVE-2015-3290 tests at the same time. If so, all the GP
counters are used. Huafei, could you please confirm?

Thanks,
Kan
> 
> Li, you added that huge useless backtrace but cut off the output of
> perf_event_print_debug() after it. Can you please provide that
> information so we can see what the counter states are?
> 
>>>> +static void hsw_limit_period(struct perf_event *event, s64 *left)
>>>> +{
>>>> +	*left = max(*left, 32LL);
>>>> +}
>>>
>>> And why do we need a copy of nhm_limit_period() ?
>>>
>>
>> Do you mean why the period is limited to 32 like nhm_limit_period()?
> 
> No. If 32 is the correct limit, then we don't need another function
> which does exactly the same. So you can assign exactly that function for
> HSW, no?
> 
> Thanks,
> 
>         tglx
