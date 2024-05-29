Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B0717B4E2;
	Wed, 29 May 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716979917; cv=none; b=fN7KHUYDOho2rcFC1sMKvgGNhYA5YdsNisSeErvJsatW3HNHcONCLZLhneZvu+XlCUkPn1BKckIFZYi4cxIfWal3FuxJ57CWX46U0ptRAjhKa+6M+EhU6G86DmyAcz3Uv0y9XCdZq/qRljGNDysNnlTceyARHOpAikIIoD0PDjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716979917; c=relaxed/simple;
	bh=hu2o7TrXLAGI3/sOnTzeqAdPmrb8I0AVR4eoXnAypvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqtZ1qjqW6aa9OeZF0EF4gueGEOOw8NvaMmZIMx1HIfbJZMwNNP5PS+fH87XhOT9VFsWUacya0P9QYoZ4VM9mOmiZmpctVC0fNVRTRNCSq8oAHMx5lVyiBHoECJs7IyHt+kLQMme1X1k+6Bg3h631DnJ5nVr0cH1Q2cbuASxA8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64F72339;
	Wed, 29 May 2024 03:52:18 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22C433F792;
	Wed, 29 May 2024 03:51:47 -0700 (PDT)
Date: Wed, 29 May 2024 11:51:40 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	will@kernel.org, catalin.marinas@arm.com,
	Mark Brown <broonie@kernel.org>, James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
	Oliver Upton <oliver.upton@linux.dev>, linux-doc@vger.kernel.org
Subject: Re: [PATCH V17 4/9] arm64/boot: Enable EL2 requirements for BRBE
Message-ID: <ZlcIvJUArqDYHVFm@J2N7QTR9R3>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
 <20240405024639.1179064-5-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405024639.1179064-5-anshuman.khandual@arm.com>

On Fri, Apr 05, 2024 at 08:16:34AM +0530, Anshuman Khandual wrote:
> Fine grained trap control for BRBE registers, and instructions access need
> to be configured in HDFGRTR_EL2, HDFGWTR_EL2 and HFGITR_EL2 registers when
> kernel enters at EL1 but EL2 is present. This changes __init_el2_fgt() as
> required.
> 
> Similarly cycle and mis-prediction capture need to be enabled in BRBCR_EL1
> and BRBCR_EL2 when the kernel enters either into EL1 or EL2. This adds new
> __init_el2_brbe() to achieve this objective.
> 
> This also updates Documentation/arch/arm64/booting.rst with all the above
> EL2 along with MDRC_EL3.SBRBE requirements.
> 
> First this replaces an existing hard encoding (1 << 62) with corresponding
> applicable macro HDFGRTR_EL2_nPMSNEVFR_EL1_MASK.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Oliver Upton <oliver.upton@linux.dev>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ----
> Changes in V17:
> 
> - New patch added in the series
> - Separated out from the BRBE driver implementation patch
> - Dropped the comment in __init_el2_brbe()
> - Updated __init_el2_brbe() with BRBCR_EL2.MPRED requirements
> - Updated __init_el2_brbe() with __check_hvhe() constructs
> - Updated booting.rst regarding MPRED, MDCR_EL3 and fine grained control
> 
>  Documentation/arch/arm64/booting.rst | 26 ++++++++
>  arch/arm64/include/asm/el2_setup.h   | 90 +++++++++++++++++++++++++++-
>  2 files changed, 113 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/arch/arm64/booting.rst b/Documentation/arch/arm64/booting.rst
> index b57776a68f15..512210da7dd2 100644
> --- a/Documentation/arch/arm64/booting.rst
> +++ b/Documentation/arch/arm64/booting.rst
> @@ -349,6 +349,32 @@ Before jumping into the kernel, the following conditions must be met:
>  
>      - HWFGWTR_EL2.nSMPRI_EL1 (bit 54) must be initialised to 0b01.
>  
> +  For CPUs with feature Branch Record Buffer Extension (FEAT_BRBE):
> +
> +  - If the kernel is entered at EL2 and EL1 is present:
> +
> +    - BRBCR_EL1.CC (bit 3) must be initialised to 0b1.
> +    - BRBCR_EL1.MPRED (bit 4) must be initialised to 0b1.

IIUC this isn't necessary; if the kernel is entered at EL2, it's capable
of initializing the EL1 regs, and it doesn't look like this silently
affects something we'd need in the absence of a BRBE driver.

AFAICT the __init_el2_brbe() code you add below handles this, so I think
this is redundant and can be deleted.

