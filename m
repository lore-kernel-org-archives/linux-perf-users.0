Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B083E9C03;
	Tue,  2 Jun 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780409789; cv=none; b=S+BTZlVcDCMqk0pK3KOZ9YrilHUIYtEmvlbk2ILpoBxicSwvcK5ogTTHC1b9QVVGQtRLEZKoPkNmbJGhOdtr4aGNbX+lQT89rtzSlgdq8u9hPzX6/BcokoJgaqybDWlxk1PYqhniqiVA/FF0qHE/ebdHunE1iJzidscb/mFQEok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780409789; c=relaxed/simple;
	bh=hqzmHgQ70FShBqTVEbaq6TPvuzDVwCeLK8WAhF6nIbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdvEWoQCoqDxwGQQY2k6LxiH0gUSc/uD3wlSoWWOaLvOD7dy35HvxVxIaO/s1JqZMPjxNslpoLXG6YaGtLFHMUVb3d7emDlHCy6+MpgtFinZ71yMPmaVhSp+LBczycimLKL3DrV6MYvkNipqaWm9lvh+vqljJMbQZbyxd0V6Pf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aunigJeP; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aunigJeP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780409787; x=1811945787;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hqzmHgQ70FShBqTVEbaq6TPvuzDVwCeLK8WAhF6nIbU=;
  b=aunigJeP88fpupXCCSGEX+y5uRT2j6vmSTe+sVGiepif6tB4N48YwIF4
   RI7lTCj9a45G7Q/Ur3GiLDVvQaONoVilQRVNAIp23oDU6LgfYEqgn1lMb
   X4bCqrmDjSSPlU4VdKln+p/5/4bD98VtFDSRaiSzXxnp4Ws/WfOmWewuE
   yDR3YuVDYBzj5MLpgPagkdtNbt3Zav9sPYCmRBlrntsu3ENHGD/bXYB5l
   QslL4vE3fEvKxpWV95vN1tc4poUD6gD15UJqzY0oDjnJ2UNT5lPagZzjk
   MChd3++M6UApWqX/Ii2rxoKBRJT+JfOaK0UN/ZwJyZffz3JEbMYX1g4lj
   A==;
X-CSE-ConnectionGUID: dE5rhkpxTfKiffnd93mIOA==
X-CSE-MsgGUID: ryh+UX4aS/ivRxB5FtYJjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="68737959"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="68737959"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:16:27 -0700
X-CSE-ConnectionGUID: 8K61nxnOTRG+AeOLtQtIzQ==
X-CSE-MsgGUID: 4JrvLkyiRFCjXIZEu2953w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="243757437"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 07:16:26 -0700
Message-ID: <1640889a-53ed-46ad-b78b-35982ff37b33@intel.com>
Date: Tue, 2 Jun 2026 09:16:25 -0500
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
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <1643127e-9a3f-421a-a690-9b363ccfa8e6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/2/2026 4:52 AM, Mi, Dapeng wrote:
> 
> On 6/2/2026 1:01 AM, Zide Chen wrote:
>> Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.
>>
>> Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
>> reflect its actual meaning and be consistent with other functions.
>>
>> Remove the incorrect atomic_inc(&box->refcnt) from
>> uncore_pci_pmu_register(): PCI boxes are not tracked by refcnt,
>> and this call incorrectly increments it on a per-die basis.
>>
>> Signed-off-by: Zide Chen <zide.chen@intel.com>
>> ---
>> v2:
>> - Don't rename pmu->activeboxes and keep its semantics because in
>>   uncore_pci_remove() path, uncore_pci_pmu_unregister() won't be
>>   called for non-active boxes.
>> - Since pmu->activeboxes keeps it's name, don't need to rename
>>   box->refcnt to box->cpu_refcnt.
>> ---
>>  arch/x86/events/intel/uncore.c | 11 +++++------
>>  arch/x86/events/intel/uncore.h |  6 +++---
>>  2 files changed, 8 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
>> index b69b6a21d46b..d759888476c3 100644
>> --- a/arch/x86/events/intel/uncore.c
>> +++ b/arch/x86/events/intel/uncore.c
>> @@ -1170,7 +1170,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
>>  	if (!box)
>>  		return -ENOMEM;
>>  
>> -	atomic_inc(&box->refcnt);
> 
> I'm not sure if we should remove this. The
> uncore_box_ref()/uncore_box_unref() are only called for MSR or MMIO type
> uncore PMUs. For the uncore PMUs of PCI type, the box->refcnt is only
> increased here. All the 3 kinds of uncore PMUs should keep consistent
> behavior on the refcnt. 

