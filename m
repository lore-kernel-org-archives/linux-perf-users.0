Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EFC19CD0A;
	Sun, 10 May 2026 03:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384081; cv=none; b=iolhOGXk2CidCCjrIPun9ghWD+FgYuhOcrnNZNTDW7tDpwcG831/MmLFV/uc3YpQd2j8urFCgMWR1/rIdsnPSqYQ5CGwrcavkjRkr2zNbqKk26kEkomc45piHR4r3HexNnTc7kkOmgIJBtmQOuAKk/e9/5eHaWt21Z8IIO62kOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384081; c=relaxed/simple;
	bh=GjI6Or9N8wBybD4ZEpZb3NVs1BbNqas2/5d/0tdTtXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lcr424BfAwGPvjsxBTw217J4HTVoYPHnTl+WiEdx6G1ASvD7bPvlQSssHzf9sdy9hZbTIb9nld5DYJ3hM4mFt06dpctz66fNXdH1+O0DfT7ROYQbboIYgaa52x3qb4nmSJ9kf6zbqvVMjydgW2FAYQHyPHZguLpddCXL1uZQ29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pNNFaMPT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNNFaMPT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C32ADC2BCB8;
	Sun, 10 May 2026 03:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384081;
	bh=GjI6Or9N8wBybD4ZEpZb3NVs1BbNqas2/5d/0tdTtXM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pNNFaMPTatR+2NEHMpHmlhcItsx2KdOp0heiuWVw4FTw3Qky0lw0wugz7GSkjzdph
	 QoUzDKFvRbGCV0otvwewl2LhwkE0kvDGbOHttU4PQK10kqkchAyt6XyBgGZr7p9tAI
	 9nNz/0sxadVT+o9R6NPxB2oDsNcM5HNEKt0qLWKZnKSX1G+4jqbc5oKo66+rErIjaI
	 J1lFm5CsLbO/KM/Ubsf7p9pq8W2Bo5eLjHHRsel8Ly4R7EPdk+iJK8wFMO4kqGO/m0
	 IwLyJxCUTzCMKJWcwiARLJWRXZefHsqx+ZZxT4gAYnl5TLw4MDdbpgq47seQo079jI
	 t/ypMOgXpnMkg==
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
Subject: [PATCH 01/28] perf session: Add minimum event size validation table
Date: Sun, 10 May 2026 00:33:52 -0300
Message-ID: <20260510033424.255812-2-acme@kernel.org>
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

Also guard event_swap() against crafted event types >=
PERF_RECORD_HEADER_MAX to prevent OOB reads on the
perf_event__swap_ops[] array.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 121 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index fe0de2a0277f09f9..aae0651fb6f025a1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1759,10 +1759,88 @@ int perf_session__deliver_synth_attr_event(struct perf_session *session,
 	return perf_session__deliver_synth_event(session, &ev.ev, NULL);
 }
 
