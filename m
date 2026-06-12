Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC37156C6A;
	Fri, 12 Jun 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781225531; cv=none; b=hpSonwOOj2r3QNl14W4Atdz13xwFrImcQYPRDO9v/BJK40JjdZCBjSdSCPIsOEP5h9tbcnfCAHXfMx3DFOE3/V26gmhqNH+lFkW+5z7XQpvUR+8iXGZ3k83zEtaIZuTWdmkE+dW9zXaiLx/OAK4MH3NOfxjLm9K+WrRMJsVQGyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781225531; c=relaxed/simple;
	bh=Sj2uk2N3krt4TUcTVl9T/97IRtgQzmmdaZJm4/sxdDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pN18p1LYak2ZLzSzGINcU/OQNQEeIPdP1EXxhXXBmmWnCKc8Zln9vvOvdJIWZYvlwLz9kNHu+s7V9HMP90eJ4/AQ+CVyv4gmS6rU96hAJ8jTXEaKA+xfm5Ohf8kaPxECzP7BGjKeKATUOPz1VCERjAPBOnAf/1fSCjKiv9DK0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DB1lYics; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DB1lYics"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781225530; x=1812761530;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sj2uk2N3krt4TUcTVl9T/97IRtgQzmmdaZJm4/sxdDU=;
  b=DB1lYicsEVB8KK2FH3SsEUrJTqHkdjqt55xyb/6rhGUp5kR/icEgi22E
   UlVVb8UlzVk6sW7/lQz+8zvEug9SoW1a5fgcLlh6PkC6FkHf8rpPSWIFi
   3lCd7HTqLewAUQIKnoUevwXPR+9j3Sz+x4c9+72PqEo9yyIFQrQ5kmdGo
   c9AFqN50sr+Zqr6sd9t65+9YSmm72QaFn7GMn5Lu4bsaQ6VE9u/PmySho
   DMcqV3te6IS5QnehlFZRoDVy9tsO+C0NAz+uR6+KGG4Vc2rHGFKR7t7KW
   ex0SMlqSQTK7QNcbE28KE7Cxt5Am5NXO7w+GQ6Utu8tKddPDo2dRCgdPD
   Q==;
X-CSE-ConnectionGUID: D4i1F+NnSUa9M2op4SCgug==
X-CSE-MsgGUID: gYFdWQt4RFqrTjcOS5o5Xw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="93445874"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="93445874"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:52:09 -0700
X-CSE-ConnectionGUID: 62LSDhl8QeKE2wGmCLBzxA==
X-CSE-MsgGUID: 7pc0qlckTZmoE3skoIxfkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="242302501"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 17:52:06 -0700
Message-ID: <0d5867c1-3d14-4c9a-805a-453b66a24fa9@linux.intel.com>
Date: Fri, 12 Jun 2026 08:52:04 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/8] perf/x86/intel/uncore: Fix refcnt and other
 cleanups
To: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20260611160033.66760-1-zide.chen@intel.com>
 <20260611160033.66760-3-zide.chen@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260611160033.66760-3-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

LGTM. Thanks.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

On 6/12/2026 12:00 AM, Zide Chen wrote:
> Fix typo UNCORE_BOX_FLAG_INITIATED to UNCORE_BOX_FLAG_INITIALIZED.
>
> Rename the 'id' parameter in uncore_box_{ref,unref}() to 'die' to
> reflect its actual meaning and be consistent with other functions.
>
> box->refcnt is incremented in the PCI PMU register path but has never
> been checked or decremented. Although for PCI PMUs box->refcnt
> effectively tracks only a single user, add atomic_dec_return() in the
> PCI PMU unregister path to make the reference counting complete and
> consistent.
>
> Signed-off-by: Zide Chen <zide.chen@intel.com>
> ---
> v3:
> - Instead of removing atomic_inc(&box->refcnt) in PMU register, add
>   the corresponding atomic_dec_return(&box->refcnt) in PMU unregister.
>   (Dapeng)
> v2:
> - Don't rename pmu->activeboxes and keep its semantics because in
>   uncore_pci_remove() path, uncore_pci_pmu_unregister() won't be
>   called for non-active boxes.
> - Since pmu->activeboxes keeps its name, don't need to rename
>   box->refcnt to box->cpu_refcnt.
> ---
>  arch/x86/events/intel/uncore.c | 16 +++++++++-------
>  arch/x86/events/intel/uncore.h |  6 +++---
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index b69b6a21d46b..21c8ed1628cb 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1255,8 +1255,10 @@ static void uncore_pci_pmu_unregister(struct intel_uncore_pmu *pmu, int die)
>  	pmu->boxes[die] = NULL;
>  	if (atomic_dec_return(&pmu->activeboxes) == 0)
>  		uncore_pmu_unregister(pmu);
> -	uncore_box_exit(box);
> -	kfree(box);
> +	if (atomic_dec_return(&box->refcnt) == 0) {
> +		uncore_box_exit(box);
> +		kfree(box);
> +	}
>  }
>  
>  static void uncore_pci_remove(struct pci_dev *pdev)
> @@ -1518,7 +1520,7 @@ static void uncore_change_context(struct intel_uncore_type **uncores,
>  		uncore_change_type_ctx(*uncores, old_cpu, new_cpu);
>  }
>  
> -static void uncore_box_unref(struct intel_uncore_type **types, int id)
> +static void uncore_box_unref(struct intel_uncore_type **types, int die)
>  {
>  	struct intel_uncore_type *type;
>  	struct intel_uncore_pmu *pmu;
> @@ -1529,7 +1531,7 @@ static void uncore_box_unref(struct intel_uncore_type **types, int id)
>  		type = *types;
>  		pmu = type->pmus;
>  		for (i = 0; i < type->num_boxes; i++, pmu++) {
> -			box = pmu->boxes[id];
> +			box = pmu->boxes[die];
>  			if (box && box->cpu >= 0 && atomic_dec_return(&box->refcnt) == 0)
>  				uncore_box_exit(box);
>  		}
> @@ -1604,14 +1606,14 @@ static int allocate_boxes(struct intel_uncore_type **types,
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
> @@ -1619,7 +1621,7 @@ static int uncore_box_ref(struct intel_uncore_type **types,
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
