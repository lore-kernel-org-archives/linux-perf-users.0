Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5494136654F;
	Thu, 24 Sep 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254613; cv=none; b=jTmBJOf2gCl9Hw/FR/DAbz+BKZC8PqchCH+Euo1SBZpVabAaPkg4hGIHt2kmzDI28UDMQPvTz/GI7EV99JNzGzEpLN/fIh0oRmICa9lsC1KNorJuwpcoPo8VSfwcRBeUaZcUjmIim5Sjd1JpBwX8yDy12pmDfXoHXtPWtJFUx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254613; c=relaxed/simple;
	bh=/wPSn5TX/IfDvUO2b11sC+pew1vT0U/jfmKRpqjH8bg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jg+Uyz9lHU5Q5QTNi2cmDEMPPifBjw5VrQcFITSkr+Y/6YJzFOe8uimW32wv8JjrVqVrW7d8Fy1uo7O59v82JG3B6P6bCj5qY24Pz5wo1GYhp9zrgU2rXub4+35ZbAHOzNmRY1bMvoOHu1jkuZuq/CDYgYD5PUZIfKq/InK9sm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2gbq8FS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2gbq8FS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A2121F000FF;
	Thu, 24 Sep 2026 12:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254612;
	bh=caS7YkmtkK38DSAKPTLNPWgx0PGnx+hGOkLr7fr36iA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J2gbq8FSRDIwO5Trd3Hsu3/voYWx+jQ9oTWqSMgj2WrNxOwnrnvOsTzftNuUpEq58
	 XkDQzuDlme5UKvo2O3xcc/i3+ki8DVov16hEwXzAs0d8SKlSGJvIZLt2D9RGgmoXs9
	 ibOiU78BDtKirFKscCTWf6dD+XJiFWdPkXCiI/dVDRb/0VVAMyzlu4LD8CAqN38STC
	 eSu8OkBcS0dCzaDawt8NCOTMfOzmfLNtjRBcdx7H1ULIfZhNQbpeacYcyxPanbgWqR
	 1nBH4rSCdYPYiT4hBPEeW8caZHtgaQPFJnJ1UCKnP4BFTGzqySZdXTLPWW9CxakM/A
	 V4rJqpdm1MSZw==
Date: Thu, 24 Sep 2026 21:56:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
 Sean Christopherson <seanjc@google.com>, Jinchao Wang
 <wangjinchao600@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Thomas Gleixner <tglx@linutronix.de>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org,
 x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 03/13] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-Id: <20260924215646.be6a2abb78f3243cef008919@kernel.org>
In-Reply-To: <20260923091320.GW776954@noisy.programming.kicks-ass.net>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
	<179005111951.388919.3131603399440492416.stgit@devnote2>
	<20260923091320.GW776954@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 11:13:20 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 22, 2026 at 01:25:19PM +0900, Masami Hiramatsu (Google) wrote:
> > From: Jinchao Wang <wangjinchao600@gmail.com>
> > 
> > Hardware breakpoint installation and removal run with IRQs disabled, but
> > an NMI can still enter the same code through KGDB. The interrupted
> > operation and the NMI can consequently claim the same slot or overwrite
> > each other's DR7 state.
> > 
> > Claim and release per-CPU slots with cmpxchg. Update cpu_dr7 with
> > single-instruction per-CPU operations, and preserve hardware-first
> > disable and hardware-last enable ordering. Add a per-CPU sequence number
> > so interrupted DR7 writers and restore paths detect an NMI update and
> > retry from the latest shadow state.
> 
> Bah, KGDB.. Aren't there far more problems with that thing? 

Yes, it could be... Hmm, it looks like we need to take a closer
look at other issues related to KGDB as well.

> 
> 
> > diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> > index 854d82b88ff4..515d2d313d0c 100644
> > --- a/arch/x86/include/asm/debugreg.h
> > +++ b/arch/x86/include/asm/debugreg.h
> > @@ -18,6 +18,7 @@
> >  #define DR7_FIXED_1	0x00000400
> >  
> >  DECLARE_PER_CPU(unsigned long, cpu_dr7);
> > +DECLARE_PER_CPU(unsigned int, cpu_dr7_seq);
> 
> Would it make sense to:
> 
> typedef struct {
> 	unsigned long dr7;
> 	unsigned int  seq;
> } dr7_save_t;

Yeah, thanks for the good idea :)

