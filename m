Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34901C9B6C;
	Wed, 19 Mar 2025 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394873; cv=none; b=f5t4ONnSBZY1kzO7exnxCNx3P7vct3OvapQZx/qFXtsWbmqccMCOJYSDc4FBXN6yrrzZeLq9d0iEMkDJs6UK8hWxVg9oqfQUDkP+mOHjjFZ+6nGEWUeLf8JZ/rt66ExbcsL49ZiQlCULyR7D6sA18ZQXRgPy0d4dtjMK/ben0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394873; c=relaxed/simple;
	bh=3pq6FRyIzrjv4SPWeUepBB3TqevtfuHC4XLYdOXn3XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mf0L667JsovQk3ljfxjp+AOy62PbWkPKmEAuzQHoyJenAezatpHFWfxSwASa25nomWJ7VIeF4o+hpZ91QikVtp7v4zkjuFM/Eu3kGXty//Ckdz8ZYcKtZaDhDEES0tS33kanCW3BfwhBxxtucTsf3NFOg6GbLUjI2gBqQY+GvGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5AA0AFEC;
	Wed, 19 Mar 2025 07:34:39 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 278053F673;
	Wed, 19 Mar 2025 07:34:28 -0700 (PDT)
Date: Wed, 19 Mar 2025 14:34:25 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, thiago.bauermann@linaro.org,
	broonie@kernel.org, yury.khrustalev@arm.com,
	kristina.martsenko@arm.com, liaochang1@huawei.com,
	catalin.marinas@arm.com, will@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] uprobes: Allow the use of uprobe_warn() in arch code
Message-ID: <Z9rV8YbThvW2r69-@J2N7QTR9R3>
References: <20250318204841.373116-1-jeremy.linton@arm.com>
 <20250318204841.373116-7-jeremy.linton@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318204841.373116-7-jeremy.linton@arm.com>

On Tue, Mar 18, 2025 at 03:48:40PM -0500, Jeremy Linton wrote:
> The uprobe_warn function is limited to the uprobe core,
> but the functionality is useful to report arch specific errors.
> 
> Drop the static so it can be used in those code paths.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

NAK to the arm64 additions.

There is no reason to print a warning message for something that does
not adversely affect the kernel, and where buggy or malicious userspace
can trigger the warning when the kernel is behaving correctly.

This isn't even ratelimited.

Mark.

> ---
>  arch/arm64/kernel/probes/simulate-insn.c | 8 ++++++--
>  arch/arm64/kernel/probes/uprobes.c       | 4 ++++
>  include/linux/uprobes.h                  | 1 +
>  kernel/events/uprobes.c                  | 2 +-
>  4 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> index 1fc9bb69b1eb..fe637fec8f36 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.c
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -56,8 +56,10 @@ static inline void update_lr(struct pt_regs *regs, long addr)
>  
>  	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
>  		push_user_gcs(addr + 4,	 &err);
> -		if (err)
> +		if (err) {
> +			uprobe_warn(current, "GCS stack push failure");
>  			force_sig(SIGSEGV);
> +		}
>  	}
>  	procedure_link_pointer_set(regs, addr + 4);
>  }
> @@ -160,8 +162,10 @@ simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
>  
>  	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
>  		ret_addr = pop_user_gcs(&err);
> -		if (err || ret_addr != procedure_link_pointer(regs))
> +		if (err || ret_addr != procedure_link_pointer(regs)) {
> +			uprobe_warn(current, "GCS RET address mismatch");
>  			force_sig(SIGSEGV);
> +		}
>  	}
>  
>  }
> diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
> index 5e72409a255a..9349d521316c 100644
> --- a/arch/arm64/kernel/probes/uprobes.c
> +++ b/arch/arm64/kernel/probes/uprobes.c
> @@ -54,6 +54,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  
>  	switch (arm_probe_decode_insn(insn, &auprobe->api)) {
>  	case INSN_REJECTED:
> +		uprobe_warn(current, "Unsupported instruction at probe location");
>  		return -EINVAL;
>  
>  	case INSN_GOOD_NO_SLOT:
> @@ -169,6 +170,7 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>  		gcspr = read_sysreg_s(SYS_GCSPR_EL0);
>  		gcs_ret_vaddr = load_user_gcs((unsigned long __user *)gcspr, &err);
>  		if (err) {
> +			uprobe_warn(current, "GCS stack not available for retprobe");
>  			force_sig(SIGSEGV);
>  			goto out;
>  		}
> @@ -180,11 +182,13 @@ arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
>  		 * a GCS exception.
>  		 */
>  		if (gcs_ret_vaddr != orig_ret_vaddr)	{
> +			uprobe_warn(current, "LR/GCS mismatch, likely due to incorrectly placed retprobe");
>  			orig_ret_vaddr = -1;
>  			goto out;
>  		}
>  		put_user_gcs(trampoline_vaddr, (unsigned long __user *) gcspr, &err);
>  		if (err) {
> +			uprobe_warn(current, "GCS stack update failure during retprobe");
>  			force_sig(SIGSEGV);
>  			goto out;
>  		}
> diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> index b1df7d792fa1..9578ef1ea5a3 100644
> --- a/include/linux/uprobes.h
> +++ b/include/linux/uprobes.h
> @@ -185,6 +185,7 @@ struct uprobes_state {
>  };
>  
>  extern void __init uprobes_init(void);
> +extern void uprobe_warn(struct task_struct *t, const char *msg);
>  extern int set_swbp(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>  extern int set_orig_insn(struct arch_uprobe *aup, struct mm_struct *mm, unsigned long vaddr);
>  extern bool is_swbp_insn(uprobe_opcode_t *insn);
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index b4ca8898fe17..613c1c76f227 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -118,7 +118,7 @@ struct xol_area {
>  	unsigned long 			vaddr;		/* Page(s) of instruction slots */
>  };
>  
> -static void uprobe_warn(struct task_struct *t, const char *msg)
> +void uprobe_warn(struct task_struct *t, const char *msg)
>  {
>  	pr_warn("uprobe: %s:%d failed to %s\n", current->comm, current->pid, msg);
>  }
> -- 
> 2.48.1
> 
