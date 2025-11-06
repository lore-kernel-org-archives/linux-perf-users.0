Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A721FF2E;
	Thu,  6 Nov 2025 07:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762414115; cv=none; b=nF42nqej2ZISvrMu7L4Z//sbX6g5wW2fXiJDYfgXOAIAGSz5lDSky+vfcSMBXkamB5E+GlokKYl3i4kPbzFvHzYDxmY8zDQGZraBrZMLn9GEytGKEKKPnkKcRJv3DBOZqP9jNU6eVUXGVIxR2wFjTl3nqUj6wcWTG9YpuWrwJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762414115; c=relaxed/simple;
	bh=5GFgLQayQxL+0EO09s0cLKYJvaSzj5FZ7EbeMU2N5MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mZ7HxNP8KL/7nKb8KuIiuwvTsVwBawTpAP9PYiaGZjVwFo8uNaWIIIg4PIGrat6GCnk7caKwg/pP9uKk7XXMqifNBxQhLqjcHaHVKl2B8EkfiKkUk6cAT2Yo4jgiUDPv3BF7EG7QrlVy438RWSQawJC80Ikxl9s8WnwrqUHyPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2CHkhgo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2CHkhgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BDAC4CEF7;
	Thu,  6 Nov 2025 07:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762414115;
	bh=5GFgLQayQxL+0EO09s0cLKYJvaSzj5FZ7EbeMU2N5MQ=;
	h=From:To:Cc:Subject:Date:From;
	b=k2CHkhgopIagvwdl2Jl3EgYMzCOWTC9ISqFGfMKgY2aexPhkz0ozDZ+4f+7eFL8Ic
	 xdGbCc42zCobldqNX5u+FdJtZ/d7F4Zo/ecV8OdBGpwsY7haFMD04X4gf1WYmK8jDN
	 0AptJVgE5uuZicjDtRk+9oMYv7jBZgq1kELiZEEtkuH2Z3scf6k28U5M+zyaOKtUb2
	 kql2asTemixsFzKHDG6n3oNvQKS5J2wYz1XNLnUiNDJ2wp0VVySuOXoy5HwJQFgKrU
	 nJjno3/Qu+7LUfqeQM9Cz5ghwgDZjVaxwnEIPs9Q4XdNSpOgDAvBV70iXTyCB0Khek
	 upj0cTdgY6ong==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] perf stat: Align metric output without events
Date: Wed,  5 Nov 2025 23:28:34 -0800
Message-ID: <20251106072834.1750880-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.2.1026.g39e6a42477-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

One of my concern in the perf stat output was the alignment in the
metrics and shadow stats.  I think it missed to calculate the basic
output length using COUNTS_LEN and EVNAME_LEN but missed to add the
unit length like "msec" and surround 2 spaces.  I'm not sure why it's
not printed below though.

But anyway, now it shows correctly aligned metric output.

  $ perf stat true

   Performance counter stats for 'true':

             859,772      task-clock                       #    0.395 CPUs utilized
                   0      context-switches                 #    0.000 /sec
                   0      cpu-migrations                   #    0.000 /sec
                  56      page-faults                      #   65.134 K/sec
           1,075,022      instructions                     #    0.86  insn per cycle
           1,255,911      cycles                           #    1.461 GHz
             220,573      branches                         #  256.548 M/sec
               7,381      branch-misses                    #    3.35% of all branches
                          TopdownL1                        #     19.2 %  tma_retiring
                                                           #     28.6 %  tma_backend_bound
                                                           #      9.5 %  tma_bad_speculation
                                                           #     42.6 %  tma_frontend_bound

         0.002174871 seconds time elapsed                  ^
                                                           |
         0.002154000 seconds user                          |
         0.000000000 seconds sys                          here

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a67b991f4e810336..8fbfec5c0ef7b147 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -439,9 +439,9 @@ static inline void __new_line_std_csv(struct perf_stat_config *config,
 	aggr_printout(config, os, os->evsel, os->id, os->aggr_nr);
 }
 
-static inline void __new_line_std(struct outstate *os)
+static inline void __new_line_std(struct perf_stat_config *config, struct outstate *os)
 {
-	fprintf(os->fh, "                                                 ");
+	fprintf(os->fh, "%*s", COUNTS_LEN + EVNAME_LEN + config->unit_width + 2, "");
 }
 
 static void do_new_line_std(struct perf_stat_config *config,
@@ -450,7 +450,7 @@ static void do_new_line_std(struct perf_stat_config *config,
 	__new_line_std_csv(config, os);
 	if (config->aggr_mode == AGGR_NONE)
 		fprintf(os->fh, "        ");
-	__new_line_std(os);
+	__new_line_std(config, os);
 }
 
 static void print_metric_std(struct perf_stat_config *config,
@@ -583,13 +583,13 @@ static void print_metricgroup_header_std(struct perf_stat_config *config,
 	int n;
 
 	if (!metricgroup_name) {
-		__new_line_std(os);
+		__new_line_std(config, os);
 		return;
 	}
 
 	n = fprintf(config->output, " %*s", EVNAME_LEN, metricgroup_name);
 
-	fprintf(config->output, "%*s", MGROUP_LEN - n - 1, "");
+	fprintf(config->output, "%*s", MGROUP_LEN + config->unit_width + 2 - n, "");
 }
 
 /* Filter out some columns that don't work well in metrics only mode */
-- 
2.51.2.1026.g39e6a42477-goog

