Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8A3B679;
	Wed, 14 Aug 2024 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723664285; cv=none; b=V1x1HaCVmKimrIEUCFufzxiaO/ri8k5olkDZat/dfKF4IcTnTrZCLaAaxsIhfMt6xSgGn7MlMc/7ok+ChJmiHXGj5ixZVRKDI7aGjuI/TV3cl5QZx9BSNA+MlEyjSB3wkAjzkj9mkEjNbgZJrun7OYWc4uEsvem18Fo7Vac6BP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723664285; c=relaxed/simple;
	bh=2X+S2s1uWqkb1n7zXhrMhhXFROiV45BRva21USi8yEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8oq6h/ErkWAssNDwZi+GSlCLGCFNFTgFxSf2pvTIHPCaw/luriSi0lyfRq0iIbN4ZYs/vZiqlHft2Ct1GQLhDXslbFkLb+8Qn/IPNjKCFu3iY5sR/4o4cyOllHmftik2c7XGW3Fq9bOo8wXJO91RN+qTpPcW35cHIJ6PcsDhQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkLsY/bz; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkLsY/bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723664283; x=1755200283;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2X+S2s1uWqkb1n7zXhrMhhXFROiV45BRva21USi8yEo=;
  b=hkLsY/bzXOBRYfmUnB8/H4034KdVQd3nhI5Vh/74lfY3pNP7PvQNd36t
   6bvby31YyFcBk9e8RS5xPzZNDS0aAaot9XkR7jgfsTws+xTOFS0nQ9Rqr
   IJx86LN4s2WHym2vcYQikewDW01GnCcLXJIR+VcvwTzH2vjFdzIJnyGjZ
   Z+jfTPilickLXSinqtQ+nA0MmCe8cj+VqwsD+LfL/qRA1GTv7urAMK/AJ
   X/YkVjC7OiS/3lyHAMB60EBxy2IE1iOsoK2824GrK49GDYwGapgzodiXP
   R51WG3aQcobcTQZWwcpHGl29Di/wNk4A3OuPDqD3PEyIbL3EWjemZi/i2
   Q==;
