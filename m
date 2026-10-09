Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195424D37CB
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Oct 2026 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791561662; cv=none; b=Ok141BnwN53dMsvmTrRHr9KEWKi2y9M0uxcjBDzvfC3X8lOSWfu/bwxboKVN9XvGH7Ew1P7aV8TLQNKMEgwyW2hr9ky+OlFoFKhbJ5mRbXqSDM9v1l3LxiSPCeuBaTGsd4+ZwrTQgtWhQlBgv3nNrNxAJ6vvaOsy/7v5Bu5RjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791561662; c=relaxed/simple;
	bh=Bzd1n8PNBPkwLZSceQok9BksM2v54TrmAZZOfIplMhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT5J8970huL8mBuMEERail5I5QsLh4EiDR+mxbC2YQLwqv/NO3E8LZlqOygsCQ1bi6VqmSRoTwNPffSjMrgoDsPnTs9UfheL8+KmVg2QHPF3R37P45fNVbqwUL0PNlhQxlUSxI4PNfV/UHWDV/Lkyhwlg028MMaE1xwXCwnpEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbQ6G9J/; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbQ6G9J/"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e6038cebefso27098695ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Oct 2026 09:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791561659; x=1792166459; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JdCwLDZTjwAmZVg/6y5GzBZEqQlqfc3xCna0j1e/A5I=;
        b=qbQ6G9J/HycOC6tUDg7ryg/KFY8InS3vO7ZuhZqo92bGWEALmUw9ivM5CtUnlVFQvi
         LHvMhO8qPdyc0vUu6cNYD0RIkLb43Q5HwomVhE+OHwuPjZ2B5poPYCOFWom/2/DGxdts
         e8jNoTKtySiRj9fBh8OX2a4zTdJR07wZOMs2f/wVvg90j6PKX52qWtWarH/jQCgPnZXc
         oH5HleMy+pyGYp3ZCJ1Pnfifj79aLytfQeJCIt/TlLYdNX85jdgWgwxwEiFzsNgYhNZU
         eBJrnB7VtY/ls5p4uF3P95fViF+R/7Qokv6Ho+yXwDN/VszrehBlimDbypbWHQQvHJhS
         MWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791561659; x=1792166459;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JdCwLDZTjwAmZVg/6y5GzBZEqQlqfc3xCna0j1e/A5I=;
        b=N5CD+4gRw0lp5Yg+lp7IbHpacFZp3f2fHmY6Nxd018XprFQucPH9LVG7Rv9xitR5uh
         ONASB5HSmzyK/2UxfJfpBgtVJMBFxoUXKT8lbYz0P6oofnkuvSD3ASmtdhoe8zgIZREw
         t5kDIp5nBfsEMF2esEPw9hQ7icLR94vRMKwGl8f6DNC4NrT4AW2SXVztH2/+jPqFPUpc
         kJnTFqkbQfZURg+VQlB5+JOIrsD7zI3sV3rxHxl4ib1r40a6mPm53479GEj+Jnc0a0IA
         3l95etvhm1H5iW5X6v2vO1IHAieZFjxT6aMPHbqabIfA9iWKz6bIYlN2pHQUiNZSHtf5
         zo8w==
X-Forwarded-Encrypted: i=1; AKwUvBy7OZKdDj6Q1jKHbTxSuamOoOtPTJj7fzq0sVe2+ud3tMDdxlhvrvGH43DMTSAkHVvXZ70lRpsOF4AhcG5vh+mJ@vger.kernel.org
X-Gm-Message-State: AFq9FYJpO/rauDE42IoBRX5OfCiZnK6T8h1WCdvTyBz2sadT3mJH+yrN
	JpGrMaBQsL3sn7opSb2lcT+3SXwsXgDLLJpOScQ8/jCOrQHjOmr7NPPG
