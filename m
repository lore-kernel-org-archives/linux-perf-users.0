Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A485E219A80;
	Tue, 20 May 2025 22:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747781410; cv=none; b=jGrFX1JIYo4gVnUyvGTB+E7YF2vAqgKdf9BudVTV3Rd9uYQxgQfqtEh9pPcj8HDaXx8ct+qurj0fYgqM/eZm9rZfUogWi1w/CccaRJvzQcj/HxmHsR0IliqzrlMHOUINm/Bip5IdVadPrdLmcgNcil6GjoEvOy12BjGbRa7wPxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747781410; c=relaxed/simple;
	bh=1u9LvhcaOTRd24ql7ud9/uRq8uX/ET3DmN6DwGlD20k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSLWca2mP7TWUVyMEHzUy0dYb8NAYv/JxZxXFruE6zQ4n1kJvB54+hg9X2m+XFDL/FkwnEwZ9FgXefBOzSSgqSSPJr2rmJP6wut6i49z5wlDK81dHOw6MC1gmIkGYVYid0CBENGwgkhjBnjRyy7ngjimotJk7EllrfzXmliXo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8wyhnMY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8wyhnMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3476C4CEE9;
	Tue, 20 May 2025 22:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747781409;
	bh=1u9LvhcaOTRd24ql7ud9/uRq8uX/ET3DmN6DwGlD20k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O8wyhnMYLHA+w1I6e2yBl+GrfhCu3uhYqgMZdD6q6Kn6YMCDg8EujS/qPKoLM6ely
	 R67k3HejOtKkUNX3cM3b/9XGyjwq2optLdKxGdKcy73Z606SlY5Der/NV3KucUZ5Jm
	 AZiLQjuba8+iuG5+FMoaqm+Ra7Bg9C0Xsofl+nfQ9IqzcyIwd+nyZ3BPce7oodV5oQ
	 iTwYzlOZJZvu1DOB+f4QvNMsqQp+W90YY6SA0q/v71lefDBEDnursvI1P+YNbT+fyM
	 nWCxCGgwjn56r+Zlw6qy4PM4L5IJUzZadBrrq+AwHvmbo5NXsMyeHAfgmsNhoW/SI+
	 KiAEz/DVZHVeA==
Date: Tue, 20 May 2025 15:50:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [RFC/PATCH] perf report: Support latency profiling in
 system-wide mode
Message-ID: <aC0HH45JCBTchZMc@google.com>
References: <aBmvmmRKpeVd6aT3@google.com>
 <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com>
 <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
 <aBvwFPRwA2LVQJkO@google.com>
 <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com>
 <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
 <aCveO4qQGy03ow5p@google.com>
 <CACT4Y+YdnQebkGTQJ9yhLs2j12WBYk2ReiBAq5cE+wtu1RRU5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YdnQebkGTQJ9yhLs2j12WBYk2ReiBAq5cE+wtu1RRU5A@mail.gmail.com>

