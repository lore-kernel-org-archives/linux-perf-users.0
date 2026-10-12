Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427913A8722
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800173; cv=none; b=jIYTQarG3XEiJRQjSnGF2RRR+u7J6nJVuKP6ZhE8jS+5g4/l8MHYK3b/gaUWEPZiLW4FXNXr6BO8fMBWeE0IUTUiiJTe4EgudPMSyC6W25+9f4PxBmuDWmeR8z9o6k/OeJByWBUKwL0xZsvzGQBR15PirJuOOxH6Hs1T2LqTZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800173; c=relaxed/simple;
	bh=L3yVb1zCDt9EJgrSPxrSjTkziqDkUrtipzK2mKk+bf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IIDj3gp+2RFKRJIG1uP0/T46dlY7XLwHyXgARQ+fmLti8UIMHzbgBxXKMmj+EozKs1uMqP4OxW3qL1DnPqH6VzuSr3N3hckyT86NMM67M1838XfVi9ht3J8y/9SaLs3HCeBhVaIUYFudXu9IdaPI/gMjyl9dR3Rk+3NNz7oSQxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fI+tmga+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI+tmga+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17E21F008A4
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791800163;
	bh=orl793BvU5e/CSxcYnxxsBl8AsMTBAsWY1vEB3OIDG4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fI+tmga+k57E8D0T5LnxP2Nb0fso/oPOUxz0Wj0oJJyE0g4FvgJLbmDHbhe16iNfn
	 DrwStfRcazQINxS3eIEvUwyauJYH5qO890en8ukt4jJgA7HkaZo5ZfXcRkB9P4QU5V
	 Dca+sJBekwOBrzwwuImo9gzMBoBDu7xeLFzO7BTGjkirFXsqSr0YZf+68N4PjGGiEn
	 oiiPEVsbwk2H9aIHEzEtVbkQWrqEqqPzuVTnnrXjyUc1NxCpYQ2A1clPey7sgrHoJc
	 XmOxX29JMPFfOVJnqgpF95QieZpOeAYDaIGp999fOH5pph9axRj+KUSeCWSGqBfQfJ
	 0kv+gmchg+uxQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b1dae0febeso291130a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Oct 2026 03:16:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz9WOyx2KafQ7cCbGiYN8udxXSKuWga5TruTfOkwKEpGCwRJ0+WH/8+OVHukMs9q4G67zVDf3uXJhg+vHy6+whN@vger.kernel.org
X-Gm-Message-State: AFq9FYKt5QJj0UkMZbdXEljgg0pwNzOUQIKqFJ7tyKS5xDK6eWTug2u1
	djTgtEfqgeoz7Gkw9WVt6UxccgCQ70W/IywPC27ztgpVMUWKwElMkPA2b4Zm0LJkYYKyJfxr+a+
	icSJGuMeN+KGKxI3M00SAusbp5gGn1EQ=
X-Received: by 2002:a05:6402:52d4:b0:6b1:bfa2:28b2 with SMTP id
 4fb4d7f45d1cf-6b1bfa237f9mr1810902a12.41.1791800162033; Mon, 12 Oct 2026
 03:16:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012090431.TF3iVDsk@linutronix.de>
In-Reply-To: <20261012090431.TF3iVDsk@linutronix.de>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 12 Oct 2026 18:15:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4=nnhbJS4srmt7dNdgpkEZ8_RQ5Z+0baYMiXF1UrJ3KA@mail.gmail.com>
X-Gm-Features: AclHuK9TEXrFCWum0m6_oB3KBiHLt4AYM32obi_SLjhsWyEN5aWEU2MqT_igAd8
Message-ID: <CAAhV-H4=nnhbJS4srmt7dNdgpkEZ8_RQ5Z+0baYMiXF1UrJ3KA@mail.gmail.com>
Subject: Re: [PATCH v4] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP notification
 to task_work()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>, 
	Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Oleg Nesterov <oleg@redhat.com>, 
	WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Clark Williams <clrkwllms@kernel.org>, 
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, James Clark <james.clark@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Sebastian,

