Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA523ED6A;
	Sun, 24 May 2026 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593253; cv=none; b=KEZcy9RtgYY4sGqiBPSdlb9OhC31LBG69pHKBveMHQdMTc8l0IpOGI+JXq4AqPGXQulavrmzQdFH4cd9uDm4XJhhtsB2IMEfetwo+2g4JPBqSzQhaDsQMFRQI4AkooW+ylA7XgQB20W21HOftcUo4hdAY/y/PzdZKLXLFuTJhzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593253; c=relaxed/simple;
	bh=m3Nyc1/tMu2Qw0Ch4VxQWF/Vv5iYyTVVIJHhb1fDxKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDtq8gOMovMQAw3nO13uTfbKb9bdp6JLUVpIvjl5SKecwA8xvvOXqmwLa5wXwKd4d4BwrFgv1cw69BWrQ6VwRsVCG893BqeX1hzQJlnlko9PIT2uaADLGiAn5KNJ9Mnk5Hj+WNl+kF5TMTiJ31TBP3lbsifZafaIpMgyIcFvN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlD+pjMg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlD+pjMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBCD31F00A3A;
	Sun, 24 May 2026 03:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593251;
	bh=SWCMSnNtfVnyAWAIWVo7IK27z/JemwC0+SY2Gkyjx2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RlD+pjMgPwR5bFwv1iEGrhgCj1DnBwcO/5ABzgHyqEVVEXfNX9VdWANZHqvtytL/V
	 rLnlwuVRs+Yw3gGnQNk68A0rrsE0E7M4KmOdSLjXMgFRFxJkcFp8GPb0+FpZcHZd1K
	 Yyn/FX2eiMtKnnzpNA3Igy1J+mf7PBcnzlNcI7Bt6mEajAKcsz8GNIG5RBjcI/ifXE
	 gxjrIPcQlPqMVVgAWwOD5SUiRguFu1UZu6V7kc/AWaL6Uj5kRlplidXhBDN0gXxKht
	 HpiFGn25ls6gJSjauEfsh5YjtKiaH4RkXX1oxrH+2sZEbzIZ7uf2Nik7F8c1DDGuCT
	 cBncvoylpPMOA==
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
Subject: [PATCH 01/29] perf session: Add minimum event size and alignment validation
Date: Sun, 24 May 2026 00:26:35 -0300
Message-ID: <20260524032709.1080771-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524032709.1080771-1-acme@kernel.org>
References: <20260524032709.1080771-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Add a per-type minimum size table (perf_event__min_size[]) and
enforce it before swap and processing, so that both cross-endian
and native-endian paths are protected from accessing fields past
the event boundary.

The table uses offsetof() for types with trailing variable-length
fields (filenames, strings, msg arrays) and sizeof() for
fixed-size types.  Zero entries mean no minimum beyond the 8-byte
header already enforced by the reader.

Undersized events are skipped with a warning in process_event
and rejected in peek_event — both checked before the swap
handler runs, preventing OOB access on crafted event fields.

Also reject events whose header.size is not 8-byte aligned.  The
kernel aligns all event sizes to sizeof(u64) — see
perf_event_comm_event() (ALIGN), perf_event_mmap_event(),
perf_event_cgroup(), perf_event_ksymbol() (IS_ALIGNED loops),
and perf_event_text_poke() (ALIGN) in kernel/events/core.c.
An unaligned size means the file is corrupted or crafted; reject
early so downstream code that divides by sizeof(u64) to compute
array element counts gets exact results.

Three legacy user events are exempted from the alignment check:
TRACING_DATA (66) had a 12-byte struct before commit b39c915a4f36
("libperf event: Ensure tracing data is multiple of 8 sized")
added padding, COMPRESSED (81) carries raw ZSTD output (already
superseded by COMPRESSED2 with PERF_ALIGN), and HEADER_FEATURE
(80) uses do_write_string() with a 4-byte length prefix.

Also guard event_swap() against crafted event types >=
PERF_RECORD_HEADER_MAX to prevent OOB reads on the
perf_event__swap_ops[] array.

