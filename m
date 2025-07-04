Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C413BC0C;
	Fri,  4 Jul 2025 14:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751637888; cv=none; b=JP+CXqggAVOD0xJESPS6aylsxtev8GRSKSJeaZ4xZ3o5OnJlCK9G+vx1A47fBsR4DSneZjTUzzDBjHp83v3186ZcgG8LYfo2lGAO1OZ0bpJRs3Bb11v4vl4JArOVpzuFMfFSnULG4UpqsnhBbnuk8Zy8cOJiPxmDF4R36vHz3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751637888; c=relaxed/simple;
	bh=2fTB4eZSfWO9hqTIwd7L+Z/CosZn1YDOT8FR8MWvd1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmr7YBepZmqDQGOZDzoikvEtaOAP3skZwUt6VaU52yCftOogrci7b9ERh63Y3nrUwc7MKjWeWN4BVVz5WH4X400g1c7EjHiPhP5NyiSzLnp0/Sfx9F0rJcSSyKmU6S1+wRPfDPMEP3rL5JcXwjvpZlxOdhwQFk0Rp116tkpyQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC0B61515;
	Fri,  4 Jul 2025 07:04:31 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EF303F63F;
	Fri,  4 Jul 2025 07:04:45 -0700 (PDT)
Date: Fri, 4 Jul 2025 15:04:43 +0100
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
Subject: Re: [PATCH 1/3] perf: arm_spe: Add barrier before enabling profiling
 buffer
Message-ID: <20250704140443.GH1039028@e132581.arm.com>
References: <20250701-james-spe-vm-interface-v1-0-52a2cd223d00@linaro.org>
 <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-james-spe-vm-interface-v1-1-52a2cd223d00@linaro.org>

On Tue, Jul 01, 2025 at 04:31:57PM +0100, James Clark wrote:
> DEN0154 states that PMBPTR_EL1 must not be modified while the profiling
> buffer is enabled. Ensure that enabling the buffer comes after setting
> PMBPTR_EL1 by inserting an isb().
> 
> This only applies to guests for now, but in future versions of the
> architecture the PE will be allowed to behave in the same way.
> 
> Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  drivers/perf/arm_spe_pmu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 3efed8839a4e..6235ca7ecd48 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -537,6 +537,7 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>  	limit += (u64)buf->base;
>  	base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>  	write_sysreg_s(base, SYS_PMBPTR_EL1);
> +	isb();

I know that you and Alexandru have discussed whether the isb() should
be placed here or after the out_write_limit label. I should have engaged
in the discussion earlier. Sorry for raising the question now.

My understanding is that isb() is not only for synchronizing the write
to PMBPTR_EL1. It also serves as a context synchronization event
between any other SPE register writes and the write to
SYS_PMBLIMITR_EL1.

Let me give an example (perhaps a rare one): if we use perf snapshot
mode or the AUX pause/resume mode, it's possible that the flow does
not trigger an interrupt via overflow. Instead, the sequence might
look like this:

  arm_spe_pmu_stop()
    `> arm_spe_pmu_start()
         `> arm_spe_perf_aux_output_begin()

In this case, to ensure that all SPE system registers are properly
written to the hardware, the safest approach is to always execute isb()
just before writing to SYS_PMBLIMITR_EL1. (In other words, after the
label out_write_limit).

Thanks,
Leo

>  out_write_limit:
>  	write_sysreg_s(limit, SYS_PMBLIMITR_EL1);
> 
> -- 
> 2.34.1
> 
> 
