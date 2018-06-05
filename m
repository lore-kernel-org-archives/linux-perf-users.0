From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/46] perf tools: No need to check if the argument to __get() function is NULL
Date: Tue,  5 Jun 2018 14:49:48 -0300
Message-ID: <20180605175030.32549-5-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Those functions always check if the argument is NULL before trying to
grab a reference count, and also will return the received object, so, to
make code more compact, no need to check for NULL.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Krister Johansen <kjlx@templeofstupid.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-i9wycjdxh0fwhryu55lmafks@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c | 3 +--
 tools/perf/util/hist.c     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index c0065923a525..99de91698de1 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -81,8 +81,7 @@ static int parse_probe_event(const char *str)
 		params.target_used = true;
 	}
 
-	if (params.nsi)
-		pev->nsi = nsinfo__get(params.nsi);
+	pev->nsi = nsinfo__get(params.nsi);
 
 	/* Parse a perf-probe command into event */
 	ret = parse_perf_probe_command(str, pev);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 4d602fba40b2..95333b068109 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1039,7 +1039,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
 	int err, err2;
 	struct map *alm = NULL;
 
-	if (al && al->map)
+	if (al)
 		alm = map__get(al->map);
 
 	err = sample__resolve_callchain(iter->sample, &callchain_cursor, &iter->parent,
-- 
2.14.3
