Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2A265604;
	Mon, 28 Apr 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745838711; cv=none; b=MrhtzfjLqaD3V/6cLOH5UHZ2hC78x17tHKYL2mJfAhPLxNNg5yDcEdlryUmQNK/eOTc314QzdrOig9pXeFDme872rPb49Xsx2kfzZ1G3Bfks9kXyFmx7ASWqIFKZZVbHbm71FpG4DW6JySl+4IE/rUT8w1WAyu3kkcMInnLjd0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745838711; c=relaxed/simple;
	bh=M8bfo9nwHR9FBIyNBaiiApaWzDjww92GWLsgn0B2p44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usgVtM/PApy7OEKtb3N5AOthCa9kz9z4ydcSO1GBIX0C2FAa9JMDaM61pQEBJQetEyWpZf6jREGx1U8eh/WqS4iibCe6T/lLLZmm1jMfTp/+KkPzt5jhgtvPbe4IJSHi7U024S9t1OCRmw6ShJ0luarQKgdWSYui0sLXDoOhX1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2ptE2LU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2ptE2LU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29ABFC4CEF2;
	Mon, 28 Apr 2025 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745838710;
	bh=M8bfo9nwHR9FBIyNBaiiApaWzDjww92GWLsgn0B2p44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2ptE2LULN/9xqE5iRO+qlMYyfOkLCI0Oje/CzfSo5mOpJ7WWJ00odf1s5RIAqRPi
	 rAztIyzza5w0MlJlYEyd++Ak/qx+z0WOzhY494W2IvPSToFuaPQQd9pHb4TTLJGlH7
	 Ewes1QIp9/wp9CdO1VukijKAv23gloO08Vcf+UzTaOKXBMlqO0b5M19+T8mMq9mR5j
	 B8WBca0kBiJtch3jIoN+pEA41bUej1KNbTWp05acw+HwMwUl5yXF3VEyjjQzuPBUdk
	 /06B4ZXKqx4V9UvRVsjrdBMrpjYtwxKp7IOat6DSx35BXIzj/i26pqV1Ip5nzygZLo
	 5aNNwNdYfp3bQ==
Date: Mon, 28 Apr 2025 13:11:47 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/4] perf: Fix irq work dereferencing garbage
Message-ID: <aA9ic6m6WAcmVBAw@pavilion.home>
References: <20250424161128.29176-1-frederic@kernel.org>
 <20250424161128.29176-3-frederic@kernel.org>
 <20250424163024.GC18306@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424163024.GC18306@noisy.programming.kicks-ass.net>

Le Thu, Apr 24, 2025 at 06:30:24PM +0200, Peter Zijlstra a écrit :
> On Thu, Apr 24, 2025 at 06:11:26PM +0200, Frederic Weisbecker wrote:
> > @@ -13940,29 +13941,36 @@ perf_event_exit_event(struct perf_event *event,
> >  		 * Do destroy all inherited groups, we don't care about those
> >  		 * and being thorough is better.
> >  		 */
> > -		detach_flags |= DETACH_GROUP | DETACH_CHILD;
> > +		prd.detach_flags |= DETACH_GROUP | DETACH_CHILD;
> >  		mutex_lock(&parent_event->child_mutex);
> >  	}
> >  
> >  	if (revoke)
> > -		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
> > +		prd.detach_flags |= DETACH_GROUP | DETACH_REVOKE;
> >  
> > -	perf_remove_from_context(event, detach_flags);
> > +	perf_remove_from_context(event, &prd);
> 
> Isn't all this waay to complicated?
> 
> That is, to modify state we need both ctx->mutex and ctx->lock, and this
> is what __perf_remove_from_context() has, but because of this, holding
> either one of those locks is sufficient to read the state -- it cannot
> change.
> 
> And here we already hold ctx->mutex.
> 
> So can't we simply do:
> 
> 	old_state = event->attach_state;
> 	perf_remove_from_context(event, detach_flags);
> 
> 	// do whatever with old_state

Right, the locking scenario is just a bit more complicated.
Most flags are set on init or with both ctx mutex and lock.
But:

_ PERF_ATTACH_CHILD is set instead with parent child_mutex and ctx lock.
_ PERF_ATTACH_ITRACE is set from pmu::start(). Thus from the event context
  with just interrupt disabled. It's probably enough to synchronize against
  initialization and remove_from_context IPIs but perf_event_exit_event() needs
  some care.

So we must hold both ctx mutex and child_mutex (although the pmus_srcu thing
should make that PERF_ATTACH_CHILD thing visible but let's keep things obvious).
And also have WRITE_ONCE() / READ_ONCE() to take care about PERF_ATTACH_ITRACE,
which we don't care about anyway.

Now this looks like this:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7bcb02ffb93a..7278ca731a55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -208,7 +208,6 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)
-#define EVENT_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
 {
@@ -2338,12 +2337,6 @@ static void perf_child_detach(struct perf_event *event)
 
 	sync_child_event(event);
 	list_del_init(&event->child_list);
-	/*
-	 * Cannot set to NULL, as that would confuse the situation vs
-	 * not being a child event. See for example unaccount_event().
-	 */
-	event->parent = EVENT_TOMBSTONE;
-	put_event(parent_event);
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -5705,7 +5698,7 @@ static void put_event(struct perf_event *event)
 	_free_event(event);
 
 	/* Matches the refcount bump in inherit_event() */
-	if (parent && parent != EVENT_TOMBSTONE)
+	if (parent)
 		put_event(parent);
 }
 
@@ -9998,7 +9991,7 @@ void perf_event_text_poke(const void *addr, const void *old_bytes,
 
 void perf_event_itrace_started(struct perf_event *event)
 {
-	event->attach_state |= PERF_ATTACH_ITRACE;
+	WRITE_ONCE(event->attach_state, event->attach_state | PERF_ATTACH_ITRACE);
 }
 
 static void perf_log_itrace_start(struct perf_event *event)
@@ -13922,10 +13915,7 @@ perf_event_exit_event(struct perf_event *event,
 {
 	struct perf_event *parent_event = event->parent;
 	unsigned long detach_flags = DETACH_EXIT;
-	bool is_child = !!parent_event;
-
-	if (parent_event == EVENT_TOMBSTONE)
-		parent_event = NULL;
+	unsigned int attach_state;
 
 	if (parent_event) {
 		/*
@@ -13942,6 +13932,8 @@ perf_event_exit_event(struct perf_event *event,
 		 */
 		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
+		/* PERF_ATTACH_ITRACE might be set concurrently */
+		attach_state = READ_ONCE(event->attach_state);
 	}
 
 	if (revoke)
@@ -13951,18 +13943,25 @@ perf_event_exit_event(struct perf_event *event,
 	/*
 	 * Child events can be freed.
 	 */
-	if (is_child) {
-		if (parent_event) {
-			mutex_unlock(&parent_event->child_mutex);
-			/*
-			 * Kick perf_poll() for is_event_hup();
-			 */
-			perf_event_wakeup(parent_event);
+	if (parent_event) {
+		mutex_unlock(&parent_event->child_mutex);
+		/*
+		 * Kick perf_poll() for is_event_hup();
+		 */
+		perf_event_wakeup(parent_event);
+
+		/*
+		 * Match the refcount initialization. Make sure it doesn't happen
+		 * twice if pmu_detach_event() calls it on an already exited task.
+		 */
+		if (attach_state & PERF_ATTACH_CHILD) {
 			/*
 			 * pmu_detach_event() will have an extra refcount.
+			 * perf_pending_task() might have one too.
 			 */
 			put_event(event);
 		}
+
 		return;
 	}
 
