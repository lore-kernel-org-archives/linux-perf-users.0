Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16FE477E37;
	Wed, 23 Sep 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154815; cv=none; b=FTdx4vN1mdkc/qJCC916+FtaqlUDpOApWIvDeAZ5uvcSz8pcZ5qdzem/noxyGlwcuY0jh21qtSLLU/HvRAK4pcvTeNUOg3qQ2fdeDVQ8btEVjHjLiMSeJWmokW6GOX1v3v2lC+D03TAlmPe8bP2ctupn/WW7uNw+Qd/baobE9SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154815; c=relaxed/simple;
	bh=TsIuNm5jFryvz4LLPwlBrr1EE8osp13D6JiRN6bqtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnNsAdK/ZU3WT7oIrDffEHcEG6pWxLvpOlASLf6i4lbWDFZcfd6kC93xT6pafs7W426TMX/S7zi0LdgpdZBrA37LxjPmQkVFKem7O1oIYzXPxs+O2wzsN1HzTvAm/wEhCDMBWrX+0kWNDUs5xP1ivXDVMwTwXttKB5AFTyh27O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hkPlCmYJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkPlCmYJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JUBiUwkLuqf7ZmJwTiYj7Qrw6wUl0OXzxMNYxraTk/E=; b=hkPlCmYJFsdy/YK0RkiVRAqWXB
	GzN0N/P1H7rVpbCKkSBKwCjJL9JoNKKJY176lqHON8IhJSZxww3F65ZRpxJQE24HF6Te/2Tz+4yL2
	M9k7nLlCyGisi29RVxoORbnQc+uFsG1ZaxHxALW0vpiaw1HKkxiGTDVC5iJ36nz4TXWbZP4FsJ99B
	q/Lnw50Z+ezeL8gfcCvTOs6oZC4ucrrS2TAD2PqpYvdS9D5f6TDYy9J2r5jOpMKTnouGZspPxaJvV
	tHNZTq5BE7DsXbs/kdAAgWVxjyFyA9diGfIgFOu4s17B3zCYLaFCC5XQDgQkJiwRSS+SF5rvygQhl
	tCTrfxgw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9J2X-0000000CW22-0qbV;
	Wed, 23 Sep 2026 09:13:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 362833006DD; Wed, 23 Sep 2026 11:13:20 +0200 (CEST)
Date: Wed, 23 Sep 2026 11:13:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, x86@kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 03/13] x86/hw_breakpoints: Make DR7 updates NMI safe
Message-ID: <20260923091320.GW776954@noisy.programming.kicks-ass.net>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005111951.388919.3131603399440492416.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179005111951.388919.3131603399440492416.stgit@devnote2>

On Tue, Sep 22, 2026 at 01:25:19PM +0900, Masami Hiramatsu (Google) wrote:
> From: Jinchao Wang <wangjinchao600@gmail.com>
> 
> Hardware breakpoint installation and removal run with IRQs disabled, but
> an NMI can still enter the same code through KGDB. The interrupted
> operation and the NMI can consequently claim the same slot or overwrite
> each other's DR7 state.
> 
> Claim and release per-CPU slots with cmpxchg. Update cpu_dr7 with
> single-instruction per-CPU operations, and preserve hardware-first
> disable and hardware-last enable ordering. Add a per-CPU sequence number
> so interrupted DR7 writers and restore paths detect an NMI update and
> retry from the latest shadow state.

Bah, KGDB.. Aren't there far more problems with that thing? 


> diff --git a/arch/x86/include/asm/debugreg.h b/arch/x86/include/asm/debugreg.h
> index 854d82b88ff4..515d2d313d0c 100644
> --- a/arch/x86/include/asm/debugreg.h
> +++ b/arch/x86/include/asm/debugreg.h
> @@ -18,6 +18,7 @@
>  #define DR7_FIXED_1	0x00000400
>  
>  DECLARE_PER_CPU(unsigned long, cpu_dr7);
> +DECLARE_PER_CPU(unsigned int, cpu_dr7_seq);

Would it make sense to:

typedef struct {
	unsigned long dr7;
	unsigned int  seq;
} dr7_save_t;


