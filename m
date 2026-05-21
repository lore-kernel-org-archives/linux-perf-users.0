Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED82ED860;
	Thu, 21 May 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779325870; cv=none; b=U5QG3ZKZp56Ydia3zChbRZYQ42WEXy8mQdTvZOrH1CFAeSn1XL2RxDz8j7l3xg6f0OGtyMgC34nBCMibeVLXcimePBONpjZb4RRT5gyePk5+prNDsCY5tsYieqRynBlQxUUP3xYJwadnPxF6fNBlxA1hphriB/TYmJyhNcRbCUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779325870; c=relaxed/simple;
	bh=GkXEu7YCfzkuEEUmDf+aECIQzdnSKfyzIbK1DgiL7Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHY0K9wwUTlwZMIoMdWR3hFoRGUeDuR3k+zVgGCWr6UVlTpP9etLYr8+GeAShEOlT5BcUp3PQR/4iCuS4A8Xrkylf6k6O0H7aIB4oi/hS37RXmVeW00720xyZ/0uzenLrffE18aPQOHJML8CO2dbytUj0vHAf4vTOPKf+TOR+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Rh/rKu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Rh/rKu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611551F00A3B;
	Thu, 21 May 2026 01:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779325867;
	bh=YCdn1X0ClheJiE3+BbVIBf/67D2rccH+absKQ8IENCA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f9Rh/rKuRDF7KeinCSNSU/NEwDYexK+ZrA8dDfXB8yvQb5dqRvh+YyTFmZi+XOhq+
	 +fXKAgAdAFKiC3Zje7tB/jLYl5zQB9m1MGbo/U74d11ZnKvn+rQOupM33jTDZiNeZk
	 dzgVqyFb+nt2gp83H8zB+7sZS405sPmf/IGVtjodXSov5/yLoJngHx57xjTfSydUqz
	 rxr7nOs5nzMtMqUEzzNIBUMXNVb4W7GJ9Etpy/OHOcMQdcaTsi1k3ubnpv9z6vn8un
	 ZpJIEo3kJIqUoeaYSctkxK6aNJP/SjhPyXmP4GeUJUGtpRGAl9oXtCQ1NybuTO5ZRw
	 XGwcy+K3t0EEw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot@kernel.org,
	"Claude Opus 4.6 (1M context)" <noreply@anthropic.com>
Subject: [PATCH 07/27] perf session: Add validated swap infrastructure with null-termination checks
Date: Wed, 20 May 2026 22:09:52 -0300
Message-ID: <20260521011027.622268-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521011027.622268-1-acme@kernel.org>
References: <20260521011027.622268-1-acme@kernel.org>
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

 - Fix perf_event__time_conv_swap(): decouple time_cycles and
   time_mask into independent per-field event_contains() checks,
   so each field is only swapped when the event is large enough
   to contain it.  The original code guarded both fields under
   a single time_cycles check, which would swap time_mask on a
   short event that contains time_cycles but not time_mask.

 - Handle ABI0 (attr.size == 0) in perf_event__attr_swap()
   by substituting PERF_ATTR_SIZE_VER0, so bswap_safe()
   correctly swaps VER0 fields instead of skipping everything.

 - peek_events: on swap failure, advance past the malformed
   entry instead of aborting the loop.

