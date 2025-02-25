Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E47642A8C;
	Tue, 25 Feb 2025 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497591; cv=none; b=JkmCH4lLT2uWA56AOffNKavoDVEFWqzAIr9Gkp+h4y+8P/LFQTBi9OtkyKeid5Xbqc4ZqoDtPvJxPHpmu8Mz2h9CXB3EEJfJ0cgVmbmcnp9YxhhVinGi2RCSXsbj2oQf1S+0biNeQ7tC6pjQO9IOmar2hGDnKvWwPm/eGaUqgi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497591; c=relaxed/simple;
	bh=NB3Ck5iopHslm0lllp1K8pfnwoMHYcDXFKgUU42IWKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvcIX5HxOBOXMCysstAO4IcrCeAtOwoHpVVm+1JD8gadINqKBlXhxI5fnw74dnaowGkB6L32r/whDpjItnl9Lxa3YFR9M6gXql0OW9YTLu80mbU4WpZSJZG2hM2ovgyMvotlquesEiFTWK8mrmrOqlG9c6kOe6oGa9sYs+55jaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rbYcIPYs; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rbYcIPYs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MZEzMJLWhR18exaXAwg6HdM4ASsrIPJJFCYkErtszkQ=; b=rbYcIPYswSC/DeKeX96XqlAq+M
	gRAoGGSuuCTCNV9RSSfJaytPzEKfJXHqOa5VvI2yQrnDqHt3116cdNwcMsgEUUo6wwssjMsAc1r2/
	hBdCpd9s3jHXO9DTuo7RvB1LertfZTxdMfcxJ9Z/Ia7rcfT3RL6CNPdJDMzXF3ntWxLzDFxFO1wq5
	g7qOTByJYodjMJA0dJIG4DtpQow+2pM76++zPnrUBG5ErnQRr28X9MM4Zmcf5nu1/AMfkeP/Ibias
	JychAqRNOfwH6gllx4QCZi7+W7fVuwpJ/ZtSUAKD83WEJ+P5wwvhGQJjF9Od7PrAaz19LpI9Uk0E2
	V4E5P1vw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmwva-00000003MGd-3FKz;
	Tue, 25 Feb 2025 15:32:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B010D300472; Tue, 25 Feb 2025 16:32:57 +0100 (CET)
Date: Tue, 25 Feb 2025 16:32:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: Re: [Patch v2 18/24] perf/x86/intel: Support arch-PEBS vector
 registers group capturing
Message-ID: <20250225153257.GQ11590@noisy.programming.kicks-ass.net>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
 <20250218152818.158614-19-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218152818.158614-19-dapeng1.mi@linux.intel.com>

On Tue, Feb 18, 2025 at 03:28:12PM +0000, Dapeng Mi wrote:
> Add x86/intel specific vector register (VECR) group capturing for
> arch-PEBS. Enable corresponding VECR group bits in
> GPx_CFG_C/FX0_CFG_C MSRs if users configures these vector registers
> bitmap in perf_event_attr and parse VECR group in arch-PEBS record.
> 
> Currently vector registers capturing is only supported by PEBS based
> sampling, PMU driver would return error if PMI based sampling tries to
> capture these vector registers.


