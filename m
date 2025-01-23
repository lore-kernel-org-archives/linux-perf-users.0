Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58271D5AB9;
	Thu, 23 Jan 2025 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737675290; cv=none; b=RfkhhVhEONsXRFr7+C2Y2HCDzyipAcZ3irzCRLf8awQXhQjl8kVrjPA1hMfgPP2LvAWuWpTppmx09OKyrxxAJUM++mBfs6oLvX70NOpZSBkd8GSxPsmW2oOwGkD0OFTPubcouZ/DReGvWS+3z+a4+EqW+CBl96PIedBT2uvjjyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737675290; c=relaxed/simple;
	bh=PwxjONB++A+9wM5woTms13h00oSvubWGRcBIudfuow8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4G9A7Nq5wflQLoqYgQtIrcE8Lu2MFwqfAswPOsddRr44uJ7jrPuChnwN888+09fQMhef7QrrPMDWoXB/AfbtsQATzpJIT/aEfEm9NBm04HwO8xqdn8YEOAbkKC2dn2dllmX8zy+v0r2OwLkdkwxY7BykJVA6NXdm/OTThDpG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGZ4PHYh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGZ4PHYh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22892C4AF0B;
	Thu, 23 Jan 2025 23:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737675289;
	bh=PwxjONB++A+9wM5woTms13h00oSvubWGRcBIudfuow8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGZ4PHYh+Tdi0o+AoPRmHCBsioNMnyuQUFW1Su2ObDlHhkF+NjsEpfTuUbXLvX+Ie
	 Tz3ke/4RcppqbHQmwlpN/SImApQkvIGKP8VoACxGvr3BPVQ1QPloJq/tl7wsCYbSRU
	 NJtBe3TgSJ1FpJbF2mRfJcpM9Ym/bv6XF0jJFTcOpTRgZ8GAmWKUpaY/qVt6ut7m4S
	 /rlmEWRHcLiQI92cJ1CIqw32ZitWM3G93rtml+hh16tOoTMo4gcsZPeNimRqgk5xky
	 eiP/R/wED2QU8IiknR+WCZhzgTU6hyAssmoVMIz6e9Q+sP2lnHGC+VD2N5MlhHE/1O
	 jREqLXT7Uldgg==
Date: Thu, 23 Jan 2025 15:34:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Stephane Eranian <eranian@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	chu howard <howardchu95@gmail.com>
Subject: Re: Off-CPU sampling (was perf report: Add wall-clock and
 parallelism profiling)
Message-ID: <Z5LSFmM64tFPj-Vz@google.com>
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com>
 <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
 <CAP-5=fWHivx7Q6okMwYOs=65MZr40RjE16tgatMX0hjkCfrwfw@mail.gmail.com>
 <CACT4Y+Yh98VcNgmJ-gF9+inw=ZDkg1rRzi4_35f6krw8BBRpug@mail.gmail.com>
 <Z4lWDPpmdQDM1k6l@google.com>
 <CACT4Y+YMAM1eMEEWhGsOcGqPT2bn+4FRSp5ORgF0Qji8nmBzdQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+YMAM1eMEEWhGsOcGqPT2bn+4FRSp5ORgF0Qji8nmBzdQ@mail.gmail.com>