>  #ifndef CONFIG_PARAVIRT_XXL
>  /*
> @@ -125,40 +126,69 @@ static __always_inline bool hw_breakpoint_active(void)
>  
>  extern void hw_breakpoint_restore(void);
>  
> -static __always_inline unsigned long local_db_save(void)
> +static __always_inline void local_db_save(unsigned long *dr7,
> +					  unsigned int *dr7_seq)

static __always_inline dr7_save_t local_db_save(void)

>  {

>  }
>  
> -static __always_inline void local_db_restore(unsigned long dr7)
> +static __always_inline void local_db_restore(unsigned long dr7,
> +					     unsigned int dr7_seq)

static __always_inline void local_db_restore(dr7_save_t dr7)

>  {

>  }
>  
>  #ifdef CONFIG_CPU_SUP_AMD

> diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> index 0473a5c95856..901323ae7d6a 100644
> --- a/arch/x86/kernel/hw_breakpoint.c
> +++ b/arch/x86/kernel/hw_breakpoint.c

> @@ -106,32 +108,25 @@ int arch_install_hw_breakpoint(struct perf_event *bp)

> +	do {
> +		seq = this_cpu_inc_return(cpu_dr7_seq);
> +		this_cpu_write(cpu_debugreg[i], info->address);
> +		barrier();
> +		set_debugreg(info->address, i);
> +		if (info->mask)
> +			amd_set_dr_addr_mask(info->mask, i);
> +		this_cpu_or(cpu_dr7, encode_dr7(i, info->len, info->type));
> +		barrier();
> +		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
> +		barrier();
> +	} while (seq != this_cpu_read(cpu_dr7_seq));
>  
>  	return 0;
>  }
> @@ -149,36 +144,34 @@ void arch_uninstall_hw_breakpoint(struct perf_event *bp)

> +	do {
> +		seq = this_cpu_inc_return(cpu_dr7_seq);
> +		dr7 = this_cpu_read(cpu_dr7);

You're inconsistent with the leading barrier(). 

> +		dr7 &= ~__encode_dr7(i, info->len, info->type);
> +		set_debugreg(dr7 | DR7_FIXED_1, 7);
> +		if (info->mask)
> +			amd_set_dr_addr_mask(0, i);
> +		barrier();
> +		this_cpu_and(cpu_dr7,
> +			     ~__encode_dr7(i, info->len, info->type));
> +		barrier();
> +	} while (seq != this_cpu_read(cpu_dr7_seq));
> +
> +	WARN_ONCE(this_cpu_cmpxchg(bp_per_reg[i], bp, NULL) != bp,
> +		  "Can't release breakpoint slot");
>  }

These loops should be far more similar. Note how the top one does:

	this_cpu_or(cpu_dr7, encode_dr7(...));
	set_debugreg(this_cpu_read(cpu_dr7) | ..., 7);

while the bottom one does:

	dr7 &= ~encode_dr7(...)
	set_debugreg(dr7 | ...);
	this_cpu_and(cpu_dr7, ~encode_dr7(...));

Why can't they both have the same shape and only one encode_dr7()
instance?


> @@ -486,12 +480,18 @@ void flush_ptrace_hw_breakpoint(struct task_struct *tsk)
>  
>  void hw_breakpoint_restore(void)
>  {
> +	unsigned int seq;
> +
> +	do {
> +		seq = this_cpu_inc_return(cpu_dr7_seq);

no barrier().

> +		set_debugreg(this_cpu_read(cpu_debugreg[0]), 0);
> +		set_debugreg(this_cpu_read(cpu_debugreg[1]), 1);
> +		set_debugreg(this_cpu_read(cpu_debugreg[2]), 2);
> +		set_debugreg(this_cpu_read(cpu_debugreg[3]), 3);
> +		set_debugreg(DR6_RESERVED, 6);
> +		set_debugreg(this_cpu_read(cpu_dr7) | DR7_FIXED_1, 7);
> +		barrier();
> +	} while (seq != this_cpu_read(cpu_dr7_seq));
>  }
>  EXPORT_SYMBOL_FOR_KVM(hw_breakpoint_restore);

I really can't say I'm a fan of this. Is KGDB really a thing?
