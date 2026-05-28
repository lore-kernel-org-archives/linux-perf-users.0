Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD343D6474;
	Thu, 28 May 2026 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965877; cv=none; b=SjEYZoC7KxMPsKIXK8oGyzVP+K1FYz9hzGAu3mtIWjzKqtjCqCMlrPfeXLlJfiflr+pC/+UDqb8SHUQg902rCEXdcE4FiyRxIEnV4acSNSFY7+DI+4Xj3LrsR76jNFvgEoKiJbxxat44M29niq+z6Il19euRp4YARosn1Hyhl+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965877; c=relaxed/simple;
	bh=YGtkcjrhopnf0FWykF3WR0bpqvOTM6s0JXacR/g+l50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsfWivuQDYddMGXoXvsh4A32Pa/kALLjCM4Hh8mUXwpv2FDoAKjjEMXb151eu/r3bKYVQl5430WpaslifJoURTbOvPquUS3wv1/JidCJ9wcywQMhM4zO6wAdMNBJEtHYU1MjiETvtxuNmtwHH0rb2fUtMcz+YR5l3Fy+rdOpZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEkKoxVo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEkKoxVo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D1161F000E9;
	Thu, 28 May 2026 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779965874;
	bh=uf8OOS9w8K2nnKpcG8N7Or//SZ7kw7jH9ROTyM2KyWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DEkKoxVoorrPdTxtupr2rvWQFXSCXdd2vYUnDkDTq4rdf8mTSR5uOW/DRTJSwA26o
	 609khKhGlox+UYDSKgxr9FqU27djS4eFqeok1Q3N/Pz6+SZq+bpR/pUDk2+fl5DkXX
	 6F6eGcG3tAgrmCzRqNym+Q+kUyxUn9m0+mQUjr6oPRiw16AvZO0EOxV3oxWU5HL+7n
	 jdl6kjRd+AcpE1S+oAnMYimCEgqSvDaM9hqWx12ThU7zphz7T3FjOZ8W3Psr30Xq5w
	 WCKsmMJ2mOMcQkXYEvKZDskSIMaQT408znIGE/fYFL0ANb+PgRaWp8WlSCF+fjTiXt
	 gMSnaOP66gfqA==
Date: Thu, 28 May 2026 11:57:49 +0100
From: Will Deacon <will@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH v4 4/6] arm64/cpufeature: Add field details for
 ID_AA64DFR1_EL1 register
Message-ID: <ahgfrdlEioodRPQ1@willie-the-truck>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
 <20260407-arm-debug-8-9-v4-4-a4864e69b0ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-arm-debug-8-9-v4-4-a4864e69b0ea@kernel.org>

On Tue, Apr 07, 2026 at 09:29:46AM -0500, Rob Herring (Arm) wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> This adds required field details for ID_AA64DFR1_EL1, and also drops dummy
> ftr_raz[] array which is now redundant. These register fields will be used
> to enable increased breakpoint and watchpoint registers via FEAT_Debugv8p9
> later. The register fields have been marked as FTR_STRICT, unless there is
> a known variation in practice.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c31f8e17732a..24c8e9147e35 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -570,6 +570,21 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
>  	ARM64_FTR_END,
>  };
>  
> +static const struct arm64_ftr_bits ftr_id_aa64dfr1[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ABL_CMPs_SHIFT, 8, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_DPFZS_SHIFT, 4, 0),

Why does FTR_LOWER_SAFE make sense for DPFZS? From what I can tell, the
new behaviour isn't opt-in, so maybe an FTR_EXACT of 0 would make more
sense if we have to be non-strict (along with a comment like we have for
DFR0.PMUVer)?

> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_EBEP_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ITE_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ABLE_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_PMICNTR_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_SPMU_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_CTX_CMPs_SHIFT, 8, 0),

I find it very weird for this to be non-strict when DFR0.CTX_CMPs _is_
strict.

> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_WRPs_SHIFT, 8, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_BRPs_SHIFT, 8, 0),

Given that things like hw_breakpoint_reset() rely on the sanitised
register view to determine the number of {break,watch}points, I think we
have to be strict here unless that is changed.

> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_SYSPMUID_SHIFT, 8, 0),

Again, I'm not sure that FTR_LOWER_SAFE makes a lot of sense here, but
it's hard to tell without an upstream driver for the system PMU.

> +	ARM64_FTR_END,
> +};
> +
>  static const struct arm64_ftr_bits ftr_mvfr0[] = {
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_EL1_FPRound_SHIFT, 4, 0),
>  	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_EL1_FPShVec_SHIFT, 4, 0),
> @@ -756,10 +771,6 @@ static const struct arm64_ftr_bits ftr_single32[] = {
>  	ARM64_FTR_END,
>  };
>  
> -static const struct arm64_ftr_bits ftr_raz[] = {
> -	ARM64_FTR_END,
> -};
> -
>  #define __ARM64_FTR_REG_OVERRIDE(id_str, id, table, ovr) {	\
>  		.sys_id = id,					\
>  		.reg = 	&(struct arm64_ftr_reg){		\
> @@ -832,7 +843,7 @@ static const struct __ftr_reg_entry {
>  
>  	/* Op1 = 0, CRn = 0, CRm = 5 */
>  	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
> -	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
> +	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_id_aa64dfr1),

I'm guessing that KVM will need some updates for this in its sys reg
handling code?

Will
