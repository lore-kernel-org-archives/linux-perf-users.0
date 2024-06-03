Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D7B13D27F;
	Mon,  3 Jun 2024 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454656; cv=none; b=tjIpAX/6e7w5H3C7sD3j/C5QiOx5Yxh/i/fQI70GeYB+5k4LF5HbdpNHcmrQjSOnxveGHLQguxyBbO1GvpDfkEosS4oHdaYhhsXPaUqqC7QJ6o67D/x15SQWkjVGuuSThjt6ZhQzuuzhKCmjBLJb9FcggPonXeTw3na5YPoDHY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454656; c=relaxed/simple;
	bh=jSrJ9iNN+XlHHSV30984S7Q4L1nAEpF0UPaMLYCqwls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtmeDSt/I+5hqzzhpwaGgoaDPzi9WhL8+zrtR9ZzEm94pvnsAxq3y05zqYlppEDPhoxnRqn7/8hiNcheoRrJF9H5fXjqrG8UTLxLJzaiNURNG1+xlX9L0WDVrBA9dz6pGdd80JKgMvutNuGW/QGRfqjGg8b3rbW1nb9//txksrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdsIo1cG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdsIo1cG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E086C4AF0E;
	Mon,  3 Jun 2024 22:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717454655;
	bh=jSrJ9iNN+XlHHSV30984S7Q4L1nAEpF0UPaMLYCqwls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NdsIo1cGRDVOLo7Wc9L5DwpE676YaatVb0A00KZ+q3/e2HFYep7utc/faVMlW4I0p
	 LWLBA9ZrIB1Z/OF1G5k8gnbQ+/zvo8it0anU29XD2gna1w7CuwjdrZ5QhY64MjwK0R
	 A1Epr7I/b5apbN8S4xFhzrDkHGDharrm0xFWQY61WcmHL+/2PL4sNzrTK14lJ+DP1b
	 RrpBcy409IyjYQ0pU/i0jPcXYoV4Zgc8TXXK601HkqSn0HLVQnmXYg7gC9tqRP3Jwx
	 O2HhemQmEJ3iQ0l9KQZ8K8LAfzU7/24CtgyNBsA8yyCt4yDSNde/Y/tEya3ZEkweLm
	 gWjoxLJKieszQ==
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
Subject: [PATCH 4/4] perf hist: Honor symbol_conf.skip_empty
Date: Mon,  3 Jun 2024 15:44:12 -0700
Message-ID: <20240603224412.1910049-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240603224412.1910049-1-namhyung@kernel.org>
References: <20240603224412.1910049-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can skip events with no sample according to the config value.
This can omit the dummy event in the output of perf report --group.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c     | 18 ++++++++++++++++--
 tools/perf/util/evsel.c  | 13 ++++++++++---
 tools/perf/util/python.c |  3 +++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 539978c95cfd..d76062979ab7 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -95,6 +95,10 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	}
 
 	for (i = 0; i < nr_members; i++) {
+		if (symbol_conf.skip_empty &&
+		    data[i].hists->stats.nr_samples == 0)
+			continue;
+
 		ret += __hpp__fmt_print(hpp, data[i].hists, data[i].val,
 					data[i].samples, fmt, len,
 					print_fn, fmtype);
@@ -296,8 +300,18 @@ static int hpp__width_fn(struct perf_hpp_fmt *fmt,
 	int len = fmt->user_len ?: fmt->len;
 	struct evsel *evsel = hists_to_evsel(hists);
 
-	if (symbol_conf.event_group)
-		len = max(len, evsel->core.nr_members * fmt->len);
+	if (symbol_conf.event_group) {
+		int nr = 0;
+		struct evsel *pos;
+
+		for_each_group_evsel(pos, evsel) {
+			if (!symbol_conf.skip_empty ||
+			    evsel__hists(pos)->stats.nr_samples)
+				nr++;
+		}
+
+		len = max(len, nr * fmt->len);
+	}
 
 	if (len < (int)strlen(fmt->name))
 		len = strlen(fmt->name);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4f818ab6b662..befb80c272d2 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -53,6 +53,7 @@
 #include "../perf-sys.h"
 #include "util/parse-branch-options.h"
 #include "util/bpf-filter.h"
+#include "util/hist.h"
 #include <internal/xyarray.h>
 #include <internal/lib.h>
 #include <internal/threadmap.h>
@@ -830,16 +831,22 @@ const char *evsel__group_name(struct evsel *evsel)
 int evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 {
 	int ret = 0;
+	bool first = true;
 	struct evsel *pos;
 	const char *group_name = evsel__group_name(evsel);
 
 	if (!evsel->forced_leader)
 		ret = scnprintf(buf, size, "%s { ", group_name);
 
-	ret += scnprintf(buf + ret, size - ret, "%s", evsel__name(evsel));
+	for_each_group_evsel(pos, evsel) {
+		if (symbol_conf.skip_empty &&
+		    evsel__hists(pos)->stats.nr_samples == 0)
+			continue;
 
-	for_each_group_member(pos, evsel)
-		ret += scnprintf(buf + ret, size - ret, ", %s", evsel__name(pos));
+		ret += scnprintf(buf + ret, size - ret, "%s%s",
+				 first ? "" : ", ", evsel__name(pos));
+		first = false;
+	}
 
 	if (!evsel->forced_leader)
 		ret += scnprintf(buf + ret, size - ret, " }");
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 0aeb97c11c03..88f98f2772fb 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -23,6 +23,7 @@
 #include "util/env.h"
 #include "util/pmu.h"
 #include "util/pmus.h"
+#include "util/symbol_conf.h"
 #include <internal/lib.h>
 #include "util.h"
 
@@ -50,6 +51,8 @@
 #define Py_TYPE(ob) (((PyObject*)(ob))->ob_type)
 #endif
 
+struct symbol_conf symbol_conf;
+
 /*
  * Avoid bringing in event parsing.
  */
-- 
2.45.1.288.g0e0cd299f1-goog