X-Gm-Gg: AYBFou0b0sNyjluDUiFJL/+dygGq1KhXv/N2iRhN9fNMl06cQHNWA1DB6c2KUuJgMOL
	klW1IoudEQju5EiuDih0XgRlQJcxfhisBQWsXs1XtZFDI1zBZ6AvsBH2kD/2p2q6vPFw7RQ5C9D
	f6QnOJCWhkI14TfrUYCE/NFl+snJhnYpdHRaa6bhyunGtmSxZ+noUvxgN5XwpaqCmaHEj/K8Hku
	68NNZmEArnjcQRl85BODbIT8AWB3fT9DnO9cXNGpAGpK+ca9cVsIlu8i8X/chGXqY7ZcXFVEqYj
	qUyQ+Gq/ztnTvP1F4cRnsk7LXEGqss4v2MfhRMji/MVAtx6yjyScaDCRaUR2CKeHNw8qOc4PP2E
	jNO6CVPI6k076/6M9PUt4SXwwXEtpnjEUlVJYerrFsQNwRdVqS995/nLtXm6XjK0qwQFS0bWWOn
	BZHDsrXzz1s4KSRvLac0D+9aLIoynMPYKESd84VYaSzbTz24WKO44nc6jEqu03n/Q5LK7XoL6do
	hw/ZPvBjIgci/+xVdDU/jJKlhS6TJnn7AiCIBO8
X-Received: by 2002:a17:902:f612:b0:2e6:29bc:73b6 with SMTP id d9443c01a7336-2e842bbf51emr21218695ad.45.1791561658866;
        Fri, 09 Oct 2026 09:00:58 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422b8cb6sm12333235ad.60.2026.10.09.09.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:00:58 -0700 (PDT)
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
Subject: [PATCH v2 2/5] perf/core: add AUX ring accessors for kernel consumers
Date: Fri,  9 Oct 2026 23:59:49 +0800
Message-ID: <20261009160010.1829642-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009160010.1829642-1-kunwu.chan@gmail.com>
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add kernel-consumer accessors for the published AUX producer head, the
consumer tail, and copying a possibly wrapped AUX interval without exposing
perf's internal page array.

Use the same memory ordering as mmap consumers: order data reads after the
published head with smp_rmb() and order completed data reads before
advancing the tail with smp_mb().  Validate cursor distances in the
absolute cursor domain before applying the ring mask, so rewound,
already-consumed, and future windows are rejected even across unsigned
cursor wrap.

Hold an AUX reference while copying so storage cannot disappear under the
consumer.  Restrict the helpers to buffers owned by the kernel AUX setup
API.  Document the API in
Documentation/userspace-api/perf_ring_buffer.rst.

Co-developed-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../userspace-api/perf_ring_buffer.rst        |  62 +++++-
 include/linux/perf_event.h                    |   7 +
 kernel/events/ring_buffer.c                   | 203 +++++++++++++++++-
 3 files changed, 270 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/perf_ring_buffer.rst b/Documentation/userspace-api/perf_ring_buffer.rst
index dc71544532ce..206c57ee6c35 100644
--- a/Documentation/userspace-api/perf_ring_buffer.rst
+++ b/Documentation/userspace-api/perf_ring_buffer.rst
@@ -26,6 +26,7 @@ Perf ring buffer
     3.1  The relationship between AUX and regular ring buffers
     3.2  AUX events
     3.3  Snapshot mode
+    3.4  Kernel-consumer AUX buffer access
 
 
 1. Introduction
@@ -827,4 +828,63 @@ mode.
          |                 AUX Ring buffer 3     | <- aux_head
          +---------------------------------------+
 
