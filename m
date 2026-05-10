Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE703285CB6;
	Sun, 10 May 2026 03:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384214; cv=none; b=h8W9d7C7VhKNLeXCU4IBsCQw8FE1xro5Z/ZIeTlMsWK4W9gwNc59pPu6d9ZbLjgTtqofOPASGtFoRig0ddNZfm2yFE2qOtzfzmdP5cdp7sByYDWHPmlmkbiPxCISSp2fh+NRJzJ0y7+oOaHqsEHKAnA6jw0eiL9DTUqbXW+v0Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384214; c=relaxed/simple;
	bh=fdT6ZtqV6FXdsmthN+Sha6Rf+AOARgwXiDiEj+FPl4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=si5F8h6/Ku/Zx5Ju1piCcLDGhGFsj+xhHBfyySbjVgFi5Lnyl1NP2gR7oeQC3NePuPhaaiCSVRW3mO6J7QK2jXXkj7r52QqXvcEDZs5p1xT88L9Mb2AfGa4gKoZQpNxaqN+sHmLnFt80+52pNB8ocQx6kojlq4Hyf9KuPd+nDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1ncqYPx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1ncqYPx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3832FC2BCF6;
	Sun, 10 May 2026 03:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778384214;
	bh=fdT6ZtqV6FXdsmthN+Sha6Rf+AOARgwXiDiEj+FPl4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1ncqYPx7cKdAmN+0JtqY4hGJLMBRo3FUDFccwdISbix2bhgkwhU+/0YKej4ciujD
	 Xf1pnFmfmMnuAHADnmmZYkaqtpLuEX3Wt/mw/ePgb36/fU9eNyo6Tv71TSkGYovYEq
	 5FH/lW81nnOuRf9tvWaeQrXCARtF70wxyNN9XvmueEYJY9Ujct6yK+P+8UjT0bw9F3
	 fHTgwHU1UUVHxa4LoYc1auUSd5vpwHCWjb/oNMAu6Uz0bPPsbOdshE3dSj8gRkbxSl
	 YUHrbNmVKVpaaOH+Sjfp9zdH29cU6F/ly5JymZuKKhfoVbYPF2f6WclcSglUPnbPCP
	 C78y02rv34nFA==
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
Subject: [PATCH 25/28] perf session: Bound nr_cpus_avail and validate sample CPU
Date: Sun, 10 May 2026 00:34:16 -0300
Message-ID: <20260510033424.255812-26-acme@kernel.org>
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

Several downstream consumers (timechart, kwork, sched) use fixed-size
arrays indexed by CPU.  A crafted perf.data can supply arbitrary CPU
values that index past these arrays, causing out-of-bounds access.

Clamp nr_cpus_avail to MAX_NR_CPUS when reading HEADER_NRCPUS, and
fall back to MAX_NR_CPUS when the header is missing (truncated files,
pipe mode, pre-2017 perf).  Then validate sample.cpu against
nr_cpus_avail in perf_session__deliver_event() before any tool
callback runs.

Only validate when PERF_SAMPLE_CPU is set in sample_type — when
absent, evsel__parse_sample() leaves sample.cpu as (u32)-1, a
sentinel that downstream tools (script, inject) check to identify
events without CPU info.  Clamping it to 0 would break those checks.

Also refactor the sample parsing in perf_session__deliver_event()
to call evsel__parse_sample() directly (via evlist__event2evsel()
for evsel lookup), with explicit guest VM SID resolution for
machine_pid and vcpu fields.

Fix an off-by-one in end_sample_processing(): change the loop bound
from cpu <= numcpus to cpu < numcpus to prevent accessing one
element past the array.

For pipe-mode streams where HEADER_NRCPUS may arrive late or not at
all, the MAX_NR_CPUS fallback ensures the bounds check is still
effective against the fixed-size downstream arrays.

