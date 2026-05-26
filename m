Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BED3C2797;
	Tue, 26 May 2026 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830385; cv=none; b=FfFxCr6YF6QHu3QxL8XbRPhIH4O5Y30ZANHAT0ouAuWqtejazebdHAijHcZG8Sij3QYdz/mbP0KsPkX6vii2vkWOm4iw6ARsUYWJJiiESYF0e/D+N2c56DOaB5sqFIEni1ciAHF3shoSAjIIAucbgzlLjAXRuKoijHuikkL54BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830385; c=relaxed/simple;
	bh=8E9RIlbyvVDBk235UNUwM9fkK9UZ7p1GRFqPdxPKE3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofWo5CKx9Hg+yY9M6gaomcExt2PrrJR/UKPqIRNaZuZLz3Ilga5KNuN8izTU3aY9CqU1ZUCR0811bcVKxcI2GfV5gxtaeGTrP0WSJaKe9ouHkOVUm69BbTtpwzSMVQh7+J72LoOmNbrEXAaPuExi3WoubTZO1cMMXhVWj0eka0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+JXo8bi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+JXo8bi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 352931F000E9;
	Tue, 26 May 2026 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779830384;
	bh=/MQAOBlHH4kWSzGdREJ/sx9SwrF4xqRIQrt4huN03as=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L+JXo8biyuzIb5UKiuBTqxIuXQNN5bsd4Y1ekjYimmuS1MfRjEiE8L1KJp4lDoFk3
	 RhRcM7bRVNT5S5oVVTcDhStuGC/kFWAjqRiQbvvB995ZGW9PHQqGBZUFxzhvkWgh/R
	 hrYK1Y+LIacfhOigYONrduWnRsYwZmyxYZj8GYqPbHKGIFLWVcEVOEAPfviCXnNH8C
	 kGoh4VvlXf8nPyc5qVwZrHQIX6sjQF/FuYekj6gNIF5puS8Xu+0RB/gcMHxqY+TZsa
	 08vKRNfE15oOb7inS3O3j4S3NahfCRuFhMfFUl31zHY2Y0snEgWNxBsPaxNRGekM/4
	 o0KT5GacD95IA==
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
Date: Tue, 26 May 2026 18:18:02 -0300
Message-ID: <20260526211806.1193848-27-acme@kernel.org>
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
index f771a76321c10a02..5b1fa1653d2a48cc 100644
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
index 9271885e3920f897..6de665d3c9054179 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2110,14 +2110,100 @@ static int perf_session__deliver_event(struct perf_session *session,
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

