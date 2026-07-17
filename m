Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E42146D5A;
	Fri, 17 Jul 2026 00:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247998; cv=none; b=S5xcVoH1hajFTMUjZU548dZfST/lFjzl1nv+dTN/IZLdQMEkaT1G5CSb4suySq72lEGqppq0lBWO2IYhjHCdNO64BrhB6soPOdSSckWlMKj5S/7c2Eri1NGMA/Q3fwIBMiul1lcvmRI68wcezlHaMRJctpwoZqoMAbtUjDxhB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247998; c=relaxed/simple;
	bh=Agm7wxQwQbPfZBiQnZis7YPJks8mee6bjrh//fqryRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ES3nEREWttbbkGkOifSix7Jj5opQa36annX7ALUl6SP5eDHkN1x7JeLbQom8SOfX3aUeRs1aHzeEO0vckE5YNRBsi1ysn2fadeb6eXPHrW0uf86C+BAwKEcs2lCbTUsrowl1CUzjYB4EK2AfmYaI+DhRnrExXGB5ONwHsQFGJi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ris6t6yp; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ris6t6yp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784247996; x=1815783996;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Agm7wxQwQbPfZBiQnZis7YPJks8mee6bjrh//fqryRA=;
  b=Ris6t6yp1CjNvkty8hCPtdjirW7e7kPEebHKIhkVBOfJYYyQM8JjDLs+
   k/Q6J+6Q0X0rNebezhXsl/pFY+JKPHqjIPIVeftHw7kFvxz0QZZJG8xgK
   KXySDFTlndzSg1ZHYm/KaaskadeBPR4koN3GeQa6Y7KgZ5HwSciCDCORF
   /ww2dIV771Hc8Nt6PsTVnv9j5zxGEQIroj+r/rt3OUvGT8wnmQdGPzk0M
   cgk59ZfmGffq8SDSKt9NoZRMviIbgf5T5lDSCOdQpGeEBYFWyUP93M4vp
   sXr1Sz3creAOHk0einrhy7Swfss6nScl5OZYmk/RKkvr4h4p7nYsYPZzy
   A==;
X-CSE-ConnectionGUID: nmmpaziISq2rezTQMDOLvw==
X-CSE-MsgGUID: uW3HxXNCTFesF1wwN3yiGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84042490"
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="84042490"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 17:26:35 -0700
X-CSE-ConnectionGUID: l7iJgWwRR2Cqs5adpssKig==
X-CSE-MsgGUID: 0hVJzSB9TyugNfoiv7Is4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,168,1779174000"; 
   d="scan'208";a="252241908"
Received: from unknown (HELO [10.238.3.181]) ([10.238.3.181])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 17:26:33 -0700
Message-ID: <c02e35a6-1a94-47c3-b2aa-8c52fec671a7@linux.intel.com>
Date: Fri, 17 Jul 2026 08:26:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip:perf/core] [perf/core] 166f10836a:
 perf-sanity-tests.Object_code_reading.fail
To: Namhyung Kim <namhyung@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org
References: <202607091054.7c96d6c6-lkp@intel.com>
 <56069e78-7006-4569-add0-6ccdf88c746b@linux.intel.com>
 <alCwJew7UgGb+EQV@xsang-OptiPlex-9020>
 <803bfea9-b16c-44d5-8004-096a92e90017@linux.intel.com>
 <alkhQXgadepTWbk9@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <alkhQXgadepTWbk9@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/17/2026 2:21 AM, Namhyung Kim wrote:
> Hello,
>
> Thanks for taking a look.
>
> On Thu, Jul 16, 2026 at 02:29:49PM +0800, Mi, Dapeng wrote:
>> On 7/10/2026 4:41 PM, Oliver Sang wrote:
>>> hi, Dapeng,
>>>
>>> On Thu, Jul 09, 2026 at 05:04:11PM +0800, Mi, Dapeng wrote:
>>>> Hi Oliver,
>>>>
>>>> It looks the direct reason causing the test case failure is the "0" sampled
>>>> IP. This is expected. The commit 166f10836a653dfa280d4335603b52f685b8b1ef
>>>> ("perf/core: Fix kernel register info leak via hardware skid") mitigates a
>>>> security hole and may lead to the sampled IP could be 0. 
>>>>
>>>> What user right is used to run this command, root or normal user? If it's a
>>> root user. as 'sudo' in attached:
>>>
>>> "2026-07-10 15:38:50 sudo ASAN_OPTIONS=fast_unwind_on_malloc=0 /usr/src/linux-perf-x86_64-rhel-9.4-bpf-166f10836a653dfa280d4335603b52f685b8b1ef/tools/perf/perf test 23 -vvv"
>>>
>>>> root user, suppose it should not generate such kind of error. Could you
>>>> please add "-vvv" option and rerun this test? The "-vvv" option would print
>>>> more  verbose log.
>>> as attached, thanks
>> "
>>
>>   disabled                         1
>>   inherit                          1
>>   *exclude_kernel                   1*
>>   exclude_hv                       1
>>   mmap                             1
>>
>> "
>>
>> The event "exclude_kernel" attribute is set in the test case,  so it's
>> possible that perf overwrites the kernel IP to 0 to prevent kernel IP
>> leakage if PMI hits into kernel space. 
> I expect PMU doesn't hit samples in the kernel when exclude_kernel is
> set.  But maybe there are some corner cases.

The reason is that there is an hardware skid between counter overflow and
PMI triggering. The counter could overflow at user space but the PMI hits
kernel space subsequently and gets a kernel IP as the hardware skid. 

To prevent this kernel IP or registers leakage, the patch
https://lore.kernel.org/all/20260616044654.3468742-8-dapeng1.mi@linux.intel.com/
overwrites the kernel IP to 0.


>
>> In general, the "exclude_kernel" attribute should not be set for root user,
>> I have no idea why "exclude_kernel" is set in this case.
> The test explicitly runs with it both for hardware and software events.
> I think it wants to check the privilege filter as well.
>
>> Anyway, we could have to improve this test case and skip these "0" sample IPs.
> Yep, probably that's the simplest fix.

Besides this fix, another patch
https://lore.kernel.org/all/20260616044654.3468742-9-dapeng1.mi@linux.intel.com/
fixes the kernel callchain leakage risk, it could lead to the perf event
creation failure when PERF_SAMPLE_CALLCHAIN is required but without
exclude_callchain_kernel attribute. This needs extra  fallback mechanism
just like currently what to do for the exclude_kernel attribute.

We would add these 2 fixes later.

Thanks.


>
> Thanks,
> Namhyung
>
>
