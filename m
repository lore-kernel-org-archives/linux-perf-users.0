Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEFD192B8C;
	Tue, 17 Sep 2024 21:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726610343; cv=none; b=GhmfFOjnO+i+Qa+ESdXmym9ZI3t2pcsp+NcA2vbIQaNuBwhcRW2McVR4/WXMSew/1kKhEiuFKz6HvqXQIm4Aq14a1EQQHXFDvdfEi5JaRZugGGWoj5jlDAHFrg+Ul33AeMPzlurNUjCzayNXYhiu3rTtEhDBtTQADsj9/6gJNTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726610343; c=relaxed/simple;
	bh=XHchNEjGNbXlp7Wqp7pU3mczMQTJAnogTJaHlJi9jHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx9colENnat9AFnFxp2vC2JW2Sb4CEzl1BbjJXd/R2Gs7n6qSIL2WPkfA3KkSpo8Bgs6ZuKOe9KzwU4vWhAEpQpUPecW+7N5sAvCkeAAt+c8X9x7mW5tfupQbNeFdQaZwQq+aNX9DSLKIMKPq+6LdO+qv7tC7Tn15JuU35amf7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MZDxK4kQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MZDxK4kQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E54C4CEC5;
	Tue, 17 Sep 2024 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726610342;
	bh=XHchNEjGNbXlp7Wqp7pU3mczMQTJAnogTJaHlJi9jHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MZDxK4kQzPjG6ufMCyg9tWmQBRitkI3Z0BsdEcOYQeGWCweSxzo8vC5yevlsMpvxw
	 lr9NJiOFcsZQbKdG1gN2WwIi9eqT3sssYqrZSOLPhnkNaJkxYTRQ34bO2EP5aQatSq
	 2s0V4ncLOSdMvQ+eT4zg/1KIrBjlZMGtB4pUnYCelN+JdZWD26WmNgfV6lpF1x5Zwi
	 EqGgj9vQd9TeCFPPFI10RqY4GZKuXr37VkX4xpJZKA6z9Xb2dKozt9U4UBCjxAl62f
	 csK0hqJ79hptrIlEVkjvqOkLLJp7KoAxXpN5TD/bHgyQfTdjfUw473Cprhz7bJstLr
	 j3HcTl7V40I3g==
Date: Tue, 17 Sep 2024 14:58:52 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <Zun7nKFzWz2J2rSz@google.com>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
 <20240915111111.taq3sb5xzqamhb7f@treble>
 <20240916140856.GB4723@noisy.programming.kicks-ass.net>
 <20240916153953.7fq5fmch5uqg7tjj@treble>
 <20240916181545.GD4723@noisy.programming.kicks-ass.net>
 <20240916184645.142face1@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916184645.142face1@rorschach.local.home>

Hello,

On Mon, Sep 16, 2024 at 06:46:45PM -0400, Steven Rostedt wrote:
> On Mon, 16 Sep 2024 20:15:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Sep 16, 2024 at 05:39:53PM +0200, Josh Poimboeuf wrote:
> > 
> > > The cookie is incremented once per entry from userspace, when needed.
> > > 
> > > It's a unique id used by the tracers which is emitted with both kernel
> > > and user stacktrace samples so the userspace tool can stitch them back
> > > together.  Even if you have multiple tracers triggering at the same time
> > > they can all share a single user trace.  
> > 
> > But perf don't need this at all, right? It knows that the next deferred
> > trace for that tid will be the one.

Well.. technically you can sample without tid.  But I'm not sure how
much it'd be useful if you collect callchains without tid.

> 
> Is that because perf uses per task buffers? Will perf know this if it
> uses a global buffer? What does perf do with "-a"?

Then it'd use per-cpu ring buffers.  But each sample would have pid/tid
pair and time so perf tools can match it with a deferred callchian.

Thanks,
Namhyung