+/*
+ * Minimum event sizes indexed by type.  Checked before swap and
+ * processing so that both cross-endian and native-endian paths
+ * are protected from accessing fields past the event boundary.
+ * Zero means no minimum beyond the 8-byte header (already
+ * enforced by the reader).
+ */
+static const u32 perf_event__min_size[PERF_RECORD_HEADER_MAX] = {
+	/*
+	 * offsetof() for types with a trailing variable-length string
+	 * (filename, comm, path, name, msg): sizeof() includes a
+	 * PATH_MAX or fixed-size array, but valid events only need
+	 * the fixed fields.  Null-termination is checked separately.
+	 *
+	 * PERF_RECORD_SAMPLE is omitted: all64_swap is bounded by
+	 * header.size, and the internal layout varies by sample_type
+	 * so a fixed minimum is not meaningful.
+	 */
+	[PERF_RECORD_MMAP]		  = offsetof(struct perf_record_mmap, filename),
+	[PERF_RECORD_LOST]		  = sizeof(struct perf_record_lost),
+	[PERF_RECORD_COMM]		  = offsetof(struct perf_record_comm, comm),
+	[PERF_RECORD_EXIT]		  = sizeof(struct perf_record_fork),
+	[PERF_RECORD_THROTTLE]		  = sizeof(struct perf_record_throttle),
+	[PERF_RECORD_UNTHROTTLE]	  = sizeof(struct perf_record_throttle),
+	[PERF_RECORD_FORK]		  = sizeof(struct perf_record_fork),
+	/*
+	 * The kernel dynamically sizes PERF_RECORD_READ based on
+	 * attr.read_format — the minimum has just pid + tid + value.
+	 */
+	[PERF_RECORD_READ]		  = offsetof(struct perf_record_read, time_enabled),
+	[PERF_RECORD_MMAP2]		  = offsetof(struct perf_record_mmap2, filename),
+	[PERF_RECORD_LOST_SAMPLES]	  = sizeof(struct perf_record_lost_samples),
+	[PERF_RECORD_AUX]		  = sizeof(struct perf_record_aux),
+	[PERF_RECORD_ITRACE_START]	  = sizeof(struct perf_record_itrace_start),
+	[PERF_RECORD_SWITCH]		  = sizeof(struct perf_event_header),
+	[PERF_RECORD_SWITCH_CPU_WIDE]	  = sizeof(struct perf_record_switch),
+	[PERF_RECORD_NAMESPACES]	  = sizeof(struct perf_record_namespaces),
+	[PERF_RECORD_CGROUP]		  = offsetof(struct perf_record_cgroup, path),
+	[PERF_RECORD_TEXT_POKE]		  = sizeof(struct perf_record_text_poke_event),
+	[PERF_RECORD_KSYMBOL]		  = offsetof(struct perf_record_ksymbol, name),
+	[PERF_RECORD_BPF_EVENT]		  = sizeof(struct perf_record_bpf_event),
+	[PERF_RECORD_HEADER_ATTR]	  = sizeof(struct perf_event_header) + PERF_ATTR_SIZE_VER0,
+	[PERF_RECORD_HEADER_EVENT_TYPE]	  = sizeof(struct perf_record_header_event_type),
+	[PERF_RECORD_HEADER_TRACING_DATA] = sizeof(struct perf_record_header_tracing_data),
+	[PERF_RECORD_AUX_OUTPUT_HW_ID]	  = sizeof(struct perf_record_aux_output_hw_id),
+	[PERF_RECORD_AUXTRACE_INFO]	  = sizeof(struct perf_record_auxtrace_info),
+	[PERF_RECORD_AUXTRACE]		  = sizeof(struct perf_record_auxtrace),
+	[PERF_RECORD_AUXTRACE_ERROR]	  = offsetof(struct perf_record_auxtrace_error, msg),
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
 static void event_swap(union perf_event *event, bool sample_id_all)
 {
 	perf_event__swap_op swap;
 
+	/* Prevent OOB read on perf_event__swap_ops[] from crafted type */
+	if (event->header.type >= PERF_RECORD_HEADER_MAX)
+		return;
+
 	swap = perf_event__swap_ops[event->header.type];
 	if (swap)
 		swap(event, sample_id_all);
@@ -1780,6 +1858,20 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 	if (session->one_mmap && !session->header.needs_swap) {
 		event = file_offset - session->one_mmap_offset +
 			session->one_mmap_addr;
+
+		/* Every event must at least contain its own header */
+		if (event->header.size < sizeof(struct perf_event_header))
+			return -1;
+
+		/* Reject undersized events on the native-endian fast path */
+		if (event->header.type < PERF_RECORD_HEADER_MAX) {
+			u32 min_sz = perf_event__min_size[event->header.type];
+
+			if (min_sz && event->header.size < min_sz) {
+				*event_ptr = event;
+				return -1;
+			}
+		}
 		goto out_parse_sample;
 	}
 
@@ -1810,6 +1902,20 @@ int perf_session__peek_event(struct perf_session *session, off_t file_offset,
 	if (readn(fd, buf, rest) != (ssize_t)rest)
 		return -1;
 
+	/* Reject undersized events before swapping */
+	if (event->header.type < PERF_RECORD_HEADER_MAX) {
+		u32 min_sz = perf_event__min_size[event->header.type];
+
+		if (min_sz && event->header.size < min_sz) {
+			pr_warning("WARNING: peek_event: %s event size %u too small (min %u)\n",
+				   perf_event__name(event->header.type),
+				   event->header.size, min_sz);
+			/* Expose so peek_events can advance past it */
+			*event_ptr = event;
+			return -1;
+		}
+	}
+
 	if (session->header.needs_swap)
 		event_swap(event, evlist__sample_id_all(session->evlist));
 
@@ -1860,6 +1966,21 @@ static s64 perf_session__process_event(struct perf_session *session,
 	const struct perf_tool *tool = session->tool;
 	int ret;
 
+	if (event->header.type < PERF_RECORD_HEADER_MAX) {
+		u32 min_sz = perf_event__min_size[event->header.type];
+
+		/*
+		 * Skip rather than abort: a crafted file may have
+		 * isolated bad events among otherwise valid data.
+		 */
+		if (min_sz && event->header.size < min_sz) {
+			pr_warning("WARNING: %s event size %u too small (min %u), skipping\n",
+				   perf_event__name(event->header.type),
+				   event->header.size, min_sz);
+			return 0;
+		}
+	}
+
 	if (session->header.needs_swap)
 		event_swap(event, evlist__sample_id_all(evlist));
 
-- 
2.54.0

