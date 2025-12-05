Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7855C398F97;
	Fri,  5 Dec 2025 06:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764916654; cv=none; b=AZgC8VGgS3DBmnI3jA7kmV1J3/gmyrXY0+ishtIxSpEIUYnsk35IHXbhfM1MPp29pIkoU/6gZbzuvHhPfhZyOexlE/FuRFSilfcTWSPx15R2+i05vzlnWA7bQL32auKtclSD/dUO95VGpCpNg2wzm3qn4u+V69vS0DkmR6h2RZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764916654; c=relaxed/simple;
	bh=AiRuLcIG5O37rtv/hDe82/U1bzZL/37aF6zSXJtDBKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gfvzS4/Z/f6CEF2PXvuD+QomfJ893m1CbrRnY3dPk/zD0KsEGe2WXCmjurRv543otRgMwAEajyrII9UQlwaW62M+PsNBu8+YzHaIzd+xgSc53ba1BT59QuhyxF8Xzom/OCI6TxpZnNdx8iz5AKwuHQ2nj4uTZR/qfabYbVW3Ju0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5tifBo9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5tifBo9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764916652; x=1796452652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AiRuLcIG5O37rtv/hDe82/U1bzZL/37aF6zSXJtDBKk=;
  b=M5tifBo9hwnAj7dOW7nYMzBoAQrB9BdPfxVS2i/PjMYeBK8gbmHLsaI2
   QE8U+Ah+xLonWWRwgHKvzAkgJrd/53clP1qdDroB1+CyblZsViMGBdsRH
   auuZUxju0angiQLKC4DrjpnPnEpD6lZDh9nSLixUS+5BmMz+lj82cXQhs
   9M6ZfozF+0znBUF8u28ZCt7ZbPUnmo3Krq+D+V+7CAwFm05iGohlYsmKO
   Z7Io/hYWUEoSjs7JrWWIw26pINqtWSMBIsny17z0VaYbdN7ESoOWurKpI
   F5Fi+tLMnF7ymfuTQj6dtDiCFseaiSQ242m1vKzK5nW1wpSvr59gFNHhB
   Q==;
X-CSE-ConnectionGUID: HciTauPwQNSzZrT/vfAWXA==
X-CSE-MsgGUID: 9vf4HKwJT8isJLjzPWDFHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11632"; a="66984259"
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="66984259"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 22:37:32 -0800
X-CSE-ConnectionGUID: V5IjASliR9SAt43+BQBGAg==
X-CSE-MsgGUID: WtzaIc5WQDiaaWA3YuM+UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,251,1758610800"; 
   d="scan'208";a="200167550"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.12]) ([10.124.240.12])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2025 22:37:27 -0800
Message-ID: <becd48cc-8dce-463f-bb00-fd97a21bba7d@linux.intel.com>
Date: Fri, 5 Dec 2025 14:37:24 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 06/19] perf/x86: Add support for XMM registers in
 non-PEBS and REGS_USER
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
 Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-7-dapeng1.mi@linux.intel.com>
 <20251204151735.GO2528459@noisy.programming.kicks-ass.net>
 <20251204154721.GB2619703@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251204154721.GB2619703@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 12/4/2025 11:47 PM, Peter Zijlstra wrote:
