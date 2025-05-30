Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23642905;
	Fri, 30 May 2025 12:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748609201; cv=none; b=jbDlGf2CoE0hdu6JtdSDJNci4e5gDJYm9eXB0UT4konZRWm8FjiGSKbumitfBctGIClKobjks4y8oxUK+wVmjMrma0HVZuHRcxkmIPtik4Wcz/cGzEis4Y6POF5gtQvFiqCstvmKf/Zveaj5DgVe3cGlu6G5qI1JEYwxncb4yjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748609201; c=relaxed/simple;
	bh=UouTRDZWRFQY12UDfa8B7SZK9YSVYXlijP3sPSFSC+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/jMV8DnuHuShXizNpQovk1USguCmfEmIaYI/jzCHDj4TIg15ed3Lhm9X0IMDE14vjIb8NR4efhieDx372zjJXK5TXik3dCzt54Y3bG/4TtVF8xH9xjtcHtbJ65fVpkXYecaFkiEIDlpuOnxWIZ8yZwVvlDFVwLj17V4O0eecvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNni6vbd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNni6vbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DC5C4CEE9;
	Fri, 30 May 2025 12:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748609200;
	bh=UouTRDZWRFQY12UDfa8B7SZK9YSVYXlijP3sPSFSC+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MNni6vbdljirgsw19cRPr/LTI1gGIqFyBhU5hTAX6drSdzIgelY/wzaMVGGnKuK/2
	 q4tSylmvZzlahNC6V18L4AhLFdMctn/GwEdOk4W5T+vaNf3R4md03NFOfiE+mz/gZj
	 TLB8X7PZZuEducywcluQojApbsdkN8NsOOM87oc13zRS9x4mb0Fr/31BUhcOOnIerM
	 nG/ehVIpH79FwQMdzPk7MFyRA1D5zC6hP4tCPtNZABVQF6S8tTZq/6eGV9yq4I/MUq
	 FcKzl6mKGfZzJdAIAgNs2tTNKPSltTNPfYoZLevM2pAyVA3BkM6dLa4+Sk3SzBGukw
	 F8hBQumgXeQ5w==
Date: Fri, 30 May 2025 13:46:35 +0100
From: Will Deacon <will@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/ptrace: Make user_hwdebug_state.dbg_regs[] array
 size as ARM_MAX_BRP
Message-ID: <20250530124635.GB30463@willie-the-truck>
References: <20250421055212.123774-1-anshuman.khandual@arm.com>
 <20250516135958.GA13612@willie-the-truck>
 <8f6bba3a-4cf6-44c2-abeb-8d419ca5a6c3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f6bba3a-4cf6-44c2-abeb-8d419ca5a6c3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, May 30, 2025 at 09:19:53AM +0530, Anshuman Khandual wrote:
