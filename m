Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ABC274FDF
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561649; cv=none; b=sZsaf30TnqLROkgL9XfuRFuZDH73t1APzWsNQwP+CEG+jpQGvIp1stB2qA57yYjl0GxZtHWkPgBlMl5rOPkFGoJowhaXzY0chjb8KqJbGly6Nnf7kNOy2zQp5MzyCTGY3rCjQ8MbGnY62b04ySJyC8NgtiaVSXoMqF9HqriVzVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561649; c=relaxed/simple;
	bh=MEOP7Cim0SWYhd0AHNqQSoaCp+To1czrqRaH2EBbrC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RoqiKy21INB/tpJgHnX8KvQbEaxx1GT+C8KgFrsuWCB5SLxGmP4+Ttx7TXaKyKLKROLOVXbZEClrXMSgsU3VufSxykfpH8ypYERS8R2w4jrRN5/yFFI1yZir4umZ0inMqwVE3UTi7OjRgUgpGwrLJqLw8hT1qqIi0Y/D4jmn12o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQUwkUIW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQUwkUIW"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab67ff8f16so332367a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 09:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561647; x=1792166447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C2iDUyx1hYmDpowiwbHCOTP7K4pLn3hdUaxaoPJ6+Vo=;
        b=eQUwkUIWZVUODGqmRxP1j3wBQLuIJ5VM1FIu4Bq7ZjneV35tfIjFRzTx0Eh5bEPKGw
         6Xgyik7Nkw9huGKK0WnBI9g7zLR9NWTYsObDGVeD6tXuFKF9DvrzpgZ8LgJ0oWkKuqW2
         RyKDCIFAMJcBDpoMyuyngLN6uJbjGzUYuaCHywnU4rKBAZ0qannVPS/lGO5/6O92P+n6
         EFvGbLRNIXAbbHJ0REFGVWZwdUkxGNscMIBeiUQ/hqCT/vFGTtXq4mBreFXIgeGEgly3
         8dH2jWdtLHXSgHT8dSEDvT8+tSnDlosuCenYkSTWZaY+Q9gu2cK4aQ9uqyZNm9HGZK8v
         0b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561647; x=1792166447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=C2iDUyx1hYmDpowiwbHCOTP7K4pLn3hdUaxaoPJ6+Vo=;
        b=RSRYFcPVfdGM5GMv4wM/XZUsNCZgEklGSLx3e2tyimb7jaKWgJ2FSSnFP1QIay6PaK
         JX5vvQlaV/X0Y2ngDNEk8iAJhgy6NeNS7QLZptE5w1TaWFnyFfhEZ4Bi1TUXkqWtZ3Qh
         /0CQ9G0VUJHtO+NutJsUfFSHmWUGVZmdTJ4K7k9g0ds+eDguO3HNCy4/P+JVviku9xiU
         reeZs63mSz5jXrH9uE+RtpIEPQ/JX+aZyU+w9lArzBA47yOROfAbJvflA0sJtKhIJK9V
         IkyyPI17czbJIbpJDCwOVo49NFtWPXFzBcu3A5Hxbhdt5ugO3poJ/KnVYcrQscAKtCNI
         l01Q==
X-Forwarded-Encrypted: i=1; AKwUvBw8k0RsphEZrCXukGXnXRseMPXg9xKY62atcBbBZ7y3uCoIO9Do2QJ3GL0QufKE2VjdD/ousnEXPqqFlSjoeYRs@vger.kernel.org
X-Gm-Message-State: AFq9FYKU0cs3obSSK/poBNiLmDNrpUegdgwxiqi3XPc4RYH6ukyLBLc9
	Pr1dso2/RJZ9ho+TLZYsfbpXmQXwaC3zUmCtR5Er/XXrwuI8OE3Tf4qj
