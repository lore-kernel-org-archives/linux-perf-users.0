Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7F8399CEE;
	Wed,  3 Jun 2026 15:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499386; cv=none; b=aEATzlTkBnxN0svMsZB68Rve+Fg6gIifnmlMzSOrL1rPQFTh02YzN2iPHMJKKCG/MSItSD6onjOpBVzXUldD+hWMPhO3+RkwHdk/DVHbzYpnrFii1BuDRIriDT6dWDObEHUVShrWd4uTs97wETlFRyopc+Yu3/VyFqzqe4z5UBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499386; c=relaxed/simple;
	bh=x3Mj2Mx2JfGeE8/nqhc1RLOemDeVXfRBHPhzoDXZyg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAn5LBnfNqrZeNpW6yPeBFXB8e9m07hgJ42dNIoXYUOQBj0IdOYAATpP5T7o9/me8HMldihUk2T1jz/gkc+RX9wwGV9XBieDa8sPdaGlAB/lIPDT6BlfYcJiUCx5NpLV8m09GfdmG9mqX/PSj/dHYC4knKCbdDD31I8O9ks5AJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYY7OyWX; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYY7OyWX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780499385; x=1812035385;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x3Mj2Mx2JfGeE8/nqhc1RLOemDeVXfRBHPhzoDXZyg0=;
  b=lYY7OyWXpR/Vh06LL/eh5JScY2dGo4Nt4trUSr5luOBeZb7vq4d3FO16
   EfWyDwjnxPKiT0iebXkXKC/S05pcnJGE5qgalJp5Un4BqksjGXok2T8y/
   mImm0i0mHpziXFYmAdkHYqSji2EG0AwKZNxBlX3yzTg+kN1hgQmlqpUdP
   JSxIwNp/AdP2G/ISNeKOtzULeVlMc5HeHNr0lVZ1zhKD4lA3IVi+a0BVd
   C/qyA+/lzekEu7MPFmLHpTyaShmtHhOYaMk+U+vhWknI8LxI/Sa3EZxwb
   xz64jDImb5WYxbPzwXrhR6PATIEsn6sem1ScMFhJMqi5krkz7MKkkNgxG
   Q==;
X-CSE-ConnectionGUID: PnfL+sryTiuEHrlog95s0Q==
X-CSE-MsgGUID: fUtPME4qRn65uUwTA5YaMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91885944"
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="91885944"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:09:44 -0700
X-CSE-ConnectionGUID: sr7dFjRDS4uylcZs4xLJIg==
X-CSE-MsgGUID: E8Jvoh1KTdyL97f06lNC6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,185,1774335600"; 
   d="scan'208";a="240087809"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 08:09:39 -0700
Message-ID: <d9402295-4f46-4630-a5dd-f66e6627793a@intel.com>
Date: Wed, 3 Jun 2026 10:09:38 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/8] perf/x86/intel/uncore: Fix refcnt and other
 cleanups
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-3-zide.chen@intel.com>
 <1643127e-9a3f-421a-a690-9b363ccfa8e6@linux.intel.com>
 <1640889a-53ed-46ad-b78b-35982ff37b33@intel.com>
 <d71fbc71-aedd-4822-9ddc-1b8fadb07314@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <d71fbc71-aedd-4822-9ddc-1b8fadb07314@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/2/2026 8:13 PM, Mi, Dapeng wrote:
> 
> On 6/2/2026 10:16 PM, Chen, Zide wrote:
>>
>> On 6/2/2026 4:52 AM, Mi, Dapeng wrote:
>>> On 6/2/2026 1:01 AM, Zide Chen wrote:
>>>> Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.
>>>>
>>>> Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
>>>> reflect its actual meaning and be consistent with other functions.
>>>>
>>>> Remove the incorrect atomic_inc(&box->refcnt) from
>>>> uncore_pci_pmu_register(): PCI boxes are not tracked by refcnt,
>>>> and this call incorrectly increments it on a per-die basis.
>>>>
>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>> ---
>>>> v2:
>>>> - Don't rename pmu->activeboxes and keep its semantics because in
>>>>   uncore_pci_remove() path, uncore_pci_pmu_unregister() won't be
>>>>   called for non-active boxes.
>>>> - Since pmu->activeboxes keeps it's name, don't need to rename
>>>>   box->refcnt to box->cpu_refcnt.
>>>> ---
>>>>  arch/x86/events/intel/uncore.c | 11 +++++------
>>>>  arch/x86/events/intel/uncore.h |  6 +++---
>>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>>> index b69b6a21d46b..d759888476c3 100644
>>>> --- a/arch/x86/events/intel/uncore.c
>>>> +++ b/arch/x86/events/intel/uncore.c
>>>> @@ -1170,7 +1170,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
>>>>  	if (!box)
>>>>  		return -ENOMEM;
>>>>  
>>>> -	atomic_inc(&box->refcnt);
>>> I'm not sure if we should remove this. The
>>> uncore_box_ref()/uncore_box_unref() are only called for MSR or MMIO type
>>> uncore PMUs. For the uncore PMUs of PCI type, the box->refcnt is only
>>> increased here. All the 3 kinds of uncore PMUs should keep consistent
>>> behavior on the refcnt. 
>> box->refcnt tracks how many CPUs are active within this die. Here it is
>> incorrectly incremented on a per-die basis. Additionally, during the PCI
>> uncore enumeration or teardown process, there is no per-CPU context, so
>> box->refcnt is useless in PCI uncore.
>>
>> PCI uncore only needs pmu->activeboxes.
> 
> Per my understanding, the main aim of refcnt is to prevent the box
> structure is freed unexpectedly, it doesn't directly couple with CPUs. It
> just records how many users are using the the box regardless the users are
> CPU or something else. For the uncore PMUs of MSR and MMIO type, CPUs can
> be seen as the users, while for the uncore PMUs of PCI, I suppose the dies
> (actually any cpu on the die) can be seen the users. 

