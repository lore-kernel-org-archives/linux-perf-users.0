Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA71F4711;
	Wed, 30 Oct 2024 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303185; cv=none; b=eaVy3C1Jz42C3MCYzZ2mtfmFqTcT2yrFRUZZNb08EMl3RGqxofxAbFzVYV3r1YFvwt/Zwjq1xeON9QuqfaSWJl/bj59AN2NCFq6xmbPzJNErd91N23t8bEAlX2qHZxYRwMsra/vbQhTR4F/CU5IoIpVMTAUwaI7jk2BtJNLZ60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303185; c=relaxed/simple;
	bh=02fzOt3hjs0XplZPBlHeTB8KJ/xnkeRcpDH3gjvSSj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSe/Nr4ynGipTHQ8upJ0jegoET7aiX1eIiB5l5LnkMfSl2Xx3Q9gxQSwjRwi6KjyRXNqQQlU/EjR9uxNygX+4w/N374T44YsCuxBKVS165tyvlp6+vsv3z8Q5C+DHGkgURCmZXIvrjtzUtF5fDmdw5zJcdsasCESIF7u/+d5xJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQ2Pm/69; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQ2Pm/69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824FFC4CECE;
	Wed, 30 Oct 2024 15:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730303184;
	bh=02fzOt3hjs0XplZPBlHeTB8KJ/xnkeRcpDH3gjvSSj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QQ2Pm/69WVVKq6UK7oiomNKoOLGOo7xZOlbR6GEyRLHlfnf5rELUZmFJVOOxD1P6A
	 diatsdY2LEwGrnPGnZ1JalY5iSv3WVNfKSCzKX9kD5nA99eOjzSir2kckQQbFMJX4K
	 WAv2UZ/LWR6Np0Qhc3k1jvYhv79JHDb0omrFX5K6uLUwNjJ6vdnvm5W9e2MGwPAdJw
	 cZhwFK6NUU5wOjae4Twyj+t777r2ES2yVc79DxAKPWbsCO2kq5iiBhUKsQNHqjHqut
	 xZ0iGYzIK6nlxDofWi8YvDhP+ejFa+ZJWR9cP0MEgJ32bf1EeeHOCqA1sMspCxvZUI
	 7ijMZF7SNE9ag==
Date: Wed, 30 Oct 2024 16:46:22 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
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
Message-ID: <ZyJUzhzHGDu5CLdi@localhost.localdomain>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241030140721.pZzb9D-u@linutronix.de>

Le Wed, Oct 30, 2024 at 03:07:21PM +0100, Sebastian Andrzej Siewior a écrit :
> On 2024-10-29 18:21:31 [+0100], To Frederic Weisbecker wrote:
> > On 2024-10-28 13:21:39 [+0100], Frederic Weisbecker wrote:
> > > Ah the perf_pending_task work is pending but perf_pending_task_sync()
> > > fails to cancel there:
> > > 
> > > 	/*
> > > 	 * If the task is queued to the current task's queue, we
> > > 	 * obviously can't wait for it to complete. Simply cancel it.
> > > 	 */
> > > 	if (task_work_cancel(current, head)) {
> > > 		event->pending_work = 0;
> > > 		local_dec(&event->ctx->nr_no_switch_fast);
> > > 		return;
> > > 	}
> > > 
> > > And that's because the work is not anymore on the task work
> > > list in task->task_works. Instead it's in the executing list
> > > in task_work_run(). It's a blind spot for task_work_cancel()
> > > if the current task is already running the task works. And it
> > > does since it's running the fput delayed work.
> > > 
> > > Something like this untested?
> > 
> > Tested. Not sure if this is a good idea.
> > Couldn't we take the ->next pointer and add it to current::task_works
> > instead?
> > That patch in ZtYyXG4fYbUdoBpk@pavilion.home gets rid of that
> > rcuwait_wait_event().
> 
> Just tested. That patch from ZtYyXG4fYbUdoBpk@pavilion.home also solves
> that problem. Could we take that one instead?

This needs more thoughts. We must make sure that the parent is put _after_
the child because it's dereferenced on release, for example:

put_event()
   free_event()
      irq_work_sync(&event->pending_irq);
      ====> IRQ or irq_workd
      perf_event_wakeup()
         ring_buffer_wakeup()
	    event = event->parent;
	    rcu_dereference(event->rb);

And now after this patch it's possible that this happens after
the parent has been released.

We could put the parent from the child's free_event() but some
places (inherit_event()) may call free_event() on a child without
having held a reference to the parent.

Also note that with this patch the task may receive late irrelevant
signals after the event is removed. It's probably not that bad but
still... This could be a concern for exec(), is there a missing
task_work_run() there before flush_signal_handlers()?

Anyway here is an updated version:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4287cb..4031d0dbc47b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5448,10 +5448,17 @@ static void perf_remove_from_owner(struct perf_event *event)
 
 static void put_event(struct perf_event *event)
 {
+	struct perf_event *parent;
+
 	if (!atomic_long_dec_and_test(&event->refcount))
 		return;
 
+	parent = event->parent;
 	_free_event(event);
+
+	/* Matches the refcount bump in inherit_event() */
+	if (parent)
+		put_event(parent);
 }
 
 /*
@@ -5535,11 +5542,6 @@ int perf_event_release_kernel(struct perf_event *event)
 		if (tmp == child) {
 			perf_remove_from_context(child, DETACH_GROUP);
 			list_move(&child->child_list, &free_list);
-			/*
-			 * This matches the refcount bump in inherit_event();
-			 * this can't be the last reference.
-			 */
-			put_event(event);
 		} else {
 			var = &ctx->refcount;
 		}
@@ -5565,7 +5567,7 @@ int perf_event_release_kernel(struct perf_event *event)
 		void *var = &child->ctx->refcount;
 
 		list_del(&child->child_list);
-		free_event(child);
+		put_event(child);
 
 		/*
 		 * Wake any perf_event_free_task() waiting for this event to be
@@ -13325,8 +13327,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Kick perf_poll() for is_event_hup();
 		 */
 		perf_event_wakeup(parent_event);
-		free_event(event);
-		put_event(parent_event);
+		put_event(event);
 		return;
 	}
 
@@ -13444,13 +13445,11 @@ static void perf_free_event(struct perf_event *event,
 	list_del_init(&event->child_list);
 	mutex_unlock(&parent->child_mutex);
 
-	put_event(parent);
-
 	raw_spin_lock_irq(&ctx->lock);
 	perf_group_detach(event);
 	list_del_event(event, ctx);
 	raw_spin_unlock_irq(&ctx->lock);
-	free_event(event);
+	put_event(event);
 }
 
 /*
