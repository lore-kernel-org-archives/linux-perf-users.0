Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60E3A16A8;
	Wed,  7 Oct 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366275; cv=none; b=bkKOKQSC2L+eNvH9LWruSE/hbKN7W/BBtCyIASIP4a97NM+jpxvSd84ULyLCkqTsNx3YmjKci9kfl4Z6xs8XeY5rxpRnSds7JWPYLjfLhnYq0rA0IXQPM7hmgY+fdyTpjXAMTGhHjtrdwjvVihBhDneOBBTkdOVAuqiTYx6jh2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366275; c=relaxed/simple;
	bh=nVyUikFS83jrl7eInMd8sch4UkMvLRN9Zo0n4e0sWUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwP0tfZhOYFO5Ojeh1ZXhdWW6bPZ5v5jGlM10oe3VHz9XQ37h4vSHZBn+uHN4VkXK9fmlg3QQ4lFI5nTCf82/aQAVYr1Ad9A3CbAufPR9uKty3iWL6Em9bCHPSh1tDblD1Y//cnSt3T0GBVdXmpCRKZbytl6WGYsIBe/96cOQGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb2eiVyE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb2eiVyE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 759941F0089B;
	Wed,  7 Oct 2026 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791366264;
	bh=beNAX/c6ny4wg2xm6dYkqkzdisfgjWDJ6w1eTxk1V5U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Kb2eiVyEL4tlFvmIWqT+tcj4Xy4fR6sI/494lTQ1znw2Kzdv5iQGWV+jxmSBVSQZn
	 3Wgvn1HB0SQKrLR0qDwlrZXRxrdlARB6YIR1kza/Jl8f3OW3oMilQYPqS+E7xTFzUL
	 nKc4hCwnMk4ByKUIW73SRtNsHVjxleSc40Y5c96Xd42twMcVs5EBdKEGL9QXEfUOV7
	 j7yblnE68cJ3mMIDFyOLv22FbXwZtx78rOwr10tG6lBCjW+LgDAWAJZ7G7eUJmX0CI
	 S+fCW2f/UFo+tnbmtV2JO4Lr5AeWTNjCV9SVYxWupy3hGoQaYV5gIazDH8LbY9Pcdx
	 3T11kOD0FrV3g==
Date: Wed, 7 Oct 2026 11:44:20 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 0/8] perf tools: Add progress diagnostics and a
 false-sharing workload
Message-ID: <asYUdNszhQkQPSLN@x2>
References: <20261006145729.3028247-1-acme@kernel.org>
 <asWNQWokyx9F6iRq@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asWNQWokyx9F6iRq@google.com>

On Tue, Oct 06, 2026 at 05:07:29PM -0700, Namhyung Kim wrote:
> On Tue, Oct 06, 2026 at 04:57:21PM +0200, Arnaldo Carvalho de Melo wrote:
> >   - move perf_config__set_variable() to util/config.c and serialize config
> >     parser and read-modify-write state, so non-builtin perf code can persist
> >     configuration changes safely;
> >   - add 'perf report --progress' for stdio users, showing the current phase,
> >     percentage, and counts while a session is processed;
> >   - wire up 'perf report --no-progress', the counterpart of the option
> >     above, for the TUI and GTK browsers, whose progress there is no other
> >     way to turn off;
> >   - add 'perf test -w false_sharing', a synthetic TCP-shaped workload with
> >     identity and packet counters sharing a cacheline, and include it in the
> >     data type profiling shell test.
> > Follow up work: the DO_ONCE() one-time init primitive added here mirrors
> > what the eight pre-existing raw pthread_once() users in util/ (annotate.c,
> > callchain.c, comm.c, dso.c, fncache.c, intel-tpebs.c, libbfd.c, pmus.c)
> > need, conversions that will also exercise the DEFINE_MUTEX() static
> > initializer; converting them is left for after this series.
> > Best regards,
 
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
