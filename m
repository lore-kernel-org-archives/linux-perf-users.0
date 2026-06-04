Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AD8356765;
	Thu,  4 Jun 2026 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587684; cv=none; b=g5nCJ/lKFNWmBQN4h/qzEy/OIRuygKyzlhkU1DbAHiKQfDNEUhP4kDjdGGuZo8+/TDrV1ANn02Or8sC46v5GET6oyOz1X1j3VZZ7E8sC/DUpBJ8h90UZwoERP0lQN44w+bV62PciTqMWHm6Nf6597kJGyQzOYrOFIdJszEV0qQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587684; c=relaxed/simple;
	bh=vjpx6iif2SN+mz6q2FhkS6oWteDl5dJVjvY4e1faHAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1IteySVN8xZNCXrY8U7ref7QEDUdrij+G294rnJUCZhyubOP3thMSHz9L6JPW3c8OPFUEam88TSVolsSiUQ3Z+LPrdTr+u6UM2hn8CKEGJKTP79LHFs4R21QYy040K8dZBJnWSLVnGa5eK37RgDK/Sq6DrJYO2C0AomX2dHHiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnYgxtXd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnYgxtXd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780587683; x=1812123683;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vjpx6iif2SN+mz6q2FhkS6oWteDl5dJVjvY4e1faHAQ=;
  b=WnYgxtXdUco32flxELYmBOm9rpmVNAwnCbhwK25Dom0K+eJk9v6nIhec
   PgGRjG+fChaYT6SMjnajIpa0yZVIP9LuzQowvEWbd35R1REu06mIdLiNK
   Jz7UodLbkHOF/3j3aUxyFki4dhQlMN6CqZnSXU8AM3EWVPlMjflHrCtbo
   QHH8lRdnq/31iy6gt+xzQxA788scDk+myAPxKpC2GS5sTuAc5HWJ3KfJ9
   XNFb4NfxVg/137IbvWOb3EFaACicaDJzPJF5RSI7hwPYq08Vrm3Qs8i5k
   7rJ/PtpdS+e6S5AIU/Y+AsK7nMUwS2JnSViMHG5ClKNc7k2y+XA8ByDpg
   A==;
X-CSE-ConnectionGUID: IA6tvtAZS2244LMecdS7Zw==
X-CSE-MsgGUID: QA6ZtPyOQgykR0+SkcJhrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="91991880"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="91991880"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:41:21 -0700
X-CSE-ConnectionGUID: uLqs7nwCQbux9eP2ezpSLQ==
X-CSE-MsgGUID: NImUmZX9RPu9EqXgZrdKrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="240392266"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:41:20 -0700
Message-ID: <f4fd8bd6-bb61-401c-9e36-efaff86cf96c@intel.com>
Date: Thu, 4 Jun 2026 10:41:19 -0500
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
 <d9402295-4f46-4630-a5dd-f66e6627793a@intel.com>
 <e1afadac-76d5-4b71-b5e4-ebae89bfc1b0@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <e1afadac-76d5-4b71-b5e4-ebae89bfc1b0@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/3/2026 8:00 PM, Mi, Dapeng wrote:
