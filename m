Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D064A35;
	Thu, 30 Jan 2025 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738268474; cv=none; b=hMEoQ4FMZIxQwcT50KzWerm4xaxHfgQcrYYTnIFoo4gONlGKQ6tUvqFU+6JZbnfbFgRsJV9yjW1vwhkqhpfIq1Rbulta7Em7mdLz6t4O6L1AqYt3MQp2B8AFGJuB07+Hyi0K9rhgkhrZkw2DJBybANZ698JVnNl+Ty+PE/mSFYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738268474; c=relaxed/simple;
	bh=wLSa6HAlF+w1VkgiKjXM+Rmb1W9nq8QutO1/L+h5Zio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcRaFZemmSnp6dipvyj8fy7pzIcLMTc0cC6ige9uLt/vwr8ZwSZTRK+3IpKqa/NPrlQwm2XKMQSoS1PmWPPkfbOeMEWI8qgyoNUpbyvS66TAA1madNulLr5Bi+E8Vzy5WOWfevMjCvlgctEj3JYMu331ZOUOt2XYRC0NA1IkazQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F9A6C4CED2;
	Thu, 30 Jan 2025 20:21:11 +0000 (UTC)
Date: Thu, 30 Jan 2025 15:21:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, x86@kernel.org, Ingo Molnar
 <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>, Mark
 Rutland <mark.rutland@arm.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, Mark
 Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, Jordan Rome
 <jordalgo@meta.com>, Sam James <sam@gentoo.org>,
 linux-trace-kernel@vger.kernel.org, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, Florian
 Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250130152136.51bee69b@gandalf.local.home>
In-Reply-To: <20250124185744.69379ba6@gandalf.local.home>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
	<e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
	<20250123040533.e7guez5drz7mk6es@jpoimboe>
	<20250123082534.GD3808@noisy.programming.kicks-ass.net>
	<20250123184305.rjuxj7hs3ond3e7c@jpoimboe>
	<20250123221326.GD969@noisy.programming.kicks-ass.net>
	<20250124165803.565c29ed@gandalf.local.home>
	<20250124224645.lcovfraeq53gegys@jpoimboe>
	<20250124225011.aebigdykpmnnthfg@jpoimboe>
	<20250124185744.69379ba6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 18:57:44 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Jan 2025 14:50:11 -0800
> Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> 
> > Hm, reading this again I'm wondering if you're actually proposing that
> > the unwind happens on @prev after it gets rescheduled sometime in the
> > future?  Does that actually solve the issue?  What if doesn't get
> > rescheduled within a reasonable amount of time?  
> 
> Correct, it would be prev that would be doing the unwinding and not next.
> But when prev is scheduled back onto the CPU. That way it's only blocking
> itself.
> 
> The use case that people were doing this with was measuring the time a task
> is off the CPU. It can't get that time until the task schedules back
> anyway. What the complaint was about was that it could be a very long
> system call, with lots of sleeps and they couldn't do the processing.
> 
> I can go back and ask, but I'm pretty sure doing the unwind when a task
> comes back to the CPU would be sufficient.
> 

Coming back from this. It would be fine if we could do the back trace when
we come back from the scheduler, so it should not be an issue if the task
even has to schedule again to fault in the sframe information.

I was also wondering if the unwinder doesn't keep track of who requested
the back trace, just that someone did. Then it would just take a single
flag in the task struct to do the back trace. Return the "cookie" to the
tracer that requested the back trace, and when you do the back trace, just
call all callbacks with that cookie. Let the tracer decided if it wants to
record the back trace or ignore it based on the cookie.

That is, the tracers would need to keep track of the cookies that it cares
about, as if there's other tracers asking for stack traces on tasks that
this tracer doesn't care about it needs to handle being called when it
doesn't care about the stack trace. That said, if you want to trace all
tasks, you can just ignore the cookies and record the traces.

-- Steve
