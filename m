From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/43] perf report: Fix regression when decoding intel_pt traces
Date: Tue, 23 Jan 2018 10:12:16 -0300
Message-ID: <20180123131251.28197-9-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752072AbeAWNNU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Jan 2018 08:13:20 -0500
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Commit (93d10af26bb7 perf tools: Optimize sample parsing for ordered
events) breaks intelPT trace decoding by invariably returning an error
if the event type isn't a PERF_SAMPLE_TIME.

With this patch the timestamp is initialised and processing is allowed
to continue if the error returned by function
perf_evlist__parse_sample_timestamp() is not a fault.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 93d10af26bb7 ("perf tools: Optimize sample parsing for ordered events")
Link: http://lkml.kernel.org/r/1515616312-27645-1-git-send-email-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 8d0fa2f8da16..c71ced7db152 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1508,10 +1508,10 @@ static s64 perf_session__process_event(struct perf_session *session,
 		return perf_session__process_user_event(session, event, file_offset);
 
 	if (tool->ordered_events) {
-		u64 timestamp;
+		u64 timestamp = -1ULL;
 
 		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
-		if (ret)
+		if (ret && ret != -1)
 			return ret;
 
 		ret = perf_session__queue_event(session, event, timestamp, file_offset);
-- 
2.14.3
