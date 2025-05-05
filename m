Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1426D17;
	Mon,  5 May 2025 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746433989; cv=none; b=QH0S8DKvzP7Q7/5fk2o3pjdQcCMc9vlQfHDUumOHILza2d85VpKkEBOVXG+28RqyTYy601jNemQoDO4pzJYa/EZ6l4ajsoclNp18pfOl3sKVWx/7vmiYx7hualUWILvd/Ec1vOfKWlkZjfu0yOxOzs0QzMe8xyqT7k+Y2StRkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746433989; c=relaxed/simple;
	bh=KWzV3bnJ82yXg2UyfVxU4NysgKS0z45OIAt5yL74fVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aR3q8ETBs64R2arpuEA3zP1XyyePi7M3wmFOc9RetZaYNZYmRulEAFwFPxP9nw3MgtNpwNEGklkOOmZgzb1SY32bXyWO32I+UBx+Jkx5xkuJxoxaz5z5CG+MJxmq4tQTQgZMyZB4vOFQh+ZyVe4k8FI8ashmsq12tQsWwjzFQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB1461007;
	Mon,  5 May 2025 01:32:57 -0700 (PDT)
Received: from [10.163.53.144] (unknown [10.163.53.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85F263F5A1;
	Mon,  5 May 2025 01:33:04 -0700 (PDT)
Message-ID: <a76b6bb7-f6ac-4e0c-abd0-b2af9fde8691@arm.com>
Date: Mon, 5 May 2025 14:02:59 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64/ptrace: Make user_hwdebug_state.dbg_regs[] array
 size as ARM_MAX_BRP
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250421055212.123774-1-anshuman.khandual@arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250421055212.123774-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/21/25 11:22, Anshuman Khandual wrote:
> Array elements inside 'struct user_hwdebug_state.dbg_regs[]' are inherently
> coupled with maximum breakpoints or watchpoints which could be present on a
> platform and which are defined with macros ARM_MAX_[BRP|WRP].
> 
> Rather than explicitly trying to keep the array elements in sync with these
> macros and then adding a BUILD_BUG_ON() just to ensure continued compliance
> , move these two macros into the uapi ptrace header itself thus making them
> available both for user space and kernel.
> 
> While here also ensure that ARM_MAX_BRP and ARM_MAX_WRP are always the same
> via a new BUILD_BUG_ON(). This helps in making sure that user_hwdebug_state
> structure remains usable both for breakpoint and watchpoint registers set
> via ptrace() system call interface.
> 
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch applies on v6.15-rc3

Gentle ping, any updates on this.

> 
>  arch/arm64/include/asm/hw_breakpoint.h |  7 -------
>  arch/arm64/include/uapi/asm/ptrace.h   | 10 +++++++++-
>  arch/arm64/kernel/hw_breakpoint.c      |  9 +++++++++
>  3 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
> index bd81cf17744a..63c21b515647 100644
> --- a/arch/arm64/include/asm/hw_breakpoint.h
> +++ b/arch/arm64/include/asm/hw_breakpoint.h
> @@ -75,13 +75,6 @@ static inline void decode_ctrl_reg(u32 reg,
>  #define ARM_KERNEL_STEP_ACTIVE	1
>  #define ARM_KERNEL_STEP_SUSPEND	2
>  
> -/*
> - * Limits.
> - * Changing these will require modifications to the register accessors.
> - */
> -#define ARM_MAX_BRP		16
> -#define ARM_MAX_WRP		16
> -
>  /* Virtual debug register bases. */
>  #define AARCH64_DBG_REG_BVR	0
>  #define AARCH64_DBG_REG_BCR	(AARCH64_DBG_REG_BVR + ARM_MAX_BRP)
> diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
> index 0f39ba4f3efd..8683f541a467 100644
> --- a/arch/arm64/include/uapi/asm/ptrace.h
> +++ b/arch/arm64/include/uapi/asm/ptrace.h
> @@ -99,6 +99,14 @@ struct user_fpsimd_state {
>  	__u32		__reserved[2];
>  };
>  
> +/*
> + * Maximum number of breakpoint and watchpoint registers
> + * on the platform. These macros get used both in kernel
> + * and user space as well.
> + */
> +#define ARM_MAX_BRP		16
> +#define ARM_MAX_WRP		16
> +
>  struct user_hwdebug_state {
>  	__u32		dbg_info;
>  	__u32		pad;
> @@ -106,7 +114,7 @@ struct user_hwdebug_state {
>  		__u64	addr;
>  		__u32	ctrl;
>  		__u32	pad;
> -	}		dbg_regs[16];
> +	}		dbg_regs[ARM_MAX_BRP];	/* Or ARM_MAX_WRP */
>  };
>  
>  /* SVE/FP/SIMD state (NT_ARM_SVE & NT_ARM_SSVE) */
> diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
> index 722ac45f9f7b..9bc51682713d 100644
> --- a/arch/arm64/kernel/hw_breakpoint.c
> +++ b/arch/arm64/kernel/hw_breakpoint.c
> @@ -981,6 +981,15 @@ static int __init arch_hw_breakpoint_init(void)
>  {
>  	int ret;
>  
> +	/*
> +	 * Maximum supported breakpoint and watchpoint registers must
> +	 * always be the same - regardless of actual register numbers
> +	 * found on a given platform. This is because the user facing
> +	 * ptrace structure 'user_hwdebug_state' actually depends on
> +	 * these macros to be the same.
> +	 */
> +	BUILD_BUG_ON(ARM_MAX_BRP != ARM_MAX_WRP);
> +
>  	core_num_brps = get_num_brps();
>  	core_num_wrps = get_num_wrps();
>  