X-Gm-Gg: AYBFou2ODob1frypnLqlGZ0zso9jI1juzV3MCcBK7vDkeofXXrmWHC9yd1Wg516t/Eo
	u8qvPoT10zQLU5pmsDmXsm6lSMyNQ10eeATaBk/rdAF/BcJXOzLySXl8uxmp5GhZuDV0kkNHPE+
	2TfwmjZhcVMVr0zIrGUyN4z+R6gAkpawET09nwiLCKpeRIE6QLoBLLkez5u86hxv00iE0Tal2Sz
	qUYGNGAxKGPO8hdQeWBpVrJMyQ7EtLxRlKSoHZojsvKywvfuMOaqUj1WP114vuRryoiEY7F5ji3
	jJl+cIqe9KQdPVentqx6F4WKdOL4kln6gJWsVUESoRz/GGwVgkFRrYB+nxJonIMHUNM3Yakl5EP
	2KVt8nFVh5ZVaD0cPAyaUle5fI3g2Q1s+lAd3y3iemAIwtpVL5W2y+mI51y4yfgSiYLiPIiU4cM
	qEFF0WAa5RGsXxiMxuLQ+uWOCLlxZOGJ/w+AKJ4gd0usYwzoXrZTpq1jE/rut1i2lck/ZDVa69D
	1M1g8Iy2TYt40nrlutPG063y9jxtMKFzLniFr8c
X-Received: by 2002:a17:90b:3b52:b0:3a8:c0cd:57f6 with SMTP id 98e67ed59e1d1-3ab3a95046fmr2174975a91.9.1791561646542;
        Fri, 09 Oct 2026 09:00:46 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm12333235ad.60.2026.10.09.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:00:46 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: sj@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	akpm@linux-foundation.org,
	lianux.mm@gmail.com,
	kunwu.chan@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 1/5] perf/core: add AUX buffer ownership for kernel events
Date: Fri,  9 Oct 2026 23:59:48 +0800
Message-ID: <20261009160010.1829642-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009160010.1829642-1-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an in-kernel AUX owner reference and setup/release helpers for
kernel-created perf events that need an AUX buffer without a userspace
mmap.  The setup path validates that the event is a kernel event with
no parent, rejects non-power-of-two page counts and negative watermark
values, allocates the perf buffer and AUX pages, records the kernel
owner, and attaches the buffer under the same lock.

perf_event_release_aux() stops AUX writers, frees AUX storage, and
detaches the buffer, in that order, matching the AUX teardown ordering
of perf_mmap_close(): perf_pmu_output_stop() walks event->rb->event_list
and rb_free_aux() must run while the buffer is still referenced by the
event.  The single event->rb reference is dropped by
ring_buffer_attach(event, NULL) itself, so the release path does not
put it again.

Both functions run under event->mmap_mutex, the lock that already
serialises ring-buffer attach/detach transitions for an event:
perf_mmap(), perf_mmap_close(), _perf_event_set_output() and
_free_event() all hold it around ring_buffer_attach().  Concurrent
perf_event_release_aux() callers therefore go through the same
serialisation point, and a second release call, or a release of a
buffer this API does not own, is a no-op.

Keep aux_mmap_count dedicated to userspace mappings.
perf_aux_output_begin() accepts a writer while either a userspace or kernel
owner remains, preserving the existing teardown ordering.

Co-developed-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/perf_event.h  |  11 +++
 kernel/events/core.c        | 164 ++++++++++++++++++++++++++++++++++++
 kernel/events/internal.h    |   6 ++
 kernel/events/ring_buffer.c |  11 ++-
 4 files changed, 188 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7797ce207555..78fd2ed11fcf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1255,6 +1255,17 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr,
 				 perf_overflow_handler_t callback,
 				 void *context);
 
+/*
+ * AUX ring-buffer support for kernel-created events (no user mmap).
+ * perf_event_setup_aux() allocates the buffer the PMU writes into via
+ * perf_aux_output_begin()/perf_aux_output_end(); the paired
+ * perf_event_release_aux() must be called before
+ * perf_event_release_kernel().
+ */
+extern int perf_event_setup_aux(struct perf_event *event, int nr_pages,
+				long watermark);
+extern void perf_event_release_aux(struct perf_event *event);
+
 extern void perf_pmu_migrate_context(struct pmu *pmu,
 				     int src_cpu, int dst_cpu);
 extern int perf_event_read_local(struct perf_event *event, u64 *value,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index de05df65ab3d..966e74645cc9 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7139,6 +7139,170 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	ring_buffer_put(rb); /* could be last */
 }
 