On Sun, Jan 19, 2025 at 12:08:36PM +0100, Dmitry Vyukov wrote:
> On Thu, 16 Jan 2025 at 19:55, Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Wed, Jan 15, 2025 at 08:11:51AM +0100, Dmitry Vyukov wrote:
> > > On Wed, 15 Jan 2025 at 06:59, Ian Rogers <irogers@google.com> wrote:
> > > >
> > > > On Tue, Jan 14, 2025 at 12:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > [snip]
> > > > > FWIW I've also considered and started implementing a different
> > > > > approach where the kernel would count parallelism level for each
> > > > > context and write it out with samples:
> > > > > https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab496c1a9f2
> > > > > Then sched_in/out would need to do atomic inc/dec on a global counter.
> > > > > Not sure how hard it is to make all corner cases work there, I dropped
> > > > > it half way b/c the perf record post-processing looked like a better
> > > > > approach.
> > > >
> > > > Nice. Just to focus on this point and go off on something of a
> > > > tangent. I worry a little about perf_event_sample_format where we've
> > > > used 25 out of the 64 bits of sample_type. Perhaps there will be a
> > > > sample_type2 in the future. For the code and data page size it seems
> > > > the same information could come from mmap events. You have a similar
> > > > issue. I was thinking of another similar issue, adding information
> > > > about the number of dirty pages in a VMA. I wonder if there is a
> > > > better way to organize these things, rather than just keep using up
> > > > bits in the perf_event_sample_format. For example, we could have a
> > > > code page size software event that when in a leader sampling group
> > > > with a hardware event with a sample IP provides the code page size
> > > > information of the leader event's sample IP. We have loads of space in
> > > > the types and config values to have an endless number of such events
> > > > and maybe the value could be generated by a BPF program for yet more
> > > > flexibility. What these events would mean without a leader sample
> > > > event I'm not sure.
> > >
> > > In the end I did not go with adding parallelism to each sample (this
> > > is purely perf report change), so at least for this patch this is very
> > > tangential :)
> > >
> > > > Wrt wall clock time, Howard Chu has done some work advancing off-CPU
> > > > sampling. Wall clock time being off CPU plus on CPU. We need to do
> > > > something to move forward the default flags/options for perf record,
> > > > for example, we don't enable build ID mmap events by default causing
> > > > the whole perf.data file to be scanned looking to add build ID events
> > > > for the dsos with samples in them. One option that could be a default
> > > > could be off-CPU profiling, and when permissions deny the BPF approach
> > > > we can fallback on using events. If these events are there by default
> > > > then it makes sense to hook them up in perf report.
> > >
> > > Interesting. Do you mean "IO" by "off-CPU".
> > > Yes, if a program was blocked for IO for 10 seconds (no CPU work),
> > > then that obviously contributes to latency, but won't be in this
> > > profile. Though, it still works well for a large number of important
> > > cases (e.g. builds, ML inference, server request handling are
> > > frequently not IO bound).
> > >
> > > I was thinking how IO can be accounted for in the wall-clock profile.
> > > Since we have SWITCH OUT events (and they already include preemption
> > > bit), we do have info to account for blocked threads. But it gets
> > > somewhat complex and has to make some hypotheses b/c not all blocked
> > > threads contribute to latency (e.g. blocked watchdog thread). So I
> > > left it out for now.
> > >
> > > The idea was as follows.
> > > We know a set of threads blocked at any point in time (switched out,
> > > but not preempted).
> > > We hypothesise that each of these could equally improve CPU load to
> > > max if/when unblocked.
> > > We inject synthetic samples in a leaf "IO wait" symbol with the weight
> > > according to the hypothesis. I think these events can be  injected
> > > before each switch in event only (which changes the set of blocked
> > > threads).
> > >
> > > Namely:
> > > If CPU load is already at max (parallelism == num cpus), we don't
> > > inject any IO wait events.
> > > If the number of blocked threads is 0, we don't inject any IO wait events.
> > > If there are C idle CPUs and B blocked threads, we inject IO wait
> > > events with weight C/B for each of them.
> >
> > To track idle CPUs, you need sched-switch of all CPUs regardless of your
> > workload, right?  Also I'm not sure when do you want to inject the IO
> > wait events - when a thread is sched-out without preemption?  And what
> > would be the weight?  I guess you want something like:
> >
> >   blocked time * C / B
> >
> > Then C and B can change before the thread is woken up.
> 
> Yes, these events need to be emitted on every switch-in/out in the
> trace so that a long blocked thread gets multiple events with
> different weights.

Ok.

> 
> > > For example, if there is a single blocked thread, then we hypothesise
> > > that this blocked thread is the root cause of all currently idle CPUs
> > > being idle.
> >
> > I think this may make sense when you target a single process group but
> > it also needs system-wide idle information.
> 
> I assumed this profiling is done on a mostly idle system (generally
> it's a good idea for any profiling).
> 
> Theoretically, we could look at runnable threads rather than running.
> If there are NumCPU runnable threads, then creating more runnable
> threads won't help.

But it'd need to look at the state of the previous (sched-out) task in
sched_switch event which is a lot bigger.

> 
> > > This still has a problem of saying that unrelated threads contribute
> > > to latency, but at least it's a simple/explainable model and it should
> > > show guilty threads as well. Maybe unrelated threads can be filtered
> > > by the user by specifying a set of symbols in stacks of unrelated
> > > threads.
> >
> > Or by task name.
> >
> > >
> > > Does it make any sense? Do you have anything better?
> >
> > I'm not sure if it's right to use idle state which will be affected by
> > unrelated processes.  Maybe it's good for system-wide profiling.
> >
> > For a process (group) profiliing, I think you need to consider number of
> > total threads, active threads, and CPUs.  And if the #active-threads is
> > less than min(#total-threads, #CPUs), then it could be considered as
> > idle from the workload's perspective.
> >
> > What do you think?
> 
> I don't know, hard to say. I see what you mean, but this makes the
> problem even harder, and potentially breaking hypotheses we are
> making.
> For example, if we have 2 unrelated workloads A and B running on the
> machine. Their high- and low-parallelism phases will overlap randomly,
> and we will make conclusions from that, but these overlapping are
> really random and may not hold next time. Or next time A may be
> collocated with C.

Hmm.. but isn't it the same when you use idle state?  CPUs can go idle
randomly because of other workload IMHO.

> 
> I would solve the simpler problem of profiling a single workload on a
> mostly idle system first, and only then move to the harder case.

I agree with you to start with the simpler one.  I need to check the
code how you checked the idle state.


> Are you considering this for GWP-type profiling?

No, I'm not (for now).

Thanks,
Namhyung