On Tue, May 20, 2025 at 08:45:51AM +0200, Dmitry Vyukov wrote:
> On Tue, 20 May 2025 at 03:43, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Mon, May 19, 2025 at 08:00:49AM +0200, Dmitry Vyukov wrote:
> > > On Fri, 16 May 2025 at 18:33, Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > Sorry for the delay.
> > > >
> > > > On Thu, May 08, 2025 at 02:24:08PM +0200, Dmitry Vyukov wrote:
> > > > > On Thu, 8 May 2025 at 01:43, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> > > > > > > On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > > > > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > > > > > > > >
> > > > > > > > > > Basically yes, but you can use --sample-cpu to add it.
> > > > > > > > >
> > > > > > > > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> > > > > > > >
> > > > > > > > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> > > > > > > >
> > > > > > > > We may disable latency column by default in this case and show warning
> > > > > > > > if it's requested.  Or we may add a new attribute to emit sched-switch
> > > > > > > > records only for idle tasks and enable the latency report only if the
> > > > > > > > data has sched-switch records.
> > > > > > > >
> > > > > > > > What do you think?
> > > > > > >
> > > > > > > Depends on what problem we are trying to solve:
> > > > > > >
> > > > > > > 1. Enabling latency profiling for system-wide mode.
> > > > > > >
> > > > > > > 2. Switch events bloating trace too much.
> > > > > > >
> > > > > > > 3. Lost switch events lead to imprecise accounting.
> > > > > > >
> > > > > > > The patch mentions all 3 :)
> > > > > > > But I think 2 and 3 are not really specific to system-wide mode.
> > > > > > > An active single process profile can emit more samples than a
> > > > > > > system-wide profile on a lightly loaded system.
> > > > > >
> > > > > > True.  But we don't need to care about lightly loaded systems as they
> > > > > > won't cause problems.
> > > > > >
> > > > > >
> > > > > > > Similarly, if we rely on switch events for system-wide mode, then it's
> > > > > > > equally subject to the lost events problem.
> > > > > >
> > > > > > Right, but I'm afraid practically it'll increase the chance of lost
> > > > > > in system-wide mode.  The default size of the sample for system-wide
> > > > > > is 56 byte and the size of the switch is 48 byte.  And the default
> > > > > > sample frequency is 4000 Hz but it cannot control the rate of the
> > > > > > switch.  I saw around 10000 Hz of switches per CPU on my work env.
> > > > > >
> > > > > > >
> > > > > > > For problem 1: we can just permit --latency for system wide mode and
> > > > > > > fully rely on switch events.
> > > > > > > It's not any worse than we do now (wrt both profile size and lost events).
> > > > > >
> > > > > > This can be an option and it'd work well on lightly loaded systems.
> > > > > > Maybe we can just try it first.  But I think it's better to have an
> > > > > > option to make it work on heavily loaded systems.
> > > > > >
> > > > > > >
> > > > > > > For problem 2: yes, we could emit only switches to idle tasks. Or
> > > > > > > maybe just a fake CPU sample for an idle task? That's effectively what
> > > > > > > we want, then your current accounting code will work w/o any changes.
> > > > > > > This should help wrt trace size only for system-wide mode (provided
> > > > > > > that user already enables CPU accounting for other reasons, otherwise
> > > > > > > it's unclear what's better -- attaching CPU to each sample, or writing
> > > > > > > switch events).
> > > > > >
> > > > > > I'm not sure how we can add the fake samples.  The switch events will be
> > > > > > from the kernel and we may add the condition in the attribute.
> > > > > >
> > > > > > And PERF_SAMPLE_CPU is on by default in system-wide mode.
> > > > > >
> > > > > > >
> > > > > > > For problem 3: switches to idle task won't really help. There can be
> > > > > > > lots of them, and missing any will lead to wrong accounting.
> > > > > >
> > > > > > I don't know how severe the situation will be.  On heavily loaded
> > > > > > systems, the idle task won't run much and data size won't increase.
> > > > > > On lightly loaded systems, increased data will likely be handled well.
> > > > > >
> > > > > >
> > > > > > > A principled approach would be to attach a per-thread scheduler
> > > > > > > quantum sequence number to each CPU sample. The sequence number would
> > > > > > > be incremented on every context switch. Then any subset of CPU should
> > > > > > > be enough to understand when a task was scheduled in and out
> > > > > > > (scheduled in on the first CPU sample with sequence number N, and
> > > > > > > switched out on the last sample with sequence number N).
> > > > > >
> > > > > > I'm not sure how it can help.  We don't need the switch info itself.
> > > > > > What's needed is when the CPU was idle, right?
> > > > >
> > > > > I mean the following.
> > > > > Each sample has a TID.
> > > > > We add a SEQ field, which is per-thread and is incremented after every
> > > > > rescheduling of the thread.
> > > > >
> > > > > When we see the last sample for (TID,SEQ), we pretend there is SCHED
> > > > > OUT event for this thread at this timestamp. When we see the first
> > > > > sample for (TID,SEQ+1), we pretend there is SCHED IN event for this
> > > > > thread at this timestamp.
> > > > >
> > > > > These SCHED IN/OUT events are not injected by the kernel. We just
> > > > > pretend they happen for accounting purposes. We may actually
> > > > > materialize them in the perf tool, or me may just update parallelism
> > > > > as if they happen.
> > > >
> > > > Thanks for the explanation.  But I don't think it needs the SEQ and
> > > > SCHED IN/OUT generated from it to track lost records.  Please see below.
> > > >
> > > > >
> > > > > With this scheme we can lose absolutely any subset of samples, and
> > > > > still get very precise accounting. When we lose samples, the profile
> > > > > of course becomes a bit less precise, but the effect is local and
> > > > > recoverable.
> > > > >
> > > > > If we lose the last/first event for (TID,SEQ), then we slightly
> > > > > shorten/postpone the thread accounting in the process parallelism
> > > > > level. If we lose a middle (TID,SEQ), then parallelism is not
> > > > > affected.
> > > >
> > > > I'm afraid it cannot check parallelism by just seeing the current thread.
> > > > I guess it would need information from other threads even if it has same
> > > > SEQ.
> > >
> > > Yes, we still count parallelism like you do in this patch, we just use
> > > the SEQ info instead of CPU numbers and explicit switch events.
> >
> > I mean after record lost, let's say
> >
> >   t1: SAMPLE for TID 1234, seq 10  (parallelism = 4)
> >   t2: LOST
> >   t3: SAMPLE for TID 1234, seq 10  (parallelism = ?)
> >
> > I don't think we can continue to use parallelism of 4 after LOST even if
> > it has the same seq because it cannot know if other threads switched on
> > other CPUs.  Then do we need really the seq?
> 
> I do not understand the problem you describe.
> We just keep updating parallelism according to the algorithm I
> described. It works fine in the presence of lost events.

