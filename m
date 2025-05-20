Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D2DB67A;
	Tue, 20 May 2025 01:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747705406; cv=none; b=Ik3+kaB4yqb8bd4qtAHf92cQVk7vLa8aQuNqY56jDh24F+mJMd9ct118qrYdczPLlo0NWTuM5yX1s9KQ8XoTqgZWGc6SWBBIAVgdblbslRFnCg74kvZzBrx1nRKmzKwXxS4qib4YZkG2uylCQLV8yEq4IxBo76FmlnKJN8Ee2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747705406; c=relaxed/simple;
	bh=wCkNYO//dwnifDIdrFoU0BI7VkcCO23Ga1rKCx3MOHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uo1Y2q+p+yqBhYP66Mxtg23xJHRfXCfCZUyLws4CjSRoEFUMjeqb5/vjdn9qAvZbukNIMjv18o0tMMh2roSg/MtrTsLxw/Dt1iQg8Wzu4zW2i48LXiCLy5LenVg74gPBmJvvJf5jkV7inX+7zvgbTXgUv/NRvbV4J+VviTgtLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=smM7l7By; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="smM7l7By"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DF2C4CEE4;
	Tue, 20 May 2025 01:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747705405;
	bh=wCkNYO//dwnifDIdrFoU0BI7VkcCO23Ga1rKCx3MOHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=smM7l7By3f5j5Id4QIrszJ2d+/oBDppvE6QLSGq5JLSt4QFIspzXq8rUtCa+xUNC6
	 2gfZpXlj20qeLGsYgz9ihx1/+Wj3F1BBXkr352WzP4f4QcwnewtsTXB4HB/U5vB3r2
	 oU5i7gvGidbjx7IBAbWZz0qeGyUcd1DHzAY5t1YRr4SPqPC8cmxQ28mH7zL7G5iwH8
	 zA9i8h6oZGh1SqTmnYs0gwafp663WQYzW3HWQ2/uFaZZVVpUoMcIreP2/3Xdmx4a64
	 ZeaSQTZ6Y+DChNkvphI8qPjx2RV9bfOZOZ7Lj92FbKiTVFx4rcXDD57Sb4K38Y4t85
	 x5BqkEfEnPywA==
Date: Mon, 19 May 2025 18:43:23 -0700
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
Message-ID: <aCveO4qQGy03ow5p@google.com>
References: <aBmei7cMf-MzzX5W@google.com>
 <CACT4Y+ameQFd3n=u+bjd+vKR6svShp3NNQzjsUo_UUBCZPzrBw@mail.gmail.com>
 <aBmvmmRKpeVd6aT3@google.com>
 <CACT4Y+bm4gCO_sGvEkxLQfw8JyrWvCzqV_H5h+oebt8kk1_Hwg@mail.gmail.com>
 <aBm1x2as1fraHXHz@google.com>
 <CACT4Y+aiU-dHVgTKEpyJtn=RUUyYJp8U5BjyWSOHm6b2ODp9cA@mail.gmail.com>
 <aBvwFPRwA2LVQJkO@google.com>
 <CACT4Y+YacgzrUL1uTqxkPOjQm6ryn2R_nPs8dgnrP_iKA9yasQ@mail.gmail.com>
 <aCdo6Vz2MVv3N0kk@google.com>
 <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACT4Y+YHxXjCU2jySTUO5kH=xC8scdzTTuP2qEBc5zMber44Aw@mail.gmail.com>

