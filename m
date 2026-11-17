Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931045;
	b=aBJtN+Ksj9A0J8Jd5LPhPYT0XzHo1YcWPHd8osnXg2akMytEabGUH29E93K5DuX7ftZ1
	 WS3jU6i5s6602LAkXNwNdkwCnsTVSVQ48sbGpVifcDbCh9G4HHMi4wt4r77G6jNlN7UDA
	 +/rHSFMZ3wnopSVtAkZs1cWdrINnTyVWG3doFE0sFP11F/Kj8nBcx+F5vD/iQj2I6fBwp
	 7LPVe1sTZ1jW2pyqydvPmFHfwuPS1FFgwMHIGKgfEx1akc9KKr82d2878awJ8tPyRWpij
	 7OT1VsaBBMcRVUQ9Nv9lbP7KAUBOL2JCIVnCoJ5I04S4uwA5pbJ41pKeCDaFsRKj8ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931045;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cs7WmXLtLvfzSaEY3F1n54CWNp97VoAM7iUg02itheI=;
	b=B5qKcDU3gJLZVRqkSdCxTtn+Y5Iz6UXtMeU5Y/ST3VVgh4BcGTejHFx11CpvgKFXVeDZ
	 lRqJCURS12ys2UCMGYW3byORHriR+5KUyKtuw8M31OI3/pzPB95hQgMBBKWaYDa9SM0+B
	 AcRcG/i60s7yLqPK8zUoZ/NNYUnUEyI95bg6PvWZpfmI6rt+7uskai2wN0CyTENXVTLL5
	 sUxHZmNqt98HTB6B7/Mw5LJZCCLs0FZg95vGO/6lF11NhKFg2mU6FWEn8cemufKeStNpO
	 m/lVS6OwQWnsX4GPt99KVtUiko0x+p2UyA9FfKo5a+JlkPUiQEfOzfUlIqnhQdPDHqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oiyc4UpX;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE6B606A31C;
	Tue, 17 Nov 2026 15:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AE6B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=oiyc4UpX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cs7WmXLtLvfzSaEY3F1n54CWNp97VoAM7iUg02itheI=; b=oiyc4UpX6RbTwsDS2I3LujqnZW
	HRIJs/9PBbn8mZq0GuZfrDIQ16tbF1h/PvfrLxPypoNEkW3MxOBfVbhJj6fMJRlpIXBKaGx68NA1A
	EfP6K+1JTo70X5Whc8ilDho3i0uWSpeNbVPGYWexncBirsBJOIPEuoMQKJRfAQtVO9aNqQb7NCatN
	PypNXit2SnugLLYR77MBjNx6ekUGeif5HW9WhJZVoLtNh0TIil2/ybz1ze/rkSKP6JstBCZp+QtGl
	BcVzj0z292TOPFvWuotVJzxtNyeYoZx5WtwqNfX2bC6ftQ9nfgX2OV+sf03lm1bCDUTCEBGOkJJEc
	Vk6oMoWg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTLYf-00000001uyH-2YiP;
	Tue, 17 Nov 2026 15:57:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BBFB3300400; Tue, 17 Nov 2026 16:57:20 +0100 (CET)
Date: Tue, 17 Nov 2026 16:57:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael B. Dias" <rafaelbttdias@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	security@kernel.org
Subject: Re: [PATCH] perf/core: unaccount mmap pages from the charged owners
Message-ID: <20261117155720.GB621672@noisy.programming.kicks-ass.net>
References: <CAFhB66oYbThmK59NiT1YwFZ4z=xkNxj9paga4EJW+mGFHa8f8A@mail.gmail.com>
 <20260722060353.24-1-rafaelbttdias@gmail.com>
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
In-Reply-To: <20260722060353.24-1-rafaelbttdias@gmail.com>

On Wed, Jul 22, 2026 at 03:03:53AM -0300, Rafael B. Dias wrote:
> perf mmap accounting splits pages between user_struct::locked_vm and
> mm_struct::pinned_vm. The first mapping that allocates a data ring stores
> the charged user and numeric pinned amount in perf_buffer, but it does not
> store the mm that received the pinned charge.
> 
> A perf event fd can be mapped by more than one process. If a different mm
> owns the final VMA close, perf_mmap_unaccount() subtracts mmap_locked from
> that final mm instead of the mm charged at allocation. Repeating this
> across short-lived donor processes creates a negative pinned_vm balance
> that can fund later perf mappings beyond RLIMIT_MEMLOCK.
> 
> AUX has the same last-VMA assumption. It also subtracts locked_vm from the
> data ring's mmap_user even when a different user created the AUX mapping.
> 
> Retain references to the mm charged for the data ring and to the user and
> mm charged for AUX. Use those stored owners during final unaccounting and
> release the references after the counters are restored.
> 
> On a two-CPU 6.12.94 KASAN guest, an unprivileged receiver with

