Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5F1AD5E;
	Sat, 31 May 2025 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748678481; cv=none; b=LvU6kZyjUmpyVKz9ycQe9aE1GaEP+aah/lDmErONmrRSXgR0fi+8+5EsnCP6kJMOhJzCm2xo1Jqk/Uyof6QiuTteC0gHwaImcEDPUAstcggr/BV0OMaf7becs7z2sZDDqfDrApOZC7/N8ZX6FHiImZq9cFNuzIkWb41c9qrnl6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748678481; c=relaxed/simple;
	bh=GiFNV580WZ1Ace5VTRXQHO9zPun5iNtUfqXjhZo6LKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKLd0qwXnkMvH31GETx2TjQBTIf8Mf14yN8Sz5LgVbvHXxu8ICnInovKKP4K82PcrfPUVTZZ50xShX94/xJVa7BW9tt5X9ri0OCpanxZF6OMtsTSAmhKz/PbygH35NQnsfNTyxFo4/Cq2OIvFU/3v7C7qw7C64PxIEAa5WEEGEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hZ1CVKPz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hZ1CVKPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E7CC4CEE3;
	Sat, 31 May 2025 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748678481;
	bh=GiFNV580WZ1Ace5VTRXQHO9zPun5iNtUfqXjhZo6LKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hZ1CVKPzwFiwYiKdQvv0CEwQ0vZ/+hfgrlDbibBeP5a6qdbtIR3ge5+azl9/OV1ry
	 1vFAGO/9j70OyevJwR8kTkOy/lPOH63v/mbaqK1ONbkINXtJ/NXmY49iwP3w51wi0N
	 PRJ+IwS/esW0EfxRvvLL+oQWo874FmjA+q5EHA06W6n+FmK9ZXsEWvK67i9h0AHlDV
	 JoFbsP9+XBxqkLLTEnzKgE33WqrXBnDb+dVuMIpib5Mc3A7rtRF6mRBX/uHjut7d6q
	 m/7/zpQGJGC1tkXaauKzhsCDEdSE07F4xepGit/jy52991Nbp6zUkqqrw7H4nsJYc1
	 LmfQ7eJJFowHg==
Date: Sat, 31 May 2025 10:01:15 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [PATCH 1/2] perf/x86/intel: Fix IA32_PMC_x_CFG_B MSRs access
 error
Message-ID: <aDq3S9lwO1YadCKT@gmail.com>
References: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>


* Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:

> When running perf_fuzzer on PTL, sometimes the below "unchecked MSR
>  access error" is seen when accessing IA32_PMC_x_CFG_B MSRs.
> 
> [   55.611268] unchecked MSR access error: WRMSR to 0x1986 (tried to write 0x0000000200000001) at rIP: 0xffffffffac564b28 (native_write_msr+0x8/0x30)
> [   55.611280] Call Trace:
> [   55.611282]  <TASK>
> [   55.611284]  ? intel_pmu_config_acr+0x87/0x160
> [   55.611289]  intel_pmu_enable_acr+0x6d/0x80
> [   55.611291]  intel_pmu_enable_event+0xce/0x460
> [   55.611293]  x86_pmu_start+0x78/0xb0
> [   55.611297]  x86_pmu_enable+0x218/0x3a0
> [   55.611300]  ? x86_pmu_enable+0x121/0x3a0
> [   55.611302]  perf_pmu_enable+0x40/0x50
> [   55.611307]  ctx_resched+0x19d/0x220
> [   55.611309]  __perf_install_in_context+0x284/0x2f0
> [   55.611311]  ? __pfx_remote_function+0x10/0x10
> [   55.611314]  remote_function+0x52/0x70
> [   55.611317]  ? __pfx_remote_function+0x10/0x10
> [   55.611319]  generic_exec_single+0x84/0x150
> [   55.611323]  smp_call_function_single+0xc5/0x1a0
> [   55.611326]  ? __pfx_remote_function+0x10/0x10
> [   55.611329]  perf_install_in_context+0xd1/0x1e0
> [   55.611331]  ? __pfx___perf_install_in_context+0x10/0x10
> [   55.611333]  __do_sys_perf_event_open+0xa76/0x1040
> [   55.611336]  __x64_sys_perf_event_open+0x26/0x30
> [   55.611337]  x64_sys_call+0x1d8e/0x20c0
> [   55.611339]  do_syscall_64+0x4f/0x120
> [   55.611343]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> On PTL, GP counter 0 and 1 doesn't support auto counter reload feature,
> thus it would trigger a #GP when trying to write 1 on bit 0 of CFG_B MSR
> which requires to enable auto counter reload on GP counter 0.
> 
> The root cause of causing this issue is the check for auto counter
> reload (ACR) counter mask from user space is incorrect in
> intel_pmu_acr_late_setup() helper. It leads to an invalid ACR counter
> mask from user space could be set into hw.config1 and then written into
> CFG_B MSRs and trigger the MSR access warning.
> 
> e.g., User may create a perf event with ACR counter mask (config2=0xcb),
> and there is only 1 event created, so "cpuc->n_events" is 1.
> 
> The correct check condition should be "i + idx >= cpuc->n_events"
> instead of "i + idx > cpuc->n_events" (it looks a typo). Otherwise,
> the counter mask would traverse twice and an invalid "cpuc->assign[1]"
> bit (bit 0) is set into hw.config1 and cause MSR accessing error.
> 
> Besides, also check if the ACR counter mask corresponding events are
> ACR events. If not, filter out these counter mask. If a event is not a
> ACR event, it could be scheduled to an HW counter which doesn't support
> ACR. It's invalid to add their counter index in ACR counter mask.
> 
> Furthermore, remove the WARN_ON_ONCE() since it's easily triggered as
> user could set any invalid ACR counter mask and the warning message
> could mislead users.
> 
> Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 3a319cf6d364..8d046b1a237e 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2994,7 +2994,8 @@ static void intel_pmu_acr_late_setup(struct cpu_hw_events *cpuc)
>  			if (event->group_leader != leader->group_leader)
>  				break;
>  			for_each_set_bit(idx, (unsigned long *)&event->attr.config2, X86_PMC_IDX_MAX) {
> -				if (WARN_ON_ONCE(i + idx > cpuc->n_events))
> +				if (i + idx >= cpuc->n_events ||
> +				    !is_acr_event_group(cpuc->event_list[i + idx]))
>  					return;

Is this a normal condition?

 - If it's normal then the 'return' is destructive, isn't it? Shouldn't 
   it be a 'break', if this condition is legitimate?

 - If it's not normal, then the WARN_ON_ONCE() was justified, right?

Thanks,

	Ingo
