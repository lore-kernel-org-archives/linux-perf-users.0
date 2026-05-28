Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC637B007;
	Thu, 28 May 2026 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779966347; cv=none; b=nrzL2fhblGR+N6QDjjK2OHFcPubCn7zBrL0Pl6CZy+4CYEe+fat3XCIcw9Z1mBcJ6RxVQSYKEHRNhZaysVuUjmIKPGa1TlNLAYCF0xLWX4ZSk+HCqCe6/EqW1vBwv0Rv5THq7w3AmjVPC65NnlSbLSF1NqwPON39wyLXIegtMJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779966347; c=relaxed/simple;
	bh=fJFHH01v1zUljKRPRyttTzOJOhvFyx5afLPaIrusY2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2wWsFn5dMHmRzGF4hFsWhnJTJqEyPHyzXPbU+C7DocwmeXIesQY8bLWrSP16WBLNTYStqzuPPIwaATK3PA4ToFpfD+PfOa67niutHwlmwlLw7zS76hTSCgC2hBG++33jrai/auBUbjg6DU4Q1eOklQRg6u6WlvDJUoxd6Ruj0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adh5Adqx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adh5Adqx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320591F000E9;
	Thu, 28 May 2026 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779966346;
	bh=GVN+D237UJu5s1Uyc+xMy00xwjnCzolgiCKW26U7g2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=adh5AdqxoufFKI/GGbLyy6JQy02tr+RbV1aPlGhwUopbT2+gHnj/CJnA5kQPksTin
	 1mXjTYNKC8Q5hbEhtiw4VnzQFJeLaBrL11nnDjibS2YmSZuYzxN518k5919MHV8HWC
	 wcIidghcchgWa+cNRVq/eiUWLbWhgS9fZwja+8SQ3tFenHTFnUbaFfBpQvf5mo0UH8
	 w7KIsF25SBLmMRKCrjIw5hMI/N4iTBIsiBvqyYEO8RH6sufXaRhTCr1p2Z9/wXvp+7
	 GKt6mnaGQJgR/ijfFsmvCQLZjkoII2uA5+bpVQQgWPTgnuVQjBA9Fgvf8dt/mDWk6Z
	 1iOJPoqBLmhLw==
Date: Thu, 28 May 2026 12:05:41 +0100
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
Subject: Re: [PATCH v4 6/6] arm64: hw_breakpoint: Enable FEAT_Debugv8p9
Message-ID: <ahghhbcDgzB8wsrQ@willie-the-truck>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
 <20260407-arm-debug-8-9-v4-6-a4864e69b0ea@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407-arm-debug-8-9-v4-6-a4864e69b0ea@kernel.org>

On Tue, Apr 07, 2026 at 09:29:48AM -0500, Rob Herring (Arm) wrote:
> From: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Currently, there can be maximum 16 breakpoints and 16 watchpoints available
> on a given platform - as detected from ID_AA64DFR0_EL1.[BRPs|WRPs] register
> fields. These breakpoints and watchpoints can be extended further up to
> 64 via a new arch feature FEAT_Debugv8p9.
> 
> Checking for FEAT_Debugv8p9 alone is not enough to enable the support.
> It is also necessary to determine if there are more than 16 breakpoints
> or watchpoints. The behavior with FEAT_Debugv8p9 and <=16 breakpoints
> and watchpoints is IMPDEF.
> 
> The addition of the MDSELR_EL1 to set the bank index makes the register
> accesses non-atomic. However, the combination of all the breakpoint code
> being in the kprobe blacklist and breakpoint install/uninstall being
> protected by perf locking (IRQs disabled and context lock) will prevent
> debug exceptions during accesses and serialize the accesses.
> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> v4:
>  - Update commit message.
>  - Configure MDSCR_EL1_EMBWE on CPU reset/hotplug instead of every time
>    breakpoints are enabled/disabled.
>  - Drop unnecessary IRQ save and restore on register accesses.
>  - Stash checking whether FEAT_Debugv8p9 is used rather than reading
>    feature register on every register access.
>  - Check that we're greater than or equal to Debug_v8p9 not just equal
>    to.
>  - Use is_debug_v8p9_enabled() in get_num_brps/get_num_wrps(). Handle
>    the case when FEAT_Debugv8p9 is present, but the number of BP/WP
>    are <16. It is IMPDEF if ID_AA64DFR1_EL1 is used in this case. It is
>    also IMPDEF if MDSELR_EL1 is accessible. TF-A doesn't enable access
>    to MDSELR_EL1 in this case.
>  - Mark register access functions nokprobe.
> ---
>  arch/arm64/include/asm/hw_breakpoint.h | 47 ++++++++++++++++++++++++++--------
>  arch/arm64/kernel/debug-monitors.c     | 16 ++++++++----
>  arch/arm64/kernel/hw_breakpoint.c      | 41 +++++++++++++++++++++++++++--
>  3 files changed, 87 insertions(+), 17 deletions(-)

