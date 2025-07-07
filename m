Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0D11D5AB7;
	Mon,  7 Jul 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902641; cv=none; b=T9BooskVuFnfx29N114pmGnls+b1oOth0mONx5wDjG+Rm5JKI21ZEfxKvK2GScckIsb4oKAQXaYBpwJtAzyHLu/afc2iTYVV9mVVIVeTlYLHs2IoBGB0xH8QoPZsKI1lE9Gkrr3z0wHCmVmPOtqVNYM+y8XoFAsEgKfBVdaSfKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902641; c=relaxed/simple;
	bh=GEvLhH+HdHGBlGq1TRR0in6YZ+bDbe9WfJqwHXAUymM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bzE9O3UMOVmSVd61C7cuM0CuFmAFgRqKddLOxuG/6HcSJgX0nm709KDLyy+ufsPw/RaBwWm61X5D3bukoLhyqhJqOuW0hM4v48nhzXaLAyLGbk4nkqe9flnMShKu3eEgShYDic883Bb6Xl3SB0i6Xjjr4cDFsspHX7l8TK5z0ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA592168F;
	Mon,  7 Jul 2025 08:36:59 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1F443F77D;
	Mon,  7 Jul 2025 08:37:11 -0700 (PDT)
Date: Mon, 7 Jul 2025 16:37:10 +0100
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
Message-ID: <20250707153710.GB2182465@e132581.arm.com>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
 <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>

On Mon, Jul 07, 2025 at 12:39:57PM +0100, James Clark wrote:

[...]

> > > @@ -661,16 +666,24 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > >   	 */
> > >   	irq_work_run();
> > > +	/*
> > > +	 * arm_spe_pmu_buf_get_fault_act() already drained, and PMBSR_EL1.S == 1
> > > +	 * means that StatisticalProfilingEnabled() == false. So now we can
> > > +	 * safely disable the buffer.
> > > +	 */
> > > +	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
> > > +	isb();
> > > +
> > > +	/* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
> > > +	write_sysreg_s(0, SYS_PMBSR_EL1);
> > > +
> > 
> > An important thing is about sequence:
> > As described in arm_spe_pmu_disable_and_drain_local(), should we always
> > clear ELs bits in PMSCR_EL1 before clear PMBLIMITR_EL1.E bit? As a
> > reference, we could see TRBE always clear ELx bits before disable trace
> > buffer.
> > 
> > And a trivial flaw:
> > 
> > If the TRUNCATED flag has been set, the irq_work_run() above runs the
> > IRQ work to invoke the arm_spe_pmu_stop() to disable trace buffer, which
> > clear SYS_PMBLIMITR_EL1.E bit. This is why the current code does not
> > explictly clear SYS_PMBLIMITR_EL1.E bit.
> > 
> > With this patch, the interrupt handler will clear SYS_PMBLIMITR_EL1.E
> > bit twice for a trunacated case.
> 
> I suppose that's a rarer case that we don't necessarily have to optimize
> for. I don't think it will do any harm, but is it even possible to avoid?
> 
> There are already some other duplications in the driver, for example in
> arm_spe_pmu_stop() we call arm_spe_pmu_disable_and_drain_local() which
> drains, and then arm_spe_pmu_buf_get_fault_act() which also drains again.

If we don't need to worry about duplicated operations in the truncated
case, then for easier maintenance and better readability, I'm wondering
if we could simplify the interrupt handler as follows:

    arm_spe_pmu_irq_handler()
    {
        ...

        act = arm_spe_pmu_buf_get_fault_act(handle);
        if (act == SPE_PMU_BUF_FAULT_ACT_SPURIOUS)
                return IRQ_NONE;

        arm_spe_pmu_disable_and_drain_local();

        /* Status can be cleared now that PMBLIMITR_EL1.E == 0 */
        write_sysreg_s(0, SYS_PMBSR_EL1);
        isb();

        switch (act) {
            ...
        }
    }

This approach complies with DEN0154 - we must clear PMBLIMITR_EL1.E
before writing to other SPE system registers (e.g., PMBSR).

The reason for using arm_spe_pmu_disable_and_drain_local() is that we
first need to disable profiling instructions by clearing PMSCR_EL1/EL2,
and then is it safe to disable the profiling buffer.

[...]

> > >   	case SPE_PMU_BUF_FAULT_ACT_OK:
> > >   		/*
> > > @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > >   		 * PMBPTR might be misaligned, but we'll burn that bridge
> > >   		 * when we get to it.
> > >   		 */
> > > -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
> > > +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
> > >   			arm_spe_perf_aux_output_begin(handle, event);
> > > -			isb();
> > 
> > I am a bit suspecious we can remove this isb().
> > 
> > As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
> > after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
> > for this?
>
> Wasn't this isb() to separate the programming of the registers with the
> status register clear at the end of this function to enable profiling?

Enabling profiling buffer followed an isb() is not only for separating
other register programming.

As described in section D17.9, Synchronization and Statistical Profiling
in Arm ARM:

  "A Context Synchronization event guarantees that a direct write to a
  System register made by the PE in program order before the Context
  synchronization event are observable by indirect reads and indirect
  writes of the same System register made by a profiling operation
  relating to a sampled operation in program order after the Context
  synchronization event."

My understanding is: after the ARM SPE profiling is enabled, the
followed ISB is a Synchronization to make sure the system register
values are observed by SPE. And we cannot rely on ERET, especially if
we are tracing the kernel mode.

Thanks,
Leo

> But now we enable profiling with the write to PMBLIMITR_EL1 in
> arm_spe_perf_aux_output_begin() and the last thing here is the ERET. That's
> specifically mentioned as enough synchronization in PKLXF:
> 
>   In the common case, this is an ERET instruction that returns to a
>   different Exception level where tracing is allowed.
> 
> > > -		}
> > >   		break;
> > >   	case SPE_PMU_BUF_FAULT_ACT_SPURIOUS:
> > >   		/* We've seen you before, but GCC has the memory of a sieve. */
> > >   		break;
> > >   	}
> > > -	/* The buffer pointers are now sane, so resume profiling. */
> > > -	write_sysreg_s(0, SYS_PMBSR_EL1);
> > >   	return IRQ_HANDLED;
> > >   }
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > > 
> 
