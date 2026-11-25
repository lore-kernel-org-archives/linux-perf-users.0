Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623469;
	b=Pj2mSuhzeNDK2AVmEoRFXBea0jUNLzQqbK7PxggxpR1niAPWaKWdRZyvuQGjA3cEeCkW
	 81VAAWvNQrbNIa4vtBEAqdTVlWm1GHAvNqIC+WB0ncylOJ9vRq04f4ZA25URW0qAOSgXx
	 xmFq5iBnfnQfDlHZ2KdIeXL1fbfucXJK4DYnToOsO6Bm4IsGLZJ7kTKTqlsa+tlt9o5Pc
	 7pl4NNzTN71dOqia8edn6SI+w4lPKU0dK3UU1r49C2LTYDlpVWSGl7+xqup/GvMwNA+jv
	 diea7EJ3oGL9E1RG1HRYHQf5rE4he5dcTvQzu5aQ+Gtdg7xtJHBBLkKeEegPepGSQLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623469;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=LvxSIvaNmQjosn0UxqGVKAuoQF4fg6kGbRT56I0NKnc=;
	b=Q4YSjp7dDwfsqCWcO6d39GNEwuXhtJ+KG12QuQtduMxT/FpWRLr1qza4N2QQuvFLR0ZP
	 /lBSleO4HnrMvGmsv6PoktzwMi8K2ek154QWbzewXtpvLIXmynuGCckKecnhvm8dzhtQA
	 8H5NJT6qjgGVkU59Lf0qdBlyh5nSpisFflcHNtLA6lZrve6as/BmghQkDnxC2L2CFqbsx
	 KmOByz9UST9NV2d4J6w67gHIdlBOvp4LQ4tr7n/D0D6we3fd+HWS6xSqoQuqY41yaY1O0
	 KS4n5GwsFyEUVzAjMLa2BVjqgebFb8q/LEUUM98UACo5jrqk+NcOriZ65TjAbKbCIAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=QCECURo4;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86D0606A31E;
	Wed, 25 Nov 2026 16:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E86D0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=QCECURo4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LvxSIvaNmQjosn0UxqGVKAuoQF4fg6kGbRT56I0NKnc=; b=QCECURo4mZFoDCQQLKHQYCj0/2
	pdFYjZuf4kq0CMCecVGr0K9dWkGi6CxOEHKfokcMho9aLE3/vqgQJB+6DyS+dduMyl5P1lhK3iafT
	ABg830cPfWHGe9ctxXJAqRX7k6hLOTEtM2+Sf5+SmjNm3oK2khtBQ01CFifkiETLSoZOJ/wtUNOU8
	t9toe7qI784yn/pa8Pug0d9NJulT92WcyHsn/MUpoo6ez0lKZkTMGxGrTEWSc7y3a7s+F0ULSrh2Y
	CkKcPc36AMaczCqfuOftUkRx+qqsMxMwXff+ZbBISamQE6oIOs9e6cT0DtzZys/ooztLOTYdsS43h
	j0QTEe/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWFge-00000000IAa-1o0t;
	Wed, 25 Nov 2026 16:17:38 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F0A563008BF; Wed, 25 Nov 2026 17:17:35 +0100 (CET)
Date: Wed, 25 Nov 2026 17:17:35 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261125161735.GG2668804@noisy.programming.kicks-ass.net>
References: <45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com>
 <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
 <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
 <20261123080004.MKzgHQ3W@linutronix.de>
 <20261125082711.GV2668804@noisy.programming.kicks-ass.net>
 <20261125105547.WBO5iSOJ@linutronix.de>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125105547.WBO5iSOJ@linutronix.de>

