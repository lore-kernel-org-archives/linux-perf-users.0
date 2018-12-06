From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/75] perf ordered_events: Add private data member
Date: Thu,  6 Dec 2018 18:25:34 -0300
Message-ID: <20181206212602.20474-48-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We will need it in following patch, where we can't use the
container_of() trick to get the higher level object.

Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/n/tip-vgs9aoek21v14o3obza586yy@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/ordered-events.c | 6 ++++--
 tools/perf/util/ordered-events.h | 4 +++-
 tools/perf/util/session.c        | 3 ++-
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
index 28f0f5c95024..d053aa0a7582 100644
--- a/tools/perf/util/ordered-events.c
+++ b/tools/perf/util/ordered-events.c
@@ -326,7 +326,8 @@ int ordered_events__flush(struct ordered_events *oe, enum oe_flush how)
 	return err;
 }
 
-void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver)
+void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
+			  void *data)
 {
 	INIT_LIST_HEAD(&oe->events);
 	INIT_LIST_HEAD(&oe->cache);
@@ -334,6 +335,7 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
 	oe->max_alloc_size = (u64) -1;
 	oe->cur_alloc_size = 0;
 	oe->deliver	   = deliver;
+	oe->data	   = data;
 }
 
 static void
@@ -377,5 +379,5 @@ void ordered_events__reinit(struct ordered_events *oe)
 
 	ordered_events__free(oe);
 	memset(oe, '\0', sizeof(*oe));
-	ordered_events__init(oe, old_deliver);
+	ordered_events__init(oe, old_deliver, oe->data);
 }
diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
index 1338d5c345dc..507b4e4df79e 100644
--- a/tools/perf/util/ordered-events.h
+++ b/tools/perf/util/ordered-events.h
@@ -47,13 +47,15 @@ struct ordered_events {
 	enum oe_flush			 last_flush_type;
 	u32				 nr_unordered_events;
 	bool				 copy_on_queue;
+	void				*data;
 };
 
 int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
 			  u64 timestamp, u64 file_offset);
 void ordered_events__delete(struct ordered_events *oe, struct ordered_event *event);
 int ordered_events__flush(struct ordered_events *oe, enum oe_flush how);
-void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver);
+void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t deliver,
+			  void *data);
 void ordered_events__free(struct ordered_events *oe);
 void ordered_events__reinit(struct ordered_events *oe);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f8eab197f35c..78a067777144 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -126,7 +126,8 @@ struct perf_session *perf_session__new(struct perf_data *data,
 	session->tool   = tool;
 	INIT_LIST_HEAD(&session->auxtrace_index);
 	machines__init(&session->machines);
-	ordered_events__init(&session->ordered_events, ordered_events__deliver_event);
+	ordered_events__init(&session->ordered_events,
+			     ordered_events__deliver_event, NULL);
 
 	if (data) {
 		if (perf_data__open(data))
-- 
2.19.2
