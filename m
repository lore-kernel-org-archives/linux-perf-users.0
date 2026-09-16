Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8014E50D3;
	Wed, 16 Sep 2026 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789584855; cv=none; b=BhyY/Y4WCy39v4k+ajZaIw/KiMpefuDIm9PkSKxouq434YTdYM5azp9AY7RlJr12/URUVXmkMBNIbaaHgE8awo9KfZJ7TkzSXozvXImVbeAaFoDrLyvydd3HFHJhmuEVPHl8SB9ub23VhDPh4bwJ+xq9kfivvBEcjp27tETmwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789584855; c=relaxed/simple;
	bh=nq4yxfPmxq8tg8A4+oWfRMiPvyMERaFSE2FqEAd1yc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMlQM7dhWTwfLu75gKvXsFoMklL3QQE7BS2+oXbkX82VrRQ/iT2ZmiO+TEwpPZZ3DLh6xduB0ovUYCOCe5o2GqtE8rUOSCM7fSoel3fQUHjmNHmHQhvxuuhB95rlOtvQaz7pdwCXAKPF+X3D8ebbzfuADGHYOOvDfDAEBclX0Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RId118fD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RId118fD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8651F000FF;
	Wed, 16 Sep 2026 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789584837;
	bh=EUc04wLsH81TP/wK2o6rPFRNswhGGYkw4lx3QOdluX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RId118fDO8PGYTbyDNE+4TnhP3BO7oB+RCHtfcCb0EkM/a2A76vHKhPX9PzGsTAHe
	 mbv1Kdjmf2ArrTxxMTvz+v859UPCYf4yEor7EVwBefVdRDAsDOCR+7qegUHuB5Ri2t
	 Z5YyS8EEZOnWmCdb31WQVq+KOUCxqgwLz9rGBT7di38zEeKkSYr5nIeWtLv/TFnZvA
	 v/HDlgurKMr6U3P/P3DwYamSOSj/37H/9i6bDhY2UsZDFF9eMjamqXudVFrZr3gSjB
	 TIzYfuUXMhfnP4M6+ifaFGX/pJe3imJuVWK8IaHlP8fCpx4jtQo4pC0onWiZO+o4N4
	 j7Jg4XtAm3Z/A==
Date: Wed, 16 Sep 2026 11:53:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 04/12] perf debuginfo: Let the user skip and disable
 debuginfod fetches
Message-ID: <aqrlw1YzYHFBdvcz@google.com>
References: <20260916114740.48230-1-acme@kernel.org>
 <20260916114740.48230-5-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916114740.48230-5-acme@kernel.org>

On Wed, Sep 16, 2026 at 08:47:31AM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> When a fetch is in progress, the way it prints progress is how one
> gets out of it: 's' aborts the current fetch via the debuginfod
> client's progress callback protocol and remembers the build ID, so
> that the rest of the session doesn't ask for it again, the user may
> have skipped it for being too big; 'd' additionally disables debuginfod
> for the rest of the session, clearing DEBUGINFOD_URLS so that libdwfl's
> own client, that reads it in every query, stops fetching too, and, using
> perf_config__set_variable(), moved to util/config.c in the previous
> patch, writes core.debuginfod=false to the configuration file directly,
> the user's ~/.perfconfig or the one named by PERF_CONFIG, the same
> rewrite 'perf config' does -- the comments are not preserved, as the
> config set carries just the key-value pairs -- and SIGINT, SIGQUIT and
> SIGTERM are intercepted while the terminal is in raw mode, so that it is
> restored and the signal is re-raised when the user interrupts a fetch.
> 
> In the TUI nothing is shown yet, printing to stderr would garble the
> browser display and draining stdin would eat the keys the browser
> wants, that comes in the next patch.
> 
> The interaction state -- the terminal settings, the signal dispositions
> and the progress and cancellation state -- is process global, so the
> fetches stay serialized: a second fetch resetting the cancellation
> state would drop the 's'/'d' keypress that was meant for the fetch
> already in progress, and the serialization the lookup state needs
> already provides the lock the interaction state uses.
> 
> Since the debuginfo fetching this builds on is opt-out, a fetch that
> the user asked to skip is not restarted by the next request for the
> same build ID in the same session, it is remembered as a cancellation
> on the misses list, where the debug message can tell it apart from a
> plain miss.
> 
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
[SNIP]
> +/*
> + * The stdio fetch UI: the terminal is in raw mode, see
> + * debuginfod__fetch(), so the keypresses are on stdin, drain them.
> + */
> +static void debuginfod__poll_cancel_keys(void)
> +{
> +	char ch;
> +
> +	while (read(STDIN_FILENO, &ch, 1) == 1)
> +		debuginfod__cancel_key(ch);

Isn't it block indefinitely when users don't press any key?  I'm curious
how it can escape from the loop when it finishes to fetch.

Thanks,
Namhyung

> +}
> +
> +/*
> + * Print a warning and a progress indicator when the debuginfod client
> + * ends up fetching a file, which can be big, such as the vmlinux for a
> + * kernel profiled on another machine or before it got upgraded, so that
> + * users know perf is not stuck, and let them bail out: 's' skips this
> + * fetch and remembers the build ID, so that the rest of the session
> + * doesn't ask for it again, 'd' also disables debuginfod for the rest
> + * of the session.
> + *
> + * The client invokes this both while fetching, where 'a' is the number
> + * of bytes transferred so far and 'b' the total size, zero when it
> + * doesn't know it yet, and, before committing to a server, from the
> + * cache cleanup, that scans the debuginfod client cache, with 'a' being
> + * the number of cache files scanned so far and 'b' zero.
> + *
> + * In the stdio case the progress goes to stderr, a \r terminated line,
> + * the keys are drained from stdin, that debuginfod__fetch() put in raw
> + * mode.
> + */
> +static int debuginfod_progress_fn(debuginfod_client *c __maybe_unused,
> +				  long a, long b)
> +{
> +	if (debuginfod_signal)
> +		return 1;
> +
> +	if (!isatty(STDERR_FILENO) || use_browser)
> +		return 0;
> +
> +	if (isatty(STDIN_FILENO)) {
> +		debuginfod__poll_cancel_keys();
> +		if (debuginfod_fetch_cancelled)
> +			return 1;
> +	}
> +
> +	if (!debuginfod_progress_started) {
> +		fprintf(stderr, "Fetching debuginfo by build ID from the debuginfod servers, this may take a while for large files such as the vmlinux, press 's' to skip, 'd' to skip and disable\n");
> +		debuginfod_progress_started = true;
> +	}
> +
> +	if (a >= 0) {
> +		if (b > 0)
> +			fprintf(stderr, "  %ld/%ld MiB fetched\r", a >> 20, b >> 20);
> +		else
> +			fprintf(stderr, "  %ld MiB fetched\r", a >> 20);
> +	}
> +
> +	return 0;
> +}
