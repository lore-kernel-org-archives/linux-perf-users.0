Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80571DE895;
	Tue,  7 Jan 2025 22:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736289834; cv=none; b=jAyvJwxD8+OrcJuNk9dsb25hqG2NQ3Fp7TFV71p3+yCLoaHBblRsnlEWcgjypt6vNqjU4Jvx/l2WDoN7cqH6YoT/3bF4p7ubw6jBgcZNtj7jTntuM9yjYrMKQ/3dUx5Fp/HQx7AZai+yJCGHSQ02uMA31XVTXHMoo2M7JIWzFVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736289834; c=relaxed/simple;
	bh=H/5RyzuoGg3CahRj9FsVc60ornaj8RNUZ6q5BAFrF20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oY2xE9UCj3OWDX7pTjuYNwGLyCVvUmeowwEJpaPdi3ied1KoODiyTYHj3W5ZisekRuFBmAF4g1AaqQeVd0VU6TA/BdGnlFEGvQaLfojCAaTyqNONcAw3BQgOHJWbLmqzBCLsoP6cncQk8X3RiE/PNZPu2PngwWZX54+7gF6OVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgaqHsKo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgaqHsKo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDB4C4CEDF;
	Tue,  7 Jan 2025 22:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736289834;
	bh=H/5RyzuoGg3CahRj9FsVc60ornaj8RNUZ6q5BAFrF20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgaqHsKoovSaGFJJnleEGbVCKdWpmVFT+rULOs9BROkNmobd9YFjbvR+wBCwuOc96
	 HuEKlaISWp37B2yL4t8x3IZoEFrIDEXdchIY/1p5c6xSfZKErJREcSESAZcG0Ka3M4
	 yfU9O8cwyRpYnOLS2yW5IvIDDqR3k1IuSuqIcgz2XgYS9wBHabNfcDWoNuLzmnpbvY
	 gNBrMB9xIJsP/oRo5oXB52vfeFkWTkDuLj1MzZmb2wlFkzstWhfYy2/VS15ElXYQbT
	 FXdEioZaZTAKjFIygjuL/R3PJvvk3sNz7WzaQE5wqSMVC+eotpG3BxdixstJo72ZNd
	 geuZDiJy/pekQ==
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
	James Clark <james.clark@linaro.org>
Subject: [PATCH v2 2/3] perf ftrace: Add --graph-opts option to profile subcommand
Date: Tue,  7 Jan 2025 14:43:51 -0800
Message-ID: <20250107224352.1128669-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20250107224352.1128669-1-namhyung@kernel.org>
References: <20250107224352.1128669-1-namhyung@kernel.org>
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

Reviewed-by: James Clark <james.clark@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-ftrace.txt | 8 ++++++++
 tools/perf/builtin-ftrace.c              | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
index eccc0483f7faecad..b77f58c4d2fdcff9 100644
--- a/tools/perf/Documentation/perf-ftrace.txt
+++ b/tools/perf/Documentation/perf-ftrace.txt
@@ -201,6 +201,14 @@ OPTIONS for 'perf ftrace profile'
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
index 2a786047ba32bcb7..08c1cc429b27e169 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -1064,6 +1064,7 @@ static int prepare_func_profile(struct perf_ftrace *ftrace)
 {
 	ftrace->tracer = "function_graph";
 	ftrace->graph_tail = 1;
+	ftrace->graph_verbose = 0;
 
 	ftrace->profile_hash = hashmap__new(profile_hash, profile_equal, NULL);
 	if (ftrace->profile_hash == NULL)
@@ -1650,6 +1651,9 @@ int cmd_ftrace(int argc, const char **argv)
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

