Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC2913C809;
	Mon,  5 Aug 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722889231; cv=none; b=ByuD3CTyNynrPSzCllBIVZg0dPP6FX9bVnL/6WBimbp93I9OPs6Gzjui+3AicrJYvc1husV/ADCg04bmoOpU87cBYz11Vq6Ev834nQVkB+6qAGRjmKt9pZYqxRopchknw+NLSTZR0QPpI4oIdVL9YYZgU2FjOsTs31cfVdj2B44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722889231; c=relaxed/simple;
	bh=YnHqiwHC0r0CQROotklnma9dFaOYTX3qZk3p8KPeEUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKyyVwDbquA/UGpWNY0Td8jJ9sgCVfThH8YyMxBxlM5ubl2Z46qVM5XOWe3zlttsod4LfYq66F9vZB6e1o/QE14vP85pGeGIAgrKDNAwd3ijo67YPRfTgzUzK5ZWjqT6XqgeMBQbyreJLYySpwU4s1s3jDxxVv/77TjrzrZI6Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOWpkFDq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOWpkFDq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBB2C32782;
	Mon,  5 Aug 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722889231;
	bh=YnHqiwHC0r0CQROotklnma9dFaOYTX3qZk3p8KPeEUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aOWpkFDq1ESmckUPhObVsdcn8ZTW6rO291B/x8AWOqq4gcB6C8uMy2xonawJjR2GF
	 RZu7WLymWxYbztmeJInDWK7dPLVWz7Os6wnSY4Dyr1GMcxXMF3RzLG+RgAItVoBpmd
	 3Y4L5C/MfFw1gBf1sVtvhpt7Ops3txemW84BChx0/W9awu0gowYJV2Pf+J0LPFFPdL
	 D1GIIHGGyyZMeUlNUmI9f6tx4MjkB2koruxZ4vpyxfMfa+eZE9QoKHZ4QJUSTQc5IM
	 w6auXU9SypWg6jlxQtdk5T5XlW1vflDsq+AtTQuMPJi0nTWMLKKJuxfx3Zmgqz6hKl
	 Uc0M2sjNctmfw==
Date: Mon, 5 Aug 2024 17:20:26 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: weilin.wang@intel.com
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [RFC PATCH v18 3/8] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Message-ID: <ZrE0CtHsDOS7vUw9@x1>
References: <20240720062102.444578-1-weilin.wang@intel.com>
 <20240720062102.444578-4-weilin.wang@intel.com>
 <ZrEqr36sukDW66uV@x1>
 <ZrErSvqHMvzw3dm2@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrErSvqHMvzw3dm2@x1>

On Mon, Aug 05, 2024 at 04:43:06PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Aug 05, 2024 at 04:40:37PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Sat, Jul 20, 2024 at 02:20:56AM -0400, weilin.wang@intel.com wrote:
> > > From: Weilin Wang <weilin.wang@intel.com>
> > > 
> > > When retire_latency value is used in a metric formula, evsel would fork a perf
> > > record process with "-e" and "-W" options. Perf record will collect required
> > > retire_latency values in parallel while perf stat is collecting counting values.
> > > 
> > > At the point of time that perf stat stops counting, evsel would stop perf record
> > > by sending sigterm signal to perf record process. Sampled data will be process
> > > to get retire latency value. Another thread is required to synchronize between
> > > perf stat and perf record when we pass data through pipe.
> > > 
> > > Retire_latency evsel is not opened for perf stat so that there is no counter
> > > wasted on it. This commit includes code suggested by Namhyung to adjust reading
> > > size for groups that include retire_latency evsels.
> > 
> > Failing at this point:
> > 
> > ⬢[acme@toolbox perf-tools-next]$ git log --oneline -5
> > 13430131acc4f88b (HEAD) perf stat: Fork and launch perf record when perf stat needs to get retire latency value for a metric.
> > b7b9adefb5d57aaf perf data: Allow to use given fd in data->file.fd
> > 3a442bf266d1f3c7 perf parse-events: Add a retirement latency modifier
> > ce533c9bc6deb125 (perf-tools-next.korg/tmp.perf-tools-next, acme.korg/tmp.perf-tools-next) perf annotate: Add --skip-empty option
> > bb588e38290fb723 perf annotate: Set al->data_nr using the notes->src->nr_events
> > ⬢[acme@toolbox perf-tools-next]$
> > 
> > I'll see if when a followup patch gets applied this gets solved, if so
> > will try to fixup things or ask for help, since this seems to be
> > breaking 'git bisect' for this codebase.
> 
> Indeed, when the next patch gets applied it builds without problems.
> I.e. patch  4/8 fixes problems in patch 3/8, maybe just combine them
> into one single patch?

I have everything in the tmp.perf-tools-next branch at:

https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git

I'll check later or tomorrow if I can fixup the bisection breakage
described above or if just sqashing together 3/8 with 4/8 is better,
please advise.

Then I'll move it to the perf-tools-next branch.

- Arnaldo
