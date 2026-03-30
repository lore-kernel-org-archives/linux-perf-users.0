Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D01220F49;
	Mon, 30 Mar 2026 20:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901681; cv=none; b=L3WS4sdXgTUcpi7h+QE5doN9ZuLFbfbf45DJSXyIbNMHfgpP35HmzZU/lP3cEHkPV3MNXX9MRzoLl+QiEPgqij5jZPMVbAA7kOUwbnOjBSP/6AjIuA9tCIzcZgo2aHtG8Zf/tVilynu00wc1Xh+VhKl4dSDm3TtBLkEYL2YEJkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901681; c=relaxed/simple;
	bh=nS0ssTuUzF2GY5XGcmISrdR8ZRo1f7kZk59QSbhVIZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCqLxvJgdaoQQkuWihpC8sUHjyT7sdcCnk1zz3o75at66uwtVgDRqokWLwHFgFdkZ/l4vMujjq7njKI6xooOEU9ijlvl+K60vsHKmbNTznMTknjp30+egh2FDoB9RDjm1bOIy1iNZsUxi8zDxQbNWCUJgNIIv1q6dzU3e1x7AWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7xhOTxO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7xhOTxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D77EC4CEF7;
	Mon, 30 Mar 2026 20:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774901680;
	bh=nS0ssTuUzF2GY5XGcmISrdR8ZRo1f7kZk59QSbhVIZU=;
	h=From:To:Cc:Subject:Date:From;
	b=H7xhOTxOVMR+lLa2Pyo+Gdbl2pd1c9cZR/xMduq6vAxJ7msxaBtebLkeX+Vj9d2m/
	 rORh0bbWhLymJLK5kBZVbvuG5gU2S6WgSwRAkSq7WSrE2PkxcvxdUHnFpkowM1/PFI
	 Wug+XXRhQW7wv0PPbtLDYXP1eYzb1U1bo7/HZJ5+LLDN7x/lkrJkj4Jnt/gyqtx03i
	 N6U5lVRisHDCWq6cZoljPR7x2NWdIMcjHttiDaCLqfSoLM06lzWBa2q/gs7WopH8Qe
	 214KhMJI6paj3TX2U82AZlWsYpkB0sEzg1AJJr+D+LE1Vz7PtDGGwY+w3qd6xRqlZD
	 /j4b1i6+SpcWQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Skip unnecessary synthesis for summary-only mode
Date: Mon, 30 Mar 2026 13:14:39 -0700
Message-ID: <20260330201439.689899-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0.1185.g05d4b7b318-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It needs to synthesize task info for the comm name.  The mmap
information is only needed for callchain symbolization which is not used
by the summary mode.  Also total or cgroup summary mode don't require
the task info.  Let's skip the processing if possible.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-trace.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f487fbaa0ad60028..d09d78b3222717d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2004,11 +2004,23 @@ static int trace__symbols_init(struct trace *trace, int argc, const char **argv,
 	if (err < 0)
 		goto out;
 
-	err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
-					    evlist->core.threads, trace__tool_process,
-					    /*needs_mmap=*/callchain_param.enabled,
-					    /*mmap_data=*/false,
-					    /*nr_threads_synthesize=*/1);
+	if (trace->summary_only) {
+		if (trace->summary_mode == SUMMARY__BY_THREAD) {
+			err = __machine__synthesize_threads(trace->host, &trace->tool,
+							    &trace->opts.target,
+							    evlist->core.threads,
+							    trace__tool_process,
+							    /*needs_mmap=*/false,
+							    /*mmap_data=*/false,
+							    /*nr_threads_synthesize=*/1);
+		}
+	} else {
+		err = __machine__synthesize_threads(trace->host, &trace->tool, &trace->opts.target,
+						    evlist->core.threads, trace__tool_process,
+						    /*needs_mmap=*/callchain_param.enabled,
+						    /*mmap_data=*/false,
+						    /*nr_threads_synthesize=*/1);
+	}
 out:
 	if (err) {
 		perf_env__exit(&trace->host_env);
-- 
2.53.0.1185.g05d4b7b318-goog

