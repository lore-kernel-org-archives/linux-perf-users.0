From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 67/83] perf: Fix header.size for namespace events
Date: Fri, 17 Nov 2017 17:15:45 -0300
Message-ID: <20171117201601.24110-68-acme@kernel.org>
References: <20171117201601.24110-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171117201601.24110-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Reset header size for namespace events, otherwise it only gets bigger in
ctx iterations.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: e422267322cd ("perf: Add PERF_RECORD_NAMESPACES to include namespaces related info")
Link: http://lkml.kernel.org/n/tip-nlo4gonz9d4guyb8153ukzt0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 81dd57b9e5e3..aa21555972aa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6640,6 +6640,7 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	struct perf_namespaces_event *namespaces_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u16 header_size = namespaces_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_namespaces_match(event))
@@ -6650,7 +6651,7 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	ret = perf_output_begin(&handle, event,
 				namespaces_event->event_id.header.size);
 	if (ret)
-		return;
+		goto out;
 
 	namespaces_event->event_id.pid = perf_event_pid(event,
 							namespaces_event->task);
@@ -6662,6 +6663,8 @@ static void perf_event_namespaces_output(struct perf_event *event,
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
+out:
+	namespaces_event->event_id.header.size = header_size;
 }
 
 static void perf_fill_ns_link_info(struct perf_ns_link_info *ns_link_info,
-- 
2.13.6
