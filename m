Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C14570D8;
	Mon,  5 Oct 2026 23:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791244150; cv=none; b=smqc1rVTBe5SlMrOeXArLtyzaSqEnycJUoSxO81kMbS7jiKUKRWE8z7OU3+tqDVfeyPZUQdH/Bgmf2cIwCQnLg/JveIN/0YW6MANLN31bREuNl0lDQvt7Vxc9gHCgaLt+zV7GTOzSiNywx//ZmCpfKAqrB4OaBvRK7e8xJQTAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791244150; c=relaxed/simple;
	bh=lZTwnOoFTGNNdEYGUvrj5bog1h4AiMkbiUbGM4A//QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLXDzjXYELjX2xzjI5eUo1+wQ/p5D73bUA1AcSe/58PeO/tA6orIZIucU9vDm9A9S3nNZjIt+RU4btaWf1AsxvQmjgqnikgIdjbg0cQjW1hk0j64YL8Y7QHnpfPs6Id80t9pIfIP6jwjvWL15MlSsqhSmhDl4mdDCj5QHMpZoAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1eXY5e/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1eXY5e/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865ED1F000FF;
	Mon,  5 Oct 2026 23:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791244148;
	bh=3m1AWPWn5W99hApseKdyu3DOT2c4xLUVxX2/bA6UP5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S1eXY5e/JCKHrtr2oaZkkfgZH/YcQaWdP7W0TG+k+O2qarU7V0GWZ2fMO3OfC+5f9
	 KaFWG9u4g8d5aOPdJ5KMOjeSfxKI+piZ0j3rRu2tYyK+yoKFIHbArIo6M2ohmTCKfM
	 0+tSxBAydkP5rkj8g/Zn1f8g3G5P//yPkNsMOL86Mde+bAqSIDP7WC9Ixr2JBzngOV
	 Ys1W5aNaU9Gvv8iyFVPlnnnGnu6VvfEG4L1/M3l08tPMPJz1wuz5P9M4svwXdWYy7b
	 by70zCDvRubJrAsj68KJDdmsqpmkzxaSFug0oOejdlUUoNExMtMUrFE5XnBXRIYsn4
	 9XVcmD8cn1bUw==
Date: Mon, 5 Oct 2026 16:49:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Michal Pluta <michalpl2003@gmail.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/8] perf bench futex: Retry futex_wait() when
 interrupted by a signal
Message-ID: <asQ3cyGMAJbVUEoR@google.com>
References: <20260926190407.1106421-1-michalpl2003@gmail.com>
 <20260926190407.1106421-2-michalpl2003@gmail.com>
 <20260926191347.E59281F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926191347.E59281F000FF@smtp.kernel.org>

Hello,

On Sat, Sep 26, 2026 at 07:13:47PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: deadlock in futex wake-parallel due to missed one-shot futex_wake()
> --
> 
> commit 4425d175409b64dbe77117f655f0ffa4eca2b864
> Author: Michal Pluta <michalpl2003@gmail.com>
> 
> perf bench futex: Retry futex_wait() when interrupted by a signal
> 
> The worker threads in 'futex wake' and 'futex wake-parallel' are meant
> to go back to sleep when a signal interrupts futex_wait(), but the check
> never works. futex_wait() returns -1 and sets errno, so comparing its
> return value with EINTR is always true and the loop ends at the first
> interruption.
> 
> > diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
> > index 6aede7c46b337..a089d8ee4b023 100644
> > --- a/tools/perf/bench/futex-wake-parallel.c
> > +++ b/tools/perf/bench/futex-wake-parallel.c
> > @@ -139,10 +139,9 @@ static void *blocked_workerfn(void *arg __maybe_unused)
> >  	cond_wait(&thread_worker, &thread_lock);
> >  	mutex_unlock(&thread_lock);
> >  
> > -	while (1) { /* handle spurious wakeups */
> > -		if (futex_wait(&futex, 0, NULL, futex_flag) != EINTR)
> > -			break;
> > -	}
> > +	/* Retry if the wait was interrupted by a signal. */
> > +	while (futex_wait(&futex, 0, NULL, futex_flag) == -1 && errno == EINTR)
> > +		;
> 
> [Severity: Medium]
> Can this retry loop cause a deadlock if a signal interrupts the wait?
> 
> If blocked_workerfn() receives a signal, futex_wait() returns -1 and
> errno == EINTR. The thread then temporarily leaves the futex wait queue before
> looping back to call futex_wait() again.
> 
> If waking_workerfn() in tools/perf/bench/futex-wake-parallel.c happens to
> execute its single futex_wake() call during this unqueued window:
> 
> tools/perf/bench/futex-wake-parallel.c:waking_workerfn() {
>     ...
>     waker->nwoken = futex_wake(&futex, nwakes, futex_flag);
>     if (waker->nwoken != nwakes)
>         warnx("couldn't wakeup all tasks (%d/%d)",
>     ...
> }
> 
> Will the waker thread miss the unqueued worker and exit, leaving the worker to
> block forever on its next futex_wait() and causing the main thread to hang in
> pthread_join()?

Looks like this patch discovers an existing bug.

Probably you can add a logic at the end of wakeup_threads() to check
each waker's nwoken and call futex_wake() additionally if needed.

Thanks,
Namhyung

