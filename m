Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21836344DB9
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434069; cv=none; b=GdbMvY778mn5Xd2fouL10BaDhuSoH4mp8e/CC/RK5wrgGSpUlBTAWftFteJ7AIzqp1JaBld0mxJ7WHjAFRQkLHY/jugE5PCM0D9m51X/aD0ftkjE7w0gkfJ40DQBOklS9gGwd8rTji6CjAydCnWrQZHFj6//VrH13RHyugVtODQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434069; c=relaxed/simple;
	bh=WPt4DvNqupxTlvcwAH81mPkiloh4dRgjM9M59Bf3dnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImA7OKSU9C41kQJv2qbC+We9ODXgjcwoFW6tNYvS/TxkH1WWD2o/n0+M3zGNy7pl4dUYDj9aPQxiSkVWePl0+6gLEHXB2autAQwZbQ4zFt7dIUIS9yHV4+h17etuYV+ph8Z/JF6L/opzvO6/BcknnlpoZeCWEgDeLAGmalct7yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WXIXfl3t; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXIXfl3t"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2aae146b604so43155865ad.3
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Mar 2026 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774434067; x=1775038867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rEJQGBx4Xb6J3zWmRxtcoZ3WTekrmNgq3UQWPxGWMU=;
        b=WXIXfl3txdDeTo1Soro8TnCECrI1trHBNmFtL0zol+leEe37U82Njfg3K3kTP1Roum
         pWkIMorgpyIzrXEZULwTCPFpEnb6Cjefj4BYig37H9L+HDb5UqINHu/UUP3ym9Jb+DbI
         eNGfCqRI6O+kEN2xi1SbDbNEc2OxHNW08vDUfX8Ss88BsVFc2mx8cQpX1zU22AN48OdJ
         Za9XnnllkzgpaBBsl88bK03ll95jP5/GWH9urcMmEzRtXde1XItOajqG4WcTyd4kNZSe
         fivzssDquCEoQLdN/oSHA2HhZuwnCw165AGKJF0LDKQsb3oZdunahxdJGxQ2kzd/6uQV
         M1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774434067; x=1775038867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rEJQGBx4Xb6J3zWmRxtcoZ3WTekrmNgq3UQWPxGWMU=;
        b=WT4eiGYqh5ErxLbzqupBoa1qIbWMZpgll0Udio4bzBK8FtPYS1A6T2CY2qIAPMgGCD
         e/NrdavPODAbSFiug6BBsWoTJTvAP/yO5/kChko5q7liCKrvXyIev7Crax2ZvUtz5POS
         pY3QHb+19kvnn3TJzYRDRZFrII2zsgx2rCBFK/xLgu/K8M7eu+GQVDnToLrHsV4LqBL3
         4f2qErt6c5BsWmvMGz0ftnECduNGyVyhns+SnL19dvm75K3Rc9qZBe8uUgtG5a8OKchN
         csskV5N7sIfHCS4gnRlCTrvNNvXien9UslCz2XYMzr+4VocQ1897H8KYW7sCkjz/9rtw
         KlwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpUq1zk8Z39i4SHyNEs12d+lIdC7n1DCH9psbn2MMrnlfNJnlAAnSF4wp4CUVoTldQvQNS10Q3hQ5y/MO/nfxw@vger.kernel.org
X-Gm-Message-State: AOJu0YxEfLxZTz+U/Stdxwnpr5/yW6LHNsiSgCyoEBbtygFGugrP3VRp
	s3iensO95wHe2uk+HtnYF6YExCk/kkE9yoh8486x7ItoJmSWzHEq4ReP
X-Gm-Gg: ATEYQzwocqok4oB7Ug6RKIzbZKAWr8/yIWMwI7Hg6soBaeig4wu/9LhILChpoi/OWKX
	TGm4pVjj6P3AmdTu4e313Dd7lhXlzOKw32zNgxgJuDLE0guXp9uTOiJlCtjYEE16EYKnZn/QXxv
	dAwzMdTCGiRbS2ce5ZXEjhYcGjBTo5Cvt7bPHw7tIksfDY7g8hsiBDW75mA1CvgqgHRCQqnmdwn
	m4Mvd4TWn3PG/TR+0Xz2PSVn2kJ83AEKotjCuyXUY9ncHaCQAjSs9ZNmBgxMgRmZm7svDQaj314
	445/b2UTAkPb6870sn7dnzWSUVocFlqC1ICjw25hEc3VKngrz0Wh/isBQUQmTV99yFFJvjmCdTm
	t+w7tQ/DnJLGGuRgX5ov0sACN/RR5cs6rA9Vg5u+ofag4y9VDEZYRXjQWTSIvE/Sh3YqorcvTBZ
	rn78DZl+934GNzchKdyWDUST+new==
X-Received: by 2002:a17:903:234d:b0:2ae:6133:d170 with SMTP id d9443c01a7336-2b0b0a58ad9mr31139925ad.20.1774434067110;
        Wed, 25 Mar 2026 03:21:07 -0700 (PDT)
Received: from localhost ([2408:8642:893:d2da:e037:e3f2:a0bf:cef])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2b08366b5besm177533395ad.55.2026.03.25.03.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 03:21:05 -0700 (PDT)
From: yuhaocheng035@gmail.com
To: irogers@google.com,
	wangqing7171@gmail.com,
	peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Subject: [PATCH v3] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Wed, 25 Mar 2026 18:20:53 +0800
