Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DD2D94AB;
	Thu,  4 Dec 2025 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764863253; cv=none; b=Cw+cuPCX14VCEC+rdNgMaGp9ZiAnwWNGLb8Enp+aFwWU3hy++BU9CPOSYY0XksYAfSGRgsewS2sUEdgf82+SeNA0IAJ97fgweVQymA/Nekmur1MCXbddV2OdKpKRbhiqTK/8KEli6vng/vZ8qyT6Yd5OJZA7vaM6cQHIztV6XVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764863253; c=relaxed/simple;
	bh=5eihp2HgQ0ga+OOHRT9lJBRLtzv87azOWrTbcYMCu7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTzqwQS7UIwijA61Bt+dCKtw8XQhHnWfnLq7cDyBd0Yx64f2JvhiFzGyMPvZDy8T6bpUNEuALmUkv3WQen2/gdpM4+tNmw/uBlXfn9PkTZb8rOTdwcNdusqtv/yjo0sD+URNKumcImt3OpIvmRIk1g3rz76EMoLR/6NYsPMEmgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S0xdTvOh; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S0xdTvOh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cySWC8Qsyj3igeThyd58EBHBDsIMDERk6kMrb8LMWzY=; b=S0xdTvOhJeJlrxY5guySgb9zCP
	NQOmHRRxddQMQLhLoVt0OqUw4/KFCTWwPTBW939w7xCUbyAoQQVdQmMG19Kwrr8yUKEbrNQ1lw/d/
	PzkbkeBY5g/2DorOGqih/DQvwJxLjcxgUJr6c4xze1oSizaZ/P09pMslH3flTlJimZAeirlk53sbJ
	lpzocVMPvclwRAAy5BUTWmJaOs7juXEEsQLisxmHXrDcDzOW+BQYe1yPCTACkU4ykFmYFM4zOQIFU
	aJvsnRX+y8NXe0KTy8emSgMBd0P+L8uADtm3xxV/1EYUzEx5fQZtcN2WeJnLJIBiQFcFbh1Tv9F4f
	aiZvFwDQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRAgc-00000004Lfg-1xYN;
	Thu, 04 Dec 2025 14:52:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 676C33004B8; Thu, 04 Dec 2025 16:47:21 +0100 (CET)
Date: Thu, 4 Dec 2025 16:47:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <20251204154721.GB2619703@noisy.programming.kicks-ass.net>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-7-dapeng1.mi@linux.intel.com>
 <20251204151735.GO2528459@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204151735.GO2528459@noisy.programming.kicks-ass.net>

On Thu, Dec 04, 2025 at 04:17:35PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 03, 2025 at 02:54:47PM +0800, Dapeng Mi wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > While collecting XMM registers in a PEBS record has been supported since
> > Icelake, non-PEBS events have lacked this feature. By leveraging the
> > xsaves instruction, it is now possible to snapshot XMM registers for
> > non-PEBS events, completing the feature set.
> > 
> > To utilize the xsaves instruction, a 64-byte aligned buffer is required.
> > A per-CPU ext_regs_buf is added to store SIMD and other registers, with
> > the buffer size being approximately 2K. The buffer is allocated using
> > kzalloc_node(), ensuring natural alignment and 64-byte alignment for all
> > kmalloc() allocations with powers of 2.
> > 
> > The XMM sampling support is extended for both REGS_USER and REGS_INTR.
> > For REGS_USER, perf_get_regs_user() returns the registers from
> > task_pt_regs(current), which is a pt_regs structure. It needs to be
> > copied to user space secific x86_user_regs structure since kernel may
> > modify pt_regs structure later.
> > 
> > For PEBS, XMM registers are retrieved from PEBS records.
> > 
> > In cases where userspace tasks are trapped within kernel mode (e.g.,
> > during a syscall) when an NMI arrives, pt_regs information can still be
> > retrieved from task_pt_regs(). However, capturing SIMD and other
> > xsave-based registers in this scenario is challenging. Therefore,
> > snapshots for these registers are omitted in such cases.
> > 
> > The reasons are:
> > - Profiling a userspace task that requires SIMD/eGPR registers typically
> >   involves NMIs hitting userspace, not kernel mode.
> > - Although it is possible to retrieve values when the TIF_NEED_FPU_LOAD
> >   flag is set, the complexity introduced to handle this uncommon case in
> >   the critical path is not justified.
> > - Additionally, checking the TIF_NEED_FPU_LOAD flag alone is insufficient.
> >   Some corner cases, such as an NMI occurring just after the flag switches
> >   but still in kernel mode, cannot be handled.
> 
> Urgh.. Dave, Thomas, is there any reason we could not set
> TIF_NEED_FPU_LOAD *after* doing the XSAVE (clearing is already done
> after restore).
> 
> That way, when an NMI sees TIF_NEED_FPU_LOAD it knows the task copy is
> consistent.
> 
> I'm not at all sure this is complex, it just needs a little care.
> 
> And then there is the deferred thing, just like unwind, we can defer
> REGS_USER/STACK_USER much the same, except someone went and built all
> that deferred stuff with unwind all tangled into it :/

