Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637625179E;
	Mon, 28 Apr 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745859365; cv=none; b=D4WHXdNfkK+d6pfIuaPS/tW79bgYVjuanK1yMZkPypHROCjz6RCVDrAyxqJE5kSkPvQcF82sof4/rqXjems1cSTk1qhGaH3uCzy18cQirYHfWjOtZCwT2j01Rj1Ko7q0O751GFjBAhYBiDksKXs4utl5VRe5+o5sXZKFedby5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745859365; c=relaxed/simple;
	bh=NdWqAH7iECnUuZvOmycgvYr6C9+P10Bi0ApVGVoU+Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D18GuA9OV7MJk+x++dOwLfksV3bgWk9dRnaSjtrnhskQnkTm07k1FdkNSeG8XNNEJRg8LY6AzxojruCBtNfxVV57+UEMX2ejHkngUSslRHaXixvleNMJS4Qc+geWj6Hs9wpwPpWQ+epT7wkMPCAcHD/qLw1sgXMoGWZLMZWyfP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087A4C4CEE4;
	Mon, 28 Apr 2025 16:56:01 +0000 (UTC)
Date: Mon, 28 Apr 2025 12:56:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers
 <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 linux-toolchains@vger.kernel.org, Jordan Rome <jordalgo@meta.com>, Sam
 James <sam@gentoo.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens
 Remus <jremus@linux.ibm.com>, Florian Weimer <fweimer@redhat.com>, Andy
 Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, Blake Jones
 <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Alexander Aring <aahringo@redhat.com>
Subject: Re: [PATCH v5 3/9] unwind deferred: Use bitmask to determine which
 callbacks to call
Message-ID: <20250428125600.1f50f476@gandalf.local.home>
In-Reply-To: <02339b93-de9a-49e4-8dbb-137d02fc6ea8@efficios.com>
References: <20250424192456.851953422@goodmis.org>
	<20250424192612.844558089@goodmis.org>
	<02339b93-de9a-49e4-8dbb-137d02fc6ea8@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Apr 2025 12:33:50 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2025-04-24 15:24, Steven Rostedt wrote:
> > From: Steven Rostedt <rostedt@goodmis.org>
> > 
> > In order to know which registered callback requested a stacktrace for when
> > the task goes back to user space, add a bitmask for all registered
> > tracers. The bitmask is the size of log, which means that on a 32 bit  
> 
> size of long
> 

Sure


> > --- a/include/linux/unwind_deferred.h
> > +++ b/include/linux/unwind_deferred.h
> > @@ -13,6 +13,7 @@ typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stackt
> >   struct unwind_work {
> >   	struct list_head		list;
> >   	unwind_callback_t		func;
> > +	int				bit;  
> 
> int or unsigned int ?
> 
> Rename "bit" to "requester_id" ?

Perhaps just "id", as this is only internal and shouldn't be touched.

> 
> >   };
> >   
> >   #ifdef CONFIG_UNWIND_USER
> > diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
> > index 2afd197da2ef..f505cb1766de 100644
> > --- a/kernel/unwind/deferred.c
> > +++ b/kernel/unwind/deferred.c
> > @@ -26,6 +26,7 @@ static DEFINE_PER_CPU(u64, unwind_ctx_ctr);
> >   /* Guards adding to and reading the list of callbacks */
> >   static DEFINE_MUTEX(callback_mutex);
> >   static LIST_HEAD(callbacks);
> > +static unsigned long unwind_mask;  
> 
> Perhaps "reserved_unwind_mask" ?

Sure.