> 
> On 6/3/2026 11:09 PM, Chen, Zide wrote:
>>
>> On 6/2/2026 8:13 PM, Mi, Dapeng wrote:
>>> On 6/2/2026 10:16 PM, Chen, Zide wrote:
>>>> On 6/2/2026 4:52 AM, Mi, Dapeng wrote:
>>>>> On 6/2/2026 1:01 AM, Zide Chen wrote:
>>>>>> Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.
>>>>>>
>>>>>> Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
>>>>>> reflect its actual meaning and be consistent with other functions.
>>>>>>
>>>>>> Remove the incorrect atomic_inc(&box->refcnt) from
>>>>>> uncore_pci_pmu_register(): PCI boxes are not tracked by refcnt,
>>>>>> and this call incorrectly increments it on a per-die basis.
>>>>>>
>>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>>>>>> ---
>>>>>> v2:
>>>>>> - Don't rename pmu->activeboxes and keep its semantics because in
>>>>>>   uncore_pci_remove() path, uncore_pci_pmu_unregister() won't be
>>>>>>   called for non-active boxes.
>>>>>> - Since pmu->activeboxes keeps it's name, don't need to rename
>>>>>>   box->refcnt to box->cpu_refcnt.
>>>>>> ---
>>>>>>  arch/x86/events/intel/uncore.c | 11 +++++------
>>>>>>  arch/x86/events/intel/uncore.h |  6 +++---
>>>>>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>>>>>> index b69b6a21d46b..d759888476c3 100644
>>>>>> --- a/arch/x86/events/intel/uncore.c
>>>>>> +++ b/arch/x86/events/intel/uncore.c
>>>>>> @@ -1170,7 +1170,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
>>>>>>  	if (!box)
>>>>>>  		return -ENOMEM;
>>>>>>  
>>>>>> -	atomic_inc(&box->refcnt);
>>>>> I'm not sure if we should remove this. The
>>>>> uncore_box_ref()/uncore_box_unref() are only called for MSR or MMIO type
>>>>> uncore PMUs. For the uncore PMUs of PCI type, the box->refcnt is only
>>>>> increased here. All the 3 kinds of uncore PMUs should keep consistent
>>>>> behavior on the refcnt. 
>>>> box->refcnt tracks how many CPUs are active within this die. Here it is
>>>> incorrectly incremented on a per-die basis. Additionally, during the PCI
>>>> uncore enumeration or teardown process, there is no per-CPU context, so
>>>> box->refcnt is useless in PCI uncore.
>>>>
>>>> PCI uncore only needs pmu->activeboxes.
>>> Per my understanding, the main aim of refcnt is to prevent the box
>>> structure is freed unexpectedly, it doesn't directly couple with CPUs. It
>>> just records how many users are using the the box regardless the users are
>>> CPU or something else. For the uncore PMUs of MSR and MMIO type, CPUs can
>>> be seen as the users, while for the uncore PMUs of PCI, I suppose the dies
>>> (actually any cpu on the die) can be seen the users. 
>> No, box->refcnt is a refcnt for in-die CPUs, while pmu->activeboxes is a
>> per-die count. They are clear and distinct. That's also why I tried to
>> rename them to box->cpu_refcnt and pmu->die_refcnt in v1.
>>
>> If this line is not deleted, box->refcnt for PCI boxes is always <= 1,
>> which is confusing and useless.
>>
>>  > If we delete this refcnt reference, then the box structure is under no
>>> protection and the box structure could be freed by some accidents. 
>> box->refcnt is not checked on any PCI boxes; Because there is one
>> pmu->box[die] per die, it utilizes box->refcnt for MSR/MMIO boxes only:
>>
>> - box_ref(): first in-die CPU online — allocate and initialize the box.
>> - box_unref(): last in-die CPU offline — tear down the box.
>>
>> Uncore PCI PMU enumeration and hot plug/unplug do not involve any CPU
>> online/offline events, which is why box->refcnt is not used.
> 
> No, the refcnt is still useful even for pci type's uncore PMUs, especially
> from the software's perspective. refcnt is the essential way to prevent the
> unexpected free of the referenced structure. Although currently there would
> be only one user for pci type's uncore PMUs and refcnt would be 1 in most
> time, we can't ensure the code would always right in any time and no code
> accidentally free the box. We'd better keep this refcnt mechanism to avoid
> this situation. Thanks.

pmu->activeboxes is the refcnt used by PCI PMUs, whose online/offline
events operate on a per-die basis.

box->refcnt is the refcnt used by MSR/MMIO PMUs, where online/offline
events are per-CPU based.

In this particular case (uncore_pci_pmu_register(), prior to the
upcoming refactor), incrementing box->refcnt also increments
pmu->activeboxes. This makes box->refcnt completely redundant for PCI
PMUs and effectively a misuse of the per-cpu field for a per-die operation.

