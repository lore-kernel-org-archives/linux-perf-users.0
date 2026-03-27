Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253038550E
	for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774614609; cv=none; b=nBZAMmPwPqxue8vXpKvP3lcB6yNtrP4je0Y/vnkx7LVOGrFagYzoiSwoU0lYdAdLSal5CqW9cgccIIQffKkuZVdEDyo7nBamLORqeFqHWRtDBzI+0vRJjNZ7x7wVFbhRyrIZXH+Mk29w0wgnfTZL+zxMPKcLHioOU3gQBM/kte4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774614609; c=relaxed/simple;
	bh=jiwfoKiW7Iqq0nVesngfTGnAbrVpLhAYRfRLuRDPCos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp33ZX+GxSxtMn0fq6CEXrf4usOV3BBT+ul04ykqOBXgujsgDHoIM726nSFiCUeesIl5AS2e/0Y31hacDhNNknLeBW3CYXgSwcj5wqxUqtYt1aYLfyeNjuNR1wKCVmFoJ663qgBOgU20hm/q6lIijw8cv10z06P6krmjxdUoO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6VRUmWv; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6VRUmWv"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-8297e0b27e5so1225225b3a.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Mar 2026 05:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774614607; x=1775219407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwAVa0COxv1kxQ+9exw+d50siXWOj7kmeww57r3MWyA=;
        b=d6VRUmWvePq/aRV5XsqfvpbVhWfYUn6kiEo+DichsiUlfKA6A0Jxkc82aIaIdXb4tI
         D1lCAOpyxjn5GKo96f851OHGDtgNkUde3cWmfCWSlUONLCzHT/TXwWVXxyad+pNq0BPr
         PXUPoJnvMX44r/6JV7rX7pt//cykHR3iaKsaDLjXC92X/WkFabEDAE2XWp/eAtJLR+FX
         xzC4x+vnPBEisBd1PLb1q3XlPZW5a+xC7KqcXls257w9e/A4yPFpcCGVLX7DC6xOomzd
         gDytNnD7lv3E0nOzZXFdZ0jvOGJBSF9dPt6NujSVDBG8wLPpCGHFquL7KUbbc5SWBYuK
         unwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774614607; x=1775219407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mwAVa0COxv1kxQ+9exw+d50siXWOj7kmeww57r3MWyA=;
        b=GaCyVXXtI8ZLDjgBP6o+Ij0TXOW8ZEo8cwZt+381v8FsHNGsKfxnqowYaVfpCVAYy3
         l+baKdD5YXF9lqMSTyg5KTms4gFx0gn+1kZvMWxZvrtRajxH4aonKlolKZI4I/ckTLHX
         6ui/YAaFEYjOMm3GeqoI9keislLDsETNtZ5z5uxSvTi1S8oAnxHgcEtxeHcZAGHCUntC
         dz/VSNnwx26B7q7Ot1K0VYV/5KhRJS0LiYJ3gt/2ehKhcWgKd4MHw9pk4WR5qtqZClpD
         u/eXZeZiWkgL4sr1sKJ7u4fYu8XMvOHuOIrgpJ/AabcEojfEnMJx1I/SAUyVyA/I8sXZ
         RkRA==
X-Forwarded-Encrypted: i=1; AJvYcCXmV1ILLhEvvzJp59nCsSWXQifjaoRWYq3cAVYTepn8MObyrfaOVrDSLtUW0n9rQj0BSkibl1jyMq7c4RlBSv/H@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0bJCAtPa5vj1TSFM8aq7sR+ODq4aPW/FakKHyGbKVyZ5L4V++
	5IB+EhH7dtGNOK4mQPYilGse0ZAtmWIdmYioVesX1gJkB6oxD3lAnvgH
X-Gm-Gg: ATEYQzz1qQchiCZW8G8wz31tUvqjEvjhwxceCs4GiFaBw7fXiHN9DnJoc9Hmet+tfYf
	T4cvzRRZBffB6GxMEYiqYyWEywp7lMVPhumpoXXZfBjgNovRelCUKHl7zE9IpO9QrssD5RMUgt8
	Qb2NL8ncblm9c9m9HKhPXiZ2HVs2Sj9bw6oY3FfecjNUuLtg8Sos/j/uym8D0r1dEOPM0ABT2/s
	T2tc7jwswVLLv7CYxvO9/J/25jfIcd6SAwFTeBnRkihZ4jXCHH2vwOgxBwB6LmrzImn3AZmADNu
	JTAD8Mkiyh9Pnj5UzPWSEQGCLpIKT0KJfkOKICwfR0bPX5TnzWLEQBerwCSVloBGCMSSsLj+4N5
	tNrnCfkOYzs7G9TFqYM4FhdXUXbXsi7v3YzWxYu9q0lzI24It7toFPSJmpxwKAXYU6zqTPwFtY4
	ZkLK4Xn7VMQuDz2levYB9DiGQWQH4=