> 
> >   
> >   /*
> >    * The context cookie is a unique identifier that is assigned to a user
> > @@ -135,6 +136,7 @@ static void unwind_deferred_task_work(struct callback_head *head)
> >   	struct unwind_task_info *info = container_of(head, struct unwind_task_info, work);
> >   	struct unwind_stacktrace trace;
> >   	struct unwind_work *work;
> > +	struct task_struct *task = current;
> >   	u64 cookie;
> >   
> >   	if (WARN_ON_ONCE(!info->pending))
> > @@ -156,7 +158,10 @@ static void unwind_deferred_task_work(struct callback_head *head)
> >   
> >   	guard(mutex)(&callback_mutex);
> >   	list_for_each_entry(work, &callbacks, list) {
> > -		work->func(work, &trace, cookie);
> > +		if (task->unwind_mask & (1UL << work->bit)) {
> > +			work->func(work, &trace, cookie);
> > +			clear_bit(work->bit, &current->unwind_mask);
> > +		}  
> 
> You could change this list of callbacks for an array of pointers,
> indexed by "requester_id".
> 
> Then you can do a for each bit on task->unwind_mask, and all bits
> that match end up calling the callback for the matching array index.

Yeah, I thought of this, but that's just an optimization, and something I
probably will add as a separate patch.

> > @@ -244,14 +254,18 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> >   
> >   	*cookie = get_cookie(info);
> >   
> > +	/* This is already queued */
> > +	if (current->unwind_mask & (1UL << work->bit))
> > +		return 0;
> > +
> >   	/* callback already pending? */
> >   	pending = READ_ONCE(info->pending);
> >   	if (pending)
> > -		return 0;
> > +		goto out;
> >   
> >   	/* Claim the work unless an NMI just now swooped in to do so. */
> >   	if (!try_cmpxchg(&info->pending, &pending, 1))  
> 
> Not that it necessarily matters performance wise here, but can this be a
> try_cmpxchg_local if we're working on the task struct and only expecting
> interruption from NMIs ?

Hmm, sure.

> 
> > -		return 0;
> > +		goto out;
> >   
> >   	/* The work has been claimed, now schedule it. */
> >   	ret = task_work_add(current, &info->work, TWA_RESUME);
> > @@ -260,16 +274,29 @@ int unwind_deferred_request(struct unwind_work *work, u64 *cookie)
> >   		return ret;
> >   	}
> >   
> > + out:
> > +	set_bit(work->bit, &current->unwind_mask);
> > +
> >   	return 0;
> >   }
> >   
> >   void unwind_deferred_cancel(struct unwind_work *work)
> >   {
> > +	struct task_struct *g, *t;
> > +
> >   	if (!work)
> >   		return;
> >   
> >   	guard(mutex)(&callback_mutex);
> >   	list_del(&work->list);
> > +
> > +	clear_bit(work->bit, &unwind_mask);
> > +
> > +	guard(rcu)();
> > +	/* Clear this bit from all threads */
> > +	for_each_process_thread(g, t) {
> > +		clear_bit(work->bit, &t->unwind_mask);
> > +	}  
> 
> It is enough to guard with RCU ? See syscall_regfunc() from
> tracepoint.c where we do:
> 
>                  read_lock(&tasklist_lock);
>                  for_each_process_thread(p, t) {
>                          set_task_syscall_work(t, SYSCALL_TRACEPOINT);
>                  }
>                  read_unlock(&tasklist_lock);
> 
> To prevent concurrent fork from adding threads while we
> iterate, thus opening the possibility of missing a clear
> due to a concurrent fork + set bit.

A set_bit only would happen if the callback was live and accepting new
callback requests. It's a bug for a tracer to call unwind_deferred_cancel()
and then call unwind_deferred_request() (which would set the bit). We could
possibly set the tracer's unwind descriptor id to -1, and do an
WARN_ON_ONCE() in unwind_deferred_request() if the tracer's id is negative.

The loop is called under the callback_mutex, where no new tracer could
register and be assigned that bit.

The RCU lock is just to make sure the current tasks that existed when the
loop started doesn't disappear before the loop ends.

-- Steve



> 
> Thanks,
> 
> Mathieu
> 
> >   }
> >   
> >   int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> > @@ -277,6 +304,14 @@ int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
> >   	memset(work, 0, sizeof(*work));
> >   
> >   	guard(mutex)(&callback_mutex);
> > +
> > +	/* See if there's a bit in the mask available */
> > +	if (unwind_mask == ~0UL)
> > +		return -EBUSY;
> > +
> > +	work->bit = ffz(unwind_mask);
> > +	unwind_mask |= 1UL << work->bit;
> > +
> >   	list_add(&work->list, &callbacks);
> >   	work->func = func;
> >   	return 0;
> > @@ -288,6 +323,7 @@ void unwind_task_init(struct task_struct *task)
> >   
> >   	memset(info, 0, sizeof(*info));
> >   	init_task_work(&info->work, unwind_deferred_task_work);
> > +	task->unwind_mask = 0;
> >   }
> >   
> >   void unwind_task_free(struct task_struct *task)  
> 
> 