box->refcnt tracks how many CPUs are active within this die. Here it is
incorrectly incremented on a per-die basis. Additionally, during the PCI
uncore enumeration or teardown process, there is no per-CPU context, so
box->refcnt is useless in PCI uncore.

PCI uncore only needs pmu->activeboxes.

> Could we keep this and just decrease the refcnt in
> uncore_pci_pmu_unregister()? Thanks.
> 
> 
>>  	box->dieid = die;
>>  	box->pci_dev = pdev;
>>  	box->pmu = pmu;
>> @@ -1518,7 +1517,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
>>  		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
>>  }
>>  
>> -static void uncore_box_unref(struct intel_uncore_type **types, int id)
>> +static void uncore_box_unref(struct intel_uncore_type **types, int die)
>>  {
>>  	struct intel_uncore_type *type;
>>  	struct intel_uncore_pmu *pmu;
>> @@ -1529,7 +1528,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
>>  		type = *types;
>>  		pmu = type->pmus;
>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>> -			box = pmu->boxes[id];
>> +			box = pmu->boxes[die];
>>  			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
>>  				uncore_box_exit(box);
>>  		}
>> @@ -1604,14 +1603,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
>>  }
>>  
>>  static int uncore_box_ref(struct intel_uncore_type **types,
>> -			  int id, unsigned int cpu)
>> +			  int die, unsigned int cpu)
>>  {
>>  	struct intel_uncore_type *type;
>>  	struct intel_uncore_pmu *pmu;
>>  	struct intel_uncore_box *box;
>>  	int i, ret;
>>  
>> -	ret = allocate_boxes(types, id, cpu);
>> +	ret = allocate_boxes(types, die, cpu);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -1619,7 +1618,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>>  		type = *types;
>>  		pmu = type->pmus;
>>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
>> -			box = pmu->boxes[id];
>> +			box = pmu->boxes[die];
>>  			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
>>  				uncore_box_init(box);
>>  		}
>> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
>> index c2e5ccb1d72c..bad5d8dec8e0 100644
>> --- a/arch/x86/events/intel/uncore.h
>> +++ b/arch/x86/events/intel/uncore.h
>> @@ -185,7 +185,7 @@ struct intel_uncore_box {
>>  #define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
>>  #define CFL_UNC_CBO_7_PER_CTR0			0xf76
>>  
>> -#define UNCORE_BOX_FLAG_INITIATED		0
>> +#define UNCORE_BOX_FLAG_INITIALIZED		0
>>  /* event config registers are 8-byte apart */
>>  #define UNCORE_BOX_FLAG_CTL_OFFS8		1
>>  /* CFL 8th CBOX has different MSR space */
>> @@ -559,7 +559,7 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
>>  
>>  static inline void uncore_box_init(struct intel_uncore_box *box)
>>  {
>> -	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
>> +	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>>  		if (box->pmu->type->ops->init_box)
>>  			box->pmu->type->ops->init_box(box);
>>  	}
>> @@ -567,7 +567,7 @@ static inline void uncore_box_init(struct intel_uncore_box *box)
>>  
>>  static inline void uncore_box_exit(struct intel_uncore_box *box)
>>  {
>> -	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
>> +	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>>  		if (box->pmu->type->ops->exit_box)
>>  			box->pmu->type->ops->exit_box(box);
>>  	}