X-Received: by 2002:a05:6a00:6c8d:b0:829:809e:8972 with SMTP id d2e1a72fcca58-82c95e5893bmr2369531b3a.3.1774614606793;
        Fri, 27 Mar 2026 05:30:06 -0700 (PDT)
Received: from localhost ([2408:8642:893:d2da:bd6e:7277:59f0:fb2b])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-82c7d3f959esm5618143b3a.56.2026.03.27.05.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 05:30:06 -0700 (PDT)
From: yuhaocheng035@gmail.com
To: Peter Zijlstra <peterz@infradead.org>,
	Qing Wang <wangqing7171@gmail.com>
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Subject: [PATCH v4] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Fri, 27 Mar 2026 20:29:52 +0800
Message-ID: <20260327122953.64466-1-yuhaocheng035@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260326112821.GK3738786@noisy.programming.kicks-ass.net>
References: <20260326112821.GK3738786@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <yuhaocheng035@gmail.com>

Syzkaller reported a refcount_t: addition on 0; use-after-free warning
in perf_mmap.

The issue is caused by a race condition between a failing mmap() setup
and a concurrent mmap() on a dependent event (e.g., using output
redirection).

In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
event->rb with the mmap_mutex held. The mutex is then released to
perform map_range().

If map_range() fails, perf_mmap_close() is called to clean up.
However, since the mutex was dropped, another thread attaching to
this event (via inherited events or output redirection) can acquire
the mutex, observe the valid event->rb pointer, and attempt to
increment its reference count. If the cleanup path has already
dropped the reference count to zero, this results in a
use-after-free or refcount saturation warning.

Fix this by extending the scope of mmap_mutex to cover the
map_range() call. This ensures that the ring buffer initialization
and mapping (or cleanup on failure) happens atomically effectively,
preventing other threads from accessing a half-initialized or
dying ring buffer.

v2:
Because expanding the guarded region would cause the event->mmap_mutex
to be acquired repeatedly in the perf_mmap_close function, potentially
leading to a self deadlock, the original logic of perf_mmap_close was
retained, and the mutex-holding logic was modified to obtain the
perf_mmap_close_locked function.

v3:
The fix is made smaller by passing the parameter "holds_event_mmap_mutex"
to perf_mmap_close.

v4:
This problem is solved in a smarter way.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
Reviewed-by: Ian Rogers <irogers@google.com>
Reviewed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
---
 kernel/events/core.c        | 59 +++++++++++++++++++++++++++++--------
 kernel/events/internal.h    |  1 +
 kernel/events/ring_buffer.c |  2 ++
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 22a0f405585b..d3f978402b1e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7010,7 +7010,7 @@ static void perf_mmap_open(struct vm_area_struct *vma)
 }
 
 static void perf_pmu_output_stop(struct perf_event *event);
-
+static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *rb);
 /*
  * A buffer can be mmap()ed multiple times; either directly through the same
  * event, or through other events by use of perf_event_set_output().
@@ -7025,8 +7025,6 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
-	int mmap_locked = rb->mmap_locked;
-	unsigned long size = perf_data_size(rb);
 	bool detach_rest = false;
 
 	/* FIXIES vs perf_pmu_unregister() */
@@ -7121,11 +7119,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
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
@@ -7265,6 +7259,15 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
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
@@ -7327,8 +7330,6 @@ static int perf_mmap_rb(struct vm_area_struct *vma, struct perf_event *event,
 	if (!rb)
 		return -ENOMEM;
 
-	refcount_set(&rb->mmap_count, 1);
-	rb->mmap_user = get_current_user();
 	rb->mmap_locked = extra;
 
 	ring_buffer_attach(event, rb);
@@ -7484,10 +7485,42 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 * vmops::close().
 		 */
 		ret = map_range(event->rb, vma);
-		if (ret)
-			perf_mmap_close(vma);
-	}
+		if (likely(!ret))
+			return 0;
+
+		/* Error path */
 
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
+	}
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

base-commit: 77de62ad3de3967818c3dbe656b7336ebee461d2
-- 
2.51.0

