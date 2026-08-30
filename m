Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B758B3F104C;
	Sun, 30 Aug 2026 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788068114; cv=none; b=b6fFNAf0yS3f7Uy1+2Hk/aKDUtKqDmngm+9UI6PvB4jQ+Ye+dvmJ0ZSLjWfECKwaGXnLLmGC8aeHxlfppwRL+eJzssdz8fILyh4t7PM5QUgQJyokRao6v6E5PLlxiCoXhA33DsKW8gWjr+xaJTReFGc7zs3DcJTf2BtZzjIUgt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788068114; c=relaxed/simple;
	bh=VZ/6roZBGSz+RN8ytXxzivU/IHRaLsw2q8iG6ckchyA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=aHEGPujVaXfX341p2gM+pWvqtUWpmOpq0IeX4GQ4XH/CMnKKfhCAGoAEML0KVbw2T+kHV5rtAFcfWili0Je0LtbbdxZ9d06mzg2cCuAYtr3b3kfmzqWNWUvUvNti5kyP81Ltz1H40qC073IYwdounElcjfH+7VHp2i8EfyOPBL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RabyRp6e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RabyRp6e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23081F000E9;
	Sun, 30 Aug 2026 05:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788068113;
	bh=OfcyBa6g3GlyYMSTvkUtDb1Jm2JpFQlqGt1iiYWJ7Do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RabyRp6enEo+N5DXek3DHfpxGqKhpfR2lFWJ/aeQJARx5vFDqVoq68sdJoMFG7tte
	 zDEC5Y6LrdcJSCtlGNzMUgnrXnsDOF0KPTmgcvwWJrfMo126q9CZrriPr9Dqqa4zsf
	 UbXQhHJmY5Z50Amp7++UrgTccAU1aG9M5Ae/0iIXmvPxdNnC9/rbkYG+WaPdFnVdef
	 Cb4SF3RJGoUP8Vp5k42GRJquc3mD8lN5PQNTSbb5BVnKzikCobVDUCnJjZcMX7OBTA
	 ORzE58ygVK7wnMYaCAMtceQKEgLcOcl2CtX47Q7VmOI3whKPHXpEoItiwkwNZr3Omg
	 BKEhMIJW/y8HQ==
Date: Sun, 30 Aug 2026 14:35:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: sashiko-bot@kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v13 02/12] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-Id: <20260830143509.12601f973b9eb2d5d716d489@kernel.org>
In-Reply-To: <20260822094107.349031F00A3A@smtp.kernel.org>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
	<178739056219.1520941.16843776326995549779.stgit@devnote2>
	<20260822094107.349031F00A3A@smtp.kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 22 Aug 2026 09:41:06 +0000
sashiko-bot@kernel.org wrote:

