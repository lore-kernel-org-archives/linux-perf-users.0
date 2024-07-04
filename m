Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CE4C637;
	Thu,  4 Jul 2024 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720122409; cv=none; b=iQoYIImKyk4lYPA0rfO/XtXsNwX9cW/JSJYKzwh0Zk0uxekLCJYldqgqiVCBQ/kTHLxJPAJGJJGqoCr1pbHWx5K8Gfw29vmljm+VTHnp7WBBq7Z6iTQY5mF+GogUr+M9zn175GDmFZu0KYdWkiL8aF+gHqq/lj5Uk0BhcAJCkb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720122409; c=relaxed/simple;
	bh=hdzu6+x7pUc8kUm+CwDE52Hqd6ckmenuVTmuczXmn+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOZOQSEiFbyFQYVOFi6E0LobBM1eyQ4DKTltQI3+PEn3gBfd9wrTC3mZPUcVwUR5ZJmB99RsX/dEy60x1sRL5vW25Dls/3ySr14Qk/r6PjnFiRmslybHDfZciMP054r7gIjcvGvD2ugeApW1VrsBRgXtAdUkU28IxhZxToCBc3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGuFG9uq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGuFG9uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A0F1C3277B;
	Thu,  4 Jul 2024 19:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720122408;
	bh=hdzu6+x7pUc8kUm+CwDE52Hqd6ckmenuVTmuczXmn+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GGuFG9uq3bLP6U/cVg9DSfOAa60zNe5kpk2+DOEb7oXTSaRIiVQc4rGJRQqfPdOaV
	 C0g4+7v45cLDgQ4QOtdUvst22wGq6dzyCvlTqOi3KTXNliiU/XzhEeAD6jaBX4eLb+
	 SuPO8AgFCRCVp2gKeoU1TEPyYfgMhCnH8eCzleDt6CKYK6z5RaGB9ehjUco1nIB3y9
	 hv2e2QcisOBMsKLt7+CRgms0mV8WST15yJiMMmWLrdC7ozdUNjbdwFrhwQeJGx5U98
	 aDZDJhBEVjY3tNIWqL0Lua63+jpvpWIm4x3GY6YrlcsUYxJUZqLNRarOYxQNLtjUMr
	 VsyAPzjqgpzoA==
Date: Thu, 4 Jul 2024 16:46:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 0/6] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <Zob8JhK1VH0OKnbB@x1>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
 <Zob7zlMJy2Q_d_Fn@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zob7zlMJy2Q_d_Fn@x1>

On Thu, Jul 04, 2024 at 04:45:22PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jul 04, 2024 at 07:03:34PM +0200, Sebastian Andrzej Siewior wrote:
> > Hi,
> > 
> > Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> > the signal gets delayed until event_sched_out() which then uses
> > task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> > signal is delivered with disabled preemption.
> > 
> > While looking at this, I also stumbled upon __perf_pending_irq() which
> > requires disabled interrupts but this is not the case on PREEMPT_RT.
> > 
> > This series aim to address both issues while not introducing a new issue
> > at the same time ;)
> > Any testing is appreciated.
> 
> Were should I apply this patch? The v4 series was applied to
> linux-rt-devel/linux-6.10.y-rt IIRC

Looking at linux-rt-devel/linux-6.10.y-rt I see:

commit ca8b27c51f0962f8fb59e5acb23e0af791fb5c04
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Tue Jun 25 10:56:32 2024 +0200

    perf: Update the perf series
    
    This is an all-in-one patch integrating the following changes:
    
    - Merging Frederick's "Fix leaked sigtrap events" series as of v4 which
      is a dependency.
    
    - Update the "perf test sigtrap" fixup to v4 as posted.
    
    Link: https://lore.kernel.org/20240621091601.18227-1-frederic@kernel.org
    Link: https://lore.kernel.org/20240624152732.1231678-1-bigeasy@linutronix.de
    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

But I think that is v4, right?

- Arnaldo
>  
> > v4…v5: https://lore.kernel.org/all/20240624152732.1231678-1-bigeasy@linutronix.de/
> >    - Add TWA_NMI_CURRENT as notify mode for task_work_add() and use it.
> >      PeterZ pointed out that the current version is not NMI safe.
> > 
> > v3…v4: https://lore.kernel.org/all/20240322065208.60456-1-bigeasy@linutronix.de/
> >    - Rebased on top of Frederic's series
> >       (https://lore.kernel.org/all/20240621091601.18227-1-frederic@kernel.org)
> >    - Frederick pointed out that perf_pending_task() needs to
> >      perf_swevent_get_recursion_context() in order not to recurse if
> >      something within perf_swevent_.*_recursion_context() triggers a
> >      software event. To address this, the counters have been moved to
> >      the task_struct (#3 + #4) and preemt_disable() has been replaced
> >      with a RCU-read lock (#5).
> >    - The remaning logic same that means the event is pushed to task-work
> >      instead of delivering from IRQ-work. The series was tested with
> >      remove_on_exec as suggested by Marco Elver: On PREEMPT_RT a single
> >      invocation passes, 100 parallel invocations report (for some)
> >      unexpected SIGTRAPs and timeouts. This also observed on !RT
> >      (without the series) with a higher task-count.
> > 
> > v2…v3: https://lore.kernel.org/all/20240312180814.3373778-1-bigeasy@linutronix.de/
> >     - Marco suggested to add a few comments
> >       - Added a comment to __perf_event_overflow() to explain why irq_work
> >         is raised in the in_nmi() case.
> >       - Added a comment to perf_event_exit_event() to explain why the
> >         pending event is deleted.
> > 
> > v1…v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigeasy@linutronix.de/
> >     - Marco pointed me to the testsuite that showed two problems:
> >       - Delayed task_work from NMI / missing events.
> >         Fixed by triggering dummy irq_work to enforce an interrupt for
> > 	the exit-to-userland path which checks task_work
> >       - Increased ref-count on clean up/ during exec.
> >         Mostly addressed by the former change. There is still a window
> > 	if the NMI occurs during execve(). This is addressed by removing
> > 	the task_work before free_event().
> >       The testsuite (remove_on_exec) fails sometimes if the event/
> >       SIGTRAP is sent before the sighandler is installed.
> > 
> > Sebastian
> > 
