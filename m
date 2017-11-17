From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 75/83] perf evsel: Centralize perf_sample initialization
Date: Fri, 17 Nov 2017 17:15:53 -0300
Message-ID: <20171117201601.24110-76-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161773AbdKQUUT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:20:19 -0500
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jiri Olsa <jolsa@kernel.org>

Move the initialization bits into common place at the beginning of the
function.

Also removing some superfluous zero initialization for addr and
transaction, because we zero all the data at the top.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-1gv5t6fvv735t1rt3mxpy1h9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b8e9def77f44..03d7abcdc6b7 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1983,6 +1983,8 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 	data->stream_id = data->id = data->time = -1ULL;
 	data->period = evsel->attr.sample_period;
 	data->cpumode = event->header.misc & PERF_RECORD_MISC_CPUMODE_MASK;
+	data->id = -1ULL;
+	data->data_src = PERF_MEM_DATA_SRC_NONE;
 
 	if (event->header.type != PERF_RECORD_SAMPLE) {
 		if (!evsel->attr.sample_id_all)
@@ -2000,7 +2002,6 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 	if (evsel->sample_size + sizeof(event->header) > event->header.size)
 		return -EFAULT;
 
-	data->id = -1ULL;
 	if (type & PERF_SAMPLE_IDENTIFIER) {
 		data->id = *array;
 		array++;
@@ -2030,7 +2031,6 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		array++;
 	}
 
-	data->addr = 0;
 	if (type & PERF_SAMPLE_ADDR) {
 		data->addr = *array;
 		array++;
@@ -2194,14 +2194,12 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		array++;
 	}
 
-	data->data_src = PERF_MEM_DATA_SRC_NONE;
 	if (type & PERF_SAMPLE_DATA_SRC) {
 		OVERFLOW_CHECK_u64(array);
 		data->data_src = *array;
 		array++;
 	}
 
-	data->transaction = 0;
 	if (type & PERF_SAMPLE_TRANSACTION) {
 		OVERFLOW_CHECK_u64(array);
 		data->transaction = *array;
-- 
2.13.6
