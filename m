Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC411B280
	for <linux-perf-users@vger.kernel.org>; Sat, 11 Nov 2023 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKhDpNVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82ECC433C7;
	Sat, 11 Nov 2023 18:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699728550;
	bh=ATwLr/Z79d09EhjptUII4Di/VJZD5uMiL2/srCUcLzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GKhDpNVQ3WFy19cyXyasIz8JdzWAHYV+izdmJJK8ObjTdI51ns//7DZ6NFXOwbsxz
	 Ip/4v6vsw+v+7SkIuVIvtjjjjczCKmVWmnBSwwBkXurBkrLZAy5B7wz/dW8s/4Piax
	 L6UlGHZvQVnoIbT77AAQIGryWm0OkYutACQ8SDF8t3IhshWna0lP61PAdKRliuYLoI
	 n197UTsR74TgwrLjz5czTx6N+f09y6grygerVniHao4c0EYkVATp3OJkDY1FQGNjoY
	 gS5+LySg8StdxbUNgPSa8kJTTeUCHi7Fix54evBN6gckHIiryN/cQ00nbWTMqxM18T
	 PjErX00Zp8aGw==
Date: Sat, 11 Nov 2023 10:49:08 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org
Subject: Re: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Message-ID: <20231111184908.ym4l6cwzwnkl7e6m@treble>
References: <cover.1699487758.git.jpoimboe@kernel.org>
 <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
 <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chZcqR8WCEYtjpP4KzUOeNdJ=kSvae0UrjsO8OgsepjDw@mail.gmail.com>

On Fri, Nov 10, 2023 at 10:57:58PM -0800, Namhyung Kim wrote:
> On Wed, Nov 8, 2023 at 4:43 PM Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > +++ b/kernel/bpf/stackmap.c
> > @@ -294,8 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
> >         if (max_depth > sysctl_perf_event_max_stack)
> >                 max_depth = sysctl_perf_event_max_stack;
> >
> > -       trace = get_perf_callchain(regs, kernel, user, max_depth, false);
> > -
> > +       trace = get_perf_callchain(regs, kernel, user, max_depth, false, false);
> >         if (unlikely(!trace))
> >                 /* couldn't fetch the stack trace */
> >                 return -EFAULT;
> > @@ -420,7 +419,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
> >                 trace = get_callchain_entry_for_task(task, max_depth);
> >         else
> >                 trace = get_perf_callchain(regs, kernel, user, max_depth,
> > -                                          false);
> > +                                          false, false);
> 
> Hmm.. BPF is not supported.  Any plans?

I'm not sure whether this feature makes sense for BPF.  If the BPF
program runs in atomic context then it would have to defer the unwind
until right before exiting to user space.  But then the program is no
longer running.

> > +++ b/kernel/events/callchain.c
> > @@ -178,7 +178,7 @@ put_callchain_entry(int rctx)
> >
> >  struct perf_callchain_entry *
> >  get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> > -                  u32 max_stack, bool add_mark)
> > +                  u32 max_stack, bool add_mark, bool defer_user)
> >  {
> >         struct perf_callchain_entry *entry;
> >         struct perf_callchain_entry_ctx ctx;
> > @@ -207,6 +207,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> >                         regs = task_pt_regs(current);
> >                 }
> >
> > +               if (defer_user) {
> > +                       perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
> > +                       goto exit_put;
> 
> Hmm.. ok.  Then now perf tools need to stitch the call stacks
> in two (or more?) samples.

Yes.  And it could be more than two samples if there were multiple NMIs
before returning to user space.  In that case there would be a single
user sample which needs to be stitched to each of the kernel samples.

> > +               }
> > +
> >                 if (add_mark)
> >                         perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 5e41a3b70bcd..290e06b0071c 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6751,6 +6751,12 @@ static void perf_pending_irq(struct irq_work *entry)
> >         struct perf_event *event = container_of(entry, struct perf_event, pending_irq);
> >         int rctx;
> >
> > +       if (!is_software_event(event)) {
> > +               if (event->pending_unwind)
> > +                       task_work_add(current, &event->pending_task, TWA_RESUME);
> 
> I'm not familiar with this code.  Is it possible to the current task
> is preempted before returning to user space (and run the
> perf_pending_task_unwind) ?

Yes, the task work (perf_pending_task_unwind) is preemptible.

> > +static void perf_pending_task_unwind(struct perf_event *event)
> > +{
> > +       struct pt_regs *regs = task_pt_regs(current);
> > +       struct perf_output_handle handle;
> > +       struct perf_event_header header;
> > +       struct perf_sample_data data;
> > +       struct perf_callchain_entry *callchain;
> > +
> > +       callchain = kmalloc(sizeof(struct perf_callchain_entry) +
> > +                           (sizeof(__u64) * event->attr.sample_max_stack) +
> > +                           (sizeof(__u64) * 1) /* one context */,
> > +                           GFP_KERNEL);
> 
> Any chance it can reuse get_perf_callchain() instead of
> allocating the callchains every time?

I don't think so, because if it gets preempted, the new task might also
need to do an unwind.  But there's only one task-context callchain per
CPU.

The allocation is less than ideal.  I could just allocate it on the
stack, and keep the number of entries bounded to 128 entries or so.

> > +       if (!callchain)
> > +               return;
> > +
> > +       callchain->nr = 0;
> > +       data.callchain = callchain;
> > +
> > +       perf_sample_data_init(&data, 0, event->hw.last_period);
> 
> It would double count the period for a sample.
> I guess we want to set the period to 0.

Ok.

> > +
> > +       data.deferred = true;
> > +
> > +       perf_prepare_sample(&data, event, regs);
> 
> I don't think this would work properly.  Not to mention it duplicates
> sample data unnecessarily, some data needs special handling to
> avoid inefficient (full) data copy like for (user) stack, regs and aux.

Yeah.  I tried sending only the sample ID and callchain, but perf tool
didn't appreciate that ;-) So for the RFC I gave up and did this.

> Anyway I'm not sure it can support these additional samples for
> deferred callchains without breaking the existing perf tools.
> Anyway it doesn't know PERF_CONTEXT_USER_DEFERRED at least.
> I think this should be controlled by a new feature bit in the
> perf_event_attr.
> 
> Then we might add a breaking change to have a special
> sample record for the deferred callchains and sample ID only.

Sounds like a good idea.  I'll need to study the code to figure out how
to do that on the perf tool side.  Or would you care to write a patch?

> > -struct perf_callchain_entry *
> > -perf_callchain(struct perf_event *event, struct pt_regs *regs)
> > +void perf_callchain(struct perf_sample_data *data, struct perf_event *event,
> > +                   struct pt_regs *regs)
> >  {
> >         bool kernel = !event->attr.exclude_callchain_kernel;
> >         bool user   = !event->attr.exclude_callchain_user;
> >         const u32 max_stack = event->attr.sample_max_stack;
> > -       struct perf_callchain_entry *callchain;
> > +       bool defer_user = IS_ENABLED(CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED);
> 
> Is it always enabled depending on the kernel config?
> It could be controlled by event->attr.something..

Possibly, depending on what y'all think.  Also, fp vs sframe could be an
attr (though sframe implies deferred).

Thanks for the review!

-- 
Josh