> +  - If the kernel is entered at EL1 and EL2 is present:
> +
> +    - BRBCR_EL2.CC (bit 3) must be initialised to 0b1.
> +    - BRBCR_EL2.MPRED (bit 4) must be initialised to 0b1.
> +
> +    - HDFGRTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
> +    - HDFGRTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
> +    - HDFGRTR_EL2.nBRBIDR  (bit 59) must be initialised to 0b1.
> +
> +    - HDFGWTR_EL2.nBRBDATA (bit 61) must be initialised to 0b1.
> +    - HDFGWTR_EL2.nBRBCTL  (bit 60) must be initialised to 0b1.
> +
> +    - HFGITR_EL2.nBRBIALL (bit 56) must be initialised to 0b1.
> +    - HFGITR_EL2.nBRBINJ  (bit 55) must be initialised to 0b1.
> +
> +  - If EL3 is present:
> +
> +    - MDCR_EL3.SBRBE (bits 33:32) must be initialised to 0b11.

Minor nit: please list the EL3 requirements first, that way this can be
read in EL3->EL2->EL1 order to match the FW boot-flow order.

> +
>    For CPUs with the Scalable Matrix Extension FA64 feature (FEAT_SME_FA64):
>  
>    - If EL3 is present:
> diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
> index b7afaa026842..7c12a8e658d4 100644
> --- a/arch/arm64/include/asm/el2_setup.h
> +++ b/arch/arm64/include/asm/el2_setup.h
> @@ -154,6 +154,41 @@
>  .Lskip_set_cptr_\@:
>  .endm
>  
> +#ifdef CONFIG_ARM64_BRBE
> +/*
> + * Enable BRBE cycle count and miss-prediction
> + *
> + * BRBE requires both BRBCR_EL1.CC and BRBCR_EL2.CC fields, be set
> + * for the cycle counts to be available in BRBINF<N>_EL1.CC during
> + * branch record processing after a PMU interrupt. This enables CC
> + * field on both these registers while still executing inside EL2.

Huh, it's a bit of an oddity to do that for a register that gets the E2H
treatment, but that is what the ARM ARM says, looking at the pseudocode
in ARM DDI 0487K.a:

| // BRBCycleCountingEnabled()
| // =========================
| // Returns TRUE if the recording of cycle counts is allowed,
| // FALSE otherwise.
| boolean BRBCycleCountingEnabled()
| 	if HaveEL(EL2) && BRBCR_EL2.CC == '0' then return FALSE;
| 	if BRBCR_EL1.CC == '0' then return FALSE;
| 	return TRUE;

... and likewise for MPRED:

| // BRBEMispredictAllowed()
| // =======================
| // Returns TRUE if the recording of branch misprediction is allowed,
| // FALSE otherwise.
| boolean BRBEMispredictAllowed()
| 	if HaveEL(EL2) && BRBCR_EL2.MPRED == '0' then return FALSE;
| 	if BRBCR_EL1.MPRED == '0' then return FALSE;
| 	return TRUE;

... though BRBCycleCountingEnabled() isn't actually used anywhere, while
BRBEMispredictAllowed is used by BRBEBranch(), since that does:

| (ccu, cc) = BranchEncCycleCount();
| ...
| bit mispredict = if BRBEMispredictAllowed() && BranchMispredict() then '1' else '0';

... where BranchEncCycleCount() is a stub that doesn't mention
BRBCycleCountingEnabled() at all, so it's not clear to me whether CCU is
guaranteed to be set.

> + *
> + * BRBE driver would still be able to toggle branch records cycle
> + * count support via BRBCR_EL1.CC field regardless of whether the
> + * kernel ends up executing in EL1 or EL2.
> + *
> + * The same principle applies for branch record mis-prediction info
> + * as well, thus requiring MPRED field to be set on both BRBCR_EL1
> + * and BRBCR_EL2 while still executing inside EL2.
> + */

I think we can clarify this comment to:

/*
 * Enable BRBE to record cycle counts and branch mispredicts.
 *
 * At any EL, to record cycle counts BRBE requires that both
 * BRBCR_EL2.CC=1 and BRBCR_EL1.CC=1.
 *
 * At any EL, to record branch mispredicts BRBE requires that both
 * BRBCR_EL2.MPRED=1 and BRBCR_EL1.MPRED=1.
 *
 * When HCR_EL2.E2H=1, the BRBCR_EL1 encoding is redirected to
 * BRBCR_EL2, but the {CC,MPRED} bits in the real BRBCR_EL1 register
 * still apply.
 *
 * Set {CC,MPRBED} in both BRBCR_EL2 and BRBCR_EL1 so that at runtime we
 * only need to enable/disable thse in BRBCR_EL1 regardless of whether
 * the kernel ends up executing in EL1 or EL2.
 */