With something like the below, the NMI could do something like:

	struct xregs_state *xr = NULL;

	/*
	 * fpu code does:
	 *  XSAVE
	 *  set_thread_flag(TIF_NEED_FPU_LOAD)
	 *  ...
	 *  XRSTOR
	 *  clear_thread_flag(TIF_NEED_FPU_LOAD)
	 * therefore, when TIF_NEED_FPU_LOAD, the task fpu state holds a
	 * whole copy.
	 */
	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
		struct fpu *fpu = x86_task_fpu(current);
		/*
		 * If __task_fpstate is set, it holds the right pointer,
		 * otherwise fpstate will.
		 */
		struct fpstate *fps = READ_ONCE(fpu->__task_fpstate);
		if (!fps)
			fps = fpu->fpstate;
		xr = &fps->regs.xregs_state;
	} else {
		/* like fpu_sync_fpstate(), except NMI local */
		xsave_nmi(xr, mask);
	}

	// frob xr into perf data

Or did I miss something? I've not looked at this very long and the above
was very vague on the actual issues.


diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index da233f20ae6f..0f91a0d7e799 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -359,18 +359,22 @@ int fpu_swap_kvm_fpstate(struct fpu_guest *guest_fpu, bool enter_guest)
 	struct fpstate *cur_fps = fpu->fpstate;
 
 	fpregs_lock();
-	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD))
+	if (!cur_fps->is_confidential && !test_thread_flag(TIF_NEED_FPU_LOAD)) {
 		save_fpregs_to_fpstate(fpu);
+		set_thread_flag(TIF_NEED_FPU_LOAD);
+	}
 
 	/* Swap fpstate */
 	if (enter_guest) {
-		fpu->__task_fpstate = cur_fps;
+		WRITE_ONCE(fpu->__task_fpstate, cur_fps);
+		barrier();
 		fpu->fpstate = guest_fps;
 		guest_fps->in_use = true;
 	} else {
 		guest_fps->in_use = false;
 		fpu->fpstate = fpu->__task_fpstate;
-		fpu->__task_fpstate = NULL;
+		barrier();
+		WRITE_ONCE(fpu->__task_fpstate, NULL);
 	}
 
 	cur_fps = fpu->fpstate;
@@ -456,8 +460,8 @@ void kernel_fpu_begin_mask(unsigned int kfpu_mask)
 
 	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
 	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
-		set_thread_flag(TIF_NEED_FPU_LOAD);
 		save_fpregs_to_fpstate(x86_task_fpu(current));
+		set_thread_flag(TIF_NEED_FPU_LOAD);
 	}
 	__cpu_invalidate_fpregs_state();
 
