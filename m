Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEECF29B795;
	Thu, 24 Sep 2026 00:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211392; cv=none; b=W5gLdvWp4+3dFw6PsMgMR9BN5S6p7UuHXqM6PoC2cZ+56jfvzOU0s4brRAGkA+Ngs6V50tX3F1Bys3nNHSvataV5dYIyZq23x8Q5OHPpsMXgc7UenUqthxoZ/tvEFaRKMkEM9RrINP2pv28IQuAzf4tYbDJnqycJqxt1Yfk9tyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211392; c=relaxed/simple;
	bh=jdXlTLlf3jUa4RrM2D3BUMVLd7xgVV710VYzNJz/Wog=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bpzmA1Ak8xTVj+lil/giKGHELUzK5lVz1Dh3TP7Ty/GXb8B9RQ7XkrJ6AGiFAXDj/gxKaAuVpvhaf9Goy1gJOWqWTDRkrkodPMFt0owhoWPt6X9Jb170IcSVkV5SIk2xn1pR5RfyFqN/Tw4WD8Hy1A+IVmXCtibqkYC8e3Jd/oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mppRpFV4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mppRpFV4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639731F000FF;
	Thu, 24 Sep 2026 00:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790211390;
	bh=WoXa/iDV2HbrHjZ10qYpEVqoIC06vqPR1blppfOnTQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mppRpFV4LdabrXVBTFLP+RFdG191JPBsakD697PStifVFP2iTUSoZVhATEvbkWa/d
	 5qtCrwC3zblD+2DXxI+BQz6vTxr3ptzPStQpiQpPkEBVhS3tRhl3AuLlG8vPkD0YKC
	 QmWgtqm8yf22rN4Skj7F+JgoidaQ042cZtTfqWg3cpXbA6D0MVEqqWyen/Lf1Qax1b
	 firJhOlLSJnJtCeU2qIe2X/IyWpKaaFHMBpmwUA5ZlGpHXt4nBMb6og9Z3v+9+jSHq
	 PO/EH9R2HP+KZWSiwdUJKzeQgknj1WrLYqlz5vnFcFZxEE75LE74gSeiksQCsQFWvB
	 U10sVNTDl7L8A==
Date: Thu, 24 Sep 2026 09:56:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar
 <mingo@kernel.org>, Jinchao Wang <wangjinchao600@gmail.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Thomas Gleixner
 <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers
 <irogers@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-perf-users@vger.kernel.org, x86@kernel.org, Paolo Bonzini
 <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v17 02/13] perf/x86, KVM: Prevent host debug register
 leak into guest OS on NMI
Message-Id: <20260924095624.dfb77a8a1dd95a957b45f12c@kernel.org>
In-Reply-To: <arPw-N3HF3ehNGTQ@google.com>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
	<179005110742.388919.1509641807739909065.stgit@devnote2>
	<20260923091555.GX776954@noisy.programming.kicks-ass.net>
	<arPw-N3HF3ehNGTQ@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Sep 2026 08:32:08 -0700
Sean Christopherson <seanjc@google.com> wrote:

> On Wed, Sep 23, 2026, Peter Zijlstra wrote:
> > On Tue, Sep 22, 2026 at 01:25:07PM +0900, Masami Hiramatsu (Google) wrote:
> > > diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
> > > index f846c15f21ca..0473a5c95856 100644
> > > --- a/arch/x86/kernel/hw_breakpoint.c
> > > +++ b/arch/x86/kernel/hw_breakpoint.c
> > > @@ -102,6 +102,9 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
> > >  
> > >  	lockdep_assert_irqs_disabled();
> > >  
> > > +	if (perf_guest_in_guest())
> > 
> > That naming is hilariously bad :-)

Agreed.

> 
> Indeed.  It's also misleading and confusing, because it's really checking for
> "in KVM's core run loop", whereas the goal of perf_guest_state() returns a
> non-zero value if and only if the IRQ/NMI really did occur while the guest was
> active (I say "the goal" because it's imperfect due to architectural limitations,
> but the goal is purely to detect guest PMIs).

Yeah, I see.

> 
> Ugh, and routing this through perf was my suggestion[*]:
> 
>   : If we decide this is how to fix arch_install_hw_breakpoint() clobbering DRs from
>   : NMI context, I would rather have more generic flag to tell perf that KVM is about
>   : to enter the guest, e.g. so that we don't have to separately solve the same problem
>   : for other perf events:
> 
> After seeing the code, that feels like a pretty stupid suggestion.  Though in my
> defense, I was thinking of a per-CPU flag as opposed to a new callback.  Anyways,
> I don't think we should key off IN_GUEST_MODE and EXITING_GUEST_MODE because they
> are very much an arch-specific, KVM-internal concept.

OK.

> 
> What I was trying to say by "more generic flag" is that I would prefer not to have
> a super specific cpu_dr_in_guest.  I'm not opposed to have a dedicated flag (though
> if we can avoid one, that would be lovely).  The biggest problem I see with adding
> a generic flag is how to make it precise enough to be useful, without end up with a
> confusing name.  E.g. "guest_state_loaded" is terrible because KVM keeps some guest
> state loaded even when the task is scheduled out.

Something like "cpu_in_guest_transition"?

> 
> And to Peter's point below, is arch_install_hw_breakpoint() even the right place
> to handle this?  It seems like KGDB itself should be handling this, at which point
> maybe we just do something like this?  Then we can provide nop stubs when KGDB
> support is disabled.

Hmm, so instead of kgdb specific flag, add a per-cpu flag for entering/exiting
guest, and use it for kgdb and other users like wprobe? (it may work similar to
in_nmi() check.)

> 
> diff --git arch/x86/kvm/x86.c arch/x86/kvm/x86.c
> index 1705e7be46ec..42fa4dc44cbc 100644
> --- arch/x86/kvm/x86.c
> +++ arch/x86/kvm/x86.c
> @@ -8273,6 +8273,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  
>         kvm_load_xfeatures(vcpu, true);
>  
> +       kgdb_arch_enter_guest();
> +
>         if (unlikely(vcpu->arch.switch_db_regs &&
>                      !(vcpu->arch.switch_db_regs & KVM_DEBUGREG_AUTO_SWITCH))) {
>                 set_debugreg(DR7_FIXED_1, 7);
> @@ -8365,6 +8367,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>         if (hw_breakpoint_active())
>                 hw_breakpoint_restore();
>  
> +       kgdb_arch_exit_guest();
> +
>         vcpu->arch.last_vmentry_cpu = vcpu->cpu;
>         vcpu->arch.last_guest_tsc = kvm_read_l1_tsc(vcpu, rdtsc());
>  
> [*] https://lore.kernel.org/all/aqgGRKOE138ePqmX@google.com
> 
> > > +		return -EBUSY;
> > > +
> > >  	for (i = 0; i < HBP_NUM; i++) {
> > >  		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
> > >  
> > 
> > Note how the other -EBUSY return is a WARN. Why is silently not doing
> > anything not a WARN in this case?
> 
> Probably because the WARN would trigger anytime KGDB's NMI craziness happens to
> hit a vCPU, i.e. isn't a kernel bug.

Yeah, this may confuse the caller. OK, let me change it to check
the state flag in caller side.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