No, box->refcnt is a refcnt for in-die CPUs, while pmu->activeboxes is a
per-die count. They are clear and distinct. That's also why I tried to
rename them to box->cpu_refcnt and pmu->die_refcnt in v1.

If this line is not deleted, box->refcnt for PCI boxes is always <= 1,
which is confusing and useless.

 > If we delete this refcnt reference, then the box structure is under no
> protection and the box structure could be freed by some accidents. 

box->refcnt is not checked on any PCI boxes; Because there is one
pmu->box[die] per die, it utilizes box->refcnt for MSR/MMIO boxes only:

- box_ref(): first in-die CPU online — allocate and initialize the box.
- box_unref(): last in-die CPU offline — tear down the box.

Uncore PCI PMU enumeration and hot plug/unplug do not involve any CPU
online/offline events, which is why box->refcnt is not used.

> 
>>
>>> Could we keep this and just decrease the refcnt in
>>> uncore_pci_pmu_unregister()? Thanks.
>>>
>>>
>>>>  	box->dieid = die;
>>>>  	box->pci_dev = pdev;
>>>>  	box->pmu = pmu;
>>>> @@ -1518,7 +1517,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
>>>>  		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
>>>>  }
>>>>  
>>>> -static void uncore_box_unref(struct intel_uncore_type **types, int id)
>>>> +static void uncore_box_unref(struct intel_uncore_type **types, int die)
>>>>  {
>>>>  	struct intel_uncore_type *type;
>>>>  	struct intel_uncore_pmu *pmu;
>>>> @@ -1529,7 +1528,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
>>>>  		type = *types;
>>>>  		pmu = type->pmus;
>>>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>>>> -			box = pmu->boxes[id];
>>>> +			box = pmu->boxes[die];
>>>>  			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
>>>>  				uncore_box_exit(box);
>>>>  		}
>>>> @@ -1604,14 +1603,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
>>>>  }
>>>>  
>>>>  static int uncore_box_ref(struct intel_uncore_type **types,
>>>> -			  int id, unsigned int cpu)
>>>> +			  int die, unsigned int cpu)
>>>>  {
>>>>  	struct intel_uncore_type *type;
>>>>  	struct intel_uncore_pmu *pmu;
>>>>  	struct intel_uncore_box *box;
>>>>  	int i, ret;
>>>>  
>>>> -	ret = allocate_boxes(types, id, cpu);
>>>> +	ret = allocate_boxes(types, die, cpu);
>>>>  	if (ret)
>>>>  		return ret;
>>>>  
>>>> @@ -1619,7 +1618,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>>>  		type = *types;
>>>>  		pmu = type->pmus;
>>>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>>>> -			box = pmu->boxes[id];
>>>> +			box = pmu->boxes[die];
>>>>  			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
>>>>  				uncore_box_init(box);
>>>>  		}
>>>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>>>> index c2e5ccb1d72c..bad5d8dec8e0 100644
>>>> --- a/arch/x86/events/intel/uncore.h
>>>> +++ b/arch/x86/events/intel/uncore.h
>>>> @@ -185,7 +185,7 @@ struct intel_uncore_box {
>>>>  #define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
>>>>  #define CFL_UNC_CBO_7_PER_CTR0			0xf76
>>>>  
>>>> -#define UNCORE_BOX_FLAG_INITIATED		0
>>>> +#define UNCORE_BOX_FLAG_INITIALIZED		0
>>>>  /* event config registers are 8-byte apart */
>>>>  #define UNCORE_BOX_FLAG_CTL_OFFS8		1
>>>>  /* CFL 8th CBOX has different MSR space */
>>>> @@ -559,7 +559,7 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
>>>>  
>>>>  static inline void uncore_box_init(struct intel_uncore_box *box)
>>>>  {
>>>> -	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
>>>> +	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>>>>  		if (box->pmu->type->ops->init_box)
>>>>  			box->pmu->type->ops->init_box(box);
>>>>  	}
>>>> @@ -567,7 +567,7 @@ static inline void uncore_box_init(struct intel_uncore_box *box)
>>>>  
>>>>  static inline void uncore_box_exit(struct intel_uncore_box *box)
>>>>  {
>>>> -	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
>>>> +	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>>>>  		if (box->pmu->type->ops->exit_box)
>>>>  			box->pmu->type->ops->exit_box(box);
>>>>  	}
>>

