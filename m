Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CA619992C;
	Fri, 13 Dec 2024 22:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130369; cv=none; b=LbtM0SyBmf3p9NNZ/kSn/AZx3nP+TF/8dMbOGtlUB6L+yK+eYMMpt0/BhvIWoFvS7Q7XBs8B9NTFER35kvbTHNisxoj/OKoxiT0q9/kt2LGKe8ee09rlZgOqHcsypGSgK45RUdALTO+g709CUqbDyetA0YgbAvMmm2LiY6vA63A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130369; c=relaxed/simple;
	bh=04Tx0x578Uzc8rm85xT+i6prSqGkdTU6HjQojNx5BaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWg8txM+3ovsV3boiZS9cpDNnrF/nZNJsOoKGs8ZjDARrpXsTungliVexE9NwDr9IjGb/nl2EXmqQFUjHPZFIhSpTpFC+A7hI/8tqc3YPvDNDcrDu+AecdJCOpK7ho5cWXRUKslCe0H3nFIPPmAfR0myttv92mo7XWbwKaQd93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tavy4t2D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tavy4t2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F2DC4CED0;
	Fri, 13 Dec 2024 22:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734130368;
	bh=04Tx0x578Uzc8rm85xT+i6prSqGkdTU6HjQojNx5BaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tavy4t2DHnD1HgZ97BCgsnRvNHS1Z7DsTkwFMYwX1ooRMTvoyU4iWkxhVRyBk8Gi6
	 iejgRQl1jbJFM6NEGc3hHn8aE/9Hua6er2VtMkpqQ4iwRDXAPHAMnmn5HQoeK9y8/H
	 YOu2glWvHjFmEP00wH5vu0Fcr3A2A6PZb8AQzazVtHazm0kcFHk9/WDk4SB+lIHqOy
	 nuadJqY+Sziw4uMpRLaEOc0kHK42L27c77kGN3r7tEjxAqlhP5h6N/2MQ0OulQ2Pxs
	 lcXVT790qEdRyYKoFdMx6b1FDdi0QVk+yh0mhHoUhobJnjU7JROQn9rjserZeRSpEz
	 6RvSmnOoWoaJQ==
Date: Fri, 13 Dec 2024 23:52:45 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Lai, Yi" <yi1.lai@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <Z1y6vSznjbCwAvn1@pavilion.home>
References: <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
 <20241204134826.GA923@redhat.com>
 <Z1DxqJlGM_I8irVQ@pavilion.home>
 <20241205092015.GA8673@redhat.com>
 <Z1F6_cC4bRvcN56T@pavilion.home>
 <20241205102840.GB8673@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205102840.GB8673@redhat.com>

Le Thu, Dec 05, 2024 at 11:28:41AM +0100, Oleg Nesterov a écrit :
> On 12/05, Frederic Weisbecker wrote:
> >
> > Le Thu, Dec 05, 2024 at 10:20:16AM +0100, Oleg Nesterov a écrit :
> >
> > > > Looking at task_work, it seems that most enqueues happen to the current task.
> > > > AFAICT, only io_uring() does remote enqueue. Would it make sense to have a light
> > > > version of task_work that is only ever used by current? This would be a very
> > > > simple flavour with easy queue and cancellation without locking/atomics/RmW
> > > > operations.
> > >
> > > Perhaps, but we also need to avoid the races with task_work_cancel() from
> > > another task. I mean, if a task T does task_work_add_light(work), it can race
> > > with task_work_cancel(T, ...) which can change T->task_works on another CPU.
> >
> > I was thinking about two different lists.
> 
> OK... but this needs more thinking/discussion.

Sure.

> 
> > Another alternative is to maintain another head that points to the
> > head of the executing list. This way we can have task_work_cancel_current()
> > that completely cancels the work. That was my initial proposal here and it
> > avoids the lock/xchg for each work:
> >
> > https://lore.kernel.org/all/Zx-B0wK3xqRQsCOS@localhost.localdomain/
> 
> Thanks... Heh, I thought about something like this too ;) Although I thought
> that we need a bit more to implement task_work_cancel_sync(). But this is
> another story.

So which way do you prefer do solve the initial problem?

> 
> > > Hmm. I just noticed that task_work_run() needs a simple fix:
> > >
> > > 	--- x/kernel/task_work.c
> > > 	+++ x/kernel/task_work.c
> > > 	@@ -235,7 +235,7 @@
> > > 			raw_spin_unlock_irq(&task->pi_lock);
> > >
> > > 			do {
> > > 	-			next = work->next;
> > > 	+			next = READ_ONCE(work->next);
> > > 				work->func(work);
> > > 				work = next;
> > > 				cond_resched();
> > >
> > > Perhaps it makes sense before the patch from Sebastian even if that patch
> > > removes this do/while loop ?
> >
> > Hmm, can work->next be modified concurrently here?
> 
> work->func(work) can, say, do kfree(work) or do another task_work_add(X,
> work).

Right but then isn't it serialized program order, from the compiler point of view?

Thanks.

> 
> Oleg.
> 
