Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5133AA518
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719012; cv=none; b=Su5877TNiE6SFXVZCyPc8Qkkgf5hWVpIxDxjtZ3lO+wvUy+ouY22FP6jyjwOepxE0pYgfY7LEQz4mRIyRUCcIdHNg79WyONT4ainRzzjIF3b7uxT8anJPGAJ+0OdFbdbsNLV4KoC8EcqZBxU0kXCDpTBclYrf64ITXRWZxyQqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719012; c=relaxed/simple;
	bh=Itv9jQ+cgGREh7F3gB7lH8k0MiTigkyXyaA+k+YNoBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzjNtPLdkB5wyYs/J4xLMqQyBXSH7n6Ca3fHx6AMMre7RgsHg3wrOpaLlh8H1fu3KRKYS3IDsCXWzI3lQy33K+eBV1yLgX0gjM4bdpFeEkSkbW9rJ2MCl9CNkFcBBM5JjYxb/Ca7Zx9gWcrc0sX9Dj6fYQdO/aMm8bWVDuW5+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF/xIHUM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF/xIHUM"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1604225a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786719008; x=1787323808; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=smhmlaujxPVhf53l9bjkItlTOWCewUbQLVL+UUzYPD8=;
        b=IF/xIHUMXKzYzpKmqrU6DomAx98F2w6HdGe3QWZKn0PtcBIGjP/JuAJdLeWWpFw3FN
         48aRym2PP1zusv1jComkJ87C0PXGLohUEC6DcTni+q2qbBTJB28mC0FLuU4nASmeB6H9
         uqO2wmzV9Zg3o3/SbdE5nMfa54dGLHcCyYoImL0VdxvsSnxoX60DaBDbVtWp2ERZeKF/
         dEsBvuZedEGkXbzM+KYuhkLRpeVjBz5tIY+GI2Cf82rduiTEhtijpgAp3Kh1fN+SylbQ
         XlxnQfV4U8avMlYczHrsdqux3RQ1XRNPmxtog6nAaWpHUcp1TLZICB3297Qlctl4dGXT
         9esA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786719008; x=1787323808;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=smhmlaujxPVhf53l9bjkItlTOWCewUbQLVL+UUzYPD8=;
        b=VuXag4PTWJwRc/ssqtRGxA/nrW1f7abmDr9fhkIfOTROmdyaL1nieJNGAwsihNM6IZ
         +pgvQSSysESQsZbE68BEd//NoYWIC3NmGHoElQatmh9VsYfgXbm8rfLI+YN1Qt/lko0V
         h7aN+t9i4QieRbiKw3my+CK8mHf95XdYyMxhWyfozNgwkg3lKnP8gj7RTZt9Cwurc1eA
         ey9fPNwaHf7otaX4NFllqg/oZ3GcskmpZzP8WMjb4EbWQ8dwUFymBUt0Gsd9yNNF6mzd
         leQqe4xMOcSLGA8ElDOmK+2KOoby2VfUEpnTq5gmXARC1TmpUxdxzkJXfI4TO2L5tD0a
         weDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTzeQb2qR5risjPa+5DvpvymlZK4ttj4QH6AyvnfABujwmLnj2yKPFgOG5S47tUeSSZXUGtxwGK01jX4ZD6Azs@vger.kernel.org
X-Gm-Message-State: AOJu0YyJzyM34Er24VtX2BluiclPTodvsfclxM0hhtSxlh56ETz5V8pF
	rfWQjiMcrp/866LzZ/VOn4rY9m7bARBadm2UZR5CXJeZzYjvRoX4N/Vw
X-Gm-Gg: AR+sD103AbR/ZasRXG8EiNvI1kWRMR2uvqvwcIlpOxnlmoc+bmniFOA7J2sLCfpWwAY
	GSK/kXVp1qGkoQftVyUtZCpL6/D4YPRu8NS7EBKbOXjATbM7UpBrHYaiNVeKMZmn1zUhXp/7BGB
	eR84h7jycjjXwPyjkdMqHQJ/r3wYzg8KmG+4eOJ2+FsBwRTQth6Xj5L7X+M0vR2L+CgszrKNaKs
	hQ80lFxtJpMFvfA+bvkCCAJY85aqN7QFEmomCPZWGC9Mz18VieADkQjsU1Gev+bhJ4HhZ62Ndto
	aYDwz+Z2zrYSKJbPXSnptxCqehHS7V47hiUlgXvkeYa9xFnKfZOFwKzvKmqtzbSixGNUnGFE5nG
	amjq05BybCJUSgEdMbZyAvq4ZkB1uWd/I/j5LEeZKvhV3RCkpofnyToyqUEODTuEkR1AzxSrIBw
	yKB/nAgnIoibGA41hzaGjdlMedg3cQcW/k34q2PAY6rJTFsgvidenWstG2DkzuOPEWMIJql4NaT
	rtT2d7tYwcS
