Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0711739656D;
	Wed, 25 Mar 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774425522; cv=none; b=OAYwiOisZLl9qD5/ndlTa9lR9vi0HFn3vLQopxtckkJhflVP5ajmBY4+tCXSOwnqzjmZEhdEDFrIZ9p3gaRlSdduK6e9RFYJ7wyT9LPeh4nNzUkbXn3NT7psEsb/5HG1ZsNCDwSC63aLocjAEzoMR9KKhm8StC14TkMcLQWEs5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774425522; c=relaxed/simple;
	bh=4jlEss/cpXcSwu4h8jGg/tWhGBwgeOHFTywsRMH0PuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAuRhW5WI/1Slepolqv4aK9kiiMg3ZQ9meJQAnZXpi62fjLNKjUyvd7SRlMmKx8c+kW8W9Qd/UI2+PMLw0h7iYx6+vruOOhXKHW/bW1lzb6Vlu72hIIZiuqOs4SeMb5fxxHdM3Pqz0bTwdNX1DXevC+Er4LnbaTShdib/fKPXKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E/6hrLkU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E/6hrLkU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774425518; x=1805961518;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4jlEss/cpXcSwu4h8jGg/tWhGBwgeOHFTywsRMH0PuI=;
  b=E/6hrLkUAF8QokGlmkIsomHTL16tmm355gs3j/eTx6OaIQwKljIYHNeN
   JRtexRijpcMb/jHPD8hUSUGgMxJ7c9zcQQYkjrxN+2s4z1K7ohaUModu2
   x6U2snPqiHhfSFsGPzCZvo3zexfil4AJfMoXnrYi88FcTBtM3vCmaDKIk
   NtHLdyH8QufNcZRblqwrtBV3KqckXBIFqRy9iO1Rd/aLmtTB64wzsZvmy
   hBwiUpE8qdeAZgoKbPRZpjt+lAbcytuAowoxYgEzv0lJGAIs93uIq3atM
   tBCuw17D7qNvQ7uwG/iTG9TanzCfFES+cLmbrh7dZEAnW1OPJDSlSZyuJ
   Q==;
X-CSE-ConnectionGUID: JsBxIvGsR269dTm/6joMKg==
X-CSE-MsgGUID: b6D/kGdSSgSX9BR9Qa6e8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86150954"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="86150954"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:58:36 -0700
X-CSE-ConnectionGUID: /nJJx5DNQZGFg33IjHe7/w==
X-CSE-MsgGUID: DjJpxalkT1qPz9VKWam43A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="220191007"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 00:58:32 -0700
Message-ID: <fa954a5a-2efd-4f21-abb9-c69150f66c56@linux.intel.com>
Date: Wed, 25 Mar 2026 15:58:29 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 12/24] perf/x86: Enable XMM register sampling for
 REGS_USER case
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
 <20260324004118.3772171-13-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324004118.3772171-13-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/24/2026 8:41 AM, Dapeng Mi wrote:
> This patch adds support for XMM register sampling in the REGS_USER case.
>
> To handle simultaneous sampling of XMM registers for both REGS_INTR and
> REGS_USER cases, a per-CPU `x86_user_regs` is introduced to store
> REGS_USER-specific XMM registers. This prevents REGS_USER-specific XMM
> register data from being overwritten by REGS_INTR-specific data if they
> share the same `x86_perf_regs` structure.
>
> To sample user-space XMM registers, the `x86_pmu_update_user_ext_regs()`
> helper function is added. It checks if the `TIF_NEED_FPU_LOAD` flag is
> set. If so, the user-space XMM register data can be directly retrieved
> from the cached task FPU state, as the corresponding hardware registers
> have been cleared or switched to kernel-space data. Otherwise, the data
> must be read from the hardware registers using the `xsaves` instruction.
>
> For PEBS events, `x86_pmu_update_user_ext_regs()` checks if the
> PEBS-sampled XMM register data belongs to user-space. If so, no further
> action is needed. Otherwise, the user-space XMM register data needs to be
> re-sampled using the same method as for non-PEBS events.
>
> Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c | 95 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 82 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 22965a8a22b3..a5643c875190 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -696,7 +696,7 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> -	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
> +	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
>  		/*
>  		 * Besides the general purpose registers, XMM registers may
>  		 * be collected as well.
> @@ -707,15 +707,6 @@ int x86_pmu_hw_config(struct perf_event *event)
>  		}
>  	}
>  
> -	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
> -		/*
> -		 * Currently XMM registers sampling for REGS_USER is not
> -		 * supported yet.
> -		 */
> -		if (event_has_extended_regs(event))
> -			return -EINVAL;
> -	}
> -
>  	return x86_setup_perfctr(event);
>  }

