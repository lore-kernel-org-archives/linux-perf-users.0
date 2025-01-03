Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505891C3C03;
	Fri,  3 Jan 2025 23:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735946192; cv=none; b=AcE5wpmHUD0f+Fd5Q+vChN+x/k+Sx7ZfcMGQVTih/zctDXVtHrbmNjeOtp4tGtTnllUybMOb3vGjlyUGE2OnOhqkipXyddC0nAHy4IDd5/XMSvdu0dxAKh785cbeWnEwzN9GM5PMlHsk1I47PmnnfXJwUL+U5JklJ+HB+4aTj+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735946192; c=relaxed/simple;
	bh=WkEeeTp9mIvZ7jCICgBzv3rhTqe6zTAtJNPynygMvxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUVu51qmxVimG3wbuRyUc1oA9ZJvQnSZ6mWlDW/+sK+wZ8KB7dcvQPJoI8OiEYv1GTZ2IH5tQA3HAlm3xM5G3zIIc4lAp5Of7jnv6llGl/LZNm0d3R/qQ9mEmFztv5SFjs8iWLOgyC57mYugPxXvLeF+WSLGIdzB9MkqWhDb5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9r1zgTo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9r1zgTo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D57C4CEE2;
	Fri,  3 Jan 2025 23:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735946191;
	bh=WkEeeTp9mIvZ7jCICgBzv3rhTqe6zTAtJNPynygMvxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A9r1zgToYUaE3HwZHndkFIMlAdGwEPnO/LcxXe6nMx4c2rOJ7kUSpPdbIfled2ZcN
	 4BDhUYcyfGpg3cm/fBCcsSpvzJ23XqcqAMYa09CM64HPpG41Ap3RxDn4pAuKrjXFgl
	 Xlo4fRP7EgenHZS+SSa/O1g57y5QCNljI37EI6lFptT3oKy2OXchr30PvRxrCHDUWR
	 yxXAzw/4UxeK49f2TAmQUpq3uYVnet8v+d/AbH4ZpKt+tOWN6CAYjVWRHMjckGCRfH
	 ED8PwMcq3llTu3MHoKbnhFJAsFpEvekglM1CxF4FTjY4Rz5TCr7vLWbkEl4O/RigUX
	 27JH5EffjrwUw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf ftrace: Add --graph-opts option to profile subcommand
Date: Fri,  3 Jan 2025 15:16:29 -0800
Message-ID: <20250103231630.928815-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250103231630.928815-1-namhyung@kernel.org>
References: <20250103231630.928815-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like trace subcommand, it should be able to pass some options to control
the tracing behavior for the function graph tracer.  But some options
are limited in order to maintain the internal behavior.

For example, it can limit the function call depth like below:

  # perf ftrace profile --graph-opts depth=5 -- myprog

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt | 8 ++++++++
 tools/perf/builtin-ftrace.c              | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index 16b067eb5d84746d..4a69a1135f07341b 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -205,6 +205,14 @@ OPTIONS for 'perf ftrace profile'
 	Sort the result by the given field.  Available values are:
 	total, avg, max, count, name.  Default is 'total'.
 
+--graph-opts::
+	List of options allowed to set:
+
+	  - nosleep-time - Measure on-CPU time only for function_graph tracer.
+	  - noirqs       - Ignore functions that happen inside interrupt.
+	  - thresh=<n>   - Setup trace duration threshold in microseconds.
+	  - depth=<n>    - Set max depth for function graph tracer to follow.
+
 
 SEE ALSO
 --------
diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 0ac2b20b272bd790..d747cca2403e494e 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1072,6 +1072,7 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
 {
 	ftrace->tracer = "function_graph";
 	ftrace->graph_tail = 1;
+	ftrace->graph_verbose = 0;
 
 	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
 	if (ftrace->profile_hash == NULL)
@@ -1660,6 +1661,9 @@ int cmd_ftrace(int argc, const char **argv)
 	OPT_CALLBACK('s', "sort", &profile_sort, "key",
 		     "Sort result by key: total (default), avg, max, count, name.",
 		     parse_sort_key),
+	OPT_CALLBACK(0, "graph-opts", &ftrace, "options",
+		     "Graph tracer options, available options: nosleep-time,noirqs,thresh=<n>,depth=<n>",
+		     parse_graph_tracer_opts),
 	OPT_PARENT(common_options),
 	};
 	const struct option *options = ftrace_options;
-- 
2.47.1.613.gc27f4b7a9f-goog

