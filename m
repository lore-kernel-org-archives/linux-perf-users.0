Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057418B0F;
	Sun, 12 Apr 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776025017; cv=none; b=T2V8lyigi7vhLOYuVnIWD0HvyATTlvF/SaJyeN4aNVXfW4Wfu7/re5Z4ySMC99OH+qsQl4rTjSbwL4t9F5ZDpBAchk/0vcFV7ZTGx+mchrDcQqLmagpktYy01tR0VeP7HgN78xPkU/+FXsn/oWBNwEBeQdSFNTcsMyx6lYF6VN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776025017; c=relaxed/simple;
	bh=QKGjVM1byO9pxMHKpE5GnvLwR0ykKJAt4EomEbpe5rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiZPZayhY+qA+EHa6Es3kg5jO3NUsX4mb37IH65BgSBCwAmmAg6LSe1QHOVPL/3WZ/Fl/PO0wWpxHzpzaLnGaQM5/M2q9FQTv5nO//ku+2f7UuYGLFXiGJbpjpqxQ2g813Vx0g4Dm21bgdA5agT5ki2WJ7YL5cgnS4/dK+Fd+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6HZ7HMi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6HZ7HMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4122DC19424;
	Sun, 12 Apr 2026 20:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776025017;
	bh=QKGjVM1byO9pxMHKpE5GnvLwR0ykKJAt4EomEbpe5rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6HZ7HMiLd0oyzMC+hWoMemxpDmZMb4jO74PeLHtZg1hPb3dIfwBSlklkxbXZGU+r
	 Y8l2aFE/q8lwHwQmAEKBlXoNGTmMCq33PHsDT/SJPPAPKSJk0i3bh26zoYm5E0VFNk
	 WETpPKG+iMj8t7343LV3aKJhmFqfkvc1p/hwdzh0vxr2GHFMbrWGic2RL6VetgbdIc
	 oLuZAjh4QA/vH1wdWGBKAd28vv37jwK7DA8lA+Alv8MDVl67FLXeItve23naMCW4tE
	 I32kYcRq3ViKMNNK88AhT+fTVvc/v/uifoNnG1kZVPZyaGJLqZx/RqEyPg0nUIK1qG
	 oiN3+hNvaYJXQ==
Date: Sun, 12 Apr 2026 13:16:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v10 07/29] perf lock: Only pass sample to handlers
Message-ID: <adv9t-BRXA4tSZ0g@google.com>
References: <20260412020833.641177-8-irogers@google.com>
 <20260412022538.830B4C116C6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412022538.830B4C116C6@smtp.kernel.org>

On Sun, Apr 12, 2026 at 02:25:37AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Out-of-memory errors from get_callstack() are silently swallowed.
> --
> 
> commit 4d8eb4c521b8cbbd581b94a51ae57655ebd7ab69
> Author: Ian Rogers <irogers@google.com>
> perf lock: Only pass sample to handlers
> 
> This commit removes the unused evsel parameter from lock event handlers and
> adds a NULL check for sample->callchain in get_callstack().
> 
> > diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> > index e2b585e528aca..fcc33089b9455 100644
> > --- a/tools/perf/builtin-lock.c
> > +++ b/tools/perf/builtin-lock.c
> [ ... ]
> > @@ -948,9 +938,16 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
> >  	u64 i;
> >  	int c;
> >  
> > +	if (!sample->callchain) {
> > +		pr_debug("Sample unexpectedly missing callchain\n");
> > +		return NULL;
> > +	}
> > +
> >  	callstack = calloc(max_stack, sizeof(*callstack));
> > -	if (callstack == NULL)
> > +	if (callstack == NULL) {
> > +		pr_debug("Failed to allocate callstack\n");
> >  		return NULL;
> > +	}
> >  
> >  	for (i = 0, c = 0; i < sample->callchain->nr && c < max_stack; i++) {
> >  		u64 ip = sample->callchain->ips[i];
> [ ... ]
> > @@ -1070,7 +1066,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel __maybe_unused
> >  	if (needs_callstack()) {
> >  		u64 *callstack = get_callstack(sample, max_stack_depth);
> >  		if (callstack == NULL)
> > -			return -ENOMEM;
> > +			return 0;
> 
> Does this inadvertently swallow the memory allocation failure from
> get_callstack()?
> 
> Since get_callstack() returns NULL both when the callchain is missing and
> when calloc() fails, changing this return from -ENOMEM to 0 means the tool
> will now silently drop events when memory is exhausted instead of propagating
> the error.

I've removed this part for now.

Thanks,
Namhyung

