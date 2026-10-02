Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EB649159D;
	Fri,  2 Oct 2026 13:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790946092; cv=none; b=NvuSGbv6NiEp7Zy+lTuJJhPzZcy0YWa4NeCPCRt6HSDSv+yw49/F4YPcQtEORCfSMLn1Sd3qfS7NED4a0EUEpEbCLUeJigd1kbOUwjf1ItlGTUD57L6ugzO/UQi1WY9QjXXS7FYTtN4AnUbhZDePtDbVecQVAfydXa8ZDTuoiII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790946092; c=relaxed/simple;
	bh=PPNsKh5iFmYOWcu5Wh5/i5vHtCxevqviLv8Y6BrMjPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksJWtPDmQxrpyC9PWnDnfwNNsanPl9ZF5FUp4Rvyau48rZBrDqdzesXnZ9iAcPawxCq58XzX7St58ASYF2Q9I5IEwrkwjcLr35ZXfeg37/rlQ90HYyFgVIWrTwPFwcROnbOMjfPOA3znwR+ioQNEF3lqXUD1lfkmxiP7KnYbosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dqJtOXiv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="dqJtOXiv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1AF0497;
	Fri,  2 Oct 2026 06:01:24 -0700 (PDT)
Received: from J2N7QTR9R3.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6564E3F86F;
	Fri,  2 Oct 2026 06:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790946088; bh=PPNsKh5iFmYOWcu5Wh5/i5vHtCxevqviLv8Y6BrMjPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dqJtOXivG2aPuAGzBiMXSIBSYNDf4tXrBQDpUpqUptX3mI4a0yMOrc6LsghKhon0x
	 UkiosuX/S1rRCJhki2bPF10ihIgxIxVyEHHfdm2CqEZvcjwwJW+4YQ187+yaFb+R+j
	 4QGq7hezZ4TAYh4tkHW2swzRkOlA80PsRyAqz1Cs=
Date: Fri, 2 Oct 2026 14:01:14 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Kohei Enju <enju.kohei@fujitsu.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Message-ID: <ar-rGjVKB0vqB-Jx@J2N7QTR9R3.cambridge.arm.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
 <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>

On Fri, Oct 02, 2026 at 07:26:50PM +0900, Tomohiro Misono wrote:
> FUJITSU-MONAKA Erratum E#030001 affects FUJITSU-MONAKA CPU
> when using 64k page size.
> 
> On affected FUJITSU-MONAKA CPUs, range-based TLBI operations
> targeting a VA or IPA may fail to invalidate TLB entries when
> addr[34:29] == all 1 && addr[28:0] == 0 for 512MB mappings.
> The affected instructions are:
>   RVA[L]E{1,2,3}*, RVAA[L]E1*, and RIPAS2[L]E1*.

How does this work when all of the following are true:

* The S1 translation granule is 4K.
* The S2 translation granule is 64K.
* S1 has a 1G block translating VA x to IPA y.
* S2 has a 512M block translating IPA y to PA z.

In that case, can a "512MB mapping" exist for VA x? I would expect so.

Assuming that is the case, the S1 translation granule doesn't matter,
and the S1 workaround cannot depend on PAGE_SIZE_64KB.

> Work around the erratum by issuing additional non-range
> TLBI instructions corresponding to the affected VA or IPA
> range-based TLBI operations.
> 
> Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
> ---
>  Documentation/arch/arm64/silicon-errata.rst |  2 ++
>  arch/arm64/Kconfig                          | 19 +++++++++++++++++
>  arch/arm64/include/asm/cpucaps.h            |  2 ++
>  arch/arm64/include/asm/tlbflush.h           | 33 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/cpu_errata.c              | 10 +++++++++
>  arch/arm64/tools/cpucaps                    |  1 +
>  6 files changed, 67 insertions(+)
> 
> diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
> index ac3248b9f2f3..8ab6284e3d10 100644
> --- a/Documentation/arch/arm64/silicon-errata.rst
> +++ b/Documentation/arch/arm64/silicon-errata.rst
> @@ -373,6 +373,8 @@ stable kernels.
>  +----------------+-----------------+-----------------+-----------------------------+
>  | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
>  +----------------+-----------------+-----------------+-----------------------------+
> +| Fujitsu        | MONAKA          | E#030001        | FUJITSU_ERRATUM_030001      |
> ++----------------+-----------------+-----------------+-----------------------------+
>  +----------------+-----------------+-----------------+-----------------------------+
>  | ASR            | ASR8601         | #8601001        | N/A                         |
>  +----------------+-----------------+-----------------+-----------------------------+
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index b5a51b0ef944..38248a31d5f1 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1312,6 +1312,25 @@ config FUJITSU_ERRATUM_010001
>  
>  	  If unsure, say Y.
>  
> +config FUJITSU_ERRATUM_030001
> +	bool "FUJITSU-MONAKA erratum E#030001: Range TLBI may fail to invalidate some entries"
> +	depends on PAGE_SIZE_64KB

As above, I strongly suspect this depends on the conbiation of S1 and S2
sizes, and could happen regardless of whether S1 uses 64K.

