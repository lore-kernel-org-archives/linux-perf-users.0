Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAA21552EF;
	Fri,  7 Jun 2024 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717792162; cv=none; b=A3D7mIjjpzBX785rYPBZslvvtWSGdpZEwNkY4REZVmsoxDyQyFUZx51wYhJ+bwLPLMpUfSp7kfBQr5ylhxYdZyp2qYChAOoYCTvPJC+zLLtNuBMjJ9t8FI6kmgwhnWNhoCgWuVwNZSC++J20nHUwJFNEAJArPMBlxT0HEQLO1Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717792162; c=relaxed/simple;
	bh=Bdv1T3V+QVoamQb/wjWYwDu3U6qdpHhyUU9S4KSBk3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDf61lMMVPsDBIHRuXBE+KC9g4uedh+76QV+2ndnJqzKdnG1Q458ooxMc7E07/nlRUtYbvlzLEU81HBYqfzFscEKA+m8K6Sg0HCx1KrZXqvHr82egLTlj0Qm8BrvX5hnoo3clXw0px1I30RpiSddtTQLOy9EfZQRHrcrPMbj3OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ky9ue0y+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ky9ue0y+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60982C4AF0F;
	Fri,  7 Jun 2024 20:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717792161;
	bh=Bdv1T3V+QVoamQb/wjWYwDu3U6qdpHhyUU9S4KSBk3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ky9ue0y+/xNybgFOEj5pGu0kOmr7vYGQrZQBMDpDR5oWSotHdAojnDD9Nfu1TzIUa
	 WLbq0nlyvnSpZY7NXuwXiMtNnAg926Dm7Ge3wgd1/cB/Ie8885mkgVPrhA3HmZrT6s
	 4NS4tAIlzCepbJtzqLhpczQwr3kEreT8R6wM+/YsDQ5QF8gdMT+hMBx5/dYykDOErZ
	 3MMpO7Vaw0uM3/g4n9egvEEHkf9JOj2ZLpU58uCp461qsvEx4kOeuHuNgzxy/7aIKp
	 nK4yR5Nl+BXMJog7sY6NFEO3Qr3I6jyucwbNHFQfD3mPExW8ClVSlWmEM9HReuuZHP
	 sbz9Hml6g18og==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/4] perf hist: Honor symbol_conf.skip_empty
Date: Fri,  7 Jun 2024 13:29:18 -0700
Message-ID: <20240607202918.2357459-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240607202918.2357459-1-namhyung@kernel.org>
References: <20240607202918.2357459-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that it can skip events with no sample according to the config value.
This can omit the dummy event in the output of perf report --group.

An example output:

  $ sudo perf mem record -a sleep 1
  $ sudo perf report --group

Before)
  #
  # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P, dummy:u'
  # Event count (approx.): 3089861
  #
  #                 Overhead  Command      Shared Object      Symbol
  # ........................  ...........  .................  .....................................
  #
       9.29%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
       5.26%   0.15%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
       4.15%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
       3.87%   0.00%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
       3.79%   0.17%   0.00%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
       3.63%   0.00%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
       2.86%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
       2.78%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
       2.34%   0.00%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
       2.32%   0.97%   0.00%  swapper      [kernel.kallsyms]  [k] psi_group_change

After)
  #
  # Samples: 232  of events 'cpu/mem-loads,ldlat=30/P, cpu/mem-stores/P'
  # Event count (approx.): 3089861
  #
  #         Overhead  Command      Shared Object      Symbol
  # ................  ...........  .................  .....................................
  #
       9.29%   0.00%  swapper      [kernel.kallsyms]  [k] update_blocked_averages
       5.26%   0.15%  swapper      [kernel.kallsyms]  [k] __update_load_avg_se
       4.15%   0.00%  perf-exec    [kernel.kallsyms]  [k] slab_update_freelist.isra.0
       3.87%   0.00%  perf-exec    [kernel.kallsyms]  [k] memcg_slab_post_alloc_hook
       3.79%   0.17%  swapper      [kernel.kallsyms]  [k] enqueue_task_fair
       3.63%   0.00%  sleep        [kernel.kallsyms]  [k] next_uptodate_page
       2.86%   0.00%  swapper      [kernel.kallsyms]  [k] __update_load_avg_cfs_rq
       2.78%   0.00%  swapper      [kernel.kallsyms]  [k] __schedule
       2.34%   0.00%  swapper      [kernel.kallsyms]  [k] intel_idle
       2.32%   0.97%  swapper      [kernel.kallsyms]  [k] psi_group_change

Now it doesn't have a column for the dummy event.

Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/hist.c     | 18 ++++++++++++++++--
 tools/perf/util/evsel.c  | 13 ++++++++++---
 tools/perf/util/python.c |  3 +++
 3 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 7e863cd92781..5d1f04f66a5a 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -95,6 +95,10 @@ static int __hpp__fmt(struct perf_hpp *hpp, struct hist_entry *he,
 	}
 
 	for (i = 0; i < nr_members; i++) {
+		if (symbol_conf.skip_empty &&
+		    values[i].hists->stats.nr_samples == 0)
+			continue;
+
 		ret += __hpp__fmt_print(hpp, values[i].hists, values[i].val,
 					values[i].samples, fmt, len,
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
2.45.2.505.gda0bf45e8d-goog

