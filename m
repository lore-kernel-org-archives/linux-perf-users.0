Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AC15625A;
	Thu, 23 Jan 2025 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737657788; cv=none; b=iFdssDsmOdiKkWhuPwwxsOQPbyo5+nyS3y0zsycz3lFk/ySPlQVtD7MzWsQmRGnBCXAYmpt7tXW1KZEJ+3u4z9yELH1aeQl/ksRtXkX9dkwCuSOcQwC5q0AkwEFq+tqJ984wuK5+77vwayK2e13M9CHwAnEA9DhzJg2OQwCn9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737657788; c=relaxed/simple;
	bh=1I1Qzg0rVDit+pAFlgUmK98i+dbpD8zLzGhP3sQKtN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQyIyOCh9F96DEqhuD70oTRmGSKMaCad+g7K1xl8/ymqEsEHgMk6uFwIGM+RhTXJGwj/8Sm8aBkwnCGjcpRBBQAv3Ej654dSjOV4wNNmXkOiP0IkWXxfs4/Wb2zM1xOJAru+/1AsExdUMAu2vBI0HgnGJ8lB4FwFJyUR6RB/vJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrvkkXsO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrvkkXsO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D567C4CED3;
	Thu, 23 Jan 2025 18:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737657787;
	bh=1I1Qzg0rVDit+pAFlgUmK98i+dbpD8zLzGhP3sQKtN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrvkkXsORV83sNa20ViH7QzcrNhZXTMYnW4wr82a1CjV0xZ1cFV2cgAqMhwSPCgEo
	 EeYEWsajJL3kl3hEIlhW+/7sKtecasDgZwtCH31TrnG1Fwiti03R/3pGcASTq4MZee
	 uhfqZ+73njuqhylwA6SX7xMyIxdZ4FMrU9RNGNMXImFeYNLpoqMfxi6WxxbVKqGPEh
	 KtlXc/Fxf5AVPE+jyBdQNzHJ6WooXSnFOxkQPB9izRAZJhJkAPbzt0u+58E2ri9N+y
	 RRRCDwdt5kgWWxAThYWiZwb7GfOYheQJA52a37I03l2D20wPl/kHdEp0Dm1Oxdkc68
	 ggTI5aHzyx7GA==
Date: Thu, 23 Jan 2025 10:43:05 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20250123184305.rjuxj7hs3ond3e7c@jpoimboe>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <6052e8487746603bdb29b65f4033e739092d9925.1737511963.git.jpoimboe@kernel.org>
 <e92fc832-ef46-4863-9316-24f30d8d82fd@efficios.com>
 <20250123040533.e7guez5drz7mk6es@jpoimboe>
 <20250123082534.GD3808@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123082534.GD3808@noisy.programming.kicks-ass.net>

On Thu, Jan 23, 2025 at 09:25:34AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 22, 2025 at 08:05:33PM -0800, Josh Poimboeuf wrote:
> 
> > However... would it be a horrible idea for 'next' to unwind 'prev' after
> > the context switch???
> 
> The idea isn't terrible, but it will be all sorta of tricky.
> 
> The big immediate problem is that the CPU doing the context switch
> looses control over prev at:
> 
>   __schedule()
>     context_switch()
>       finish_task_switch()
>         finish_task()
> 	  smp_store_release(&prev->on_cpu, 0);
> 
> And this is before we drop rq->lock.
> 
> The instruction after that store another CPU is free to claim the task
> and run with it. Notably, another CPU might already be spin waiting on
> that state, trying to wake the task back up.
> 
> By the time we get to a schedulable context, @prev is completely out of
> bounds.

Could unwind_deferred_request() call migrate_disable() or so?

How bad would it be to set some bit in @prev to prevent it from getting
rescheduled until the unwind from @next has been done?  Unfortunately
two tasks would be blocked on the unwind instead of one.

BTW, this might be useful for another reason.  In Steve's sframe meeting
yesterday there was some talk of BPF needing to unwind from
sched-switch, without having to wait indefinitely for @prev to get
rescheduled and return to user.

-- 
Josh
