Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233319D098;
	Thu, 27 Jun 2024 20:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719518635; cv=none; b=SGqv1KIpShi83Ns7mj+yooWxeIDrJkI3MZizO/BrvTtLFSXJphpWkbttH+905kdvuncTGJdz2BNZ/TbCN1hoaCyUCEjqPaRsn/cP+rjubVeYMRZ2sAZzohcigiclOCw4HQCx5QMHhdPNuLGBvrhExZbX9ht+PB40pD8XlrWuM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719518635; c=relaxed/simple;
	bh=5fhM/yWehiXwJfbP82u1cStk7xDHumCVqpfOvwP3aPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7Vp4PaEKrFVtMZ/W0DCgnkBrlz+Vody56QldhuHjd1BaYVXS9Ig0CMYLnGzgB9Stifj+upGTqML8u/RtoWuxnNa6MUAYN5GcpsupwLTjflvGErWgTBg9nMWFl9dpDtNkwmjrp5J6phDBuU4yp2ut7e7um1ICDc62qynNJrCmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIkz3zRU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIkz3zRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C331C4AF07;
	Thu, 27 Jun 2024 20:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719518634;
	bh=5fhM/yWehiXwJfbP82u1cStk7xDHumCVqpfOvwP3aPY=;
	h=From:To:Cc:Subject:Date:From;
	b=XIkz3zRUFOvLndmiZH7wyShAc8OMS+kNQO2KqTczjT/ICUOPcN4BLLJF9GgnzwqAS
	 qlYua9VFVQzSzxeepPtkL4H6tkY4tPs5Jz+wWsrpv9/FdY+cmezyXzjZRX2F0DMulD
	 +KXKsB4XSYYcrzOBhsHxL/W19UBDphBlgRFatn1zIkqnak1B+6qbPevGRqB11ebizk
	 DZRFMIz/r/lJkXwk0/ETHBqkYwT5RSAtGqxEfz3S3xwbsGuT+EYx+NTWmrLW6ARGDd
	 faRJ4oA/felcv2sLRp9/WHEr/zbA0YBUmf8K4LrEweMKv37CZLUr3Mmj1eSpCv+bfG
	 Ie14wYxKBaxMA==
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
Subject: [PATCH 1/2] perf stat: Use field separator in the metric header
Date: Thu, 27 Jun 2024 13:03:52 -0700
Message-ID: <20240627200353.1230407-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It didn't use the passed field separator (using -x option) when it
prints the metric headers and always put "," between the fields.

Before:
  $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
  core,cpus,%  tma_core_bound:     <<<--- here: "core,cpus," but ":" expected
  S0-D0-C0:2:10.5:
  S0-D0-C1:2:14.8:
  S0-D0-C2:2:9.9:
  S0-D0-C3:2:13.2:

After:
  $ sudo ./perf stat -a -x : --per-core -M tma_core_bound --metric-only true
  core:cpus:%  tma_core_bound:
  S0-D0-C0:2:10.5:
  S0-D0-C1:2:15.0:
  S0-D0-C2:2:16.5:
  S0-D0-C3:2:12.5:

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/stat-display.c | 37 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 91d2f7f65df7..e8673c9f6b49 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -47,16 +47,27 @@ static int aggr_header_lens[] = {
 };
 
 static const char *aggr_header_csv[] = {
-	[AGGR_CORE] 	= 	"core,cpus,",
-	[AGGR_CACHE]	= 	"cache,cpus,",
-	[AGGR_DIE] 	= 	"die,cpus,",
-	[AGGR_SOCKET] 	= 	"socket,cpus,",
-	[AGGR_NONE] 	= 	"cpu,",
-	[AGGR_THREAD] 	= 	"comm-pid,",
-	[AGGR_NODE] 	= 	"node,",
+	[AGGR_CORE] 	= 	"core%scpus%s",
+	[AGGR_CACHE]	= 	"cache%scpus%s",
+	[AGGR_DIE] 	= 	"die%scpus%s",
+	[AGGR_SOCKET] 	= 	"socket%scpus%s",
+	[AGGR_NONE] 	= 	"cpu%s",
+	[AGGR_THREAD] 	= 	"comm-pid%s",
+	[AGGR_NODE] 	= 	"node%s",
 	[AGGR_GLOBAL] 	=	""
 };
 
+static int aggr_header_num[] = {
+	[AGGR_CORE] 	= 	2,
+	[AGGR_CACHE]	= 	2,
+	[AGGR_DIE] 	= 	2,
+	[AGGR_SOCKET] 	= 	2,
+	[AGGR_NONE] 	= 	1,
+	[AGGR_THREAD] 	= 	1,
+	[AGGR_NODE] 	= 	1,
+	[AGGR_GLOBAL] 	=	0,
+};
+
 static const char *aggr_header_std[] = {
 	[AGGR_CORE] 	= 	"core",
 	[AGGR_CACHE] 	= 	"cache",
@@ -1185,8 +1196,18 @@ static void print_metric_headers_csv(struct perf_stat_config *config,
 {
 	if (config->interval)
 		fputs("time,", config->output);
-	if (!config->iostat_run)
+	if (config->iostat_run)
+		return;
+
+	if (aggr_header_num[config->aggr_mode] == 1) {
+		fprintf(config->output, aggr_header_csv[config->aggr_mode],
+			config->csv_sep);
+	} else if (aggr_header_num[config->aggr_mode] == 2) {
+		fprintf(config->output, aggr_header_csv[config->aggr_mode],
+			config->csv_sep, config->csv_sep);
+	} else {
 		fputs(aggr_header_csv[config->aggr_mode], config->output);
+	}
 }
 
 static void print_metric_headers_json(struct perf_stat_config *config __maybe_unused,
-- 
2.45.2.803.g4e1b14247a-goog

