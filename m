Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1991F09B6;
	Wed, 30 Jul 2025 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753869033; cv=none; b=m9SPrgfXUYR28FAngZa5oI5aAGQh5bcLFMdf7quqBSvLJ4Gn97N3X8atccslT0CEHbm2WSm3t7ozaUbQ05zyvQsZmn3KJmcP6ViqA6B1nov04jX5U3ZpjNp9YjsHtgJnWZqVpw2P1Laj2FY78hkrC55eDohZABWRQhaj6T4GNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753869033; c=relaxed/simple;
	bh=XSx22nMmjlxza109AyQhc67lUcWbbXFFyCOm19DzJio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gmSk1unZNQ0/QtaWUWa8yTxzR3pbFedt9NIbKCFjF9oAuicOuHzBLAJiYORn0evi3UyUdBivbtlSWCof4gU3daIhiX2ZIc0KEmEhgaBIJkjMGQDMC9JABzGhREH2gKfg4PF33vbb26HS8mv14ub3dH/M2toHXamk7n0Mb38ofCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 161511BC0;
	Wed, 30 Jul 2025 02:50:22 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E04AD3F7BD;
	Wed, 30 Jul 2025 02:50:27 -0700 (PDT)
Date: Wed, 30 Jul 2025 10:50:17 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>, Will Deacon <will@kernel.org>,
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
Message-ID: <aInqMPBzi7YnIxOB@raptor>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
 <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
 <20250707153710.GB2182465@e132581.arm.com>
 <aG4_uYJgpMXo3QHQ@raptor>
 <20250714085849.GC1093654@e132581.arm.com>
 <0c53164a-306a-4cb7-9085-bba8985c32e7@linaro.org>
 <20250721152134.GF3137075@e132581.arm.com>
 <10e9cb52-2476-4c13-8632-0a85830f98dd@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10e9cb52-2476-4c13-8632-0a85830f98dd@linaro.org>

Hi Leo, James,

On Tue, Jul 22, 2025 at 03:46:11PM +0100, James Clark wrote:
> 
> 
> On 21/07/2025 4:21 pm, Leo Yan wrote:
> > On Mon, Jul 21, 2025 at 02:20:15PM +0100, James Clark wrote:
> > 
> > [...]
> > 
> > > > > Thought about this some more.
> > > > > 
> > > > > Before:
> > > > > 
> > > > > arm_spe_pmu_buf_get_fault_act:
> > > > >     <drain buffer>
> > > > >     ISB
> > > > > arm_spe_perf_aux_output_begin:
> > > > >     PMBLIMITR_EL1.E = 1
> > > > > ISB
> > > > > PMBSR_EL1.S = 0
> > > > > ERET
> > > > > 
> > > > > Now:
> > > > > 
> > > > > PMBLIMITR_EL1 = 0
> > > > > ISB
> > > > > 
> > > > > PMBSR_EL1.S = 0
> > > > > arm_spe_perf_aux_output_begin:
> > > > >     ISB
> > > > >     PMBLIMITR_EL1.E = 1
> > > > > ERET
> > > > > 
> > > > > I don't see much of a difference between the two sequences - the point after
> > > > > which we can be sure that profiling is enabled remains the ERET from the
> > > > > exception return.  The only difference is that, before this change, the ERET
> > > > > synchronized clearing the PMBSR_EL1.S bit, now it synchronizes setting the
> > > > > PMBLIMITR_EL1.E bit.
> > > > > 
> > > > > Thoughts?
> > > > 
> > > > To make the discussion easier, I'll focus on the trace enabling flow
> > > > in this reply.
> > > > 
> > > > My understanding of a sane flow would be:
> > > > 
> > > >     arm_spe_pmu_irq_handler() {
> > > >       arm_spe_perf_aux_output_begin() {
> > > >             SYS_PMBPTR_EL1 = base;
> > > > 
> > > >             ISB // Synchronization between SPE register setting and
> > > >                 // enabling profiling buffer.
> > > >             PMBLIMITR_EL1.E = 1;
> > > >       }
> > > >       ISB // Context synchronization event to ensure visibility to SPE
> > > >     }
> > > > 
> > > >     ... start trace ... (Bottom half, e.g., softirq, etc)
> > > > 
> > > >     ERET
> > > > 
> > > > In the current code, arm_spe_perf_aux_output_begin() is followed by an
> > > > ISB, which serves as a context synchronization event to ensure
> > > > visibility to the SPE. After that, it ensures that the trace unit will
> > > > function correctly.
> > > > 
> > > 
> > > But I think Alex's point is that in the existing code the thing that finally
> > > enables trace (PMBSR_EL1.S = 0) isn't followed by an isb(), only an ERET. So
> > > the new flow isn't any different in that regard.
> > 
> > Thanks for explanation.
> > 
> > > > I understand that the Software Usage PKLXF recommends using an ERET as
> > > > the synchronization point. However, between enabling the profiling
> > > > buffer and the ERET, the kernel might execute other operations (e.g.,
> > > > softirqs, tasklets, etc.).
> > > 
> > > Isn't preemption disabled? Surely that's not possible. Even if something did
> > > run it wouldn't be anything that touches the SPE registers, and we're sure
> > > there's an isb() between setting up the buffer and the final PMBLIMITR_EL1.E
> > > = 1
> > 
> > Yes, bottom half runs in preemtion disabled state. See:
> > 
> >    el1_interrupt() -> __el1_irq() -> irq_exit_rcu() -> invoke_softirq()
> > 
> > In some cases, sotfirq and tasklet might even cause long latency (I
> > believe it can be milliseconds or even longer), this is why ftrace
> > "irqsoff" tracer is used to profile latency caused by irq off state.
> > 
> > Bottom half does not modify SPE registsers, but it can be a long road
> > between enabling SPE trace and ERET.
> > 
> > > > Therefore, it seems to me that using ERET as the synchronization point
> > > > may be too late. This is why I think we should keep an ISB after
> > > > arm_spe_perf_aux_output_begin().
> > > 
> > > Wouldn't that make the ERET too late even in the current code then? But I
> > > think we're agreeing there's no issue there?
> > 
> > I would say ERET is too late for current code as well.
> > 
> > Thanks,
> > Leo

Thanks for the explanation and the analysis. I think we were looking at the
patch from different point of views: I was interested in not changing the
current behaviour, you were saying that the existing behaviour can be improved
upon.

> Ok I get it now. The point is that there is stuff in between the return in
> the SPE IRQ handler and the actual ERET. If someone is interested in
> sampling the kernel then they might miss sampling a small amount of that.
> 
> It's not a correctness thing, just reducing potential gaps in the samples. I
> can add another commit to add it, but it doesn't look like it would be a
> fixes commit either, just an improvement. And the same issue applies to the
> existing code too.

I agree here, this looks on an improvement on existing behaviour. I would keep
it as a patch separate from this series, as it's not a fix, and it's not related
to to the rules from DEN0154.

Thanks,
Alex