Changes in v2:
- Fix double-skip for unsupported event types: return 0 instead
  of event->header.size in perf_session__process_event() for
  HEADER_MAX, since reader__read_event() already advances by
  event->header.size (Reported-by: sashiko-bot@kernel.org)
- Exempt TRACING_DATA, COMPRESSED, and HEADER_FEATURE from the
  alignment check — these legacy user events predate the 8-byte
  alignment rule (Reported-by: sashiko-bot@kernel.org)
- peek_event: return 0 (skip) for unknown event types instead of
  -1 (error), consistent with process_event which already skips
  unsupported types gracefully (Reported-by: sashiko-bot@kernel.org)

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 253 +++++++++++++++++++++++++++++++++-----
 1 file changed, 220 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1e25892963b7857a..0523fd243e02c09b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1759,15 +1759,121 @@ int perf_session__deliver_synth_attr_event(struct perf_session *session,
 	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
 }
 
-static void event_swap(union perf_event *event, bool sample_id_all)
+/*
+ * Minimum event sizes indexed by type.  Checked before swap and
+ * processing so that both cross-endian and native-endian paths
+ * are protected from accessing fields past the event boundary.
+ * Zero means no minimum beyond the 8-byte header (already
+ * enforced by the reader).
+ */
+static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
+	/*
+	 * offsetof() + 1 for types with a trailing variable-length
+	 * string (filename, comm, path, name, msg): the +1 ensures
+	 * room for at least a null terminator.  Full null-termination
+	 * within the event boundary is checked separately.
+	 *
+	 * PERF_RECORD_SAMPLE is omitted: all64_swap is bounded by
+	 * header.size, and the internal layout varies by sample_type
+	 * so a fixed minimum is not meaningful.
+	 */
+	[PERF_RECORD_MMAP]		  = offsetof(struct perf_record_mmap, filename) + 1,
+	[PERF_RECORD_LOST]		  = sizeof(struct perf_record_lost),
+	[PERF_RECORD_COMM]		  = offsetof(struct perf_record_comm, comm) + 1,
+	[PERF_RECORD_EXIT]		  = sizeof(struct perf_record_fork),
+	[PERF_RECORD_THROTTLE]		  = sizeof(struct perf_record_throttle),
+	[PERF_RECORD_UNTHROTTLE]	  = sizeof(struct perf_record_throttle),
+	[PERF_RECORD_FORK]		  = sizeof(struct perf_record_fork),
+	/*
+	 * The kernel dynamically sizes PERF_RECORD_READ based on
+	 * attr.read_format — the minimum has just pid + tid + value.
+	 */
+	[PERF_RECORD_READ]		  = offsetof(struct perf_record_read, time_enabled),
+	[PERF_RECORD_MMAP2]		  = offsetof(struct perf_record_mmap2, filename) + 1,
+	[PERF_RECORD_LOST_SAMPLES]	  = sizeof(struct perf_record_lost_samples),
+	[PERF_RECORD_AUX]		  = sizeof(struct perf_record_aux),
+	[PERF_RECORD_ITRACE_START]	  = sizeof(struct perf_record_itrace_start),
+	[PERF_RECORD_SWITCH]		  = sizeof(struct perf_event_header),
+	[PERF_RECORD_SWITCH_CPU_WIDE]	  = sizeof(struct perf_record_switch),
+	[PERF_RECORD_NAMESPACES]	  = sizeof(struct perf_record_namespaces),
+	[PERF_RECORD_CGROUP]		  = offsetof(struct perf_record_cgroup, path) + 1,
+	[PERF_RECORD_TEXT_POKE]		  = sizeof(struct perf_record_text_poke_event),
+	[PERF_RECORD_KSYMBOL]		  = offsetof(struct perf_record_ksymbol, name) + 1,
+	[PERF_RECORD_BPF_EVENT]		  = sizeof(struct perf_record_bpf_event),
+	[PERF_RECORD_HEADER_ATTR]	  = sizeof(struct perf_event_header) + PERF_ATTR_SIZE_VER0,
+	[PERF_RECORD_HEADER_EVENT_TYPE]	  = sizeof(struct perf_record_header_event_type),
+	/* Legacy events predate the __u32 pad field, accept 12-byte records */
+	[PERF_RECORD_HEADER_TRACING_DATA] = offsetof(struct perf_record_header_tracing_data, pad),
+	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = sizeof(struct perf_record_aux_output_hw_id),
+	[PERF_RECORD_AUXTRACE_INFO]	  = sizeof(struct perf_record_auxtrace_info),
+	[PERF_RECORD_AUXTRACE]		  = sizeof(struct perf_record_auxtrace),
+	[PERF_RECORD_AUXTRACE_ERROR]	  = offsetof(struct perf_record_auxtrace_error, msg) + 1,
+	[PERF_RECORD_THREAD_MAP]	  = sizeof(struct perf_record_thread_map),
+	/* Smallest valid variant is RANGE_CPUS: header(8) + type(2) + range(6) */
+	[PERF_RECORD_CPU_MAP]		  = sizeof(struct perf_event_header) +
+					    sizeof(__u16) +
+					    sizeof(struct perf_record_range_cpu_map),
+	[PERF_RECORD_STAT_CONFIG]	  = sizeof(struct perf_record_stat_config),
+	[PERF_RECORD_STAT]		  = sizeof(struct perf_record_stat),
+	[PERF_RECORD_STAT_ROUND]	  = sizeof(struct perf_record_stat_round),
+	/* Union inflates sizeof; use fixed header fields as minimum */
+	[PERF_RECORD_EVENT_UPDATE]	  = offsetof(struct perf_record_event_update, scale),
+	[PERF_RECORD_TIME_CONV]		  = offsetof(struct perf_record_time_conv, time_cycles),
+	[PERF_RECORD_ID_INDEX]		  = sizeof(struct perf_record_id_index),
+	[PERF_RECORD_HEADER_BUILD_ID]	  = sizeof(struct perf_record_header_build_id),
+	[PERF_RECORD_HEADER_FEATURE]	  = sizeof(struct perf_record_header_feature),
+	[PERF_RECORD_COMPRESSED2]	  = sizeof(struct perf_record_compressed2),
+	[PERF_RECORD_BPF_METADATA]	  = sizeof(struct perf_record_bpf_metadata),
+	[PERF_RECORD_CALLCHAIN_DEFERRED]  = sizeof(struct perf_event_header) + sizeof(__u64),
+	/*
+	 * SCHEDSTAT events have a version-dependent union after the
+	 * fixed header fields; the minimum is the base (pre-union)
+	 * portion so old and new versions both pass.
+	 */
+	[PERF_RECORD_SCHEDSTAT_CPU]	  = offsetof(struct perf_record_schedstat_cpu, v15),
+	[PERF_RECORD_SCHEDSTAT_DOMAIN]	  = offsetof(struct perf_record_schedstat_domain, v15),
+};
+
+/*
+ * Return true if the event is too small for its declared type.
+ * Caller must ensure event->header.type < PERF_RECORD_HEADER_MAX.
+ * If min is non-NULL, stores the required minimum on failure.
+ */
+static bool perf_event__too_small(const union perf_event *event, u32 *min)
 {
-	perf_event__swap_op swap;
+	u32 min_sz = perf_event__min_size[event->header.type];
+
+	if (min_sz && event->header.size < min_sz) {
+		if (min)
+			*min = min_sz;
+		return true;
+	}
 
-	swap = perf_event__swap_ops[event->header.type];
+	return false;
+}
+
+/* Caller must ensure event->header.type < PERF_RECORD_HEADER_MAX */
+static void event_swap(union perf_event *event, bool sample_id_all)
+{
+	perf_event__swap_op swap = perf_event__swap_ops[event->header.type];
 	if (swap)
 		swap(event, sample_id_all);
 }
 
