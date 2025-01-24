Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03019E975;
	Fri, 24 Jan 2025 22:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737758809; cv=none; b=qcGKcIgTeVCIi8issAXLjEok7kdyRg4XUv3vXnltfmRedTbow7OiQYiC81Rj15NMMWq64RpbejhfXaWcRof9bj07LPbuZJ47QL+fq1Ul1MnEfAzIRAH4rhSj2i/PsISILyiWp00DGJwGT9aTSDDPJRBG8hEgbf9wJs+AfRBuZNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737758809; c=relaxed/simple;
	bh=76BJhGDZ0qsjhHEGajgAdiZ9KAVN3V//xjtf3ccLXC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fny1m+RYu4lhnzlJZ+7lUNY46cLT9k/P3InySDjYvmPy40SE0KLvrfro4OEaKn5x80wMQ2z5clihu8mBczm+dA+2BJAOroUC98A4/yB8u23uQq3ys+gl4szRzXZFOxJoDf9hd0lyG5Vj9DN9ZiUtf0ZuIYUkx2PPbuU/Ak7m8aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSYMX1j0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSYMX1j0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A640C4CED2;
	Fri, 24 Jan 2025 22:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737758808;
	bh=76BJhGDZ0qsjhHEGajgAdiZ9KAVN3V//xjtf3ccLXC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSYMX1j08Tuxd9CpN6Mq5Wg7ZxK7QKlkJfRY7ENu5k8GxlaonLDHY/4WVrpG/KZ+n
	 N76/JrBTGGHllOol0XeYn9mWFXmbLpTlGp2Y+BtWQaOczNF/ANvXuls/fFG2Pw8f9O
	 4olrYMT9tZyDYDCriACcKSXB3KePLq6xJVe7aHlQwts91M0js/mhOOG8pj7djoHUXS
	 /jcnrzPgXlqBH37Tzf4chhDgRcBwNOrrDOhouANuDNhnO/h8CqVHIyw/0Xs3ZyEsTT
	 FJoAWth7zvFptba8P5dNil7sdDYhWEs3/BstWlKjBDkF6xIoBm7uGhp4PbaPmvzZCW
	 XV9MRUMURE0pQ==
Date: Fri, 24 Jan 2025 14:46:45 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 28/39] unwind_user/deferred: Add deferred unwinding
 interface
Message-ID: <20250124224645.lcovfraeq53gegys@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
 <20250123040533.e7guez5drz7mk6es@jpoimboe>
 <20250123082534.GD3808@noisy.programming.kicks-ass.net>
 <20250123184305.rjuxj7hs3ond3e7c@jpoimboe>
 <20250123221326.GD969@noisy.programming.kicks-ass.net>
 <20250124165803.565c29ed@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124165803.565c29ed@gandalf.local.home>

On Fri, Jan 24, 2025 at 04:58:03PM -0500, Steven Rostedt wrote:
> On Thu, 23 Jan 2025 23:13:26 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > -EPONIES, you cannot take faults from the middle of schedule(). They can
> > always use the best effort FP unwind we have today.
> 
> Agreed.
> 
> Now the only thing I could think of is a flag gets set where the task comes
> out of the scheduler and then does the stack trace. It doesn't need to do
> the stack trace before it schedules. As it did just schedule, where ever it
> scheduled must have been in a schedulable context.
> 
> That is, kind of like the task_work flag for entering user space and
> exiting the kernel, could we have a sched_work flag to run after after being
> scheduled back (exiting schedule()). Since the task has been picked to run,
> it will not cause latency for other tasks. The work will be done in its
> context. This is no different to the tasks accounting than if it does this
> going back to user space. Heck, it would only need to do this once if it
> didn't go back to user space, as the user space stack would be the same.
> That is, if it gets scheduled multiple times, this would only happen on the
> first instance until it leaves the kernel.
> 
> 
> 	[ trigger stack trace - set sched_work ]
> 
> 	schedule() {
> 		context_switch() -> CPU runs some other task
> 				 <- gets scheduled back onto the CPU
> 		[..]
> 		/* preemption enabled ... */
> 		if (sched_work) {
> 			do stack trace() // can schedule here but
> 					 // calls a schedule function that does not
> 					 // do sched_work to prevent recursion
> 		}
> 	}
> 
> Could something like this work?

Yeah, this is basically a more fleshed out version of what I was trying
to propose.

One additional wrinkle is that if @prev wakes up on another CPU while
@next is unwinding it, the unwind goes haywire.  So that would maybe
need to be prevented.

-- 
Josh