X-Received: by 2002:a17:90b:1b43:b0:38e:9ca8:e99 with SMTP id 98e67ed59e1d1-3933af8b5d7mr4735892a91.5.1786719007234;
        Fri, 14 Aug 2026 07:50:07 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b626d4esm1518950a91.2.2026.08.14.07.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:50:06 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: corbet@lwn.net,
	skhan@linuxfoundation.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	kunwu.chan@gmail.com,
	lianux.mm@gmail.com
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sj@kernel.org
Subject: [RFC PATCH 2/5] perf/core: add AUX ring accessors for kernel consumers
Date: Fri, 14 Aug 2026 22:49:18 +0800
Message-ID: <20260814144927.489172-3-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814144927.489172-1-kunwu.chan@linux.dev>
References: <20260814144927.489172-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

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
Documentation/userspace-api/perf_ring_buffer.rst (§3.4).

Co-developed-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../userspace-api/perf_ring_buffer.rst        |  56 ++++-
 include/linux/perf_event.h                    |   7 +
 kernel/events/ring_buffer.c                   | 194 ++++++++++++++++++
 3 files changed, 256 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/perf_ring_buffer.rst b/Documentation/userspace-api/perf_ring_buffer.rst
index dc71544532ce..8333d2791878 100644
--- a/Documentation/userspace-api/perf_ring_buffer.rst
+++ b/Documentation/userspace-api/perf_ring_buffer.rst
@@ -26,6 +26,7 @@ Perf ring buffer
     3.1  The relationship between AUX and regular ring buffers
     3.2  AUX events
     3.3  Snapshot mode
+    3.4  Kernel-consumer AUX buffer access
 
 
 1. Introduction
@@ -827,4 +828,57 @@ mode.
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
+    never had an AUX buffer (no-op).  A ring buffer not owned by the
+    kernel AUX API is left attached.
+
+  - ``perf_event_aux_head(event)`` — read the published producer
+    head.  Returns 0 if the event has no ring buffer.
+
+  - ``perf_event_aux_tail_set(event, tail)`` — advance the consumer
+    tail.  The new tail must be within the current ``[old_tail,
+    head]`` window; an out-of-range tail is rejected with ``-EINVAL``.
+
+  - ``perf_event_aux_copy(event, from, to, buf)`` — copy a possibly
+    wrapped AUX interval into a linear buffer.  The ``from``/``to``
+    cursors are absolute and must lie within ``[tail, head]``.
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
index 4070a725d21f..800638f70628 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1265,6 +1265,13 @@ extern int perf_event_setup_aux(struct perf_event *event, int nr_pages,
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
index be57007a1b79..6608df879d7f 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -580,6 +580,200 @@ void *perf_get_aux(struct perf_output_handle *handle)
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
+ * @tail:	New absolute tail; must be within the current AUX window.
+ *
+ * Frees the consumed space so perf_aux_output_begin() can compute space
+ * again for the PMU writer.  The new tail must refer to a valid position
+ * within the current AUX window (the last ring of produced data); an
+ * out-of-window tail would corrupt the free-space computation in
+ * perf_aux_output_begin() and let the producer overwrite unconsumed data.
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
+	/*
+	 * Pairs with the producer's AUX-data write barrier in
+	 * perf_aux_output_end() before it publishes aux_head.
+	 */
+	smp_rmb();
+	head = READ_ONCE(rb->user_page->aux_head);
+	advance = tail - old_tail;
+
+	/* Modular distances keep the check valid when a cursor wraps. */
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
+ * copied, or -errno.  The window must not exceed the ring size; this is
+ * enforced below, so a buggy consumer cannot silently read garbage.
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
+	 * AUX storage may be referenced from both producer and consumer
+	 * contexts (see rb_alloc_aux): a concurrent perf_event_release_aux()
+	 * may free it once the last writer drops the AUX reference.  Keep
+	 * it alive for the duration of the copy.
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
+	 * Validate modular distances before masking.  The requested window
+	 * must be wholly contained in the current [tail, head] interval;
+	 * this rejects rewound, already-consumed, and future cursors while
+	 * remaining correct across unsigned cursor wrap.
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

