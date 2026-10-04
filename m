Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86747208F
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135326; cv=none; b=WQKnt614kgcXtah7VI5EkqcbSZ3rGx5Hp3hqwUht2uDzqtxjr1UZlzPaCvbG1mhEAHfy9olyrvLwgczuKT2qrkQPkvrvZxy6J9iDIxpZFEJdbFvpB9A3fX6aHNSFMhn0R9EhyJTxuOMJMidWIth88+HbukQnAOwSyJIAsXjhdDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135326; c=relaxed/simple;
	bh=A92TnaeD9sPotpS20FBYiuYY5aXwJuXXao6Lkoo66Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbxOpf/6Hgfyzu+J7PljG5WyDm/AB/HBg/B4XGFmcdjhiGcOTT11pH1SYhFPKZga8nKUps06gBxpGWhJTBPJQUi4XDZt4BLAgdGQEGlmXOA0QW5Ko0u9GNMKi76oaIWKSJLPdkSFnhU2j2jFPTQY4R/4vP6lB3B+DxloTl6Pc8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IiW0DxdI; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IiW0DxdI"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c6so465940b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Oct 2026 10:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791135317; x=1791740117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ucoKS5Z1NvmoX9tY0eQL9oK5ahppwH8SeQ2foxdCSmM=;
        b=IiW0DxdIZxl0JbqrvHp8rCKEy/rsQcDazedM3h49PV7Uq411Zvdpj6lMklfdWG4Wys
         FqO9MzoSeR0fbk6DkIdi50oAXU+bFSAOhqQcdpzGWsqg5dQCc44nm3zgW8Syozzw8wxt
         9VmbwkCAKhas1xG4h+N6QXmSwAPeX5i9yj8K+mie4ujHVGHf1X6zW2rkHeUJChn80xer
         tYkCWubZ+BTk29ffitr/yxdDoobDB2tz/fkXovMHh+kpWAW3M/q5AoO+jNtw89A/Yuym
         PLVH9veTDf2Iou0ntNAl636xkmQmPWLf3epp3aSdr16XRDFdpiQJvEteFegnV0+XMq2f
         cnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791135317; x=1791740117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ucoKS5Z1NvmoX9tY0eQL9oK5ahppwH8SeQ2foxdCSmM=;
        b=qi9PA8yzS1Nlnumy/zavgekXZIAiXQziXiHhPihw6UR+6tXdVIOpQbkMk0LlFGbsnB
         gNIdQhCyg8N3AIw86eaAoKtbab/Tty5ob0l/C9n1EOyNbfb4IbUA+0JGN9rq2FVGfwJ4
         11+WUTF43jNL8TLNhmCp6GE3kyWGa0RRNAheic+72JwllseOIwRFhgzrjl5rnM5bybhQ
         /Tps1ysuxFL0eZtJw07FldXBAPU3xSmbaWDEuTD5dcmzmhzAGhOQbldoeQ+P6KTHyEBy
         iH8NeoUFDEOdtt/YMGmErm1UwSN+o8P2ok67hRrEoAbVGjRB6398WguFVfs5tXsG7tZv
         EVBg==
X-Forwarded-Encrypted: i=1; AKwUvBzdUJFobRgMgZvK8sJYJw2KQ1zNSW5OfZiRCkOgkEPFf+vTHa3bUI4y0JLtAumr8G53MqEV5MyDG+GlQhkaYruk@vger.kernel.org
X-Gm-Message-State: AFuF++kGnbeOz9bUt9IANorjGcCOfA09aLz+KL9G8qU3t14bYIEXq+iU
	7fJRhQIdofYA13/XS0TZKbN19rlqCS9S15+T2B1NQfmTUpao7DaC8zoh
X-Gm-Gg: AYBFou2OwWba0S5Iw6tEyKKBN+MWcAYnhdsQdDaoKTNW1tuHeIN2KVYlA6uJxzLBL++
	uPcd1K+nLNzoTQPfqaD8Esu/IwLhbYFnzMUi+VhdlXcjYWeKV3vypkoCIltH5kNZ+Vui1MLwhRZ
	vVtfKPW8u8QpqacTjrwsh6jFOqb767pvAuysZJZuSuJVhVG4zpKkdYDcdKzHv7MSrt0JkWczzDy
	Tiho/OD0wb57AmoAztFhO9zDNZZpMuy1ijaevlLoXT6M+nOE7V2Aitg5NBksr/UPoAFWhXuVCAz
	tcMOuaL6D7ANN5jYrO+esNBErPI4wV1BQWguC5kSUcQTR9PfJdGys6dwkPVItOi3j7Ux9stEGSf
	EVDFjAluF7ea0AsCo1IIeLkF0W0QzZn2YcGu/CUe7a7Uw6d//2pz1WwXFxXZFU9UeMuQoQy2i74
	OQSn7uXtgGRi43dSG2iFzH80vN/O/J4rpeyk0DFJDSE1bTDBgukdiSrDYszBWRDlDjdXBUr5EER
	bBNIuI2wgNAgYFovGCyGI1NehHnHw==
X-Received: by 2002:a05:6a00:2350:b0:885:e434:76ec with SMTP id d2e1a72fcca58-88af86601a4mr7122808b3a.45.1791135316236;
        Sun, 04 Oct 2026 10:35:16 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d247930sm2678370b3a.54.2026.10.04.10.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:35:15 -0700 (PDT)
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
Subject: [PATCH 1/5] perf/core: add AUX buffer ownership for kernel events
Date: Mon,  5 Oct 2026 01:34:53 +0800
Message-ID: <20261004173458.837842-2-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261004173458.837842-1-kunwu.chan@gmail.com>
References: <20261004173458.837842-1-kunwu.chan@gmail.com>
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

Co-developed-by: Lian Wang <lianux.mm@gmail.com>
Signed-off-by: Lian Wang <lianux.mm@gmail.com>
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

