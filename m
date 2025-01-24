Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2BC18A93E;
	Fri, 24 Jan 2025 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737759017; cv=none; b=fwZx8dJMB7iyl/m4lc8fWz4iGRf5iroW1G7M+avWfpn6PAybH51Vh39DuKUGOcYTklZljVD53id08KwHCqNVVAilCeGNf7j44GJvy0XxZ7eWLIsydKJsxFbaV9Vl1Df45ZM6gygNrCXJXIxO6kyc4aEvhkniAZQNp5XM1sLZKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737759017; c=relaxed/simple;
	bh=PN8pLVwoBIiMsB0hfGHwoGwP2/OQk4yc/BJVgGMLty0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k3WqG4JxGboLEtcuY6k8Ja0DABUgCR4ks751ctpPyp91ChBDHold5ORsvOik3hnIiJH3awdYXW2dTpIC9yPnrAjhYD7ej2luFwYKhADSGqBizsPCnoD4gRcDMUG1pvPT5pX65p1DV63bOtGIishaHrcLP8IkVGE0MqNNPwu5O+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCjNJ62c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCjNJ62c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DB5C4CED2;
	Fri, 24 Jan 2025 22:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737759014;
	bh=PN8pLVwoBIiMsB0hfGHwoGwP2/OQk4yc/BJVgGMLty0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XCjNJ62csbK/zf0o3yiPRz5QbINQWh4YXdHasOTVeHZpoIa8NWUoG6cRlOhhjt3xL
	 C6sKFF0ZmxwdgVGGg0W+dJFoo8BFo9H48Mafe+rr+B+8pejAoor30WNI1OzwVw4H8L
	 He8nGRpzPhgyhEex2STZVwV/6XoJHC+ijpRTMv/YgRkCYNCJbsMLQjES5ZIGtYy7Q5
	 FZYdQ1GAbBiKpeWRv+BJ+oQ5oXqi0C7NgWVopLuOQinKRG/+fryj9VHsteFudXAGW3
	 41mC5WucT25nuEbsYE5NPCKZRjfKo2DbOBfeAmBL0lrhuZVY8l+2oA5JrLSIzOL6pt
	 O45tE66WqREwA==
Date: Fri, 24 Jan 2025 14:50:11 -0800
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
Message-ID: <20250124225011.aebigdykpmnnthfg@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
 <20250123040533.e7guez5drz7mk6es@jpoimboe>
 <20250123082534.GD3808@noisy.programming.kicks-ass.net>
 <20250123184305.rjuxj7hs3ond3e7c@jpoimboe>
 <20250123221326.GD969@noisy.programming.kicks-ass.net>
 <20250124165803.565c29ed@gandalf.local.home>
 <20250124224645.lcovfraeq53gegys@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250124224645.lcovfraeq53gegys@jpoimboe>

On Fri, Jan 24, 2025 at 02:46:48PM -0800, Josh Poimboeuf wrote:
> On Fri, Jan 24, 2025 at 04:58:03PM -0500, Steven Rostedt wrote:
> > Now the only thing I could think of is a flag gets set where the task comes
> > out of the scheduler and then does the stack trace. It doesn't need to do
> > the stack trace before it schedules. As it did just schedule, where ever it
> > scheduled must have been in a schedulable context.
> > 
> > That is, kind of like the task_work flag for entering user space and
> > exiting the kernel, could we have a sched_work flag to run after after being
> > scheduled back (exiting schedule()). Since the task has been picked to run,
> > it will not cause latency for other tasks. The work will be done in its
> > context. This is no different to the tasks accounting than if it does this
> > going back to user space. Heck, it would only need to do this once if it
> > didn't go back to user space, as the user space stack would be the same.
> > That is, if it gets scheduled multiple times, this would only happen on the
> > first instance until it leaves the kernel.
> > 
> > 
> > 	[ trigger stack trace - set sched_work ]
> > 
> > 	schedule() {
> > 		context_switch() -> CPU runs some other task
> > 				 <- gets scheduled back onto the CPU
> > 		[..]
> > 		/* preemption enabled ... */
> > 		if (sched_work) {
> > 			do stack trace() // can schedule here but
> > 					 // calls a schedule function that does not
> > 					 // do sched_work to prevent recursion
> > 		}
> > 	}
> > 
> > Could something like this work?
> 
> Yeah, this is basically a more fleshed out version of what I was trying
> to propose.
> 
> One additional wrinkle is that if @prev wakes up on another CPU while
> @next is unwinding it, the unwind goes haywire.  So that would maybe
> need to be prevented.

Hm, reading this again I'm wondering if you're actually proposing that
the unwind happens on @prev after it gets rescheduled sometime in the
future?  Does that actually solve the issue?  What if doesn't get
rescheduled within a reasonable amount of time?

-- 
Josh
