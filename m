Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFE2E401;
	Wed, 25 Mar 2026 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774415935; cv=none; b=IE/6T3y9l5nmzB0eZIw8XpquM0ObK0qw55NTqm5INid8sQF8IWiEhEVgDIeaxp2jQbIHy6CSuCJDeSNv85rm/T76XFoqPkHIHxSY52QGD47Jf7giLtdIqF8M2LVCnhy8VOTT9u8nBzkaEqcNHlSJKTlE3MP29Cl9Tq4dCZ+FBoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774415935; c=relaxed/simple;
	bh=N+ZQ2SaWvXCp0sxJhTvr1moXay3eRsAD4m78bHtik08=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCRKRZT2VEDOWgh2SVWDACzC2NIIqrbXJoS7pPT5F+9KfOBH+UylAIE7oKwJUnK4VignAF9zv4LcYwnO706JI+OP3HPVk/phFnJmpUk+GsKscNLAjLQpZYJVIffWc550XGQ3LObZyoSBo/XPEsnci6HrW2CvsEcklBqAN/xLypg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIUvHV46; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIUvHV46"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774415934; x=1805951934;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N+ZQ2SaWvXCp0sxJhTvr1moXay3eRsAD4m78bHtik08=;
  b=cIUvHV46KVkITKsvDraTF5peAG80Hg+e3YD65EEGazhwVGbXF1EutzOe
   oQw7MEUi2cFsJsPtM1UPfOvuCGj++UtkoCp1i9UeiEWgZBDYAaHe4sE22
   rOqVCeY5UBX/a1HrKk/eX+lSb18Bf4q6FYkFWvBk14sLHBW2Gg+7o9JPO
   JUcV4BLgLXoi2x07Yl8072kV/8w8WNnMoXv+HVzzNI9DgyH9niFpGW03b
   4i9Bm+hHswxkkuQXVMSTUwS7sGzx330xMDT7bWo13vSAnFyiIUAnOWKbl
   Z2dIZjLgz/dA4QvaH7y181sx67JTf72n6YOwLA03YXbgp6tFCVH69hg60
   w==;
X-CSE-ConnectionGUID: kkcHs3efS/uWef6rb3UjTg==
X-CSE-MsgGUID: Sk2EQ12bRBe0zONS2xX5xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="74473454"
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="74473454"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 22:18:53 -0700
X-CSE-ConnectionGUID: uFkGH1EKTXyPQTHhXemuHQ==
X-CSE-MsgGUID: ijJyg3/pRZm3R9DRKjyrlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,139,1770624000"; 
   d="scan'208";a="229039893"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 22:18:48 -0700
Message-ID: <7efb05b6-ce14-4a55-b45a-fe79872d8fd9@linux.intel.com>
Date: Wed, 25 Mar 2026 13:18:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v7 07/24] perf/x86: Introduce x86-specific
 x86_pmu_setup_regs_data()
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
 <20260324004118.3772171-8-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260324004118.3772171-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/24/2026 8:41 AM, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