Do you think it's ok to use 4 if seq is the same?  I'm afraid it'd be
inaccurate.

> 
> 
> > > > Also postpone thread accounting can be complex.  I think it should wait
> > > > for all other threads to get a sample.  Maybe some threads exited and
> > > > lost too.
> > >
> > > Yes, in order to understand what's the last event for (TID,SEQ) we
> > > need to look ahead and find the event (TID,SEQ+1). The easiest way to
> > > do it would be to do 2 passes over the trace. That's the cost of
> > > saving trace space + being resilient to lost events.
> > >
> > > Do you see any other issues with this scheme besides requiring 2 passes?
> >
> > Well.. 2 pass itself can be a problem due to slowness it'd bring.  Some
> > people complain about the speed of perf report as of now.
> 
> Is trace processing CPU-bound or memory-bound? If it's CPU-bound, then
> the second pass may be OK-ish, since we will need minimal CPU
> processing during the first pass.

It depends on the size of data, but I guess it's CPU-bound in most cases.

> 
> 
> > I think we can simply reset the parallelism in all processes after LOST
> > and set current process to the idle task.  It'll catch up as soon as it
> > sees samples from all CPUs.
> 
> I guess we can approximate parallelism as you described here:
> 
> > Hmm.. ok.  Maybe we can save the timestamp of the last sample on each
> > CPU and clear the current thread after some period (2x of given freq?).
> 
> We probably don't need to do anything special for lost events in this
> scheme at all. If the gap caused by lost events is tiny, then we
> consider nothing happened. If the gap is large enough, then we
> consider the CPU as idle for the duration of the gap. Either way it
> will be handled on common grounds.

How do you know if it's tiny?  Do you mean the seq remains after lost?

> 
> But tuning of these heuristics + testing and verification may be a bit
> of a problem. I would hate to end up with a tool which I won't trust.
> 
> Here:
> "after some period (2x of given freq?)"
> do you mean 2x average/median period, or 1/2 average/median period?
> (2x freq is 1/2 period)

Oh, sorry.  It's 2x period.

> 
> Ideally, we consider a CPU idle after 1/2 period after it switched to
> the idle task and we stop receiving samples.
> But on the other hand, we don't want to consider it constantly
> becoming idle, when it's just doing normal sampling with the normal
> period...
> 
> So ideally the algorithm should be something like:
> let's say average/median sampling period is P
> we got last sample for CPU X at time T
> if by time T+2P we have not seen any other sample on CPU X, then
> consider CPU X idle since T+0.5P
> 
> But this would also require either 2 passes over the data, or some
> kind of look ahead similar to the algo I proposed...

I think we can do it in 1 pass.  For each sample,

  for_each_cpu(cpu) {
      if (current[cpu]->last_timestamp + 2*period < sample->timestamp) {
          if (current[cpu]->thread != idle) {
              current[cpu]->thread->parallelism--;
              current[cpu]->thread = idle;
	  }
      }
  }

  leader = machine__findnew_thread(machine, sample->pid);
  current[sample->cpu]->last_timestamp = sample->timestamp;

  if (current[sample->cpu]->thread != leader) {
      if (current[sample->cpu]->thread != idle)
          current[sample->cpu]->thread->parallelism--;
      
      current[sample->cpu]->thread = leader;
      leader->parallelism++;
  }

  sample->parallelism = leader->parallelism;

> 
> Also, do we take the median period? or average? do we update it over
> time (say, if CPU freq changes)? do we count it globally, or per CPU
> (in case CPUs run at different freqs)?

Oh, perf tools use default frequency of 4000 Hz.  Maybe we can use this
only for the frequency mode which means user didn't use -c option or
similar in the event description.

Thanks,
Namhyung

