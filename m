Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFC8140E5E;
	Thu, 13 Jun 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273458; cv=none; b=XgB8RQO5Vh39K6/NDnxXJb2pTXyE9qBLcZhlxjUnMcDaKVKdrvPB7IdW4uaH+qTLTo8QiHCkRw+BntVT+aRNgLcLv8pHF7+72IUSpFiK6pcrullLHzfpkpPE1MdMuv3YQdfildAO9JpE3GWgVIc15mc5aS1qhF2rEsVbUQZlzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273458; c=relaxed/simple;
	bh=TlbJyx+7DYGqEN8p9zg1Ig4eLs1UO4SOV9WpXUZtOrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qds0B/LN5p0OcSsYrIGPB5r8gT4Xcy9xY2jMrdqLMYOVCEOIUWTrFl9kB11mDWFctsPlAcKSt8l32I3ZVAreW3VUAqk/NDWx9vhOP5E4CsWdV/16I5I//NPq3w6oZtJ9BqWJqgcCdzs+I7rcrLcyDApUe/kBD79Sg5fcxeGZYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F01A1063;
	Thu, 13 Jun 2024 03:11:20 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4B3A3F5A1;
	Thu, 13 Jun 2024 03:10:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:10:48 +0100
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
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V18 1/9] arm64/sysreg: Add BRBE registers and fields
Message-ID: <ZmrFqMqNo3_rhdIo@J2N7QTR9R3>
References: <20240613061731.3109448-1-anshuman.khandual@arm.com>
 <20240613061731.3109448-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613061731.3109448-2-anshuman.khandual@arm.com>

On Thu, Jun 13, 2024 at 11:47:23AM +0530, Anshuman Khandual wrote:
> This patch adds definitions related to the Branch Record Buffer Extension
> (BRBE) as per ARM DDI 0487K.a. These will be used by KVM and a BRBE driver
> in subsequent patches.
> 
> Some existing BRBE definitions in asm/sysreg.h are replaced with equivalent
> generated definitions.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ----
> Changes in V18:
> 
> - Changed BRBIDR0_EL1 register fields CC and FORMAT, updated the commit message

Thanks, I see that matches my requsts on v17, so this looks good to me.

> 
>  arch/arm64/include/asm/sysreg.h |  17 ++---
>  arch/arm64/tools/sysreg         | 131 ++++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+), 11 deletions(-)
> ---
>  arch/arm64/include/asm/sysreg.h |  17 ++---
>  arch/arm64/tools/sysreg         | 131 ++++++++++++++++++++++++++++++++
>  2 files changed, 137 insertions(+), 11 deletions(-)

Something went wrong here to have this teice, but that doesn't affect
the actual patch.

Mark.

> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index af3b206fa423..cb3c9c83dc7a 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -195,16 +195,8 @@
>  #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
>  
>  #define SYS_BRBINF_EL1(n)		sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 0))
> -#define SYS_BRBINFINJ_EL1		sys_reg(2, 1, 9, 1, 0)
>  #define SYS_BRBSRC_EL1(n)		sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 1))
> -#define SYS_BRBSRCINJ_EL1		sys_reg(2, 1, 9, 1, 1)
>  #define SYS_BRBTGT_EL1(n)		sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 2))
> -#define SYS_BRBTGTINJ_EL1		sys_reg(2, 1, 9, 1, 2)
> -#define SYS_BRBTS_EL1			sys_reg(2, 1, 9, 0, 2)
> -
> -#define SYS_BRBCR_EL1			sys_reg(2, 1, 9, 0, 0)
> -#define SYS_BRBFCR_EL1			sys_reg(2, 1, 9, 0, 1)
> -#define SYS_BRBIDR0_EL1			sys_reg(2, 1, 9, 2, 0)
>  
>  #define SYS_TRCITECR_EL1		sys_reg(3, 0, 1, 2, 3)
>  #define SYS_TRCACATR(m)			sys_reg(2, 1, 2, ((m & 7) << 1), (2 | (m >> 3)))
> @@ -270,8 +262,6 @@
>  /* ETM */
>  #define SYS_TRCOSLAR			sys_reg(2, 1, 1, 0, 4)
>  
> -#define SYS_BRBCR_EL2			sys_reg(2, 4, 9, 0, 0)
> -
>  #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
>  #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
>  #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
> @@ -601,7 +591,6 @@
>  #define SYS_CNTHV_CVAL_EL2		sys_reg(3, 4, 14, 3, 2)
>  
>  /* VHE encodings for architectural EL0/1 system registers */
> -#define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)
>  #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
>  #define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
>  #define SYS_SCTLR2_EL12			sys_reg(3, 5, 1, 0, 3)
> @@ -794,6 +783,12 @@
>  #define OP_COSP_RCTX			sys_insn(1, 3, 7, 3, 6)
>  #define OP_CPP_RCTX			sys_insn(1, 3, 7, 3, 7)
>  
> +/*
> + * BRBE Instructions
> + */
> +#define BRB_IALL_INSN	__emit_inst(0xd5000000 | OP_BRB_IALL | (0x1f))
> +#define BRB_INJ_INSN	__emit_inst(0xd5000000 | OP_BRB_INJ  | (0x1f))
> +
>  /* Common SCTLR_ELx flags. */
>  #define SCTLR_ELx_ENTP2	(BIT(60))
>  #define SCTLR_ELx_DSSBS	(BIT(44))
> diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
> index a4c1dd4741a4..c6d3390f39ee 100644
> --- a/arch/arm64/tools/sysreg
> +++ b/arch/arm64/tools/sysreg
> @@ -1025,6 +1025,137 @@ UnsignedEnum	3:0	MTEPERM
>  EndEnum
>  EndSysreg
>  
> +
> +SysregFields BRBINFx_EL1
> +Res0	63:47
> +Field	46	CCU
> +Field	45:32	CC
> +Res0	31:18
> +Field	17	LASTFAILED
> +Field	16	T
> +Res0	15:14
> +Enum	13:8		TYPE
> +	0b000000	DIRECT_UNCOND
> +	0b000001	INDIRECT
> +	0b000010	DIRECT_LINK
> +	0b000011	INDIRECT_LINK
> +	0b000101	RET
> +	0b000111	ERET
> +	0b001000	DIRECT_COND
> +	0b100001	DEBUG_HALT
> +	0b100010	CALL
> +	0b100011	TRAP
> +	0b100100	SERROR
> +	0b100110	INSN_DEBUG
> +	0b100111	DATA_DEBUG
> +	0b101010	ALIGN_FAULT
> +	0b101011	INSN_FAULT
> +	0b101100	DATA_FAULT
> +	0b101110	IRQ
> +	0b101111	FIQ
> +	0b110000	IMPDEF_TRAP_EL3
> +	0b111001	DEBUG_EXIT
> +EndEnum
> +Enum	7:6	EL
> +	0b00	EL0
> +	0b01	EL1
> +	0b10	EL2
> +	0b11	EL3
> +EndEnum
> +Field	5	MPRED
> +Res0	4:2
> +Enum	1:0	VALID
> +	0b00	NONE
> +	0b01	TARGET
> +	0b10	SOURCE
> +	0b11	FULL
> +EndEnum
> +EndSysregFields
> +
> +SysregFields	BRBCR_ELx
> +Res0	63:24
> +Field	23 	EXCEPTION
> +Field	22 	ERTN
> +Res0	21:10
> +Field	9	FZPSS
> +Field	8 	FZP
> +Res0	7
> +Enum	6:5	TS
> +	0b01	VIRTUAL
> +	0b10	GUEST_PHYSICAL
> +	0b11	PHYSICAL
> +EndEnum
> +Field	4	MPRED
> +Field	3	CC
> +Res0	2
> +Field	1	ExBRE
> +Field	0	E0BRE
> +EndSysregFields
> +
> +Sysreg	BRBCR_EL1	2	1	9	0	0
> +Fields	BRBCR_ELx
> +EndSysreg
> +
> +Sysreg	BRBFCR_EL1	2	1	9	0	1
> +Res0	63:30
> +Enum	29:28	BANK
> +	0b00	BANK_0
> +	0b01	BANK_1
> +EndEnum
> +Res0	27:23
> +Field	22	CONDDIR
> +Field	21	DIRCALL
> +Field	20	INDCALL
> +Field	19	RTN
> +Field	18	INDIRECT
> +Field	17	DIRECT
> +Field	16	EnI
> +Res0	15:8
> +Field	7	PAUSED
> +Field	6	LASTFAILED
> +Res0	5:0
> +EndSysreg
> +
> +Sysreg	BRBTS_EL1	2	1	9	0	2
> +Field	63:0	TS
> +EndSysreg
> +
> +Sysreg	BRBINFINJ_EL1	2	1	9	1	0
> +Fields BRBINFx_EL1
> +EndSysreg
> +
> +Sysreg	BRBSRCINJ_EL1	2	1	9	1	1
> +Field	63:0 ADDRESS
> +EndSysreg
> +
> +Sysreg	BRBTGTINJ_EL1	2	1	9	1	2
> +Field	63:0 ADDRESS
> +EndSysreg
> +
> +Sysreg	BRBIDR0_EL1	2	1	9	2	0
> +Res0	63:16
> +Enum	15:12	CC
> +	0b0101	20_BIT
> +EndEnum
> +Enum	11:8	FORMAT
> +	0b0000	FORMAT_0
> +EndEnum
> +Enum	7:0		NUMREC
> +	0b00001000	8
> +	0b00010000	16
> +	0b00100000	32
> +	0b01000000	64
> +EndEnum
> +EndSysreg
> +
> +Sysreg	BRBCR_EL2	2	4	9	0	0
> +Fields	BRBCR_ELx
> +EndSysreg
> +
> +Sysreg	BRBCR_EL12	2	5	9	0	0
> +Fields	BRBCR_ELx
> +EndSysreg
> +
>  Sysreg	ID_AA64ZFR0_EL1	3	0	0	4	4
>  Res0	63:60
>  UnsignedEnum	59:56	F64MM
> -- 
> 2.25.1
> 