Sashiko comments

"

With this check removed, can older platforms hit an uninitialized stack
pointer dereference?


In __intel_pmu_pebs_events(), a struct x86_perf_regs is allocated on the
stack without zero-initialization. setup_pebs_fixed_sample_data() populates
perf_regs.regs but leaves perf_regs.xmm_regs uninitialized and doesn't set
the PERF_SAMPLE_REGS_USER flag.
If perf_prepare_sample() sees the missing flag, it calls
perf_sample_regs_user(), and perf_output_sample_regs() eventually
dereferences the uninitialized stack memory at perf_regs->xmm_regs to
output XMM data.

"

The comment makes sense. Would clear the xmm_regs and other pointers in
next version.


>  
> @@ -1745,6 +1736,28 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>  	static_call_cond(x86_pmu_del)(event);
>  }
>  
> +/*
> + * When both PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER are set,
> + * an additional x86_perf_regs is required to save user-space registers.
> + * Without this, user-space register data may be overwritten by kernel-space
> + * registers.
> + */
> +static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
> +static void x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
> +				       struct pt_regs *regs)
> +{
> +	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
> +	struct perf_regs regs_user;
> +
> +	perf_get_regs_user(&regs_user, regs);
> +	data->regs_user.abi = regs_user.abi;
> +	if (regs_user.regs) {
> +		x86_regs_user->regs = *regs_user.regs;
> +		data->regs_user.regs = &x86_regs_user->regs;
> +	} else
> +		data->regs_user.regs = NULL;
> +}

Sashiko comments

"

Does this leave the xmm_regs pointer uninitialized across perf events?
x86_user_regs is a per-CPU variable. When x86_pmu_perf_get_regs_user()
copies the general-purpose registers, it doesn't clear or initialize the
xmm_regs pointer in the union.
If user_mask evaluates to 0 later, x86_pmu_update_xregs() is bypassed,
leaving a stale xmm_regs pointer from a previous perf event on the same CPU.
Could this lead to a use-after-free or information leak when
perf_output_sample_regs() dereferences it?

"

It makes sense. would clear xmm_regs and other pointers in next version.


