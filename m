Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F3328B7A;
	Wed, 22 Apr 2026 21:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776892889; cv=none; b=XdoRhDqrvwVlklZ2M1+02686YEQLtgzcWVUOFCu5+eKJyWGOKy+YhexCYVDn+adG/qYf0z4mUu/HmoWHR93hpvjdHiT+0vSdTPJTY6nB2r16JLo5XoqUplZmF1/YvcUuTbnhO2KTgCX3rdft+23kaS7lu40a1mUjb7som9SU4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776892889; c=relaxed/simple;
	bh=ltJnzYWq/n5kfmRjHNR0fHpGkQumF68vxulMx81Zpj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4qWuP46YqAZRwLWATa/7ketlewTY3V1NatX4ONlQ6dDW5jeVbB2WwFHtlVHIiAxKHUJk7xFi3L8xwBEM+VlgVH+WDhEM/qHUWC8ToC0yyA+f8luqHDmJikSpxSUHjISgFTGofIT+rAuSQgvMlSRltqUzpF1F1Bo6/37L8xL3tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BCbl/cXt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCbl/cXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A18C19425;
	Wed, 22 Apr 2026 21:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776892889;
	bh=ltJnzYWq/n5kfmRjHNR0fHpGkQumF68vxulMx81Zpj4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BCbl/cXtJaOeGi9NvxOKvklyREmaa2NfN+cmlJNkzTZRrFDEurZq6V7iRzU08OLkF
	 Ep9yAa/konI6khyF342fyOkaJq4pjh3L21K6TVDUx6z45i2XAea3U/9SMs1VcBYSy4
	 7P10MI2kHPT8rqeyUxBSeyDgJ9X5cmw9UEutRX3LxBlaOCzh1PFPfLpS2uX2a/pS+T
	 khCVtN5NdY6OEuAr0mNZ8mG7gHxgczbODQm0R+fKh0zDicWiBV2Kr+hILmukSTwcC2
	 F7n0N8uIBr22AIcOw0tXu0leaD2JkbeUDwDs5ZO5ulqcNqDoXEhTmuvNpZq9A2dHd+
	 ijYYOoi50vIBA==
Date: Wed, 22 Apr 2026 14:21:27 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: Swapnil Sapkal <swapnil.sapkal@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 1/3] perf sched stats: Fix SIGCHLD vs pause() race in
 schedstat_record()
Message-ID: <aek71-nfrJJv-WPi@google.com>
References: <20260422050545.129448-2-swapnil.sapkal@amd.com>
 <20260422052953.29209C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422052953.29209C19425@smtp.kernel.org>

Hello,

On Wed, Apr 22, 2026 at 05:29:52AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 2 potential issue(s):
> - [High] Blocking waitpid() ignores the cancellation flag, causing a hang or premature exit.
> - [Medium] Unconditional `done = 0;` assignment discards termination signals received during initialization.
> --
> 
> commit 1c95f818d983ad8f7f5ed28e4a0036553b2d2758
> Author: Swapnil Sapkal <swapnil.sapkal@amd.com>
> 
> perf sched stats: Fix SIGCHLD vs pause() race in schedstat_record()
> 
> This commit replaces pause() with waitpid() or a sleep() loop to fix an
> indefinite hang if SIGCHLD is delivered before the process enters pause().
> It also introduces a sig_atomic_t flag set by the signal handler.
> 
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 3f509cfdd58c4..cfd93bf11c2ee 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> [ ... ]
> > @@ -3899,11 +3903,15 @@ static int perf_sched__schedstat_record(struct perf_sched *sched,
> >  	if (err < 0)
> >  		goto out;
> >  
> > -	if (argc)
> > -		evlist__start_workload(evlist);
> > +	done = 0;
> 
> Is it possible that this unconditional assignment discards termination signals
> received during initialization?
> 
> Since the signal handlers are registered at the beginning of the function,
> if a user sends SIGINT during the setup phase, the handler will set done to 1.
> This assignment would then erase the early cancellation request, requiring the
> user to send the signal again.

Right, as it's initialized to 0 you don't need to set it here.

> 
> >  
> > -	/* wait for signal */
> > -	pause();
> > +	if (argc) {
> > +		evlist__start_workload(evlist);
> > +		waitpid(evlist->workload.pid, NULL, 0);
> 
> Could this blocking waitpid() cause the tool to ignore the cancellation flag?
> 
> Because perf is compiled with _GNU_SOURCE, glibc's signal() uses the
> SA_RESTART flag by default. This causes waitpid() to automatically restart
> after the signal handler returns.
> 
> If the profiled workload ignores or delays handling SIGINT, waitpid() will
> continue to block indefinitely and ignore the done flag.
> 
> Conversely, if SA_RESTART were disabled, waitpid() would return -1 (EINTR).
> Since the return value is not checked, the program would exit prematurely
> and leave the workload orphaned in the background.
> 
> Would it be safer to use waitpid() with WNOHANG inside a loop that checks
> the done flag?

Right, something like this? (not tested)

	while (!done) {
		if (argc && waitpid(evlist->workload.pid, NULL, WNOHANG) > 0)
			break;
		sleep(1);
	}

Thanks,
Namhyung

> 
> > +	} else {
> > +		while (!done)
> > +			sleep(1);
> > +	}
> >  
> >  	if (reset) {
> >  		err = disable_sched_schedstat();
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260422050545.129448-1-swapnil.sapkal@amd.com?part=1
