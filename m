Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD63232;
	Fri, 24 Jan 2025 21:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737755876; cv=none; b=kmgaEzuZAJcp3EReZ1ADGh5Hq4Tt1U16JtDL5ys2NOsxfM8tNWvPvOnBWPy1TjbhPR3FP8e+moH54ryjPoZqSebE6A3Es3bQWolR6cbpDw4TAfJmRH9A8cCsvJ83/rEMerULtArDiAV9MqtzZYLokFZ9gJWxlxXQmsDrDrL5u4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737755876; c=relaxed/simple;
	bh=a8j//TXYuzakVMJulOkRRanNDtAFn6MXEtxJKhHw3BE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBk+tDYWEa5NSJWcMTRupQ7vEp7OF3TqAkuZy5GzbCT7cRhL3UGhkhAnLaDTQb9owrGYGdcD5kbO7IjSV5FbRHLOpBFjhJU/ZjnzuVj6qTCwsEA/sYA6Vq05pVZ2OrG0rGQuUwGk7KNEDhAYj2GKISuUIiiTIpP+8ZW4SpCuPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611C6C4CED2;
	Fri, 24 Jan 2025 21:57:53 +0000 (UTC)
Date: Fri, 24 Jan 2025 16:58:03 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Mathieu Desnoyers
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
Message-ID: <20250124165803.565c29ed@gandalf.local.home>
In-Reply-To: <20250123221326.GD969@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
	<6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
	<e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
	<20250123040533.e7guez5drz7mk6es@jpoimboe>
	<20250123082534.GD3808@noisy.programming.kicks-ass.net>
	<20250123184305.rjuxj7hs3ond3e7c@jpoimboe>
	<20250123221326.GD969@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jan 2025 23:13:26 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> -EPONIES, you cannot take faults from the middle of schedule(). They can
> always use the best effort FP unwind we have today.

Agreed.

Now the only thing I could think of is a flag gets set where the task comes
out of the scheduler and then does the stack trace. It doesn't need to do
the stack trace before it schedules. As it did just schedule, where ever it
scheduled must have been in a schedulable context.

That is, kind of like the task_work flag for entering user space and
exiting the kernel, could we have a sched_work flag to run after after being
scheduled back (exiting schedule()). Since the task has been picked to run,
it will not cause latency for other tasks. The work will be done in its
context. This is no different to the tasks accounting than if it does this
going back to user space. Heck, it would only need to do this once if it
didn't go back to user space, as the user space stack would be the same.
That is, if it gets scheduled multiple times, this would only happen on the
first instance until it leaves the kernel.


	[ trigger stack trace - set sched_work ]

	schedule() {
		context_switch() -> CPU runs some other task
				 <- gets scheduled back onto the CPU
		[..]
		/* preemption enabled ... */
		if (sched_work) {
			do stack trace() // can schedule here but
					 // calls a schedule function that does not
					 // do sched_work to prevent recursion
		}
	}

Could something like this work?

-- Steve
