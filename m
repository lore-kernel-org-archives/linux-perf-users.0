Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6E62FF65B;
	Fri,  5 Dec 2025 08:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764924154; cv=none; b=K5vZa8KofEo0O+YOLDdjcsZrvjGRchl48fymHztgtFZ9B++R01HD9jtT+sZdZAho1OnOt+A1Ni+WXCz37RZdeeLlK6mjcAa+r5RrRyVdxxbytfBjiszyHpJwq715UmzkNaVpq1acTSwyzabCKnEpa4Efs64TXvtVQuvoVvJA1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764924154; c=relaxed/simple;
	bh=3uw1xZVThmLTt6IH55Wzrhm7fZLK+nZGWYkXQXBQ2SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WADIVg0IxKMMNA6z1BUUJuMNqOU7pX3EFKxwjUc/Ydem2j55wYUvgJZ3OObRXuZ3HIWxWsnPPoTR8nv/5KrKPcnThS00cF+5JcxYT3kCgaZRCPj5pX6B+LmwT+55gyaB0QjdiesLgsloS0kQcqX3tMhaBIJvOpoO0jkSOvzSCmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CAnb2V0V; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CAnb2V0V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kjHdEon8tZpsl3f+ysIHwl9o+xzQtWZAdYgu7tsfbsA=; b=CAnb2V0V+FKTj0Jwrz/feVK1UF
	HuimdLfXbEuEJtk0/dOzgf+UCoMExyrv7zulX1l6ULvgArak3jr5w0uLiB2TywsTOs/8l9YmNuhKd
	leZDOpOns/hE8/YV88cN1IdFFyztlrqIx9oA4+jATuX6jQcRtgZal7a6xcFa9IKXqa+EZlPgULWjB
	ywSi1qIrJ/zMvDV6v9sJcojIFLZAF9UsAK3EmJtxRXk+f3fMUmD5CAT525oXUciN2slgy9muaT6Qp
	yz48akFsqSLzueyOIuonkgG3wOn3vtEcYYupg5vCsS8zQ3lUCJwZF+gzTs5AkvKY6GlpCYsYskf1r
	ubpoutTA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRQWi-00000005dZu-0r6t;
	Fri, 05 Dec 2025 07:46:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EB3ED300237; Fri, 05 Dec 2025 09:42:09 +0100 (CET)
Date: Fri, 5 Dec 2025 09:42:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [Patch v5 06/19] perf/x86: Add support for XMM registers in
 non-PEBS and REGS_USER
Message-ID: <20251205084209.GP2528459@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-7-dapeng1.mi@linux.intel.com>
 <20251204151735.GO2528459@noisy.programming.kicks-ass.net>
 <f4521211-b8e2-41a6-9ae1-cfedcb8dd7b2@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4521211-b8e2-41a6-9ae1-cfedcb8dd7b2@intel.com>

On Thu, Dec 04, 2025 at 10:59:15AM -0800, Dave Hansen wrote:
> On 12/4/25 07:17, Peter Zijlstra wrote:
> >> - Additionally, checking the TIF_NEED_FPU_LOAD flag alone is insufficient.
> >>   Some corner cases, such as an NMI occurring just after the flag switches
> >>   but still in kernel mode, cannot be handled.
> > Urgh.. Dave, Thomas, is there any reason we could not set
> > TIF_NEED_FPU_LOAD *after* doing the XSAVE (clearing is already done
> > after restore).
> > 
> > That way, when an NMI sees TIF_NEED_FPU_LOAD it knows the task copy is
> > consistent.
> 
> Something like the attached patch?
> 
> I think that would be just fine. save_fpregs_to_fpstate() doesn't
> actually change the need for TIF_NEED_FPU_LOAD, so I don't think the
> ordering matters.

Right, I missed this one. And yes, I couldn't find any site where this
ordering mattered either. Its all with interrupts disabled, so normally
it all goes together. Only the NMI could observe the difference.

> diff --git a/arch/x86/include/asm/fpu/sched.h b/arch/x86/include/asm/fpu/sched.h
> index 89004f4ca208..2d57a7bf5406 100644
> --- a/arch/x86/include/asm/fpu/sched.h
> +++ b/arch/x86/include/asm/fpu/sched.h
> @@ -36,8 +36,8 @@ static inline void switch_fpu(struct task_struct *old, int cpu)
>  	    !(old->flags & (PF_KTHREAD | PF_USER_WORKER))) {
>  		struct fpu *old_fpu = x86_task_fpu(old);
>  
> -		set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
>  		save_fpregs_to_fpstate(old_fpu);
> +		set_tsk_thread_flag(old, TIF_NEED_FPU_LOAD);
>  		/*
>  		 * The save operation preserved register state, so the
>  		 * fpu_fpregs_owner_ctx is still @old_fpu. Store the

