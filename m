Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC8215A864;
	Mon, 16 Sep 2024 18:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510566; cv=none; b=E4SK9uygEfqEt3TPn2GryUSGRJc9pq6h+u9XSNFG0YK3c4Brn3sqJAHiLvCBQDjP55mUTdhBD6PZgv7z11ajB+t5R4Y85NXDUZP9MHy4rQUPFvaUxFOYewJ9nQ3nI4kGnJqz6O0g6nMxN8iF5gZMs9BZoH2j/cVzPbDtJSRKNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510566; c=relaxed/simple;
	bh=6eO3MBXLw+/MZH3rmthMrcKzjz5ZrdzPUJU6FPpbDBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JA+N9QBgh8GiktVN9xRIb1Rx8kInGuldbO9877hsOf/0zmsD/5akvHPz5BMMFvTxEW5Wu7R2moBtssKl+IMXIwW0DKg02nzPCDVRcnqC71M844JwNoB7bg3U2nTYUN37vc9Aar/BQB6e2DTMIVhHbAZaRKiydusvbwfui7UMEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UseJU5DF; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UseJU5DF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qoNvWL4UG7AnBJpndXjo8yrfa8PYdP7qC0FsdSGsFpY=; b=UseJU5DFC+uSdeFx4Z+M9RnLzx
	H9zzsdqqAftRkUCFsIf0jO8ivumDXMDxRT1QvFOGVj3sN614u9igv5zmzD/gwrZQ/u/bYO75wU6ee
	lSXYpRdYfXTNCUbFvvF1mSHTFqsSTlLuXnWp428ljScY5mhVkrR+spirQ4kWSdtwLnngwjsvYuGFx
	kuFZTr2kohFdHnO0U2OAruyorsq3T82qm+MDdHJbZNz9l9iYl/Pn957c70gm7RB6TY7/NsDJuqApG
	PW+rcEQzr+koBAfbbtA/Cuxv4DzNFdU9IYCtUNtk6nXjvXFIeP4V7HVPfLiDBhMdhnGVXvFUyKJ0g
	thp2nOAw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sqGGJ-00000000QmO-1J72;
	Mon, 16 Sep 2024 18:15:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9A4E430049D; Mon, 16 Sep 2024 20:15:45 +0200 (CEST)
Date: Mon, 16 Sep 2024 20:15:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
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
	Sam James <sam@gentoo.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2 00/11] unwind, perf: sframe user space unwinding,
 deferred perf callchains
Message-ID: <20240916181545.GD4723@noisy.programming.kicks-ass.net>
References: <cover.1726268190.git.jpoimboe@kernel.org>
 <20240914081246.1e07090c@rorschach.local.home>
 <20240915111111.taq3sb5xzqamhb7f@treble>
 <20240916140856.GB4723@noisy.programming.kicks-ass.net>
 <20240916153953.7fq5fmch5uqg7tjj@treble>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240916153953.7fq5fmch5uqg7tjj@treble>

On Mon, Sep 16, 2024 at 05:39:53PM +0200, Josh Poimboeuf wrote:

> The cookie is incremented once per entry from userspace, when needed.
> 
> It's a unique id used by the tracers which is emitted with both kernel
> and user stacktrace samples so the userspace tool can stitch them back
> together.  Even if you have multiple tracers triggering at the same time
> they can all share a single user trace.

But perf don't need this at all, right? It knows that the next deferred
trace for that tid will be the one.

> > This scheme seems unsound

> > pin yourself on CPU0 and trigger 1<<48 unwinds while keeping CPU1 idle.
> 
> Hm???

The point being that it is possible to wrap one CPU into the id space of
another CPU. It is not trivial, but someone who wants to can make it
happen.

Combined I don't see the need to force this into this scheme, carry an
opaque (void*) pointer and let the user do whatever it wants, perf for
instance can pass NULL and not do anything like this.
