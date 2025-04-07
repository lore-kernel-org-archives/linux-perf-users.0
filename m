Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B3B227EAE
	for <linux-perf-users@vger.kernel.org>; Mon,  7 Apr 2025 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744016091; cv=none; b=L4bRQ4cFaItdvKsRf7krzPTcVYvR3S65PoiuhAOINkJSm/bN0Gct56aXhNHPtoOuf0Oy09rqfmoQx6U/6cfCQr+AMs14buP7RdoBGMbZzaWu3lpp6ydDOigdlNbrSyulW5MGtfPuxprvJssX5zr+2Ml7C3nyYJinMf2+AshVaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744016091; c=relaxed/simple;
	bh=S/krgJ47mHcWOwClo3HTb0co93o+dijfVcRLgxutwHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlwpGK7yBj0jneYc1nthOUXe9EzPqCsgXhdFLWjkoe5dXnnePSefCXiDVobNDw/ORDCjWDhY47EnGb0Tba9u25t8mL+LydzH1WPO8+8UXB8Paq6hc3KUyitnKQ48wuctrbWOCDSIf18X+L7AV93C4G3Jqisn8XgwUd2RcxtmYFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eCwmTJwu; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eCwmTJwu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744016086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uZTCm0LxWsnE3tYH357Upfibjs77OsM/NB9Y2oX27PE=;
	b=eCwmTJwuriVtW9CejDnYuY98GUudC4abWzVHy9TV+D7BtP+GbflTsGpyfc0MyEYJgdQ1CI
	LWJ3meLEcrI7BlwoQHM241nrKkwNN6T1W6A5yuKVIAzGAPUGWi1cU+FDs66nS67pJ2CfYY
	BvxW+WaWc40WmTORz7ew4G7QvGBqHCc=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ingo Molnar <mingo@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/x86: Rename local bts_buffer variables
Date: Mon,  7 Apr 2025 10:52:53 +0200
Message-ID: <20250407085253.742834-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Rename struct bts_buffer objects from 'buf' to 'bb' to improve the
readability when accessing the structure's 'buf' member. For example,
'buf->buf[]' becomes 'bb->buf[]'.

Indent line 327 using tabs to silence a checkpatch warning.

No functional changes intended.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- struct_size() change should be a separate patch as suggested by Peter
- Link to v1: https://lore.kernel.org/lkml/20250331122938.1837255-2-thorsten.blum@linux.dev/
---
 arch/x86/events/intel/bts.c | 144 ++++++++++++++++++------------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index a95e6c91c4d7..16bc89c8023b 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -80,54 +80,54 @@ static void *
 bts_buffer_setup_aux(struct perf_event *event, void **pages,
 		     int nr_pages, bool overwrite)
 {
-	struct bts_buffer *buf;
+	struct bts_buffer *bb;
 	struct page *page;
 	int cpu = event->cpu;
 	int node = (cpu == -1) ? cpu : cpu_to_node(cpu);
 	unsigned long offset;
 	size_t size = nr_pages << PAGE_SHIFT;
-	int pg, nbuf, pad;
+	int pg, nr_buf, pad;
 
 	/* count all the high order buffers */
-	for (pg = 0, nbuf = 0; pg < nr_pages;) {
+	for (pg = 0, nr_buf = 0; pg < nr_pages;) {
 		page = virt_to_page(pages[pg]);
 		pg += buf_nr_pages(page);
-		nbuf++;
+		nr_buf++;
 	}
 
 	/*
 	 * to avoid interrupts in overwrite mode, only allow one physical
 	 */
-	if (overwrite && nbuf > 1)
+	if (overwrite && nr_buf > 1)
 		return NULL;
 
-	buf = kzalloc_node(offsetof(struct bts_buffer, buf[nbuf]), GFP_KERNEL, node);
-	if (!buf)
+	bb = kzalloc_node(offsetof(struct bts_buffer, buf[nr_buf]), GFP_KERNEL, node);
+	if (!bb)
 		return NULL;
 
-	buf->nr_pages = nr_pages;
-	buf->nr_bufs = nbuf;
-	buf->snapshot = overwrite;
-	buf->data_pages = pages;
-	buf->real_size = size - size % BTS_RECORD_SIZE;
+	bb->nr_pages = nr_pages;
+	bb->nr_bufs = nr_buf;
+	bb->snapshot = overwrite;
+	bb->data_pages = pages;
+	bb->real_size = size - size % BTS_RECORD_SIZE;
 
-	for (pg = 0, nbuf = 0, offset = 0, pad = 0; nbuf < buf->nr_bufs; nbuf++) {
+	for (pg = 0, nr_buf = 0, offset = 0, pad = 0; nr_buf < bb->nr_bufs; nr_buf++) {
 		unsigned int __nr_pages;
 
 		page = virt_to_page(pages[pg]);
 		__nr_pages = buf_nr_pages(page);
-		buf->buf[nbuf].page = page;
-		buf->buf[nbuf].offset = offset;
-		buf->buf[nbuf].displacement = (pad ? BTS_RECORD_SIZE - pad : 0);
-		buf->buf[nbuf].size = buf_size(page) - buf->buf[nbuf].displacement;
-		pad = buf->buf[nbuf].size % BTS_RECORD_SIZE;
-		buf->buf[nbuf].size -= pad;
+		bb->buf[nr_buf].page = page;
+		bb->buf[nr_buf].offset = offset;
+		bb->buf[nr_buf].displacement = (pad ? BTS_RECORD_SIZE - pad : 0);
+		bb->buf[nr_buf].size = buf_size(page) - bb->buf[nr_buf].displacement;
+		pad = bb->buf[nr_buf].size % BTS_RECORD_SIZE;
+		bb->buf[nr_buf].size -= pad;
 
 		pg += __nr_pages;
 		offset += __nr_pages << PAGE_SHIFT;
 	}
 
-	return buf;
+	return bb;
 }
 
 static void bts_buffer_free_aux(void *data)
@@ -135,25 +135,25 @@ static void bts_buffer_free_aux(void *data)
 	kfree(data);
 }
 
-static unsigned long bts_buffer_offset(struct bts_buffer *buf, unsigned int idx)
+static unsigned long bts_buffer_offset(struct bts_buffer *bb, unsigned int idx)
 {
-	return buf->buf[idx].offset + buf->buf[idx].displacement;
+	return bb->buf[idx].offset + bb->buf[idx].displacement;
 }
 
 static void
-bts_config_buffer(struct bts_buffer *buf)
+bts_config_buffer(struct bts_buffer *bb)
 {
 	int cpu = raw_smp_processor_id();
 	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
-	struct bts_phys *phys = &buf->buf[buf->cur_buf];
+	struct bts_phys *phys = &bb->buf[bb->cur_buf];
 	unsigned long index, thresh = 0, end = phys->size;
 	struct page *page = phys->page;
 
-	index = local_read(&buf->head);
+	index = local_read(&bb->head);
 
-	if (!buf->snapshot) {
-		if (buf->end < phys->offset + buf_size(page))
-			end = buf->end - phys->offset - phys->displacement;
+	if (!bb->snapshot) {
+		if (bb->end < phys->offset + buf_size(page))
+			end = bb->end - phys->offset - phys->displacement;
 
 		index -= phys->offset + phys->displacement;
 
@@ -168,7 +168,7 @@ bts_config_buffer(struct bts_buffer *buf)
 	ds->bts_buffer_base = (u64)(long)page_address(page) + phys->displacement;
 	ds->bts_index = ds->bts_buffer_base + index;
 	ds->bts_absolute_maximum = ds->bts_buffer_base + end;
-	ds->bts_interrupt_threshold = !buf->snapshot
+	ds->bts_interrupt_threshold = !bb->snapshot
 		? ds->bts_buffer_base + thresh
 		: ds->bts_absolute_maximum + BTS_RECORD_SIZE;
 }
@@ -184,16 +184,16 @@ static void bts_update(struct bts_ctx *bts)
 {
 	int cpu = raw_smp_processor_id();
 	struct debug_store *ds = per_cpu(cpu_hw_events, cpu).ds;
-	struct bts_buffer *buf = perf_get_aux(&bts->handle);
+	struct bts_buffer *bb = perf_get_aux(&bts->handle);
 	unsigned long index = ds->bts_index - ds->bts_buffer_base, old, head;
 
-	if (!buf)
+	if (!bb)
 		return;
 
-	head = index + bts_buffer_offset(buf, buf->cur_buf);
-	old = local_xchg(&buf->head, head);
+	head = index + bts_buffer_offset(bb, bb->cur_buf);
+	old = local_xchg(&bb->head, head);
 
-	if (!buf->snapshot) {
+	if (!bb->snapshot) {
 		if (old == head)
 			return;
 
@@ -205,9 +205,9 @@ static void bts_update(struct bts_ctx *bts)
 		 * old and head are always in the same physical buffer, so we
 		 * can subtract them to get the data size.
 		 */
-		local_add(head - old, &buf->data_size);
+		local_add(head - old, &bb->data_size);
 	} else {
-		local_set(&buf->data_size, head);
+		local_set(&bb->data_size, head);
 	}
 
 	/*
@@ -218,7 +218,7 @@ static void bts_update(struct bts_ctx *bts)
 }
 
 static int
-bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
+bts_buffer_reset(struct bts_buffer *bb, struct perf_output_handle *handle);
 
 /*
  * Ordering PMU callbacks wrt themselves and the PMI is done by means
@@ -232,17 +232,17 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle);
 static void __bts_event_start(struct perf_event *event)
 {
 	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
-	struct bts_buffer *buf = perf_get_aux(&bts->handle);
+	struct bts_buffer *bb = perf_get_aux(&bts->handle);
 	u64 config = 0;
 
-	if (!buf->snapshot)
+	if (!bb->snapshot)
 		config |= ARCH_PERFMON_EVENTSEL_INT;
 	if (!event->attr.exclude_kernel)
 		config |= ARCH_PERFMON_EVENTSEL_OS;
 	if (!event->attr.exclude_user)
 		config |= ARCH_PERFMON_EVENTSEL_USR;
 
-	bts_config_buffer(buf);
+	bts_config_buffer(bb);
 
 	/*
 	 * local barrier to make sure that ds configuration made it
@@ -261,13 +261,13 @@ static void bts_event_start(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
-	struct bts_buffer *buf;
+	struct bts_buffer *bb;
 
-	buf = perf_aux_output_begin(&bts->handle, event);
-	if (!buf)
+	bb = perf_aux_output_begin(&bts->handle, event);
+	if (!bb)
 		goto fail_stop;
 
-	if (bts_buffer_reset(buf, &bts->handle))
+	if (bts_buffer_reset(bb, &bts->handle))
 		goto fail_end_stop;
 
 	bts->ds_back.bts_buffer_base = cpuc->ds->bts_buffer_base;
@@ -306,27 +306,27 @@ static void bts_event_stop(struct perf_event *event, int flags)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct bts_ctx *bts = this_cpu_ptr(bts_ctx);
-	struct bts_buffer *buf = NULL;
+	struct bts_buffer *bb = NULL;
 	int state = READ_ONCE(bts->state);
 
 	if (state == BTS_STATE_ACTIVE)
 		__bts_event_stop(event, BTS_STATE_STOPPED);
 
 	if (state != BTS_STATE_STOPPED)
-		buf = perf_get_aux(&bts->handle);
+		bb = perf_get_aux(&bts->handle);
 
 	event->hw.state |= PERF_HES_STOPPED;
 
 	if (flags & PERF_EF_UPDATE) {
 		bts_update(bts);
 
-		if (buf) {
-			if (buf->snapshot)
+		if (bb) {
+			if (bb->snapshot)
 				bts->handle.head =
-					local_xchg(&buf->data_size,
-						   buf->nr_pages << PAGE_SHIFT);
+					local_xchg(&bb->data_size,
+						   bb->nr_pages << PAGE_SHIFT);
 			perf_aux_output_end(&bts->handle,
-			                    local_xchg(&buf->data_size, 0));
+					    local_xchg(&bb->data_size, 0));
 		}
 
 		cpuc->ds->bts_index = bts->ds_back.bts_buffer_base;
@@ -382,19 +382,19 @@ void intel_bts_disable_local(void)
 }
 
 static int
-bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
+bts_buffer_reset(struct bts_buffer *bb, struct perf_output_handle *handle)
 {
 	unsigned long head, space, next_space, pad, gap, skip, wakeup;
 	unsigned int next_buf;
 	struct bts_phys *phys, *next_phys;
 	int ret;
 
-	if (buf->snapshot)
+	if (bb->snapshot)
 		return 0;
 
-	head = handle->head & ((buf->nr_pages << PAGE_SHIFT) - 1);
+	head = handle->head & ((bb->nr_pages << PAGE_SHIFT) - 1);
 
-	phys = &buf->buf[buf->cur_buf];
+	phys = &bb->buf[bb->cur_buf];
 	space = phys->offset + phys->displacement + phys->size - head;
 	pad = space;
 	if (space > handle->size) {
@@ -403,10 +403,10 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
 	}
 	if (space <= BTS_SAFETY_MARGIN) {
 		/* See if next phys buffer has more space */
-		next_buf = buf->cur_buf + 1;
-		if (next_buf >= buf->nr_bufs)
+		next_buf = bb->cur_buf + 1;
+		if (next_buf >= bb->nr_bufs)
 			next_buf = 0;
-		next_phys = &buf->buf[next_buf];
+		next_phys = &bb->buf[next_buf];
 		gap = buf_size(phys->page) - phys->displacement - phys->size +
 		      next_phys->displacement;
 		skip = pad + gap;
@@ -431,8 +431,8 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
 				 * anymore, so we must not be racing with
 				 * bts_update().
 				 */
-				buf->cur_buf = next_buf;
-				local_set(&buf->head, head);
+				bb->cur_buf = next_buf;
+				local_set(&bb->head, head);
 			}
 		}
 	}
@@ -445,7 +445,7 @@ bts_buffer_reset(struct bts_buffer *buf, struct perf_output_handle *handle)
 		space -= space % BTS_RECORD_SIZE;
 	}
 
-	buf->end = head + space;
+	bb->end = head + space;
 
 	/*
 	 * If we have no space, the lost notification would have been sent when
@@ -462,7 +462,7 @@ int intel_bts_interrupt(void)
 	struct debug_store *ds = this_cpu_ptr(&cpu_hw_events)->ds;
 	struct bts_ctx *bts;
 	struct perf_event *event;
-	struct bts_buffer *buf;
+	struct bts_buffer *bb;
 	s64 old_head;
 	int err = -ENOSPC, handled = 0;
 
@@ -485,8 +485,8 @@ int intel_bts_interrupt(void)
 	if (READ_ONCE(bts->state) == BTS_STATE_STOPPED)
 		return handled;
 
-	buf = perf_get_aux(&bts->handle);
-	if (!buf)
+	bb = perf_get_aux(&bts->handle);
+	if (!bb)
 		return handled;
 
 	/*
@@ -494,26 +494,26 @@ int intel_bts_interrupt(void)
 	 * there's no other way of telling, because the pointer will
 	 * keep moving
 	 */
-	if (buf->snapshot)
+	if (bb->snapshot)
 		return 0;
 
-	old_head = local_read(&buf->head);
+	old_head = local_read(&bb->head);
 	bts_update(bts);
 
 	/* no new data */
-	if (old_head == local_read(&buf->head))
+	if (old_head == local_read(&bb->head))
 		return handled;
 
-	perf_aux_output_end(&bts->handle, local_xchg(&buf->data_size, 0));
+	perf_aux_output_end(&bts->handle, local_xchg(&bb->data_size, 0));
 
-	buf = perf_aux_output_begin(&bts->handle, event);
-	if (buf)
-		err = bts_buffer_reset(buf, &bts->handle);
+	bb = perf_aux_output_begin(&bts->handle, event);
+	if (bb)
+		err = bts_buffer_reset(bb, &bts->handle);
 
 	if (err) {
 		WRITE_ONCE(bts->state, BTS_STATE_STOPPED);
 
-		if (buf) {
+		if (bb) {
 			/*
 			 * BTS_STATE_STOPPED should be visible before
 			 * cleared handle::event
-- 
2.49.0