> @@ -676,6 +709,32 @@ int x86_pmu_hw_config(struct perf_event *event)
>  			return -EINVAL;
>  	}
>  
> +	/*
> +	 * Architectural PEBS supports to capture more vector registers besides
> +	 * XMM registers, like YMM, OPMASK and ZMM registers.
> +	 */
> +	if (unlikely(has_more_extended_regs(event))) {
> +		u64 caps = hybrid(event->pmu, arch_pebs_cap).caps;
> +
> +		if (!(event->pmu->capabilities & PERF_PMU_CAP_MORE_EXT_REGS))
> +			return -EINVAL;
> +
> +		if (has_opmask_regs(event) && !(caps & ARCH_PEBS_VECR_OPMASK))
> +			return -EINVAL;
> +
> +		if (has_ymmh_regs(event) && !(caps & ARCH_PEBS_VECR_YMM))
> +			return -EINVAL;
> +
> +		if (has_zmmh_regs(event) && !(caps & ARCH_PEBS_VECR_ZMMH))
> +			return -EINVAL;
> +
> +		if (has_h16zmm_regs(event) && !(caps & ARCH_PEBS_VECR_H16ZMM))
> +			return -EINVAL;
> +
> +		if (!event->attr.precise_ip)
> +			return -EINVAL;
> +	}
> +
>  	return x86_setup_perfctr(event);
>  }
>  
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index f21d9f283445..8ef5b9a05fcc 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2963,6 +2963,18 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
>  			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
>  				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
>  
> +			if (pebs_data_cfg & PEBS_DATACFG_YMMS)
> +				ext |= ARCH_PEBS_VECR_YMM & cap.caps;
> +
> +			if (pebs_data_cfg & PEBS_DATACFG_OPMASKS)
> +				ext |= ARCH_PEBS_VECR_OPMASK & cap.caps;
> +
> +			if (pebs_data_cfg & PEBS_DATACFG_ZMMHS)
> +				ext |= ARCH_PEBS_VECR_ZMMH & cap.caps;
> +
> +			if (pebs_data_cfg & PEBS_DATACFG_H16ZMMS)
> +				ext |= ARCH_PEBS_VECR_H16ZMM & cap.caps;
> +
>  			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
>  				ext |= ARCH_PEBS_LBR & cap.caps;
>  
> @@ -5115,6 +5127,9 @@ static inline void __intel_update_pmu_caps(struct pmu *pmu)
>  
>  	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
>  		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
> +
> +	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_EXT)
> +		dest_pmu->capabilities |= PERF_PMU_CAP_MORE_EXT_REGS;
>  }

There is no technical reason for it to error out, right? We can use
FPU/XSAVE interface to read the CPU state just fine.


> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 4b01beee15f4..7e5a4202de37 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c

> @@ -1437,9 +1438,37 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
>  	if (gprs || (attr->precise_ip < 2) || tsx_weight)
>  		pebs_data_cfg |= PEBS_DATACFG_GP;
>  
> -	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
> -	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
> -		pebs_data_cfg |= PEBS_DATACFG_XMMS;
> +	if (sample_type & PERF_SAMPLE_REGS_INTR) {
> +		if (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK)
> +			pebs_data_cfg |= PEBS_DATACFG_XMMS;
> +
> +		for_each_set_bit_from(bit,
> +			(unsigned long *)event->attr.sample_regs_intr_ext,
> +			PERF_NUM_EXT_REGS) {

This is indented wrong; please use cino=(0:0
if you worry about indentation depth, break out in helper function.

> +			switch (bit + PERF_REG_EXTENDED_OFFSET) {
> +			case PERF_REG_X86_OPMASK0 ... PERF_REG_X86_OPMASK7:
> +				pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
> +				bit = PERF_REG_X86_YMMH0 -
> +				      PERF_REG_EXTENDED_OFFSET - 1;
> +				break;
> +			case PERF_REG_X86_YMMH0 ... PERF_REG_X86_ZMMH0 - 1:
> +				pebs_data_cfg |= PEBS_DATACFG_YMMS;
> +				bit = PERF_REG_X86_ZMMH0 -
> +				      PERF_REG_EXTENDED_OFFSET - 1;
> +				break;
> +			case PERF_REG_X86_ZMMH0 ... PERF_REG_X86_ZMM16 - 1:
> +				pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
> +				bit = PERF_REG_X86_ZMM16 -
> +				      PERF_REG_EXTENDED_OFFSET - 1;
> +				break;
> +			case PERF_REG_X86_ZMM16 ... PERF_REG_X86_ZMM_MAX - 1:
> +				pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
> +				bit = PERF_REG_X86_ZMM_MAX -
> +				      PERF_REG_EXTENDED_OFFSET - 1;
> +				break;
> +			}
> +		}
> +	}
>  
>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
>  		/*