> +.macro __init_el2_brbe
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +	cbz	x1, .Lskip_brbe_\@
> +
> +	mov_q	x0, BRBCR_ELx_CC | BRBCR_ELx_MPRED
> +	msr_s	SYS_BRBCR_EL2, x0
> +
> +	__check_hvhe .Lset_brbe_nvhe_\@, x1
> +	msr_s	SYS_BRBCR_EL12, x0	// VHE
> +	b	.Lskip_brbe_\@
> +
> +.Lset_brbe_nvhe_\@:
> +	msr_s	SYS_BRBCR_EL1, x0	// NVHE
> +.Lskip_brbe_\@:
> +.endm
> +#endif /* CONFIG_ARM64_BRBE */
> +
>  /* Disable any fine grained traps */
>  .macro __init_el2_fgt
>  	mrs	x1, id_aa64mmfr0_el1
> @@ -161,16 +196,48 @@
>  	cbz	x1, .Lskip_fgt_\@
>  
>  	mov	x0, xzr
> +	mov	x2, xzr
>  	mrs	x1, id_aa64dfr0_el1
>  	ubfx	x1, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
>  	cmp	x1, #3
>  	b.lt	.Lset_debug_fgt_\@
> +
>  	/* Disable PMSNEVFR_EL1 read and write traps */
> -	orr	x0, x0, #(1 << 62)
> +	orr	x0, x0, #HDFGRTR_EL2_nPMSNEVFR_EL1_MASK
> +	orr	x2, x2, #HDFGWTR_EL2_nPMSNEVFR_EL1_MASK
>  
>  .Lset_debug_fgt_\@:
> +#ifdef CONFIG_ARM64_BRBE
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +	cbz	x1, .Lskip_brbe_reg_fgt_\@
> +
> +	/*
> +	 * Disable read traps for the following registers
> +	 *
> +	 * [BRBSRC|BRBTGT|RBINF]_EL1
> +	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
> +	 */
> +	orr	x0, x0, #HDFGRTR_EL2_nBRBDATA_MASK
> +
> +	/*
> +	 * Disable write traps for the following registers
> +	 *
> +	 * [BRBSRCINJ|BRBTGTINJ|BRBINFINJ|BRBTS]_EL1
> +	 */
> +	orr	x2, x2, #HDFGWTR_EL2_nBRBDATA_MASK
> +
> +	/* Disable read and write traps for [BRBCR|BRBFCR]_EL1 */
> +	orr	x0, x0, #HDFGRTR_EL2_nBRBCTL_MASK
> +	orr	x2, x2, #HDFGWTR_EL2_nBRBCTL_MASK
> +
> +	/* Disable read traps for BRBIDR_EL1 */
> +	orr	x0, x0, #HDFGRTR_EL2_nBRBIDR_MASK
> +
> +.Lskip_brbe_reg_fgt_\@:
> +#endif /* CONFIG_ARM64_BRBE */
>  	msr_s	SYS_HDFGRTR_EL2, x0
> -	msr_s	SYS_HDFGWTR_EL2, x0
> +	msr_s	SYS_HDFGWTR_EL2, x2
>  
>  	mov	x0, xzr
>  	mrs	x1, id_aa64pfr1_el1
> @@ -193,7 +260,21 @@
>  .Lset_fgt_\@:
>  	msr_s	SYS_HFGRTR_EL2, x0
>  	msr_s	SYS_HFGWTR_EL2, x0
> -	msr_s	SYS_HFGITR_EL2, xzr
> +	mov	x0, xzr
> +#ifdef CONFIG_ARM64_BRBE
> +	mrs	x1, id_aa64dfr0_el1
> +	ubfx	x1, x1, #ID_AA64DFR0_EL1_BRBE_SHIFT, #4
> +	cbz	x1, .Lskip_brbe_insn_fgt_\@
> +
> +	/* Disable traps for BRBIALL instruction */
> +	orr	x0, x0, #HFGITR_EL2_nBRBIALL_MASK
> +
> +	/* Disable traps for BRBINJ instruction */
> +	orr	x0, x0, #HFGITR_EL2_nBRBINJ_MASK
> +
> +.Lskip_brbe_insn_fgt_\@:
> +#endif /* CONFIG_ARM64_BRBE */
> +	msr_s	SYS_HFGITR_EL2, x0
>  
>  	mrs	x1, id_aa64pfr0_el1		// AMU traps UNDEF without AMU
>  	ubfx	x1, x1, #ID_AA64PFR0_EL1_AMU_SHIFT, #4
> @@ -228,6 +309,9 @@
>  	__init_el2_nvhe_idregs
>  	__init_el2_cptr
>  	__init_el2_fgt
> +#ifdef CONFIG_ARM64_BRBE
> +	__init_el2_brbe
> +#endif

This largely looks fine, but I note that we haven't bothered with
ifdeffery for PMU and SPE, so I suspect it might be worth getting rid of
the ifdeffery for BRBE.

Mark.
