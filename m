Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905381A9B48;
	Fri, 25 Apr 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600181; cv=none; b=Pfn7JBR4eitASKAzyXMgMe1E+XLrVuLm1uQ6ahRFBtJ+JFKuBe3s7kc8G9DUxrQLxCzRds0fsVe+Yu7zDTXF6u+nUoSXFT/rSoUmXa7QAQ+lbIdbAuQW31sNOFO4aRC/2/rIaI/UlXmNwqav1OTdmY2YVoV6m2OpNa+afVRVQms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600181; c=relaxed/simple;
	bh=7bLymEJM7zPsKDvgdEe/EvNJwvGyKZa6h6ULmTf9nGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FptHstD3esiEM7G3ulZuOrOzwnGDQrJ+hvJtfL8ix9jsFMU3KpjsbGdvSPCCfuybhUZyHKK9MSrnVt879erR/2kw2iqgoqrAbb1GMenrLbNDfvheQqU15yT7RkjN5DuwybeYhnsHOOHsGmeIcI68YXU0Wc/S6xOK9Teop4G4cp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052ACC4CEE4;
	Fri, 25 Apr 2025 16:56:17 +0000 (UTC)
Date: Fri, 25 Apr 2025 12:58:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>
Subject: Re: [PATCH v5 13/17] perf: Support deferred user callchains
Message-ID: <20250425125815.5c5b33be@gandalf.local.home>
In-Reply-To: <aAupP56jOM_wul_8@google.com>
References: <20250424162529.686762589@goodmis.org>
	<20250424162633.390748816@goodmis.org>
	<aAupP56jOM_wul_8@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 08:24:47 -0700
Namhyung Kim <namhyung@kernel.org> wrote:
> > +/*
> > + * Returns:
> > +*     > 0 : if already queued.
> > + *      0 : if it performed the queuing
> > + *    < 0 : if it did not get queued.
> > + */
> > +static int deferred_request(struct perf_event *event)
> > +{
> > +	struct callback_head *work = &event->pending_unwind_work;
> > +	int pending;
> > +	int ret;  
> 
> I'm not sure if it works for per-CPU events.  The event is shared so any
> task can request the deferred callchains.  Does it handle if task A
> requests one and scheduled out before going to the user mode, and task B
> on the CPU also requests another after that?  I'm afraid not..

I was afraid of that.

This is no different that what Josh did in his last set in v4. I'm guessing
the issue is running with "-a", correct?

Could we just not use deferred when running with "-a" for now? Or could we
possibly just make the deferred stacktrace its own event? Have it be
possible that perf just registers a signal instance with the deferred
unwinding logic, and then perf can handle where to write the information. I
don't know perf well enough to implement that.

Josh's code had it call the unwind_deferred_init() and just used its own
event to callback to and that was called on hundreds of events when I ran:

  perf record -g <whatever>

Same if I added the "-a" option.

The above function return values came from Josh's code:

  https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/tree/kernel/unwind/deferred.c?h=sframe#n173

I just moved it out of deferred.c and into perf itself, and removed the
cookie logic.

> 
> > +
> > +	if (!current->mm || !user_mode(task_pt_regs(current)))
> > +		return -EINVAL;  
> 
> Does it mean it cannot use deferred callstack when it's in the kernel
> mode like during a syscall?

task_pt_regs(current) will return the regs from when the task entered the
kernel. So the answer is no, it will still trace if an interrupt happened
while a task is in a system call.

-- Steve
