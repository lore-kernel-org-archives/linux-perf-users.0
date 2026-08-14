Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672F35AC00
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 14:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719000; cv=none; b=ZUGEnY0FLlPzCuXHXYbJY69p5jlyRTOTHGEbNhtalAfzZihtC5h/IDQEjUr3Xv3g8jVz3gesz4aTpL3PWxUGXHgRFXfmBMdehvP2Hd45ztY4KVFhQHcR3UPObqazpaw3JfAXq1SuOUdEUu2FSqzfgoJWWLLLL0aUKjxFKDaFaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719000; c=relaxed/simple;
	bh=/G6o9JLaKwM+MWYO5ioYvbKdLCB6G/l0+lyvvQiDPVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1CYyUa39+sUAsAjmK9D3g/0C3AFtOjjZ2eFT9IefJkCoTdmXySgz+nCQtZMoO4TnqmghKQG5O9pXVKPY9PEp/hECmyBW4yNTQ/NEBs3R821jDPmpfbN8k/Ne44/1fhD2HV1AvNp/sprzCC2iJljcYx5YiQ2DM5KZ+jsyk6bhhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCAJ/nBz; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCAJ/nBz"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1074457a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786718998; x=1787323798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VA+T8Kw/D1l+kXKHMVf0JC+Q03Y5VzQaUlRgdX/Okfc=;
        b=MCAJ/nBz/powPMzXZqnd3jzk8g2VgSNPeMJuSbAi/ev44KSF7921TGaKJCkgArvWzV
         Nb/b6BZGkFRkN1yy9HsJi6Yu2dU/ksBVdEfUzM2Cl063eZHn9wmthJbRFysYMw2BW4d3
         ogBPmYk8G6DJA5EwPrRpl0OlsR1u4fCRjUKFVPcYho4bA6sDgcX0C1Fy5G21lyzk2fFd
         cW8avnhfM7aieUwcdtEjTty5OdZiqfzq8lmbaHj5BHBzryulRS68kXyndwXQWdSzdSMS
         DIb85MJvy1ZMghB9rdY640yaH5xh1++jSeGWLYn/co33RWZYqy/z/183xefPcVMfmMOz
         NgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786718998; x=1787323798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VA+T8Kw/D1l+kXKHMVf0JC+Q03Y5VzQaUlRgdX/Okfc=;
        b=Q1fDF/uInwnvscshDwqkNZM83Hx5Enx0Hn8oD7s+BouIfO2CH1gtijY7vXIbAFeh29
         /npT5BzKL2iiZ4BaoILkSwyBxMZx3SiXlepe0hr3drD6xjA5B8Dg/tV2Xgnvs4SdUoEH
         v1D70I1wLWGJY+K9xR6Go3ZiCTfT4rT3T8Pf+J5ZVBqaIEGOnfpWw56rcPTTvEQJ8aPe
         dAIkzMJDe4ok22VyPa+2+lNxCt3tkWBqs6Qc9gTY3ocI7yNPGedHy+TXNqtjQ5twLAwt
         0nlN95wRiJUpLGJw2jng9l+neEJSHbAdX6XrWHPxT5Xh1pO+B2RdJu7o5APGDDxyFN43
         aUgA==
X-Forwarded-Encrypted: i=1; AHgh+RqfrVBBBfva4rXQbh1IKATY0I677EpiN9PJW0R3QVeOpocw7KrdlPcp8KdSLLfglGzr/r+xil7030iSdgJ6FZGL@vger.kernel.org
X-Gm-Message-State: AOJu0YwVQfdniqKv5sRPTZgFrJL5Sg8f7LXQkbx+rErvJbEhlTcbQdku
	48A+UBtB9QbpQibz94sBAZ0Fd8l2MVXBFFPLLbMBAVkDtKPDhQnn/9r/
X-Gm-Gg: AR+sD125+7hHKWKCLkzfQ6lE0MKZ+O1BLm9duu8x4FdmTcQ41RWvrT9o1B35jno8d94
	JV0EskdfDoBR+3DJh8zOBrDRhxAJhpb3N8f/JQLNx6tt2HUnS/yOR5j14/Mp3na2nSukHKnOLeK
	mznhsC+ZKoAhrtMrdgO7OAR39l0V5YFTjR8mzzA9Ifp2t+OdbJUdzTbLsZ/u0v8cuTx6gW/8j92
	1cfyYoCF2k/bDJ7oJSLXLiOxxWX5earjEKM6KdC/Ji8bCi8nkN8iuhzuui7Px8tQSEe9g+ac2V7
	EqqmbZXPSYFik5vbl6xjYGwfl7mllOisUU6lBAldEY4ixePTSWMT7toOGlZdr9cGZx0TdvISAJY
	b8RQshx2KZ9AeeBOt9v3vtHDwu5zK0CViNFDubzleDDDABIoEcZITXVE9gHR9KJ1tIbMyfiCEmq
	sfnrq45IYAM4oIkf0qNC/sd5Judpf5T1YgAC1gBThi0P+buVxOLmBq7VwMphw5kq9JJ97GTDTEv
	flxrn4=
X-Received: by 2002:a17:90a:e7c1:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-3933ed1ba09mr6645950a91.19.1786718997674;
        Fri, 14 Aug 2026 07:49:57 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933b626d4esm1518950a91.2.2026.08.14.07.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:49:57 -0700 (PDT)
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
Subject: [RFC PATCH 1/5] perf/core: add AUX buffer ownership for kernel events
Date: Fri, 14 Aug 2026 22:49:17 +0800
Message-ID: <20260814144927.489172-2-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260814144927.489172-1-kunwu.chan@linux.dev>
References: <20260814144927.489172-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

Add an in-kernel AUX owner reference and setup/release helpers for
kernel-created perf events that need an AUX buffer without a userspace
mmap.  The setup path validates that the event is a kernel event with
no parent, rejects non-power-of-two page counts and negative watermark
values, allocates the perf buffer and AUX pages, records the kernel
owner, and attaches the buffer through the existing mmap-serialized
helper.  The release path stops AUX writers, frees AUX storage, drops
the event->rb reference via ring_buffer_put(), and detaches only buffers
owned by this API.

Keep aux_mmap_count dedicated to userspace mappings.
perf_aux_output_begin() accepts a writer while either a userspace or kernel
owner remains, preserving the existing teardown ordering.

Co-developed-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Lian Wang (Processmission) <lianux.mm@gmail.com>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 include/linux/perf_event.h  |  11 +++
 kernel/events/core.c        | 139 ++++++++++++++++++++++++++++++++++++
 kernel/events/internal.h    |   1 +
 kernel/events/ring_buffer.c |  11 +--
 4 files changed, 158 insertions(+), 4 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 48d851fbd8ea..4070a725d21f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1254,6 +1254,17 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr,
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
index 4638544205f2..da6225ca144a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7122,6 +7122,145 @@ static void perf_mmap_close(struct vm_area_struct *vma)
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
+ * Safe to call with a missing rb (no-op).  A ring buffer not allocated by
+ * perf_event_setup_aux() is left attached.
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
+	rb = ring_buffer_get(event);
+	if (!rb)
+		return;
+
+	/* Do not detach a ring buffer that this API does not own. */
+	if (!rb_has_aux(rb) || !refcount_read(&rb->aux_kernel_count))
+		goto out_put;
+
+	if (refcount_dec_and_mutex_lock(&rb->aux_kernel_count, &rb->aux_mutex)) {
+		/*
+		 * Stop all AUX events writing to this buffer so the pages
+		 * can be freed; after aux_kernel_count drops to zero they
+		 * won't start any more (see perf_aux_output_begin()).
+		 */
+		perf_pmu_output_stop(event);
+
+		rb_free_aux(rb);
+		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
+		mutex_unlock(&rb->aux_mutex);
+	}
+
+	/*
+	 * Detach the ring buffer from the event.  This runs even if the
+	 * refcount_dec_and_mutex_lock above lost the race to another
+	 * concurrent release caller; the mmap_mutex serialisation and the
+	 * event->rb == rb check ensure only one caller performs the detach.
+	 */
+	mutex_lock(&event->mmap_mutex);
+	if (event->rb == rb) {
+		ring_buffer_attach(event, NULL);
+		ring_buffer_put(rb); /* drop the event->rb reference */
+	}
+	mutex_unlock(&event->mmap_mutex);
+
+out_put:
+	ring_buffer_put(rb); /* the temporary reference from ring_buffer_get() */
+}
+EXPORT_SYMBOL_GPL(perf_event_release_aux);
+
 static vm_fault_t perf_mmap_pfn_mkwrite(struct vm_fault *vmf)
 {
 	/* The first page is the user control page, others are read-only. */
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index c03c4f2eea57..7bcb60827514 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -48,6 +48,7 @@ struct perf_buffer {
 	int				aux_nr_pages;
 	int				aux_overwrite;
 	refcount_t			aux_mmap_count;
+	refcount_t			aux_kernel_count; /* in-kernel AUX owner */
 	unsigned long			aux_mmap_locked;
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 9fe92161715e..be57007a1b79 100644
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

