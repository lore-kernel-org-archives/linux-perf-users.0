Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDF3C09EB;
	Tue, 26 May 2026 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830336; cv=none; b=m7QN+zdl4Dqe6KPYlFcbVDBj+ONIUBfTI4Sa/tLIaaPUHynxMBfaR1CgUMCPeE28DervPl0scQt5hQEaUr5kqMd13kTBfUvyBLEIXNIk5Md4vw9lnkE2lVdcYzYF5+n/70bVWtQDau1xoZDevPmo1CXKkXL0MITEk2k+ivtP28o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830336; c=relaxed/simple;
	bh=IMm6QqciKoj9L86ffNAHT3CHzVjj1Uev6t0eb+VdG2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPamZoSE8PDnqHtKOjDqJPVNFN4NfGpx28sgek/mhqlWSQtHbaWK6P98rvPAa5BoHhYzHWAUZ0iLolxFUarxXYgCMn4aG3o5RTQIE9y7DhCPytYTbyW4807BpmEPcVP3I1SvZ79PQbhYW8Rs8JNgi+Jom3PYZAOPKUgkpqahdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq3ybSxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq3ybSxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702C01F00A3A;
	Tue, 26 May 2026 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830334;
	bh=PqqN3TMSovKEaOntcbHHKrbyahaJzHRxFuKowFiVyu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tq3ybSxeZBmhemwuvFkqPWyo+aKtN/vVjX0WBNYkDNQX9gN+4KUmWQ6/F9pRP9X1b
	 g1Xm7c+IwY/jVxwkndf4gWIG2hwE45RPy0l/Uunb9IfetATZ+kVDQD1Dp+ZxKPYEBw
	 RKRBm8NkS+gEw13NiJjccUngl5wT9ig5piPHo/uur9U5D4ArNUBakCQj478MxCBFI9
	 UXDmquvTuxM8TIEQo8fLhxPxirP8hB88zgqVfEGmWbJ4layBVqwad5z+ME1Owe5nq8
	 /s7r5UQjWs7a+NiLLE7h9sE35/rgUEJ9GnUDqZNt48HAtTbycpHEZ+VOxwaLVjp3X1
	 Sla7dy9l+uH6g==
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
Subject: [PATCH 11/29] perf session: Validate nr fields against event size on both swap and common paths
Date: Tue, 26 May 2026 18:17:47 -0300
Message-ID: <20260526211806.1193848-12-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526211806.1193848-1-acme@kernel.org>
References: <20260526211806.1193848-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Several event types use an nr field to control iteration over
variable-length arrays.  The swap handlers byte-swap and loop using
these fields without bounds checks, and the native processing path
trusts them as well.

Add bounds checks on both paths for:

- PERF_RECORD_THREAD_MAP: validate nr against payload, return -1
  on the swap path.  On the native path, reject with -EINVAL.

- PERF_RECORD_NAMESPACES: clamp nr on the swap path (safe because
  each entry is indexed by type; missing entries just won't be
  resolved).  Skip the event on the native path.

- PERF_RECORD_CPU_MAP: clamp nr for CPUS and MASK sub-types on
  the swap path.  Add bounds checks for mask64 which previously
  had no nr validation.  Skip the event on the native path.

- PERF_RECORD_STAT_CONFIG: clamp nr on the swap path (safe because
  each config entry is self-describing via its tag).  Skip the
  event on the native path.

The swap path (cross-endian, writable MAP_PRIVATE mapping) can
safely clamp by writing back to the event.  The native path
(read-only MAP_SHARED mapping) must skip instead of clamping
because writing to the mmap'd event would segfault.

Also fix stat_config swap range: change size += 1 to
size += sizeof(event->stat_config.nr) for clarity.  The old +1
happened to work because mem_bswap_64 processes 8-byte chunks,
but the intent is to include the 8-byte nr field in the swap
range.

