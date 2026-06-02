Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6E63438BA;
	Tue,  2 Jun 2026 09:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393988; cv=none; b=BBtsZXzLbOdrDPJKpIod9vC533/QJtkuW5aaKanzzAqf5ZaKr6l2R3quqWDlRVUIeztto7rjGEVYAt9bpQzGiQR5W2hlvWYDe8ZAu9Z1UTRTmFytYTtj/n7JucvEq9tvv3jcUfIuQbhyJCEsELH3/sZe14Z4GzR/1+bqN7xQ5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393988; c=relaxed/simple;
	bh=2AcQVJn0UZdCS6yFRj9bSLwWcQgN+KPdd6H5suWoBQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GdpKiLhoi0exb13ekOqvwQVK4Yw+bSt2RfbAF+foA/ZWve4NiMBgIDfLIjtbMiUDOiIp8bwEXPY+C01x+RqJ8DLOz6YymPriSycBOU29PqpJJrUaYdSXlo56J4gN7MT4QHNnU/jVmOjduUTyXf33er45R0BNEMGT+fKtRxk4R4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O3xFqs4G; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O3xFqs4G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780393986; x=1811929986;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2AcQVJn0UZdCS6yFRj9bSLwWcQgN+KPdd6H5suWoBQE=;
  b=O3xFqs4GBdBKhtLBbvV9gikAIN+dBQDjpuc2EwQvifEIQw75wZqFBcnB
   clh1lXiz0Wik7f4Pcc2lg4QwqrH7YTB4olh96wliaDmVewKDyi1imNpr4
   Qk8o3vLWzziuQWWa7yAILBkFT3haaYNQiyNk5B9D0y/fQ7gJLcgrLWEH5
   xcHx6lNJNhjSxBZSo+ZezLSMAPCNyYtXLVcOvPN5s/ZOdphqYSiic937g
   ek175stbtG1eHMO7fEYwdUG8FeLnUgd7HogdiqlLnmeHmuiAcBwYyXR6N
   Y7mGlBwxTY6J41ypdQx7s15edQ+zkZdVibC/2Zr6laQqfk5GXJ6uVTPEt
   g==;
X-CSE-ConnectionGUID: YggHp0nqS6m3oTRhCxfN1Q==
X-CSE-MsgGUID: +FNEdAXQQeePKJSf5YRkWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="80319434"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="80319434"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:53:06 -0700
X-CSE-ConnectionGUID: KvbAAoP5RjWMLs8qaDq0Qg==
X-CSE-MsgGUID: 9YBVGPpvTkKBUxWyezwHtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="248787063"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 02:53:03 -0700
Message-ID: <1643127e-9a3f-421a-a690-9b363ccfa8e6@linux.intel.com>
Date: Tue, 2 Jun 2026 17:52:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/8] perf/x86/intel/uncore: Fix refcnt and other
 cleanups
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260601170114.173359-1-zide.chen@intel.com>
 <20260601170114.173359-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260601170114.173359-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 6/2/2026 1:01 AM, Zide Chen wrote:
> Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.
>
> Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
> reflect its actual meaning and be consistent with other functions.
>
> Remove the incorrect atomic_inc(&box->refcnt) from
> uncore_pci_pmu_register(): PCI boxes are not tracked by refcnt,
> and this call incorrectly increments it on a per-die basis.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v2:
> - Don't rename pmu->activeboxes and keep its semantics because in
>   uncore_pci_remove() path, uncore_pci_pmu_unregister() won't be
>   called for non-active boxes.
> - Since pmu->activeboxes keeps it's name, don't need to rename
>   box->refcnt to box->cpu_refcnt.
> ---
>  arch/x86/events/intel/uncore.c | 11 +++++------
>  arch/x86/events/intel/uncore.h |  6 +++---
>  2 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index b69b6a21d46b..d759888476c3 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1170,7 +1170,6 @@ static int uncore_pci_pmu_register(struct pci_dev *pdev,
>  	if (!box)
>  		return -ENOMEM;
>  
> -	atomic_inc(&box->refcnt);

I'm not sure if we should remove this. The
uncore_box_ref()/uncore_box_unref() are only called for MSR or MMIO type
uncore PMUs. For the uncore PMUs of PCI type, the box->refcnt is only
increased here. All the 3 kinds of uncore PMUs should keep consistent
behavior on the refcnt. 

Could we keep this and just decrease the refcnt in
uncore_pci_pmu_unregister()? Thanks.


>  	box->dieid = die;
>  	box->pci_dev = pdev;
>  	box->pmu = pmu;
> @@ -1518,7 +1517,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
>  		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
>  }
>  
> -static void uncore_box_unref(struct intel_uncore_type **types, int id)
> +static void uncore_box_unref(struct intel_uncore_type **types, int die)
>  {
>  	struct intel_uncore_type *type;
>  	struct intel_uncore_pmu *pmu;
> @@ -1529,7 +1528,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
>  		type = *types;
>  		pmu = type->pmus;
>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
> -			box = pmu->boxes[id];
> +			box = pmu->boxes[die];
>  			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
>  				uncore_box_exit(box);
>  		}
> @@ -1604,14 +1603,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
>  }
>  
>  static int uncore_box_ref(struct intel_uncore_type **types,
> -			  int id, unsigned int cpu)
> +			  int die, unsigned int cpu)
>  {
>  	struct intel_uncore_type *type;
>  	struct intel_uncore_pmu *pmu;
>  	struct intel_uncore_box *box;
>  	int i, ret;
>  
> -	ret = allocate_boxes(types, id, cpu);
> +	ret = allocate_boxes(types, die, cpu);
>  	if (ret)
>  		return ret;
>  
> @@ -1619,7 +1618,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
>  		type = *types;
>  		pmu = type->pmus;
>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
> -			box = pmu->boxes[id];
> +			box = pmu->boxes[die];
>  			if (box && box->cpu >= 0 && atomic_inc_return(&box->refcnt) == 1)
>  				uncore_box_init(box);
>  		}
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index c2e5ccb1d72c..bad5d8dec8e0 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -185,7 +185,7 @@ struct intel_uncore_box {
>  #define CFL_UNC_CBO_7_PERFEVTSEL0		0xf70
>  #define CFL_UNC_CBO_7_PER_CTR0			0xf76
>  
> -#define UNCORE_BOX_FLAG_INITIATED		0
> +#define UNCORE_BOX_FLAG_INITIALIZED		0
>  /* event config registers are 8-byte apart */
>  #define UNCORE_BOX_FLAG_CTL_OFFS8		1
>  /* CFL 8th CBOX has different MSR space */
> @@ -559,7 +559,7 @@ static inline u64 uncore_read_counter(struct intel_uncore_box *box,
>  
>  static inline void uncore_box_init(struct intel_uncore_box *box)
>  {
> -	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
> +	if (!test_and_set_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>  		if (box->pmu->type->ops->init_box)
>  			box->pmu->type->ops->init_box(box);
>  	}
> @@ -567,7 +567,7 @@ static inline void uncore_box_init(struct intel_uncore_box *box)
>  
>  static inline void uncore_box_exit(struct intel_uncore_box *box)
>  {
> -	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIATED, &box->flags)) {
> +	if (test_and_clear_bit(UNCORE_BOX_FLAG_INITIALIZED, &box->flags)) {
>  		if (box->pmu->type->ops->exit_box)
>  			box->pmu->type->ops->exit_box(box);
>  	}
