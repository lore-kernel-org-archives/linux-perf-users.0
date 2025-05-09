Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03435464E;
	Fri,  9 May 2025 21:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746824662; cv=none; b=enSzbcgsD1FN8mrV4owtgxEUtHupnWP5kscXXSu6AAxa8mLvPQWKiJB9OYzcPXvzqyeGVZeCGKWU8fKg5uDGzSsqAfu+MFiyIu2U/CnTPB3yqjChPytAeKp89s5Zoy0FnL9Zdsv/X4AyfNYlzo7gKKfdzKIjxJv1lvX7oXDBON4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746824662; c=relaxed/simple;
	bh=v3Zwm6/aCZ7Mpskl6W+PHfQjemE6+xItrRb+q1pwKiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2UhGy9S8/ln7R/istBvKeuE/z4PlUrbPIa3/g8z+a5BPFAS2q8nhEyOdrBlxmQXPoOwUAHXhN/Nrzdsls+zW83pvG23I2XyGbJ65Fsg1KH1o/j+tjqEoZ6FaqFDbUdXJ/suT671FPFLDL9ok1BJsuDh8ut72ag4HQ035EMXZAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi76QhD1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi76QhD1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3DD0C4CEE4;
	Fri,  9 May 2025 21:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746824662;
	bh=v3Zwm6/aCZ7Mpskl6W+PHfQjemE6+xItrRb+q1pwKiA=;
	h=From:To:Cc:Subject:Date:From;
	b=Hi76QhD1TUAaMth8j8sJ1/rAteJIAgjHhlMcDSJJVlhrefXXuZLz+Gs5SeQv0eS8u
	 qv+k9Tjy5He67vwcbBaWDVOn2bvJfBplsJ88vogVJ7dWnLcpxfmHSXDSKt/8Xt/ufQ
	 jka7Pc9o0DwfWQN/jbXaKXP++2KNlcpx/kCxBgxmV7w8UVp8HtpKYHz4i+MvVp+4Wu
	 ZVnl+sntJTUK0+4zYBsBzqge48QiHDYL5Zo5/gK8ODLf0qveZStuAFHTFSs0SZB56M
	 16k+4K75eHQ3KQhLJ3gZ/zK2q2qcw8T3p0gSudaDhHa8H5iWTcNKYAwKnFDBeuLuqO
	 Mm1f/aLoq3eAw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH v2] perf report: Add 'tgid' sort key
Date: Fri,  9 May 2025 14:04:21 -0700
Message-ID: <20250509210421.197245-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.1015.ga840276032-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes we need to analyze the data in process level but current sort
keys only work on thread level.  Let's add 'tgid' sort key for that as
'pid' is already taken for thread.

This will look mostly the same, but it only uses tgid instead of tid.
Here's an example of a process with two threads (thloop).

  $ perf record -- perf test -w thloop

  $ perf report --stdio -s tgid,pid -H
  ...
  #
  #    Overhead  Tgid:Command / Pid:Command
  # ...........  ..........................
  #
     100.00%     2018407:perf
         50.34%     2018407:perf
         49.66%     2018409:perf

Suggested-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-report.txt |  1 +
 tools/perf/util/hist.h                   |  1 +
 tools/perf/util/sort.c                   | 38 ++++++++++++++++++++++++
 tools/perf/util/sort.h                   |  1 +
 4 files changed, 41 insertions(+)

diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 3376c471057506d9..acef3ff4178eff66 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -94,6 +94,7 @@ OPTIONS
 
 	- comm: command (name) of the task which can be read via /proc/<pid>/comm
 	- pid: command and tid of the task
+	- tgid: command and tgid of the task
 	- dso: name of library or module executed at the time of sample
 	- dso_size: size of library or module executed at the time of sample
 	- symbol: name of function executed at the time of sample
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 355198fd70281f43..c64254088fc77246 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -42,6 +42,7 @@ enum hist_column {
 	HISTC_TIME,
 	HISTC_DSO,
 	HISTC_THREAD,
+	HISTC_TGID,
 	HISTC_COMM,
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 8efafa7c10822ee9..45e6546539600a46 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -141,6 +141,43 @@ struct sort_entry sort_thread = {
 	.se_width_idx	= HISTC_THREAD,
 };
 
+/* --sort tgid */
+
+static int64_t
+sort__tgid_cmp(struct hist_entry *left, struct hist_entry *right)
+{
+	return thread__pid(right->thread) - thread__pid(left->thread);
+}
+
+static int hist_entry__tgid_snprintf(struct hist_entry *he, char *bf,
+				       size_t size, unsigned int width)
+{
+	int tgid = thread__pid(he->thread);
+	const char *comm = NULL;
+
+	/* display comm of the thread-group leader */
+	if (thread__pid(he->thread) == thread__tid(he->thread)) {
+		comm = thread__comm_str(he->thread);
+	} else {
+		struct maps *maps = thread__maps(he->thread);
+		struct thread *leader = machine__find_thread(maps__machine(maps),
+							     tgid, tgid);
+		if (leader) {
+			comm = thread__comm_str(leader);
+			thread__put(leader);
+		}
+	}
+	width = max(7U, width) - 8;
+	return repsep_snprintf(bf, size, "%7d:%-*.*s", tgid, width, width, comm ?: "");
+}
+
+struct sort_entry sort_tgid = {
+	.se_header	= "   Tgid:Command",
+	.se_cmp		= sort__tgid_cmp,
+	.se_snprintf	= hist_entry__tgid_snprintf,
+	.se_width_idx	= HISTC_TGID,
+};
+
 /* --sort simd */
 
 static int64_t
@@ -2508,6 +2545,7 @@ static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
 
 static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_PID, "pid", sort_thread),
+	DIM(SORT_TGID, "tgid", sort_tgid),
 	DIM(SORT_COMM, "comm", sort_comm),
 	DIM(SORT_DSO, "dso", sort_dso),
 	DIM(SORT_SYM, "symbol", sort_sym),
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 6e92ac62b9c80a0b..a742ab7f3c677f48 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -73,6 +73,7 @@ enum sort_type {
 	SORT_SYM_OFFSET,
 	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
 	SORT_PARALLELISM,
+	SORT_TGID,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.49.0.1015.ga840276032-goog

