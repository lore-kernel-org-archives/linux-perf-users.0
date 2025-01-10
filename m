Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F219207A15;
	Fri, 10 Jan 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736518282; cv=none; b=JC9iu4sq3CWOgc+m6CtQhaQh1GWewIgV8d8IXGSxEsy+zktzGXb+WxugF2GrEeXSu+H57CvMzwXc0HWvkuHhky4qwYPGDSmF+B/moFlMO6LfGGVbpyQCfbewG+MUlhDzX/IBn5eDd74nubnRzTrSP766A3ltqP7vjD186We7eJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736518282; c=relaxed/simple;
	bh=hVkhG81ekKLweqSTcFtTEYKWAO36YZpJWo0m0luk+6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z2JeADpNisaMxxvEdrtej0TKYGVc6qH93BpBBTdoE8AQxI2pYby68pFHTIinv9svOW/FgQjHYrStqAK/UqtSAqISgxDANaKRMMB7i/rK4l3VS/A6cKYptcsbXaBElr3obnwyPi+kmcjBNii1laPCfkZ1MRepCBigSSMgL69kcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaWioAUn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaWioAUn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D34CC4CED6;
	Fri, 10 Jan 2025 14:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736518281;
	bh=hVkhG81ekKLweqSTcFtTEYKWAO36YZpJWo0m0luk+6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VaWioAUnXlUU7iTwry6j4MBOPs6klmXc7LKQs1CYCO75Zgfp2HBr7iJKrezQN/bUR
	 dYr0v8/j8UK69HXkzUkgFTNX9yIM51qh7NlEdsM/i9r6tM8Z73o/y6il2KeJdU53tA
	 OlvM48y1dm+eQFpq2EcrHhPYc1gI1WM2ZWIEge+3JNSCsk5jFi1tGxz8MISH1qFw8Q
	 brJ6g2YbSnp8P2Q76yjv5QLCP4+i7MzlTiV0lis/IgpcACvI8Gf0k1KQGGJSPQadbS
	 3B1PrZEOytTw8besqoeJRzTim6NLIJIEoo6brwmVJ545/8EHqslyAp4WZ+EF7bA3sk
	 QtC25JDMH3kbA==
Date: Fri, 10 Jan 2025 11:11:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Kan Liang <kan.liang@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: Re: [PATCH 2/2] perf ftrace: Fix display for range of the first
 bucket
Message-ID: <Z4Eqh5R1M5dElkYN@x1>
References: <20250108210015.1188531-1-namhyung@kernel.org>
 <20250108210015.1188531-2-namhyung@kernel.org>
 <Z4Ep7WbRhZXVINCc@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Ep7WbRhZXVINCc@x1>

On Fri, Jan 10, 2025 at 11:08:48AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 08, 2025 at 01:00:15PM -0800, Namhyung Kim wrote:
> > When min_latency is not given, it prints 0 - 0.  It should be 0 - 1.
> > 
> > Before:
> >   $ sudo ./perf ftrace latency -a -T do_futex sleep 1
> >   #   DURATION     |      COUNT | GRAPH                                          |
> >        0 -    0 us |        321 | ###########                                    |
> >   ...
> > 
> > After:
> >   $ sudo ./perf ftrace latency -a -T do_futex sleep 1
> >   #   DURATION     |      COUNT | GRAPH                                          |
> >        0 -    1 us |        699 | ############                                   |
> >   ...
> > 
> > Fixes: b875b6bf608589 ("perf ftrace latency: Introduce --min-latency to narrow down into a latency range")
> 
> I couldn't find the above cset in perf-tools not perf-tools-next nor in
> upstream, I fixed it up to:

It is just in perf-tools-next, so probably I did some rebase and that
explains this. Anyway, that should be stable now.

- Arnaldo
 
> Fixes: 08b875b6bf608589 ("perf ftrace latency: Introduce --min-latency to narrow down into a latency range")
> 
> Thanks,
> 
> - Arnaldo
> 
> > Cc: Gabriele Monaco <gmonaco@redhat.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-ftrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> > index 90cf2c9915a7e35b..cfd770ec72867d77 100644
> > --- a/tools/perf/builtin-ftrace.c
> > +++ b/tools/perf/builtin-ftrace.c
> > @@ -840,7 +840,7 @@ static void display_histogram(struct perf_ftrace *ftrace, int buckets[])
> >  	bar_len = buckets[0] * bar_total / total;
> >  
> >  	printf("  %4d - %4d %s | %10d | %.*s%*s |\n",
> > -	       0, min_latency, use_nsec ? "ns" : "us",
> > +	       0, min_latency ?: 1, use_nsec ? "ns" : "us",
> >  	       buckets[0], bar_len, bar, bar_total - bar_len, "");
> >  
> >  	for (i = 1; i < NUM_BUCKET - 1; i++) {
> > -- 
> > 2.47.1.613.gc27f4b7a9f-goog