>
> The current perf/x86 implementation uses the generic functions
> perf_sample_regs_user() and perf_sample_regs_intr() to set up registers
> data for sampling records. While this approach works for general
> registers, it falls short when adding sampling support for SIMD and APX
> eGPRs registers on x86 platforms.
>
> To address this, we introduce the x86-specific function
> x86_pmu_setup_regs_data() for setting up register data on x86 platforms.
>
> At present, x86_pmu_setup_regs_data() mirrors the logic of the generic
> functions perf_sample_regs_user() and perf_sample_regs_intr().
> Subsequent patches will introduce x86-specific enhancements.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/core.c       | 33 +++++++++++++++++++++++++++++++++
>  arch/x86/events/intel/ds.c   |  9 ++++++---
>  arch/x86/events/perf_event.h |  4 ++++
>  3 files changed, 43 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index ad6cbc19592d..0a6c51e86e9b 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1699,6 +1699,39 @@ static void x86_pmu_del(struct perf_event *event, int flags)
>  	static_call_cond(x86_pmu_del)(event);
>  }
>  
> +void x86_pmu_setup_regs_data(struct perf_event *event,
> +			     struct perf_sample_data *data,
> +			     struct pt_regs *regs)
> +{
> +	struct perf_event_attr *attr = &event->attr;
> +	u64 sample_type = attr->sample_type;
> +
> +	if (sample_type & PERF_SAMPLE_REGS_USER) {
> +		if (user_mode(regs)) {
> +			data->regs_user.abi = perf_reg_abi(current);
> +			data->regs_user.regs = regs;
> +		} else if (!(current->flags & PF_KTHREAD)) {

Sashiko (AI agent) reviews this patchset. I would pick the reasonable
comment and paste here.

"

Is it safe to rely on !(current->flags & PF_KTHREAD) here?


Core perf code replaced this with the is_user_task() helper in commit
76ed27608f7d to prevent crashes. If a task is exiting (where task->mm
is cleared but PF_KTHREAD is not set) or if it is an io_uring thread
(which uses PF_USER_WORKER), could this pass the check and cause a NULL
pointer dereference or leak uninitialized kernel registers to user-space?

"

The comment looks reasonable and would fix it in next version.


> +			perf_get_regs_user(&data->regs_user, regs);
> +		} else {
> +			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
> +			data->regs_user.regs = NULL;
> +		}
> +		data->dyn_size += sizeof(u64);
> +		if (data->regs_user.regs)
> +			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
> +		data->sample_flags |= PERF_SAMPLE_REGS_USER;
> +	}
> +
> +	if (sample_type & PERF_SAMPLE_REGS_INTR) {
> +		data->regs_intr.regs = regs;
> +		data->regs_intr.abi = perf_reg_abi(current);
> +		data->dyn_size += sizeof(u64);
> +		if (data->regs_intr.regs)
> +			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
> +		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
> +	}
> +}
> +
>  int x86_pmu_handle_irq(struct pt_regs *regs)
>  {
>  	struct perf_sample_data data;
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 52eb6eac5df3..b045297c02d0 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2450,6 +2450,7 @@ static inline void __setup_pebs_basic_group(struct perf_event *event,
>  }
>  
>  static inline void __setup_pebs_gpr_group(struct perf_event *event,
> +					  struct perf_sample_data *data,
>  					  struct pt_regs *regs,
>  					  struct pebs_gprs *gprs,
>  					  u64 sample_type)
> @@ -2459,8 +2460,10 @@ static inline void __setup_pebs_gpr_group(struct perf_event *event,
>  		regs->flags &= ~PERF_EFLAGS_EXACT;
>  	}
>  
> -	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
> +	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
>  		adaptive_pebs_save_regs(regs, gprs);
> +		x86_pmu_setup_regs_data(event, data, regs);
> +	}
>  }
>  
>  static inline void __setup_pebs_meminfo_group(struct perf_event *event,
> @@ -2553,7 +2556,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
>  		gprs = next_record;
>  		next_record = gprs + 1;
>  
> -		__setup_pebs_gpr_group(event, regs, gprs, sample_type);
> +		__setup_pebs_gpr_group(event, data, regs, gprs, sample_type);
>  	}
>  
>  	if (format_group & PEBS_DATACFG_MEMINFO) {
> @@ -2677,7 +2680,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
>  		gprs = next_record;
>  		next_record = gprs + 1;
>  
> -		__setup_pebs_gpr_group(event, regs,
> +		__setup_pebs_gpr_group(event, data, regs,
>  				       (struct pebs_gprs *)gprs,
>  				       sample_type);
>  	}
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index fad87d3c8b2c..39c41947c70d 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1306,6 +1306,10 @@ void x86_pmu_enable_event(struct perf_event *event);
>  
>  int x86_pmu_handle_irq(struct pt_regs *regs);
>  
> +void x86_pmu_setup_regs_data(struct perf_event *event,
> +			     struct perf_sample_data *data,
> +			     struct pt_regs *regs);
> +
>  void x86_pmu_show_pmu_cap(struct pmu *pmu);
>  
>  static inline int x86_pmu_num_counters(struct pmu *pmu)
