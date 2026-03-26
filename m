Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCE9390226;
	Thu, 26 Mar 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774524517; cv=none; b=c2lQF9ygkPd+OFzE+ZgcJ1m6MVbj1Yzidp2x6aiPSDjxQDBsn8to3dMRZ/d3LMoTrKm5Ln+YnRQC/m37XYFXQY5PrGahByl805CPhqyvslrBiXtbO7xdtAGxDxIUaJevK2RBcKRKs1tuVnMUK5hieofCPBje9WFzAZoFrLmIKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774524517; c=relaxed/simple;
	bh=LxnS+crKuWk4ZaPt0UyvL8saMjf2Oi4lGTMDBjkNaOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvoHK+N2/ihfqzJYXvUxzyCuXPiipappltti1eA3wzOcTS9IOeoY42o8w3gSReYVa7but2zcHhVarwZBup27/xsoo7pUyF2E0pQ6pkl9C0i/GtndKjiH2G6UeT/dcYdyE/ng/lqzEdFmX1GOQcNWLq0R0jFn5y71JQ2i9lWTXDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AiWTXO2h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AiWTXO2h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mdCS41MTqP7+yzD1LA82uxZ4UQOVt4a4TCVKxW3G9s0=; b=AiWTXO2hY22cOrwaM+UTCE/Jt7
	CnGlDIcBKw4GkGS3mED2P/Y2BbiA0S1y043HeljtltrOSPJXtLaPWXVYGfE/HKTvDZcTSLUi9ONbC
	zzZggtvmHPMca/IKABSj4I3FrXve6Xx9qHNZ+WRZB67bY3culR/TbZ3li4d4mGhsm83m+7CMnMvS+
	4SVdEHg4vjSxSbuRjggewBuh8evVoeUXyiPetpPORMJxj6MKddUsIuTuABVSckQfdnMFqBYV437rj
	n2fxV/O4HU4dsBoK84tedW4zevacxNxrQNPKyyq4gw3lRCz80EXyAwlagpPunObfDUnZN1Vne2ZiD
	ffT4Lvsg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5isw-0000000HXRk-2QtQ;
	Thu, 26 Mar 2026 11:28:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 363913004F8; Thu, 26 Mar 2026 12:28:21 +0100 (CET)
Date: Thu, 26 Mar 2026 12:28:21 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qing Wang <wangqing7171@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, irogers@google.com,
	james.clark@linaro.org, jolsa@kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com,
	yuhaocheng035@gmail.com
Subject: Re: [PATCH v3] perf/core: Fix refcount bug and potential UAF in
 perf_mmap
Message-ID: <20260326112821.GK3738786@noisy.programming.kicks-ass.net>
References: <20260325151735.GI3738010@noisy.programming.kicks-ass.net>
 <20260326031806.876931-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326031806.876931-1-wangqing7171@gmail.com>

On Thu, Mar 26, 2026 at 11:18:06AM +0800, Qing Wang wrote:
> On Wed, 25 Mar 2026 at 23:17, Peter Zijlstra <peterz@infradead.org> wrote:
> > Argh,. why is this hidden in this old thread :/
> > 
> > On Wed, Mar 25, 2026 at 06:20:53PM +0800, yuhaocheng035@gmail.com wrote:
> > 
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index 2c35acc2722b..a3228c587de1 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -6730,9 +6730,10 @@ static void perf_pmu_output_stop(struct perf_event *event);
> > >   * the buffer here, where we still have a VM context. This means we need
> > >   * to detach all events redirecting to us.
> > >   */
> > > -static void perf_mmap_close(struct vm_area_struct *vma)
> > > +static void __perf_mmap_close(struct vm_area_struct *vma, struct perf_event *event,
> > > +			      bool holds_event_mmap_lock)
> > >  {
> > > -	struct perf_event *event = vma->vm_file->private_data;
> > > +	struct perf_event *iter_event;
> > >  	mapped_f unmapped = get_mapped(event, event_unmapped);
> > >  	struct perf_buffer *rb = ring_buffer_get(event);
> > >  	struct user_struct *mmap_user = rb->mmap_user;
> > > @@ -6772,11 +6773,14 @@ static void perf_mmap_close(struct vm_area_struct *vma)
> > >  	if (refcount_dec_and_test(&rb->mmap_count))
> > >  		detach_rest = true;
> > >  
> > > -	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
> > > +	if ((!holds_event_mmap_lock &&
> > > +	     !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex)) ||
> > > +	    (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_count)))
> > >  		goto out_put;
> > 
> > *groan*, this is horrible.
> > 
> > Let me have a poke to see if there isn't a saner variant around.
> 
> I think it's ok to move perf_mmap_close() outside the mutex lock, like this:
> 
> https://lore.kernel.org/all/20260325153240.GK3739106@noisy.programming.kicks-ass.net/T/#m0f82e8ecdfdfce4acd5121bcb799e864cf05ebf9
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1f5699b339ec..e5ce03ce926d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -7485,9 +7485,12 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>  		 */
>  		ret = map_range(event->rb, vma);
>  		if (ret)
> -			perf_mmap_close(vma);
> +			goto out_close;
>  	}
> +	return 0;
>  
> +out_close:
> +	perf_mmap_close(vma);
>  	return ret;
>  }
> 
> How do you think?

