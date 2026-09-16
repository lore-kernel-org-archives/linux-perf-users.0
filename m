Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E01481A8C;
	Wed, 16 Sep 2026 21:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594039; cv=none; b=s0RK/4+0+/F0n1plH9iAPvaYUH3z1LXfzrLg6sa8Dzb8fEx1mTE4GYCbaUZBtG2aaBh5W0CZSE9R7ITfrtXRFHXlxLAYr/PLXPPDc5uGo2r3AYWqGi6X0uSL7p99+Z2eeYG/XeUldV2l/E878o9iryo/kNuva+uxJRCLWRlw8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594039; c=relaxed/simple;
	bh=ewqPR1hSrBjCW69VvH7iCDZXX88dfiqXQ5s91UAO1KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDAbWSsBBNg3G8T+pCRF5X/cWLRrlLUIifgIfy/TP4X1CkA7FZ6ukJInWFK4qDVyibVkBu5Utm+9y81JwKxyWy41ZdLXpoX0x6rZRlIe0yvlewMmgDMTuyMi5vxj0yHSslnV2OysdyP62qmzZuAHZizhE6jHxVqrp5ILskiCzs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7sRb6mt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7sRb6mt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7CE1F000FF;
	Wed, 16 Sep 2026 21:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789594025;
	bh=KsJK5CVKzAAfbDBiCC2MNN35JO+Fjsxxzz2W7zvL9xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G7sRb6mtB7i0vkf3VtYCMsnWxcJ5PibIYuXz4zQbbFsARzEUXONgSmVKD4p9HBqT6
	 ybufz/XjJxx559KmkHFPUhEm7m8DhXfeLx/igWhAtOOePc6ZQtn2whiRPTiv2ThUOl
	 CS+O72gA1mcS9wWS1p94Nnm1lgYpI2p6NxAEL88lnPOKqgu605d1fZDPQvw7Bw5aqa
	 YYwKxgobeUk2k5SYGwhvu4SE18hRVZucOC2WXlALWum4pTjyIxl6o63IJ0OS6NQrtN
	 ABy7kn1Yuh6hvnzwjuCfci+Q+5tzs8c+O5paYjI3Lut3OE0sPXlf4D2Tsm2yDaG7wt
	 jtu0utsw1cNKA==
Date: Wed, 16 Sep 2026 18:27:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 04/12] perf debuginfo: Let the user skip and disable
 debuginfod fetches
Message-ID: <aqsJpsJZcM7gzhLG@x2>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-5-acme@kernel.org>
 <aqrlw1YzYHFBdvcz@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqrlw1YzYHFBdvcz@google.com>

On Wed, Sep 16, 2026 at 11:53:55AM -0700, Namhyung Kim wrote:
> On Wed, Sep 16, 2026 at 08:47:31AM -0300, Arnaldo Carvalho de Melo wrote:
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > When a fetch is in progress, the way it prints progress is how one
> > gets out of it: 's' aborts the current fetch via the debuginfod
> > client's progress callback protocol and remembers the build ID, so
> > that the rest of the session doesn't ask for it again, the user may
> > have skipped it for being too big; 'd' additionally disables debuginfod
> > for the rest of the session, clearing DEBUGINFOD_URLS so that libdwfl's
> > own client, that reads it in every query, stops fetching too, and, using
> > perf_config__set_variable(), moved to util/config.c in the previous
> > patch, writes core.debuginfod=false to the configuration file directly,
> > the user's ~/.perfconfig or the one named by PERF_CONFIG, the same
> > rewrite 'perf config' does -- the comments are not preserved, as the
> > config set carries just the key-value pairs -- and SIGINT, SIGQUIT and
> > SIGTERM are intercepted while the terminal is in raw mode, so that it is
> > restored and the signal is re-raised when the user interrupts a fetch.
> > 
> > In the TUI nothing is shown yet, printing to stderr would garble the
> > browser display and draining stdin would eat the keys the browser
> > wants, that comes in the next patch.
> > 
> > The interaction state -- the terminal settings, the signal dispositions
> > and the progress and cancellation state -- is process global, so the
> > fetches stay serialized: a second fetch resetting the cancellation
> > state would drop the 's'/'d' keypress that was meant for the fetch
> > already in progress, and the serialization the lookup state needs
> > already provides the lock the interaction state uses.
> > 
> > Since the debuginfo fetching this builds on is opt-out, a fetch that
> > the user asked to skip is not restarted by the next request for the
> > same build ID in the same session, it is remembered as a cancellation
> > on the misses list, where the debug message can tell it apart from a
> > plain miss.

> > Assisted-by: LLM
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> [SNIP]
> > +/*
> > + * The stdio fetch UI: the terminal is in raw mode, see
> > + * debuginfod__fetch(), so the keypresses are on stdin, drain them.
> > + */
> > +static void debuginfod__poll_cancel_keys(void)
> > +{
> > +	char ch;
> > +
> > +	while (read(STDIN_FILENO, &ch, 1) == 1)
> > +		debuginfod__cancel_key(ch);
 
> Isn't it block indefinitely when users don't press any key?  I'm curious
> how it can escape from the loop when it finishes to fetch.

With the help of AI:

it can't block — it's a drain, not a wait. set_term_quiet_input()
(util/term.c) puts the terminal in raw mode with VMIN = 0; VTIME = 0, so
read() returns 0 when there is nothing typed; the while (read(...) == 1)
loop drains what was typed and returns to the progress callback, which
returns to libdebuginfod, which carries on fetching and calls it again
at the next update. When the fetch finishes there are no more callbacks.

But then there are other issues in that series, from Ian, and from
myself, locally, I'll submit a new version soon.

- Arnaldo