> +	default y
> +	help
> +	  This option adds a workaround for FUJITSU-MONAKA erratum E#030001.
> +	  On affected FUJITSU-MONAKA CPUs, range-based TLBI operation
> +	  targeting a VA or IPA may fail to invalidate some TLB entries
> +	  for 512MB mappings. The affected instructions are RVA[L]E{1,2,3}*,
> +	  RVAA[L]E1*, and RIPAS2[L]E1*.
> +
> +	  Work around the erratum by issuing additional non-range TLBI
> +	  instructions corresponding to the affected VA or IPA range-based
> +	  TLBI operations.
> +
> +	  The erratum only affects the FUJITSU-MONAKA on 64k pagesize.
> +
> +	  If unsure, say Y.
> +
>  config HISILICON_ERRATUM_161600802
>  	bool "Hip07 161600802: Erroneous redistributor VLPI base"
>  	default y
> diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
> index 76350b38f0d7..9220b917ec20 100644
> --- a/arch/arm64/include/asm/cpucaps.h
> +++ b/arch/arm64/include/asm/cpucaps.h
> @@ -66,6 +66,8 @@ cpucap_is_possible(const unsigned int cap)
>  		return IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386);
>  	case ARM64_WORKAROUND_4193714:
>  		return IS_ENABLED(CONFIG_ARM64_ERRATUM_4193714);
> +	case ARM64_WORKAROUND_FUJITSU_030001:
> +		return IS_ENABLED(CONFIG_FUJITSU_ERRATUM_030001);
>  	case ARM64_MPAM:
>  		/*
>  		 * KVM MPAM support doesn't rely on the host kernel supporting MPAM.
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 14a78ac0f800..0487daec1652 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -487,6 +487,37 @@ static __always_inline void __tlbi_range(tlbi_op op, u64 addr,
>  	op(arg);
>  }
>  
> +#ifdef CONFIG_FUJITSU_ERRATUM_030001
> +static inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end, u16 asid)
> +{
> +	u64 addr;
> +
> +	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_FUJITSU_030001))
> +		return;
> +
> +	/*
> +	 * The erratum fails to invalidate TLBI entries in the range when
> +	 * addr[34:29] == all 1 && addr[28:0] == all 0 for 512M hugepage.
> +	 * However, since it cannot be determined reliably if the target
> +	 * entry is hugepage or not here, always assume hugepage is used.
> +	 * The workaround is to issue extra non-range TLBI ops corresponding
> +	 * to the affected VA or IPA range-based ops in the range.
> +	 */
> +	addr = (start & GENMASK_ULL(63, 35)) | GENMASK_ULL(34, 29);
> +	while (addr < end) {
> +		__tlbi_level_asid(lop, addr, TLBI_TTL_UNKNOWN, asid);
> +		if (addr + BIT_ULL(35) < addr)
> +			/* overflow */
> +			break;
> +		addr += BIT_ULL(35);
> +	}
> +}
> +#else
> +static inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end, u16 asid)
> +{
> +}
> +#endif /* CONFIG_FUJITSU_ERRATUM_030001 */
> +
>  static __always_inline void __flush_tlb_range_op(tlbi_op lop, tlbi_op rop,
>  						 u64 start, size_t pages,
>  						 u64 stride, u16 asid,
> @@ -518,6 +549,8 @@ static __always_inline void __flush_tlb_range_op(tlbi_op lop, tlbi_op rop,
>  		__tlbi_level_asid(lop, addr, level, asid);
>  		addr += stride;
>  	}
> +
> +	fujitsu_erratum_wa(lop, start, end, asid);
>  }

It would be much simpler to say range invalidation doesn't work on this
part.

>  
>  #define __flush_s1_tlb_range_op(op, start, pages, stride, asid, tlb_level) \
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 8ec47d89b45b..5b9dea3c761d 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -1027,6 +1027,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.matches = has_impdef_pmuv3,
>  		.cpu_enable = cpu_enable_impdef_pmuv3_traps,
>  	},
> +#ifdef CONFIG_FUJITSU_ERRATUM_030001
> +	{
> +		.desc = "FUJITSU-MONAKA Erratum E#030001",
> +		.capability = ARM64_WORKAROUND_FUJITSU_030001,
> +		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
> +					MIDR_ALL_VERSIONS(MIDR_FUJITSU_MONAKA),
> +					{}
> +				})),
> +	},

Are you expecting to add other parts here?

Is there a (future?) revision of MONAKA with this fixed?

Mark.

> +#endif
>  	{
>  		.desc = "Known broken GICv3 SEIS implementation",
>  		.capability = ARM64_WORKAROUND_GICv3_BROKEN_SEIS,
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 2775ba3359cf..50a9aa0e2bf0 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -132,3 +132,4 @@ WORKAROUND_REPEAT_TLBI_SYNC
>  WORKAROUND_SPECULATIVE_AT
>  WORKAROUND_SPECULATIVE_SSBS
>  WORKAROUND_SPECULATIVE_UNPRIV_LOAD
> +WORKAROUND_FUJITSU_030001
> 
> -- 
> 2.43.0
> 
