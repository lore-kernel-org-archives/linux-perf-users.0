Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798C9215F72;
	Thu,  5 Dec 2024 10:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733393153; cv=none; b=YYAyulOp87Tbuayks5YyB720LwL13SGIvNIaJH2LP1Gjo0SVC3Hb5CMFxp6mv63TwsETwZrWs24q1xwAWedrWdKD8RVuMb287FAqUiL5OVfh8qhCQYoNVIQseQ/LoIBLvPUL7JDIn8Ve5y4kmIt8dw2E2K93UviLkz3anOkSiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733393153; c=relaxed/simple;
	bh=JY6FwqIJOGRys05JhdkoNtEjJ06O798hF3fOIWIu+5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw91a67QnVatWCkPXNYNsSMTtnL4oLfhBhqDqJX/x0NBvRaUF+Xc9SFR+zbowdRkgXp0OacnPeGg6xSXnNezJh9GtGjsHLlU1ztyq11PoaH0aO2X0LuE+35Tb0AY6eoNNFsXn/faO6EgaUVkz4lZ8wDNDo55fUp8ZUUE8fRDeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsFHSGjQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsFHSGjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97157C4CED1;
	Thu,  5 Dec 2024 10:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733393153;
	bh=JY6FwqIJOGRys05JhdkoNtEjJ06O798hF3fOIWIu+5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QsFHSGjQiQ38Ra604K4DoUgIwISoRDkj7ZSOQMcW2Ntg2Wnti5oWu3XGR4kaDTA7u
	 b4ve9DXUVrx8KQFSH+UGUMC4YaCzolLajt+5c/NKtRQsgQy58Hq1KKprIDF+3GQenJ
	 Ru38+zmGRRzvrj/AUm4zyaVuI0l2CGGklr4zEgCuv/RLyRLTWxXnLtrXXDoXlQQFMg
	 K8DycHuvHS/ROIA/M8GE6VX5JJln5ihnPzGkMVKxvXdtLETcFwXphIIh18rn5Xe9Cu
	 Jhb6gFyQhslcpH7Jh5KlYPGhaDVxDnjHAuResnmjKLz8FXo+sVi6RZe6CqjZJjln4V
	 rkTIX/c3QCxjA==
Date: Thu, 5 Dec 2024 11:05:49 +0100
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
Message-ID: <Z1F6_cC4bRvcN56T@pavilion.home>
References: <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
 <20241204134826.GA923@redhat.com>
 <Z1DxqJlGM_I8irVQ@pavilion.home>
 <20241205092015.GA8673@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241205092015.GA8673@redhat.com>

Le Thu, Dec 05, 2024 at 10:20:16AM +0100, Oleg Nesterov a écrit :
> > Looking at task_work, it seems that most enqueues happen to the current task.
> > AFAICT, only io_uring() does remote enqueue. Would it make sense to have a light
> > version of task_work that is only ever used by current? This would be a very
> > simple flavour with easy queue and cancellation without locking/atomics/RmW
> > operations.
> 
> Perhaps, but we also need to avoid the races with task_work_cancel() from
> another task. I mean, if a task T does task_work_add_light(work), it can race
> with task_work_cancel(T, ...) which can change T->task_works on another CPU.

I was thinking about two different lists.

> 
> 
> OK, I can't suggest a good solution for this problem, so I won't argue with
> the patch from Sebastian. Unfortunately, with this change we can never restore
> the fifo ordering. And note that the current ordering is not lifo, it is
> "unpredictable". Plus the extra lock/xchg for each work...

Good point it's unpredictable due to extraction before execution.

Another alternative is to maintain another head that points to the
head of the executing list. This way we can have task_work_cancel_current()
that completely cancels the work. That was my initial proposal here and it
avoids the lock/xchg for each work:

https://lore.kernel.org/all/Zx-B0wK3xqRQsCOS@localhost.localdomain/

> 
> Hmm. I just noticed that task_work_run() needs a simple fix:
> 
> 	--- x/kernel/task_work.c
> 	+++ x/kernel/task_work.c
> 	@@ -235,7 +235,7 @@
> 			raw_spin_unlock_irq(&task->pi_lock);
> 	 
> 			do {
> 	-			next = work->next;
> 	+			next = READ_ONCE(work->next);
> 				work->func(work);
> 				work = next;
> 				cond_resched();
> 
> Perhaps it makes sense before the patch from Sebastian even if that patch
> removes this do/while loop ?

Hmm, can work->next be modified concurrently here?

Thanks.

> 
> Oleg.
> 