+/*
+ * Read and validate the event at @file_offset.
+ *
+ * Returns:
+ *   0  — success: *event_ptr is set and safe to access.
+ *  -1  — error; check *event_ptr to decide whether to advance or abort:
+ *          *event_ptr set  — event header was read but the event is
+ *                            malformed (too small for its type, or byte-swap
+ *                            failed).  header.size is still valid, so the
+ *                            caller can advance past the event.
+ *          *event_ptr NULL — fatal: couldn't read the header at all
+ *                            (I/O error, offset out of range, pipe mode).
+ *                            Caller must abort.
+ */
 int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 			     void *buf, size_t buf_sz,
 			     union perf_event **event_ptr,
@@ -1775,52 +1881,85 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 {
 	union perf_event *event;
 	size_t hdr_sz, rest;
+	u32 min_sz;
 	int fd;
 
+	*event_ptr = NULL;
+
 	if (session->one_mmap && !session->header.needs_swap) {
 		event = file_offset - session->one_mmap_offset +
 			session->one_mmap_addr;
-		goto out_parse_sample;
-	}
 
-	if (perf_data__is_pipe(session->data))
-		return -1;
+		/* Every event must at least contain its own header */
+		if (event->header.size < sizeof(struct perf_event_header))
+			return -1;
+	} else {
+		if (perf_data__is_pipe(session->data))
+			return -1;
 
-	fd = perf_data__fd(session->data);
-	hdr_sz = sizeof(struct perf_event_header);
+		fd = perf_data__fd(session->data);
+		hdr_sz = sizeof(struct perf_event_header);
 
-	if (buf_sz < hdr_sz)
-		return -1;
+		if (buf_sz < hdr_sz)
+			return -1;
 
-	if (lseek(fd, file_offset, SEEK_SET) == (off_t)-1 ||
-	    readn(fd, buf, hdr_sz) != (ssize_t)hdr_sz)
-		return -1;
+		if (lseek(fd, file_offset, SEEK_SET) == (off_t)-1 ||
+		    readn(fd, buf, hdr_sz) != (ssize_t)hdr_sz)
+			return -1;
 
-	event = (union perf_event *)buf;
+		event = (union perf_event *)buf;
 
-	if (session->header.needs_swap)
-		perf_event_header__bswap(&event->header);
+		if (session->header.needs_swap)
+			perf_event_header__bswap(&event->header);
+
+		if (event->header.size < hdr_sz || event->header.size > buf_sz)
+			return -1;
+
+		buf += hdr_sz;
+		rest = event->header.size - hdr_sz;
+
+		if (readn(fd, buf, rest) != (ssize_t)rest)
+			return -1;
+	}
 