> 
> 
> >  #ifndef CONFIG_PARAVIRT_XXL
> >  /*
> > @@ -125,40 +126,69 @@ static __always_inline bool hw_breakpoint_active(void)
> >  
> >  extern void hw_breakpoint_restore(void);
> >  
> > -static __always_inline unsigned long local_db_save(void)
> > +static __always_inline void local_db_save(unsigned long *dr7,
> > +					  unsigned int *dr7_seq)
> 
> static __always_inline dr7_save_t local_db_save(void)
> 
> >  {
> 
> >  }
> >  
> > -static __always_inline void local_db_restore(unsigned long dr7)
> > +static __always_inline void local_db_restore(unsigned long dr7,
> > +					     unsigned int dr7_seq)
> 
> static __always_inline void local_db_restore(dr7_save_t dr7)
> 
> >  {
> 
> >  }
> >  
> >  #ifdef CONFIG_CPU_SUP_AMD
> 
> > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > index 0473a5c95856..901323ae7d6a 100644
> > --- a/arch/x86/kernel/hw_breakpoint.c
> > +++ b/arch/x86/kernel/hw_breakpoint.c
> 
> > @@ -106,32 +108,25 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> 
> > +	do {
> > +		seq = this_cpu_inc_return(cpu_dr7_seq);
> > +		this_cpu_write(cpu_debugreg[i], info->address);
> > +		barrier();
> > +		set_debugreg(info->address, i);
> > +		if (info->mask)
> > +			amd_set_dr_addr_mask(info->mask, i);
> > +		this_cpu_or(cpu_dr7, encode_dr7(i, info->len, info->type));
> > +		barrier();
> > +		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
> > +		barrier();
> > +	} while (seq != this_cpu_read(cpu_dr7_seq));
> >  
> >  	return 0;
> >  }
> > @@ -149,36 +144,34 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)
> 
> > +	do {
> > +		seq = this_cpu_inc_return(cpu_dr7_seq);
> > +		dr7 = this_cpu_read(cpu_dr7);
> 
> You're inconsistent with the leading barrier(). 

Ah, OK.

> 
> > +		dr7 &= ~__encode_dr7(i, info->len, info->type);
> > +		set_debugreg(dr7 | DR7_FIXED_1, 7);
> > +		if (info->mask)
> > +			amd_set_dr_addr_mask(0, i);
> > +		barrier();
> > +		this_cpu_and(cpu_dr7,
> > +			     ~__encode_dr7(i, info->len, info->type));
> > +		barrier();
> > +	} while (seq != this_cpu_read(cpu_dr7_seq));
> > +
> > +	WARN_ONCE(this_cpu_cmpxchg(bp_per_reg[i], bp, NULL) != bp,
> > +		  "Can't release breakpoint slot");
> >  }
> 
> These loops should be far more similar. Note how the top one does:
> 
> 	this_cpu_or(cpu_dr7, encode_dr7(...));
> 	set_debugreg(this_cpu_read(cpu_dr7) | ..., 7);
> 
> while the bottom one does:
> 
> 	dr7 &= ~encode_dr7(...)
> 	set_debugreg(dr7 | ...);
> 	this_cpu_and(cpu_dr7, ~encode_dr7(...));
> 
> Why can't they both have the same shape and only one encode_dr7()
> instance?

Indeed. It should have the same shape.

> 
> 
> > @@ -486,12 +480,18 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
> >  
> >  void hw_breakpoint_restore(void)
> >  {
> > +	unsigned int seq;
> > +
> > +	do {
> > +		seq = this_cpu_inc_return(cpu_dr7_seq);
> 
> no barrier().
> 
> > +		set_debugreg(this_cpu_read(cpu_debugreg[0]), 0);
> > +		set_debugreg(this_cpu_read(cpu_debugreg[1]), 1);
> > +		set_debugreg(this_cpu_read(cpu_debugreg[2]), 2);
> > +		set_debugreg(this_cpu_read(cpu_debugreg[3]), 3);
> > +		set_debugreg(DR6_RESERVED, 6);
> > +		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
> > +		barrier();
> > +	} while (seq != this_cpu_read(cpu_dr7_seq));
> >  }
> >  EXPORT_SYMBOL_FOR_KVM(hw_breakpoint_restore);
> 
> I really can't say I'm a fan of this. Is KGDB really a thing?

No, I would like to drop this patch (and KVM patch)from this series
since wprobe is not supporting to set the DR7 from NMI context.

I think it is better to split the series into 2 threads,
 - wprobe related features/improvements. ([4/13]-[13/13])
 - NMI-safe DR7 for KGDB. ([2/13] and [3/13])

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
