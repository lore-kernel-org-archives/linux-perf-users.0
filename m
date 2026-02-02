Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDE123504B;
	Mon,  2 Feb 2026 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058640; cv=none; b=JDA8Fi+xt+xwQ+kWo13ooXsgN6ZqxjiSZ7QIbHwQyJ2DZ0xdPuO7t6PovRTHK1idjq9ofxM5peRo25NkwHAow7jICRlUgX4l75a6TF6cd6Bwl3oDXGqpArg+o1u4oIVgO/aRHp0AbjPTZBAVWtDlEZzoweZe7inC1FoZUxnIKSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058640; c=relaxed/simple;
	bh=EvH/CRh1Q3JQ5wjxo+wP7sP09MLf4rqLjdI4TQq0KoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd0CHniK01rvNmQ2ruDpXr217YVjBIKMn+leDzN0vuQlg2cMOkPb25ANvVZlLRiFfEDxJ31wFHkAb+0eR8J0I6ikOZoL3/YfRJ2HpRtpY3tdJ/DMeRfnGeyIpxboVDorP6Fiwz3hBqi9ObZByE8q98qpjCnpPSEaT13gwmwfXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ga6Zn9Si; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ga6Zn9Si"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3EFC116C6;
	Mon,  2 Feb 2026 18:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770058640;
	bh=EvH/CRh1Q3JQ5wjxo+wP7sP09MLf4rqLjdI4TQq0KoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ga6Zn9SivhZuz8tmObUtlHGj6iFM4IL8Xqca4R39VAaaHtCu+ksRZv43YcSIKZwI7
	 B2fRg7mbsctSCIbGyXIUyFmwGTEFY2PhrwpDRsv2k99j1E3vELTz6uwVwCpcNgPdKF
	 h3BrqcS58DnEknVos06bsH6gtdxAFkfk/xDwcWtoeGrp+/aZyFOGwBt1MxjdBDYJRx
	 gXtg9l58EIrJE/PfS48MiIRLIiP+wkEirjsdApIhkvSoC3d1gNTMaHsjcHMBw6PNs/
	 flOfVE0xI2oVvROU3yz2t5g8og+p/Y0x184gftOkVB5vJh1xMLlANhi0OLNvCK0iVn
	 dtMGyNpxElZYQ==
Date: Mon, 2 Feb 2026 18:57:11 +0000
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
Message-ID: <aYDzh1B9Cnr_expJ@willie-the-truck>
References: <20260123-james-spe-relaxation-v1-1-4ccb88fa7bc5@linaro.org>
 <20260130202437.GB3481290@e132581.arm.com>
 <aYDWpc8Jh4SqMcD5@willie-the-truck>
 <20260202184234.GC3481290@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260202184234.GC3481290@e132581.arm.com>

On Mon, Feb 02, 2026 at 06:42:34PM +0000, Leo Yan wrote:
> On Mon, Feb 02, 2026 at 04:53:57PM +0000, Will Deacon wrote:
> 
> [...]
> 
> > > > To avoid redundant isb()s in the IRQ handler, remove the isb() between
> > > > the PMBLIMITR_EL1 write and SYS_PMBSR_EL1 as it doesn't matter which
> > > > order these happen in now that all the previous configuration is covered
> > > > by the new isb().
> > > 
> > > The isb() in the interrupt handler is useful and should not be removed.
> > > 
> > > See the sequence in the interrupt handler:
> > > 
> > >     arm_spe_perf_aux_output_begin() {
> > >         write_sysreg_s(base, SYS_PMBPTR_EL1);
> > > 
> > >         // Ensure the write pointer is ordered
> > >         isb();
> > > 
> > >         write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> > >     }
> > > 
> > >     // Ensure the limit pointer is ordered
> > >     isb();
> > > 
> > >     // Profiling is enabled:
> > >     //   (PMBLIMITR_EL1.E==1) && (PMBSR_EL1.S==0) && (not discard mode)
> > >     write_sysreg_s(0, SYS_PMBSR_EL1);
> > > 
> > > The first isb() ensures that the write pointer update is ordered.  The
> > > second isb() ensures that the limit pointer is visible before profiling
> > > is enabled by clearing the PMBSR_EL1.S bit.  When handling a normal
> > > maintenance interrupt, PMBSR_EL1.S is set by the SPE to stop tracing,
> > > while PMBLIMITR_EL1.E remains set.  Clearing PMBSR_EL1.S therefore
> > > effectively re-enables profiling.
> > > 
> > > Since the second isb() is a synchronization for both the write pointer
> > > and the limit pointer before profiling is enabled, it could be argued
> > > that the first isb() is redundant in the interrupt handling.  However,
> > > the first isb() is crucial for the arm_spe_pmu_start() case, and keeping
> > > it in the interrupt handler does no harm and simplifies code maintenance.
> > > 
> > > In short, if preserves the second isb() instead of removing it, the
> > > change looks good to me.
> > 
> > I'm not sure I follow your logic as to why both ISBs are required, but
> > I'd have thought that if perf_aux_output_begin() fails when called from
> > arm_spe_perf_aux_output_begin() in the irqhandler, we need the ISB
> > because we're going to clear pmblimitr_el1 to 0 and that surely has
> > to be ordered before clearing pmbsr?
> 
> I think the ISB after arm_spe_perf_aux_output_begin() in the irq
> handler is required for both the failure and success cases.
> 
> For a normal maintenance interrupt, an ISB is inserted between writing
> PMBLIMITR_EL1 and PMBSR_EL1 to ensure that a valid limit write is
> visible before tracing restarts.  This ensures that the following
> conditions are safely met:
> 
>   "While the Proﬁling Buﬀer is enabled, proﬁling is not stopped, and
>    Discard mode is not enabled, all of the following must be true:
> 
>    The current write pointer must be at least one sample record below
>    the write limit pointer.
> 
>    PMBPTR_EL1.PTR[63:56] must equal PMBLIMITR_EL1.LIMIT[63:56],
>    regardless of the value of the applicable TBI bit."

Hmm, so let's say we've executed the first ISB. At that point, the
Profiling Buffer is disabled (PMBLIMITR_EL1.E = 0) and profiling is
stopped (PMBSR_EL1.S = 1). If we *don't* have the second ISB then either
PMBLIMITR_EL1 is written first or PMBSR_EL1 is written first. But the
text you quoted will only come into effect once they've both happened,
right? In which case, why does the order matter for the success case?

Will