-	if (event->header.size < hdr_sz || event->header.size > buf_sz)
+	/* Event data is fully loaded — expose so callers can advance */
+	*event_ptr = event;
+
+	/*
+	 * Check alignment before type: an unaligned size misaligns the
+	 * stream for all subsequent reads regardless of event type.
+	 * Three legacy user events predate the 8-byte rule — exempt them.
+	 */
+	if (event->header.size % sizeof(u64) &&
+	    event->header.type != PERF_RECORD_HEADER_TRACING_DATA &&
+	    event->header.type != PERF_RECORD_COMPRESSED &&
+	    event->header.type != PERF_RECORD_HEADER_FEATURE) {
+		pr_warning("WARNING: peek_event: event type %u size %u not aligned to %zu\n",
+			   event->header.type,
+			   event->header.size, sizeof(u64));
 		return -1;
+	}
 
-	buf += hdr_sz;
-	rest = event->header.size - hdr_sz;
+	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
+		pr_warning("WARNING: peek_event: unsupported event type %u, skipping\n",
+			   event->header.type);
+		return 0;
+	}
 
-	if (readn(fd, buf, rest) != (ssize_t)rest)
+	if (perf_event__too_small(event, &min_sz)) {
+		pr_warning("WARNING: peek_event: %s event size %u too small (min %u)\n",
+			   perf_event__name(event->header.type),
+			   event->header.size, min_sz);
 		return -1;
+	}
 
 	if (session->header.needs_swap)
 		event_swap(event, evlist__sample_id_all(session->evlist));
 