Message-ID: <20260325102053.1401-1-yuhaocheng035@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAAoXzSrdEjHtLYqHJDT8bm_gDAY=C1VdeU=0NbjJ0hhpOo5V9w@mail.gmail.com>
References: <CAAoXzSrdEjHtLYqHJDT8bm_gDAY=C1VdeU=0NbjJ0hhpOo5V9w@mail.gmail.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
---
 kernel/events/core.c | 78 +++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2c35acc2722b..a3228c587de1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6730,9 +6730,10 @@ static void perf_pmu_output_stop(struct perf_event *event);
  * the buffer here, where we still have a VM context. This means we need
  * to detach all events redirecting to us.
  */
-static void perf_mmap_close(struct vm_area_struct *vma)
+static void __perf_mmap_close(struct vm_area_struct *vma, struct perf_event *event,
+			      bool holds_event_mmap_lock)
 {
-	struct perf_event *event = vma->vm_file->private_data;
+	struct perf_event *iter_event;
 	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
@@ -6772,11 +6773,14 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	if (refcount_dec_and_test(&rb->mmap_count))
 		detach_rest = true;
 
-	if (!refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex))
+	if ((!holds_event_mmap_lock &&
+	     !refcount_dec_and_mutex_lock(&event->mmap_count, &event->mmap_mutex)) ||
+	    (holds_event_mmap_lock && !refcount_dec_and_test(&event->mmap_count)))
 		goto out_put;
 
 	ring_buffer_attach(event, NULL);
-	mutex_unlock(&event->mmap_mutex);
+	if (!holds_event_mmap_lock)
+		mutex_unlock(&event->mmap_mutex);
 
 	/* If there's still other mmap()s of this buffer, we're done. */
 	if (!detach_rest)
@@ -6789,8 +6793,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 */
 again:
 	rcu_read_lock();
-	list_for_each_entry_rcu(event, &rb->event_list, rb_entry) {
-		if (!atomic_long_inc_not_zero(&event->refcount)) {
+	list_for_each_entry_rcu(iter_event, &rb->event_list, rb_entry) {
+		if (!atomic_long_inc_not_zero(&iter_event->refcount)) {
 			/*
 			 * This event is en-route to free_event() which will
 			 * detach it and remove it from the list.
@@ -6799,7 +6803,8 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		}
 		rcu_read_unlock();
 
-		mutex_lock(&event->mmap_mutex);
+		if (!holds_event_mmap_lock)
+			mutex_lock(&iter_event->mmap_mutex);
 		/*
 		 * Check we didn't race with perf_event_set_output() which can
 		 * swizzle the rb from under us while we were waiting to
@@ -6810,11 +6815,12 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		 * still restart the iteration to make sure we're not now
 		 * iterating the wrong list.
 		 */
-		if (event->rb == rb)
-			ring_buffer_attach(event, NULL);
+		if (iter_event->rb == rb)
+			ring_buffer_attach(iter_event, NULL);
 
-		mutex_unlock(&event->mmap_mutex);
-		put_event(event);
+		if (!holds_event_mmap_lock)
+			mutex_unlock(&iter_event->mmap_mutex);
+		put_event(iter_event);
 
 		/*
 		 * Restart the iteration; either we're on the wrong list or
@@ -6842,6 +6848,18 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }
 
+static void perf_mmap_close(struct vm_area_struct *vma)
+{
+	struct perf_event *event = vma->vm_file->private_data;
+
+	__perf_mmap_close(vma, event, false);
+}
+
+static void perf_mmap_close_locked(struct vm_area_struct *vma, struct perf_event *event)
+{
+	__perf_mmap_close(vma, event, true);
+}
+
 static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
 {
 	/* The first page is the user control page, others are read-only. */
@@ -7167,28 +7185,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			ret = perf_mmap_aux(vma, event, nr_pages);
 		if (ret)
 			return ret;
-	}
 
-	/*
-	 * Since pinned accounting is per vm we cannot allow fork() to copy our
-	 * vma.
-	 */
-	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &perf_mmap_vmops;
+		/*
+		 * Since pinned accounting is per vm we cannot allow fork() to copy our
+		 * vma.
+		 */
+		vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
+		vma->vm_ops = &perf_mmap_vmops;
 
-	mapped = get_mapped(event, event_mapped);
-	if (mapped)
-		mapped(event, vma->vm_mm);
+		mapped = get_mapped(event, event_mapped);
+		if (mapped)
+			mapped(event, vma->vm_mm);
 
-	/*
-	 * Try to map it into the page table. On fail, invoke
-	 * perf_mmap_close() to undo the above, as the callsite expects
-	 * full cleanup in this case and therefore does not invoke
-	 * vmops::close().
-	 */
-	ret = map_range(event->rb, vma);
-	if (ret)
-		perf_mmap_close(vma);
+		/*
+		 * Try to map it into the page table. On fail, invoke
+		 * perf_mmap_close() to undo the above, as the callsite expects
+		 * full cleanup in this case and therefore does not invoke
+		 * vmops::close().
+		 */
+		ret = map_range(event->rb, vma);
+		if (ret)
+			perf_mmap_close_locked(vma, event);
+	}
 
 	return ret;
 }

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.51.0

