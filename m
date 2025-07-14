Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8310723BD1D;
	Mon, 14 Jul 2025 08:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752483534; cv=none; b=h7nKHAt0QJdLnsu+YGchLFiPMcVym12oop75dFwBurdWUnUSKi3lajx1bVHZNUt0EkkWKcxxsCHuQaO636f98LF71l7dN+wu045x+0sMDADifWAi76LT0E99123DYvP1IN5OivqbLnRyhLbeZRgXwqKxPLb/dE7hLDcbjRHZ+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752483534; c=relaxed/simple;
	bh=Pbra00ApgwHXEuR8gnZIa2ZhDS08TIfHcQUZpvP/4JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYOvNhmH+3HMMkY/ajg/yTxc/9/vVxJf/t5b0UaIpmnaKfhBy6H+nK6+AGmVwRj51tcBOOO22stJyaFIqiUgaWLHYqL4oalaGxBrHzjKvcyPajJ1scOgiQCHXnCNs6zVydvIQoz7p7C4RqV8EvtFhl7YUCLDaae3owZicWUYJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35E5C1764;
	Mon, 14 Jul 2025 01:58:42 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1528E3F694;
	Mon, 14 Jul 2025 01:58:50 -0700 (PDT)
Date: Mon, 14 Jul 2025 09:58:49 +0100
From: Leo Yan <leo.yan@arm.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
Message-ID: <20250714085849.GC1093654@e132581.arm.com>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
 <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
 <20250707153710.GB2182465@e132581.arm.com>
 <aG4_uYJgpMXo3QHQ@raptor>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG4_uYJgpMXo3QHQ@raptor>

Hi Alexandru,

On Wed, Jul 09, 2025 at 11:08:57AM +0100, Alexandru Elisei wrote:

[...]

> > > > >   	case SPE_PMU_BUF_FAULT_ACT_OK:
> > > > >   		/*
> > > > > @@ -679,18 +692,14 @@ static irqreturn_t arm_spe_pmu_irq_handler(int irq, void *dev)
> > > > >   		 * PMBPTR might be misaligned, but we'll burn that bridge
> > > > >   		 * when we get to it.
> > > > >   		 */
> > > > > -		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED)) {
> > > > > +		if (!(handle->aux_flags & PERF_AUX_FLAG_TRUNCATED))
> > > > >   			arm_spe_perf_aux_output_begin(handle, event);
> > > > > -			isb();
> > > > 
> > > > I am a bit suspecious we can remove this isb().
> > > > 
> > > > As a reference to the software usage PKLXF in Arm ARM (DDI 0487 L.a),
> > > > after enable TRBE trace unit, an ISB is mandatory. Maybe check a bit
> > > > for this?
> > >
> > > Wasn't this isb() to separate the programming of the registers with the
> > > status register clear at the end of this function to enable profiling?
> > 
> > Enabling profiling buffer followed an isb() is not only for separating
> > other register programming.
> > 
> > As described in section D17.9, Synchronization and Statistical Profiling
> > in Arm ARM:
> > 
> >   "A Context Synchronization event guarantees that a direct write to a
> >   System register made by the PE in program order before the Context
> >   synchronization event are observable by indirect reads and indirect
> >   writes of the same System register made by a profiling operation
> >   relating to a sampled operation in program order after the Context
> >   synchronization event."
> > 
> > My understanding is: after the ARM SPE profiling is enabled, the
> > followed ISB is a Synchronization to make sure the system register
> > values are observed by SPE. And we cannot rely on ERET, especially if
> > we are tracing the kernel mode.
> 
> Thought about this some more.
> 
> Before:
> 
> arm_spe_pmu_buf_get_fault_act:
>   <drain buffer>
>   ISB
> arm_spe_perf_aux_output_begin:
>   PMBLIMITR_EL1.E = 1
> ISB
> PMBSR_EL1.S = 0
> ERET
> 
> Now:
> 
> PMBLIMITR_EL1 = 0
> ISB
> 
> PMBSR_EL1.S = 0
> arm_spe_perf_aux_output_begin:
>   ISB
>   PMBLIMITR_EL1.E = 1
> ERET
> 
> I don't see much of a difference between the two sequences - the point after
> which we can be sure that profiling is enabled remains the ERET from the
> exception return.  The only difference is that, before this change, the ERET
> synchronized clearing the PMBSR_EL1.S bit, now it synchronizes setting the
> PMBLIMITR_EL1.E bit.
> 
> Thoughts?

To make the discussion easier, I'll focus on the trace enabling flow
in this reply.

My understanding of a sane flow would be:

  arm_spe_pmu_irq_handler() {
    arm_spe_perf_aux_output_begin() {
          SYS_PMBPTR_EL1 = base;

          ISB // Synchronization between SPE register setting and
              // enabling profiling buffer.
          PMBLIMITR_EL1.E = 1;
    }
    ISB // Context synchronization event to ensure visibility to SPE
  }

  ... start trace ... (Bottom half, e.g., softirq, etc)

  ERET

In the current code, arm_spe_perf_aux_output_begin() is followed by an
ISB, which serves as a context synchronization event to ensure
visibility to the SPE. After that, it ensures that the trace unit will
function correctly.

I understand that the Software Usage PKLXF recommends using an ERET as
the synchronization point. However, between enabling the profiling
buffer and the ERET, the kernel might execute other operations (e.g.,
softirqs, tasklets, etc.).

Therefore, it seems to me that using ERET as the synchronization point
may be too late. This is why I think we should keep an ISB after
arm_spe_perf_aux_output_begin().

Thanks,
Leo