Reported-by: sashiko-bot@kernel.org # Running on a local machine
Assisted-by: Claude Opus 4.6 (1M context) <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-timechart.c |  2 +-
 tools/perf/util/header.c       | 43 +++++++++++++++++++
 tools/perf/util/session.c      | 75 +++++++++++++++++++++++++++++++++-
 3 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 28f33e39895d362d..40297f2dcd0353cc 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -700,7 +700,7 @@ static void end_sample_processing(struct timechart *tchart)
 	u64 cpu;
 	struct power_event *pwr;
 
-	for (cpu = 0; cpu <= tchart->numcpus; cpu++) {
+	for (cpu = 0; cpu < tchart->numcpus; cpu++) {
 		/* C state */
 #if 0
 		pwr = zalloc(sizeof(*pwr));
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 994e54167ea3196b..30b65c58784b596f 100644
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
@@ -2884,12 +2885,36 @@ static int process_nrcpus(struct feat_fd *ff, void *data __maybe_unused)
 	if (ret)
 		return ret;
 
+	/* Validate raw values before clamping */
 	if (nr_cpus_online > nr_cpus_avail) {
 		pr_err("Invalid HEADER_NRCPUS: nr_cpus_online (%u) > nr_cpus_avail (%u)\n",
 		       nr_cpus_online, nr_cpus_avail);
 		return -1;
 	}
 
+	/*
+	 * FIXME: Several downstream consumers use fixed-size arrays
+	 * indexed by CPU (timechart MAX_CPUS, kwork/sched/annotate
+	 * DECLARE_BITMAP(MAX_NR_CPUS)).  Until these are converted
+	 * to dynamic allocation, clamp nr_cpus_avail so per-event
+	 * CPU bounds checks reject samples above the array limit.
+	 * Data from CPUs beyond MAX_NR_CPUS will be lost.
+	 *
+	 * Pipe-mode streams from pre-2017 perf or third-party tools
+	 * that lack HEADER_NRCPUS will hit the MAX_NR_CPUS fallback
+	 * in perf_session__deliver_event() instead.
+	 */
+	if (nr_cpus_avail > MAX_NR_CPUS) {
+		pr_warning("WARNING: perf.data recorded on a %u-CPU machine but perf is compiled with MAX_NR_CPUS=%d.\n"
+			   "         Samples from CPUs >= %d will be clamped to CPU 0.  Consider rebuilding\n"
+			   "         perf with a larger MAX_NR_CPUS, or help convert fixed-size CPU arrays to\n"
+			   "         dynamic allocation.\n",
+			   nr_cpus_avail, MAX_NR_CPUS, MAX_NR_CPUS);
+		nr_cpus_avail = MAX_NR_CPUS;
+		if (nr_cpus_online > nr_cpus_avail)
+			nr_cpus_online = nr_cpus_avail;
+	}
+
 	env->nr_cpus_avail = (int)nr_cpus_avail;
 	env->nr_cpus_online = (int)nr_cpus_online;
 	return 0;
@@ -5239,6 +5264,24 @@ int perf_session__read_header(struct perf_session *session)
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
index 80cb03d150cecc0b..dd84b3cd017a5073 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2085,14 +2085,87 @@ static int perf_session__deliver_event(struct perf_session *session,
 				       const char *file_path)
 {
 	struct perf_sample sample;
+	struct evsel *evsel;
 	int ret;
 
 	perf_sample__init(&sample, /*all=*/false);
-	ret = evlist__parse_sample(session->evlist, event, &sample);
+	evsel = evlist__event2evsel(session->evlist, event);
+	if (!evsel) {
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
+		 */
+		if (nr_cpus_avail <= 0) {
+			nr_cpus_avail = MAX_NR_CPUS;
+			perf_session__env(session)->nr_cpus_avail = nr_cpus_avail;
+			pr_warning_once("WARNING: HEADER_NRCPUS not set, using MAX_NR_CPUS (%d) as CPU bound\n",
+					MAX_NR_CPUS);
+		}
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