+/*
+ * perf_event_setup_aux()/perf_event_release_aux() - AUX buffer support for
+ * kernel-created perf events (perf_event_create_kernel_counter()).
+ *
+ * perf_mmap()/perf_mmap_close() build and tear down AUX buffers for
+ * user-space events; kernel consumers (e.g. DAMON's ARM SPE backend) have no
+ * mmap, so they need this symmetric pair to get a buffer the PMU can write
+ * into via perf_aux_output_begin()/perf_aux_output_end().
+ *
+ * event->mmap_mutex is not an mmap-specific lock here: it is the lock that
+ * already serialises ring-buffer attach/detach transitions for an event
+ * (perf_mmap(), perf_mmap_close(), _perf_event_set_output() and
+ * _free_event() all hold it around ring_buffer_attach()).  Both functions
+ * below use it so that the attach and detach they perform are atomic with
+ * respect to those paths and to each other.
+ *
+ * The buffer holds an AUX owner reference (aux_kernel_count = 1) so
+ * perf_aux_output_begin() admits writers and so it is torn down here
+ * rather than by perf_mmap_close().  perf_event_release_aux() also detaches
+ * the event's normal ring-buffer reference before the event is released.
+ */
+
+/**
+ * perf_event_setup_aux() - Allocate an AUX ring buffer for an event.
+ * @event:	Kernel-created perf event (must not have an rb yet).
+ * @nr_pages:	AUX buffer size in pages; power of two, >= 1.
+ * @watermark:	AUX watermark; 0 selects the perf default (half the buffer).
+ *
+ * The buffer is non-overwrite streaming (RING_BUFFER_WRITABLE): the PMU
+ * pauses when the buffer is full until the consumer advances the tail.
+ * Must be called before the event is enabled.  The PMU's ->setup_aux()
+ * callback (e.g. arm_spe_pmu_setup_aux) validates the size and maps the
+ * pages for hardware writes.  The ring buffer is allocated with zero
+ * data pages, so PERF_RECORD_AUX events are not recorded; this is
+ * intentional for kernel consumers that drain trace data directly.
+ * Returns 0 on success, -errno otherwise.
+ */
+int perf_event_setup_aux(struct perf_event *event, int nr_pages,
+			 long watermark)
+{
+	struct perf_buffer *rb;
+	int ret;
+
+	if (!is_kernel_event(event) || event->parent ||
+	    !is_power_of_2(nr_pages) || watermark < 0)
+		return -EINVAL;
+
+	mutex_lock(&event->mmap_mutex);
+	if (event->rb) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
+	rb = rb_alloc(0, 0, event->cpu, 0);
+	if (!rb) {
+		ret = -ENOMEM;
+		goto out_unlock;
+	}
+
+	/* AUX area sits right after the user (control) page. */
+	ret = rb_alloc_aux(rb, event, 1, nr_pages, watermark,
+			   RING_BUFFER_WRITABLE);
+	if (ret)
+		goto err_put;
+
+	/*
+	 * No user-space mmap exists for this buffer; record an in-kernel
+	 * AUX owner (aux_kernel_count) instead so perf_aux_output_begin()
+	 * admits writers and perf_event_release_aux() performs the teardown
+	 * that perf_mmap_close() would otherwise do.
+	 */
+	refcount_set(&rb->aux_kernel_count, 1);
+
+	/* Transfer the allocation reference to the event. */
+	ring_buffer_attach(event, rb);
+	mutex_unlock(&event->mmap_mutex);
+
+	return 0;
+
+err_put:
+	ring_buffer_put(rb);
+out_unlock:
+	mutex_unlock(&event->mmap_mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(perf_event_setup_aux);
+
+/**
+ * perf_event_release_aux() - Tear down an AUX buffer for an event.
+ * @event:	Event with an AUX buffer allocated by perf_event_setup_aux().
+ *
+ * Stops any active AUX writers, frees the AUX pages, and detaches the ring
+ * buffer from the event.  Must be called before perf_event_release_kernel().
+ * Safe to call with a missing rb (no-op); a second call is also a no-op.
+ * A ring buffer not allocated by perf_event_setup_aux() is left attached.
+ *
+ * The whole teardown runs under event->mmap_mutex, the lock that already
+ * serialises ring-buffer attach/detach transitions for this event
+ * (perf_mmap(), perf_mmap_close() and _perf_event_set_output() hold it
+ * around ring_buffer_attach()): concurrent callers on the same event
+ * serialise here, so exactly one of them drops the single
+ * aux_kernel_count owner reference and performs the teardown, and the
+ * others then observe event->rb == NULL and return.  Holding it also
+ * keeps event->rb valid across perf_pmu_output_stop(), which walks
+ * event->rb->event_list, until the detach is done.
+ *
+ * The ordering matches the AUX teardown of perf_mmap_close(): the PMU
+ * output is stopped and the AUX pages freed before the buffer is
+ * detached from the event, because perf_pmu_output_stop() walks
+ * event->rb->event_list and rb_free_aux() must run while the buffer is
+ * still referenced by the event.
+ *
+ * The caller must quiesce AUX consumers before releasing the buffer;
+ * active AUX references at release time indicate a violated lifetime
+ * contract (see the aux_refcount WARN below).
+ */
+void perf_event_release_aux(struct perf_event *event)
+{
+	struct perf_buffer *rb;
+
+	if (!is_kernel_event(event) || event->parent)
+		return;
+
+	mutex_lock(&event->mmap_mutex);
+
+	rb = event->rb;
+	if (!rb)
+		goto out_unlock;
+
+	/* Only tear down a ring buffer that this API owns. */
+	if (!rb_has_aux(rb) || !refcount_read(&rb->aux_kernel_count))
+		goto out_unlock;
+
+	/*
+	 * Drop the kernel AUX-owner reference; writers are refused once it
+	 * reaches zero (perf_aux_output_begin()).  Since concurrent
+	 * releases serialise on mmap_mutex and setup rejects a second
+	 * buffer with -EBUSY, the count can only be 1 here.
+	 */
+	WARN_ON_ONCE(!refcount_dec_and_test(&rb->aux_kernel_count));
+
+	/*
+	 * Stop all AUX events writing to this buffer so the pages can be
+	 * freed; the aux_mutex serialisation matches perf_mmap_close().
+	 */
+	mutex_lock(&rb->aux_mutex);
+	perf_pmu_output_stop(event);
+	rb_free_aux(rb);
+	WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
+	mutex_unlock(&rb->aux_mutex);
+
+	/*
+	 * Detach the buffer from the event.  ring_buffer_attach(event, NULL)
+	 * drops the event->rb reference itself (the allocation reference
+	 * transferred by perf_event_setup_aux()), so no extra
+	 * ring_buffer_put() is needed here.
+	 */
+	ring_buffer_attach(event, NULL);
+
+out_unlock:
+	mutex_unlock(&event->mmap_mutex);
+}
+EXPORT_SYMBOL_GPL(perf_event_release_aux);
+
 static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
 {
 	/* The first page is the user control page, others are read-only. */
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index c03c4f2eea57..760b7659ad87 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -48,6 +48,12 @@ struct perf_buffer {
 	int				aux_nr_pages;
 	int				aux_overwrite;
 	refcount_t			aux_mmap_count;
+	/*
+	 * In-kernel AUX owner reference, set by perf_event_setup_aux():
+	 * admits writers and ties the AUX teardown to
+	 * perf_event_release_aux() when no userspace mmap holds the buffer.
+	 */
+	refcount_t			aux_kernel_count;
 	unsigned long			aux_mmap_locked;
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 1b1ffe0533e5..eae28e42346c 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -395,14 +395,17 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 		goto err;
 
 	/*
-	 * If aux_mmap_count is zero, the aux buffer is in perf_mmap_close(),
-	 * about to get freed, so we leave immediately.
+	 * If no AUX owner remains, the buffer is in perf_mmap_close() or
+	 * perf_event_release_aux(), about to get freed, so we leave
+	 * immediately.  aux_mmap_count tracks user-space mmap owners;
+	 * aux_kernel_count tracks in-kernel owners (perf_event_setup_aux()).
 	 *
-	 * Checking rb::aux_mmap_count and rb::refcount has to be done in
+	 * Checking the AUX owner counts and rb::refcount has to be done in
 	 * the same order, see perf_mmap_close. Otherwise we end up freeing
 	 * aux pages in this path, which is a bug, because in_atomic().
 	 */
-	if (!refcount_read(&rb->aux_mmap_count))
+	if (!refcount_read(&rb->aux_mmap_count) &&
+	    !refcount_read(&rb->aux_kernel_count))
 		goto err;
 
 	if (!refcount_inc_not_zero(&rb->aux_refcount))
-- 
2.43.0

