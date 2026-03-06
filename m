Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA08D3451D7
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 09:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772789783; cv=none; b=Q8/onlJsKT+kolpQ1wEJQ0DJhOLqun1i9onxQHbkoDVSDmTKomhHfyOPY1SVXWgZwW+1bArGKK9SJWkKJEa2RBsylMG3O7xT3ty6xLVI/mc9d7xS3tGdw7eiGM5vnwoVtQR6YCkap88srnn7Cq5S6QeoEWeHvSmOkmV8T/1S6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772789783; c=relaxed/simple;
	bh=jcA+on09iDE1IR2yBmTExuW1QlEziEnx+GwxlhMn1i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pd9z99rKH4nzdp7suS37TUfsTMy4DRZlRsHtFYf83eO/jpw+W/vezCXPAJ4VUgzqvYr3BPG7iUK1y/NSSoKUXTVU4t4yJk6+gyQeW8qer3oclY06oFc1+BdK0m81pube77pOKLzsajS0J5CxPvJ8Ka2R4tRhACU0AeUP9JW71AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdnESQ43; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdnESQ43"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-3597c40a838so2362366a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 01:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772789781; x=1773394581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN0zGFg33zgQxzT7/xaXsRp6BwBZHo415245xIuslL8=;
        b=QdnESQ43ulIUfpu+kj7meA8Qm9EfoeG/29jtThd+QiWnDdS5s7y4l3qJEBupmUhl0L
         dw/AwiWjeV0vr1LobhA/Vq1JdBZ/lDXTFc19BuJRvBFvI+NK3Osv/WBeBph0wxpm37q2
         y6NltqdR0SXb+wQb3ITd73bhCFYQn1fndRYVZsEu63dHhoymD0Yr9bXchcXwPD7ZDDHV
         yCTcMSFzNKdRt0zPuSpGBcH7yphTBOqov0ktq74X6MvbEeIqDHZYpPv7HvlvCBrqahnU
         0Ik1go54zBTb/nk7WG+jS0nZ6HWuKn8+vI+SmxY8a7sxA0eyLQzPr9Pic/qCaOWtvnYk
         QCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772789781; x=1773394581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IN0zGFg33zgQxzT7/xaXsRp6BwBZHo415245xIuslL8=;
        b=nYww4mzAMxdEOTTY8p6v5/WVrYgv20+lcyUPNoAJoPu5bbo7gSP3kXEnEpjfGxJufL
         tOsXF+MDhyKmR+tjCpyN2g3I7JtvCw0WJ9qd0IHdQ2EbzCvRRtcCFTaFiWKWw4adv2xB
         Qtw6ExFi617659SXrRQ5+TJcnpuhK2m/38Nwa1O6bICIylGrPdNq77lT60tp11byHiJ1
         g7hejbnoaLUlJt5bnp851EgMAgo8ZPBbJO/2Pr2IYnZMtkzJvRzVJVzj7frkNB0Onb64
         lPfwq6LeL0wusg3aTLZmX24fbDpGUVKUa9hkftct/6TuS45O71yRupmFSf1i3MVLOPIo
         AX8w==
X-Forwarded-Encrypted: i=1; AJvYcCW2gWELvUgbsDd/ZKsiz5pOX0R/O9KodAh7oq+0ghQ391IWfxdrRADyQoyj0nfCA7I0Ldquh2AX/mnhoyVFTz34@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRc1ELRhtl9YJdA73XzzRwTypIK49hc2PD5UYmwAN7eWx1JlT
	aLps3ysC7QWIFqeLREBcNDZludSdyGRkRYoGWyq2GvXCdeO47cTW4Fqs
X-Gm-Gg: ATEYQzxpTnrxJ2GNHALLsdSAHPUD3oZZTQklmo2wFdDY2MBKWh/sXIL7qEwI9WkAhnY
	txLVnJb+RxDbJ0K+FVBzBETMamGG7dx5JS0o5zTY7AlScnO5jrpTmkKJhLkyhtb1VoUBai21Uis
	+r5VUHFdWEJB0+r02pw6G2QxxKVFmISffqiy298QjX9WKaBxk7Oi8I5tAYoqBPALsiblKf5opHH
	ABlUyfPzpzmBgmKQ+JcQng1F0mWIz2Uc73PXo+vdlUrf88t2sl9gqxfHTj29QCSsjzghZtl+Y7I
	zlc/+9LIahi4bmziBXVbDC+t2c5BjlnowaSLLd7ArT8msQ4FLRhb9y7RQWBdbwuSsfVnfotDpLF
	Hm1Mde3Vek5ny1an9YGMeymJaABfsBlEqQqARPmYTUWfr9KtvYrnlcqj/2jvxdStcyak28EjVGh
	j7cW0OITBZpYak2CPuYFH9qPUERL0=
X-Received: by 2002:a17:90b:3512:b0:34c:c514:ee1f with SMTP id 98e67ed59e1d1-359be2a5cf2mr1459073a91.11.1772789780957;
        Fri, 06 Mar 2026 01:36:20 -0800 (PST)
