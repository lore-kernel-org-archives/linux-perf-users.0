Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277A234CE4;
	Thu, 16 Jan 2025 18:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737053711; cv=none; b=dG3Cr0/IiwzxJ70zxiYrCZE15FkdQhoJ2YT4Bo1ESid/2qTyffJ8pjUSoW6CkBytzI69GaxAQUI7yTtaYUxGM44xAkm06XhAjh5sov4IJ/9H/o5WKGUTRHR+79bsAwV6VdawK9qfyP/DoDJX0rwbj7LakxvV5QEAlwGB/CcfcsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737053711; c=relaxed/simple;
	bh=GjN9CRNUsQVdxrwKdp8D8zNv08JZcn8mZ5FSI1G92bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPczIUd2jXjUX5HN7VvgUnmrZ5g8FZSx0oMwgCNsAccLKUV8asfrMGxSOk5B28vhAS8qbWMR04CS5/kAC5Vajgb0sTOqqDFc1U6ef+iSRN/2HuAH1WImIJI3VwvCykLfJD9d/yw2EUMxcNwRaUibvXRczeQvu9UZ001iQAfHL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZbJhOai; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZbJhOai"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7CAC4CEE2;
	Thu, 16 Jan 2025 18:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737053710;
	bh=GjN9CRNUsQVdxrwKdp8D8zNv08JZcn8mZ5FSI1G92bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZbJhOai5N1Std6NRP/4z6SsjvISYLO1PvRi+kqHvTHlVw99doXZD7CCVv/XceJqz
	 foLOCROegeeXULBj6ShhOJPBRm48k+rZrk8r/IHUBkwUPe+0EgbjOziLfpFo6E/l13
	 h8SRvzEn0OEg2TVgl5QQvGD1jv1Nb+kyhbk8XUxExvsIAPQY+KzrXlkkBDmqo31GVo
	 kRnstLvBnF2OtUAUuvUnhCjJJLXf/nCX179Id+6756wWOVLy8G4gEtUzImvuLVrxTF
	 Audzh0wIffH317D1n1tEiesxnjhA8njwpvxi642YHjQFT0isE66pPRmDUX02VqcNne
	 EzkGoCzGSLVvw==
Date: Thu, 16 Jan 2025 10:55:08 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, eranian@google.com,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	chu howard <howardchu95@gmail.com>
Subject: Re: [PATCH v2] perf report: Add wall-clock and parallelism profiling
Message-ID: <Z4lWDPpmdQDM1k6l@google.com>
References: <CACT4Y+b4WYa9TSqKtDKTJNgXth1U30=KddutfSdp5gmXVOV_jA@mail.gmail.com>
 <20250113134022.2545894-1-dvyukov@google.com>
 <Z4XDJyvjiie3howF@google.com>
 <CACT4Y+b96xynNaZoBHP72-4tJM5Nzo3MBRW19_E7JsMKRWYCzg@mail.gmail.com>
 <CAP-5=fWHivx7Q6okMwYOs=65MZr40RjE16tgatMX0hjkCfrwfw@mail.gmail.com>
 <CACT4Y+Yh98VcNgmJ-gF9+inw=ZDkg1rRzi4_35f6krw8BBRpug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACT4Y+Yh98VcNgmJ-gF9+inw=ZDkg1rRzi4_35f6krw8BBRpug@mail.gmail.com>