If I’m missing any scenarios where PCI PMU boxes still require
additional protection from box->refcnt, please help point them out.

>>
>>>>> Could we keep this and just decrease the refcnt in
>>>>> uncore_pci_pmu_unregister()? Thanks.
>>>>>
>>>>>
>>>>>>  	box->dieid = die;
>>>>>>  	box->pci_dev = pdev;
>>>>>>  	box->pmu = pmu;
>>>>>> @@ -1518,7 +1517,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
>>>>>>  		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
>>>>>>  }
>>>>>>  
>>>>>> -static void uncore_box_unref(struct intel_uncore_type **types, int id)
>>>>>> +static void uncore_box_unref(struct intel_uncore_type **types, int die)
>>>>>>  {
>>>>>>  	struct intel_uncore_type *type;
>>>>>>  	struct intel_uncore_pmu *pmu;
>>>>>> @@ -1529,7 +1528,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
>>>>>>  		type = *types;
>>>>>>  		pmu = type->pmus;
>>>>>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>>>>>> -			box = pmu->boxes[id];
>>>>>> +			box = pmu->boxes[die];
>>>>>>  			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
>>>>>>  				uncore_box_exit(box);
>>>>>>  		}
>>>>>> @@ -1604,14 +1603,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
>>>>>>  }
>>>>>>  
>>>>>>  static int uncore_box_ref(struct intel_uncore_type **types,
>>>>>> -			  int id, unsigned int cpu)
>>>>>> +			  int die, unsigned int cpu)
>>>>>>  {
>>>>>>  	struct intel_uncore_type *type;
>>>>>>  	struct intel_uncore_pmu *pmu;
>>>>>>  	struct intel_uncore_box *box;
>>>>>>  	int i, ret;
>>>>>>  
>>>>>> -	ret = allocate_boxes(types, id, cpu);
>>>>>> +	ret = allocate_boxes(types, die, cpu);
>>>>>>  	if (ret)
>>>>>>  		return ret;
>>>>>>  
>>>>>> @@ -1619,7 +1618,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>>>>>  		type = *types;
>>>>>>  		pmu = type->pmus;
>>>>>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>>>>>> -			box = pmu->boxes[id];
>>>>>> +			box = pmu->boxes[die];
>>>>>>  			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
>>>>>>  				uncore_box_init(box);
>>>>>>  		}
>>>>>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>>>>>> index c2e5ccb1d72c..bad5d8dec8e0 100644
>>>>>> --- a/arch/x86/events/intel/uncore.h
>>>>>> +++ b/arch/x86/events/intel/uncore.h
>>>>>> @@ -185,7 +185,7 @@ struct intel_uncore_box {
>>>>>>  #define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
>>>>>>  #define CFL_UNC_CBO_7_PER_CTR0			0xf76
>>>>>>  
>>>>>> -#define UNCORE_BOX_FLAG_INITIATED		0
>>>>>> +#define UNCORE_BOX_FLAG_INITIALIZED		0
>>>>>>  /* event config registers are 8-byte apart */
>>>>>>  #define UNCORE_BOX_FLAG_CTL_OFFS8		1
>>>>>>  /* CFL 8th CBOX has different MSR space */
>>>>>> @@ -559,7 +559,7 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
>>>>>>  
>>>>>>  static inline void uncore_box_init(struct intel_uncore_box *box)
>>>>>>  {
>>>>>> -	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
>>>>>> +	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>>>>>>  		if (box->pmu->type->ops->init_box)
>>>>>>  			box->pmu->type->ops->init_box(box);
>>>>>>  	}
>>>>>> @@ -567,7 +567,7 @@ static inline void uncore_box_init(struct intel_uncore_box *box)
>>>>>>  
>>>>>>  static inline void uncore_box_exit(struct intel_uncore_box *box)
>>>>>>  {
>>>>>> -	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
>>>>>> +	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>>>>>>  		if (box->pmu->type->ops->exit_box)
>>>>>>  			box->pmu->type->ops->exit_box(box);
>>>>>>  	}