Well, that will just re-introduce the original problem. As you were told
there.

What about something like this?

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..0bb1d8b83bc9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7010,6 +7010,7 @@ static void perf_mmap_open(struct vm_area_struct *vma)
 }
 
 static void perf_pmu_output_stop(struct perf_event *event);
+static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb);
 
 /*
  * A buffer can be mmap()ed multiple times; either directly through the same
@@ -7025,8 +7026,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
-	int mmap_locked = rb->mmap_locked;
-	unsigned long size = perf_data_size(rb);
 	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
@@ -7121,11 +7120,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * Aside from that, this buffer is 'fully' detached and unmapped,
 	 * undo the VM accounting.
 	 */
-
-	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
-			&mmap_user->locked_vm);
-	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
-	free_uid(mmap_user);
+	perf_mmap_unaccount(vma, rb);
 
 out_put:
 	ring_buffer_put(rb); /* could be last */
@@ -7265,6 +7260,15 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
+static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb)
+{
+	struct user_struct *user = rb->mmap_user;
+
+	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
+			&user->locked_vm);
+	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
+}
+
 static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			unsigned long nr_pages)
 {
@@ -7327,8 +7331,6 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	if (!rb)
 		return -ENOMEM;
 
-	refcount_set(&rb->mmap_count, 1);
-	rb->mmap_user = get_current_user();
 	rb->mmap_locked = extra;
 
 	ring_buffer_attach(event, rb);
@@ -7484,10 +7486,43 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 * vmops::close().
 		 */
 		ret = map_range(event->rb, vma);
-		if (ret)
-			perf_mmap_close(vma);
+		if (likely(!ret))
+			return 0;
+
+		/* Error path */
+
+		/*
+		 * If this is the first mmap(), then event->mmap_count should
+		 * be stable at 1. It is only modified by:
+		 * perf_mmap_{open,close}() and perf_mmap().
+		 *
+		 * The former are not possible because this mmap() hasn't been
+		 * successful yet, and the latter is serialized by
+		 * event->mmap_mutex which we still hold (note that mmap_lock
+		 * is not strictly sufficient here, because the event fd can
+		 * be passed to another process through trivial means like
+		 * fork(), leading to concurrent mmap() from different mm).
+		 *
+		 * Make sure to remove event->rb before releasing
+		 * event->mmap_mutex, such that any concurrent mmap() will not
+		 * attempt use this failed buffer.
+		 */
+		if (refcount_read(&event->mmap_count) == 1) {
+			/*
+			 * Minimal perf_mmap_close(); there can't be AUX or
+			 * other events on account of this being the first.
+			 */
+			mapped = get_mapped(event, event_unmapped);
+			if (mapped)
+				mapped(event, vma->vm_mm);
+			perf_mmap_unaccount(vma, event->rb);
+			ring_buffer_attach(event, NULL);	/* drops last rb->refcount */
+			refcount_set(&event->mmap_count, 0);
+			return ret;
+		}
 	}
 
+	perf_mmap_close(vma);
 	return ret;
 }
 
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index d9cc57083091..c03c4f2eea57 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -67,6 +67,7 @@ static inline void rb_free_rcu(struct rcu_head *rcu_head)
 	struct perf_buffer *rb;
 
 	rb = container_of(rcu_head, struct perf_buffer, rcu_head);
+	free_uid(rb->mmap_user);
 	rb_free(rb);
 }
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 3e7de2661417..9fe92161715e 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -340,6 +340,8 @@ ring_buffer_init(struct perf_buffer *rb, long watermark, int flags)
 		rb->paused = 1;
 
 	mutex_init(&rb->aux_mutex);
+	rb->mmap_user = get_current_user();
+	refcount_set(&rb->mmap_count, 1);
 }
 
 void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags)
