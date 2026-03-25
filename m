Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CA31D555;
	Wed, 25 Mar 2026 09:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429292; cv=none; b=TXrujOwqsGl0IA8g/JUFLVH9Pt5nPlT1B/3YiM1uRmk48INLLsoD4fGICTL148LqpH/BaLuBFVYmAnbcWmdk8TePURZ4AN7RlrtY2WzAPme+pQjfZDwaD8VV7mc3WwitW+R/9ShCzOPt8Jp31PXjjlDo0aoIivkYFU7KqC6H4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429292; c=relaxed/simple;
	bh=mq99TBCSyzIEMCf75Bm7PMliTVQpAnGyzQnrkagr3Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjKtUMAUpYL/4Wq0XxbI42uJeYeDZmzwkMvK2JtG7+wCs+lfoGdFoGqcFha/PdukDC/RzXjYiewWKdil6Q6QwIjiWRo1c9ntAj5Y9/xBZa7emlYelO7LsIzf/hB5USBnbCuRZuCk+9o5YNmVuUN0JpG/NabVl7TbPRzi6gPt72Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JD1XcIO1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JD1XcIO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774429290; x=1805965290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mq99TBCSyzIEMCf75Bm7PMliTVQpAnGyzQnrkagr3Wo=;
  b=JD1XcIO1VOhat8aLk2UbGrz/JeyAL3A6rgRjHkIsrOo40B9gPF5tPssL
   sZyvUzBP+eVRdwZoGbNWq6Fjd3cn/kiUgL22YXxV5iVOBdwLgaln0f/wi
   +pBqsTWkdzYBvY43o6/OfB3aHfnnN/fh+2qzBPoPGTe+9T7sima22ukl7
   oI5Vmo/F4BtJuZ+z/WO58W12fyGKs1fH01x4xPfOFrFzvQ98PvPUOrOqX
   eUnXNMG8XHbXzxaRw9svAWDqzqjtHAKPgtKdg9TtWqDpsf3rGb/8XSoUF
   wMWbI+zEtEysYrpCll5w+/q7kX3JTrtsNMlI9Dxv57odWY9OOqqLRaLjT
   A==;
X-CSE-ConnectionGUID: EfJhCXBvTe6SixEBoawieA==
X-CSE-MsgGUID: 8JdX17YxS9OuNB9LrkKy8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="79367561"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="79367561"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:01:29 -0700
X-CSE-ConnectionGUID: dkw8Sna2Tw+2ZM5SrfOwWw==
X-CSE-MsgGUID: wmMbE6RJSGKv6/d0CTOLWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="262546519"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 02:01:24 -0700
Message-ID: <69274c6d-0db5-47b7-a2c9-0b1e069db470@linux.intel.com>
Date: Wed, 25 Mar 2026 17:01:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 14/24] perf/x86: Enable XMM sampling using
 sample_simd_vec_reg_* fields
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
 <20260324004118.3772171-15-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324004118.3772171-15-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/24/2026 8:41 AM, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> This patch adds support for sampling XMM registers using the