> +
>  static void x86_pmu_setup_gpregs_data(struct perf_event *event,
>  				      struct perf_sample_data *data,
>  				      struct pt_regs *regs)
> @@ -1757,7 +1770,14 @@ static void x86_pmu_setup_gpregs_data(struct perf_event *event,
>  			data->regs_user.abi = perf_reg_abi(current);
>  			data->regs_user.regs = regs;
>  		} else if (!(current->flags & PF_KTHREAD)) {
> -			perf_get_regs_user(&data->regs_user, regs);
> +			/*
> +			 * It cannot guarantee that the kernel will never
> +			 * touch the registers outside of the pt_regs,
> +			 * especially when more and more registers
> +			 * (e.g., SIMD, eGPR) are added. The live data
> +			 * cannot be used.
> +			 */
> +			x86_pmu_perf_get_regs_user(data, regs);
>  		} else {
>  			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
>  			data->regs_user.regs = NULL;
> @@ -1800,6 +1820,43 @@ static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
>  		perf_regs->xmm_space = xsave->i387.xmm_space;
>  }
>  
> +/*
> + * This function retrieves cached user-space fpu registers (XMM/YMM/ZMM).
> + * If TIF_NEED_FPU_LOAD is set, it indicates that the user-space FPU state
> + * is cached. Otherwise, the data should be read directly from the hardware
> + * registers.
> + */
> +static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *data,
> +					    u64 mask, u64 ignore_mask)
> +{
> +	struct x86_perf_regs *perf_regs;
> +	struct xregs_state *xsave;
> +	struct fpu *fpu;
> +	struct fpstate *fps;
> +
> +	if (data->regs_user.abi == PERF_SAMPLE_REGS_ABI_NONE)
> +		return 0;
> +
> +	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
> +		perf_regs = container_of(data->regs_user.regs,
> +				 struct x86_perf_regs, regs);
> +		fpu = x86_task_fpu(current);
> +		/*
> +		 * If __task_fpstate is set, it holds the right pointer,
> +		 * otherwise fpstate will.
> +		 */
> +		fps = READ_ONCE(fpu->__task_fpstate);
> +		if (!fps)
> +			fps = fpu->fpstate;
> +		xsave = &fps->regs.xsave;
> +
> +		x86_pmu_update_xregs(perf_regs, xsave, mask);
> +		return 0;
> +	}
> +
> +	return mask & ~ignore_mask;
> +}

Sashiko comments

"

If a PEBS event triggers in kernel space and TIF_NEED_FPU_LOAD is false,
PEBS has captured the kernel XMM registers, and the drain code sets
ignore_mask = XFEATURE_MASK_SSE.
When requesting user XMM registers, user_mask evaluates to 0 here because
of ignore_mask. Does this incorrectly suppress the xsaves_nmi fallback,
silently dropping the live user XMM registers?
This also seems to leave the xmm_regs pointer uninitialized, leading to
the use-after-free mentioned above.

"

It makes sense as well. Need to clear ignore_mask for user space sampling
if the PEBS sampling hits kernel space instead of user space. Thanks.


> +
>  static void x86_pmu_sample_xregs(struct perf_event *event,
>  				 struct perf_sample_data *data,
>  				 u64 ignore_mask)
> @@ -1807,6 +1864,7 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
>  	struct xregs_state *xsave = per_cpu(ext_regs_buf, smp_processor_id());
>  	u64 sample_type = event->attr.sample_type;
>  	struct x86_perf_regs *perf_regs;
> +	u64 user_mask = 0;
>  	u64 intr_mask = 0;
>  	u64 mask = 0;
>  
> @@ -1817,15 +1875,26 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
>  		mask |= XFEATURE_MASK_SSE;
>  
>  	mask &= x86_pmu.ext_regs_mask;
> +	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.abi)
> +		user_mask = x86_pmu_update_user_xregs(data, mask, ignore_mask);
>  
>  	if ((sample_type & PERF_SAMPLE_REGS_INTR) && data->regs_intr.abi)
>  		intr_mask = mask & ~ignore_mask;
>  
> +	if (user_mask | intr_mask) {
> +		xsave->header.xfeatures = 0;
> +		xsaves_nmi(xsave, user_mask | intr_mask);
> +	}
> +
> +	if (user_mask) {
> +		perf_regs = container_of(data->regs_user.regs,
> +					 struct x86_perf_regs, regs);
> +		x86_pmu_update_xregs(perf_regs, xsave, user_mask);
> +	}
> +
>  	if (intr_mask) {
>  		perf_regs = container_of(data->regs_intr.regs,
>  					 struct x86_perf_regs, regs);
> -		xsave->header.xfeatures = 0;
> -		xsaves_nmi(xsave, mask);
>  		x86_pmu_update_xregs(perf_regs, xsave, intr_mask);
>  	}
>  }