[...]

> @@ -138,19 +147,37 @@ static inline void ptrace_hw_copy_thread(struct task_struct *task)
>  /* Determine number of BRP registers available. */
>  static inline int get_num_brps(void)
>  {
> -	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
> -	return 1 +
> -		cpuid_feature_extract_unsigned_field(dfr0,
> -						ID_AA64DFR0_EL1_BRPs_SHIFT);
> +	u64 dfr0, dfr1;
> +	int brps;
> +
> +	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
> +	brps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_BRPs_SHIFT);
> +	if (is_debug_v8p9_enabled() && brps == 15) {
> +		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
> +		brps = cpuid_feature_extract_unsigned_field_width(dfr1,
> +								  ID_AA64DFR1_EL1_BRPs_SHIFT, 8);
> +		if (!brps)
> +			return 16;
> +	}
> +	return 1 + brps;
>  }
>  
>  /* Determine number of WRP registers available. */
>  static inline int get_num_wrps(void)
>  {
> -	u64 dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
> -	return 1 +
> -		cpuid_feature_extract_unsigned_field(dfr0,
> -						ID_AA64DFR0_EL1_WRPs_SHIFT);
> +	u64 dfr0, dfr1;
> +	int wrps;
> +
> +	dfr0 = read_sanitised_ftr_reg(SYS_ID_AA64DFR0_EL1);
> +	wrps = cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_WRPs_SHIFT);
> +	if (is_debug_v8p9_enabled() && wrps == 15) {
> +		dfr1 = read_sanitised_ftr_reg(SYS_ID_AA64DFR1_EL1);
> +		wrps = cpuid_feature_extract_unsigned_field_width(dfr1,
> +								  ID_AA64DFR1_EL1_WRPs_SHIFT, 8);
> +		if (!wrps)
> +			return 16;
> +	}
> +	return 1 + wrps;
>  }

[...]

> @@ -990,6 +1024,7 @@ static int __init arch_hw_breakpoint_init(void)
>  
>  	core_num_brps = get_num_brps();
>  	core_num_wrps = get_num_wrps();
> +	has_debug_v8p9 = (core_num_brps > 16) || (core_num_wrps > 16);

nit: FEAT_Debugv8p9 is advertised by ID_AA64DFR0_EL1.DebugVer and so
this should probably be called something else (e.g. 'has_register_banks').

Have you tested this in a guest? My reading is that MDCR_EL2.EMBWE will
be zero, but the ID registers can still advertise > 16 registers and
so I don't think this will work properly because writes to MDSELR_EL1
will either be trapped or ignored. It definitely feels like the KVM
piece of the puzzle is missing here and I think that it probably has to
be in place before we expose ID_AA64DFR1_EL1.

I'm also surprised not to see any ptrace changes in this series.
Specifically:

  1. I don't think we should expose any of this to compat tasks (see
     compat_ptrace_hbp_get_resource_info()) unless the 32-bit kernel is
     going to do that.

  2. 'struct user_hwdebug_state' retains a fixed length array of 16 for
     the debug regs and so the new registers aren't accessible in the
     REGSET_HW_{BREAK,WATCH} regsets. That means GDB can't use them and
     it also means they won't be included in coredumps iirc. I'm not sure
     whether we can safely extend the structure, so we might need to add
     some new ones...

Will