Note: the nr-field bounds checks for namespaces, thread_map,
cpu_map, and stat_config arrays are added by a subsequent
patch ("perf session: Validate nr fields against event size
on both swap and common paths").  The HEADER_ATTR attr.size
validation is added by ("perf session: Validate HEADER_ATTR
attr.size before swapping").

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
 tools/perf/util/session.c | 389 ++++++++++++++++++++++++++++++--------
 1 file changed, 309 insertions(+), 80 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 415693a3450a7138..8c5b3323d0ee0823 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -286,28 +286,41 @@ static void swap_sample_id_all(union perf_event *event, void *data)
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
@@ -317,13 +330,19 @@ static void perf_event__mmap_swap(union perf_event *event,
 
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
@@ -341,12 +360,19 @@ static void perf_event__mmap2_swap(union perf_event *event,
 
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
@@ -356,10 +382,11 @@ static void perf_event__task_swap(union perf_event *event, bool sample_id_all)
 
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
 
@@ -373,9 +400,10 @@ static void perf_event__read_swap(union perf_event *event,
 	 */
 	tail = event->header.size - offsetof(struct perf_record_read, value);
 	mem_bswap_64(&event->read.value, tail);
+	return 0;
 }
 
-static void perf_event__aux_swap(union perf_event *event, bool sample_id_all)
+static int perf_event__aux_swap(union perf_event *event, bool sample_id_all)
 {
 	event->aux.aux_offset = bswap_64(event->aux.aux_offset);
 	event->aux.aux_size   = bswap_64(event->aux.aux_size);
@@ -383,19 +411,21 @@ static void perf_event__aux_swap(union perf_event *event, bool sample_id_all)
 
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
@@ -404,30 +434,45 @@ static void perf_event__switch_swap(union perf_event *event, bool sample_id_all)
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
@@ -435,10 +480,11 @@ static void perf_event__throttle_swap(union perf_event *event,
 
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
 
@@ -455,18 +501,25 @@ static void perf_event__namespaces_swap(union perf_event *event,
 
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
@@ -507,9 +560,19 @@ void perf_event__attr_swap(struct perf_event_attr *attr)
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
@@ -547,8 +610,8 @@ do { 						\
 #undef bswap_safe
 }
 
-static void perf_event__hdr_attr_swap(union perf_event *event,
-				      bool sample_id_all __maybe_unused)
+static int perf_event__hdr_attr_swap(union perf_event *event,
+				     bool sample_id_all __maybe_unused)
 {
 	size_t size;
 
@@ -557,30 +620,34 @@ static void perf_event__hdr_attr_swap(union perf_event *event,
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
 
@@ -589,10 +656,11 @@ static void perf_event__auxtrace_info_swap(union perf_event *event,
 	size = event->header.size;
 	size -= (void *)&event->auxtrace_info.priv - (void *)event;
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
@@ -600,10 +668,11 @@ static void perf_event__auxtrace_swap(union perf_event *event,
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
@@ -618,10 +687,11 @@ static void perf_event__auxtrace_error_swap(union perf_event *event,
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
 
@@ -629,10 +699,11 @@ static void perf_event__thread_map_swap(union perf_event *event,
 
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
 
@@ -670,20 +741,22 @@ static void perf_event__cpu_map_swap(union perf_event *event,
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
@@ -691,44 +764,90 @@ static void perf_event__stat_swap(union perf_event *event,
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
+	if (event_contains(event->time_conv, time_cycles))
 		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
+	if (event_contains(event->time_conv, time_mask))
 		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
-	}
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
+	event->bpf.type  = bswap_16(event->bpf.type);
+	event->bpf.flags = bswap_16(event->bpf.flags);
+	event->bpf.id    = bswap_32(event->bpf.id);
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
@@ -748,6 +867,8 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_SWITCH_CPU_WIDE]	  = perf_event__switch_swap,
 	[PERF_RECORD_NAMESPACES]	  = perf_event__namespaces_swap,
 	[PERF_RECORD_CGROUP]		  = perf_event__cgroup_swap,
+	[PERF_RECORD_KSYMBOL]		  = perf_event__ksymbol_swap,
+	[PERF_RECORD_BPF_EVENT]		  = perf_event__bpf_event_swap,
 	[PERF_RECORD_TEXT_POKE]		  = perf_event__text_poke_swap,
 	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = perf_event__all64_swap,
 	[PERF_RECORD_CALLCHAIN_DEFERRED]  = perf_event__all64_swap,
@@ -755,6 +876,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
 	[PERF_RECORD_HEADER_EVENT_TYPE]	  = perf_event__event_type_swap,
 	[PERF_RECORD_HEADER_TRACING_DATA] = perf_event__tracing_data_swap,
 	[PERF_RECORD_HEADER_BUILD_ID]	  = NULL,
+	[PERF_RECORD_HEADER_FEATURE]	  = perf_event__header_feature_swap,
 	[PERF_RECORD_ID_INDEX]		  = perf_event__all64_swap,
 	[PERF_RECORD_AUXTRACE_INFO]	  = perf_event__auxtrace_info_swap,
 	[PERF_RECORD_AUXTRACE]		  = perf_event__auxtrace_swap,
@@ -1481,6 +1603,25 @@ static int session__flush_deferred_samples(struct perf_session *session,
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
@@ -1529,16 +1670,32 @@ static int machines__deliver_event(struct machines *machines,
 		}
 		return evlist__deliver_sample(evlist, tool, event, sample, machine);
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
@@ -1577,11 +1734,25 @@ static int machines__deliver_event(struct machines *machines,
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
@@ -1787,12 +1958,28 @@ int perf_session__deliver_synth_attr_event(struct perf_session *session,
 	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
 }
 
+/* Caller must ensure event->header.type < PERF_RECORD_HEADER_MAX */
+static int event_swap(union perf_event *event, bool sample_id_all)
+{
+	perf_event__swap_op swap = perf_event__swap_ops[event->header.type];
+
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
@@ -1814,7 +2001,9 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	[PERF_RECORD_FORK]		  = sizeof(struct perf_record_fork),
 	/*
 	 * The kernel dynamically sizes PERF_RECORD_READ based on
-	 * attr.read_format — the minimum has just pid + tid + value.
+	 * attr.read_format — only the enabled fields are emitted,
+	 * packed with no gaps.  The minimum valid event has just
+	 * pid + tid + one u64 value (no optional fields).
 	 */
 	[PERF_RECORD_READ]		  = offsetof(struct perf_record_read, time_enabled),
 	[PERF_RECORD_MMAP2]		  = offsetof(struct perf_record_mmap2, filename) + 1,
@@ -1836,14 +2025,25 @@ static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
 	[PERF_RECORD_AUXTRACE]		  = sizeof(struct perf_record_auxtrace),
 	[PERF_RECORD_AUXTRACE_ERROR]	  = offsetof(struct perf_record_auxtrace_error, msg) + 1,
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
@@ -1879,14 +2079,6 @@ static bool perf_event__too_small(const union perf_event *event, u32 *min)
 	return false;
 }
 
-/* Caller must ensure event->header.type < PERF_RECORD_HEADER_MAX */
-static void event_swap(union perf_event *event, bool sample_id_all)
-{
-	perf_event__swap_op swap = perf_event__swap_ops[event->header.type];
-	if (swap)
-		swap(event, sample_id_all);
-}
-
 int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 			     void *buf, size_t buf_sz,
 			     union perf_event **event_ptr,
@@ -1957,8 +2149,16 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 		return -1;
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
 
 	if (sample && event->header.type < PERF_RECORD_USER_TYPE_START &&
 	    evlist__parse_sample(session->evlist, event, sample))
@@ -1976,11 +2176,25 @@ int perf_session__peek_events(struct perf_session *session, u64 offset,
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
+			if (event && event->header.size) {
+				offset += event->header.size;
+				err = 0;
+			} else {
+				return err;
+			}
+			continue;
+		}
 
 		err = cb(session, event, offset, data);
 		if (err)
@@ -2042,8 +2256,12 @@ static s64 perf_session__process_event(struct perf_session *session,
 		return 0;
 	}
 
-	if (session->header.needs_swap)
-		event_swap(event, evlist__sample_id_all(evlist));
+	if (session->header.needs_swap &&
+	    event_swap(event, evlist__sample_id_all(evlist))) {
+		pr_warning("WARNING: swap failed for %s event, skipping\n",
+			   perf_event__name(event->header.type));
+		return 0;
+	}
 
 	events_stats__inc(&evlist->stats, event->header.type);
 
@@ -2512,6 +2730,17 @@ reader__mmap(struct reader *rd, struct perf_session *session)
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

