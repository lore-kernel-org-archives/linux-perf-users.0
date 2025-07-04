Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D7C4501A;
	Fri,  4 Jul 2025 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751644223; cv=none; b=XmBrLWOeHUXDpSWgyoKmM/SVnpo/dytKY7cB/mo2AvdZHpBvwYyHC7j/3lSvMuNlCsNmR0YGtYGF144CoZo2s7RQtXFuX3H7ltcyOlMyM35sjs41/mcMsGTQay3CYmdp1Fo3EEohE6nGKRb5qIxDwznkRJxY7j2mzKUgW23eMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751644223; c=relaxed/simple;
	bh=twYZghTXQcVO0LNfLEmd62PlWPE6v2GPlTk8wTJbwMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C9nFQ7sFQZPHqbTr4jnNnR6VPCaNmhNrm5K8bvVfrAlQMysxAJ/+uaC+T6I2bUnd4ssDB/cMh1Z/70M936u5zrgoH6Xb6sKMOGsGBvCRt7G5d2Qwy3gF9mO6Hz3Rv6lAFklJ7iD8d4Bx+ZXm4+IpbxDprSXcgrPgKwOHy2l3+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08ECB153B;
	Fri,  4 Jul 2025 08:50:05 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 81EC03F66E;
	Fri,  4 Jul 2025 08:50:18 -0700 (PDT)
Date: Fri, 4 Jul 2025 16:50:16 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
Message-ID: <20250704155016.GI1039028@e132581.arm.com>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>

On Tue, Jul 01, 2025 at 04:31:58PM +0100, James Clark wrote:

[...]

> @@ -661,16 +666,24 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>  	 */
>  	irq_work_run();
>  
> +	/*
> +	 * arm_spe_pmu_buf_get_fault_act() already drained, and PMBSR_EL1.S == 1
> +	 * means that StatisticalProfilingEnabled() == false. So now we can
> +	 * safely disable the buffer.
> +	 */
> +	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
> +	isb();
> +
> +	/* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
> +	write_sysreg_s(0, SYS_PMBSR_EL1);
> +

An important thing is about sequence:
As described in arm_spe_pmu_disable_and_drain_local(), should we always
clear ELs bits in PMSCR_EL1 before clear PMBLIMITR_EL1.E bit? As a
reference, we could see TRBE always clear ELx bits before disable trace
buffer.

And a trivial flaw:

If the TRUNCATED flag has been set, the irq_work_run() above runs the
IRQ work to invoke the arm_spe_pmu_stop() to disable trace buffer, which
clear SYS_PMBLIMITR_EL1.E bit. This is why the current code does not
explictly clear SYS_PMBLIMITR_EL1.E bit.

With this patch, the interrupt handler will clear SYS_PMBLIMITR_EL1.E
bit twice for a trunacated case.


>  	switch (act) {
>  	case SPE_PMU_BUF_FAULT_ACT_FATAL:
>  		/*
> -		 * If a fatal exception occurred then leaving the profiling
> -		 * buffer enabled is a recipe waiting to happen. Since
> -		 * fatal faults don't always imply truncation, make sure
> -		 * that the profiling buffer is disabled explicitly before
> -		 * clearing the syndrome register.
> +		 * To complete the full disable sequence, also disable profiling
> +		 * at EL0 and EL1, we don't want to continue at all anymore.
>  		 */
> -		arm_spe_pmu_disable_and_drain_local();
> +		write_sysreg_s(0, SYS_PMSCR_EL1);
>  		break;
>  	case SPE_PMU_BUF_FAULT_ACT_OK:
>  		/*
> @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
>  		 * PMBPTR might be misaligned, but we'll burn that bridge
>  		 * when we get to it.
>  		 */
> -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
> +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
>  			arm_spe_perf_aux_output_begin(handle, event);
> -			isb();

I am a bit suspecious we can remove this isb().

As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
for this?

Thanks,
Leo

> -		}
>  		break;
>  	case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:
>  		/* We've seen you before, but GCC has the memory of a sieve. */
>  		break;
>  	}
>  
> -	/* The buffer pointers are now sane, so resume profiling. */
> -	write_sysreg_s(0, SYS_PMBSR_EL1);
>  	return IRQ_HANDLED;
>  }
>  
> 
> -- 
> 2.34.1
> 
> 