On Mon, May 19, 2025 at 08:00:49AM +0200, Dmitry Vyukov wrote:
> On Fri, 16 May 2025 at 18:33, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hello,
> >
> > Sorry for the delay.
> >
> > On Thu, May 08, 2025 at 02:24:08PM +0200, Dmitry Vyukov wrote:
> > > On Thu, 8 May 2025 at 01:43, Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Tue, May 06, 2025 at 09:40:52AM +0200, Dmitry Vyukov wrote:
> > > > > On Tue, 6 May 2025 at 09:10, Namhyung Kim <namhyung@kernel.org> wrote:
> > > > > > > > > Where does the patch check that this mode is used only for system-wide profiles?
> > > > > > > > > Is it that PERF_SAMPLE_CPU present only for system-wide profiles?
> > > > > > > >
> > > > > > > > Basically yes, but you can use --sample-cpu to add it.
> > > > > > >
> > > > > > > Are you sure? --sample-cpu seems to work for non-system-wide profiles too.
> > > > > >
> > > > > > Yep, that's why I said "Basically".  So it's not 100% guarantee.
> > > > > >
> > > > > > We may disable latency column by default in this case and show warning
> > > > > > if it's requested.  Or we may add a new attribute to emit sched-switch
> > > > > > records only for idle tasks and enable the latency report only if the
> > > > > > data has sched-switch records.
> > > > > >
> > > > > > What do you think?
> > > > >
> > > > > Depends on what problem we are trying to solve:
> > > > >
> > > > > 1. Enabling latency profiling for system-wide mode.
> > > > >
> > > > > 2. Switch events bloating trace too much.
> > > > >
> > > > > 3. Lost switch events lead to imprecise accounting.
> > > > >
> > > > > The patch mentions all 3 :)
> > > > > But I think 2 and 3 are not really specific to system-wide mode.
> > > > > An active single process profile can emit more samples than a
> > > > > system-wide profile on a lightly loaded system.
> > > >
> > > > True.  But we don't need to care about lightly loaded systems as they
> > > > won't cause problems.
> > > >
> > > >
> > > > > Similarly, if we rely on switch events for system-wide mode, then it's
> > > > > equally subject to the lost events problem.
> > > >
> > > > Right, but I'm afraid practically it'll increase the chance of lost
> > > > in system-wide mode.  The default size of the sample for system-wide
> > > > is 56 byte and the size of the switch is 48 byte.  And the default
> > > > sample frequency is 4000 Hz but it cannot control the rate of the
> > > > switch.  I saw around 10000 Hz of switches per CPU on my work env.
> > > >
> > > > >
> > > > > For problem 1: we can just permit --latency for system wide mode and
> > > > > fully rely on switch events.
> > > > > It's not any worse than we do now (wrt both profile size and lost events).
> > > >
> > > > This can be an option and it'd work well on lightly loaded systems.
> > > > Maybe we can just try it first.  But I think it's better to have an
> > > > option to make it work on heavily loaded systems.
> > > >
> > > > >
> > > > > For problem 2: yes, we could emit only switches to idle tasks. Or
> > > > > maybe just a fake CPU sample for an idle task? That's effectively what
> > > > > we want, then your current accounting code will work w/o any changes.
> > > > > This should help wrt trace size only for system-wide mode (provided
> > > > > that user already enables CPU accounting for other reasons, otherwise
> > > > > it's unclear what's better -- attaching CPU to each sample, or writing
> > > > > switch events).
> > > >
> > > > I'm not sure how we can add the fake samples.  The switch events will be
> > > > from the kernel and we may add the condition in the attribute.
> > > >
> > > > And PERF_SAMPLE_CPU is on by default in system-wide mode.
> > > >
> > > > >
> > > > > For problem 3: switches to idle task won't really help. There can be
> > > > > lots of them, and missing any will lead to wrong accounting.
> > > >
> > > > I don't know how severe the situation will be.  On heavily loaded
> > > > systems, the idle task won't run much and data size won't increase.
> > > > On lightly loaded systems, increased data will likely be handled well.
> > > >
> > > >
> > > > > A principled approach would be to attach a per-thread scheduler
> > > > > quantum sequence number to each CPU sample. The sequence number would
> > > > > be incremented on every context switch. Then any subset of CPU should
> > > > > be enough to understand when a task was scheduled in and out
> > > > > (scheduled in on the first CPU sample with sequence number N, and
> > > > > switched out on the last sample with sequence number N).
> > > >
> > > > I'm not sure how it can help.  We don't need the switch info itself.
> > > > What's needed is when the CPU was idle, right?
> > >
> > > I mean the following.
> > > Each sample has a TID.
> > > We add a SEQ field, which is per-thread and is incremented after every
> > > rescheduling of the thread.
> > >
> > > When we see the last sample for (TID,SEQ), we pretend there is SCHED
> > > OUT event for this thread at this timestamp. When we see the first
> > > sample for (TID,SEQ+1), we pretend there is SCHED IN event for this
> > > thread at this timestamp.
> > >
> > > These SCHED IN/OUT events are not injected by the kernel. We just
> > > pretend they happen for accounting purposes. We may actually
> > > materialize them in the perf tool, or me may just update parallelism
> > > as if they happen.
> >
> > Thanks for the explanation.  But I don't think it needs the SEQ and
> > SCHED IN/OUT generated from it to track lost records.  Please see below.
> >
> > >
> > > With this scheme we can lose absolutely any subset of samples, and
> > > still get very precise accounting. When we lose samples, the profile
> > > of course becomes a bit less precise, but the effect is local and
> > > recoverable.
> > >
> > > If we lose the last/first event for (TID,SEQ), then we slightly
> > > shorten/postpone the thread accounting in the process parallelism
> > > level. If we lose a middle (TID,SEQ), then parallelism is not
> > > affected.
> >
> > I'm afraid it cannot check parallelism by just seeing the current thread.
> > I guess it would need information from other threads even if it has same
> > SEQ.
> 
> Yes, we still count parallelism like you do in this patch, we just use
> the SEQ info instead of CPU numbers and explicit switch events.

I mean after record lost, let's say

  t1: SAMPLE for TID 1234, seq 10  (parallelism = 4)
  t2: LOST
  t3: SAMPLE for TID 1234, seq 10  (parallelism = ?)

I don't think we can continue to use parallelism of 4 after LOST even if
it has the same seq because it cannot know if other threads switched on
other CPUs.  Then do we need really the seq?

> 
> > Also postpone thread accounting can be complex.  I think it should wait
> > for all other threads to get a sample.  Maybe some threads exited and
> > lost too.
> 
> Yes, in order to understand what's the last event for (TID,SEQ) we
> need to look ahead and find the event (TID,SEQ+1). The easiest way to
> do it would be to do 2 passes over the trace. That's the cost of
> saving trace space + being resilient to lost events.
> 
> Do you see any other issues with this scheme besides requiring 2 passes?

Well.. 2 pass itself can be a problem due to slowness it'd bring.  Some
people complain about the speed of perf report as of now.

I think we can simply reset the parallelism in all processes after LOST
and set current process to the idle task.  It'll catch up as soon as it
sees samples from all CPUs.

> 
> 
> > In my approach, I can clear the current thread from all CPUs when it
> > sees a LOST record and restart calculation of parallelism.
> >
> > >
> > > The switches from a thread to itself is not a problem. We will just
> > > inject a SCHED OUT followed by SCHED IN. But exactly the same happens
> > > now when the kernel injects these events.
> > >
> > > But if we switch to idle task and got no samples for some period of
> > > time on the CPU, then we properly inject SCHED OUT/IN that will
> > > account for the thread not actually running.
> >
> > Hmm.. ok.  Maybe we can save the timestamp of the last sample on each
> > CPU and clear the current thread after some period (2x of given freq?).
> > But it may slow down perf report as it'd check all CPUs for each sample.
> >
> > Thanks,
> > Namhyung
> >
