Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4D3128C9;
	Tue,  6 Jan 2026 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767692089; cv=none; b=hq2uu2ea0kedTCkWUWLdIfOc3YaoE3tSfSKv5RcHDPE5AAHeeNhq4UZ+Ty468Wiv+9Lp8nS/mekYgWHpoJrQiEBf5qGmmVbSfOLVKCG7KbV6tCFEixtexBxQVx9k6eCT3rCRE/E8ahspnUP6Qe0T0mFjmalAnNTFG3yVMWgpA78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767692089; c=relaxed/simple;
	bh=9qtODxdHonG5wLAEqeupF/6f1gL4jNorbgImaQIUSQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktd8ERdX+pzF2YXiY9irm7IvXcR9sPUi5ylrJ/J2i1rQelOB6xTA2kj6FE9NHxympmUNEYes0o0/VzW1wHup11w3nD+bfX2RDwEIg7S9wDucL7UBhuGCS2izS3nTNkZGvVIakjK05STko/N3HWd4wPcxlTgrS1xVQ3ZvJtODvYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JbY9kssK; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JbY9kssK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QRUbIC06+2zCGuNM0+wzRG9P0dkhNxPlVN0L96EtEoA=; b=JbY9kssKMoEbA9pFJjoJCcPOTP
	8+N3GFUsri45MI/ayvxaMl2727bjbJZrhmDPTG2+LYMwv0+EoANf3Vq55lylhxgARywJE/Aq4X4bD
	YsK0D7BhaIurBaMxZCqpVUs4ZjFrN4PB6UhZK8lIICYxHtXJHhTfsSKvNO+44PZY+GF2OvsSwB/Gt
	rYhmtsO1e/tC85BaNQQH0iPgODpB6L49dvHwnC5yJi98TkZ3PsWy5wp9NH3z2pt97VisTZfcbv4hw
	mwt9mAvHkNo8mcQcNZUX+Ctj5i1fV424KNdHR1+SksxuuBuo+5/iFYe9DIFbIarTrAobOMxV1YbJ2
	o+tdtO+g==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vd3ST-00000009SWR-274m;
	Tue, 06 Jan 2026 09:34:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D002030056B; Tue, 06 Jan 2026 10:34:31 +0100 (CET)
Date: Tue, 6 Jan 2026 10:34:31 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Rosenberg <whrosenb@asu.edu>
Cc: yi1.lai@linux.intel.com, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf: Fix refcount warning on event->mmap_count
 increment
Message-ID: <20260106093431.GA3707837@noisy.programming.kicks-ass.net>
References: <aVt6tqOp+fGnFuBb@ly-workstation>
 <20260105165149.30200-1-whrosenb@asu.edu>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105165149.30200-1-whrosenb@asu.edu>

On Mon, Jan 05, 2026 at 09:51:49AM -0700, Will Rosenberg wrote:
> When calling refcount_inc(&event->mmap_count) inside perf_mmap_rb(), the
> following warning is triggered:
> 
> 	refcount_t: addition on 0; use-after-free.
> 	WARNING: lib/refcount.c:25
> 
> PoC:
> 
>     struct perf_event_attr attr = {0};
>     int fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0);
>     mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>     int victim = syscall(__NR_perf_event_open, &attr, 0, -1, fd,
>                          PERF_FLAG_FD_OUTPUT);
>     mmap(NULL, 0x3000, PROT_READ | PROT_WRITE, MAP_SHARED, victim, 0);
> 
> This occurs when creating a group member event with the flag
> PERF_FLAG_FD_OUTPUT. The group leader should be mmap-ed and then mmap-ing
> the event triggers the warning.
> 
> Since the event has copied the output_event in perf_event_set_output(),
> event->rb is set. As a result, perf_mmap_rb() calls
> refcount_inc(&event->mmap_count) when event->mmap_count = 0.
> 
> Account for the case when event->mmap_count = 0. This patch goes against
> the design philosophy of the refcount library by re-enabling an empty
> refcount, but the patch remains inline with the current treatment of
> mmap_count.
> 
> Fixes: 448f97fba901 ("perf: Convert mmap() refcounts to refcount_t")
> Signed-off-by: Will Rosenberg <whrosenb@asu.edu>
> ---
> 
> Notes:
>     v1 -> v2: Add Fixes tag
>     
>     I also have a related concern about code that handles the mmap_count.
>     In perf_mmap_close(), if refcount_dec_and_mutex_lock() decrements
>     event->mmap_count to zero, then event->rb is set to NULL. This
>     effectively undos our ring buffer copy. However, is this desired
>     behavior? Should event->rb remain unchanged since it may still be
>     mmap-ed by other events and can still be used?
> 
>  kernel/events/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 376fb07d869b..49709b627b1f 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7279,7 +7279,8 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
>  			 * multiple times.
>  			 */
>  			perf_mmap_account(vma, user_extra, extra);
> -			refcount_inc(&event->mmap_count);
> +			if (!refcount_inc_not_zero(&event->mmap_count))
> +				refcount_set(&event->mmap_count, 1);

So this pattern was an instant red flag; this cannot be right.

Yes, this makes the error go away, but I think the result is bad. 

The sequence as provided will create a mapping for event fd, and create
victim such that its events are redirected to this buffer.

So far so good.

However, the mmap() of victim will create an alias of the earlier buffer
(which is pointless but isn't a problem per-se), but by setting
event->mmap_count, you're saying this second event should also update
the user_page (struct perf_event_mmap_page at offset +0).

This means that if you make this succeed you end up with both events
(fd, victim) writing to the same page (which is mapped twice). And that
is broken.

I'm thinking we should dis-allow this mmap()... something like so, hmm?

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3c2a491200c6..ccf3aecbfff5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7273,6 +7273,15 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 		if (data_page_nr(event->rb) != nr_pages)
 			return -EINVAL;
 
+		/*
+		 * If this event doesn't have mmap_count, we're attempting to
+		 * create an alias of another event's mmap(); this would mean
+		 * both events will end up scribbling the same user_page;
+		 * which makes no sense.
+		 */
+		if (refcount_read(&event->mmap_count))
+			return -EBUSY;
+
 		if (refcount_inc_not_zero(&event->rb->mmap_count)) {
 			/*
 			 * Success -- managed to mmap() the same buffer