X-CSE-ConnectionGUID: 2wDJ5rhPTH6UToHa2vV7Ew==
X-CSE-MsgGUID: jNE25Dj+Sk+JDIMCzo2GCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="39357075"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="39357075"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 12:38:02 -0700
X-CSE-ConnectionGUID: 2B6i/kTCTBeCHe+DcX0SrQ==
X-CSE-MsgGUID: xqEInKZ4SiuGHiYkPcUHlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59696423"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 12:38:02 -0700
Received: from [10.212.17.191] (kliang2-mobl1.ccr.corp.intel.com [10.212.17.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 7B08A20CFEDB;
	Wed, 14 Aug 2024 12:38:00 -0700 (PDT)
Message-ID: <70657c5e-f771-456b-a5ac-3df590249288@linux.intel.com>
Date: Wed, 14 Aug 2024 15:37:59 -0400
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
 <a42a3e35-2166-4539-930b-21ea0921e8d8@linux.intel.com> <87frr7nd28.ffs@tglx>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <87frr7nd28.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-14 3:01 p.m., Thomas Gleixner wrote:
> On Wed, Aug 14 2024 at 14:15, Kan Liang wrote:
>> On 2024-08-14 10:52 a.m., Thomas Gleixner wrote:
>>> Now looking at the HSW specification update specifically erratum HSW11:
>>>
>>>   Performance Monitor Precise Instruction Retired Event May Present
>>>   Wrong Indications
>>>
>>>   Problem:
>>>          When the Precise Distribution for Instructions Retired (PDIR)
>>>          mechanism is activated (INST_RETIRED.ALL (event C0H, umask
>>>          value 00H) on Counter 1 programmed in PEBS mode), the processor
>>>          may return wrong PEBS or Performance Monitoring Interrupt (PMI)
>>>          interrupts and/or incorrect counter values if the counter is
>>>          reset with a Sample- After-Value (SAV) below 100 (the SAV is
>>>          the counter reset value software programs in the MSR
>>>          IA32_PMC1[47:0] in order to control interrupt frequency).
>>>
>>>   Implication:
>>>          Due to this erratum, when using low SAV values, the program may
>>>          get incorrect PEBS or PMI interrupts and/or an invalid counter
>>>          state.
>>>
>>>   Workaround:
>>>          The sampling driver should avoid using SAV<100.
>>>
>>> IOW, that's exactly the same issue as the BDM11 erratum.
>>>
>>> Kan: Can you please go through the various specification updates and
>>> identify which generations are affected by this and fix it once and
>>> forever in a sane way instead of relying on 'tried until it works by
>>> some definition of works' hacks. These errata are there for a reason.
>>
>> Sure. I will check all the related erratum and propose a fix.
>>
>>> But that does not explain the fallout with that cve test because that
>>> does not use PEBS. It's using fixed counter 0.
>>
>> The errata also mentions about the PMI interrupts, which may imply
>> non-PEBS case. I will double check with the architect.
> 
> Ah. Indeed.
> 
>> According to the description of the patch, if I understand correctly, it
>> runs 100 CVE-2015-3290 tests at the same time. If so, all the GP
>> counters are used. Huafei, could you please confirm?
> 
> I can reproduce that way on my quad socket HSW almost instantaneously:
> 
> [10473.376928] CPU#16: ctrl:       0000000000000000
> [10473.376930] CPU#16: status:     0000000000000000
> [10473.376931] CPU#16: overflow:   0000000000000000
> [10473.376932] CPU#16: fixed:      00000000000000bb
> [10473.376933] CPU#16: pebs:       0000000000000000
> [10473.376934] CPU#16: debugctl:   0000000000004000
> [10473.376935] CPU#16: active:     0000000300000000
> [10473.376937] CPU#16:   gen-PMC0 ctrl:  0000000000134f2e
> [10473.376938] CPU#16:   gen-PMC0 count: 0000ffffffffffca
> [10473.376940] CPU#16:   gen-PMC0 left:  000000000000003b
> [10473.376941] CPU#16:   gen-PMC1 ctrl:  0000000000000000
> [10473.376943] CPU#16:   gen-PMC1 count: 0000000000000000
> [10473.376944] CPU#16:   gen-PMC1 left:  0000000000000000
> [10473.376946] CPU#16:   gen-PMC2 ctrl:  0000000000000000
> [10473.376947] CPU#16:   gen-PMC2 count: 0000000000000000
> [10473.376948] CPU#16:   gen-PMC2 left:  0000000000000000
> [10473.376949] CPU#16:   gen-PMC3 ctrl:  0000000000000000
> [10473.376950] CPU#16:   gen-PMC3 count: 0000000000000000
> [10473.376952] CPU#16:   gen-PMC3 left:  0000000000000000
> [10473.376953] CPU#16: fixed-PMC0 count: 0000fffffffffffe
> [10473.376954] CPU#16: fixed-PMC1 count: 0000fffbabf57908
> [10473.376955] CPU#16: fixed-PMC2 count: 0000000000000000
> 
> [10473.376928] CPU#88: ctrl:       0000000000000000
> [10473.376930] CPU#88: status:     0000000000000000
> [10473.376931] CPU#88: overflow:   0000000000000000
> [10473.376932] CPU#88: fixed:      00000000000000bb
> [10473.376933] CPU#88: pebs:       0000000000000000
> [10473.376934] CPU#88: debugctl:   0000000000004000
> [10473.376935] CPU#88: active:     0000000300000000
> [10473.376937] CPU#88:   gen-PMC0 ctrl:  0000000000134f2e
> [10473.376939] CPU#88:   gen-PMC0 count: 0000fffffffffff2
> [10473.376940] CPU#88:   gen-PMC0 left:  00000000000000a8
> [10473.376942] CPU#88:   gen-PMC1 ctrl:  0000000000000000
> [10473.376944] CPU#88:   gen-PMC1 count: 0000000000000000
> [10473.376945] CPU#88:   gen-PMC1 left:  0000000000000000
> [10473.376946] CPU#88:   gen-PMC2 ctrl:  0000000000000000
> [10473.376947] CPU#88:   gen-PMC2 count: 0000000000000000
> [10473.376949] CPU#88:   gen-PMC2 left:  0000000000000000
> [10473.376950] CPU#88:   gen-PMC3 ctrl:  0000000000000000
> [10473.376951] CPU#88:   gen-PMC3 count: 0000000000000000
> [10473.376952] CPU#88:   gen-PMC3 left:  0000000000000000
> [10473.376953] CPU#88: fixed-PMC0 count: 0000fffffffffffe
> [10473.376955] CPU#88: fixed-PMC1 count: 0000fffa79a83958
> [10473.376956] CPU#88: fixed-PMC2 count: 0000000000000000
> 
> This happens at the very same time and CPU#88 is the HT sibling of
> CPU#16
> 

The fixed counter 0 is used which doesn't match of what the HSW11
describes. I will check if the HSW11 missed the case, or if there is
another issue.

Thanks,
Kan
