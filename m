Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265462753F0;
	Thu, 13 Feb 2025 23:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739489742; cv=none; b=ayy2Q+1F4LMGaS7XvV0O7eLZxOHOQ/tgRNqimnk0M4W4Di5W9SURuaOidMGrFusyREeigLpX7IaWHeAE8nUGek5pgfp60SQLe+oWWCLfXqBjTeZL01yyHWFNCHm2k4gd2T3KwocYWBoMBbssMH8+WlYGose2jxQq036Dab7rEpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739489742; c=relaxed/simple;
	bh=EZkv+Ho0qnfwzKUpS/CiR6zEjhpxu4+amaaWviz+BWg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OK/X1NZF6s8BFaiNUhfW1666HDSsoN9me1/3SxVZsu+rvGEX0WvOhlzOr7QCla5m55xR20bTE34rybze+LT0u/rDH0o7ERS/Q23R/64a+dTsm9xwH19YyJPyAzmUwLN6IjQD1D7YMLCbE513prq8TjzkbsJGCBUNX1kHnqyDpvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBLZpCPz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBLZpCPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AFBFC4CED1;
	Thu, 13 Feb 2025 23:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739489741;
	bh=EZkv+Ho0qnfwzKUpS/CiR6zEjhpxu4+amaaWviz+BWg=;
	h=From:To:Cc:Subject:Date:From;
	b=sBLZpCPz1NoNgOSv1mxpSLs+FNjXdraZqNTFB3c5QkEZtldUDUwcEaHRoOGhH0jHV
	 1+MpjqpsUOHqDB4AJB4IV6znZsNCAJOd6XknfAhEvR6NR7OzRFBfFLLc+KVFov4ByJ
	 ubaNRl4pUfnAdNLtpv9T+Bva70o3kQrBNBDMlIozNFJ2WSZsYZn6huJNt516pff30S
	 To0IExRLA/JEE/JULyszAdyy0i3FANVaqcixojumjfz3wFOYOedm4fwM9Nre1F5YIf
	 HcWAFkE7/ldK3DKFPJJHo2O6qKVzfmeY/ryLli6G+F0eIVtBP0TOzGE/B28lQqM38Q
	 VaszY5PZoYaMA==
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
Date: Thu, 13 Feb 2025 15:35:40 -0800
Message-ID: <20250213233540.600006-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
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
index 87f86451940623f3..4050ec4038425bf0 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -79,6 +79,7 @@ OPTIONS
 
 	- comm: command (name) of the task which can be read via /proc/<pid>/comm
 	- pid: command and tid of the task
+	- tgid: command and tgid of the task
 	- dso: name of library or module executed at the time of sample
 	- dso_size: size of library or module executed at the time of sample
 	- symbol: name of function executed at the time of sample
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 46c8373e314657fa..c164e178e0a48a8e 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -38,6 +38,7 @@ enum hist_column {
 	HISTC_TIME,
 	HISTC_DSO,
 	HISTC_THREAD,
+	HISTC_TGID,
 	HISTC_COMM,
 	HISTC_CGROUP_ID,
 	HISTC_CGROUP,
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 3dd33721823f365d..b4034bd6629d4156 100644
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
@@ -2501,6 +2538,7 @@ static void sort_dimension_add_dynamic_header(struct sort_dimension *sd)
 
 static struct sort_dimension common_sort_dimensions[] = {
 	DIM(SORT_PID, "pid", sort_thread),
+	DIM(SORT_TGID, "tgid", sort_tgid),
 	DIM(SORT_COMM, "comm", sort_comm),
 	DIM(SORT_DSO, "dso", sort_dso),
 	DIM(SORT_SYM, "symbol", sort_sym),
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index a8572574e1686be6..6044eb1d61447c0d 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -72,6 +72,7 @@ enum sort_type {
 	SORT_ANNOTATE_DATA_TYPE_OFFSET,
 	SORT_SYM_OFFSET,
 	SORT_ANNOTATE_DATA_TYPE_CACHELINE,
+	SORT_TGID,
 
 	/* branch stack specific sort keys */
 	__SORT_BRANCH_STACK,
-- 
2.48.1.601.g30ceb7b040-goog