Changes in v2:
- Document that PERF_RECORD_NAMESPACES max_nr includes trailing
  sample_id space when sample_id_all is present — harmless on the
  swap path because both per-element bswap_64 and swap_sample_id_all()
  perform the same u64 byte swap (Reported-by: sashiko-bot@kernel.org)

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 253 +++++++++++++++++++++++++++++++++++---
 1 file changed, 234 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index aef10d42be35487a..8588e12f110fca70 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -496,13 +496,35 @@ static int perf_event__throttle_swap(union perf_event *event,
 static int perf_event__namespaces_swap(union perf_event *event,
 				       bool sample_id_all)
 {
-	u64 i;
+	u64 i, nr, max_nr;
 
 	event->namespaces.pid		= bswap_32(event->namespaces.pid);
 	event->namespaces.tid		= bswap_32(event->namespaces.tid);
 	event->namespaces.nr_namespaces	= bswap_64(event->namespaces.nr_namespaces);
 
-	for (i = 0; i < event->namespaces.nr_namespaces; i++) {
+	nr = event->namespaces.nr_namespaces;
+	/*
+	 * Cannot underflow: perf_event__min_size[] guarantees header.size >= sizeof.
+	 * When sample_id_all is present max_nr slightly overestimates the
+	 * array space because header.size includes the trailing sample_id.
+	 * Harmless: both the per-element bswap_64 loop and swap_sample_id_all()
+	 * perform the same u64 byte swap, so the result is correct regardless
+	 * of where the boundary between array and sample_id falls.
+	 */
+	max_nr = (event->header.size - sizeof(event->namespaces)) /
+		 sizeof(event->namespaces.link_info[0]);
+	/*
+	 * Safe to clamp: each namespace entry is indexed by type;
+	 * missing entries just won't be resolved.
+	 */
+	if (nr > max_nr) {
+		pr_warning("WARNING: PERF_RECORD_NAMESPACES: nr_namespaces %" PRIu64 " exceeds payload (max %" PRIu64 "), clamping\n",
+			   nr, max_nr);
+		nr = max_nr;
+		event->namespaces.nr_namespaces = nr;
+	}
+
+	for (i = 0; i < nr; i++) {
 		struct perf_ns_link_info *ns = &event->namespaces.link_info[i];
 
 		ns->dev = bswap_64(ns->dev);
@@ -734,11 +756,23 @@ static int perf_event__auxtrace_error_swap(union perf_event *event,
 static int perf_event__thread_map_swap(union perf_event *event,
 				       bool sample_id_all __maybe_unused)
 {
-	unsigned i;
+	unsigned int i;
+	u64 nr;
 
 	event->thread_map.nr = bswap_64(event->thread_map.nr);
 
-	for (i = 0; i < event->thread_map.nr; i++)
+	/*
+	 * Reject rather than clamp: unlike namespaces (indexed by type)
+	 * or stat_config (self-describing tags), a truncated thread map
+	 * is structurally broken — downstream would get a wrong map.
+	 */
+	/* Cannot underflow: perf_event__min_size[] guarantees header.size >= sizeof */
+	nr = event->thread_map.nr;
+	if (nr > (event->header.size - sizeof(event->thread_map)) /
+		  sizeof(event->thread_map.entries[0]))
+		return -1;
+
+	for (i = 0; i < nr; i++)
 		event->thread_map.entries[i].pid = bswap_64(event->thread_map.entries[i].pid);
 	return 0;
 }
@@ -747,32 +781,80 @@ static int perf_event__cpu_map_swap(union perf_event *event,
 				    bool sample_id_all __maybe_unused)
 {
 	struct perf_record_cpu_map_data *data = &event->cpu_map.data;
+	u32 payload = event->header.size - sizeof(event->header);
 
 	data->type = bswap_16(data->type);
 
+	/*
+	 * Safe to clamp: a shorter CPU map just means some CPUs
+	 * are absent; tools process the CPUs that are present.
+	 */
 	switch (data->type) {
-	case PERF_CPU_MAP__CPUS:
-		data->cpus_data.nr = bswap_16(data->cpus_data.nr);
+	case PERF_CPU_MAP__CPUS: {
+		u16 nr, max_nr;
 
-		for (unsigned i = 0; i < data->cpus_data.nr; i++)
+		data->cpus_data.nr = bswap_16(data->cpus_data.nr);
+		nr = data->cpus_data.nr;
+		max_nr = (payload - offsetof(struct perf_record_cpu_map_data,
+					     cpus_data.cpu)) /
+			 sizeof(data->cpus_data.cpu[0]);
+		if (nr > max_nr) {
+			pr_warning("WARNING: PERF_RECORD_CPU_MAP: nr %u exceeds payload (max %u), clamping\n",
+				   nr, max_nr);
+			nr = max_nr;
+			data->cpus_data.nr = nr;
+		}
+		for (unsigned int i = 0; i < nr; i++)
 			data->cpus_data.cpu[i] = bswap_16(data->cpus_data.cpu[i]);
 		break;
+	}
 	case PERF_CPU_MAP__MASK:
 		data->mask32_data.long_size = bswap_16(data->mask32_data.long_size);
 
 		switch (data->mask32_data.long_size) {
-		case 4:
+		case 4: {
+			u16 nr, max_nr;
+
 			data->mask32_data.nr = bswap_16(data->mask32_data.nr);
-			for (unsigned i = 0; i < data->mask32_data.nr; i++)
+			nr = data->mask32_data.nr;
+			max_nr = (payload - offsetof(struct perf_record_cpu_map_data,
+						     mask32_data.mask)) /
+				 sizeof(data->mask32_data.mask[0]);
+			if (nr > max_nr) {
+				pr_warning("WARNING: PERF_RECORD_CPU_MAP mask32: nr %u exceeds payload (max %u), clamping\n",
+					   nr, max_nr);
+				nr = max_nr;
+				data->mask32_data.nr = nr;
+			}
+			for (unsigned int i = 0; i < nr; i++)
 				data->mask32_data.mask[i] = bswap_32(data->mask32_data.mask[i]);
 			break;
-		case 8:
+		}
+		case 8: {
+			u16 nr, max_nr;
+
 			data->mask64_data.nr = bswap_16(data->mask64_data.nr);
-			for (unsigned i = 0; i < data->mask64_data.nr; i++)
+			nr = data->mask64_data.nr;
+			if (payload < offsetof(struct perf_record_cpu_map_data, mask64_data.mask)) {
+				data->mask64_data.nr = 0;
+				break;
+			}
+			max_nr = (payload - offsetof(struct perf_record_cpu_map_data,
+						     mask64_data.mask)) /
+				 sizeof(data->mask64_data.mask[0]);
+			if (nr > max_nr) {
+				pr_warning("WARNING: PERF_RECORD_CPU_MAP mask64: nr %u exceeds payload (max %u), clamping\n",
+					   nr, max_nr);
+				nr = max_nr;
+				data->mask64_data.nr = nr;
+			}
+			for (unsigned int i = 0; i < nr; i++)
 				data->mask64_data.mask[i] = bswap_64(data->mask64_data.mask[i]);
 			break;
+		}
 		default:
-			pr_err("cpu_map swap: unsupported long size\n");
+			pr_err("cpu_map swap: unsupported long size %u\n",
+			       data->mask32_data.long_size);
 		}
 		break;
 	case PERF_CPU_MAP__RANGE_CPUS:
@@ -788,11 +870,27 @@ static int perf_event__cpu_map_swap(union perf_event *event,
 static int perf_event__stat_config_swap(union perf_event *event,
 					bool sample_id_all __maybe_unused)
 {
-	u64 size;
+	u64 nr, max_nr, size;
 
-	size  = bswap_64(event->stat_config.nr) * sizeof(event->stat_config.data[0]);
-	size += 1; /* nr item itself */
+	nr = bswap_64(event->stat_config.nr);
+	/* Cannot underflow: perf_event__min_size[] guarantees header.size >= sizeof */
+	max_nr = (event->header.size - sizeof(event->stat_config)) /
+		 sizeof(event->stat_config.data[0]);
+	/*
+	 * Safe to clamp: each config entry is self-describing
+	 * via its tag; missing entries keep their defaults.
+	 */
+	if (nr > max_nr) {
+		pr_warning("WARNING: PERF_RECORD_STAT_CONFIG: nr %" PRIu64 " exceeds payload (max %" PRIu64 "), clamping\n",
+			   nr, max_nr);
+		nr = max_nr;
+	}
+	size = nr * sizeof(event->stat_config.data[0]);
+	/* The swap starts at &nr, so add its size to cover the full range */
+	size += sizeof(event->stat_config.nr);
 	mem_bswap_64(&event->stat_config.nr, size);
+	/* Persist the clamped value in native byte order */
+	event->stat_config.nr = nr;
 	return 0;
 }
 
@@ -1730,8 +1828,27 @@ static int machines__deliver_event(struct machines *machines,
 					   "COMM"))
 			return 0;
 		return tool->comm(tool, event, sample, machine);
-	case PERF_RECORD_NAMESPACES:
+	case PERF_RECORD_NAMESPACES: {
+		/*
+		 * Cannot underflow: perf_event__min_size[] guarantees header.size >= sizeof.
+		 * Includes trailing sample_id space when present, but prevents OOB.
+		 */
+		u64 max_nr = (event->header.size - sizeof(event->namespaces)) /
+			     sizeof(event->namespaces.link_info[0]);
+
+		/*
+		 * Native-endian events are mmap'd read-only, so we
+		 * cannot clamp nr in place.  Skip the event instead.
+		 * The swap handler already clamps on the writable
+		 * cross-endian path.
+		 */
+		if (event->namespaces.nr_namespaces > max_nr) {
+			pr_warning("WARNING: PERF_RECORD_NAMESPACES: nr_namespaces %" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
+				   (u64)event->namespaces.nr_namespaces, max_nr);
+			return 0;
+		}
 		return tool->namespaces(tool, event, sample, machine);
+	}
 	case PERF_RECORD_CGROUP:
 		if (!perf_event__check_nul(event->cgroup.path,
 					   (void *)event + event->header.size,
@@ -1912,15 +2029,112 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		perf_session__auxtrace_error_inc(session, event);
 		err = tool->auxtrace_error(tool, session, event);
 		break;
-	case PERF_RECORD_THREAD_MAP:
+	case PERF_RECORD_THREAD_MAP: {
+		u64 max_nr;
+
+		if (event->header.size < sizeof(event->thread_map)) {
+			pr_err("PERF_RECORD_THREAD_MAP: header.size (%u) too small\n",
+			       event->header.size);
+			err = -EINVAL;
+			break;
+		}
+
+		max_nr = (event->header.size - sizeof(event->thread_map)) /
+			 sizeof(event->thread_map.entries[0]);
+		if (event->thread_map.nr > max_nr) {
+			pr_err("PERF_RECORD_THREAD_MAP: nr %" PRIu64 " exceeds max %" PRIu64 "\n",
+			       (u64)event->thread_map.nr, max_nr);
+			err = -EINVAL;
+			break;
+		}
+
 		err = tool->thread_map(tool, session, event);
 		break;
-	case PERF_RECORD_CPU_MAP:
+	}
+	case PERF_RECORD_CPU_MAP: {
+		struct perf_record_cpu_map_data *data = &event->cpu_map.data;
+		u32 payload = event->header.size - sizeof(event->header);
+
+		/*
+		 * Native-endian events are mmap'd read-only, so we
+		 * cannot clamp nr fields in place.  Skip the event
+		 * if any variant overflows.
+		 */
+		switch (data->type) {
+		case PERF_CPU_MAP__CPUS: {
+			u16 max_nr = (payload - offsetof(struct perf_record_cpu_map_data,
+							 cpus_data.cpu)) /
+				     sizeof(data->cpus_data.cpu[0]);
+
+			if (data->cpus_data.nr > max_nr) {
+				pr_warning("WARNING: PERF_RECORD_CPU_MAP: nr %u exceeds payload (max %u), skipping\n",
+					   data->cpus_data.nr, max_nr);
+				err = 0;
+				goto out;
+			}
+			break;
+		}
+		case PERF_CPU_MAP__MASK:
+			if (data->mask32_data.long_size == 4) {
+				u16 max_nr = (payload - offsetof(struct perf_record_cpu_map_data,
+								 mask32_data.mask)) /
+					     sizeof(data->mask32_data.mask[0]);
+
+				if (data->mask32_data.nr > max_nr) {
+					pr_warning("WARNING: PERF_RECORD_CPU_MAP mask32: nr %u exceeds payload (max %u), skipping\n",
+						   data->mask32_data.nr, max_nr);
+					err = 0;
+					goto out;
+				}
+			} else if (data->mask64_data.long_size == 8) {
+				u16 max_nr;
+
+				if (payload < offsetof(struct perf_record_cpu_map_data, mask64_data.mask)) {
+					err = 0;
+					goto out;
+				}
+				max_nr = (payload - offsetof(struct perf_record_cpu_map_data,
+							     mask64_data.mask)) /
+					 sizeof(data->mask64_data.mask[0]);
+				if (data->mask64_data.nr > max_nr) {
+					pr_warning("WARNING: PERF_RECORD_CPU_MAP mask64: nr %u exceeds payload (max %u), skipping\n",
+						   data->mask64_data.nr, max_nr);
+					err = 0;
+					goto out;
+				}
+			} else {
+				pr_warning("WARNING: PERF_RECORD_CPU_MAP: unsupported long_size %u, skipping\n",
+					   data->mask32_data.long_size);
+				err = 0;
+				goto out;
+			}
+			break;
+		default:
+			break;
+		}
+
 		err = tool->cpu_map(tool, session, event);
 		break;
-	case PERF_RECORD_STAT_CONFIG:
+	}
+	case PERF_RECORD_STAT_CONFIG: {
+		/* Cannot underflow: perf_event__min_size[] guarantees header.size >= sizeof */
+		u64 max_nr = (event->header.size - sizeof(event->stat_config)) /
+			     sizeof(event->stat_config.data[0]);
+
+		/*
+		 * Native-endian events are mmap'd read-only, so we
+		 * cannot clamp nr in place.  Skip the event instead.
+		 */
+		if (event->stat_config.nr > max_nr) {
+			pr_warning("WARNING: PERF_RECORD_STAT_CONFIG: nr %" PRIu64 " exceeds payload (max %" PRIu64 "), skipping\n",
+				   (u64)event->stat_config.nr, max_nr);
+			err = 0;
+			goto out;
+		}
+
 		err = tool->stat_config(tool, session, event);
 		break;
+	}
 	case PERF_RECORD_STAT:
 		err = tool->stat(tool, session, event);
 		break;
@@ -1963,6 +2177,7 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		err = -EINVAL;
 		break;
 	}
+out:
 	perf_sample__exit(&sample);
 	return err;
 }
-- 
2.54.0