-                Figure 9. Snapshot with system wide mode
+                 Figure 9. Snapshot with system wide mode
+
+3.4 Kernel-consumer AUX buffer access
+-------------------------------------
+
+The AUX ring buffer is normally consumed from user space via mmap()
+on the perf event fd.  Some tracing PMUs (e.g. ARM SPE) write trace
+records directly to the AUX buffer without generating a
+perf_event_overflow() callback for each record.  A kernel consumer
+therefore needs to own and drain the AUX buffer itself rather than
+rely on the overflow path.
+
+The perf core provides five exported functions for in-kernel
+consumers that do not have a user-space mmap:
+
+  - ``perf_event_setup_aux(event, nr_pages, watermark)`` — allocate
+    an AUX ring buffer for a kernel-created perf event.  The event
+    must be created by ``perf_event_create_kernel_counter()``; it
+    must not have a parent or an existing ring buffer.  ``nr_pages``
+    must be a power of two and ``watermark`` must be non-negative
+    (0 selects half the buffer).
+
+  - ``perf_event_release_aux(event)`` — tear down the AUX buffer
+    allocated by ``perf_event_setup_aux()``.  Must be called before
+    ``perf_event_release_kernel()``.  Safe to call on an event that
+    never had an AUX buffer, and on one whose buffer was already
+    released (no-op).  A ring buffer not owned by the kernel AUX API
+    is left attached.  The whole teardown is serialised on the
+    event's mmap mutex, so concurrent callers on the same event are
+    safe: one performs the teardown and the others return.
+
+  - ``perf_event_aux_head(event)`` — read the published producer
+    head.  Returns 0 if the event has no ring buffer.
+
+  - ``perf_event_aux_tail_set(event, tail)`` — advance the consumer
+    tail.  The new tail is an absolute cursor: it is accepted only
+    within the current produced window, not ahead of the published
+    producer cursor and no more than one buffer size behind it; an
+    out-of-range tail is rejected with ``-EINVAL``.
+
+  - ``perf_event_aux_copy(event, from, to, buf)`` — copy a possibly
+    wrapped AUX interval into a linear buffer.  The ``from``/``to``
+    cursors are absolute and must lie between the consumer cursor
+    (``tail``) and the published producer cursor (``head``).
+
+The owner reference is tracked by ``aux_kernel_count`` on the
+``perf_buffer``, separate from the userspace ``aux_mmap_count``.
+``perf_aux_output_begin()`` admits a writer while either owner
+count is non-zero, so a kernel consumer and a userspace consumer
+on different events for the same PMU do not interfere.
+
+A userspace mmap and a kernel ``perf_event_setup_aux()`` on the
+*same* event cannot coexist: the second call finds ``event->rb``
+already set and returns ``-EBUSY``.
+
+Memory ordering follows the same protocol as the userspace AUX
+mmap consumer: ``perf_event_aux_head()`` uses ``smp_rmb()`` to pair
+with the producer's data-write barrier before publishing ``aux_head``,
+and ``perf_event_aux_tail_set()`` uses ``smp_mb()`` to order prior
+data reads before advancing ``aux_tail``.
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 78fd2ed11fcf..0d96145f75ed 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1266,6 +1266,13 @@ extern int perf_event_setup_aux(struct perf_event *event, int nr_pages,
 				long watermark);
 extern void perf_event_release_aux(struct perf_event *event);
 
