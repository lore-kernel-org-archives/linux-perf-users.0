Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6B350290;
	Tue, 21 Oct 2025 17:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761067151; cv=none; b=cG0CMSkW6PROenqJz+CoQZ92rlSBZHtMyp9YMo5nrBLCyEBSuKpemORCh9w0OneLhEddj6vvstx67DBawV0SI41qCidF/A1q98wQVA/zYXN4TEnMLwSu9MVj406eYcd4Q5q50n2jmja+cTXlE85GqNAq+D2O+LG8rgC+eO/cGjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761067151; c=relaxed/simple;
	bh=RDfPG1pRzJ4rs0GOH+EguFN3rm7n1AS9o0UiheUWzG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFH7sLqAaATbneQFulkFOUOJaYV4eCDQIgZ3SAjMbjlY9fmjqD1PzD+UIe/MgvwhKn7sKbd6zOBizN5rlCaaMlsn5jjJK6PzAo7SDD16yIywqEUYdJIa11WRO1qULRIS4Itpcg5Ag+BXTjTbn3yuOf8IBJPf4iUpi03xYM8ecPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jrWKLDlk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jrWKLDlk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=RkJrzfcQKUOuc7H8FY8vKP99zGLgpmQ/0LULP00+2WY=; b=jrWKLDlkLM9dtJU+WpNP47LChE
	Ksbyafre39IedUfGSwpkiptEdtQLXxKwaHLknu8VjbDiAdCNrDUNECSsg9hvZnWuOH42Pu8XY+1p2
	PvnBNKcPE5iP98lEwAKy64hV6XdtVC+2I9GpLHB2qRXrSmimQPvR2XW7gNyc3rPyCtvcdulX6pE7J
	CHzrHlJ3iLkDp/SQILVNSprkrtGEbYl/RgfI/2oFHUxx/2HZ2ae/aWQE1XQ8DR4K8IDJ7zlRX1By0
	Q4O3j9U6WihVWqDrf1vSQSHIxoxnj3CK/7xgr0JJzq5N9GdeJAGZLFkzuXo9DiB/TsrzSMCOUPx6P
	PmV1PQng==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBF90-00000000tCQ-0dPu;
	Tue, 21 Oct 2025 16:23:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 31121303160; Tue, 21 Oct 2025 17:43:49 +0200 (CEST)
Date: Tue, 21 Oct 2025 17:43:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v8 05/12] perf/x86/intel: Initialize architectural PEBS
Message-ID: <20251021154349.GR3245006@noisy.programming.kicks-ass.net>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-6-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015064422.47437-6-dapeng1.mi@linux.intel.com>

On Wed, Oct 15, 2025 at 02:44:15PM +0800, Dapeng Mi wrote:
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index c88bcd5d2bc4..bfb123ff7c9a 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5273,34 +5273,58 @@ static inline bool intel_pmu_broken_perf_cap(void)
>  
>  static void update_pmu_cap(struct pmu *pmu)
>  {
> -	unsigned int cntr, fixed_cntr, ecx, edx;
> -	union cpuid35_eax eax;
> -	union cpuid35_ebx ebx;
> +	unsigned int eax, ebx, ecx, edx;
> +	union cpuid35_eax eax_0;
> +	union cpuid35_ebx ebx_0;
> +	u64 cntrs_mask = 0;
> +	u64 pebs_mask = 0;
> +	u64 pdists_mask = 0;
>  
> -	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
> +	cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx);
>  
> -	if (ebx.split.umask2)
> +	if (ebx_0.split.umask2)
>  		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
> -	if (ebx.split.eq)
> +	if (ebx_0.split.eq)
>  		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
>  
> -	if (eax.split.cntr_subleaf) {
> +	if (eax_0.split.cntr_subleaf) {
>  		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
> -			    &cntr, &fixed_cntr, &ecx, &edx);
> -		hybrid(pmu, cntr_mask64) = cntr;
> -		hybrid(pmu, fixed_cntr_mask64) = fixed_cntr;
> +			    &eax, &ebx, &ecx, &edx);
> +		hybrid(pmu, cntr_mask64) = eax;
> +		hybrid(pmu, fixed_cntr_mask64) = ebx;
> +		cntrs_mask = (u64)ebx << INTEL_PMC_IDX_FIXED | eax;
>  	}
>  
> -	if (eax.split.acr_subleaf) {
> +	if (eax_0.split.acr_subleaf) {
>  		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
> -			    &cntr, &fixed_cntr, &ecx, &edx);
> +			    &eax, &ebx, &ecx, &edx);
>  		/* The mask of the counters which can be reloaded */
> -		hybrid(pmu, acr_cntr_mask64) = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
> +		hybrid(pmu, acr_cntr_mask64) = eax | ((u64)ebx << INTEL_PMC_IDX_FIXED);
>  
>  		/* The mask of the counters which can cause a reload of reloadable counters */
>  		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
>  	}
>  
> +	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
> +	if (eax_0.split.pebs_caps_subleaf && eax_0.split.pebs_cnts_subleaf) {
> +		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_LEAF,
> +			    &eax, &ebx, &ecx, &edx);
> +		hybrid(pmu, arch_pebs_cap).caps = (u64)ebx << 32;
> +
> +		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
> +			    &eax, &ebx, &ecx, &edx);
> +		pebs_mask = ((u64)ecx << INTEL_PMC_IDX_FIXED) | eax;
> +		pdists_mask = ((u64)edx << INTEL_PMC_IDX_FIXED) | ebx;
> +		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
> +		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
> +
> +		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
> +			x86_pmu.arch_pebs = 0;
> +	} else {
> +		WARN_ON(x86_pmu.arch_pebs == 1);
> +		x86_pmu.arch_pebs = 0;
> +	}
> +
>  	if (!intel_pmu_broken_perf_cap()) {
>  		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>  		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);

I've stuck this on top.

--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5271,6 +5271,8 @@ static inline bool intel_pmu_broken_perf
 	return false;
 }
 
+#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
+
 static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -5292,17 +5294,16 @@ static void update_pmu_cap(struct pmu *p
 			    &eax, &ebx, &ecx, &edx);
 		hybrid(pmu, cntr_mask64) = eax;
 		hybrid(pmu, fixed_cntr_mask64) = ebx;
-		cntrs_mask = (u64)ebx << INTEL_PMC_IDX_FIXED | eax;
+		cntrs_mask = counter_mask(eax, ebx);
 	}
 
 	if (eax_0.split.acr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
 			    &eax, &ebx, &ecx, &edx);
 		/* The mask of the counters which can be reloaded */
-		hybrid(pmu, acr_cntr_mask64) = eax | ((u64)ebx << INTEL_PMC_IDX_FIXED);
-
+		hybrid(pmu, acr_cntr_mask64) = counter_mask(eax, ebx);
 		/* The mask of the counters which can cause a reload of reloadable counters */
-		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cause_mask64) = counter_mask(ecx, edx);
 	}
 
 	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
@@ -5313,8 +5314,8 @@ static void update_pmu_cap(struct pmu *p
 
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
 			    &eax, &ebx, &ecx, &edx);
-		pebs_mask = ((u64)ecx << INTEL_PMC_IDX_FIXED) | eax;
-		pdists_mask = ((u64)edx << INTEL_PMC_IDX_FIXED) | ebx;
+		pebs_mask   = counter_mask(eax, ecx);
+		pdists_mask = counter_mask(ebx, edx);
 		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
 		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
 
