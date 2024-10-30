Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83E1BD9DD;
	Wed, 30 Oct 2024 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310475; cv=none; b=Cg9x8blrWFLAA7az7mwyCXkMRfc8MDsGWxLSGltgWobWITv02LlHr4L6iSAPWjMMhTf5sKDMk+/v4evKCKaRMyXQv9la7cPSwGTiPU6rG7Gw3skgRDldkpN3XrqNBCMvgGzmKLKWrpdwpWtjFVPoKEg9GXvQxyrUwYK7S31GlKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310475; c=relaxed/simple;
	bh=vYTQVlgGMWO96K/3QDgzX63B6p2f9iKkPER0yzpOEBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izeajAo3b+mtkHrot05mse4t0NyNCF9w8msQyb9eOILggWp3fD3d3AhpvMJzOGckeDOigM6LmTLI6Om1vW3ydrMOtbLMqSwkHy3lVNJnKa3Fi/T5SE5ArpqlGRNsgBqgPtfruVg1CYTgGW46LK9NBcSWEmuwdh06Ri0y9nbKafU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEED2xPL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEED2xPL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D5EC4CECE;
	Wed, 30 Oct 2024 17:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730310475;
	bh=vYTQVlgGMWO96K/3QDgzX63B6p2f9iKkPER0yzpOEBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEED2xPLUa4s1Q6S58fY+whz/cH+wVXH9Az0I2RqB3WZDVkFXwDMElu5ERFYhQHil
	 dV9XoHErDQ7iV84LCBtD/rmd2Kc5yqxJWEUkPOW/KFBVo3aEMKTjCfFPt1Go5ZBUEx
	 U74Sm3TRsKOj/c8DT4yg9wyh6T9HetuqWINdP6t0UiQz7mq8XqegHyjNq8Ag+aDqSf
	 FztGLSUaKOtUYMFY92zbwUFwPDUrXmUhvx0T8Svn8UYo+elRvRcF9iMQ+y+C5PsOZN
	 dPeEt0SW4cnZJlUA2UJgz5bA4LEmHTEmynT8hnFKTd3oL5bEPSKRwb0e3BFDNxCY2p
	 e+oTq2riUJLIA==
Date: Wed, 30 Oct 2024 10:47:52 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
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
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v3 11/19] unwind: Add deferred user space unwinding API
Message-ID: <20241030174752.gwzk6q6n2f3sg52a@treble.attlocal.net>
References: <cover.1730150953.git.jpoimboe@kernel.org>
 <a94eb70a80c4a13dedb2655b7848304a992cb1b0.1730150953.git.jpoimboe@kernel.org>
 <20241029135617.GB14555@noisy.programming.kicks-ass.net>
 <20241029171752.4y67p3ob24riogpi@treble.attlocal.net>
 <bcd11a07-45fb-442b-a25b-5cadc6aac0e6@efficios.com>
 <20241029183440.fbwoistveyxneezt@treble.attlocal.net>
 <74afc8d4-621a-4876-a8cf-6165a913e4b3@efficios.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <74afc8d4-621a-4876-a8cf-6165a913e4b3@efficios.com>

On Wed, Oct 30, 2024 at 09:44:14AM -0400, Mathieu Desnoyers wrote:
> What you want here is to move the point where you clear the task
> cookie to _after_ completion of stack unwind. There are a few ways
> this can be done:
> 
> A) Clear the task cookie in the task_work() right after the
>    unwind_user_deferred() is completed. Downside: if some long task work
>    happen to be done after the stack walk, a new unwind_user_deferred()
>    could be issued again and we may end up looping forever taking stack
>    unwind and never actually making forward progress.
> 
> B) Clear the task cookie after the exit_to_user_mode_loop is done,
>    before returning to user-space, while interrupts are disabled.

Problem is, if another tracer calls unwind_user_deferred() for the first
time, after the task work but before the task cookie gets cleared, it
will see the cookie is non-zero and will fail to schedule another task
work.  So its callback never gets called.

> > If I change the entry code to increment a per-task counter instead of a
> > per-cpu counter then this problem goes away.  I was just concerned about
> > the performance impacts of doing that on every entry.
> 
> Moving from per-cpu to per-task makes this cookie task-specific and not
> global anymore, I don't think we want this for a stack walking
> infrastructure meant to be used by various tracers. Also a global cookie
> is more robust and does not depend on guaranteeing that all the
> trace data is present to guarantee current thread ID accuracy and
> thus that cookies match between deferred unwind request and their
> fulfillment.

I don't disagree.  What I meant was, on entry (or exit), increment the
task cookie *with* the CPU bits included.

Or as you suggested previously, the "cookie" just be a struct with two
fields: CPU # and per-task entry counter.

-- 
Josh
