Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E13047126B
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 14:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396551; cv=none; b=r9C2K6ElkmBJV3oS0mReZkqe++NBH6D912/K+yq5PCNFrt1hCc1zvVvueOvHFqoiR5EfWSGX80f39ZL1g911Uwnav3zN3iliUSfRM4utiQUJhF5+DrOVIALcjLQXOuU9dp4qiEJIbKbetauURa4mU87Egb4oi9qiqYqccdBuLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396551; c=relaxed/simple;
	bh=LglaGc1H0R+sxZA6wiKDg7CCL2SBWvqlpF/H4iHUw3I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IwFLBdGr1lmxRW7C07wLPgAv/qg0H1wa+y/YgvUaPUCyFrVY+eSDKG99A67+NrEYMeqD7mO1eWKmPttCzE8d5e3V88d2v2xIbQ+yCvT7s0RBA29fjZpmz2GSNIZJjW1BqFigVZyNILTIu59mw0MFGAd3PBHYOmLJimijjBYome8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LtvLjXah; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LtvLjXah"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39af92138f9so5913789a91.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789396549; x=1790001349; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpPRVgi7aIALsRKspaYc+kGuwDrBnRXT3lk0rEcHOXU=;
        b=LtvLjXahCCiUglmMqRe8i5nUW1Xi3A62sVdLhtjxNGcwPyiC/ckUMG5Elscgs2f+80
         GFiBdV/Hip1iLa64dzcGQmt5ImwJ4kgL+Ixyl7QAKzqAQyXo5FyvwXrPCmPOXHe4mWWG
         bzclg9uXHNG2F3Aeo6sLHUAzsgtmTFFu6iAs8oTSL7T7KBX0n8bFw1mXAiP5l/uCq8ci
         MinbxRnX377igCzZJJfxkrG3NPHP6e+7UIpLGTrKPeqgKOjjh4ZhogGMtRjIk/YUb5tS
         ahDQsj0uzrmx42f7VHS/un1H04zgHLUW9hwNbcWGKwf3chdQNa1XCOP0hQWflaoOqPJw
         XhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396549; x=1790001349;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpPRVgi7aIALsRKspaYc+kGuwDrBnRXT3lk0rEcHOXU=;
        b=BLnSi2Qw8lxSvObsAONJosPHwGVRsN+/sFPlwImxOE6xpqahKgOSDogf7ShtfD/XVF
         Xl2tXF5e01XyTwnxy0qw6ZPnRHZUnIQl6icvtlYaXC1vkur+F2rLmux2EkrGwSUqPQxB
         BxYX4WQf4K/4kotBnBCEXyRs4xWauMRw2kz+Kxt08zumoMgXZLgEkPNkOWr4PBCKcEGX
         kZ2k3oBShpQFFHHpqN0sIvOL5OfW3aBB1UOTQFBtnQshzXeZtwoXKHWDnozXJL2zjXlM
         LEGz42gQXcLPbsmOYxNej83YbX2EAlFffXizH7J+yfQ4OkZ+KjATz7qSbujtyWuFOYzD
         9MnQ==
X-Forwarded-Encrypted: i=1; AKwUvBz+p4aKcLLZgnTJmp+UETcS2XFnC3jwC77pIrAVQCKTHJg/JEgThUFxgkvhzRRPIL5hGnr1lrHxy/9biAoJmjUp@vger.kernel.org
X-Gm-Message-State: AFuF++mz27dRcl4IFS12PT9ABan4TUepqR7+umkHZEbdaTyXnLvtb7k2
	Ghq/pLfhfr+SFcKqNcMoxvo9ONnQGKgfPOHoYOD2PNEysUtuW9StxxtPSF3WlZkn44ZlIbEvTew
	wcoe7ow==
X-Received: from pjbin5.prod.google.com ([2002:a17:90b:4385:b0:39d:8c01:3e57])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2790:b0:398:9beb:a2b7
 with SMTP id 98e67ed59e1d1-39dd56bdc08mr8132347a91.25.1789396549085; Mon, 14
 Sep 2026 07:35:49 -0700 (PDT)
Date: Mon, 14 Sep 2026 07:35:48 -0700
In-Reply-To: <178939019982.94750.4441254006258061798.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <178939017565.94750.9431053336761330458.stgit@devnote2> <178939019982.94750.4441254006258061798.stgit@devnote2>
Message-ID: <aqgGRKOE138ePqmX@google.com>
Subject: Re: [PATCH v16 02/13] KVM: x86: Prevent host DR7 debug register leak
 into guest OS on NMI
