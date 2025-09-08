Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289054A33;
	Mon,  8 Sep 2025 13:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339831; cv=none; b=nJGkQhEqLiAbyfa/CzmDfiY6iyRzD6lUfaHZiyLqSmobnJrtFgFmYJXuWk5YjeY9UHy3503VwdR2xRCRgz1f3UpBXvYgdOEy4FTXbw61UCjBIicTOQ5ECQsuyxtfGoSlKEaPoPHta8xkRmK/tJa8b0povi0FJ2sbByEaFPWwioY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339831; c=relaxed/simple;
	bh=050zbUZX1lnVnrMNgmCKX02vHOtiXrBiIjwWED3DpuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/J0ubRMptGkqoyn8NUfoSytZ209MxmE9KRcSgRorYTtc2VhMTXogxn3ZvEBg3brSKFsXKy27TX85fs1CqBShnJXCElPtYIQaT727bIub+1TsJ/QtreFzN2pK090pWl8c55fSm3lP3UExoCE6gxL1A5MG/c28MJ/udrEnR9bFWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUabbPRw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUabbPRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CF6C4CEF1;
	Mon,  8 Sep 2025 13:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757339830;
	bh=050zbUZX1lnVnrMNgmCKX02vHOtiXrBiIjwWED3DpuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XUabbPRwfEBXndLNsMWxIK5NGsZgzdZi2OaT2+ht3OsmFNCuXhgn+DLQVeDcxst5c
	 Y//VSxfLF72FUx6Dvs2xUUGABvQxuQ6k7yHRPT1MZ9ZsWzoaILJyYknsEYHCwXeNo9
	 a3XpWofRVVFemKbniVZVJzlBmxplmncRAoAA0/rwXN58E4620OafXmOU/yqgiPAGtd
	 w8IpPu1i3dSu+48L6lYgaUJWVigfte6p5XIijSnVA2MfptHCkUcUJLOBkvkFmPRvJP
	 UiJGrLryrDVyq1jNOYCF5OstoxsEDhnD64Izy/Nj66JHk2V/fj0xeSUIamXOVLxI03
	 jJmVYpuf0tWWg==
Date: Mon, 8 Sep 2025 14:57:05 +0100
From: Will Deacon <will@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexandru Elisei <Alexandru.Elisei@arm.com>,
	Anshuman Khandual <Anshuman.Khandual@arm.com>,
	Rob Herring <Rob.Herring@arm.com>,
	Suzuki Poulose <Suzuki.Poulose@arm.com>,
	Robin Murphy <Robin.Murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <aL7gsXbr_-k4q-i5@willie-the-truck>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
 <aL7dFIzEgiEETcIb@willie-the-truck>
 <b4bcb7cf-da03-4263-9101-feec6d0e0d8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4bcb7cf-da03-4263-9101-feec6d0e0d8d@linaro.org>

On Mon, Sep 08, 2025 at 02:54:32PM +0100, James Clark wrote:
> 
> 
> On 08/09/2025 2:41 pm, Will Deacon wrote:
> > On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
> > > DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
> > > buffer is enabled. Ensure that enabling the buffer comes after setting
> > > PMBPTR_EL1 by inserting an isb().
> > > 
> > > This only applies to guests for now, but in future versions of the
> > > architecture the PE will be allowed to behave in the same way.
> > > 
> > > Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > >   drivers/perf/arm_spe_pmu.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > > index 3efed8839a4e..6235ca7ecd48 100644
> > > --- a/drivers/perf/arm_spe_pmu.c
> > > +++ b/drivers/perf/arm_spe_pmu.c
> > > @@ -537,6 +537,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
> > >   	limit += (u64)buf->base;
> > >   	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
> > >   	write_sysreg_s(base, SYS_PMBPTR_EL1);
> > > +	isb();
> > 
> > 
> > Hmm.
> > 
> > arm_spe_perf_aux_output_begin() is only called in two places:
> > 
> > 1. From arm_spe_pmu_start()
> > 2. From arm_spe_pmu_irq_handler()
> > 
> > For (1), we know that profiling is disabled by PMSCR_EL1.ExSPE.
> > For (2), we know that profiling is disabled by PMBSR_EL1.S.
> > 
> > In both cases, we already have an isb() before enabling profiling again
> > so I don't understand what this additional isb() is achieving.
> > 
> 
> It's to prevent PMBPTR_EL1 from being written to after the PMBLIMITR_EL1
> write than enables the buffer again. So you're right it's already disabled
> up to this point, which is why we didn't need to add another isb(). This
> change is only for the re-enabling bit.
> 
> If the instructions were reordered you could get this ordering at the end of
> arm_spe_perf_aux_output_begin():
> 
>   write_sysreg_s(limit, SYS_PMBLIMITR_EL1); // Enables buffer
> 
>   write_sysreg_s(base, SYS_PMBPTR_EL1);  // Invalid write to PMBPTR
> 
> Instead of the new version with the barrier where PMBPTR must come before:
> 
>   write_sysreg_s(base, SYS_PMBPTR_EL1);
>   isb()
>   write_sysreg_s(limit, SYS_PMBLIMITR_EL1);

... but my point is that profiling is still disabled after writing to
PMBLIMITR_EL1.

Will