On Mon, Oct 12, 2026 at 5:04=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Waiman, Luis, Ada reported that HW breakpoints on ARM64 trigger
> "sleeping while atomic" warnings on PREEMPT_RT. The hardware event is
> delivered with disabled interrupts and perf intrastrucure expects
> disabled interrupts while the overflow callback is invoked.
>
> The callback then sends a SIGTRAP signal for which it acquires
> sighand_struct::siglock, a spinlock_t which becomes a sleeping lock and
> must not be acquired in atomic context.
>
> Delay the event callback until the return to userland.
> Add perf_hwbp_notify(), a generic perf callback which delayes the
> actual callback invocation to task_work_add() callback. This callback
> invokes the architecture defined callback perf_arch_hwbp_send_sig().
> This requires struct callback_head and the functions require
> ARCH_NEED_PERF_HW_NOTIFY to be defined.
>
> This was reported against ARM64. ARM, LongARCH and Xtensa follow the
> same pattern are also converted. Xtensa is the only not supporting
> PREEMPT_RT but now we have all architectures using the same pattern.
>
> Fixes: d8fccd9ca5f90 ("arm64: Allow to enable PREEMPT_RT.")
> Reported-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> Reported-by: Waiman Long <longman@redhat.com>
> Closes: https://lore.kernel.org/all/aho0eqjMESuHxECr@redhat.com/
> Reviewed-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Tested-by: Ada Couprie Diaz <ada.coupriediaz@arm.com> (arm64)
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v3=E2=80=A6v4: https://lore.kernel.org/all/20261001143516.Ew8C97WS@linutr=
onix.de/
>  - Add fixes tag
>  - Rename the functions as suggested by Ada to use the pattern that perf
>    uses in other places:
>    - perf_arch_hwbp_notify() -> perf_hwbp_notify() (generic)
>    - arch_hwbp_send_sig() -> perf_arch_hwbp_send_sig() (arch specific)
>    - perf_arch_hwbp_send_sig() -> perf_hwbp_send_sig() (generic)
>  - Rename ARCH_NEED_PERF_HW_NOTIF -> ARCH_NEED_PERF_HW_NOTIFY
>
> v2=E2=80=A6v3: https://lore.kernel.org/all/20260814085118.OPEA_Ssn@linutr=
onix.de/
>  - Add Xtensa for completion
>  - sashiko complains and wants TWA_SIGNAL instead TWA_RESUME. His
>    argument is that a syscall will trap via get_user() and loop forever
>    instead making progress. This is wrong IMHO. ARM64 will single step
>    over the watchpoint and continue execution. The only downside is that
>    userland will get notified after the syscall completed. So my theory.
>    Using TWA_SIGNAL is worse: Assume we have a watchpoint on UADDR and
>    are in a futex() syscall. The get_user() invocation will trigger the
>    exception, the debug handler will step over and queue a signal. The
>    futex code will notice this and return ERESTARTNOINTR. A signal will
>    be sent, the syscall restarts, traps onto UADDR again, the loop
>    continues. But this should be case now, too=E2=80=A6
>    Now that I look into arch_build_bp_info() and do actual testing I must
>    say arm64 does not support mixed breakpoints. This means there is no
>    breakpoint in kernel on a userland address. \o/
>
> v1=E2=80=A6v2: https://lore.kernel.org/all/20260713144939.FuCj9yvZ@linutr=
onix.de/
>  - sashiko complained that a memory breakpoint might trigger several
>    times before a signal is sent if the syscall touches the memory (via
>    get_user()) more than once before returning back. This would lead to
>    list corruption in task_work_add(). To handle this, there is now a
>    variable which is set via xchg before task_work_add() and cleared
>    after the signal has been sent.
>
>  arch/arm/include/asm/hw_breakpoint.h       |  1 +
>  arch/arm/kernel/ptrace.c                   |  7 ++----
>  arch/arm64/include/asm/hw_breakpoint.h     |  1 +
>  arch/arm64/kernel/ptrace.c                 |  6 ++---
>  arch/loongarch/include/asm/hw_breakpoint.h |  1 +
>  arch/loongarch/kernel/ptrace.c             |  6 ++---
>  arch/xtensa/include/asm/hw_breakpoint.h    |  1 +
>  arch/xtensa/kernel/ptrace.c                |  7 ++----
>  include/linux/hw_breakpoint.h              |  3 +++
>  include/linux/perf_event.h                 |  4 ++++
>  kernel/events/core.c                       | 26 ++++++++++++++++++++++
>  11 files changed, 45 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/include/asm/hw_breakpoint.h b/arch/arm/include/asm/=
hw_breakpoint.h
> index e7f9961c53b2d..fa7fb2b2a392a 100644
> --- a/arch/arm/include/asm/hw_breakpoint.h
> +++ b/arch/arm/include/asm/hw_breakpoint.h
> @@ -7,6 +7,7 @@
>  struct task_struct;
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> +#define ARCH_NEED_PERF_HW_NOTIFY
>
>  struct arch_hw_breakpoint_ctrl {
>                 u32 __reserved  : 9,
> diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
> index ed7a2a87a6707..db4b28c6e15a4 100644
> --- a/arch/arm/kernel/ptrace.c
> +++ b/arch/arm/kernel/ptrace.c
> @@ -347,9 +347,7 @@ static long ptrace_hbp_idx_to_num(int idx)
>  /*
>   * Handle hitting a HW-breakpoint.
>   */
> -static void ptrace_hbptriggered(struct perf_event *bp,
> -                                    struct perf_sample_data *data,
> -                                    struct pt_regs *regs)
> +void perf_arch_hwbp_send_sig(struct perf_event *bp)
>  {
>         struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
>         long num;
> @@ -424,8 +422,7 @@ static struct perf_event *ptrace_hbp_create(struct ta=
sk_struct *tsk, int type)
>         attr.bp_type    =3D type;
>         attr.disabled   =3D 1;
>
> -       return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NU=
LL,
> -                                          tsk);
> +       return register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL,=
 tsk);
