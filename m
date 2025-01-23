Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14AA20C03A;
	Thu, 23 Jan 2025 08:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737621855; cv=none; b=d8PUdrUpzy/gfOAyEUVk1HOPerZYq3fHnJjULQ7AH8k5o2q4yaWCOyg2W+YKIOQB/Qp2ESlUkwQGwUuPt5/y6Ce6jrQn0wf9GQZQApuVVa+IbBl5XRIxH9pPVqs6og59wkScQA6OrWQyQ1FUqInOyoQjULaCJAX1J33lMq/yHTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737621855; c=relaxed/simple;
	bh=st1hjqQiInuslmuy2R+7FlDnsIx1MG1MnaPMOJNL0vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulXY8ZImZsf1f+NknLuQNHAjzG1/7d/NtXxIxjGw8AB4DaW76jWlMMv0e/3GfbQtluJwizqm4vz9xuOuiKNfHmJCHoJIgOTjbuN9Qw7cGpOhiIGyuPAMWzWOYq5D2q2A/zeN/soJvD/jI7GKfbyaikM4MXsdg1w/LxteV0xtTPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kkgfc6iI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kkgfc6iI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JIR26XdPlkQ6JFnPOIfMnXovAk3Z9SvRrpY1FOaV/Bk=; b=kkgfc6iIiwED7WlUgGLj8idK9N
	1qsg1iapI8oMBnRqQ/flzKANB0ryh9VTVJ61BQrWSEpPMTKHqljy9Tv0wCfjA/uFe9HngN89iKL1L
	mDk2AVjStuOEGgObhFA2lvkUDDLN0DDIJ1vPM+ZO1UzrydSHjR9TQnvmxZoOvysYd+4t3aYAhf1IY
	eh2I/3g/PtRePzvwY8NNI7pAAUA05EvqqLYS9oZ3IvCRvWaBAw4ANNHD7px4iN62ENQOgwLske+Ed
	JSbG8NE94psflLmIg291i2uGOty+xW6OPlN+p7gXnCqyKRlWJ+kCs9DgYgBlN3t2mcBKGF9i1C4Pt
	2Na4DxtA==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tason-0000000Dl5d-1VAA;
	Thu, 23 Jan 2025 08:44:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBB4E3006E6; Thu, 23 Jan 2025 09:44:04 +0100 (CET)
Date: Thu, 23 Jan 2025 09:44:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, Indu Bhagat <indu.bhagat@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>,
	Sam James <sam@gentoo.org>, linux-trace-kernel@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Florian Weimer <fweimer@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Weinan Liu <wnliu@google.com>
Subject: Re: [PATCH v4 34/39] perf: Skip user unwind if !current->mm
Message-ID: <20250123084404.GH3808@noisy.programming.kicks-ass.net>
References: <cover.1737511963.git.jpoimboe@kernel.org>
 <24cde1381495cd637f0d5663ab7629572bc0eca6.1737511963.git.jpoimboe@kernel.org>
 <20250122142910.GW7145@noisy.programming.kicks-ass.net>
 <20250122230838.lrmuxhowq6ezvoqp@jpoimboe>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250122230838.lrmuxhowq6ezvoqp@jpoimboe>

On Wed, Jan 22, 2025 at 03:08:38PM -0800, Josh Poimboeuf wrote:
> On Wed, Jan 22, 2025 at 03:29:10PM +0100, Peter Zijlstra wrote:
> > On Tue, Jan 21, 2025 at 06:31:26PM -0800, Josh Poimboeuf wrote:
> > > If the task doesn't have any memory, there's no stack to unwind.
> > > 
> > > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> > > ---
> > >  kernel/events/core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 99f0f28feeb5..a886bb83f4d0 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -7792,7 +7792,7 @@ struct perf_callchain_entry *
> > >  perf_callchain(struct perf_event *event, struct pt_regs *regs)
> > >  {
> > >  	bool kernel = !event->attr.exclude_callchain_kernel;
> > > -	bool user   = !event->attr.exclude_callchain_user;
> > > +	bool user   = !event->attr.exclude_callchain_user && current->mm;
> > 
> > What about things like io_uring helpers, don't they keep ->mm but are
> > never in userspace?
> 
> Hm, that's news to me.  At least this patch doesn't make things worse in
> that regard.
> 
> IIRC, user_regs(task_pt_regs(current)) returns false for kthreads
> because the regs area is cleared.  We could add in a user_regs() check?

Possibly, I've not yet dug into the io_worker thing in much detail yet.
