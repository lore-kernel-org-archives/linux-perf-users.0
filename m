Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F93F6C48;
	Thu, 15 Oct 2026 04:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792037240; cv=none; b=BwHpbZ4TKKMJASo63SUL08vYmoFYs/83Dc7IJgGrnY0oWfHO9ahOh1FRXEjqdOPLoHigtp3b3AWSjOXKnizXkri5cCtjKvLCuuPBogcjqdtlUAvUEynfGEsodrBHOV4bhYmeAc82qNmirpqFBrqXb21jdcY+/1B8QyB1KziDYjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792037240; c=relaxed/simple;
	bh=GrPfTQvqM12lW3dyMyVc7frEbkZ245lNcMFQgTpCIDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bis9nKWDE1PfJP5vVU9ZKnNnOTUP3w2Awt9gayNl42LubUpebtcW+sXzJ4F19XqaaR1aT/R8m/UNNFqrQyPco5qN3gJ2ZAFz26D9TwEoQ9HB/L/Mcoh6BUjJTxHo5j5M31qBFrVdBaMOsrFnPi0cA8QDPopb8a1pS813S/ODpCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLNQcjKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLNQcjKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668241F000C4;
	Thu, 15 Oct 2026 04:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792037238;
	bh=eTlVW2YXR+bM+VaUqKGxnlKRNnKJwOr2ASdK6XnTcyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aLNQcjKSs0AbU/JZKRVvHhMmazrJpwXeC2+IwQGEWlKpwzDPjz30EoLSbSraCZEnR
	 o6cPWbww8DzyPVpX/Z4Cm2ZApUKTh/wO/f77tnx0ppgIBznWThWTT358qfyyKRxG5h
	 JWEvvSf4SGWAW8udC16RZA6wJlsqjvPtLgPrHTP3S5+5BwgbBlbjqVGriupZ5SZza/
	 NAcCj8xAL67QY7AMIYoY26zDRYK2uJjzzkjBwz3BdQ3KP4CbXjV8L09m9eSl/yD+Vu
	 nw5QlourRIjFgbamrk90v1OxeRIwLvJxi6/vqUsrIOH2JjjtdFNIusxfUK47Yricie
	 K42ejCQmVlrCA==
Date: Wed, 14 Oct 2026 21:07:16 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Changbin Du <changbin.du@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v4] perf bench: Add atomic operations benchmark
Message-ID: <atBRdE0Nh8OyWiBC@z2>
References: <20261013085648.976819-1-changbin.du@gmail.com>
 <as_z4g6CZTObWm2H@google.com>
 <atA7Mgrupnil4Jcv@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atA7Mgrupnil4Jcv@mail.google.com>

On Thu, Oct 15, 2026 at 10:38:17AM +0800, Changbin Du wrote:
> On Wed, Oct 14, 2026 at 02:28:02PM -0700, Namhyung Kim wrote:
> > On Tue, Oct 13, 2026 at 04:56:48PM +0800, Changbin Du wrote:
> [..]
> > > +
> > > +static const struct option options[] = {
> > > +	OPT_UINTEGER('t', "threads", &threads,
> > > +		     "Number of contending threads (default: 2, or 1 on single CPU)"),
> > > +	OPT_UINTEGER('r', "runtime", &runtime,
> > 
> > Can you please pick a different short option than 'r'?  perf bench
> > itself has -r/--repeat option so it would be confusing.  It doesn't
> > clash for now, but I think it's better to use perf bench options from
> > 'perf bench atomic ...' later.
> > 
> 
> Agreed -- I'll drop the short options; --threads and --runtime
> stay long-only so no bench option (e.g. -r/--repeat) is shadowed
> at perf bench atomic .... Will send an updated patch.

Well.. but short options are easier to use.  I think you can use 'R' and
'T' instead.

Thanks,
Namhyung

