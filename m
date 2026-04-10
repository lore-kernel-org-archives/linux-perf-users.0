Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DE51E1E04;
	Fri, 10 Apr 2026 04:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775794633; cv=none; b=BPBHNTZXnr3JHz3p6XzuW7o71LzNwCIwbTbTFqkHUfN35hIFdNt+5HA+DT0UXMYMCB5h4xmCsoketkboDbNZFTGY+T7aa9G+a16o/v10F0gXYWTqEysa7IAYMCvg0QcYFNWDhqliQuLAhNDNWHTD+432/7iDACCHLi8yJQuUO04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775794633; c=relaxed/simple;
	bh=q0bl+lD6eXBemvwpIgitksayrW9K1ju/yDtIWiWP4Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG56+kOiWm+KWg885k8umeWYGiAi1BaSbEcNQ2LR5VLIvSKHB8FWTRifQOOFBzG6sHdwz5Xy95g6YWdtUZ5VnrlLcI1MnYDL+8f5/EdYW5VzcogBh9qrT4CYibbxh407km8FcUZuacy8V+5kKV+oTeou16+OeZAjMgIRsr0MnuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zx/HP4cZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zx/HP4cZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB004C19421;
	Fri, 10 Apr 2026 04:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775794633;
	bh=q0bl+lD6eXBemvwpIgitksayrW9K1ju/yDtIWiWP4Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zx/HP4cZVEY+zC6rIW+D706xtMExaaYJ5JKG5scNoCh1abqOHOW0oo+UcEhWtYi1U
	 l4qjK3FaNT4qqUMhejwAUM6EDKJ9ydvhphstYyqCxXcX5lSd8fWqcCxvSby7ifV/D4
	 1ABxQxO+A9QEDcjdsuXBhJN7CDgiFyEkPum9ILhZ9wiApJMqPjSs6oVruhJ0PqMkVR
	 uk6aK4OPzge6HEyEU6rgJ24mkNtoRGpFOPAahxIXh1bFUyjJerU0Tml7i9vq5r5et0
	 lJyBRsCD9eZWivM/MxNopi2V5A9y6DheQIFZ/AeeWNNTZpjKr8U0QgbkNgrrfHKsXL
	 +wGRWVTrDg2rw==
Date: Thu, 9 Apr 2026 21:17:11 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf sched stats: Fix SIGCHLD race in
 schedstat_record()
Message-ID: <adh5x7wQv9uE6T2b@google.com>
References: <20260409162249.25581-2-swapnil.sapkal@amd.com>
 <20260409165102.E8A44C4CEF7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409165102.E8A44C4CEF7@smtp.kernel.org>

On Thu, Apr 09, 2026 at 04:51:02PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] The patch leaves a race window where early signals (like SIGINT) are lost, causing sigsuspend() to hang indefinitely.
> --
> 
> commit 82e42f3b8c8062e3b83019c07f66b6e7199c4104
> Author: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> perf sched stats: Fix SIGCHLD race in schedstat_record()
> 
> This commit attempts to fix a SIGCHLD race in perf sched stats record by
> replacing pause() with sigsuspend(). It blocks SIGCHLD, SIGINT, and SIGTERM
> before starting the workload to ensure no signal is lost if the child exits
> quickly.
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> 
> [ ... ]
> 
> > @@ -3899,11 +3900,25 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
> >  	if (err < 0)
> >  		goto out;
> >  
> > +	/*
> > +	 * Block all handled signals so that a short-lived workload exiting
> > +	 * (SIGCHLD) or an early Ctrl+C (SIGINT/SIGTERM) during the remaining
> > +	 * setup cannot be delivered before we are ready to wait. sigsuspend()
> > +	 * below will atomically unblock them. This is done after
> > +	 * evlist__prepare_workload() so the forked child does not inherit a
> > +	 * modified signal mask.
> > +	 */
> > +	sigemptyset(&sig_mask);
> > +	sigaddset(&sig_mask, SIGCHLD);
> > +	sigaddset(&sig_mask, SIGINT);
> > +	sigaddset(&sig_mask, SIGTERM);
> > +	sigprocmask(SIG_BLOCK, &sig_mask, &oldmask);
> 
> Does this leave a race window where early signals like SIGINT can be lost,
> causing sigsuspend() to hang indefinitely?
> 
> If a signal like SIGINT or SIGTERM is delivered before this sigprocmask()
> call, the existing sighandler will consume it without setting any state flag
> that gets checked here.
> 
> >  	if (argc)
> >  		evlist__start_workload(evlist);
> >  
> > -	/* wait for signal */
> > -	pause();
> > +	sigsuspend(&oldmask);
> 
> When execution subsequently reaches sigsuspend(), wouldn't it block
> indefinitely waiting for an event that was already processed?
> 
> To robustly resolve the TOCTOU race without leaking a modified signal mask
> to the child, should the signal handler set a volatile sig_atomic_t flag,
> and sigsuspend() be called conditionally based on that flag?

Right, maybe simply:

	if (argc) {
		evlist__start_workload(evlist);
		waitpid(evlist->workload.pid, NULL, 0);
	} else {
		while (!done)
			sleep(1);
	}

And SIG{INT,TERM,CHLD} should set done to true.

Thanks,
Namhyung

> 
> > +	sigprocmask(SIG_SETMASK, &oldmask, NULL);
> >  
> >  	if (reset) {
> >  		err = disable_sched_schedstat();
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260409162249.25581-1-swapnil.sapkal@amd.com?part=1
