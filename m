Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD386FBD
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Nov 2023 06:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC80E111;
	Fri, 10 Nov 2023 22:58:10 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6c4eaa5202aso1131560b3a.1;
        Fri, 10 Nov 2023 22:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699685890; x=1700290690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=28w6qV8WnBY4El2Ei8XwIitqeg1uDiyySjL2sTjOgog=;
        b=EF1ejeSCKuRsTUmExsrThpTXj3DlT8TG8pLBZmnG2ScT0tDTmUOwIExonjfbHtZwZk
         DqyZJOB65UopE/LRAviEExvY3csI9zNmYn5Yv31b/RbNfYVd3Dcs6lU/KBVVYpI775tE
         hG29L0P7vq45DmU6lMAblbd/NoEuvCs7iJ8SXwdVrGNxsuxgZ89hs6P75vmU5yTICM/z
         ffkvtZpGMWBJbp7yFQf03g41tfBhBQoti5CoLZElGlSTA6AbpmnYvJWZROa1QWCS4MwK
         F+R/LSSYT67w2JllzkHzsXiDqPwoBBvJpEsev+5u9qakMlLwt7qedo2KNF06qqJF2p9z
         TsLQ==
X-Gm-Message-State: AOJu0YygfjQMBSB1Z/6NikkOMDuWQiEqjdUv/R1hXJ/Gc9MYJK/i1um2
	76+ANBQ1echN23f1Y8K0stnkk7nObwhcleQz0Zc=
X-Google-Smtp-Source: AGHT+IEbkYIXoYJ1O5EDnh9FIHJcHDKgI4Np/ns56hLIG6H5K0OAeICfm4fQy4NfeoZcnIbVfazhRogSpnxkl6WiZmw=
X-Received: by 2002:a05:6a21:778b:b0:180:dd61:72a2 with SMTP id
 bd11-20020a056a21778b00b00180dd6172a2mr1677322pzc.33.1699685889885; Fri, 10
 Nov 2023 22:58:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699487758.git.jpoimboe@kernel.org> <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
In-Reply-To: <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 10 Nov 2023 22:57:58 -0800
Message-ID: <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 4:43=E2=80=AFPM Josh Poimboeuf <jpoimboe@kernel.org>=
 wrote:
>
> Instead of attempting to unwind user space from the NMI handler, defer
> it to run in task context by sending a self-IPI and then scheduling the
> unwind to run in the IRQ's exit task work before returning to user space.
>
> This allows the user stack page to be paged in if needed, avoids
> duplicate unwinds for kernel-bound workloads, and prepares for SFrame
> unwinding (so .sframe sections can be paged in on demand).
>
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>  arch/Kconfig                    |  3 ++
>  include/linux/perf_event.h      | 22 ++++++--
>  include/uapi/linux/perf_event.h |  1 +
>  kernel/bpf/stackmap.c           |  5 +-
>  kernel/events/callchain.c       |  7 ++-
>  kernel/events/core.c            | 90 ++++++++++++++++++++++++++++++---
>  6 files changed, 115 insertions(+), 13 deletions(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index f4b210ab0612..690c82212224 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -425,6 +425,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
>           It uses the same command line parameters, and sysctl interface,
>           as the generic hardlockup detectors.
>
> +config HAVE_PERF_CALLCHAIN_DEFERRED
> +       bool
> +
>  config HAVE_PERF_REGS
>         bool
>         help
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 2d8fa253b9df..2f232111dff2 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -786,6 +786,7 @@ struct perf_event {
>         struct irq_work                 pending_irq;
>         struct callback_head            pending_task;
>         unsigned int                    pending_work;
> +       unsigned int                    pending_unwind;
>
>         atomic_t                        event_limit;
>
> @@ -1113,7 +1114,10 @@ int perf_event_read_local(struct perf_event *event=
, u64 *value,
>  extern u64 perf_event_read_value(struct perf_event *event,
>                                  u64 *enabled, u64 *running);
>
> -extern struct perf_callchain_entry *perf_callchain(struct perf_event *ev=
ent, struct pt_regs *regs);
> +extern void perf_callchain(struct perf_sample_data *data,
> +                          struct perf_event *event, struct pt_regs *regs=
);
> +extern void perf_callchain_deferred(struct perf_sample_data *data,
> +                                   struct perf_event *event, struct pt_r=
egs *regs);
>
>  static inline bool branch_sample_no_flags(const struct perf_event *event=
)
>  {
> @@ -1189,6 +1193,7 @@ struct perf_sample_data {
>         u64                             data_page_size;
>         u64                             code_page_size;
>         u64                             aux_size;
> +       bool                            deferred;
>  } ____cacheline_aligned;
>
>  /* default value for data source */
> @@ -1206,6 +1211,7 @@ static inline void perf_sample_data_init(struct per=
f_sample_data *data,
>         data->sample_flags =3D PERF_SAMPLE_PERIOD;
>         data->period =3D period;
>         data->dyn_size =3D 0;
> +       data->deferred =3D false;
>
>         if (addr) {
>                 data->addr =3D addr;
> @@ -1219,7 +1225,11 @@ static inline void perf_sample_save_callchain(stru=
ct perf_sample_data *data,
>  {
>         int size =3D 1;
>
> -       data->callchain =3D perf_callchain(event, regs);
> +       if (data->deferred)
> +               perf_callchain_deferred(data, event, regs);
> +       else
> +               perf_callchain(data, event, regs);
> +
>         size +=3D data->callchain->nr;
>
>         data->dyn_size +=3D size * sizeof(u64);
> @@ -1534,12 +1544,18 @@ extern void perf_callchain_user(struct perf_callc=
hain_entry_ctx *entry, struct p
>  extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry=
, struct pt_regs *regs);
>  extern struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -                  u32 max_stack, bool add_mark);
> +                  u32 max_stack, bool add_mark, bool defer_user);
>  extern int get_callchain_buffers(int max_stack);
>  extern void put_callchain_buffers(void);
>  extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
>  extern void put_callchain_entry(int rctx);
>
> +#ifdef CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED
> +extern void perf_callchain_user_deferred(struct perf_callchain_entry_ctx=
 *entry, struct pt_regs *regs);
> +#else
> +static inline void perf_callchain_user_deferred(struct perf_callchain_en=
try_ctx *entry, struct pt_regs *regs) {}
> +#endif
> +
>  extern int sysctl_perf_event_max_stack;
>  extern int sysctl_perf_event_max_contexts_per_stack;
>
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_ev=
ent.h
> index 39c6a250dd1b..9a1127af4cda 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -1237,6 +1237,7 @@ enum perf_callchain_context {
>         PERF_CONTEXT_HV                 =3D (__u64)-32,
>         PERF_CONTEXT_KERNEL             =3D (__u64)-128,
>         PERF_CONTEXT_USER               =3D (__u64)-512,
> +       PERF_CONTEXT_USER_DEFERRED      =3D (__u64)-640,
>
>         PERF_CONTEXT_GUEST              =3D (__u64)-2048,
>         PERF_CONTEXT_GUEST_KERNEL       =3D (__u64)-2176,
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index e4827ca5378d..fcdd26715b12 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -294,8 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, s=
truct bpf_map *, map,
>         if (max_depth > sysctl_perf_event_max_stack)
>                 max_depth =3D sysctl_perf_event_max_stack;
>
> -       trace =3D get_perf_callchain(regs, kernel, user, max_depth, false=
);
> -
> +       trace =3D get_perf_callchain(regs, kernel, user, max_depth, false=
, false);
>         if (unlikely(!trace))
>                 /* couldn't fetch the stack trace */
>                 return -EFAULT;
> @@ -420,7 +419,7 @@ static long __bpf_get_stack(struct pt_regs *regs, str=
uct task_struct *task,
>                 trace =3D get_callchain_entry_for_task(task, max_depth);
>         else
>                 trace =3D get_perf_callchain(regs, kernel, user, max_dept=
h,
> -                                          false);
> +                                          false, false);

Hmm.. BPF is not supported.  Any plans?


>         if (unlikely(!trace))
>                 goto err_fault;
>
> diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> index 2bee8b6fda0e..16571c8d6771 100644
> --- a/kernel/events/callchain.c
> +++ b/kernel/events/callchain.c
> @@ -178,7 +178,7 @@ put_callchain_entry(int rctx)
>
>  struct perf_callchain_entry *
>  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> -                  u32 max_stack, bool add_mark)
> +                  u32 max_stack, bool add_mark, bool defer_user)
>  {
>         struct perf_callchain_entry *entry;
>         struct perf_callchain_entry_ctx ctx;
> @@ -207,6 +207,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel=
, bool user,
>                         regs =3D task_pt_regs(current);
>                 }
>
> +               if (defer_user) {
> +                       perf_callchain_store_context(&ctx, PERF_CONTEXT_U=
SER_DEFERRED);
> +                       goto exit_put;

Hmm.. ok.  Then now perf tools need to stitch the call stacks
in two (or more?) samples.


> +               }
> +
>                 if (add_mark)
>                         perf_callchain_store_context(&ctx, PERF_CONTEXT_U=
SER);
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5e41a3b70bcd..290e06b0071c 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6751,6 +6751,12 @@ static void perf_pending_irq(struct irq_work *entr=
y)
>         struct perf_event *event =3D container_of(entry, struct perf_even=
t, pending_irq);
>         int rctx;
>
> +       if (!is_software_event(event)) {
> +               if (event->pending_unwind)
> +                       task_work_add(current, &event->pending_task, TWA_=
RESUME);

I'm not familiar with this code.  Is it possible to the current task
is preempted before returning to user space (and run the
perf_pending_task_unwind) ?


> +               return;
> +       }
> +
>         /*
>          * If we 'fail' here, that's OK, it means recursion is already di=
sabled
>          * and we won't recurse 'further'.
> @@ -6772,11 +6778,57 @@ static void perf_pending_irq(struct irq_work *ent=
ry)
>                 perf_swevent_put_recursion_context(rctx);
>  }
>
> +static void perf_pending_task_unwind(struct perf_event *event)
> +{
> +       struct pt_regs *regs =3D task_pt_regs(current);
> +       struct perf_output_handle handle;
> +       struct perf_event_header header;
> +       struct perf_sample_data data;
> +       struct perf_callchain_entry *callchain;
> +
> +       callchain =3D kmalloc(sizeof(struct perf_callchain_entry) +
> +                           (sizeof(__u64) * event->attr.sample_max_stack=
) +
> +                           (sizeof(__u64) * 1) /* one context */,
> +                           GFP_KERNEL);

Any chance it can reuse get_perf_callchain() instead of
allocating the callchains every time?


> +       if (!callchain)
> +               return;
> +
> +       callchain->nr =3D 0;
> +       data.callchain =3D callchain;
> +
> +       perf_sample_data_init(&data, 0, event->hw.last_period);

It would double count the period for a sample.
I guess we want to set the period to 0.

> +
> +       data.deferred =3D true;
> +
> +       perf_prepare_sample(&data, event, regs);

I don't think this would work properly.  Not to mention it duplicates
sample data unnecessarily, some data needs special handling to
avoid inefficient (full) data copy like for (user) stack, regs and aux.

Anyway I'm not sure it can support these additional samples for
deferred callchains without breaking the existing perf tools.
Anyway it doesn't know PERF_CONTEXT_USER_DEFERRED at least.
I think this should be controlled by a new feature bit in the
perf_event_attr.

Then we might add a breaking change to have a special
sample record for the deferred callchains and sample ID only.

> +
> +       perf_prepare_header(&header, &data, event, regs);
> +
> +       if (perf_output_begin(&handle, &data, event, header.size))
> +               goto done;
> +
> +       perf_output_sample(&handle, &header, &data, event);
> +
> +       perf_output_end(&handle);
> +
> +done:
> +       kfree(callchain);
> +}
> +
> +
>  static void perf_pending_task(struct callback_head *head)
>  {
>         struct perf_event *event =3D container_of(head, struct perf_event=
, pending_task);
>         int rctx;
>
> +       if (!is_software_event(event)) {
> +               if (event->pending_unwind) {
> +                       perf_pending_task_unwind(event);
> +                       event->pending_unwind =3D 0;
> +               }
> +               return;
> +       }
> +
>         /*
>          * If we 'fail' here, that's OK, it means recursion is already di=
sabled
>          * and we won't recurse 'further'.
> @@ -7587,22 +7639,48 @@ static u64 perf_get_page_size(unsigned long addr)
>
>  static struct perf_callchain_entry __empty_callchain =3D { .nr =3D 0, };
>
> -struct perf_callchain_entry *
> -perf_callchain(struct perf_event *event, struct pt_regs *regs)
> +void perf_callchain(struct perf_sample_data *data, struct perf_event *ev=
ent,
> +                   struct pt_regs *regs)
>  {
>         bool kernel =3D !event->attr.exclude_callchain_kernel;
>         bool user   =3D !event->attr.exclude_callchain_user;
>         const u32 max_stack =3D event->attr.sample_max_stack;
> -       struct perf_callchain_entry *callchain;
> +       bool defer_user =3D IS_ENABLED(CONFIG_HAVE_PERF_CALLCHAIN_DEFERRE=
D);

Is it always enabled depending on the kernel config?
It could be controlled by event->attr.something..

Thanks,
Namhyung

>
>         /* Disallow cross-task user callchains. */
>         user &=3D !event->ctx->task || event->ctx->task =3D=3D current;
>
>         if (!kernel && !user)
> -               return &__empty_callchain;
> +               goto empty;
>
> -       callchain =3D get_perf_callchain(regs, kernel, user, max_stack, t=
rue);
> -       return callchain ?: &__empty_callchain;
> +       data->callchain =3D get_perf_callchain(regs, kernel, user, max_st=
ack, true, defer_user);
> +       if (!data->callchain)
> +               goto empty;
> +
> +       if (user && defer_user && !event->pending_unwind) {
> +               event->pending_unwind =3D 1;
> +               irq_work_queue(&event->pending_irq);
> +       }
> +
> +       return;
> +
> +empty:
> +       data->callchain =3D &__empty_callchain;
> +}
> +
> +void perf_callchain_deferred(struct perf_sample_data *data,
> +                            struct perf_event *event, struct pt_regs *re=
gs)
> +{
> +       struct perf_callchain_entry_ctx ctx;
> +
> +       ctx.entry               =3D data->callchain;
> +       ctx.max_stack           =3D event->attr.sample_max_stack;
> +       ctx.nr                  =3D 0;
> +       ctx.contexts            =3D 0;
> +       ctx.contexts_maxed      =3D false;
> +
> +       perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> +       perf_callchain_user_deferred(&ctx, regs);
>  }
>
>  static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
> --
> 2.41.0
>
>
