Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872BC3451B0;
	Fri,  5 Jun 2026 20:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691544; cv=none; b=poysV64VevB+7IJKrLT1TEfGNfE4ptYxqhQfdXacDeDK1pXx+QvbQZp9TUvyubCrv7RKs7wKaokcevEJwSwHMK3S4zOMjYn83ByY7EbVcitDOq0eeI5L6+dYi26cuW93K4MesqEr7v4YB9XRM9/zH5SvV8mXi2ITiq1QsEm+RUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691544; c=relaxed/simple;
	bh=XQP4zA7+lu4eln6u9ed0HJP8hO5z9fRlEXU9uifoGd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1404p/yeL5COcynMPcmSC5tErkMVW4hzxawpcTcskkzT1Y91GQeicOsSXVdQhg1YlsQeLOfdI8Q7U25sI4xfdekw2hiu77eb8dyWR4HepxQeujx8scibPHoBJMGuj82qm4Hc6mYy/Xh7e/9Hnj5T+Uo6hEsYDbY+/IpwGOsodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nn1ObHj0; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nn1ObHj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780691542; x=1812227542;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XQP4zA7+lu4eln6u9ed0HJP8hO5z9fRlEXU9uifoGd0=;
  b=Nn1ObHj0rZWpeV6oMnb1dCZlZ+GybV/UcWqP+m7oEm1Dh/j4xSbT8pMV
   7XrWlFUk0Qjag4njXkZqcM4LeYv59CuBoPbbi9Q2lqdTNbGpZX/T+56Ua
   w8E/S8brg1gGu4YR+bGzkfURZ+9v7wiKPdbdFsgfx38Bs1gBrTE2JQw/L
   bEvoBQBx/PT2/EurIuNxdGA+HZmc935aQyWL//kVJ12dlQkSR+Vs+9TsA
   W+kMC/cq+eCYCHjOB+KaQWsErn9SKXkt19lwDEahMO4EzYTnE11skRGbz
   6JYtrmSOIcqsLY9moNz5bKwUxpGfYQjU2vS8/sYeCmqNxuT3bqExTgoTR
   g==;
X-CSE-ConnectionGUID: KWw9KZa4T4+/fzNnYYCPmA==
X-CSE-MsgGUID: TjEHkcrsTZCz2+Nlq2Uoig==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="85383442"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="85383442"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 13:32:21 -0700
X-CSE-ConnectionGUID: rzKjlUBZQGq75QT9/Bm3AA==
X-CSE-MsgGUID: yr3HH1FLQCOPzjt/OAH0HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="242472461"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 13:32:20 -0700
Message-ID: <350ebaf7-91b1-4550-be4d-a07a96c4a955@intel.com>
Date: Fri, 5 Jun 2026 15:32:19 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] perf/x86/intel: Drop fixed-counter PEBS constraints
 for baseline PEBS
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Yi Lai <yi1.lai@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
 <20260605011136.2043393-8-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260605011136.2043393-8-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 8:11 PM, Dapeng Mi wrote:
> On SPR guests where pebs_baseline is not advertised, running:
> 
> $ ./perf record -e cpu/event=0x00,umask=0x01,i\
> 	 name=INST_RETIRED.PREC_DIST/p -c 10000 sleep 1
> 
> can trigger:
> 
> unchecked MSR access error: WRMSR to 0x3f1 ... in\
> 	 intel_pmu_pebs_enable_all()
> 
> Root cause:
> SPR-specific PEBS constraints allow fixed-counter scheduling,
> for example INST_RETIRED.PREC_DIST on fixed counter 0. In guests without
> pebs_baseline, KVM does not support PEBS sampling on fixed counters,
> so enabling such events reaches an invalid MSR programming path.
> 
> Fix:
> Drop fixed-counter entries from the PEBS constraint table. Without
> pebs_baseline, those fixed-counter PEBS events now resolve to empty
> constraints and are not scheduled/enabled, avoiding the warning and the
> broken guest PEBS path.

Seems this exposes a more general issue: constraints derived from
host capabilities may not be applicable to a guest, since the guest may
only has a subset of the host capabilities.

For example, an event could be constrained to GP counter 7, while that
counter is not exposed to the guest. Currently this is not gated and
failures may only surface later during event programming.

Instead of dropping the constraints, should we validate counter
availability in intel_pebs_constraints() or
intel_get_event_constraints(), etc., and in a more generic way?


> This is safe because, in pebs_baseline-capable cases, PEBS constraint
> lookup already falls back to non-PEBS constraints when needed, and
> fixed-counter constraints are effectively shared there.

Can it really be removed without any consequences?

If it is architecturally required that INST_RETIRED.PREC_DIST must run
on fixed counter 0, then the constraint should be preserved. I think.


> Reported-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  arch/x86/events/intel/ds.c | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index cb72af9b61ce..5db15a92017a 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1447,10 +1447,6 @@ struct event_constraint intel_skl_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_icl_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01c0, 0x100000000ULL),	/* old INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),	/* SLOTS */
> -
>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xff),			/* MEM_TRANS_RETIRED.LOAD_LATENCY */
>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
> @@ -1473,9 +1469,6 @@ struct event_constraint intel_icl_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_glc_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
> -
>  	INTEL_FLAGS_EVENT_CONSTRAINT(0xc0, 0xfe),
>  	INTEL_PLD_CONSTRAINT(0x1cd, 0xfe),
>  	INTEL_PSD_CONSTRAINT(0x2cd, 0x1),
> @@ -1500,9 +1493,6 @@ struct event_constraint intel_glc_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_lnc_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
> -
>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
>  	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
>  
> @@ -1534,9 +1524,6 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
>  };
>  
>  struct event_constraint intel_pnc_pebs_event_constraints[] = {
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
> -	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
> -
>  	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
>  	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
>  	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */

