Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5538216132A;
	Sun, 10 May 2026 03:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384111; cv=none; b=JYmgfi87GLsMww52pfaJjMKLVBhPPF+dLzUmJ8rquMgMQ4bebEQ907PXMpOUylp2dOGlI/v9tvD0hGd9SkiuNwW40wP/vx1FryDA/xQAm2CZMX7aiTxZAk+hrK15PehWUeoQY5OgKagde8O7QupItONAAmwvY2b28bquA5DwA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384111; c=relaxed/simple;
	bh=xEZTK/wxQ1l7gCWHtoAm/P0GGgytM79XSYBD93TAk9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7W5gpcClhwREsWxjKuGuRkKQujKPALGFZ4bpI0v4Ti1btkRPT2Ds+JU+ViY5m7CyOPoWiTnPu7tGMbzkkx0sULkBKC0Ke+ixFI7WehHjWlA/dmqikelk073o8zf7SED+x/yVEfPibz0TviMKafpuW5ozUBkrRt6zqqlx7uKO0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFGB96M7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFGB96M7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A486FC2BCB8;
	Sun, 10 May 2026 03:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384110;
	bh=xEZTK/wxQ1l7gCWHtoAm/P0GGgytM79XSYBD93TAk9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jFGB96M73VMMIG+3YtTWBQxMDs5yxnKddJ1iqS7mPzp4Imxy6GHa/sS7qZAxffuyv
	 7Jc+/TVFSOfLeyhFABpY/BVYE47v7vWTx1Fl2FlxxghSc1mXKILM7DJagIhRXK87iN
	 HORajZ2vgWQQ0x/aXBDBNywfx+LNQs3+2Ql148hRvhGhgA3GrgVPLj/fNVLhjWfTpp
	 ptYQZZ0IcAaNfu3MySrM1Haxj9aSpZ99YUwJ9z9gOn3/0OP/XLr5UZrO4sgwTlZFpS
	 QD2UgXfjdNo3Wr6hE9f9vyCfEGl6SLr1J57D67U8xKt6Y0/hte6mUzFOUe4jRhpLeM
	 45ul9I2pCCAJw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 07/28] perf session: Add validated swap infrastructure with null-termination checks
Date: Sun, 10 May 2026 00:33:58 -0300
Message-ID: <20260510033424.255812-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510033424.255812-1-acme@kernel.org>
References: <20260510033424.255812-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Change swap callbacks from void to int return so handlers can
propagate errors.  All 28 existing handlers are converted to
return 0 on success, -1 on error.  Three new handlers (KSYMBOL,
BPF_EVENT, HEADER_FEATURE) are added returning int from the
start, with sample_id_all handling for the kernel event types.

event_swap() propagates the return to its callers (process_event
and peek_event), which skip events that fail to swap.

Add perf_event__check_nul() for null-termination enforcement
on the common event delivery path for MMAP, MMAP2, COMM,
CGROUP, and KSYMBOL events.  Events with
unterminated strings are skipped — native-endian files are
mapped read-only, so writing a NUL byte in place would segfault.

Swap handler hardening:

 - Use strnlen bounded by event size (instead of strlen) in
   COMM/MMAP/MMAP2/CGROUP swap handlers, returning -1 on
   unterminated strings.

 - Bounds check text_poke old_len+new_len before computing the
   sample_id offset, returning -1 on overflow.  Use offsetof()
   for the native-path check in machines__deliver_event() since
   sizeof() includes struct padding past the flexible array.

 - Fix PERF_RECORD_SWITCH sample_id_all: non-CPU_WIDE SWITCH
   events have sample_id immediately after the 8-byte header,
   not at sizeof(struct perf_record_switch) which is the
   CPU_WIDE variant size.

 - Fix perf_event__time_conv_swap() guard: check time_mask
   (the last field accessed) instead of time_cycles, so a
   short event that fits time_cycles but not time_mask does
   not cause an out-of-bounds bswap_64.

 - Handle ABI0 (attr.size == 0) in perf_event__attr_swap()
   by substituting PERF_ATTR_SIZE_VER0, so bswap_safe()
   correctly swaps VER0 fields instead of skipping everything.

 - peek_events: initialize event pointer to NULL to avoid
   dereferencing stack garbage on early peek_event() failure;
   on swap failure, advance past the malformed entry instead
   of aborting the loop.

Note: the nr-field bounds checks for namespaces, thread_map,
cpu_map, and stat_config arrays are added by a subsequent
patch ("perf session: Validate nr fields against event size
on both swap and common paths").  The HEADER_ATTR attr.size
validation is added by ("perf session: Validate HEADER_ATTR
alignment and attr.size before swapping").

By establishing the int-returning swap infrastructure first,
all subsequent hardening patches can use direct error returns
from day one — no poison values, no workarounds for void return.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 411 ++++++++++++++++++++++++++++++--------
 1 file changed, 323 insertions(+), 88 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index b55c5168ee9f4aae..18e60ccf6829f05a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -288,28 +288,43 @@ static void swap_sample_id_all(union perf_event *event, void *data)
 		mem_bswap_64(data, size);
 }
 
-static void perf_event__all64_swap(union perf_event *event,
-				   bool sample_id_all __maybe_unused)
+static int perf_event__all64_swap(union perf_event *event,
+				  bool sample_id_all __maybe_unused)
 {
 	struct perf_event_header *hdr = &event->header;
-	mem_bswap_64(hdr + 1, event->header.size - sizeof(*hdr));
+	size_t size = event->header.size - sizeof(*hdr);
+
+	/* Round down: mem_bswap_64() would overrun on unaligned tail */
+	size &= ~(size_t)(sizeof(u64) - 1);
+	mem_bswap_64(hdr + 1, size);
+	return 0;
 }
 
-static void perf_event__comm_swap(union perf_event *event, bool sample_id_all)
+static int perf_event__comm_swap(union perf_event *event, bool sample_id_all)
 {
 	event->comm.pid = bswap_32(event->comm.pid);
 	event->comm.tid = bswap_32(event->comm.tid);
 
 	if (sample_id_all) {
 		void *data = &event->comm.comm;
+		void *end = (void *)event + event->header.size;
+		size_t len = strnlen(data, end - data);
 
-		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
+		/*
+		 * No NUL within the event boundary — can't locate where
+		 * sample_id_all starts.  Reject so the event is skipped
+		 * rather than swapping garbage.
+		 */
+		if (len == (size_t)(end - data))
+			return -1;
+		data += PERF_ALIGN(len + 1, sizeof(u64));
 		swap_sample_id_all(event, data);
 	}
+	return 0;
 }
 
-static void perf_event__mmap_swap(union perf_event *event,
-				  bool sample_id_all)
+static int perf_event__mmap_swap(union perf_event *event,
+				 bool sample_id_all)
 {
 	event->mmap.pid	  = bswap_32(event->mmap.pid);
 	event->mmap.tid	  = bswap_32(event->mmap.tid);
@@ -319,13 +334,19 @@ static void perf_event__mmap_swap(union perf_event *event,
 
 	if (sample_id_all) {
 		void *data = &event->mmap.filename;
+		void *end = (void *)event + event->header.size;
+		size_t len = strnlen(data, end - data);
 
-		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
+		/* See comment in perf_event__comm_swap() */
+		if (len == (size_t)(end - data))
+			return -1;
+		data += PERF_ALIGN(len + 1, sizeof(u64));
 		swap_sample_id_all(event, data);
 	}
+	return 0;
 }
 
-static void perf_event__mmap2_swap(union perf_event *event,
+static int perf_event__mmap2_swap(union perf_event *event,
 				  bool sample_id_all)
 {
 	event->mmap2.pid   = bswap_32(event->mmap2.pid);
@@ -343,12 +364,19 @@ static void perf_event__mmap2_swap(union perf_event *event,
 
 	if (sample_id_all) {
 		void *data = &event->mmap2.filename;
+		void *end = (void *)event + event->header.size;
+		size_t len = strnlen(data, end - data);
 
-		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
+		/* See comment in perf_event__comm_swap() */
+		if (len == (size_t)(end - data))
+			return -1;
+		data += PERF_ALIGN(len + 1, sizeof(u64));
 		swap_sample_id_all(event, data);
 	}
+	return 0;
 }
-static void perf_event__task_swap(union perf_event *event, bool sample_id_all)
+
+static int perf_event__task_swap(union perf_event *event, bool sample_id_all)
 {
 	event->fork.pid	 = bswap_32(event->fork.pid);
 	event->fork.tid	 = bswap_32(event->fork.tid);
@@ -358,10 +386,11 @@ static void perf_event__task_swap(union perf_event *event, bool sample_id_all)
 
 	if (sample_id_all)
 		swap_sample_id_all(event, &event->fork + 1);
+	return 0;
 }
 
-static void perf_event__read_swap(union perf_event *event,
-				  bool sample_id_all __maybe_unused)
+static int perf_event__read_swap(union perf_event *event,
+				 bool sample_id_all __maybe_unused)
 {
 	size_t tail;
 
@@ -376,9 +405,10 @@ static void perf_event__read_swap(union perf_event *event,
 	tail = event->header.size - offsetof(struct perf_record_read, value);
 	tail &= ~(size_t)(sizeof(__u64) - 1);
 	mem_bswap_64(&event->read.value, tail);
+	return 0;
 }
 
-static void perf_event__aux_swap(union perf_event *event, bool sample_id_all)
+static int perf_event__aux_swap(union perf_event *event, bool sample_id_all)
 {
 	event->aux.aux_offset = bswap_64(event->aux.aux_offset);
 	event->aux.aux_size   = bswap_64(event->aux.aux_size);
@@ -386,19 +416,21 @@ static void perf_event__aux_swap(union perf_event *event, bool sample_id_all)
 
 	if (sample_id_all)
 		swap_sample_id_all(event, &event->aux + 1);
+	return 0;
 }
 
-static void perf_event__itrace_start_swap(union perf_event *event,
-					  bool sample_id_all)
+static int perf_event__itrace_start_swap(union perf_event *event,
+					 bool sample_id_all)
 {
 	event->itrace_start.pid	 = bswap_32(event->itrace_start.pid);
 	event->itrace_start.tid	 = bswap_32(event->itrace_start.tid);
 
 	if (sample_id_all)
 		swap_sample_id_all(event, &event->itrace_start + 1);
+	return 0;
 }
 
-static void perf_event__switch_swap(union perf_event *event, bool sample_id_all)
+static int perf_event__switch_swap(union perf_event *event, bool sample_id_all)
 {
 	if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
 		event->context_switch.next_prev_pid =
@@ -407,30 +439,45 @@ static void perf_event__switch_swap(union perf_event *event, bool sample_id_all)
 				bswap_32(event->context_switch.next_prev_tid);
 	}
 
-	if (sample_id_all)
-		swap_sample_id_all(event, &event->context_switch + 1);
+	if (sample_id_all) {
+		/*
+		 * PERF_RECORD_SWITCH has no fields beyond the header;
+		 * SWITCH_CPU_WIDE adds pid/tid.  Use the right offset
+		 * so sample_id starts at the correct position.
+		 */
+		if (event->header.type == PERF_RECORD_SWITCH)
+			swap_sample_id_all(event, (void *)event + sizeof(event->header));
+		else
+			swap_sample_id_all(event, &event->context_switch + 1);
+	}
+	return 0;
 }
 
-static void perf_event__text_poke_swap(union perf_event *event, bool sample_id_all)
+static int perf_event__text_poke_swap(union perf_event *event, bool sample_id_all)
 {
 	event->text_poke.addr    = bswap_64(event->text_poke.addr);
 	event->text_poke.old_len = bswap_16(event->text_poke.old_len);
 	event->text_poke.new_len = bswap_16(event->text_poke.new_len);
 
 	if (sample_id_all) {
+		void *data = &event->text_poke.old_len;
+		void *end = (void *)event + event->header.size;
 		size_t len = sizeof(event->text_poke.old_len) +
 			     sizeof(event->text_poke.new_len) +
 			     event->text_poke.old_len +
 			     event->text_poke.new_len;
-		void *data = &event->text_poke.old_len;
 
+		/* old_len + new_len exceeds event — can't find sample_id_all */
+		if (data + len > end)
+			return -1;
 		data += PERF_ALIGN(len, sizeof(u64));
 		swap_sample_id_all(event, data);
 	}
+	return 0;
 }
 
-static void perf_event__throttle_swap(union perf_event *event,
-				      bool sample_id_all)
+static int perf_event__throttle_swap(union perf_event *event,
+				     bool sample_id_all)
 {
 	event->throttle.time	  = bswap_64(event->throttle.time);
 	event->throttle.id	  = bswap_64(event->throttle.id);
@@ -438,10 +485,11 @@ static void perf_event__throttle_swap(union perf_event *event,
 
 	if (sample_id_all)
 		swap_sample_id_all(event, &event->throttle + 1);
+	return 0;
 }
 
-static void perf_event__namespaces_swap(union perf_event *event,
-					bool sample_id_all)
+static int perf_event__namespaces_swap(union perf_event *event,
+				       bool sample_id_all)
 {
 	u64 i;
 
@@ -458,18 +506,25 @@ static void perf_event__namespaces_swap(union perf_event *event,
 
 	if (sample_id_all)
 		swap_sample_id_all(event, &event->namespaces.link_info[i]);
+	return 0;
 }
 
-static void perf_event__cgroup_swap(union perf_event *event, bool sample_id_all)
+static int perf_event__cgroup_swap(union perf_event *event, bool sample_id_all)
 {
 	event->cgroup.id = bswap_64(event->cgroup.id);
 
 	if (sample_id_all) {
 		void *data = &event->cgroup.path;
+		void *end = (void *)event + event->header.size;
+		size_t len = strnlen(data, end - data);
 
-		data += PERF_ALIGN(strlen(data) + 1, sizeof(u64));
+		/* See comment in perf_event__comm_swap() */
+		if (len == (size_t)(end - data))
+			return -1;
+		data += PERF_ALIGN(len + 1, sizeof(u64));
 		swap_sample_id_all(event, data);
 	}
+	return 0;
 }
 
 static u8 revbyte(u8 b)
@@ -510,9 +565,19 @@ void perf_event__attr_swap(struct perf_event_attr *attr)
 	attr->type		= bswap_32(attr->type);
 	attr->size		= bswap_32(attr->size);
 
-#define bswap_safe(f, n) 					\
-	(attr->size > (offsetof(struct perf_event_attr, f) + 	\
-		       sizeof(attr->f) * (n)))
+	/*
+	 * ABI0: size == 0 means the producer didn't set it.
+	 * Assume PERF_ATTR_SIZE_VER0 so bswap_safe() below
+	 * correctly swaps the VER0 fields instead of skipping
+	 * everything.  Same convention as read_attr().
+	 */
+	if (!attr->size)
+		attr->size = PERF_ATTR_SIZE_VER0;
+
+/* Verify the full field extent fits, not just its start offset */
+#define bswap_safe(f, n)					\
+	(attr->size >= (offsetof(struct perf_event_attr, f) +	\
+			sizeof(attr->f) * ((n) + 1)))
 #define bswap_field(f, sz) 			\
 do { 						\
 	if (bswap_safe(f, 0))			\
@@ -550,8 +615,8 @@ do { 						\
 #undef bswap_safe
 }
 
-static void perf_event__hdr_attr_swap(union perf_event *event,
-				      bool sample_id_all __maybe_unused)
+static int perf_event__hdr_attr_swap(union perf_event *event,
+				     bool sample_id_all __maybe_unused)
 {
 	size_t size;
 
@@ -560,30 +625,34 @@ static void perf_event__hdr_attr_swap(union perf_event *event,
 	size = event->header.size;
 	size -= perf_record_header_attr_id(event) - (void *)event;
 	mem_bswap_64(perf_record_header_attr_id(event), size);
+	return 0;
 }
 
-static void perf_event__event_update_swap(union perf_event *event,
-					  bool sample_id_all __maybe_unused)
+static int perf_event__event_update_swap(union perf_event *event,
+					 bool sample_id_all __maybe_unused)
 {
 	event->event_update.type = bswap_64(event->event_update.type);
 	event->event_update.id   = bswap_64(event->event_update.id);
+	return 0;
 }
 
-static void perf_event__event_type_swap(union perf_event *event,
-					bool sample_id_all __maybe_unused)
+static int perf_event__event_type_swap(union perf_event *event,
+				       bool sample_id_all __maybe_unused)
 {
 	event->event_type.event_type.event_id =
 		bswap_64(event->event_type.event_type.event_id);
+	return 0;
 }
 
-static void perf_event__tracing_data_swap(union perf_event *event,
-					  bool sample_id_all __maybe_unused)
+static int perf_event__tracing_data_swap(union perf_event *event,
+					 bool sample_id_all __maybe_unused)
 {
 	event->tracing_data.size = bswap_32(event->tracing_data.size);
+	return 0;
 }
 
-static void perf_event__auxtrace_info_swap(union perf_event *event,
-					   bool sample_id_all __maybe_unused)
+static int perf_event__auxtrace_info_swap(union perf_event *event,
+					  bool sample_id_all __maybe_unused)
 {
 	size_t size;
 
@@ -594,10 +663,11 @@ static void perf_event__auxtrace_info_swap(union perf_event *event,
 	/* priv[] is a u64 array; only swap complete 8-byte elements */
 	size &= ~(size_t)(sizeof(u64) - 1);
 	mem_bswap_64(event->auxtrace_info.priv, size);
+	return 0;
 }
 
-static void perf_event__auxtrace_swap(union perf_event *event,
-				      bool sample_id_all __maybe_unused)
+static int perf_event__auxtrace_swap(union perf_event *event,
+				     bool sample_id_all __maybe_unused)
 {
 	event->auxtrace.size      = bswap_64(event->auxtrace.size);
 	event->auxtrace.offset    = bswap_64(event->auxtrace.offset);
@@ -605,10 +675,11 @@ static void perf_event__auxtrace_swap(union perf_event *event,
 	event->auxtrace.idx       = bswap_32(event->auxtrace.idx);
 	event->auxtrace.tid       = bswap_32(event->auxtrace.tid);
 	event->auxtrace.cpu       = bswap_32(event->auxtrace.cpu);
+	return 0;
 }
 
-static void perf_event__auxtrace_error_swap(union perf_event *event,
-					    bool sample_id_all __maybe_unused)
+static int perf_event__auxtrace_error_swap(union perf_event *event,
+					   bool sample_id_all __maybe_unused)
 {
 	event->auxtrace_error.type = bswap_32(event->auxtrace_error.type);
 	event->auxtrace_error.code = bswap_32(event->auxtrace_error.code);
@@ -623,10 +694,11 @@ static void perf_event__auxtrace_error_swap(union perf_event *event,
 		event->auxtrace_error.machine_pid = bswap_32(event->auxtrace_error.machine_pid);
 		event->auxtrace_error.vcpu = bswap_32(event->auxtrace_error.vcpu);
 	}
+	return 0;
 }
 
-static void perf_event__thread_map_swap(union perf_event *event,
-					bool sample_id_all __maybe_unused)
+static int perf_event__thread_map_swap(union perf_event *event,
+				       bool sample_id_all __maybe_unused)
 {
 	unsigned i;
 
@@ -634,10 +706,11 @@ static void perf_event__thread_map_swap(union perf_event *event,
 
 	for (i = 0; i < event->thread_map.nr; i++)
 		event->thread_map.entries[i].pid = bswap_64(event->thread_map.entries[i].pid);
+	return 0;
 }
 
-static void perf_event__cpu_map_swap(union perf_event *event,
-				     bool sample_id_all __maybe_unused)
+static int perf_event__cpu_map_swap(union perf_event *event,
+				    bool sample_id_all __maybe_unused)
 {
 	struct perf_record_cpu_map_data *data = &event->cpu_map.data;
 
@@ -675,20 +748,22 @@ static void perf_event__cpu_map_swap(union perf_event *event,
 	default:
 		break;
 	}
+	return 0;
 }
 
-static void perf_event__stat_config_swap(union perf_event *event,
-					 bool sample_id_all __maybe_unused)
+static int perf_event__stat_config_swap(union perf_event *event,
+					bool sample_id_all __maybe_unused)
 {
 	u64 size;
 
 	size  = bswap_64(event->stat_config.nr) * sizeof(event->stat_config.data[0]);
 	size += 1; /* nr item itself */
 	mem_bswap_64(&event->stat_config.nr, size);
+	return 0;
 }
 
-static void perf_event__stat_swap(union perf_event *event,
-				  bool sample_id_all __maybe_unused)
+static int perf_event__stat_swap(union perf_event *event,
+				 bool sample_id_all __maybe_unused)
 {
 	event->stat.id     = bswap_64(event->stat.id);
 	event->stat.thread = bswap_32(event->stat.thread);
@@ -696,44 +771,90 @@ static void perf_event__stat_swap(union perf_event *event,
 	event->stat.val    = bswap_64(event->stat.val);
 	event->stat.ena    = bswap_64(event->stat.ena);
 	event->stat.run    = bswap_64(event->stat.run);
+	return 0;
 }
 
-static void perf_event__stat_round_swap(union perf_event *event,
-					bool sample_id_all __maybe_unused)
+static int perf_event__stat_round_swap(union perf_event *event,
+				       bool sample_id_all __maybe_unused)
 {
 	event->stat_round.type = bswap_64(event->stat_round.type);
 	event->stat_round.time = bswap_64(event->stat_round.time);
+	return 0;
 }
 
-static void perf_event__time_conv_swap(union perf_event *event,
-				       bool sample_id_all __maybe_unused)
+static int perf_event__time_conv_swap(union perf_event *event,
+				      bool sample_id_all __maybe_unused)
 {
 	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
 	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
 	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
 
-	if (event_contains(event->time_conv, time_cycles)) {
+	if (event_contains(event->time_conv, time_mask)) {
 		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
 		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
 	}
+	return 0;
 }
 
-static void
+static int
 perf_event__schedstat_cpu_swap(union perf_event *event __maybe_unused,
 			       bool sample_id_all __maybe_unused)
 {
 	/* FIXME */
+	return 0;
 }
 
-static void
+static int
 perf_event__schedstat_domain_swap(union perf_event *event __maybe_unused,
 				  bool sample_id_all __maybe_unused)
 {
 	/* FIXME */
+	return 0;
+}
+
+static int perf_event__ksymbol_swap(union perf_event *event,
+				    bool sample_id_all)
+{
+	event->ksymbol.addr = bswap_64(event->ksymbol.addr);
+	event->ksymbol.len = bswap_32(event->ksymbol.len);
+	event->ksymbol.ksym_type = bswap_16(event->ksymbol.ksym_type);
+	event->ksymbol.flags = bswap_16(event->ksymbol.flags);
+
+	if (sample_id_all) {
+		void *data = &event->ksymbol.name;
+		void *end = (void *)event + event->header.size;
+		size_t len = strnlen(data, end - data);
+
+		/* See comment in perf_event__comm_swap() */
+		if (len == (size_t)(end - data))
+			return -1;
+		data += PERF_ALIGN(len + 1, sizeof(u64));
+		swap_sample_id_all(event, data);
+	}
+	return 0;
 }
 
-typedef void (*perf_event__swap_op)(union perf_event *event,
-				    bool sample_id_all);
+static int perf_event__bpf_event_swap(union perf_event *event,
+				      bool sample_id_all)
+{
+	event->bpf.type = bswap_16(event->bpf.type);
+	event->bpf.flags = bswap_16(event->bpf.flags);
+	event->bpf.id = bswap_32(event->bpf.id);
+
+	if (sample_id_all)
+		swap_sample_id_all(event, &event->bpf + 1);
+	return 0;
+}
+
+static int perf_event__header_feature_swap(union perf_event *event,
+					   bool sample_id_all __maybe_unused)
+{
+	event->feat.feat_id = bswap_64(event->feat.feat_id);
+	return 0;
+}
+
+typedef int (*perf_event__swap_op)(union perf_event *event,
+				   bool sample_id_all);
 
 static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_MMAP]		  = perf_event__mmap_swap,
@@ -753,6 +874,8 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
 	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
 	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
+	[PERF_RECORD_KSYMBOL]		  = perf_event__ksymbol_swap,
+	[PERF_RECORD_BPF_EVENT]		  = perf_event__bpf_event_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = perf_event__all64_swap,
 	[PERF_RECORD_CALLCHAIN_DEFERRED]  = perf_event__all64_swap,
@@ -760,6 +883,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
 	[PERF_RECORD_HEADER_BUILD_ID]	  = NULL,
+	[PERF_RECORD_HEADER_FEATURE]	  = perf_event__header_feature_swap,
 	[PERF_RECORD_ID_INDEX]		  = perf_event__all64_swap,
 	[PERF_RECORD_AUXTRACE_INFO]	  = perf_event__auxtrace_info_swap,
 	[PERF_RECORD_AUXTRACE]		  = perf_event__auxtrace_swap,
@@ -1484,6 +1608,25 @@ static int session__flush_deferred_samples(struct perf_session *session,
 	return ret;
 }
 
+/*
+ * Return true if the string field is properly null-terminated
+ * within the event boundary.  Native-endian files are mapped
+ * read-only (MAP_SHARED + PROT_READ) so we cannot write a
+ * null byte in place; skip the event instead.
+ */
+static bool perf_event__check_nul(const char *str, const void *end, const char *event_name)
+{
+	size_t max_len = (const char *)end - str;
+
+	if (max_len == 0 || strnlen(str, max_len) == max_len) {
+		pr_warning("WARNING: PERF_RECORD_%s: string not null-terminated, skipping event\n",
+			   event_name);
+		return false;
+	}
+
+	return true;
+}
+
 static int machines__deliver_event(struct machines *machines,
 				   struct evlist *evlist,
 				   union perf_event *event,
@@ -1534,16 +1677,32 @@ static int machines__deliver_event(struct machines *machines,
 		}
 		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
 	case PERF_RECORD_MMAP:
+		if (!perf_event__check_nul(event->mmap.filename,
+					   (void *)event + event->header.size,
+					   "MMAP"))
+			return 0;
 		return tool->mmap(tool, event, sample, machine);
 	case PERF_RECORD_MMAP2:
 		if (event->header.misc & PERF_RECORD_MISC_PROC_MAP_PARSE_TIMEOUT)
 			++evlist->stats.nr_proc_map_timeout;
+		if (!perf_event__check_nul(event->mmap2.filename,
+					   (void *)event + event->header.size,
+					   "MMAP2"))
+			return 0;
 		return tool->mmap2(tool, event, sample, machine);
 	case PERF_RECORD_COMM:
+		if (!perf_event__check_nul(event->comm.comm,
+					   (void *)event + event->header.size,
+					   "COMM"))
+			return 0;
 		return tool->comm(tool, event, sample, machine);
 	case PERF_RECORD_NAMESPACES:
 		return tool->namespaces(tool, event, sample, machine);
 	case PERF_RECORD_CGROUP:
+		if (!perf_event__check_nul(event->cgroup.path,
+					   (void *)event + event->header.size,
+					   "CGROUP"))
+			return 0;
 		return tool->cgroup(tool, event, sample, machine);
 	case PERF_RECORD_FORK:
 		return tool->fork(tool, event, sample, machine);
@@ -1582,11 +1741,25 @@ static int machines__deliver_event(struct machines *machines,
 	case PERF_RECORD_SWITCH_CPU_WIDE:
 		return tool->context_switch(tool, event, sample, machine);
 	case PERF_RECORD_KSYMBOL:
+		if (!perf_event__check_nul(event->ksymbol.name,
+					   (void *)event + event->header.size,
+					   "KSYMBOL"))
+			return 0;
 		return tool->ksymbol(tool, event, sample, machine);
 	case PERF_RECORD_BPF_EVENT:
 		return tool->bpf(tool, event, sample, machine);
-	case PERF_RECORD_TEXT_POKE:
+	case PERF_RECORD_TEXT_POKE: {
+		/* offsetof(bytes), not sizeof — sizeof includes padding past the flexible array */
+		size_t text_poke_len = offsetof(struct perf_record_text_poke_event, bytes) +
+				       event->text_poke.old_len +
+				       event->text_poke.new_len;
+
+		if (event->header.size < text_poke_len) {
+			pr_warning("WARNING: PERF_RECORD_TEXT_POKE: old_len+new_len exceeds event, skipping\n");
+			return 0;
+		}
 		return tool->text_poke(tool, event, sample, machine);
+	}
 	case PERF_RECORD_AUX_OUTPUT_HW_ID:
 		return tool->aux_output_hw_id(tool, event, sample, machine);
 	case PERF_RECORD_CALLCHAIN_DEFERRED:
@@ -1792,19 +1965,40 @@ int perf_session__deliver_synth_attr_event(struct perf_session *session,
 	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
 }
 
+static int event_swap(union perf_event *event, bool sample_id_all)
+{
+	perf_event__swap_op swap;
+
+	/* Prevent OOB read on perf_event__swap_ops[] from crafted type */
+	if (event->header.type >= PERF_RECORD_HEADER_MAX)
+		return 0;
+
+	swap = perf_event__swap_ops[event->header.type];
+	if (swap)
+		return swap(event, sample_id_all);
+	return 0;
+}
+
 /*
  * Minimum event sizes indexed by type.  Checked before swap and
  * processing so that both cross-endian and native-endian paths
  * are protected from accessing fields past the event boundary.
  * Zero means no minimum beyond the 8-byte header (already
  * enforced by the reader).
+ *
+ * These values represent the smallest event the kernel has ever
+ * emitted for each type, so they do not reject legitimate legacy
+ * perf.data files from older kernels.  Variable-length events
+ * use offsetof() to the first variable field; the variable
+ * content is validated separately (e.g., perf_event__check_nul).
  */
 static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	/*
 	 * offsetof() for types with a trailing variable-length string
 	 * (filename, comm, path, name, msg): sizeof() includes a
 	 * PATH_MAX or fixed-size array, but valid events only need
-	 * the fixed fields.  Null-termination is checked separately.
+	 * the fixed fields.  Null-termination is checked separately
+	 * by perf_event__check_nul().
 	 *
 	 * PERF_RECORD_SAMPLE is omitted: all64_swap is bounded by
 	 * header.size, and the internal layout varies by sample_type
@@ -1812,6 +2006,7 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	 */
 	[PERF_RECORD_MMAP]		  = offsetof(struct perf_record_mmap, filename),
 	[PERF_RECORD_LOST]		  = sizeof(struct perf_record_lost),
+	/* comm[] is variable-length; kernel aligns to 8 bytes */
 	[PERF_RECORD_COMM]		  = offsetof(struct perf_record_comm, comm),
 	[PERF_RECORD_EXIT]		  = sizeof(struct perf_record_fork),
 	[PERF_RECORD_THROTTLE]		  = sizeof(struct perf_record_throttle),
@@ -1819,7 +2014,9 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	[PERF_RECORD_FORK]		  = sizeof(struct perf_record_fork),
 	/*
 	 * The kernel dynamically sizes PERF_RECORD_READ based on
-	 * attr.read_format — the minimum has just pid + tid + value.
+	 * attr.read_format — only the enabled fields are emitted,
+	 * packed with no gaps.  The minimum valid event has just
+	 * pid + tid + one u64 value (no optional fields).
 	 */
 	[PERF_RECORD_READ]		  = offsetof(struct perf_record_read, time_enabled),
 	[PERF_RECORD_MMAP2]		  = offsetof(struct perf_record_mmap2, filename),
@@ -1841,14 +2038,25 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	[PERF_RECORD_AUXTRACE]		  = sizeof(struct perf_record_auxtrace),
 	[PERF_RECORD_AUXTRACE_ERROR]	  = offsetof(struct perf_record_auxtrace_error, msg),
 	[PERF_RECORD_THREAD_MAP]	  = sizeof(struct perf_record_thread_map),
-	/* Smallest valid variant is RANGE_CPUS: header(8) + type(2) + range(6) */
+	/*
+	 * sizeof(perf_record_cpu_map) is 20 because the outer struct
+	 * isn't packed and GCC adds 2 bytes of trailing padding.
+	 * The smallest valid variant (RANGE_CPUS) is only 16 bytes:
+	 * header(8) + type(2) + range_cpu_data(6).  Per-variant
+	 * bounds are checked in the swap handler via payload.
+	 */
 	[PERF_RECORD_CPU_MAP]		  = sizeof(struct perf_event_header) +
 					    sizeof(__u16) +
 					    sizeof(struct perf_record_range_cpu_map),
 	[PERF_RECORD_STAT_CONFIG]	  = sizeof(struct perf_record_stat_config),
 	[PERF_RECORD_STAT]		  = sizeof(struct perf_record_stat),
 	[PERF_RECORD_STAT_ROUND]	  = sizeof(struct perf_record_stat_round),
-	/* Union inflates sizeof; use fixed header fields as minimum */
+	/*
+	 * EVENT_UPDATE has a union whose largest member (cpus)
+	 * inflates sizeof to 40, but SCALE events are only 32
+	 * and UNIT/NAME events can be even smaller.  Use the
+	 * fixed header fields (header + type + id) as minimum.
+	 */
 	[PERF_RECORD_EVENT_UPDATE]	  = offsetof(struct perf_record_event_update, scale),
 	[PERF_RECORD_TIME_CONV]		  = offsetof(struct perf_record_time_conv, time_cycles),
 	[PERF_RECORD_ID_INDEX]		  = sizeof(struct perf_record_id_index),
@@ -1866,19 +2074,6 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = offsetof(struct perf_record_schedstat_domain, v15),
 };
 
-static void event_swap(union perf_event *event, bool sample_id_all)
-{
-	perf_event__swap_op swap;
-
-	/* Prevent OOB read on perf_event__swap_ops[] from crafted type */
-	if (event->header.type >= PERF_RECORD_HEADER_MAX)
-		return;
-
-	swap = perf_event__swap_ops[event->header.type];
-	if (swap)
-		swap(event, sample_id_all);
-}
-
 int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 			     void *buf, size_t buf_sz,
 			     union perf_event **event_ptr,
@@ -1896,7 +2091,6 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 		if (event->header.size < sizeof(struct perf_event_header))
 			return -1;
 
-		/* Reject undersized events on the native-endian fast path */
 		if (event->header.type < PERF_RECORD_HEADER_MAX) {
 			u32 min_sz = perf_event__min_size[event->header.type];
 
@@ -1935,7 +2129,6 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 	if (readn(fd, buf, rest) != (ssize_t)rest)
 		return -1;
 
-	/* Reject undersized events before swapping */
 	if (event->header.type < PERF_RECORD_HEADER_MAX) {
 		u32 min_sz = perf_event__min_size[event->header.type];
 
@@ -1949,8 +2142,16 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 		}
 	}
 
-	if (session->header.needs_swap)
-		event_swap(event, evlist__sample_id_all(session->evlist));
+	if (session->header.needs_swap &&
+	    event_swap(event, evlist__sample_id_all(session->evlist))) {
+		/*
+		 * The header was already swapped so header.size is
+		 * valid — expose the event so callers can advance
+		 * past this malformed entry instead of aborting.
+		 */
+		*event_ptr = event;
+		return -1;
+	}
 
 out_parse_sample:
 
@@ -1968,15 +2169,34 @@ int perf_session__peek_events(struct perf_session *session, u64 offset,
 {
 	u64 max_offset = offset + size;
 	char buf[PERF_SAMPLE_MAX_SIZE];
-	union perf_event *event;
+	/*
+	 * Initialized to NULL so the first-iteration error path
+	 * doesn't dereference stack garbage.  On subsequent failures
+	 * event may point into buf from a prior read — peek_event
+	 * sets *event_ptr on min_sz and swap failures so the header
+	 * is from the current (failed) event, not a stale one.
+	 */
+	union perf_event *event = NULL;
 	int err;
 
 	do {
+		event = NULL;
 		err = perf_session__peek_event(session, offset, buf,
 					       PERF_SAMPLE_MAX_SIZE, &event,
 					       NULL);
-		if (err)
-			return err;
+		if (err) {
+			/*
+			 * peek_event sets event_ptr when it read enough
+			 * to know the event size (min_sz and swap failures).
+			 * If event is NULL or size is 0, we can't advance
+			 * and must abort.  Otherwise skip past this entry.
+			 */
+			if (event && event->header.size)
+				offset += event->header.size;
+			else
+				return err;
+			continue;
+		}
 
 		err = cb(session, event, offset, data);
 		if (err)
@@ -2014,8 +2234,12 @@ static s64 perf_session__process_event(struct perf_session *session,
 		}
 	}
 
-	if (session->header.needs_swap)
-		event_swap(event, evlist__sample_id_all(evlist));
+	if (session->header.needs_swap &&
+	    event_swap(event, evlist__sample_id_all(evlist))) {
+		pr_warning("WARNING: swap failed for %s event, skipping\n",
+			   perf_event__name(event->header.type));
+		return 0;
+	}
 
 	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
 		/* perf should not support unaligned event, stop here. */
@@ -2496,6 +2720,17 @@ reader__mmap(struct reader *rd, struct perf_session *session)
 	char *buf, **mmaps = rd->mmaps;
 	u64 page_offset;
 
+	/*
+	 * Native-endian: MAP_SHARED + PROT_READ — the kernel
+	 * guarantees page-level coherence but a concurrent writer
+	 * could modify the file between validation and use.  This
+	 * is a theoretical TOCTOU that affects the entire perf.data
+	 * processing pipeline; fixing it would require copying each
+	 * event to a private buffer before processing.
+	 *
+	 * Cross-endian: MAP_PRIVATE + PROT_WRITE — swap handlers
+	 * get a copy-on-write snapshot immune to concurrent writes.
+	 */
 	mmap_prot  = PROT_READ;
 	mmap_flags = MAP_SHARED;
 
-- 
2.54.0

