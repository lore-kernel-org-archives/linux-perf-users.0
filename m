From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 74/83] perf callchain: Reset cursor arg instead of callchain_cursor
Date: Fri, 17 Nov 2017 17:15:52 -0300
Message-ID: <20171117201601.24110-75-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We already pass cursor into thread__resolve_callchain function, so
there's no point in resetting the global instance.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-puk015qvuppao9m1xtdy9v7j@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 270f3223c6df..64d255f6a537 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2204,7 +2204,7 @@ int thread__resolve_callchain(struct thread *thread,
 {
 	int ret = 0;
 
-	callchain_cursor_reset(&callchain_cursor);
+	callchain_cursor_reset(cursor);
 
 	if (callchain_param.order == ORDER_CALLEE) {
 		ret = thread__resolve_callchain_sample(thread, cursor,
-- 
2.13.6