On Wed, Nov 25, 2026 at 11:55:47AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-11-25 09:27:11 [+0100], Peter Zijlstra wrote:
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -7776,8 +7776,8 @@ static void perf_pending_task(struct callback_head *head)
> > >  	rctx = perf_swevent_get_recursion_context();
> > >  
> > >  	if (event->pending_work) {
> > > -		event->pending_work = 0;
> > >  		perf_sigtrap(event);
> > > +		WRITE_ONCE(event->pending_work, 0);
> > >  		local_dec(&event->ctx->nr_no_switch_fast);
> > >  	}
> > >  	put_event(event);
> > > 
> > > To ensure the ::pending_work is reset after perf_sigtrap() is done?
> > 
> > task_work_add() can be used while inside task_work; so I do not see why
> > this would matter.
> 
> Because perf_sigtrap() uses event->pending_addr, ->orig_type and
> ->attr.sig_data. So if an event is enqueued before this is consumed it
> can overwrite the former content and report the latter twice.

Ah, indeed. Let me add that as a comment.

---
Subject: perf/core: Prevent duplicate sigtrap task work enqueue
From: Tengda Wu <wutengda@huaweicloud.com>
Date: Thu, 19 Nov 2026 09:51:00 +0000

From: Tengda Wu <wutengda@huaweicloud.com>

The sigtrap handling in __perf_event_overflow() checks
event->pending_work before calling task_work_add(), but only sets
pending_work after the task work has been queued.

This leaves a window where an NMI can interrupt task_work_add() and
re-enter __perf_event_overflow() for the same (software/tracepoint)
event. Since pending_work is still zero, the nested invocation can
enqueue the same pending_task again.

The re-entrant call path looks like this:

  __perf_event_overflow()
    task_work_add()
      <NMI>
        __perf_event_overflow()
          task_work_add()

The nested invocation may enqueue pending_task before the outer
invocation does. When the outer invocation resumes, it inserts the
same task work entry again, potentially creating a cycle in the task
work list.

As a result, perf_pending_task() may be executed repeatedly, leading
to unbalanced event reference counting.

Fix this by atomically claiming pending_work with cmpxchg_local()
before calling task_work_add(). This ensures that only one invocation
can enqueue the task work, even when another overflow occurs
re-entrantly from an NMI.

Notably: sigtrap events must be per-task, meaning that the there is no
concurrency, only re-entrancy.

[peterz: clarify and rewrite]
Fixes: c5d93d23a260 ("perf: Enqueue SIGTRAP always via task_work.")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/45bd71c976aea1a0e8bf5762dd6b6552e6009439.1795053619.git.wutengda@huaweicloud.com
---
 kernel/events/core.c |   34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7776,9 +7776,15 @@ static void perf_pending_task(struct cal
 	rctx = perf_swevent_get_recursion_context();
 
 	if (event->pending_work) {
-		event->pending_work = 0;
 		perf_sigtrap(event);
 		local_dec(&event->ctx->nr_no_switch_fast);
+		/*
+		 * event->pending_work also acts as a 'lock' for
+		 * event->{pending_addr, orig_type, attr.sig_data}. As such we
+		 * must clear after perf_sigtrap is complete.
+		 */
+		barrier();
+		event->pending_work = 0;
 	}
 	put_event(event);
 
@@ -10950,16 +10956,22 @@ static int __perf_event_overflow(struct
 
 		notify_mode = in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
 
-		if (!event->pending_work &&
-		    !task_work_add(current, &event->pending_task, notify_mode)) {
-			event->pending_work = pending_id;
-			local_inc(&event->ctx->nr_no_switch_fast);
-			WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
-
-			event->pending_addr = 0;
-			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
-				event->pending_addr = data->addr;
-
+		/*
+		 * Software events can nest and attempt this recursively;
+		 * claim the pending_work before task_work_add() recurses.
+		 */
+		if (cmpxchg_local(&event->pending_work, 0, 1) == 0) {
+			if (!task_work_add(current, &event->pending_task, notify_mode)) {
+				event->pending_work = pending_id;
+				local_inc(&event->ctx->nr_no_switch_fast);
+				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
+
+				event->pending_addr = 0;
+				if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
+					event->pending_addr = data->addr;
+			} else {
+				event->pending_work = 0;
+			}
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
