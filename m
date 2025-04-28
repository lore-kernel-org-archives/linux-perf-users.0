Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CBD186284;
	Mon, 28 Apr 2025 20:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745872940; cv=none; b=YanC3nQGNuz3ZFVQOs5NJWXVk5Di9MVHuvfH9SpweHNJz8bI4DA7/jPwhXOyRsG/0Fh6V2cK8UpiumGo9/H0g8aLmLYn++hWXpFXf0zN5yLy3UIwrU1g3Qlyb9V8kgR6eaSrNrpLs9p2J6xqWSDJMuL0jzx3V8PuzBtiSyhFJWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745872940; c=relaxed/simple;
	bh=V0uWzclMr2r/WAwDMRAdUM4T2DZ/rdMtbW/axAzMidY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6f5iC+7mfTKFplDwIkYZk34r4sSjOsrBcmgo4ciewGjW0l52pti3eOEjhOMbCqn4Vo0yP4KGZuy38uYkofV4ZBh2Oza4kQxa0flnOtHRcvOMo/UgvEcRgJVsiDOpyIM5gK7+kRtGbnIGTnjQm7/Athcw/wHRTIughsby+PUIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sm9EWizy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sm9EWizy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41CB0C4CEE4;
	Mon, 28 Apr 2025 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745872938;
	bh=V0uWzclMr2r/WAwDMRAdUM4T2DZ/rdMtbW/axAzMidY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sm9EWizyaC+EPmMkIokOwSgMmHtKXllVhpWHjjfuF8ul9YSnOc3D8iKL7jte0m9g0
	 F/3LjKi5p0yf6ov+fi4hHI2Y46xmoZ0FpGgyTazaP9g/14gDaI9c/x9fipZS6YbyaN
	 HJ2qeIGnT8nPB7oNwPS1Yb7Sd8lOqBZX8a4oJePJkL038MsHbV6Q96W9yvt/TPur0a
	 M0mx+VxVBTnL9eL2jIFF/EI4oiXkl3gmYMSG635T5orCP+8917RbmOQNFzMVeOfa+u
	 WBWjrOol3x5/4dJ+ukk/Fq5bzww/JHqtm0P2fl9CmuqBtf06GieGbVWJaxJivjVocn
	 wGqJJjRbgiWVA==
Date: Mon, 28 Apr 2025 13:42:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>,
	Blake Jones <blakejones@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <aA_oJ7tgGv-H4ocX@google.com>
References: <20250424162529.686762589@goodmis.org>
 <20250424162633.390748816@goodmis.org>
 <aAupP56jOM_wul_8@google.com>
 <20250425125815.5c5b33be@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425125815.5c5b33be@gandalf.local.home>

On Fri, Apr 25, 2025 at 12:58:15PM -0400, Steven Rostedt wrote:
> On Fri, 25 Apr 2025 08:24:47 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
> > > +/*
> > > + * Returns:
> > > +*     > 0 : if already queued.
> > > + *      0 : if it performed the queuing
> > > + *    < 0 : if it did not get queued.
> > > + */
> > > +static int deferred_request(struct perf_event *event)
> > > +{
> > > +	struct callback_head *work = &event->pending_unwind_work;
> > > +	int pending;
> > > +	int ret;  
> > 
> > I'm not sure if it works for per-CPU events.  The event is shared so any
> > task can request the deferred callchains.  Does it handle if task A
> > requests one and scheduled out before going to the user mode, and task B
> > on the CPU also requests another after that?  I'm afraid not..
> 
> I was afraid of that.
> 
> This is no different that what Josh did in his last set in v4. I'm guessing
> the issue is running with "-a", correct?

Yes.

> 
> Could we just not use deferred when running with "-a" for now? Or could we
> possibly just make the deferred stacktrace its own event? Have it be
> possible that perf just registers a signal instance with the deferred
> unwinding logic, and then perf can handle where to write the information. I
> don't know perf well enough to implement that.

Even if it excludes per-CPU events, per-task events also can attach to a
CPU and that's the default behavior of the perf record IIRC.  In that
case, it needs to be careful when it accesses the event since the task
can migrate to another CPU.  So I'm not sure if it's a good idea to
track event that requested the deferred callchains.

Also it doesn't need to emit duplicate deferred callchains if a task
has multiple events and they are requesting callchains.  Unfortunately,
the kernel cannot know which events are related or profiled together.

Hmm.. maybe we can add a cookie to the event itself (by ioctl or
something) in order to group events in a profiling session and then use
that for deferred callchains?  Task should maintain a list of active
cookies (or sessions) somehow but then perf can check if the current CPU
has events with matching cookies and emit a deferred callchain.

> 
> Josh's code had it call the unwind_deferred_init() and just used its own
> event to callback to and that was called on hundreds of events when I ran:
> 
>   perf record -g <whatever>
> 
> Same if I added the "-a" option.
> 
> The above function return values came from Josh's code:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/tree/kernel/unwind/deferred.c?h=sframe#n173
> 
> I just moved it out of deferred.c and into perf itself, and removed the
> cookie logic.
> 
> > 
> > > +
> > > +	if (!current->mm || !user_mode(task_pt_regs(current)))
> > > +		return -EINVAL;  
> > 
> > Does it mean it cannot use deferred callstack when it's in the kernel
> > mode like during a syscall?
> 
> task_pt_regs(current) will return the regs from when the task entered the
> kernel. So the answer is no, it will still trace if an interrupt happened
> while a task is in a system call.

Ok, thanks for the explanation.  The the user_mode check was for kernel
threads, right?

Thanks,
Namhyung