> sample_simd_vec_reg_* fields.
>
> When sample_simd_regs_enabled is set, the original XMM space in the
> sample_regs_* field is treated as reserved. An INVAL error will be
> reported to user space if any bit is set in the original XMM space while
> sample_simd_regs_enabled is set.
>
> The perf_reg_value function requires ABI information to understand the
> layout of sample_regs. To accommodate this, a new abi field is introduced
> in the struct x86_perf_regs to represent ABI information.
>
> Additionally, the X86-specific perf_simd_reg_value function is implemented
> to retrieve the XMM register values.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c                | 89 +++++++++++++++++++++++++--
>  arch/x86/events/intel/ds.c            |  2 +-
>  arch/x86/events/perf_event.h          | 12 ++++
>  arch/x86/include/asm/perf_event.h     |  1 +
>  arch/x86/include/uapi/asm/perf_regs.h | 13 ++++
>  arch/x86/kernel/perf_regs.c           | 51 ++++++++++++++-
>  6 files changed, 161 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index a5643c875190..3c9b79b46a66 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -704,6 +704,22 @@ int x86_pmu_hw_config(struct perf_event *event)
>  		if (event_has_extended_regs(event)) {
>  			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
>  				return -EINVAL;
> +			if (event->attr.sample_simd_regs_enabled)
> +				return -EINVAL;
> +		}
> +
> +		if (event_has_simd_regs(event)) {
> +			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
> +				return -EINVAL;
> +			/* Not require any vector registers but set width */
> +			if (event->attr.sample_simd_vec_reg_qwords &&
> +			    !event->attr.sample_simd_vec_reg_intr &&
> +			    !event->attr.sample_simd_vec_reg_user)
> +				return -EINVAL;
> +			/* The vector registers set is not supported */
> +			if (event_needs_xmm(event) &&
> +			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
> +				return -EINVAL;
>  		}
>  	}
>  
> @@ -1749,6 +1765,7 @@ static void x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
>  	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
>  	struct perf_regs regs_user;
>  
> +	x86_regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
>  	perf_get_regs_user(&regs_user, regs);
>  	data->regs_user.abi = regs_user.abi;
>  	if (regs_user.regs) {
> @@ -1758,12 +1775,26 @@ static void x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
>  		data->regs_user.regs = NULL;
>  }
>  
> +static inline void
> +x86_pmu_update_xregs_size(struct perf_event_attr *attr,
> +			  struct perf_sample_data *data,
> +			  struct pt_regs *regs,
> +			  u64 mask, u64 pred_mask)
> +{
> +	u16 pred_qwords = attr->sample_simd_pred_reg_qwords;
> +	u16 vec_qwords = attr->sample_simd_vec_reg_qwords;
> +
> +	data->dyn_size += (hweight64(mask) * vec_qwords +
> +			   hweight64(pred_mask) * pred_qwords) * sizeof(u64);
> +}
> +
>  static void x86_pmu_setup_gpregs_data(struct perf_event *event,
>  				      struct perf_sample_data *data,
>  				      struct pt_regs *regs)
>  {
>  	struct perf_event_attr *attr = &event->attr;
>  	u64 sample_type = attr->sample_type;
> +	struct x86_perf_regs *perf_regs;
>  
>  	if (sample_type & PERF_SAMPLE_REGS_USER) {
>  		if (user_mode(regs)) {
> @@ -1783,8 +1814,13 @@ static void x86_pmu_setup_gpregs_data(struct perf_event *event,
>  			data->regs_user.regs = NULL;
>  		}
>  		data->dyn_size += sizeof(u64);
> -		if (data->regs_user.regs)
> -			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
> +		if (data->regs_user.regs) {
> +			data->dyn_size +=
> +				hweight64(attr->sample_regs_user) * sizeof(u64);
> +			perf_regs = container_of(data->regs_user.regs,
> +						 struct x86_perf_regs, regs);
> +			perf_regs->abi = data->regs_user.abi;
> +		}
>  		data->sample_flags |= PERF_SAMPLE_REGS_USER;
>  	}
>  
> @@ -1792,8 +1828,13 @@ static void x86_pmu_setup_gpregs_data(struct perf_event *event,
>  		data->regs_intr.regs = regs;
>  		data->regs_intr.abi = perf_reg_abi(current);
>  		data->dyn_size += sizeof(u64);
> -		if (data->regs_intr.regs)
> -			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
> +		if (data->regs_intr.regs) {
> +			data->dyn_size +=
> +				hweight64(attr->sample_regs_intr) * sizeof(u64);
> +			perf_regs = container_of(data->regs_intr.regs,
> +						 struct x86_perf_regs, regs);
> +			perf_regs->abi = data->regs_intr.abi;
> +		}
>  		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
>  	}
>  }
> @@ -1871,7 +1912,7 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
>  	if (WARN_ON_ONCE(!xsave))
>  		return;
>  
> -	if (event_has_extended_regs(event))
> +	if (event_needs_xmm(event))
>  		mask |= XFEATURE_MASK_SSE;
>  
>  	mask &= x86_pmu.ext_regs_mask;
> @@ -1899,6 +1940,43 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
>  	}
>  }
>  
> +static void x86_pmu_setup_xregs_data(struct perf_event *event,
> +					     struct perf_sample_data *data)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	u64 sample_type = attr->sample_type;
> +	struct x86_perf_regs *perf_regs;
> +
> +	if (!attr->sample_simd_regs_enabled)
> +		return;
> +
> +	if (sample_type & PERF_SAMPLE_REGS_USER && data->regs_user.abi) {
> +		perf_regs = container_of(data->regs_user.regs,
> +					 struct x86_perf_regs, regs);
> +		perf_regs->abi |= PERF_SAMPLE_REGS_ABI_SIMD;
> +
> +		/* num and qwords of vector and pred registers */
> +		data->dyn_size += sizeof(u64);
> +		data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
> +		x86_pmu_update_xregs_size(attr, data, data->regs_user.regs,
> +					  attr->sample_simd_vec_reg_user,
> +					  attr->sample_simd_pred_reg_user);
> +	}
> +
> +	if (sample_type & PERF_SAMPLE_REGS_INTR && data->regs_intr.abi) {
> +		perf_regs = container_of(data->regs_intr.regs,
> +					 struct x86_perf_regs, regs);
> +		perf_regs->abi |= PERF_SAMPLE_REGS_ABI_SIMD;
> +
> +		/* num and qwords of vector and pred registers */
> +		data->dyn_size += sizeof(u64);
> +		data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
> +		x86_pmu_update_xregs_size(attr, data, data->regs_intr.regs,
> +					  attr->sample_simd_vec_reg_intr,
> +					  attr->sample_simd_pred_reg_intr);
> +	}
> +}
> +
>  void x86_pmu_setup_regs_data(struct perf_event *event,
>  			     struct perf_sample_data *data,
>  			     struct pt_regs *regs,
> @@ -1910,6 +1988,7 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
>  	 * which are unnecessary to sample again.
>  	 */
>  	x86_pmu_sample_xregs(event, data, ignore_mask);
> +	x86_pmu_setup_xregs_data(event, data);
>  }
>  
>  int x86_pmu_handle_irq(struct pt_regs *regs)
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 74a41dae8a62..ac9a1c2f0177 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1743,7 +1743,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
>  	if (gprs || (attr->precise_ip < 2) || tsx_weight)
>  		pebs_data_cfg |= PEBS_DATACFG_GP;
>  
> -	if (event_has_extended_regs(event))
> +	if (event_needs_xmm(event))
>  		pebs_data_cfg |= PEBS_DATACFG_XMMS;
>  
>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index a5e5bffb711e..26d162794a36 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -137,6 +137,18 @@ static inline bool is_acr_event_group(struct perf_event *event)
>  	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
>  }
>  
> +static inline bool event_needs_xmm(struct perf_event *event)
> +{
> +	if (event->attr.sample_simd_regs_enabled &&
> +	    event->attr.sample_simd_vec_reg_qwords >= PERF_X86_XMM_QWORDS)
> +		return true;
> +
> +	if (!event->attr.sample_simd_regs_enabled &&
> +	    event_has_extended_regs(event))
> +		return true;
> +	return false;
> +}
> +
>  struct amd_nb {
>  	int nb_id;  /* NorthBridge id */
>  	int refcnt; /* reference count */
> diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
> index e47a963a7cf0..e54d21c13494 100644
> --- a/arch/x86/include/asm/perf_event.h
> +++ b/arch/x86/include/asm/perf_event.h
> @@ -726,6 +726,7 @@ extern void perf_events_lapic_init(void);
>  struct pt_regs;
>  struct x86_perf_regs {
>  	struct pt_regs	regs;
> +	u64		abi;
>  	union {
>  		u64	*xmm_regs;
>  		u32	*xmm_space;	/* for xsaves */
> diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
> index 7c9d2bb3833b..c5c1b3930df1 100644
> --- a/arch/x86/include/uapi/asm/perf_regs.h
> +++ b/arch/x86/include/uapi/asm/perf_regs.h
> @@ -55,4 +55,17 @@ enum perf_event_x86_regs {
>  
>  #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
>  
> +enum {
> +	PERF_X86_SIMD_XMM_REGS      = 16,
> +	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
> +};
> +
> +#define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
> +
> +enum {
> +	/* 1 qword = 8 bytes */
> +	PERF_X86_XMM_QWORDS      = 2,
> +	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
> +};
> +
>  #endif /* _ASM_X86_PERF_REGS_H */
> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
> index 81204cb7f723..9947a6b5c260 100644
> --- a/arch/x86/kernel/perf_regs.c
> +++ b/arch/x86/kernel/perf_regs.c
> @@ -63,6 +63,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  
>  	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
>  		perf_regs = container_of(regs, struct x86_perf_regs, regs);
> +		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
> +		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
> +			return 0;
>  		if (!perf_regs->xmm_regs)
>  			return 0;
>  		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
> @@ -74,6 +77,51 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>  	return regs_get_register(regs, pt_regs_offset[idx]);
>  }
>  
> +u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
> +			u16 qwords_idx, bool pred)
> +{
> +	struct x86_perf_regs *perf_regs =
> +			container_of(regs, struct x86_perf_regs, regs);
> +
> +	if (pred)
> +		return 0;
> +
> +	if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_VEC_REGS_MAX ||
> +			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
> +		return 0;
> +
> +	if (qwords_idx < PERF_X86_XMM_QWORDS) {
> +		if (!perf_regs->xmm_regs)
> +			return 0;
> +		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS +
> +					   qwords_idx];
> +	}
> +
> +	return 0;
> +}
> +
> +int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
> +			   u16 pred_qwords, u32 pred_mask)
> +{
> +	/* pred_qwords implies sample_simd_{pred,vec}_reg_* are supported */
> +	if (!pred_qwords)
> +		return 0;

Sashiko comments

"

Does this early return completely bypass validation for vector registers
when pred_qwords is 0?


Since x86 does not require predicate registers for standard XMM sampling, it
appears an unprivileged user can set sample_simd_pred_reg_qwords to 0 while
supplying arbitrarily large values for sample_simd_vec_reg_qwords and
sample_simd_vec_reg_user.


Could this bypass bounds checks and lead to a massive dyn_size calculation
during a perf NMI, causing ring buffer corruption or an NMI watchdog hard
lockup?

"

It partly makes sense. Would enhance the perf_simd_reg_validate() to cover
more cases.


> +
> +	if (!vec_qwords) {
> +		if (vec_mask)
> +			return -EINVAL;
> +	} else {
> +		if (vec_qwords != PERF_X86_XMM_QWORDS)
> +			return -EINVAL;
> +		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
> +			return -EINVAL;
> +	}
> +	if (pred_mask)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  #define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
>  				 ~((1ULL << PERF_REG_X86_MAX) - 1))
>  
> @@ -108,7 +156,8 @@ u64 perf_reg_abi(struct task_struct *task)
>  
>  int perf_reg_validate(u64 mask)
>  {
> -	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
> +	/* The mask could be 0 if only the SIMD registers are interested */
> +	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
>  		return -EINVAL;
>  
>  	return 0;
