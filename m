Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8223919B;
	Thu,  5 Dec 2024 00:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357996; cv=none; b=PBCny87OCWfDp0j+igL05DM1xSxOP0PnX7WUWphmn8Hj9UTGAvVjk2sfNYSVAS/Kr/etj/PA7uzBpGsSgx+m6zO8N1isyNgfg3VlKsyMkchFrlnni5lK4htDseQyDsBvKKXyn/nPknhDdORX6NJ4iRm3/zFR7jRCwyIO4RA49os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357996; c=relaxed/simple;
	bh=bDwVXjL1nLB5xNln02V1wcdgJI0W3tE7fBM1SgIGJoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iugd4qLcJEbug3LLACDEYm4VKPXXP6mFxq0b/renAX96mIjoiZ0DqMlL72ez2bbOPuz0GyF2PLDRotnSuT8I2OtztEwZyH414Uwn3nHbV1WiryANV7p1XCMX/uFFBLWn1DmJhsKpfkYbnNL5aWHDCBbcw5simPRBhu5hMHKT/Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRVXkQuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRVXkQuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 296E1C4CECD;
	Thu,  5 Dec 2024 00:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733357995;
	bh=bDwVXjL1nLB5xNln02V1wcdgJI0W3tE7fBM1SgIGJoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WRVXkQucNnK9Gv7JgKoc6q0rbmwQincsCivco+TtyCz1ExK/jL4o4FkutUNyh8guL
	 7Frtua1JGWKAXVE5zZVhsLVw2j6fjDQfjMNpCAiXStbLdOQllgV0ZxqLR/8VRrkfbV
	 ud3cMHUmqqXm0Cx6dKvpX2cM0iqfxNo1Oed9XmuE4yyXTyR8aC3wXgT5TBKw1w4OK8
	 x6LSqMhjt3+nYUjK2GgBFiXA5OV/Ge//EgigJlV4ZDn41O8mU2MCFTkZwOxyQJKQig
	 m+03j2rpvVZj+/gkAF/dL/Ij4BR6PwpsQaSBMDGVb6hgl5Km8aKVKWn0/rEropnGai
	 oyyekV2gnGftg==
Date: Thu, 5 Dec 2024 01:19:52 +0100
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
Message-ID: <Z1DxqJlGM_I8irVQ@pavilion.home>
References: <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
 <Zy4OFlxoRK2jM5zo@localhost.localdomain>
 <20241108190835.GA11231@redhat.com>
 <Zy6QHHakztIXvudC@pavilion.home>
 <20241111120857.5cWFpNkJ@linutronix.de>
 <20241204134826.GA923@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204134826.GA923@redhat.com>

Le Wed, Dec 04, 2024 at 02:48:27PM +0100, Oleg Nesterov a écrit :
> On 11/11, Sebastian Andrzej Siewior wrote:
> Not that bad, but I personally dislike this patch for other reasons.
> But lets forget it for the moment.
> 
> The numbers in
> 
> 	PATCH] task_work: remove fifo ordering guarantee
> 	https://lore.kernel.org/all/1440816150.8932.123.camel@edumazet-glaptop2.roam.corp.google.com/
> 
> didn't look too bad too, yet they convinced Linus and other reviewers.
> 
> I still think that fifo makes much more sense. The main (only?) offender
> is fput(), so perhaps we can do something like
> https://lore.kernel.org/all/20150907134924.GA24254@redhat.com/
> but when I look at this change now I see it is racy.
> 
> Stupid question. What if we revert this "task_work: remove fifo ordering guarantee"
> patch above? Can this help?
> 
> I don't understand this code and the problem. But when I (try to) read the
> previous discussion on lore.kernel.org it seems that perf_pending_task_sync()
> fails to cancel event->pending_task because it is called from task_work_run()
> and then rcuwait_wait_event() obviously hangs.
> 
> Your patch can only help if task_work_add(current, &event->pending_task) was
> called before fput()->task_work_add(task, &file->f_task_work(), right?

Right, IIUC if &event->pending_task was added after then perf_pending_task()
would be called before perf_release() and we wouldn't have the problem.

> So perhaps, if we restore the fifo ordering, we can rely on the fact that
> current should call perf_pending_task() before it calls perf_release/free_event ?

Hmm but a perf event can still fire between the task_work_add() on fput and the
actual call to task_work_run() that will run the queue. So &event->pending_task
can be set either before or after. And then whether fifo or lifo, that would
still be buggy. Or am I missing something?

Looking at task_work, it seems that most enqueues happen to the current task.
AFAICT, only io_uring() does remote enqueue. Would it make sense to have a light
version of task_work that is only ever used by current? This would be a very
simple flavour with easy queue and cancellation without locking/atomics/RmW
operations. We would just need to be extra careful about NMIs. And cancellation
on the current queue would be more deterministic...

Of course we would then lose the advantage of a solution that works for both
remote and current enqueue...

Thanks.
