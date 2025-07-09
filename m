Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C82EF289368;
	Wed,  9 Jul 2025 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055782; cv=none; b=tyQtGC1ueBjOdjIsp0ENGcx5O5sPYAqUex8LAQv7sBsIGPetZA1RpM6jzNpoCqbSWWa2ZoIKx/FG2nZtm3/EfTXBQ3ta79fBOQJwKMJB6AExXyXTBui1Oe7SIWO3SkSn/+VB7kAKEA5s63OaeKxJdVsdWhI1hn0Q7guM4cutOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055782; c=relaxed/simple;
	bh=Sw7oI7H4anCTEdENQ9OK36GMbuYvdgqWc1bZLlsHgW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiLtpsgBhN8ORmSWts6pyMf0uh2196YR5XhdMdGz1cvc5t/1HTuPqKSQf2LZtB8VK+dg35Z2WAR+4gs2tlqBeuuwbZhUYOoYoBVf8ML1ciwL6SimTZq6V/ccyIAsu/D1h62vOw3iwe54b89/UHrAH0y9ZwWLS2xwH6KR+CqKd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9060F153B;
	Wed,  9 Jul 2025 03:09:28 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 82CB43F694;
	Wed,  9 Jul 2025 03:09:38 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:09:32 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
Message-ID: <aG4_3D1RG8CWncBF@raptor>
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

Hi James,

On Tue, Jul 01, 2025 at 04:31:58PM +0100, James Clark wrote:
> DEN0154 states that writes to PMBPTR_EL1 or PMBSR_EL1 must be done while
> the buffer is disabled (PMBLIMITR_EL1.E == 0). Re-arrange the interrupt
> handler to always disable the buffer for non-spurious interrupts before
> doing either.
> 
> Most of arm_spe_pmu_disable_and_drain_local() is now always done, so for
> faults the only thing left to do is clear PMSCR_EL1.
> 
> Elaborate the comment in arm_spe_pmu_disable_and_drain_local() to
> explain the ramifications of not doing it in the right order.
> 
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/perf/arm_spe_pmu.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 6235ca7ecd48..5829947c8871 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -559,7 +559,12 @@ static void arm_spe_perf_aux_output_end(struct perf_output_handle *handle)
>  
>  static void arm_spe_pmu_disable_and_drain_local(void)
>  {
> -	/* Disable profiling at EL0 and EL1 */
> +	/*
> +	 * To prevent the CONSTRAINED UNPREDICTABLE behavior of either writing
> +	 * to memory after the buffer is disabled, or SPE reporting an access
> +	 * not allowed event, we must disable sampling before draining the
> +	 * buffer.
> +	 */
>  	write_sysreg_s(0, SYS_PMSCR_EL1);
>  	isb();
>  
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

I've been trying to figure out if we need an ISB here to order clearing the
service bit before the PMBLIMITR_EL1 write in arm_spe_perf_aux_output_begin().

arm_spe_perf_aux_output_begin() is called only when the buffer is full, and this
rules out the event having the discard attribute (buffer management events are
not generated in discard mode).

If a new buffer cannot be allocated (perf_aux_output_begin() returns NULL), then
PMBLIMITR_EL1.E remains 0, so no need to order the two writes.

The only other path remaining in arm_spe_perf_aux_output_begin() is
reprogramming the buffer, in which case there's an ISB before the write to
PMBLIMITR_EL1.

In conclusion, I think it's correct not to have an ISB here.

> +
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

Before:

arm_spe_pmu_buf_get_fault_act:
  <drain buffer>
  ISB
arm_spe_pmu_disable_and_drain_local:
  PMSCR_EL1 = 0
  ISB		# disables profiling
  <drain buffer>
  PMBLIMITR_EL1=0
PMBSR_EL1=0
ERET		# synchronizes the two writes above

Now:

arm_spe_pmu_buf_get_fault_act:
  <drain buffer>
  ISB
PMBLIMITR_EL1=0
ISB 		# disables profiling
PMBSR_EL1=0
PMSCR_EL1=0
ERET		# synchronizes the two writes above

This looks correct to me.

Thanks,
Alex

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