From: Sean Christopherson <seanjc@google.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, x86@kernel.org, Jinchao Wang <wangjinchao600@gmail.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 14, 2026, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> When KVM enters a guest OS, host hardware breakpoints are disabled
> before running the guest. However, an NMI can occur during guest
> execution, where local_db_save() or arch_install_hw_breakpoint()
> can be invoked.
> 
> In particular, if local_db_save() or arch_install_hw_breakpoint()
> is executed from NMI, hardware DR7 can be modified or restored with
> host breakpoint settings, leaking host breakpoints into the guest OS
> or clobbering the guest's debug registers.

Not for local_db_save(), at least not AFAICT.  On VM-Exit, both Intel and AMD
purge DR7, i.e. load 0x400, so local_db_save() => local_db_restore() is more or
less a nop.  Even if that weren't the case, actually saving/restoring DR7 would
be the right thing to do, in any context.

> Introduce a per-CPU flag, cpu_dr_in_guest, to indicate that the CPU
> is executing in guest mode. Set this flag in vcpu_enter_guest()
> during entering the guest with disabling host breakpoints.
> If this flag is set, local_db_save() and local_db_restore() return
> immediately, and arch_install_hw_breakpoint() returns an error.
> In addition, protect cpu_dr_in_guest in within_cpu_entry() to
> prevent recursive #DB exceptions.
> 
> Fixes: f85d40160691 ("KVM: X86: Disable hardware breakpoints unconditionally before kvm_x86->run()")
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
> Changes in v16:
>  - Newly added.
> ---
>  arch/x86/include/asm/debugreg.h |    6 ++++++
>  arch/x86/kernel/hw_breakpoint.c |   10 ++++++++++
>  arch/x86/kvm/x86.c              |    7 +++++++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> index 854d82b88ff4..50f830972698 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
> @@ -18,6 +18,7 @@
>  #define DR7_FIXED_1	0x00000400
>  
>  DECLARE_PER_CPU(unsigned long, cpu_dr7);
> +DECLARE_PER_CPU(bool, cpu_dr_in_guest);
>  
>  #ifndef CONFIG_PARAVIRT_XXL
>  /*
> @@ -129,6 +130,9 @@ static __always_inline unsigned long local_db_save(void)
>  {
>  	unsigned long dr7;
>  
> +	if (this_cpu_read(cpu_dr_in_guest))
> +		return 0;

This is broken.  If an NMI hits between KVM writing cpu_dr_in_guest and clearing
DR7, and there are active breakpoints, then local_db_save() won't disable breakpoints
as it should, and the relevant code in exc_nmi() will run with breakpoints enabled.

	kvm_load_xfeatures(vcpu, true);

	this_cpu_write(cpu_dr_in_guest, true);
	barrier();

  <NMI here is problematic>

	if (unlikely(vcpu->arch.switch_db_regs &&
		     !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
		set_debugreg(DR7_FIXED_1, 7);
		set_debugreg(vcpu->arch.eff_db[0], 0);

> +
>  	if (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) && !hw_breakpoint_active())
>  		return 0;
>  
> @@ -157,6 +161,8 @@ static __always_inline void local_db_restore(unsigned long dr7)
>  	 * not be good.
>  	 */
>  	barrier();
> +	if (this_cpu_read(cpu_dr_in_guest))
> +		return;
>  	if (dr7)
>  		set_debugreg(dr7, 7);
>  }
> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index f846c15f21ca..68de7ed79d88 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c
> @@ -40,6 +40,9 @@
>  DEFINE_PER_CPU(unsigned long, cpu_dr7);
>  EXPORT_PER_CPU_SYMBOL(cpu_dr7);
>  
> +DEFINE_PER_CPU(bool, cpu_dr_in_guest);
> +EXPORT_PER_CPU_SYMBOL_GPL(cpu_dr_in_guest);
> +
>  /* Per cpu debug address registers values */
>  static DEFINE_PER_CPU(unsigned long, cpu_debugreg[HBP_NUM]);
>  
> @@ -102,6 +105,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
>  
>  	lockdep_assert_irqs_disabled();
>  
> +	if (this_cpu_read(cpu_dr_in_guest))
> +		return -EBUSY;

If we decide this is how to fix arch_install_hw_breakpoint() clobbering DRs from
NMI context, I would rather have more generic flag to tell perf that KVM is about
to enter the guest, e.g. so that we don't have to separately solve the same problem
for other perf events:

https://lore.kernel.org/all/3585d823-00f3-46ae-a799-b62a95743e76@linux.intel.com
