Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7327E1EE009;
	Fri, 24 Jan 2025 23:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737763056; cv=none; b=An02xIm13GcHFdLDj4LHNxRY3VLIvHZbPmGQqCYKnNoliIM5idgWnO2o3l+/669A/crZL1hRb7bbpwkDeLSQSjiflrJzzs4aKIO3iG97bKG4bZApjOsOykR+zSop05Hn/SUnUTB6Sc6ulYDAtVUom/L+bmb09yx96jhrdqmQYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737763056; c=relaxed/simple;
	bh=XUoR3QCKAa2K++lmTrQzAbkxt5IIRvj8wkBUT72pl1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lV60MNxekoWBDUNV6ecReejB7xk4GIIWbeGNbFYIfJS6tNzBSxs3b2wnI0hppo3/Qd0Vre/uwlv5VxdpZeZTpo06TMqBj+jwS89D8ABLxHhZAhu214ik5OpzHLswUowqpYcuql5clGWk2wigBhmZ/MwcHbSf0H35WJ5+RHjbwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45660C4CED2;
	Fri, 24 Jan 2025 23:57:33 +0000 (UTC)
Date: Fri, 24 Jan 2025 18:57:44 -0500
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
Message-ID: <20250124185744.69379ba6@gandalf.local.home>
In-Reply-To: <20250124225011.aebigdykpmnnthfg@jpoimboe>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jan 2025 14:50:11 -0800
Josh Poimboeuf <jpoimboe@kernel.org> wrote:

> Hm, reading this again I'm wondering if you're actually proposing that
> the unwind happens on @prev after it gets rescheduled sometime in the
> future?  Does that actually solve the issue?  What if doesn't get
> rescheduled within a reasonable amount of time?

Correct, it would be prev that would be doing the unwinding and not next.
But when prev is scheduled back onto the CPU. That way it's only blocking
itself.

The use case that people were doing this with was measuring the time a task
is off the CPU. It can't get that time until the task schedules back
anyway. What the complaint was about was that it could be a very long
system call, with lots of sleeps and they couldn't do the processing.

I can go back and ask, but I'm pretty sure doing the unwind when a task
comes back to the CPU would be sufficient.

-- Steve