-out_parse_sample:
-
 	if (sample && event->header.type < PERF_RECORD_USER_TYPE_START &&
 	    evlist__parse_sample(session->evlist, event, sample))
 		return -1;
 
-	*event_ptr = event;
-
 	return 0;
 }
 
@@ -1858,23 +1997,71 @@ static s64 perf_session__process_event(struct perf_session *session,
 {
 	struct evlist *evlist = session->evlist;
 	const struct perf_tool *tool = session->tool;
+	u32 min_sz;
 	int ret;
 
-	if (session->header.needs_swap)
-		event_swap(event, evlist__sample_id_all(evlist));
+	/*
+	 * The kernel aligns all event sizes to sizeof(u64) — see
+	 * perf_event_comm_event() (ALIGN), perf_event_mmap_event(),
+	 * perf_event_cgroup(), perf_event_ksymbol() (IS_ALIGNED loops),
+	 * and perf_event_text_poke() (ALIGN) in kernel/events/core.c.
+	 *
+	 * An unaligned size means the file is corrupted or crafted.
+	 * Abort: there is no point continuing to read unaligned records
+	 * because the caller advances rd->head by event->header.size,
+	 * so every subsequent read would start at a misaligned offset,
+	 * producing garbage headers for the rest of the file.
+	 *
+	 * Exempt three legacy user events that predate the alignment rule:
+	 *
+	 * TRACING_DATA (66): struct tracing_data_event was 12 bytes before
+	 *   b39c915a4f36 ("libperf event: Ensure tracing data is multiple
+	 *   of 8 sized") added __u32 pad; old perf.data files still contain
+	 *   12-byte records.
+	 *   TODO: introduce HEADER_TRACING_DATA2 with guaranteed alignment.
+	 *
+	 * COMPRESSED (81): raw ZSTD output, arbitrary length.  Already
+	 *   superseded by COMPRESSED2 (83) with PERF_ALIGN.
+	 *
+	 * HEADER_FEATURE (80): do_write_string() uses a 4-byte length
+	 *   prefix with no padding to 8-byte total.
+	 *   TODO: introduce HEADER_FEATURE2 with guaranteed alignment.
+	 */
+	if (event->header.size % sizeof(u64) &&
+	    event->header.type != PERF_RECORD_HEADER_TRACING_DATA &&
+	    event->header.type != PERF_RECORD_COMPRESSED &&
+	    event->header.type != PERF_RECORD_HEADER_FEATURE) {
+		pr_err("ERROR: %s event size %u is not 8-byte aligned, aborting\n",
+		       perf_event__name(event->header.type),
+		       event->header.size);
+		return -EINVAL;
+	}
 
 	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
-		/* perf should not support unaligned event, stop here. */
-		if (event->header.size % sizeof(u64))
-			return -EINVAL;
-
 		/* This perf is outdated and does not support the latest event type. */
 		ui__warning("Unsupported header type %u, please consider updating perf.\n",
 			    event->header.type);
-		/* Skip unsupported event by returning its size. */
-		return event->header.size;
+		/*
+		 * Return 0 to skip: the caller (reader__read_event)
+		 * already advances by event->header.size.
+		 */
+		return 0;
 	}
 
+	/*
+	 * Skip rather than abort: a too-small-but-aligned event
+	 * can be safely stepped over without misaligning the stream.
+	 */
+	if (perf_event__too_small(event, &min_sz)) {
+		pr_warning("WARNING: %s event size %u too small (min %u), skipping\n",
+			   perf_event__name(event->header.type),
+			   event->header.size, min_sz);
+		return 0;
+	}
+
+	if (session->header.needs_swap)
+		event_swap(event, evlist__sample_id_all(evlist));
+
 	events_stats__inc(&evlist->stats, event->header.type);
 
 	if (event->header.type >= PERF_RECORD_USER_TYPE_START)
-- 
2.54.0

