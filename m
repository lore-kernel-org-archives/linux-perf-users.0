Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187422DE6FF;
	Sun, 24 May 2026 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593398; cv=none; b=oBkhNWXmCgJiEOPQs+sONwoDSB4uDteh9/35J/vsTuYvi71Z8137K54npGDkX9fFl10Bgftawb6D5DSNVFKqeATkR+oyTC4U+qbHIhaJUAxXW6xXKIqYvNgi0oM4Efh61KRg4YiOWi13To8UWule6IazUYaS7x2QclhMbLsTU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593398; c=relaxed/simple;
	bh=MqMfUgShnZVL4k3U6lOuzv18QVb/AhfemMtE/7U3aqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBwZ1HcFtgKpDZnf3sQ59gxYaOtT6UwmdhJp4czjyw/bZ8xU6pFrFCBn/e8I/QYp6i/epL9A2BqLwn1INcGR/wfR0+u/sZB6k5Djljlw+codf6leuVpADRkVNNiUzBRMx+OURqCGwVbMAUHdqsRqVgHzubqZ/ooKftU/t37f8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOBBUNy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOBBUNy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1141F000E9;
	Sun, 24 May 2026 03:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593396;
	bh=OiHp0U5xS9L/M5HutqfRBYLr6VI1H3GpgjQRa6nJU+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gOBBUNy5JcZXgzI4jkPTXOhgEsff+OPvUYmCegF9Ws0egO1M2hKxCCYsP6aE+eFng
	 qQ7Gxdrsr0vsCfzMK+MTx3IbMi2V7EzwFXaFNie0p8RGM5UulZF+vH1JRCu8BOvGGw
	 glNI6Bf+QAKIokO6qECgZj3Z/woEMlDn+/VYa7KBP8RfK3UTP8flLaIJoRwADGc/JM
	 vtXTp+SIpQPuTPim327q/9DLi6LsBeXhx7V1ic0HDDasTeIjUeeV+wWrXw5ovdkmJC
	 CCYh2usRV74dAq3yqqnAbgo1dUnuiuUPGCeN/hsBbTOYVWpz2G+BM3HVUppo6f2gSH
	 7X8BKFF7K/UOw==
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
Subject: [PATCH 26/29] perf session: Bound nr_cpus_avail and validate sample CPU
Date: Sun, 24 May 2026 00:27:00 -0300
Message-ID: <20260524032709.1080771-27-acme@kernel.org>
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

Several downstream consumers (timechart, kwork, sched) use fixed-size
arrays indexed by CPU.  A crafted perf.data can supply arbitrary CPU
values that index past these arrays, causing out-of-bounds access.

Validate sample.cpu against min(nr_cpus_avail, MAX_NR_CPUS) in
perf_session__deliver_event() before any tool callback runs.  The
cap at MAX_NR_CPUS protects fixed-size downstream arrays; the true
nr_cpus_avail is preserved in env for header parsing (e.g.
process_cpu_topology) which needs the real count.

Fall back to MAX_NR_CPUS when HEADER_NRCPUS is missing (truncated
files, pipe mode, pre-2017 perf).

Only validate when PERF_SAMPLE_CPU is set in sample_type — when
absent, evsel__parse_sample() leaves sample.cpu as (u32)-1, a
sentinel that downstream tools (script, inject) check to identify
events without CPU info.  Clamping it to 0 would break those checks.

Inline evlist__parse_sample() into perf_session__deliver_event()
so the evsel lookup needed for sample_type checking reuses the same
evsel that parsed the sample, avoiding a second evlist__event2evsel()
call on every event.

For pipe-mode streams where HEADER_NRCPUS may arrive late or not at
all, the MAX_NR_CPUS fallback ensures the bounds check is still
effective against the fixed-size downstream arrays.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c  | 30 +++++++++++++
 tools/perf/util/session.c | 88 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 117 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index cbc740fd29e6846c..781dcbe0415d78d7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -48,6 +48,7 @@
 #include <api/io_dir.h>
 #include "asm/bug.h"
 #include "tool.h"
+#include "../perf.h"
 #include "time-utils.h"
 #include "units.h"
 #include "util/util.h" // perf_exe()
@@ -2895,6 +2896,17 @@ static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 	if (ret)
 		return ret;
 
+	/*
+	 * Cap at 1M CPUs — generous for any real system but prevents
+	 * stack overflow from VLA allocations sized by nr_cpus_avail
+	 * (e.g. DECLARE_BITMAP in builtin-c2c.c node_entry()).
+	 */
+	if (nr_cpus_avail > (1U << 20)) {
+		pr_err("Invalid HEADER_NRCPUS: nr_cpus_avail (%u) exceeds maximum (%u)\n",
+		       nr_cpus_avail, 1U << 20);
+		return -1;
+	}
+
 	if (nr_cpus_online > nr_cpus_avail) {
 		pr_err("Invalid HEADER_NRCPUS: nr_cpus_online (%u) > nr_cpus_avail (%u)\n",
 		       nr_cpus_online, nr_cpus_avail);
@@ -5250,6 +5262,24 @@ int perf_session__read_header(struct perf_session *session)
 #endif
 	}
 
