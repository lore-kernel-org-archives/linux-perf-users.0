Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794105698;
	b=ZDtTIwKHH6b2WcxwdaYK2zt1Z5I2DdEmX+6iksRIoQzHkoRTOE7FJXXGj94QFN5bZxFR
	 JVBmhBlYXXaTtsv0qYGEATW0Xphopz+4Rrg5hEcYs5Yb5YbeU5O/pjYaKT+RlysSyQbJb
	 t3RxQ/9OYThiiLa8203VVUhssLkGM5JLFGpkVVeV0Ae+d7+IIWms1qgi5bplyc+nl9ViE
	 /ow40LPH478WvwG5K226UjKxhLizgE6AffhBHwQ3KHpikYfhnhXefvHOFwXZpJ+izfmhM
	 xr1ec8kwvapp/J9Tgb0aKWvXCu6aLfbpjI5LbnUH2my41ZNYEdNknOHVzgV2mH4O+Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794105698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Kf+6PZjys2Xut4mx+fifSXamBJdpHDZB6TJ36IBUsJ8=;
	b=oevzJZ6bx+1/x2dyvmeNOTQ4iAWbEvcadnhB10LC3fM6YtmtP9nHJDG6nWBs++kvyAVN
	 VAKknsxiduQdZYJqqHgGGx+FmsOGHeCKSF8nsxDuyD9SQTY9wTVRpAIhFzOQgDwKK0OF4
	 8OayiK+kgzdOMYXQklK3bAOtUV3+X+3GIJwHvodokG99pNx4hbFJAadVXjm7F4yKnNHbb
	 j+kmq2/pz4Us0pxn79EGbpwnW3j3o2ijobzVg0ppoalIzNLCvI+yZOMevkUn5SdFGY7t/
	 XYEqanmy63RI4cik7TS+g6P2iSzGZi8dpUnLyfQooNI6joq8cMM650NGBsP2VZr1BDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB0NcMOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B7606A31A
	for <linux-perf-users@vger.kernel.org>; Sun,  8 Nov 2026 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bB0NcMOt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C671F008A3;
	Sun,  8 Nov 2026 02:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794105697;
	bh=Kf+6PZjys2Xut4mx+fifSXamBJdpHDZB6TJ36IBUsJ8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bB0NcMOt0s9iJy+XpzEpAzuBB9P70XuU28qNAL+49FZ85MslZnzbFBpSnHPjCLN5x
	 gpMIFydbsNbuNsAAMik/mvRQexDj8oDK/cH3nmS1oAUYCwyXjErVXso6e8YzKllM+U
	 dHwumESx/ACvXZasifg1muKOnO7OiiXAo4Gi3erlRcGZfmfet4tL5Nu77rGJ+VAugI
	 LU61/wR6IT/Grzv4NGC/JhN4/vV/S4Su8DfVLzuzH4g6z0aN5pGjPi95ur4KSnusvx
	 4aheXZsKKOKGGO/IFrpIwagRDWztEpwT1aDufgdd0ww8rERuc24vqDZmH1smMG0zkN
	 hK5GSCon/ie3w==
Message-ID: <sashiko-outbox-203524@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/8] riscv: add ptrace requests for hardware
 breakpoints
Reply-To: sashiko-reviews@lists.linux.dev
To: "Himanshu Chauhan" <himanshu.chauhan@oss.qualcomm.com>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>
Cc: "Alexandre Ghiti" <alex@ghiti.fr>, "Jesse Taube" <jtaubepe@redhat.com>, "Oleg
 Nesterov" <oleg@redhat.com>, "Kees Cook" <kees@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Namhyung
 Kim" <namhyung@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "Alexander
 Shishkin" <alexander.shishkin@linux.intel.com>, "Jiri Olsa" <jolsa@kernel.org>, "Ian
 Rogers" <irogers@google.com>, "Adrian Hunter" <adrian.hunter@intel.com>, "James
 Clark" <james.clark@linaro.org>, "Shuah Khan" <shuah@kernel.org>, linux-mm@kvack.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20261107023917.40606-4-himanshu.chauhan@oss.qualcomm.com>
References: <20261107023917.40606-1-himanshu.chauhan@oss.qualcomm.com>
 <20261107023917.40606-4-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 02:41:36 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] riscv: ptrace: PTRACE_GETHBPREGS/SETHBPREGS collide with
  generic SUD requests
- [High] riscv: hw_breakpoint: duplicate flush_ptrace_hw_breakpoint()
  stub breaks build
- [Medium] riscv: ptrace: switching slot type in riscv_ptrace_bp_set()
  fails with -ENOSPC
- [Medium] riscv: ptrace: sleeping lock in riscv_ptrace_hbptriggered()
  with IRQs off
- [Low] riscv: unused clear_ptrace_hw_breakpoint() prototype and
  debug_info fields
--

commit 99a21b5687d9bebf111bc51526d0fe5d8bd289d6
Author: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>

riscv: add ptrace requests for hardware breakpoints

