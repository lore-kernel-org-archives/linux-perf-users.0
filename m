Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37C03207;
	Mon, 29 Jul 2024 00:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722213689; cv=none; b=dwtxo0uKqXx4ZFa8ptrtwzfGW3WpLQPvweLq2yqF6YvahLXeVncMzUdrM7hPd7Y1xvf+dp7W6gCrmbngQKMjcG/3QXDSQDfD0Lf+HdFx4LYUWp3aw8XYdyGF1fut0tVYNFdRrvIPfOKYchP5IPZ3dnHa4o4/3FwNn6Fxt2Adbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722213689; c=relaxed/simple;
	bh=+4xhnYSijGDgv46dB8kyW6bhDjEdx5UE3zvs3CKI3sI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1gfVHeoSILZ7unVgoOycnmGX/842O0pMJ80ZVlj9zutcrEGo5jL1DX/b/ia3QTo/P54UVKLBfweV/DGfC8QvKmoSpBanP4wWlI+lYOxD73pXWg4JDKmwq6LcwElttJj7T41qmaj5yz22Nm1Ai95nbcjqmgaVUsEiu0l5Rb3StE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFT7VcIZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFT7VcIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C42F5C4AF10;
	Mon, 29 Jul 2024 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722213689;
	bh=+4xhnYSijGDgv46dB8kyW6bhDjEdx5UE3zvs3CKI3sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFT7VcIZW5fXveVxXbVw9r43AK3qh6yI6aqrqnlu6dEh4HiTFQvZQCN37ogUdcihD
	 7BbUKtauzMp84hQ5C1KLapwFcjwBXYDLWzQa0el9asE3e8l2iay4Dv+l0D5s2o715u
	 k4/kmgj/M+8run/3iIWFqWXHlz5t4x6LhOlZJTjZVGAQL49rT2yWeA8Id+vkjYRYQ9
	 H06WiPy0EMHJGXIyr9YNB5Ew4UqWwyKH7PQCvCIG5RM6SEDkJSNhuUiI18ih+gqKqe
	 TWkAoSUvO79j3dCRbqXXSoSWhTMS8EUujCBjS8zcPjhMQOzp9B8IHXP62L1HTR+EbI
	 52MjZUaxNIUZA==
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
Subject: [PATCH 1/4] perf ftrace: Add 'tail' option to --graph-opts
Date: Sun, 28 Jul 2024 17:41:24 -0700
Message-ID: <20240729004127.238611-2-namhyung@kernel.org>
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

The 'graph-tail' option is to print function name as a comment at the end.
This is useful when a large function is mixed with other functions
(possibly from different CPUs).

For example,

  $ sudo perf ftrace -- perf stat true
  ...
   1)               |    get_unused_fd_flags() {
   1)               |      alloc_fd() {
   1)   0.178 us    |        _raw_spin_lock();
   1)   0.187 us    |        expand_files();
   1)   0.169 us    |        _raw_spin_unlock();
   1)   1.211 us    |      }
   1)   1.503 us    |    }

  $ sudo perf ftrace --graph-opts tail -- perf stat true
  ...
   1)               |    get_unused_fd_flags() {
   1)               |      alloc_fd() {
   1)   0.099 us    |        _raw_spin_lock();
   1)   0.083 us    |        expand_files();
   1)   0.081 us    |        _raw_spin_unlock();
   1)   0.601 us    |      } /* alloc_fd */
   1)   0.751 us    |    } /* get_unused_fd_flags */

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt |  1 +
 tools/perf/builtin-ftrace.c              | 18 ++++++++++++++++++
 tools/perf/util/ftrace.h                 |  1 +
 3 files changed, 20 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index d780b93fcf87..7ea1645a13cf 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -125,6 +125,7 @@ OPTIONS for 'perf ftrace trace'
 	  - verbose      - Show process names, PIDs, timestamps, etc.
 	  - thresh=<n>   - Setup trace duration threshold in microseconds.
 	  - depth=<n>    - Set max depth for function graph tracer to follow.
+	  - tail         - Print function name at the end.
 
 
 OPTIONS for 'perf ftrace latency'
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index eb30c8eca488..33c52ebda2fd 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -228,6 +228,7 @@ static void reset_tracing_options(struct perf_ftrace *ftrace __maybe_unused)
 	write_tracing_option_file("funcgraph-irqs", "1");
 	write_tracing_option_file("funcgraph-proc", "0");
 	write_tracing_option_file("funcgraph-abstime", "0");
+	write_tracing_option_file("funcgraph-tail", "0");
 	write_tracing_option_file("latency-format", "0");
 	write_tracing_option_file("irq-info", "0");
 }
@@ -464,6 +465,17 @@ static int set_tracing_funcgraph_verbose(struct perf_ftrace *ftrace)
 	return 0;
 }
 
+static int set_tracing_funcgraph_tail(struct perf_ftrace *ftrace)
+{
+	if (!ftrace->graph_tail)
+		return 0;
+
+	if (write_tracing_option_file("funcgraph-tail", "1") < 0)
+		return -1;
+
+	return 0;
+}
+
 static int set_tracing_thresh(struct perf_ftrace *ftrace)
 {
 	int ret;
@@ -540,6 +552,11 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
 		return -1;
 	}
 
+	if (set_tracing_funcgraph_tail(ftrace) < 0) {
+		pr_err("failed to set tracing option funcgraph-tail\n");
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -1099,6 +1116,7 @@ static int parse_graph_tracer_opts(const struct option *opt,
 		{ .name = "verbose",		.value_ptr = &ftrace->graph_verbose },
 		{ .name = "thresh",		.value_ptr = &ftrace->graph_thresh },
 		{ .name = "depth",		.value_ptr = &ftrace->graph_depth },
+		{ .name = "tail",		.value_ptr = &ftrace->graph_tail },
 		{ .name = NULL, }
 	};
 
diff --git a/tools/perf/util/ftrace.h b/tools/perf/util/ftrace.h
index 558efcb98d25..2515e841c64c 100644
--- a/tools/perf/util/ftrace.h
+++ b/tools/perf/util/ftrace.h
@@ -25,6 +25,7 @@ struct perf_ftrace {
 	int			graph_noirqs;
 	int			graph_verbose;
 	int			graph_thresh;
+	int			graph_tail;
 };
 
 struct filter_entry {
-- 
2.46.0.rc1.232.g9752f9e123-goog