+/* AUX ring accessors for kernel consumers (no user-space mmap). */
+extern unsigned long perf_event_aux_head(struct perf_event *event);
+extern int perf_event_aux_tail_set(struct perf_event *event,
+				   unsigned long tail);
+extern long perf_event_aux_copy(struct perf_event *event, unsigned long from,
+				unsigned long to, void *buf);
+
 extern void perf_pmu_migrate_context(struct pmu *pmu,
 				     int src_cpu, int dst_cpu);
 extern int perf_event_read_local(struct perf_event *event, u64 *value,
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index eae28e42346c..8995a496bc60 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -398,7 +398,8 @@ void *perf_aux_output_begin(struct perf_output_handle *handle,
 	 * If no AUX owner remains, the buffer is in perf_mmap_close() or
 	 * perf_event_release_aux(), about to get freed, so we leave
 	 * immediately.  aux_mmap_count tracks user-space mmap owners;
-	 * aux_kernel_count tracks in-kernel owners (perf_event_setup_aux()).
+	 * aux_kernel_count tracks the in-kernel AUX owner
+	 * (perf_event_setup_aux()).
 	 *
 	 * Checking the AUX owner counts and rb::refcount has to be done in
 	 * the same order, see perf_mmap_close. Otherwise we end up freeing
@@ -585,6 +586,206 @@ void *perf_get_aux(struct perf_output_handle *handle)
 }
 EXPORT_SYMBOL_GPL(perf_get_aux);
 
+/*
+ * perf_event_aux_head()/perf_event_aux_tail_set()/perf_event_aux_copy() -
+ * AUX ring accessors for kernel consumers (e.g. DAMON's ARM SPE backend).
+ *
+ * The write cursor rb->aux_head is maintained by the PMU driver via
+ * perf_aux_output_end(), which also publishes it to user_page->aux_head;
+ * the consumer cursor lives in user_page->aux_tail (same absolute cursor
+ * domain).  The kernel consumer has no mmap, so these are the counterpart
+ * of the user-space mmap protocol.
+ *
+ * As in the user-space protocol, data visibility is the producer's duty:
+ * the PMU driver must make AUX data visible before calling
+ * perf_aux_output_end(), which then publishes the new head.  Kernel
+ * consumers use the same read- and full-barrier ordering as mmap consumers.
+ */
+
+static bool rb_has_kernel_aux(struct perf_buffer *rb)
+{
+	return rb_has_aux(rb) && refcount_read(&rb->aux_kernel_count);
+}
+
+/**
+ * perf_event_aux_head() - Return the event's absolute AUX write cursor.
+ * @event:	Event with an AUX buffer (perf_event_setup_aux()).
+ *
+ * Returns the current rb->aux_head, or 0 if the event has no ring buffer.
+ */
+unsigned long perf_event_aux_head(struct perf_event *event)
+{
+	struct perf_buffer *rb = ring_buffer_get(event);
+	unsigned long head = 0;
+
+	if (rb && rb_has_kernel_aux(rb)) {
+		head = READ_ONCE(rb->user_page->aux_head);
+		/* Pairs with the producer's AUX-data write barrier. */
+		smp_rmb();
+	}
+	if (rb)
+		ring_buffer_put(rb);
+	return head;
+}
+EXPORT_SYMBOL_GPL(perf_event_aux_head);
+
+/**
+ * perf_event_aux_tail_set() - Advance the event's AUX consumer cursor.
+ * @event:	Event with an AUX buffer.
+ * @tail:	New absolute consumer cursor.
+ *
+ * Frees the consumed space so perf_aux_output_begin() can compute space
+ * again for the PMU writer.  @tail is an absolute cursor: it is accepted
+ * only within the current produced window, i.e. not ahead of the
+ * published producer cursor and no more than one buffer size behind it;
+ * a tail outside that window would corrupt the free-space computation
+ * in perf_aux_output_begin() and let the producer overwrite unconsumed
+ * data.
+ *
+ * If a non-overwrite buffer becomes full, the producer may be stopped;
+ * advancing the tail alone does not resume it, and the consumer is
+ * responsible for re-enabling the event if needed (as user-space AUX
+ * consumers do).
+ *
+ * Returns 0 on success, -ENOENT if the event has no ring buffer, -EINVAL
+ * on an out-of-range tail.
+ */
+int perf_event_aux_tail_set(struct perf_event *event, unsigned long tail)
+{
+	struct perf_buffer *rb = ring_buffer_get(event);
+	unsigned long advance, aux_size, head, old_tail;
+	int ret = -EINVAL;
+
+	if (!rb)
+		return -ENOENT;
+
+	if (!rb_has_kernel_aux(rb)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	aux_size = (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
+	old_tail = READ_ONCE(rb->user_page->aux_tail);
+	head = READ_ONCE(rb->user_page->aux_head);
+	advance = tail - old_tail;
+
+	/*
+	 * Validate modular distances before masking.  No barrier is
+	 * needed between the two cursor reads: the accepted tail is
+	 * always bounded by a sampled head value, and head only
+	 * advances, so the producer never observes tail > head
+	 * regardless of the order the samples arrive in.
+	 */
+	if (head - old_tail <= aux_size && advance <= head - old_tail) {
+		/* Order all prior AUX data reads before releasing the space. */
+		smp_mb();
+		WRITE_ONCE(rb->user_page->aux_tail, tail);
+		ret = 0;
+	}
+
+out:
+	ring_buffer_put(rb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(perf_event_aux_tail_set);
+
+/**
+ * perf_event_aux_copy() - Copy an AUX window into a linear buffer.
+ * @event:	Event with an AUX buffer.
+ * @from:	Absolute start cursor (inclusive).
+ * @to:		Absolute end cursor (exclusive).
+ * @buf:	Destination; must hold (to - from) bytes.
+ *
+ * Handles wrap-around within the ring.  Returns the number of bytes
+ * copied, or -errno.  The requested window is validated in the
+ * absolute cursor domain -- between the consumer cursor and the
+ * published producer cursor, and not larger than the ring -- before
+ * the cursors are converted into ring offsets.
+ */
+long perf_event_aux_copy(struct perf_event *event, unsigned long from,
+			 unsigned long to, void *buf)
+{
+	struct perf_buffer *rb = ring_buffer_get(event);
+	unsigned long aux_size, available, head, len, start, tail, tocopy;
+	long ret;
+
+	if (!rb)
+		return -ENOENT;
+
+	if (!rb_has_kernel_aux(rb)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	/*
+	 * The AUX pages have a lifetime of their own, governed by
+	 * aux_refcount (see rb_alloc_aux): producers and consumers can both
+	 * hold references, and a concurrent perf_event_release_aux() drops
+	 * the owner's.  Take one for the duration of the copy.
+	 */
+	if (!refcount_inc_not_zero(&rb->aux_refcount)) {
+		ret = -ENOENT;
+		goto out;
+	}
+
+	if (!buf) {
+		ret = -EINVAL;
+		goto out_aux;
+	}
+
+	aux_size = (unsigned long)rb->aux_nr_pages << PAGE_SHIFT;
+	tail = READ_ONCE(rb->user_page->aux_tail);
+	head = READ_ONCE(rb->user_page->aux_head);
+	/* Pairs with the producer's AUX-data write barrier. */
+	smp_rmb();
+	available = head - tail;
+	start = from - tail;
+	len = to - from;
+
+	/*
+	 * Validate modular distances before masking: the requested window
+	 * must be wholly contained between the consumer cursor and the
+	 * published producer cursor.  This rejects rewound, already
+	 * consumed, and future cursors while remaining correct across
+	 * unsigned cursor wrap.
+	 */
+	if (available > aux_size || start > available ||
+	    len > available - start) {
+		ret = -EINVAL;
+		goto out_aux;
+	}
+	if (!len) {
+		ret = 0;
+		goto out_aux;
+	}
+
+	from &= aux_size - 1;
+	to &= aux_size - 1;
+	ret = 0;
+
+	do {
+		tocopy = PAGE_SIZE - offset_in_page(from);
+		if (to > from)
+			tocopy = min(tocopy, to - from);
+		if (!tocopy)
+			break;
+
+		memcpy(buf + ret, rb->aux_pages[from >> PAGE_SHIFT] +
+		       offset_in_page(from), tocopy);
+
+		ret += tocopy;
+		from += tocopy;
+		from &= aux_size - 1;
+	} while (to != from);
+
+out_aux:
+	rb_free_aux(rb);
+out:
+	ring_buffer_put(rb);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(perf_event_aux_copy);
+
 /*
  * Copy out AUX data from an AUX handle.
  */
-- 
2.43.0

