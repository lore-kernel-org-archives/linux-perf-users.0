Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485302E6CD9;
	Mon,  2 Feb 2026 18:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057760; cv=none; b=mpBtxjFajHRlpeBqMwTCgYjb9qqPH+O9hWeZdnitnwohrV+hfX93fGjcYEMdIvdSBHFYYH7o4F34mIoDzy04D/ylVjSepzEJHRcfn1lFRixY00C2hzBFtt8+8IrHw8vNdyZd+q+OpdLUdmZRPdh8WUOMv55meREPGBwaQSAHWgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057760; c=relaxed/simple;
	bh=cwutKbyuAeWA77YUD7Tj9VMNYkJYyI6EHKM68bUVygQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0Vy9HfXKE2TBwkxSMHWQ0C+EsepOSwfaPY7O7BzoX9gVLFfP3DSNQ/VdLJvp+PeSMCYxEe+7Zu8qXEJcag9vJ+l1f8qe4pTQGxuOgljcY0dE7VdCJQFf6afMb0T+F1Rmi8pVR3/r65/3ncnLX5VIj7Ez3w/dBMO2KAX9Cq6v/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACBCC339;
	Mon,  2 Feb 2026 10:42:30 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F3B03F778;
	Mon,  2 Feb 2026 10:42:36 -0800 (PST)
Date: Mon, 2 Feb 2026 18:42:34 +0000
From: Leo Yan <leo.yan@arm.com>
To: Will Deacon <will@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20260202184234.GC3481290@e132581.arm.com>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <20260130202437.GB3481290@e132581.arm.com>
 <aYDWpc8Jh4SqMcD5@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYDWpc8Jh4SqMcD5@willie-the-truck>

On Mon, Feb 02, 2026 at 04:53:57PM +0000, Will Deacon wrote:

[...]

> > > To avoid redundant isb()s in the IRQ handler, remove the isb() between
> > > the PMBLIMITR_EL1 write and SYS_PMBSR_EL1 as it doesn't matter which
> > > order these happen in now that all the previous configuration is covered
> > > by the new isb().
> > 
> > The isb() in the interrupt handler is useful and should not be removed.
> > 
> > See the sequence in the interrupt handler:
> > 
> >     arm_spe_perf_aux_output_begin() {
> >         write_sysreg_s(base, SYS_PMBPTR_EL1);
> > 
> >         // Ensure the write pointer is ordered
> >         isb();
> > 
> >         write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> >     }
> > 
> >     // Ensure the limit pointer is ordered
> >     isb();
> > 
> >     // Profiling is enabled:
> >     //   (PMBLIMITR_EL1.E==1) && (PMBSR_EL1.S==0) && (not discard mode)
> >     write_sysreg_s(0, SYS_PMBSR_EL1);
> > 
> > The first isb() ensures that the write pointer update is ordered.  The
> > second isb() ensures that the limit pointer is visible before profiling
> > is enabled by clearing the PMBSR_EL1.S bit.  When handling a normal
> > maintenance interrupt, PMBSR_EL1.S is set by the SPE to stop tracing,
> > while PMBLIMITR_EL1.E remains set.  Clearing PMBSR_EL1.S therefore
> > effectively re-enables profiling.
> > 
> > Since the second isb() is a synchronization for both the write pointer
> > and the limit pointer before profiling is enabled, it could be argued
> > that the first isb() is redundant in the interrupt handling.  However,
> > the first isb() is crucial for the arm_spe_pmu_start() case, and keeping
> > it in the interrupt handler does no harm and simplifies code maintenance.
> > 
> > In short, if preserves the second isb() instead of removing it, the
> > change looks good to me.
> 
> I'm not sure I follow your logic as to why both ISBs are required, but
> I'd have thought that if perf_aux_output_begin() fails when called from
> arm_spe_perf_aux_output_begin() in the irqhandler, we need the ISB
> because we're going to clear pmblimitr_el1 to 0 and that surely has
> to be ordered before clearing pmbsr?

I think the ISB after arm_spe_perf_aux_output_begin() in the irq
handler is required for both the failure and success cases.

For a normal maintenance interrupt, an ISB is inserted between writing
PMBLIMITR_EL1 and PMBSR_EL1 to ensure that a valid limit write is
visible before tracing restarts.  This ensures that the following
conditions are safely met:

  "While the Proﬁling Buﬀer is enabled, proﬁling is not stopped, and
   Discard mode is not enabled, all of the following must be true:

   The current write pointer must be at least one sample record below
   the write limit pointer.

   PMBPTR_EL1.PTR[63:56] must equal PMBLIMITR_EL1.LIMIT[63:56],
   regardless of the value of the applicable TBI bit."

Thanks,
Leo