> On Thu, Dec 04, 2025 at 04:17:35PM +0100, Peter Zijlstra wrote:
>> On Wed, Dec 03, 2025 at 02:54:47PM +0800, Dapeng Mi wrote:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> While collecting XMM registers in a PEBS record has been supported since
>>> Icelake, non-PEBS events have lacked this feature. By leveraging the
>>> xsaves instruction, it is now possible to snapshot XMM registers for
>>> non-PEBS events, completing the feature set.
>>>
>>> To utilize the xsaves instruction, a 64-byte aligned buffer is required.
>>> A per-CPU ext_regs_buf is added to store SIMD and other registers, with
>>> the buffer size being approximately 2K. The buffer is allocated using
>>> kzalloc_node(), ensuring natural alignment and 64-byte alignment for all
>>> kmalloc() allocations with powers of 2.
>>>
>>> The XMM sampling support is extended for both REGS_USER and REGS_INTR.
>>> For REGS_USER, perf_get_regs_user() returns the registers from
>>> task_pt_regs(current), which is a pt_regs structure. It needs to be
>>> copied to user space secific x86_user_regs structure since kernel may
>>> modify pt_regs structure later.
>>>
>>> For PEBS, XMM registers are retrieved from PEBS records.
>>>
>>> In cases where userspace tasks are trapped within kernel mode (e.g.,
>>> during a syscall) when an NMI arrives, pt_regs information can still be
>>> retrieved from task_pt_regs(). However, capturing SIMD and other
>>> xsave-based registers in this scenario is challenging. Therefore,
>>> snapshots for these registers are omitted in such cases.
>>>
>>> The reasons are:
>>> - Profiling a userspace task that requires SIMD/eGPR registers typically
>>>   involves NMIs hitting userspace, not kernel mode.
>>> - Although it is possible to retrieve values when the TIF_NEED_FPU_LOAD
>>>   flag is set, the complexity introduced to handle this uncommon case in
>>>   the critical path is not justified.
>>> - Additionally, checking the TIF_NEED_FPU_LOAD flag alone is insufficient.
>>>   Some corner cases, such as an NMI occurring just after the flag switches
>>>   but still in kernel mode, cannot be handled.
>> Urgh.. Dave, Thomas, is there any reason we could not set
>> TIF_NEED_FPU_LOAD *after* doing the XSAVE (clearing is already done
>> after restore).
>>
>> That way, when an NMI sees TIF_NEED_FPU_LOAD it knows the task copy is
>> consistent.
>>
>> I'm not at all sure this is complex, it just needs a little care.
>>
>> And then there is the deferred thing, just like unwind, we can defer
>> REGS_USER/STACK_USER much the same, except someone went and built all
>> that deferred stuff with unwind all tangled into it :/
> With something like the below, the NMI could do something like:
>
> 	struct xregs_state *xr = NULL;
>
> 	/*
> 	 * fpu code does:
> 	 *  XSAVE
> 	 *  set_thread_flag(TIF_NEED_FPU_LOAD)
> 	 *  ...
> 	 *  XRSTOR
> 	 *  clear_thread_flag(TIF_NEED_FPU_LOAD)
> 	 * therefore, when TIF_NEED_FPU_LOAD, the task fpu state holds a
> 	 * whole copy.
> 	 */
> 	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
> 		struct fpu *fpu = x86_task_fpu(current);
> 		/*
> 		 * If __task_fpstate is set, it holds the right pointer,
> 		 * otherwise fpstate will.
> 		 */
> 		struct fpstate *fps = READ_ONCE(fpu->__task_fpstate);
> 		if (!fps)
> 			fps = fpu->fpstate;
> 		xr = &fps->regs.xregs_state;
> 	} else {
> 		/* like fpu_sync_fpstate(), except NMI local */
> 		xsave_nmi(xr, mask);
> 	}
>
> 	// frob xr into perf data
>
> Or did I miss something? I've not looked at this very long and the above
> was very vague on the actual issues.
>
>
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index da233f20ae6f..0f91a0d7e799 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -359,18 +359,22 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
>  	struct fpstate *cur_fps = fpu->fpstate;
>  
>  	fpregs_lock();
> -	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD))
> +	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD)) {
>  		save_fpregs_to_fpstate(fpu);
> +		set_thread_flag(TIF_NEED_FPU_LOAD);
> +	}
>  
>  	/* Swap fpstate */
>  	if (enter_guest) {
> -		fpu->__task_fpstate = cur_fps;
> +		WRITE_ONCE(fpu->__task_fpstate, cur_fps);
> +		barrier();
>  		fpu->fpstate = guest_fps;
>  		guest_fps->in_use = true;
>  	} else {
>  		guest_fps->in_use = false;
>  		fpu->fpstate = fpu->__task_fpstate;
> -		fpu->__task_fpstate = NULL;
> +		barrier();
> +		WRITE_ONCE(fpu->__task_fpstate, NULL);
>  	}
>  
>  	cur_fps = fpu->fpstate;
> @@ -456,8 +460,8 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
>  
>  	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
>  	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
> -		set_thread_flag(TIF_NEED_FPU_LOAD);
>  		save_fpregs_to_fpstate(x86_task_fpu(current));
> +		set_thread_flag(TIF_NEED_FPU_LOAD);
>  	}
>  	__cpu_invalidate_fpregs_state();
>  

Ok, I would involve these changes into next version and support the SIMD
registers sampling for user space registers sampling.


