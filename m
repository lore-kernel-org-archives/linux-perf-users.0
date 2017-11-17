From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/83] perf evsel: Fix up leftover perf_evsel_stat usage via evsel->priv
Date: Fri, 17 Nov 2017 17:15:20 -0300
Message-ID: <20171117201601.24110-43-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753150AbdKQUSf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:18:35 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

I forgot one conversion, which got noticed by Thomas when running:

  $ perf stat  -e '{cpu-clock,instructions}' kill
  kill: not enough arguments
  Segmentation fault (core dumped)
  $

Fix it, those stats are in evsel->stats, not anymore in evsel->priv.

Reported-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Tested-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: e669e833da8d ("perf evsel: Restore evsel->priv as a tool private area")
Link: http://lkml.kernel.org/r/20171109150046.GN4333@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4376cdfaea49..cb9bcdb065ea 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1377,7 +1377,7 @@ perf_evsel__process_group_data(struct perf_evsel *leader,
 static int
 perf_evsel__read_group(struct perf_evsel *leader, int cpu, int thread)
 {
-	struct perf_stat_evsel *ps = leader->priv;
+	struct perf_stat_evsel *ps = leader->stats;
 	u64 read_format = leader->attr.read_format;
 	int size = perf_evsel__read_size(leader);
 	u64 *data = ps->group_data;
-- 
2.13.6
