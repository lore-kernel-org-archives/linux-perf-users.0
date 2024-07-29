Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE5AB661;
	Mon, 29 Jul 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213691; cv=none; b=DiH/lJg3BUTNMrNGpDPR+Da0dJ8Uh9pro+4towUauIAsBlXHCULtMvrxsXsCs6UKyNKgoPnUsUOUnndDAgID8RuyKSy+Gr8pyhZWwZ7qLowISqx5sUNrmY21t49x4bIWikVCCzG6NJFXPk43oTsW5l8brrOlVAxfMJVcpYHhxnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213691; c=relaxed/simple;
	bh=fsiX2Lm79R2xAO3++1r1+9dNsJhIjv83GPnsKTWgmlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YO50CbBweDBFwr6Zpcj8j0Txx9L8AOJoaJnVG4OFzaQHltdDwCL5f2D2L8lZdK9J2bUA+ZXfqJiORqvS+CpJQSs8okq1Mk5cRHMP2ZKTW9VY9ODUC/0be5A7YVmTt4CmtPqp3xke++FeL7h8EwLzZl9M/Wm+vrsBh+2eVlEcch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hq8Ie3lf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hq8Ie3lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF21C4AF4D;
	Mon, 29 Jul 2024 00:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722213690;
	bh=fsiX2Lm79R2xAO3++1r1+9dNsJhIjv83GPnsKTWgmlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hq8Ie3lfiCv2SW6TdlBjMomqQNY90gLUyN0iZ0vpg86gbxe+43vm2OLQS16QYA2xQ
	 aFz1XOm/XeN7Ok4FkTwVzS+P6AdIoHejqAFoHusIZpiMWF7bQotMZuVm5yChSyDz1X
	 51gPIW1jlhTIRUeGWw8PPwBbNAfdd0c9m2DRabk424QFP50ZYroN5dXyY5y7LUuB+L
	 0drImTD6WPikSSSGlaWlSa4DIiUBNQhRrJVOyDWKsKRSRfMJSq5Xyvsmwd/W8dSasA
	 31u/CPEAmz/7TC8YEjaD4QeZlcTFgHcL1xWiXLHEbwo2XTkiUnkg7lvvaLd11B52Il
	 82qB1KT/QDGxA==
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
	Steven Rostedt <rostedt@goodmis.org>,
	Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 4/4] perf ftrace: Add -s/--sort option to profile sub-command
Date: Sun, 28 Jul 2024 17:41:27 -0700
Message-ID: <20240729004127.238611-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.rc1.232.g9752f9e123-goog
In-Reply-To: <20240729004127.238611-1-namhyung@kernel.org>
References: <20240729004127.238611-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The -s/--sort option is to sort the output by given column.

  $ sudo perf ftrace profile -s max sync | head
  # Total (us)   Avg (us)   Max (us)      Count   Function
      6301.811   6301.811   6301.811          1   __do_sys_sync
      6301.328   6301.328   6301.328          1   ksys_sync
      5320.300   1773.433   2858.819          3   iterate_supers
      2755.875     17.012   2610.633        162   sync_fs_one_sb
      2728.351    682.088   2610.413          4   ext4_sync_fs [ext4]
      2603.654   2603.654   2603.654          1   jbd2_log_wait_commit [jbd2]
      4750.615    593.827   2597.427          8   schedule
      2164.986     26.728   2115.673         81   sync_inodes_one_sb
      2143.842     26.467   2115.438         81   sync_inodes_sb

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt |  5 ++
 tools/perf/builtin-ftrace.c              | 63 +++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 33f32467f287..eaec8253be68 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -185,6 +185,11 @@ OPTIONS for 'perf ftrace profile'
 	Set the size of per-cpu tracing buffer, <size> is expected to
 	be a number with appended unit character - B/K/M/G.
 
+-s::
+--sort=::
+	Sort the result by the given field.  Available values are:
+	total, avg, max, count, name.  Default is 'total'.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index ae9389435d1b..a615c405d98f 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1090,15 +1090,47 @@ static int parse_func_duration(struct perf_ftrace *ftrace, char *line, size_t le
 	return add_func_duration(ftrace, func, duration);
 }
 
+enum perf_ftrace_profile_sort_key {
+	PFP_SORT_TOTAL = 0,
+	PFP_SORT_AVG,
+	PFP_SORT_MAX,
+	PFP_SORT_COUNT,
+	PFP_SORT_NAME,
+};
+
+static enum perf_ftrace_profile_sort_key profile_sort = PFP_SORT_TOTAL;
+
 static int cmp_profile_data(const void *a, const void *b)
 {
 	const struct hashmap_entry *e1 = *(const struct hashmap_entry **)a;
 	const struct hashmap_entry *e2 = *(const struct hashmap_entry **)b;
 	struct ftrace_profile_data *p1 = e1->pvalue;
 	struct ftrace_profile_data *p2 = e2->pvalue;
+	double v1, v2;
+
+	switch (profile_sort) {
+	case PFP_SORT_NAME:
+		return strcmp(e1->pkey, e2->pkey);
+	case PFP_SORT_AVG:
+		v1 = p1->st.mean;
+		v2 = p2->st.mean;
+		break;
+	case PFP_SORT_MAX:
+		v1 = p1->st.max;
+		v2 = p2->st.max;
+		break;
+	case PFP_SORT_COUNT:
+		v1 = p1->st.n;
+		v2 = p2->st.n;
+		break;
+	case PFP_SORT_TOTAL:
+	default:
+		v1 = p1->st.n * p1->st.mean;
+		v2 = p2->st.n * p2->st.mean;
+		break;
+	}
 
-	/* compare by total time */
-	if ((p1->st.n * p1->st.mean) > (p2->st.n * p2->st.mean))
+	if (v1 > v2)
 		return -1;
 	else
 		return 1;
@@ -1414,6 +1446,30 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	return 0;
 }
 
+static int parse_sort_key(const struct option *opt, const char *str, int unset)
+{
+	enum perf_ftrace_profile_sort_key *key = (void *)opt->value;
+
+	if (unset)
+		return 0;
+
+	if (!strcmp(str, "total"))
+		*key = PFP_SORT_TOTAL;
+	else if (!strcmp(str, "avg"))
+		*key = PFP_SORT_AVG;
+	else if (!strcmp(str, "max"))
+		*key = PFP_SORT_MAX;
+	else if (!strcmp(str, "count"))
+		*key = PFP_SORT_COUNT;
+	else if (!strcmp(str, "name"))
+		*key = PFP_SORT_NAME;
+	else {
+		pr_err("Unknown sort key: %s\n", str);
+		return -1;
+	}
+	return 0;
+}
+
 enum perf_ftrace_subcommand {
 	PERF_FTRACE_NONE,
 	PERF_FTRACE_TRACE,
@@ -1497,6 +1553,9 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Set nograph filter on given functions", parse_filter_func),
 	OPT_CALLBACK('m', "buffer-size", &ftrace.percpu_buffer_size, "size",
 		     "Size of per cpu buffer, needs to use a B, K, M or G suffix.", parse_buffer_size),
+	OPT_CALLBACK('s', "sort", &profile_sort, "key",
+		     "Sort result by key: total (default), avg, max, count, name.",
+		     parse_sort_key),
 	OPT_PARENT(common_options),
 	};
 	const struct option *options = ftrace_options;
-- 
2.46.0.rc1.232.g9752f9e123-goog

