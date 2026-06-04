Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B82F691D;
	Thu,  4 Jun 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604106; cv=none; b=qGVXCxqVhGPeQ3I2P/chit/KXmA0Q0JalbLoCPZwOos3nVW6KAsj9kpy9c9/pwjeMzkK9cBvbJH75qHKm8h5HR2kVA9VD7C8d66u1ExXHoTbgQRDJcgXK/xhgOG/jB7T/r8gS6vJGW/+3CczOH/FVUcg7cTn2xj3WyjbAx3X1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604106; c=relaxed/simple;
	bh=Mra8lu9ynkwxJoQcUvaaxjEL1HfpfERDWp1i6CEI9uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3KAQUPWyyGXTvmj6EzztSfkKlncJ/wlFc3y5wzgnolj3wsAIeP8Q+Mm4aiO9wgYFFr4TOAOYhGuuNsQ8auyTOm7Pg45rCCb7o+dmo+S+qIn6167LsC4QIVgLAxtdmpYuc182GBcVfeVpPOrVlXHPYwFusM/j6auH4iAhQalOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYAR3lOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYAR3lOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83DC1F00893;
	Thu,  4 Jun 2026 20:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604105;
	bh=20Om3c6V+xJtH9Wxb/I8760WzqOs/Yu5QQGnB/GZh6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BYAR3lOLuuiFyeHOvpUJVQ/vnABwNCo3L5AGlWI46M2HR/J5CNbTbhM81CUKGUA7O
	 QDtq1YSPfS+PsOQb6U78XHTBMj86aHcf8VzJjtKtJpBYZtLk3vxe6VgfcQryauJfoa
	 ryAsLWd/OQf3kNfBqGtPjAkAkA4MI7YtoxxTHufaHkdxDSs1HUfCjXE0CACWfjuD3U
	 lcbhzNo9XgGP+3nv/EF5cR71+v77iDk9AwKlIqrGYr3ETO89g2EbJqUWjAO/4K3UXc
	 EXKccORZCA4DRNaUNlJlZgYxQ0Rsmq3IlkLnmY0vQJk3GiFSDvurgQt1oOOdcwfu4Y
	 F9cSYAB0WSLAw==
Date: Thu, 4 Jun 2026 17:15:02 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf timechart: Remove unnecessary copy of backtrace
Message-ID: <aiHcxl4rHnvkcUkK@x1>
References: <20260604190812.2168118-5-namhyung@kernel.org>
 <20260604191818.352171F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604191818.352171F00893@smtp.kernel.org>

On Thu, Jun 04, 2026 at 07:18:17PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Removing `free(backtrace)` causes severe memory leaks when the backtrace string is not consumed by the sample tracking logic.
> --

From a quick look the suggestions seems legit, will wait for v2 then.

- Arnaldo
 
> commit 8d24fd58d3a0d2702142c45fce31ca640b59f748
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf timechart: Remove unnecessary copy of backtrace
> 
> This commit updates timechart to use the backtrace string directly instead
> of duplicating it with strdup(). It updates pid_put_sample() and
> sched_wakeup() to store the original pointer and removes the free()
> calls in the process_sample routines.
> 
> > diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> > index 4efac73a714c5..2fd24d3aaa837 100644
> > --- a/tools/perf/builtin-timechart.c
> > +++ b/tools/perf/builtin-timechart.c
> 
> [ ... ]
> 
> > @@ -434,7 +434,7 @@ static void sched_wakeup(struct timechart *tchart, int cpu, u64 timestamp,
> >  
> >  	we->time = timestamp;
> >  	we->waker = waker;
> > -	we->backtrace = backtrace ? strdup(backtrace) : NULL;
> > +	we->backtrace = backtrace;
> 
> [Severity: Medium]
> Does this leak the dynamically allocated backtrace string from
> cat_backtrace() if the wake_event allocation fails?
> 
> tools/perf/builtin-timechart.c:sched_wakeup() {
> 	struct wake_event *we = zalloc(sizeof(*we));
> 
> 	if (!we)
> 		return;
>     ...
> }
> 
> Because the unconditional free() was removed from
> process_sample_sched_wakeup(), the backtrace pointer is dropped and
> leaked if zalloc() fails.
> 
> >  
> >  	if ((flags & TRACE_FLAG_HARDIRQ) || (flags & TRACE_FLAG_SOFTIRQ))
> >  		we->waker = -1;
> 
> [ ... ]
> 
> > @@ -678,7 +677,6 @@ process_sample_sched_switch(struct timechart *tchart,
> >  	backtrace = cat_backtrace(sample, &tchart->session->machines.host);
> >  	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
> >  		     prev_state, backtrace);
> > -	free((char *)backtrace);
> 
> [Severity: Medium]
> Will this leak the backtrace string if sched_switch() does not consume it?
> 
> tools/perf/builtin-timechart.c:sched_switch() {
> 	if (prev_p->current && prev_p->current->state != TYPE_NONE)
> 		pid_put_sample(tchart, prev_pid, TYPE_RUNNING, cpu,
> 			       prev_p->current->state_since, timestamp,
> 			       backtrace);
> 
> 	if (p && p->current) {
> 		if (p->current->state != TYPE_NONE)
> 			pid_put_sample(tchart, next_pid, p->current->state, cpu,
> 				       p->current->state_since, timestamp,
> 				       backtrace);
> 	}
>     ...
> }
> 
> If both TYPE_NONE conditions evaluate to true, pid_put_sample() is not
> called. The backtrace string goes unreferenced and is permanently lost
> now that the unconditional free() has been removed.
> 
> >  	return 0;
> >  }
> >
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260604190812.2168118-1-namhyung@kernel.org?part=4