> > -static __always_inline void local_db_restore(unsigned long dr7)
> > +static __always_inline void local_db_restore(unsigned long dr7,
> > +					     unsigned int dr7_seq)
> >  {
> > +	unsigned int seq;
> > +
> >  	/*
> >  	 * Ensure the compiler doesn't raise this statement into
> >  	 * the critical section; enabling breakpoints early would
> >  	 * not be good.
> >  	 */
> >  	barrier();
> > -	if (dr7)
> > +
> > +	do {
> > +		seq = this_cpu_read(cpu_dr7_seq);
> > +		if (seq == dr7_seq) {
> > +			if (!dr7)
> > +				return;
> > +		} else {
> > +			dr7 = this_cpu_read(cpu_dr7);
> > +			if (!dr7)
> > +				dr7 = DR7_FIXED_1;
> > +		}
> > +
> >  		set_debugreg(dr7, 7);
> > +		barrier();
> > +	} while (unlikely(seq != this_cpu_read(cpu_dr7_seq)));
> >  }
> 
> [Severity: High]
> If KVM intentionally clears the hardware DR7 state to isolate the guest from
> host breakpoints before VMENTER without modifying the host's cpu_dr7 shadow
> state:
> 
> arch/x86/kvm/x86.c:vcpu_enter_guest() {
>     ...
>     if (unlikely(vcpu->arch.switch_db_regs &&
>                  !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
>         set_debugreg(DR7_FIXED_1, 7);
>     ...
>     } else if (unlikely(hw_breakpoint_active())) {
>         set_debugreg(DR7_FIXED_1, 7);
>     }
>     ...
> }
> 
> Could an NMI firing shortly after this permanently undo this isolation
> upon return?
> 
> If an NMI (such as a perf event) fires before vmlaunch/vmresume, exc_nmi
> calls local_db_save, saving dr7=0. If the NMI modifies a breakpoint,
> cpu_dr7_seq increments.
> 
> When exc_nmi calls local_db_restore, the sequence mismatch causes it to
> discard the saved dr7=0 state and instead unconditionally restore the host's
> active breakpoints (this_cpu_read(cpu_dr7)) to the hardware DR7. This could
> leak host hardware breakpoints into a KVM guest and cause unexpected #DB
> exceptions.

OK, this seems only happen when KGDB/KDB sets the watchpoint from
NMI context (right after KVM disables dr7 for transient to guest).
We can avoid this by early returning if dr7 == 0 in local_db_restore().
(But..., if user intensively set the dr7 in that timing, it will be
ignored.)

> 
> [ ... ]
> > diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> > index 9bba1e2f03af7..8dba9cd04bfa5 100644
> > --- a/arch/x86/kernel/cpu/mce/core.c
> > +++ b/arch/x86/kernel/cpu/mce/core.c
> [ ... ]
> > @@ -2139,20 +2139,22 @@ static __always_inline void exc_machine_check_user(struct pt_regs *regs)
> >  DEFINE_IDTENTRY_MCE(exc_machine_check)
> >  {
> >  	unsigned long dr7;
> > +	unsigned int dr7_seq;
> >  
> > -	dr7 = local_db_save();
> > +	local_db_save(&dr7, &dr7_seq);
> >  	exc_machine_check_kernel(regs);
> > -	local_db_restore(dr7);
> > +	local_db_restore(dr7, dr7_seq);
> >  }
> >  
> >  /* The user mode variant. */
> >  DEFINE_IDTENTRY_MCE_USER(exc_machine_check)
> >  {
> >  	unsigned long dr7;
> > +	unsigned int dr7_seq;
> >  
> > -	dr7 = local_db_save();
> > +	local_db_save(&dr7, &dr7_seq);
> >  	exc_machine_check_user(regs);
> > -	local_db_restore(dr7);
> > +	local_db_restore(dr7, dr7_seq);
> >  }
> 
> [Severity: High]
> This is a pre-existing issue, but does task migration during user-mode
> machine check exceptions corrupt hardware debug registers on the new CPU?
> 
> exc_machine_check_user invokes irqentry_exit_to_user_mode, which processes
> pending thread work (like TIF_NEED_RESCHED), enabling interrupts and allowing
> the task to be scheduled out and migrate to a new CPU:
> 
> CPU1
> exc_machine_check()
>     local_db_save(&dr7, &dr7_seq);
>     exc_machine_check_user(regs)
>         irqentry_exit_to_user_mode(regs)
>             // Task migrates to CPU2
> 
> CPU2
>     local_db_restore(dr7, dr7_seq);
> 
> When it resumes on the new CPU, local_db_restore is executed with the dr7
> and dr7_seq values saved from the old CPU. If the new CPU's cpu_dr7_seq
> matches the old CPU's saved dr7_seq, it would erroneously write the old CPU's
> hardware DR7 state to the new CPU's hardware DR7 register. Could this cause
> spurious #DB exceptions or break hardware breakpoints on the new CPU?

OK, this is another problem to be fixed in a bugfix patch. We should do
local_db_save/restore() inside exc_machine_check_user() before calling
irqentry_exit_to_user_mode().

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