+	/*
+	 * Without nr_cpus_avail the sample CPU bounds check in
+	 * perf_session__deliver_event() is bypassed, allowing crafted
+	 * CPU IDs to reach downstream consumers that index fixed-size
+	 * arrays (timechart, kwork, sched — all sized MAX_NR_CPUS).
+	 *
+	 * This can happen with truncated files (interrupted recording
+	 * loses all feature sections), very old files that predate
+	 * HEADER_NRCPUS, or crafted files that omit it.  Fall back to
+	 * MAX_NR_CPUS so the bounds check is still effective — any
+	 * CPU ID below that limit is safe for all downstream arrays.
+	 */
+	if (header->env.nr_cpus_avail == 0) {
+		header->env.nr_cpus_avail = MAX_NR_CPUS;
+		pr_warning("WARNING: perf.data is missing HEADER_NRCPUS, using MAX_NR_CPUS (%d) as CPU bound\n",
+			   MAX_NR_CPUS);
+	}
+
 	return 0;
 out_errno:
 	return -errno;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index cb1d851686d9cbc0..69eb404f805d87d1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2099,14 +2099,100 @@ static int perf_session__deliver_event(struct perf_session *session,
 				       const char *file_path)
 {
 	struct perf_sample sample;
+	struct evsel *evsel;
 	int ret;
 
 	perf_sample__init(&sample, /*all=*/false);
-	ret = evlist__parse_sample(session->evlist, event, &sample);
+	evsel = evlist__event2evsel(session->evlist, event);
+	if (!evsel) {
+		pr_err("No evsel found for event type %u\n",
+		       event->header.type);
+		ret = -EFAULT;
+		goto out;
+	}
+	ret = evsel__parse_sample(evsel, event, &sample);
 	if (ret) {
 		pr_err("Can't parse sample, err = %d\n", ret);
 		goto out;
 	}
+	/*
+	 * evsel__parse_sample() doesn't populate machine_pid/vcpu,
+	 * which are needed by machines__find_for_cpumode() to
+	 * attribute samples to guest VMs.  The SID table maps
+	 * sample IDs to the guest that owns the event.
+	 */
+	if (perf_guest && sample.id) {
+		struct perf_sample_id *sid = evlist__id2sid(session->evlist, sample.id);
+
+		if (sid) {
+			sample.machine_pid = sid->machine_pid;
+			sample.vcpu = sid->vcpu.cpu;
+		}
+	}
+
+	/*
+	 * Validate sample.cpu before any callback can use it as an
+	 * array index (kwork cpus_runtime, timechart cpus_cstate_*,
+	 * sched cpu_last_switched).
+	 *
+	 * When PERF_SAMPLE_CPU is absent, evsel__parse_sample() leaves
+	 * sample.cpu as (u32)-1 — a sentinel that downstream tools
+	 * (script, inject) check to identify events without CPU info.
+	 * Only check when sample.cpu was actually populated from event
+	 * data: PERF_RECORD_SAMPLE always has it when PERF_SAMPLE_CPU
+	 * is set; non-sample events only have it when sample_id_all is
+	 * enabled.  Otherwise sample.cpu is the (u32)-1 sentinel from
+	 * evsel__parse_sample() and must not be validated or clamped.
+	 */
+	if ((evsel->core.attr.sample_type & PERF_SAMPLE_CPU) &&
+	    (event->header.type == PERF_RECORD_SAMPLE ||
+	     evsel->core.attr.sample_id_all)) {
+		int nr_cpus_avail = perf_session__env(session)->nr_cpus_avail;
+
+		/*
+		 * For perf.data files the MAX_NR_CPUS fallback in
+		 * perf_session__read_header() guarantees this is set.
+		 * For pipe mode, HEADER_NRCPUS may arrive late or not
+		 * at all (pre-2017 perf, third-party tools).  Fall
+		 * back to MAX_NR_CPUS so the bounds check still works
+		 * against fixed-size downstream arrays.
+		 *
+		 * Do NOT write back to env: this function runs during
+		 * recording (synthesized events) when nr_cpus_avail is
+		 * legitimately 0.  Writing MAX_NR_CPUS would cause
+		 * write_cpu_topology() to emit 4096 core_id/socket_id
+		 * pairs instead of the real CPU count, corrupting the
+		 * topology section in the generated perf.data.
+		 */
+		if (nr_cpus_avail <= 0)
+			nr_cpus_avail = MAX_NR_CPUS;
+		/*
+		 * Cap at MAX_NR_CPUS for the bounds check — downstream
+		 * consumers use fixed-size arrays of that size.  Keep
+		 * the true nr_cpus_avail in env for header parsing
+		 * (e.g. process_cpu_topology) which needs the real count.
+		 */
+		if (nr_cpus_avail > MAX_NR_CPUS)
+			nr_cpus_avail = MAX_NR_CPUS;
+		if (sample.cpu >= (u32)nr_cpus_avail &&
+		    sample.cpu != (u32)-1) {
+			/*
+			 * Warn rather than abort: synthesized events
+			 * (MMAP, COMM) lack sample_id_all data, so
+			 * parse_id_sample reads garbage from the event
+			 * payload.  Clamping to 0 protects downstream
+			 * array indexing while keeping the session alive.
+			 *
+			 * Preserve (u32)-1: perf script and perf inject
+			 * use it as a sentinel for "CPU not applicable."
+			 * Downstream array users (timechart, kwork) have
+			 * their own per-callback bounds checks.
+			 */
+			pr_warning_once("WARNING: sample CPU %u >= nr_cpus_avail %u, clamping to 0\n",
+					sample.cpu, nr_cpus_avail);
+			sample.cpu = 0;
+		}
+	}
 
 	ret = auxtrace__process_event(session, event, &sample, tool);
 	if (ret < 0)
-- 
2.54.0