(that's an old kernel, as in *very* old)

> RLIMIT_MEMLOCK=0 accumulated 16,385 pages of cross-mm credit and mapped
> 65,540 KiB on the vulnerable kernel. The same reproducer returned EPERM
> with this ownership fix. No KASAN report or warning occurred. The patch
> also builds kernel/events/core.o with x86_64_defconfig on the same base.
> 
> Fixes: 26cb63ad11e0 ("perf: Fix perf mmap bugs")
> Fixes: 36b3db03b474 ("perf/core: Fix the mlock accounting, again")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI-Codex:gpt-5.6-sol
> Signed-off-by: Rafael B. Dias <rafaelbttdias@gmail.com>

I don't like allowing the AUX stuff to be accounted separately from the
regular stuff. But also, I think you missed perf_mmap_calc_limits().

What about something like the below?

I am also tempted to add a clause where 'vma->vm_mm != rb->mmap_mm'
would completely dis-allow the operation.

---
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e870f12c3ad8..b920680aad50 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7046,7 +7046,7 @@ static void perf_mmap_open(struct vm_area_struct *vma)
 }
 
 static void perf_pmu_output_stop(struct perf_event *event);
-static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb);
+static void perf_mmap_unaccount(struct perf_buffer *rb, long user_extra, long extra);
 
 /*
  * A buffer can be mmap()ed multiple times; either directly through the same
@@ -7082,8 +7082,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->perf_mlock);
-		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+		perf_mmap_unaccount(rb, rb->aux_nr_pages, rb->aux_mmap_locked);
 
 		/* this has to be the last one */
 		rb_free_aux(rb);
@@ -7156,7 +7155,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 * Aside from that, this buffer is 'fully' detached and unmapped,
 	 * undo the VM accounting.
 	 */
-	perf_mmap_unaccount(vma, rb);
+	perf_mmap_unaccount(rb, data_page_nr(rb) + 1, rb->mmap_locked);
 
 out_put:
 	ring_buffer_put(rb); /* could be last */
@@ -7256,10 +7255,10 @@ static int map_range(struct perf_buffer *rb, struct vm_area_struct *vma)
 	return err;
 }
 
-static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra, long *extra)
+static bool __perf_mmap_calc_limits(struct user_struct *user, struct mm_struct *mm,
+				    long *user_extra, long *extra)
 {
 	unsigned long user_locked, user_lock_limit, locked, lock_limit;
-	struct user_struct *user = current_user();
 
 	user_lock_limit = sysctl_perf_event_mlock >> (PAGE_SHIFT - 10);
 	/* Increase the limit linearly with more CPUs */
@@ -7281,31 +7280,36 @@ static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra,
 		 * charge the rest from pinned_vm
 		 */
 		*extra = user_locked - user_lock_limit;
-		*user_extra -= *extra;
 	}
 
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
 	lock_limit >>= PAGE_SHIFT;
-	locked = atomic64_read(&vma->vm_mm->pinned_vm) + *extra;
+	locked = atomic64_read(&mm->pinned_vm) + *extra;
 
 	return locked <= lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOCK);
 }
 
-static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long extra)
+static bool perf_mmap_calc_limits(struct perf_buffer *rb, long *user_extra, long *extra)
 {
-	struct user_struct *user = current_user();
-
-	atomic_long_add(user_extra, &user->perf_mlock);
-	atomic64_add(extra, &vma->vm_mm->pinned_vm);
+	return __perf_mmap_calc_limits(rb->mmap_user, rb->mmap_mm, user_extra, extra);
 }
 
