Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0D347FD1;
	Mon, 26 Jan 2026 16:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446259; cv=none; b=Uu/8XKTucZDdwO3eOZtZy+7cGP4Td5B3cyzNoBfL/HtbfbdsHBThsyO0WJvT6iSy8/tjvjjb7WLnaI5arZ0amcX8iKEP4xHRPoplYEdZ7m+jVCSdeR3iCALhep29xDB8MdA4w/zM8nz6k2fCXIiEyCE9aQnYlXK3oxLLqzDQQjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446259; c=relaxed/simple;
	bh=ZR+j5w8xZGYwomoDHtjl/Oi6085wX9tT2RTJYLwsqrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xx6U/U5pGaUVLwwygu6CLtSxhzaiDv/iZEcdJcX20WhLDFTH3O0ayg6QcVzhvlAzn9rtO0/jsvU2DJAa75BcWke/NP64Xe711KK0exR+tAii4pmUVn8qdOlNewksFa9OSIU8F0YkeZLe7nIZu2/nCYseBcRaqS3qXiK+MWAN3p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4yawpg8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4yawpg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39710C16AAE;
	Mon, 26 Jan 2026 16:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769446259;
	bh=ZR+j5w8xZGYwomoDHtjl/Oi6085wX9tT2RTJYLwsqrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L4yawpg8tUnnP118U2ygODAR3XO6grMF4upkbJHZOaoKfw6OYKmpvdaHht4Uj7wT1
	 JBkLZBAcJMz+t2EGZpTHhTz7Fx559Lm0fzNVicG62VMo0hdJGawkHBT5fPL90Py7TO
	 F0sR0G+GBiMHVfp5OyK6f0XoyQcVtbmBFo7Cl//PlqReEC+Ai3UNJYiNlmXSMCK3z7
	 UQBRvxQcj/6g1Sos84eC/D8fBUgi7pHBq5UpB9D9LwfQtZod6XXwIitD7iVP/RwB2d
	 o/wwyGuFqWM9sIuSoOHz1aScjLdFlkTHmfCIxYqJNyimZwXPn6dPhV6MFvNKBmweuN
	 do+Q7XheQIb7A==
Date: Mon, 26 Jan 2026 11:50:59 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo
 Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: Re: [RESEND][PATCH 3/5] perf: Use current->flags &
 PF_KTHREAD|PF_USER_WORKER instead of current->mm == NULL
Message-ID: <20260126115059.3d345ca3@gandalf.local.home>
In-Reply-To: <0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
References: <20250820180338.701352023@kernel.org>
	<20250820180428.592367294@kernel.org>
	<0d877e6f-41a7-4724-875d-0b0a27b8a545@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Nov 2025 19:11:15 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi Steven,

Hi Guenter,

Somehow this got filed away in my archive without me seeing it.

> 
> On Wed, Aug 20, 2025 at 02:03:41PM -0400, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > To determine if a task is a kernel thread or not, it is more reliable to
> > use (current->flags & (PF_KTHREAD|PF_USER_WORKERi)) than to rely on
> > current->mm being NULL.  That is because some kernel tasks (io_uring
> > helpers) may have a mm field.
> > 
> > Link: https://lore.kernel.org/linux-trace-kernel/20250424163607.GE18306@noisy.programming.kicks-ass.net/
> > Link: https://lore.kernel.org/all/20250624130744.602c5b5f@batman.local.home/
> > 
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > ---
> >  kernel/events/callchain.c | 6 +++---
> >  kernel/events/core.c      | 4 ++--
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index cd0e3fc7ed05..5982d18f169b 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
> >  
> >  	if (user && !crosstask) {
> >  		if (!user_mode(regs)) {
> > -			if  (current->mm)
> > -				regs = task_pt_regs(current);
> > -			else
> > +			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
> >  				regs = NULL;
> > +			else
> > +				regs = task_pt_regs(current);
> >  		}
> >  
> >  		if (regs) {
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index bade8e0fced7..f880cec0c980 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7446,7 +7446,7 @@ static void perf_sample_regs_user(struct perf_regs *regs_user,
> >  	if (user_mode(regs)) {
> >  		regs_user->abi = perf_reg_abi(current);
> >  		regs_user->regs = regs;
> > -	} else if (!(current->flags & PF_KTHREAD)) {
> > +	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
> >  		perf_get_regs_user(regs_user, regs);
> >  	} else {
> >  		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
> > @@ -8086,7 +8086,7 @@ static u64 perf_virt_to_phys(u64 virt)
> >  		 * Try IRQ-safe get_user_page_fast_only first.
> >  		 * If failed, leave phys_addr as 0.
> >  		 */
> > -		if (current->mm != NULL) {
> > +		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {  
> 
> Subsequent code uses current->mm. This triggers a crash when running a page
> table stress test. See below for details. I have seen the crash in 6.12.57
> and 6.18-rc5.

Hmm, that should not happen. But obvious it is. Can you add this:

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1f6589578703..ff201098e5e5 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -248,6 +248,8 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		if (!user_mode(regs)) {
 			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
 				goto exit_put;
+			if (WARN_ONCE(!current->mm, "Bad flags %x", current->flags))
+				goto exit_put;
 			regs = task_pt_regs(current);
 		}
 

I'd like to see what current->flags are when ->mm is NULL.

Thanks!

-- Steve
