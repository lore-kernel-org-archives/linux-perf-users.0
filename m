Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2951EABA9;
	Fri,  8 Nov 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731071514; cv=none; b=iMETDf6Px7ZDkCLPmm70fPL9Cejs2Uki0Ql/SF47V/mfSQrgQSRjBqm8S7OFLf89dp+FJPbWTC/V3qBJvBSN/j5e6uhOQLMeYA76UX/7/f4xaL9b+X96OU83M68LjBtONMMfwe5KJF6svZGyfg0rcTux0a+h5T3j1epeziNwXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731071514; c=relaxed/simple;
	bh=ljQ8Fomc865u7EknG2fR45+zwg9L/eg93/a5wv/rJNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EC1NJrLV08vJwpWmeje2GYU1NV4lKwhwMo0rcCT2rE95UGh0R//i38japso+OrQjSAmrBmYRadjF1QFwRMpuURQG5RBPbqraZfEDEdBPnh7a/BLjHCzXdPFO68WJe4mjI5OWv7r95yNFQvEF9zT5tgf0HAALhQWem+MakMuf3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhMQFjSa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhMQFjSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A50C4CECD;
	Fri,  8 Nov 2024 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731071513;
	bh=ljQ8Fomc865u7EknG2fR45+zwg9L/eg93/a5wv/rJNI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rhMQFjSa+imhFT1qNMokMam1Fups8zY4jsTbCDdFpD84/XxvW/INrex3b/eJSo0/Z
	 FN9lKzTnxvYba7SSkkgZYH9xxFNJfc9xB/rdYLXpi5KSf39q/RrqWQsVnF2mQ8BG+b
	 2/pvKFzbA/HbMKCCOnvKYGrQwvwBQ0g/4ZySSNqLceJ9/4WEI32hHQvvxAOEVzKlLh
	 pvcFK2APBiX3Hibq/pPpoqqSrK9CqKw6C3RKgS/HlZXEbeITUf1xKpLp2nEb1EDbGq
	 aMQ80delcGVVwx+M4IFafpPstBnVBerYJHYivuhBgmwtU+NQzUhYIxDvT21k7s4LPQ
	 LhRhpqBXJMXfw==
Date: Fri, 8 Nov 2024 14:11:50 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
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
Message-ID: <Zy4OFlxoRK2jM5zo@localhost.localdomain>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
 <20241107144617.MjCWysud@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107144617.MjCWysud@linutronix.de>

+Cc Oleg.

Le Thu, Nov 07, 2024 at 03:46:17PM +0100, Sebastian Andrzej Siewior a écrit :
> On 2024-10-30 16:46:22 [+0100], Frederic Weisbecker wrote:
> > This needs more thoughts. We must make sure that the parent is put _after_
> > the child because it's dereferenced on release, for example:
> …
> > put_event()
> >    free_event()
> >       irq_work_sync(&event->pending_irq);
> >       ====> IRQ or irq_workd
> >       perf_event_wakeup()
> >          ring_buffer_wakeup()
> > 	    event = event->parent;
> > 	    rcu_dereference(event->rb);
> > 
> > And now after this patch it's possible that this happens after
> > the parent has been released.
> > 
> > We could put the parent from the child's free_event() but some
> > places (inherit_event()) may call free_event() on a child without
> > having held a reference to the parent.
> > 
> > Also note that with this patch the task may receive late irrelevant
> > signals after the event is removed. It's probably not that bad but
> > still... This could be a concern for exec(), is there a missing
> > task_work_run() there before flush_signal_handlers()?
> 
> So if this causes so much pain, what about taking only one item at a
> item? The following passes the test, too:
> 
> diff --git a/kernel/task_work.c b/kernel/task_work.c
> index c969f1f26be58..fc796ffddfc74 100644
> --- a/kernel/task_work.c
> +++ b/kernel/task_work.c
> @@ -206,7 +206,7 @@ bool task_work_cancel(struct task_struct *task, struct callback_head *cb)
>  void task_work_run(void)
>  {
>  	struct task_struct *task = current;
> -	struct callback_head *work, *head, *next;
> +	struct callback_head *work, *head;
>  
>  	for (;;) {
>  		/*
> @@ -214,17 +214,7 @@ void task_work_run(void)
>  		 * work_exited unless the list is empty.
>  		 */
>  		work = READ_ONCE(task->task_works);
> -		do {
> -			head = NULL;
> -			if (!work) {
> -				if (task->flags & PF_EXITING)
> -					head = &work_exited;
> -				else
> -					break;
> -			}
> -		} while (!try_cmpxchg(&task->task_works, &work, head));
> -
> -		if (!work)
> +		if (!work && !(task->flags & PF_EXITING))
>  			break;
>  		/*
>  		 * Synchronize with task_work_cancel_match(). It can not remove
> @@ -232,13 +222,24 @@ void task_work_run(void)
>  		 * But it can remove another entry from the ->next list.
>  		 */
>  		raw_spin_lock_irq(&task->pi_lock);
> +		do {
> +			head = NULL;
> +			if (work) {
> +				head = READ_ONCE(work->next);
> +			} else {
> +				if (task->flags & PF_EXITING)
> +					head = &work_exited;
> +				else
> +					break;
> +			}
> +		} while (!try_cmpxchg(&task->task_works, &work, head));
>  		raw_spin_unlock_irq(&task->pi_lock);

And having more than one task work should be sufficiently rare
that we don't care about doing the locking + cmpxchg() for each
of them pending.

I like it!

Thanks.

>  
> -		do {
> -			next = work->next;
> -			work->func(work);
> -			work = next;
> +		if (!work)
> +			break;
> +		work->func(work);
> +
> +		if (head)
>  			cond_resched();
> -		} while (work);
>  	}
>  }
> 
> Sebastian
