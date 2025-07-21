Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA851DF754;
	Mon, 21 Jul 2025 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753111300; cv=none; b=awuop+2FPywSVKJi4ME1EhrVt5Xj6LcyU3Gn1cPX11DqKV79sDkuqXNNAYCLl0aTzUdSW8tr0J4q/TctNBq1GCEAu/pGRu1OisKvItgXwBm08Ahbs0TJG0UzHT8myslA9BOLN08b6//UN0k9WJCfV5GOUwx9F/uOVqlEvVVZtmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753111300; c=relaxed/simple;
	bh=nBeLfk14javg9SOP+fdU5fQH+x2VW066F+emh6tP8+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhiDS6uiD1YnB8ApcSwejWm0s2VWIsM7XTj5qbqNQWpXLKLVCutddDAisuN5HGvNVwC3RkAuNi1VU38lj15OYA8mqbv+Q0Co53UvlgDSdHj6a2Br4xEDjxhA1G2/aMb3mvljEYe1YTIg/UYT1O3Z9PER8eYOo1k1hIyvKaqAln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82349153B;
	Mon, 21 Jul 2025 08:21:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C80A33F6A8;
	Mon, 21 Jul 2025 08:21:36 -0700 (PDT)
Date: Mon, 21 Jul 2025 16:21:34 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Alexandru Elisei <alexandru.elisei@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf: arm_spe: Disable buffer before writing to
 PMBPTR_EL1 or PMBSR_EL1
Message-ID: <20250721152134.GF3137075@e132581.arm.com>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-2-52a2cd223d00@linaro.org>
 <20250704155016.GI1039028@e132581.arm.com>
 <b77f12e7-ea3f-4c57-9706-ff8e32721cc8@linaro.org>
 <20250707153710.GB2182465@e132581.arm.com>
 <aG4_uYJgpMXo3QHQ@raptor>
 <20250714085849.GC1093654@e132581.arm.com>
 <0c53164a-306a-4cb7-9085-bba8985c32e7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c53164a-306a-4cb7-9085-bba8985c32e7@linaro.org>

On Mon, Jul 21, 2025 at 02:20:15PM +0100, James Clark wrote:

[...]

> > > Thought about this some more.
> > > 
> > > Before:
> > > 
> > > arm_spe_pmu_buf_get_fault_act:
> > >    <drain buffer>
> > >    ISB
> > > arm_spe_perf_aux_output_begin:
> > >    PMBLIMITR_EL1.E = 1
> > > ISB
> > > PMBSR_EL1.S = 0
> > > ERET
> > > 
> > > Now:
> > > 
> > > PMBLIMITR_EL1 = 0
> > > ISB
> > > 
> > > PMBSR_EL1.S = 0
> > > arm_spe_perf_aux_output_begin:
> > >    ISB
> > >    PMBLIMITR_EL1.E = 1
> > > ERET
> > > 
> > > I don't see much of a difference between the two sequences - the point after
> > > which we can be sure that profiling is enabled remains the ERET from the
> > > exception return.  The only difference is that, before this change, the ERET
> > > synchronized clearing the PMBSR_EL1.S bit, now it synchronizes setting the
> > > PMBLIMITR_EL1.E bit.
> > > 
> > > Thoughts?
> > 
> > To make the discussion easier, I'll focus on the trace enabling flow
> > in this reply.
> > 
> > My understanding of a sane flow would be:
> > 
> >    arm_spe_pmu_irq_handler() {
> >      arm_spe_perf_aux_output_begin() {
> >            SYS_PMBPTR_EL1 = base;
> > 
> >            ISB // Synchronization between SPE register setting and
> >                // enabling profiling buffer.
> >            PMBLIMITR_EL1.E = 1;
> >      }
> >      ISB // Context synchronization event to ensure visibility to SPE
> >    }
> > 
> >    ... start trace ... (Bottom half, e.g., softirq, etc)
> > 
> >    ERET
> > 
> > In the current code, arm_spe_perf_aux_output_begin() is followed by an
> > ISB, which serves as a context synchronization event to ensure
> > visibility to the SPE. After that, it ensures that the trace unit will
> > function correctly.
> > 
> 
> But I think Alex's point is that in the existing code the thing that finally
> enables trace (PMBSR_EL1.S = 0) isn't followed by an isb(), only an ERET. So
> the new flow isn't any different in that regard.

Thanks for explanation.

> > I understand that the Software Usage PKLXF recommends using an ERET as
> > the synchronization point. However, between enabling the profiling
> > buffer and the ERET, the kernel might execute other operations (e.g.,
> > softirqs, tasklets, etc.).
> 
> Isn't preemption disabled? Surely that's not possible. Even if something did
> run it wouldn't be anything that touches the SPE registers, and we're sure
> there's an isb() between setting up the buffer and the final PMBLIMITR_EL1.E
> = 1

Yes, bottom half runs in preemtion disabled state. See:

  el1_interrupt() -> __el1_irq() -> irq_exit_rcu() -> invoke_softirq()

In some cases, sotfirq and tasklet might even cause long latency (I
believe it can be milliseconds or even longer), this is why ftrace
"irqsoff" tracer is used to profile latency caused by irq off state.

Bottom half does not modify SPE registsers, but it can be a long road
between enabling SPE trace and ERET.

> > Therefore, it seems to me that using ERET as the synchronization point
> > may be too late. This is why I think we should keep an ISB after
> > arm_spe_perf_aux_output_begin().
> 
> Wouldn't that make the ERET too late even in the current code then? But I
> think we're agreeing there's no issue there?

I would say ERET is too late for current code as well.

Thanks,
Leo
