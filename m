Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFCE1400C;
	Mon,  2 Feb 2026 16:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770051243; cv=none; b=oOOSYk6o0aBFNB+3LECgo0OSjE0+KLLcI5DldMDbYwPxDnFY1+f3qN9mIZx/P2XKchaSFgbuWBTZ8OWUZF4NjEYY7byuL9hh+uP9MVw5mKRBCI/iGWQxm4/K+nZCWJ/Q54lLljJTBc6sW6mdo02yqeJ7t4JGELOeYv2d66aCaOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770051243; c=relaxed/simple;
	bh=ewFJ7lIw0mhiwj4TSfTYPWEKSHxdvWRNCspn7DwLvv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Inps2XK+RH1oR5HRtQY8VEtBDUBYLWJsNrjDqbqWzXA+MqXbk0fdWxLiE1ttxBHyeRBm3aVzJk8l4TjMZYBQE/oBY+JX+2KGwZIzx0/faslfTJwUd+ndcTmzSuXhOZGpiMkdTVqcxLgHUILc1pknHCj/Ml0YcDF5T3/3/SoZ1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q9U8RKjY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q9U8RKjY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C9FC116C6;
	Mon,  2 Feb 2026 16:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770051242;
	bh=ewFJ7lIw0mhiwj4TSfTYPWEKSHxdvWRNCspn7DwLvv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q9U8RKjYB1tzrvCrgN9afni5xXdEzT5RQ/+pjQUmEOb9zLuvqDCv1Nef3VxzTJ2ms
	 fyjTvE+F3qjgD3HF1RBId1ZWneCaEIXNsSE7vn0XaWPu62s68DIqx0QwmGVxU7v65i
	 arO7mNom+PH8kQYPkTWXb8pAg0pP1iIm57i4i+KvJoeF5Hn+6zicjv75Fxy/ACZ25Y
	 wPNmX7eHGPAsBig5Isf+7S2QHxKYMa/XkWH173jx4y4f1WNRJKD+6bV5o1dBMx/VKG
	 3e90A92oHAFFWk5klfyM6PuHw1lZZeaJ+7jTFNZyXXPnJl8EncMmD9JIXIEmzpNvGc
	 3Pl2FVlWutSMQ==
Date: Mon, 2 Feb 2026 16:53:57 +0000
From: Will Deacon <will@kernel.org>
To: Leo Yan <leo.yan@arm.com>
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
Message-ID: <aYDWpc8Jh4SqMcD5@willie-the-truck>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <20260130202437.GB3481290@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130202437.GB3481290@e132581.arm.com>

On Fri, Jan 30, 2026 at 08:24:37PM +0000, Leo Yan wrote:
> On Fri, Jan 23, 2026 at 04:03:53PM +0000, James Clark wrote:
> > The Arm ARM known issues document [1] states that the architecture will
> > be relaxed so that the profiling buffer must be correctly configured
> > when ProfilingBufferEnabled() && !SPEProfilingStopped() &&
> > PMBLIMITR_EL1.FM != DISCARD:
> > 
> >   R24557
> > 
> >   While the Profiling Buffer is enabled, profiling is not stopped, and
> >   Discard mode is not enabled, all of the following must be true:
> > 
> >   * The current write pointer must be at least one sample record below
> >     the write limit pointer.
> > 
> > The same relaxation also says that writes may be completely ignored:
> > 
> >   When the Profiling Buffer is enabled, profiling is not stopped, and
> >   Discard mode is not enabled, the PE might ignore a direct write to any
> >   of the following Profiling Buffer registers, other than a direct write
> >   to PMBLIMITR_EL1 that clears PMBLIMITR_EL1.E from 1 to 0:
> > 
> >   * The current write pointer, PMBPTR_EL1.
> >   * The Limit pointer, PMBLIMITR_EL1.
> >   * PMBSR_EL1.

Oh nice, since when was it ok to relax the architecture and break
existing drivers that were perfectly fine before? The SPE spec's not
worth the paper it's written on...

Anyway, we're not changing the driver without a comment next to the new
isb() explaining the backwards incompatible change.

> > When arm_spe_pmu_start() occurs, SPEProfilingStopped() is false
> > (PMBSR_EL1.S == 0) meaning that the write to PMBLIMITR_EL1 now becomes
> > the point where the buffer configuration must be correct by, rather than
> > the "When profiling becomes enabled" (StatisticalProfilingEnabled())
> > from the old rule which is much later when PMSCR_EL1 is written.
> > 
> > If the writes to PMBLIMITR_EL1 and PMBPTR_EL1 are re-ordered then a
> > misconfigured state could be observed, resulting in a buffer management
> > event. Or the write to PMBPTR_EL1 could be ignored.
> > 
> > Fix it by adding an isb() after the write to PMBPTR_EL1 to ensure that
> > this completes before enabling the buffer.
> 
> Makes sense.
> 
> > To avoid redundant isb()s in the IRQ handler, remove the isb() between
> > the PMBLIMITR_EL1 write and SYS_PMBSR_EL1 as it doesn't matter which
> > order these happen in now that all the previous configuration is covered
> > by the new isb().
> 
> The isb() in the interrupt handler is useful and should not be removed.
> 
> See the sequence in the interrupt handler:
> 
>     arm_spe_perf_aux_output_begin() {
>         write_sysreg_s(base, SYS_PMBPTR_EL1);
> 
>         // Ensure the write pointer is ordered
>         isb();
> 
>         write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
>     }
> 
>     // Ensure the limit pointer is ordered
>     isb();
> 
>     // Profiling is enabled:
>     //   (PMBLIMITR_EL1.E==1) && (PMBSR_EL1.S==0) && (not discard mode)
>     write_sysreg_s(0, SYS_PMBSR_EL1);
> 
> The first isb() ensures that the write pointer update is ordered.  The
> second isb() ensures that the limit pointer is visible before profiling
> is enabled by clearing the PMBSR_EL1.S bit.  When handling a normal
> maintenance interrupt, PMBSR_EL1.S is set by the SPE to stop tracing,
> while PMBLIMITR_EL1.E remains set.  Clearing PMBSR_EL1.S therefore
> effectively re-enables profiling.
> 
> Since the second isb() is a synchronization for both the write pointer
> and the limit pointer before profiling is enabled, it could be argued
> that the first isb() is redundant in the interrupt handling.  However,
> the first isb() is crucial for the arm_spe_pmu_start() case, and keeping
> it in the interrupt handler does no harm and simplifies code maintenance.
> 
> In short, if preserves the second isb() instead of removing it, the
> change looks good to me.

I'm not sure I follow your logic as to why both ISBs are required, but
I'd have thought that if perf_aux_output_begin() fails when called from
arm_spe_perf_aux_output_begin() in the irqhandler, we need the ISB
because we're going to clear pmblimitr_el1 to 0 and that surely has
to be ordered before clearing pmbsr?

Will