On Wed, Jan 15, 2025 at 08:11:51AM +0100, Dmitry Vyukov wrote:
> On Wed, 15 Jan 2025 at 06:59, Ian Rogers <irogers@google.com> wrote:
> >
> > On Tue, Jan 14, 2025 at 12:27 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> > [snip]
> > > FWIW I've also considered and started implementing a different
> > > approach where the kernel would count parallelism level for each
> > > context and write it out with samples:
> > > https://github.com/dvyukov/linux/commit/56ee1f638ac1597a800a30025f711ab496c1a9f2
> > > Then sched_in/out would need to do atomic inc/dec on a global counter.
> > > Not sure how hard it is to make all corner cases work there, I dropped
> > > it half way b/c the perf record post-processing looked like a better
> > > approach.
> >
> > Nice. Just to focus on this point and go off on something of a
> > tangent. I worry a little about perf_event_sample_format where we've
> > used 25 out of the 64 bits of sample_type. Perhaps there will be a
> > sample_type2 in the future. For the code and data page size it seems
> > the same information could come from mmap events. You have a similar
> > issue. I was thinking of another similar issue, adding information
> > about the number of dirty pages in a VMA. I wonder if there is a
> > better way to organize these things, rather than just keep using up
> > bits in the perf_event_sample_format. For example, we could have a
> > code page size software event that when in a leader sampling group
> > with a hardware event with a sample IP provides the code page size
> > information of the leader event's sample IP. We have loads of space in
> > the types and config values to have an endless number of such events
> > and maybe the value could be generated by a BPF program for yet more
> > flexibility. What these events would mean without a leader sample
> > event I'm not sure.
> 
> In the end I did not go with adding parallelism to each sample (this
> is purely perf report change), so at least for this patch this is very
> tangential :)
> 
> > Wrt wall clock time, Howard Chu has done some work advancing off-CPU
> > sampling. Wall clock time being off CPU plus on CPU. We need to do
> > something to move forward the default flags/options for perf record,
> > for example, we don't enable build ID mmap events by default causing
> > the whole perf.data file to be scanned looking to add build ID events
> > for the dsos with samples in them. One option that could be a default
> > could be off-CPU profiling, and when permissions deny the BPF approach
> > we can fallback on using events. If these events are there by default
> > then it makes sense to hook them up in perf report.
> 
> Interesting. Do you mean "IO" by "off-CPU".
> Yes, if a program was blocked for IO for 10 seconds (no CPU work),
> then that obviously contributes to latency, but won't be in this
> profile. Though, it still works well for a large number of important
> cases (e.g. builds, ML inference, server request handling are
> frequently not IO bound).
> 
> I was thinking how IO can be accounted for in the wall-clock profile.
> Since we have SWITCH OUT events (and they already include preemption
> bit), we do have info to account for blocked threads. But it gets
> somewhat complex and has to make some hypotheses b/c not all blocked
> threads contribute to latency (e.g. blocked watchdog thread). So I
> left it out for now.
> 
> The idea was as follows.
> We know a set of threads blocked at any point in time (switched out,
> but not preempted).
> We hypothesise that each of these could equally improve CPU load to
> max if/when unblocked.
> We inject synthetic samples in a leaf "IO wait" symbol with the weight
> according to the hypothesis. I think these events can be  injected
> before each switch in event only (which changes the set of blocked
> threads).
> 
> Namely:
> If CPU load is already at max (parallelism == num cpus), we don't
> inject any IO wait events.
> If the number of blocked threads is 0, we don't inject any IO wait events.
> If there are C idle CPUs and B blocked threads, we inject IO wait
> events with weight C/B for each of them.

To track idle CPUs, you need sched-switch of all CPUs regardless of your
workload, right?  Also I'm not sure when do you want to inject the IO
wait events - when a thread is sched-out without preemption?  And what
would be the weight?  I guess you want something like:

  blocked time * C / B

Then C and B can change before the thread is woken up.

> For example, if there is a single blocked thread, then we hypothesise
> that this blocked thread is the root cause of all currently idle CPUs
> being idle.

I think this may make sense when you target a single process group but
it also needs system-wide idle information.

> 
> This still has a problem of saying that unrelated threads contribute
> to latency, but at least it's a simple/explainable model and it should
> show guilty threads as well. Maybe unrelated threads can be filtered
> by the user by specifying a set of symbols in stacks of unrelated
> threads.

Or by task name.

> 
> Does it make any sense? Do you have anything better?

I'm not sure if it's right to use idle state which will be affected by
unrelated processes.  Maybe it's good for system-wide profiling.

For a process (group) profiliing, I think you need to consider number of
total threads, active threads, and CPUs.  And if the #active-threads is
less than min(#total-threads, #CPUs), then it could be considered as
idle from the workload's perspective.

What do you think?

Thanks,
Namhyung