>  }
>
>  static int ptrace_gethbpregs(struct task_struct *tsk, long num,
> diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/=
asm/hw_breakpoint.h
> index bd81cf17744af..0bc75f42b0da6 100644
> --- a/arch/arm64/include/asm/hw_breakpoint.h
> +++ b/arch/arm64/include/asm/hw_breakpoint.h
> @@ -124,6 +124,7 @@ extern void hw_breakpoint_pmu_read(struct perf_event =
*bp);
>  extern int hw_breakpoint_slots(int type);
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> +#define ARCH_NEED_PERF_HW_NOTIFY
>  extern void hw_breakpoint_thread_switch(struct task_struct *next);
>  extern void ptrace_hw_copy_thread(struct task_struct *task);
>  #else
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index f743cbec1c3ad..dc3793c2a7c3c 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -168,9 +168,7 @@ void ptrace_disable(struct task_struct *child)
>  /*
>   * Handle hitting a HW-breakpoint.
>   */
> -static void ptrace_hbptriggered(struct perf_event *bp,
> -                               struct perf_sample_data *data,
> -                               struct pt_regs *regs)
> +void perf_arch_hwbp_send_sig(struct perf_event *bp)
>  {
>         struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
>         const char *desc =3D "Hardware breakpoint trap (ptrace)";
> @@ -312,7 +310,7 @@ static struct perf_event *ptrace_hbp_create(unsigned =
int note_type,
>         attr.bp_type    =3D type;
>         attr.disabled   =3D 1;
>
> -       bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NU=
LL, tsk);
> +       bp =3D register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL,=
 tsk);
>         if (IS_ERR(bp))
>                 return bp;
>
> diff --git a/arch/loongarch/include/asm/hw_breakpoint.h b/arch/loongarch/=
include/asm/hw_breakpoint.h
> index 5faa97a87a9e2..c2d061ff3763a 100644
> --- a/arch/loongarch/include/asm/hw_breakpoint.h
> +++ b/arch/loongarch/include/asm/hw_breakpoint.h
> @@ -120,6 +120,7 @@ void breakpoint_handler(struct pt_regs *regs);
>  void watchpoint_handler(struct pt_regs *regs);
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> +#define ARCH_NEED_PERF_HW_NOTIFY
>  extern void ptrace_hw_copy_thread(struct task_struct *task);
>  extern void hw_breakpoint_thread_switch(struct task_struct *next);
>  #else
> diff --git a/arch/loongarch/kernel/ptrace.c b/arch/loongarch/kernel/ptrac=
e.c
> index be38430f7e280..27e7e64591592 100644
> --- a/arch/loongarch/kernel/ptrace.c
> +++ b/arch/loongarch/kernel/ptrace.c
> @@ -384,9 +384,7 @@ static int lbt_set(struct task_struct *target,
>  /*
>   * Handle hitting a HW-breakpoint.
>   */
> -static void ptrace_hbptriggered(struct perf_event *bp,
> -                               struct perf_sample_data *data,
> -                               struct pt_regs *regs)
> +void perf_arch_hwbp_send_sig(struct perf_event *bp)
>  {
>         int i;
>         struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
> @@ -479,7 +477,7 @@ static struct perf_event *ptrace_hbp_create(unsigned =
int note_type,
>         attr.bp_type    =3D type;
>         attr.disabled   =3D 1;
>
> -       bp =3D register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NU=
LL, tsk);
> +       bp =3D register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL,=
 tsk);
>         if (IS_ERR(bp))
>                 return bp;
>
> diff --git a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/includ=
e/asm/hw_breakpoint.h
> index 9ec86f440a48e..44ea340c88742 100644
> --- a/arch/xtensa/include/asm/hw_breakpoint.h
> +++ b/arch/xtensa/include/asm/hw_breakpoint.h
> @@ -12,6 +12,7 @@
>  #define __ASM_XTENSA_HW_BREAKPOINT_H
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> +#define ARCH_NEED_PERF_HW_NOTIFY
>
>  #include <linux/kdebug.h>
>  #include <linux/types.h>
> diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
> index 364e4fdabb00d..c9f583d650de2 100644
> --- a/arch/xtensa/kernel/ptrace.c
> +++ b/arch/xtensa/kernel/ptrace.c
> @@ -361,9 +361,7 @@ static int ptrace_pokeusr(struct task_struct *child, =
long regno, long val)
>  }
>
>  #ifdef CONFIG_HAVE_HW_BREAKPOINT
> -static void ptrace_hbptriggered(struct perf_event *bp,
> -                               struct perf_sample_data *data,
> -                               struct pt_regs *regs)
> +void perf_arch_hwbp_send_sig(struct perf_event *bp)
>  {
>         int i;
>         struct arch_hw_breakpoint *bkpt =3D counter_arch_bp(bp);
> @@ -395,8 +393,7 @@ static struct perf_event *ptrace_hbp_create(struct ta=
sk_struct *tsk, int type)
>         attr.bp_type    =3D type;
>         attr.disabled   =3D 1;
>
> -       return register_user_hw_breakpoint(&attr, ptrace_hbptriggered, NU=
LL,
> -                                          tsk);
> +       return register_user_hw_breakpoint(&attr, perf_hwbp_notify, NULL,=
 tsk);
>  }
>
>  /*
> diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.=
h
> index db199d653dd1a..91e8d80220c54 100644
> --- a/include/linux/hw_breakpoint.h
> +++ b/include/linux/hw_breakpoint.h
> @@ -85,6 +85,9 @@ extern int register_perf_hw_breakpoint(struct perf_even=
t *bp);
>  extern void unregister_hw_breakpoint(struct perf_event *bp);
>  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *=
cpu_events);
>  extern bool hw_breakpoint_is_used(void);
> +extern void perf_arch_hwbp_send_sig(struct perf_event *bp);
> +extern void perf_hwbp_notify(struct perf_event *bp, struct perf_sample_d=
ata *data,
> +                            struct pt_regs *regs);
Maybe this declaration can be put in one line because there is no 80
characters limit now.

Huacai

>
>  extern int dbg_reserve_bp_slot(struct perf_event *bp);
>  extern int dbg_release_bp_slot(struct perf_event *bp);
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2d5e7687875b0..07f2c858d50d1 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -215,6 +215,10 @@ struct hw_perf_event {
>
>         /* Last sync'ed generation of filters */
>         unsigned long                   addr_filters_gen;
> +#ifdef ARCH_NEED_PERF_HW_NOTIFY
> +       struct callback_head            arch_hw_notif;
> +       int                             arch_hw_notif_busy;
> +#endif
>
>  /*
>   * hw_perf_event::state flags; used to track the PERF_EF_* state.
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7846d70be57f6..619eab68d1dfd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13334,6 +13334,28 @@ static void account_event(struct perf_event *eve=
nt)
>         account_pmu_sb_event(event);
>  }
>
> +#ifdef ARCH_NEED_PERF_HW_NOTIFY
> +static void perf_hwbp_send_sig(struct callback_head *head)
> +{
> +       struct perf_event *bp;
> +
> +       bp =3D container_of(head, struct perf_event, hw.arch_hw_notif);
> +       perf_arch_hwbp_send_sig(bp);
> +       xchg_relaxed(&bp->hw.arch_hw_notif_busy, 0);
> +       put_event(bp);
> +}
> +
> +void perf_hwbp_notify(struct perf_event *bp, struct perf_sample_data *da=
ta,
> +                     struct pt_regs *regs)
> +{
> +       if (WARN_ON_ONCE(!atomic_long_inc_not_zero(&bp->refcount)))
> +               return;
> +       if (xchg_relaxed(&bp->hw.arch_hw_notif_busy, 1) ||
> +           WARN_ON_ONCE(task_work_add(current, &bp->hw.arch_hw_notif, TW=
A_RESUME)))
> +               put_event(bp);
> +}
> +#endif
> +
>  /*
>   * Allocate and initialize an event structure
>   */
> @@ -13439,6 +13461,10 @@ perf_event_alloc(struct perf_event_attr *attr, i=
nt cpu,
>         }
>
>         if (overflow_handler) {
> +#ifdef ARCH_NEED_PERF_HW_NOTIFY
> +               if (overflow_handler =3D=3D perf_hwbp_notify)
> +                       init_task_work(&event->hw.arch_hw_notif, perf_hwb=
p_send_sig);
> +#endif
>                 event->overflow_handler =3D overflow_handler;
>                 event->overflow_handler_context =3D context;
>         } else if (is_write_backward(event)){
> --
> 2.55.0
>