Received: from localhost ([2408:8642:893:d2da:cc80:5adf:acd4:7172])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-359c01961a4sm1233661a91.15.2026.03.06.01.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 01:36:20 -0800 (PST)
From: yuhaocheng035@gmail.com
To: irogers@google.com
Cc: peterz@infradead.org,
	acme@kernel.org,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v2] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Fri,  6 Mar 2026 17:35:49 +0800
Message-ID: <20260306093616.84299-1-yuhaocheng035@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAP-5=fVJyVMZw=DqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA@mail.gmail.com>
References: <CAP-5=fVJyVMZw=DqP53Kxg58nUmJ_0bxoaeOKAbC03BVc11HaA@mail.gmail.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
---
 kernel/events/core.c | 152 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 133 insertions(+), 19 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2c35acc2722b..6c161761db38 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6842,6 +6842,120 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }
 
+static void perf_mmap_close_locked(struct vm_area_struct *vma)
+{
+	struct perf_event *event = vma->vm_file->private_data;
+	struct perf_event *iter_event;
+	mapped_f unmapped = get_mapped(event, event_unmapped);
+	struct perf_buffer *rb = ring_buffer_get(event);
+	struct user_struct *mmap_user = rb->mmap_user;
+	int mmap_locked = rb->mmap_locked;
+	unsigned long size = perf_data_size(rb);
+	bool detach_rest = false;
+
+	/* FIXIES vs perf_pmu_unregister() */
+	if (unmapped)
+		unmapped(event, vma->vm_mm);
+
+	/*
+	 * The AUX buffer is strictly a sub-buffer, serialize using aux_mutex
+	 * to avoid complications.
+	 */
+	if (rb_has_aux(rb) && vma->vm_pgoff == rb->aux_pgoff &&
+	    refcount_dec_and_mutex_lock(&rb->aux_mmap_count, &rb->aux_mutex)) {
+		/*
+		 * Stop all AUX events that are writing to this buffer,
+		 * so that we can free its AUX pages and corresponding PMU
+		 * data. Note that after rb::aux_mmap_count dropped to zero,
+		 * they won't start any more (see perf_aux_output_begin()).
+		 */
+		perf_pmu_output_stop(event);
+
+		/* now it's safe to free the pages */
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
+		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
+
+		/* this has to be the last one */
+		rb_free_aux(rb);
+		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
+
+		mutex_unlock(&rb->aux_mutex);
+	}
+
+	if (refcount_dec_and_test(&rb->mmap_count))
+		detach_rest = true;
+
+	if (!refcount_dec_and_test(&event->mmap_count))
+		goto out_put;
+
+	ring_buffer_attach(event, NULL);
+
+	/* If there's still other mmap()s of this buffer, we're done. */
+	if (!detach_rest)
+		goto out_put;
+
+	/*
+	 * No other mmap()s, detach from all other events that might redirect
+	 * into the now unreachable buffer. Somewhat complicated by the
+	 * fact that rb::event_lock otherwise nests inside mmap_mutex.
+	 */
+again:
+	rcu_read_lock();
+	list_for_each_entry_rcu(iter_event, &rb->event_list, rb_entry) {
+		if (!atomic_long_inc_not_zero(&iter_event->refcount)) {
+			/*
+			 * This event is en-route to free_event() which will
+			 * detach it and remove it from the list.
+			 */
+			continue;
+		}
+		rcu_read_unlock();
+
+		if (iter_event != event) {
+			mutex_lock(&iter_event->mmap_mutex);
+			/*
+			 * Check we didn't race with perf_event_set_output() which can
+			 * swizzle the rb from under us while we were waiting to
+			 * acquire mmap_mutex.
+			 *
+			 * If we find a different rb; ignore this event, a next
+			 * iteration will no longer find it on the list. We have to
+			 * still restart the iteration to make sure we're not now
+			 * iterating the wrong list.
+			 */
+			if (iter_event->rb == rb)
+				ring_buffer_attach(iter_event, NULL);
+
+			mutex_unlock(&iter_event->mmap_mutex);
+		}
+		put_event(iter_event);
+
+		/*
+		 * Restart the iteration; either we're on the wrong list or
+		 * destroyed its integrity by doing a deletion.
+		 */
+		goto again;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * It could be there's still a few 0-ref events on the list; they'll
+	 * get cleaned up by free_event() -- they'll also still have their
+	 * ref on the rb and will free it whenever they are done with it.
+	 *
+	 * Aside from that, this buffer is 'fully' detached and unmapped,
+	 * undo the VM accounting.
+	 */
+
+	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
+			&mmap_user->locked_vm);
+	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
+	free_uid(mmap_user);
+
+out_put:
+	ring_buffer_put(rb); /* could be last */
+}
+
 static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
 {
 	/* The first page is the user control page, others are read-only. */
@@ -7167,28 +7281,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
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
+			perf_mmap_close_locked(vma);
+	}
 
 	return ret;
 }

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.51.0