This commit adds support for the PTRACE_GETHBPREGS and PTRACE_SETHBPREGS
ptrace requests on RISC-V, storing per-task perf hardware breakpoint events
and reporting hits via SIGTRAP/TRAP_HWBKPT.

> diff --git a/arch/riscv/include/asm/hw_breakpoint.h b/arch/riscv/include/=
asm/hw_breakpoint.h
> index dcce20ba3faab..6e8913d69df23 100644
> --- a/arch/riscv/include/asm/hw_breakpoint.h
> +++ b/arch/riscv/include/asm/hw_breakpoint.h
[ ... ]
> @@ -42,8 +49,14 @@ void arch_disable_hw_breakpoint(struct perf_event *bp);
>  int arch_install_hw_breakpoint(struct perf_event *bp);
>  void arch_uninstall_hw_breakpoint(struct perf_event *bp);
>  void hw_breakpoint_pmu_read(struct perf_event *bp);
> +void clear_ptrace_hw_breakpoint(struct task_struct *tsk);
> +void flush_ptrace_hw_breakpoint(struct task_struct *tsk);
> +void ptrace_hw_copy_thread(struct task_struct *task);
> =20
>  #else
> =20
> +static inline void flush_ptrace_hw_breakpoint(struct task_struct *task) =
{ }
> +static inline void ptrace_hw_copy_thread(struct task_struct *task) { }
> +
>  #endif /* CONFIG_HAVE_HW_BREAKPOINT */
>  #endif /* __RISCV_HW_BREAKPOINT_H */

[Severity: High]
Does defining flush_ptrace_hw_breakpoint() here break the build when
CONFIG_HAVE_HW_BREAKPOINT is disabled?

include/linux/hw_breakpoint.h already defines a static inline stub for
flush_ptrace_hw_breakpoint() when CONFIG_HAVE_HW_BREAKPOINT is not set
(and declares the prototype when it is set).  Since asm/processor.h now
includes asm/hw_breakpoint.h, any translation unit including both
linux/sched.h and linux/hw_breakpoint.h (such as arch/riscv/kernel/ptrace.c)
fails to compile due to the redefinition.

> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index e9d339bcb7e9f..a124ea48d8058 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
[ ... ]
> @@ -111,6 +112,19 @@ struct pt_regs;
>  #define RISCV_PREEMPT_V_NEED_RESTORE	0x40000000
>  #define RISCV_PREEMPT_V_IN_SCHEDULE	0x20000000
> =20
> +struct debug_info {
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +	/* Have we suspended stepping by a debugger? */
> +	int			suspended_step;
> +	/* Allow breakpoints and watchpoints to be disabled for this thread. */
> +	int			bp_disabled;
> +	int			wp_disabled;
> +	/* Hardware breakpoints pinned to this task. */
> +	struct perf_event	*hbp_break[RISCV_MAX_BP];
> +	struct perf_event	*hbp_watch[RISCV_MAX_BP];
> +#endif
> +};

[Severity: Low]
This isn't a bug, but suspended_step, bp_disabled, and wp_disabled in
struct debug_info, along with the clear_ptrace_hw_breakpoint() prototype in
asm/hw_breakpoint.h, are never used in this patch or later in the series.

> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/ua=
pi/asm/ptrace.h
> index 3de2b7124aff3..373a1c14f2073 100644
> --- a/arch/riscv/include/uapi/asm/ptrace.h
> +++ b/arch/riscv/include/uapi/asm/ptrace.h
> @@ -15,6 +15,8 @@
> =20
>  #define PTRACE_GETFDPIC_EXEC	0
>  #define PTRACE_GETFDPIC_INTERP	1
> +#define PTRACE_GETHBPREGS	0x4210
> +#define PTRACE_SETHBPREGS	0x4211

[Severity: High]
As reported by Rui Qi on v6 [1], do these values collide with the generic
PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG (0x4210) and
PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG (0x4211) requests in
include/uapi/linux/ptrace.h, where 0x4200-0x4300 is reserved for
architecture-independent additions?

Because arch_ptrace() and compat_arch_ptrace() intercept 0x4210 and 0x4211
before calling ptrace_request(), a tracer calling
PTRACE_SET_SYSCALL_USER_DISPATCH_CONFIG when CONFIG_HAVE_HW_BREAKPOINT=3Dy =
is
routed to riscv_ptrace_gethbpregs(), which overwrites the caller's input
buffer via copy_to_user(), while PTRACE_GET_SYSCALL_USER_DISPATCH_CONFIG is
routed to riscv_ptrace_sethbpregs().

> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index a0055743d3ba5..be076865d02d0 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
[ ... ]
> @@ -380,6 +382,152 @@ static int riscv_cfi_set(struct task_struct *target,
>  }
>  #endif
> =20
> +#ifdef CONFIG_HAVE_HW_BREAKPOINT
> +enum riscv_hbp_type {
> +	RISCV_HBP_BREAK,
> +	RISCV_HBP_WATCH,
> +};
> +
> +/*
> + * Handle hitting a HW-breakpoint.
> + */
> +static void riscv_ptrace_hbptriggered(struct perf_event *bp,
> +				      struct perf_sample_data *data,
> +				      struct pt_regs *regs)
> +{
> +	struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
> +
> +	force_sig_fault(SIGTRAP, TRAP_HWBKPT, (void __user *)bkpt->address);
> +}

[Severity: Medium]
Can calling force_sig_fault() from riscv_ptrace_hbptriggered() sleep with
interrupts disabled on PREEMPT_RT?

When a breakpoint triggers, hw_breakpoint_handler() -> perf_bp_event() ->
perf_swevent_event() disables hardware interrupts via guard(irqsave)()
before invoking the overflow handler:

  perf_swevent_event()              [guard(irqsave)()]
    -> perf_swevent_overflow()
      -> __perf_event_overflow()
        -> riscv_ptrace_hbptriggered()
          -> force_sig_fault()
            -> force_sig_info_to_task()
              -> spin_lock_irqsave(&t->sighand->siglock, flags)

On PREEMPT_RT (RISC-V selects ARCH_SUPPORTS_RT), sighand->siglock is a
sleeping rt_spin_lock, so acquiring it with interrupts disabled triggers a
sleeping-in-atomic warning and blocks with IRQs off if contended.

[ ... ]

> @@ -549,12 +697,173 @@ void ptrace_disable(struct task_struct *child)
[ ... ]
> +static int riscv_ptrace_bp_set(struct task_struct *child, unsigned long =
idx,
> +			       struct __riscv_hwdebug_state *state)
> +{
> +	struct perf_event *bp;
> +	struct perf_event_attr attr;
> +	enum riscv_hbp_type hbp_type, other_hbp_type;
> +	int ret;
> +	bool created =3D false;
> +
> +	if (idx >=3D RISCV_MAX_BP)
> +		return -EINVAL;
> +
> +	idx =3D array_index_nospec(idx, RISCV_MAX_BP);
> +
> +	ret =3D riscv_ptrace_bp_type_to_hbp(state->type, &hbp_type);
> +	if (ret)
> +		return ret;
> +
> +	/* The legacy request exposes ctrl as a disabled/enabled boolean. */
> +	if (state->ctrl > 1)
> +		return -EINVAL;
> +
> +	other_hbp_type =3D hbp_type =3D=3D RISCV_HBP_BREAK ?
> +			 RISCV_HBP_WATCH : RISCV_HBP_BREAK;
> +
> +	bp =3D ptrace_hbp_get_event(hbp_type, child, idx);
> +	if (IS_ERR(bp))
> +		return PTR_ERR(bp);
> +	if (!bp) {
> +		bp =3D ptrace_hbp_create(hbp_type, child, idx);
> +		if (IS_ERR(bp))
> +			return PTR_ERR(bp);
> +		created =3D true;
> +	}
> +
> +	attr =3D bp->attr;
> +
> +	attr.bp_addr =3D state->addr;
> +	attr.bp_len  =3D state->len;
> +	attr.bp_type =3D state->type;
> +	/* Enable or disable as requested by ctrl (0 =3D enabled, 1 =3D disable=
d) */
> +	attr.disabled =3D state->ctrl =3D=3D 1;
> +	ret =3D modify_user_hw_breakpoint(bp, &attr);
> +	if (ret) {
> +		/* Drop only events allocated by this failed request. */
> +		if (created)
> +			riscv_ptrace_bp_clear_event(child, hbp_type, idx);
> +		return ret;
> +	}
> +
> +	/*
> +	 * If the same index changed from breakpoint to watchpoint, or back,
> +	 * clear the old opposite-type slot after the new event is valid so a
> +	 * failed update does not destroy the previous state.
> +	 */
> +	return riscv_ptrace_bp_clear_event(child, other_hbp_type, idx);
> +}

[Severity: Medium]
Can switching an existing slot between a breakpoint and a watchpoint fail
with -ENOSPC when all hardware triggers are already in use?

RISC-V selects CONFIG_HAVE_MIXED_BREAKPOINTS_REGS, so breakpoints and
watchpoints share a single pool of dbtr_total_num slots in
reserve_bp_slot().  Because debug_info splits storage into hbp_break[] and
hbp_watch[], changing the type at index idx causes ptrace_hbp_get_event()
to return NULL and ptrace_hbp_create() to allocate a second perf_event
from the shared pool before riscv_ptrace_bp_clear_event() frees the
existing event at the same index.  Modifying the existing perf_event in
place via modify_user_hw_breakpoint() (or storing unified trigger slots in
a single array) would avoid needing a spare hardware slot.

[1] https://lore.kernel.org/r/5a7c08bd-4313-4424-b649-a19ffe5242e4@bytedanc=
e.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107023917.4060=
6-1-himanshu.chauhan@oss.qualcomm.com?part=3D3