> 
> 
> On 5/16/25 19:29, Will Deacon wrote:
> > On Mon, Apr 21, 2025 at 11:22:12AM +0530, Anshuman Khandual wrote:
> >> Array elements inside 'struct user_hwdebug_state.dbg_regs[]' are inherently
> >> coupled with maximum breakpoints or watchpoints which could be present on a
> >> platform and which are defined with macros ARM_MAX_[BRP|WRP].
> >>
> >> Rather than explicitly trying to keep the array elements in sync with these
> >> macros and then adding a BUILD_BUG_ON() just to ensure continued compliance
> >> , move these two macros into the uapi ptrace header itself thus making them
> >> available both for user space and kernel.
> >>
> >> While here also ensure that ARM_MAX_BRP and ARM_MAX_WRP are always the same
> >> via a new BUILD_BUG_ON(). This helps in making sure that user_hwdebug_state
> >> structure remains usable both for breakpoint and watchpoint registers set
> >> via ptrace() system call interface.
> >>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-perf-users@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >> This patch applies on v6.15-rc3
> >>
> >>  arch/arm64/include/asm/hw_breakpoint.h |  7 -------
> >>  arch/arm64/include/uapi/asm/ptrace.h   | 10 +++++++++-
> >>  arch/arm64/kernel/hw_breakpoint.c      |  9 +++++++++
> >>  3 files changed, 18 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
> >> index bd81cf17744a..63c21b515647 100644
> >> --- a/arch/arm64/include/asm/hw_breakpoint.h
> >> +++ b/arch/arm64/include/asm/hw_breakpoint.h
> >> @@ -75,13 +75,6 @@ static inline void decode_ctrl_reg(u32 reg,
> >>  #define ARM_KERNEL_STEP_ACTIVE	1
> >>  #define ARM_KERNEL_STEP_SUSPEND	2
> >>  
> >> -/*
> >> - * Limits.
> >> - * Changing these will require modifications to the register accessors.
> >> - */
> >> -#define ARM_MAX_BRP		16
> >> -#define ARM_MAX_WRP		16
> >> -
> >>  /* Virtual debug register bases. */
> >>  #define AARCH64_DBG_REG_BVR	0
> >>  #define AARCH64_DBG_REG_BCR	(AARCH64_DBG_REG_BVR + ARM_MAX_BRP)
> >> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> >> index 0f39ba4f3efd..8683f541a467 100644
> >> --- a/arch/arm64/include/uapi/asm/ptrace.h
> >> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> >> @@ -99,6 +99,14 @@ struct user_fpsimd_state {
> >>  	__u32		__reserved[2];
> >>  };
> >>  
> >> +/*
> >> + * Maximum number of breakpoint and watchpoint registers
> >> + * on the platform. These macros get used both in kernel
> >> + * and user space as well.
> >> + */
> >> +#define ARM_MAX_BRP		16
> >> +#define ARM_MAX_WRP		16
> >> +
> >>  struct user_hwdebug_state {
> >>  	__u32		dbg_info;
> >>  	__u32		pad;
> >> @@ -106,7 +114,7 @@ struct user_hwdebug_state {
> >>  		__u64	addr;
> >>  		__u32	ctrl;
> >>  		__u32	pad;
> >> -	}		dbg_regs[16];
> >> +	}		dbg_regs[ARM_MAX_BRP];	/* Or ARM_MAX_WRP */
> >>  };
> >>  
> >>  /* SVE/FP/SIMD state (NT_ARM_SVE & NT_ARM_SSVE) */
> >> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> >> index 722ac45f9f7b..9bc51682713d 100644
> >> --- a/arch/arm64/kernel/hw_breakpoint.c
> >> +++ b/arch/arm64/kernel/hw_breakpoint.c
> >> @@ -981,6 +981,15 @@ static int __init arch_hw_breakpoint_init(void)
> >>  {
> >>  	int ret;
> >>  
> >> +	/*
> >> +	 * Maximum supported breakpoint and watchpoint registers must
> >> +	 * always be the same - regardless of actual register numbers
> >> +	 * found on a given platform. This is because the user facing
> >> +	 * ptrace structure 'user_hwdebug_state' actually depends on
> >> +	 * these macros to be the same.
> >> +	 */
> >> +	BUILD_BUG_ON(ARM_MAX_BRP != ARM_MAX_WRP);
> > 
> > Sorry, but I don't understand why this patch is an improvement over what
> > we have.
> This is an improvement because
> 
> - user_hwdebug_state.dbg_regs[16] is hard coded for size without context
>   requiring explicit sync up when ARM_MAX_WRP/BRP changes to 64 later on
>   with FEAT_Debugv8p9. Defining the array size in terms of ARM_MAX_WRP/
>   BRP provides required context and also avoids the need for an explicit
>   hard coded sync up when those macros change.
> 
> - user_hwdebug_state.dbg_regs[16] gets used both for breakpoint registers
>   and watchpoint registers. Hence there is an inherent assumption that
>   ARM_MAX_BRP == ARM_MAX_WRP which should be ensured with a corresponding
>   assert.

Sorry, but I still don't see it. Plus, this is a UAPI header so I think
it's no bad thing to require an "explicit sync up", assuming we can
actually change this structure at all.

Let's leave the code as it is, please.

Will
