Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AED1345CD0;
	Fri, 30 Jan 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804683; cv=none; b=eekwfxKXSggYqc0vn8hIqkel/kROYX5+Wa74ZdfU8O9DG+RNKX60aDiL+AzOZuyuC70woa4cvllDWKEOz4ULbu0iMM2IJefxbWPmczI/E1YStYIRAeKxY4xuDSQBbdU2Q48Zw/oezHPoWCjLpLb0addZeJgiBxbEuKOsKcVxFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804683; c=relaxed/simple;
	bh=TkqzMYDMbt0vc/MGSw8V1QU5W25D2LpTNrkNwITlieM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eoPBA56uxlZ9JlYZWGi/rommHmTjybf26ne35RwyJmYlfF4SZ+5orneOIEyxx88aZsUdDXAb2tqEalULTiI0+G8JNLA13JpCFYKFTOixoNEzh35K5/F0ClSlrqbSbj2+RBcn9UmavytVyMtNXY58D0blb3MFJh/GsvId6XV6vRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE40B153B;
	Fri, 30 Jan 2026 12:24:33 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDC243F5CA;
	Fri, 30 Jan 2026 12:24:39 -0800 (PST)
Date: Fri, 30 Jan 2026 20:24:37 +0000
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
Subject: Re: [PATCH] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <20260130202437.GB3481290@e132581.arm.com>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>

On Fri, Jan 23, 2026 at 04:03:53PM +0000, James Clark wrote:
> The Arm ARM known issues document [1] states that the architecture will
> be relaxed so that the profiling buffer must be correctly configured
> when ProfilingBufferEnabled() && !SPEProfilingStopped() &&
> PMBLIMITR_EL1.FM != DISCARD:
> 
>   R24557
> 
>   While the Profiling Buffer is enabled, profiling is not stopped, and
>   Discard mode is not enabled, all of the following must be true:
> 
>   * The current write pointer must be at least one sample record below
>     the write limit pointer.
> 
> The same relaxation also says that writes may be completely ignored:
> 
>   When the Profiling Buffer is enabled, profiling is not stopped, and
>   Discard mode is not enabled, the PE might ignore a direct write to any
>   of the following Profiling Buffer registers, other than a direct write
>   to PMBLIMITR_EL1 that clears PMBLIMITR_EL1.E from 1 to 0:
> 
>   * The current write pointer, PMBPTR_EL1.
>   * The Limit pointer, PMBLIMITR_EL1.
>   * PMBSR_EL1.
> 
> When arm_spe_pmu_start() occurs, SPEProfilingStopped() is false
> (PMBSR_EL1.S == 0) meaning that the write to PMBLIMITR_EL1 now becomes
> the point where the buffer configuration must be correct by, rather than
> the "When profiling becomes enabled" (StatisticalProfilingEnabled())
> from the old rule which is much later when PMSCR_EL1 is written.
> 
> If the writes to PMBLIMITR_EL1 and PMBPTR_EL1 are re-ordered then a
> misconfigured state could be observed, resulting in a buffer management
> event. Or the write to PMBPTR_EL1 could be ignored.
> 
> Fix it by adding an isb() after the write to PMBPTR_EL1 to ensure that
> this completes before enabling the buffer.

Makes sense.

> To avoid redundant isb()s in the IRQ handler, remove the isb() between
> the PMBLIMITR_EL1 write and SYS_PMBSR_EL1 as it doesn't matter which
> order these happen in now that all the previous configuration is covered
> by the new isb().

The isb() in the interrupt handler is useful and should not be removed.

See the sequence in the interrupt handler:

    arm_spe_perf_aux_output_begin() {
        write_sysreg_s(base, SYS_PMBPTR_EL1);

        // Ensure the write pointer is ordered
        isb();

        write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
    }

    // Ensure the limit pointer is ordered
    isb();

    // Profiling is enabled:
    //   (PMBLIMITR_EL1.E==1) && (PMBSR_EL1.S==0) && (not discard mode)
    write_sysreg_s(0, SYS_PMBSR_EL1);

The first isb() ensures that the write pointer update is ordered.  The
second isb() ensures that the limit pointer is visible before profiling
is enabled by clearing the PMBSR_EL1.S bit.  When handling a normal
maintenance interrupt, PMBSR_EL1.S is set by the SPE to stop tracing,
while PMBLIMITR_EL1.E remains set.  Clearing PMBSR_EL1.S therefore
effectively re-enables profiling.

Since the second isb() is a synchronization for both the write pointer
and the limit pointer before profiling is enabled, it could be argued
that the first isb() is redundant in the interrupt handling.  However,
the first isb() is crucial for the arm_spe_pmu_start() case, and keeping
it in the interrupt handler does no harm and simplifies code maintenance.

In short, if preserves the second isb() instead of removing it, the
change looks good to me.

Thanks,
Leo

> This issue is only present in arm_spe_pmu_start() and not in the IRQ
> handler because SPEProfilingStopped() is true in the IRQ handler. Jumps
> to the out_write_limit label will skip the isb() but this is ok as they
> only happen if discard mode is set or the buffer isn't enabled so
> correct configuration is not required.
> 
> [1]: https://developer.arm.com/documentation/102105/latest/
> 
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> A previous version of this was posted here [1] bundled with other
> changes to support running in a guest. Since then the known issues doc
> linked in the commit message has been released so this is a resend of
> only the critical part that also needs to be fixed for hosts.
> 
> A redundant isb() has also been removed in this version which is not
> present in the previous version.
> 
> [1]: https://lore.kernel.org/linux-arm-kernel/20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org/
> ---
>  drivers/perf/arm_spe_pmu.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 4801115f2b54..62ae409fd5b4 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -639,6 +639,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>  	limit += (u64)buf->base;
>  	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>  	write_sysreg_s(base, SYS_PMBPTR_EL1);
> +	isb();
>  
>  out_write_limit:
>  	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> @@ -780,10 +781,8 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
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
> 
> ---
> base-commit: c072629f05d7bca1148ab17690d7922a31423984
> change-id: 20260123-james-spe-relaxation-d6621c7a68ff
> 
> Best regards,
> -- 
> James Clark <james.clark@linaro.org>
> 