-static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb)
+static void perf_mmap_account(struct perf_buffer *rb, long user_extra, long extra)
 {
 	struct user_struct *user = rb->mmap_user;
+	struct mm_struct *mm = rb->mmap_mm;
 
-	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
-			&user->perf_mlock);
-	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
+	atomic_long_add(user_extra - extra, &user->perf_mlock);
+	atomic64_add(extra, &mm->pinned_vm);
+}
+
+static void perf_mmap_unaccount(struct perf_buffer *rb, long user_extra, long extra)
+{
+	struct user_struct *user = rb->mmap_user;
+	struct mm_struct *mm = rb->mmap_mm;
+
+	atomic_long_sub(user_extra - extra, &user->perf_mlock);
+	atomic64_sub(extra, &mm->pinned_vm);
 }
 
 static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
@@ -7344,7 +7348,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 			 * Success -- managed to mmap() the same buffer
 			 * multiple times.
 			 */
-			perf_mmap_account(vma, user_extra, extra);
+			perf_mmap_account(event->rb, user_extra, extra);
 			refcount_inc(&event->mmap_count);
 			return 0;
 		}
@@ -7357,7 +7361,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 		ring_buffer_attach(event, NULL);
 	}
 
-	if (!perf_mmap_calc_limits(vma, &user_extra, &extra))
+	if (!__perf_mmap_calc_limits(current_user(), vma->vm_mm, &user_extra, &extra))
 		return -EPERM;
 
 	if (vma->vm_flags & VM_WRITE)
@@ -7370,6 +7374,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	if (!rb)
 		return -ENOMEM;
 
+	rb->mmap_mm = ({ mmgrab(vma->vm_mm); vma->vm_mm; });
 	rb->mmap_locked = extra;
 
 	ring_buffer_attach(event, rb);
@@ -7378,7 +7383,7 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	perf_event_init_userpage(event);
 	perf_event_update_userpage(event);
 
-	perf_mmap_account(vma, user_extra, extra);
+	perf_mmap_account(rb, user_extra, extra);
 	refcount_set(&event->mmap_count, 1);
 
 	return 0;
@@ -7434,7 +7439,7 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 		refcount_inc(&rb->aux_mmap_count);
 
 	} else {
-		if (!perf_mmap_calc_limits(vma, &user_extra, &extra)) {
+		if (!perf_mmap_calc_limits(rb, &user_extra, &extra)) {
 			refcount_dec(&rb->mmap_count);
 			return -EPERM;
 		}
@@ -7455,7 +7460,7 @@ static int perf_mmap_aux(struct vm_area_struct *vma, struct perf_event *event,
 		rb->aux_mmap_locked = extra;
 	}
 
-	perf_mmap_account(vma, user_extra, extra);
+	perf_mmap_account(rb, user_extra, extra);
 	refcount_inc(&event->mmap_count);
 
 	return 0;
@@ -7547,6 +7552,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 * attempt use this failed buffer.
 		 */
 		if (refcount_read(&event->mmap_count) == 1) {
+			struct perf_buffer *rb = event->rb;
 			/*
 			 * Minimal perf_mmap_close(); there can't be AUX or
 			 * other events on account of this being the first.
@@ -7554,7 +7560,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			mapped = get_mapped(event, event_unmapped);
 			if (mapped)
 				mapped(event, vma->vm_mm);
-			perf_mmap_unaccount(vma, event->rb);
+			perf_mmap_unaccount(rb, data_page_nr(rb) + 1, rb->mmap_locked);
 			ring_buffer_attach(event, NULL);	/* drops last rb->refcount */
 			refcount_set(&event->mmap_count, 0);
 			return ret;
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index c03c4f2eea57..8a6c620ae91e 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -5,6 +5,9 @@
 #include <linux/hardirq.h>
 #include <linux/uaccess.h>
 #include <linux/refcount.h>
+#include <linux/sched/user.h>
+#include <linux/perf_event.h>
+#include <asm/local.h>
 
 /* Buffer handling */
 
@@ -38,6 +41,7 @@ struct perf_buffer {
 	refcount_t			mmap_count;
 	unsigned long			mmap_locked;
 	struct user_struct		*mmap_user;
+	struct mm_struct		*mmap_mm;
 
 	/* AUX area */
 	struct mutex			aux_mutex;
@@ -68,6 +72,7 @@ static inline void rb_free_rcu(struct rcu_head *rcu_head)
 
 	rb = container_of(rcu_head, struct perf_buffer, rcu_head);
 	free_uid(rb->mmap_user);
+	mmdrop(rb->mmap_mm);
 	rb_free(rb);
 }
 
