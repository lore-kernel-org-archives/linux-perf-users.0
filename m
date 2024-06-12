Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E93317B4F9;
	Wed, 12 Jun 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199567; cv=none; b=keDZ+lw/AzKtYjotIdR1fee1KejtZKey4jfP/xMVp/l26i1eJ84AvjB5UILPy7B/xng218CI6iZ5jiOFTeOU9N+U37lKJ+xsS3gz+tqCrJEN5UO5jimbgWhADkbkDRMZu7ItuhzO5DuOl8jG7K4GkgLFaBOcnOs6fg9oI+SWW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199567; c=relaxed/simple;
	bh=PI5+EkX8OYVqu1bMcFbI20r3cQja9BDI1y3E2ywaXeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvPaice2e0mqgQ744vmbVt18inlI2wQx9FyGiPCsbPfU7Uf4n6IioibsT1cXDA/3d4LK5tbCcznGIqw431DKJ1w7RtRLi4/yzw3pPqTs5DV1qlY1c4Uv9FYbqugHkyIV77oU+QHvDNu6MWq23YIQe0aU3mCsYPPMNxoM4eR0dsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81834106F;
	Wed, 12 Jun 2024 06:39:49 -0700 (PDT)
Received: from e126817.cambridge.arm.com (e126817.cambridge.arm.com [10.2.3.5])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4708D3F64C;
	Wed, 12 Jun 2024 06:39:23 -0700 (PDT)
From: Ben Gainey <ben.gainey@arm.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: james.clark@arm.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ben Gainey <ben.gainey@arm.com>
Subject: [PATCH v8 3/4] tools/perf: Correctly calculate sample period for inherited SAMPLE_READ values
Date: Wed, 12 Jun 2024 14:39:10 +0100
Message-ID: <20240612133911.3447625-4-ben.gainey@arm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612133911.3447625-1-ben.gainey@arm.com>
References: <20240612133911.3447625-1-ben.gainey@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sample period calculation in deliver_sample_value is updated to
calculate the per-thread period delta for events that are inherit +
PERF_SAMPLE_READ. When the sampling event has this configuration, the
read_format.id is used with the tid from the sample to lookup the
storage of the previously accumulated counter total before calculating
the delta. All existing valid configurations where read_format.value
represents some global value continue to use just the read_format.id to
locate the storage of the previously accumulated total.

perf_sample_id is modified to support tracking per-thread
values, along with the existing global per-id values. In the
per-thread case, values are stored in a hash by tid within the
perf_sample_id, and are dynamically allocated as the number is not known
ahead of time.

Signed-off-by: Ben Gainey <ben.gainey@arm.com>
---
 tools/lib/perf/evsel.c                  | 48 +++++++++++++++++++
 tools/lib/perf/include/internal/evsel.h | 63 ++++++++++++++++++++++++-
 tools/perf/util/session.c               | 25 ++++++----
 3 files changed, 126 insertions(+), 10 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index c07160953224..abdae2f9498b 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -5,6 +5,7 @@
 #include <perf/evsel.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
+#include <linux/hash.h>
 #include <linux/list.h>
 #include <internal/evsel.h>
 #include <linux/zalloc.h>
@@ -23,6 +24,7 @@ void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr,
 		      int idx)
 {
 	INIT_LIST_HEAD(&evsel->node);
+	INIT_LIST_HEAD(&evsel->per_stream_periods);
 	evsel->attr = *attr;
 	evsel->idx  = idx;
 	evsel->leader = evsel;
@@ -531,10 +533,56 @@ int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads)
 
 void perf_evsel__free_id(struct perf_evsel *evsel)
 {
+	struct perf_sample_id_period *pos, *n;
+
 	xyarray__delete(evsel->sample_id);
 	evsel->sample_id = NULL;
 	zfree(&evsel->id);
 	evsel->ids = 0;
+
+	perf_evsel_for_each_per_thread_period_safe(evsel, n, pos) {
+		list_del_init(&pos->node);
+		free(pos);
+	}
+}
+
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel)
+{
+	return (evsel->attr.sample_type & PERF_SAMPLE_READ)
+		&& (evsel->attr.sample_type & PERF_SAMPLE_TID)
+		&& evsel->attr.inherit;
+}
+
+u64 *perf_sample_id__get_period_storage(struct perf_sample_id *sid, u32 tid, bool per_thread)
+{
+	struct hlist_head *head;
+	struct perf_sample_id_period *res;
+	int hash;
+
+	if (!per_thread)
+		return &sid->period;
+
+	hash = hash_32(tid, PERF_SAMPLE_ID__HLIST_BITS);
+	head = &sid->periods[hash];
+
+	hlist_for_each_entry(res, head, hnode)
+		if (res->tid == tid)
+			return &res->period;
+
+	if (sid->evsel == NULL)
+		return NULL;
+
+	res = zalloc(sizeof(struct perf_sample_id_period));
+	if (res == NULL)
+		return NULL;
+
+	INIT_LIST_HEAD(&res->node);
+	res->tid = tid;
+
+	list_add_tail(&res->node, &sid->evsel->per_stream_periods);
+	hlist_add_head(&res->hnode, &sid->periods[hash]);
+
+	return &res->period;
 }
 
 void perf_counts_values__scale(struct perf_counts_values *count,
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 5cd220a61962..ea78defa77d0 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -11,6 +11,32 @@
 struct perf_thread_map;
 struct xyarray;
 
+/**
+ * The per-thread accumulated period storage node.
+ */
+struct perf_sample_id_period {
+	struct list_head	node;
+	struct hlist_node	hnode;
+	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
+	u64			period;
+	/* The TID that the values belongs to */
+	u32			tid;
+};
+
+/**
+ * perf_evsel_for_each_per_thread_period_safe - safely iterate thru all the
+ * per_stream_periods
+ * @evlist:perf_evsel instance to iterate
+ * @item: struct perf_sample_id_period iterator
+ * @tmp: struct perf_sample_id_period temp iterator
+ */
+#define perf_evsel_for_each_per_thread_period_safe(evsel, tmp, item) \
+	list_for_each_entry_safe(item, tmp, &(evsel)->per_stream_periods, node)
+
+
+#define PERF_SAMPLE_ID__HLIST_BITS 4
+#define PERF_SAMPLE_ID__HLIST_SIZE (1 << PERF_SAMPLE_ID__HLIST_BITS)
+
 /*
  * Per fd, to map back from PERF_SAMPLE_ID to evsel, only used when there are
  * more than one entry in the evlist.
@@ -34,8 +60,32 @@ struct perf_sample_id {
 	pid_t			 machine_pid;
 	struct perf_cpu		 vcpu;
 
-	/* Holds total ID period value for PERF_SAMPLE_READ processing. */
-	u64			 period;
+	/*
+	 * Per-thread, and global event counts are mutually exclusive:
+	 * Whilst it is possible to combine events into a group with differing
+	 * values of PERF_SAMPLE_READ, it is not valid to have inconsistent
+	 * values for `inherit`. Therefore it is not possible to have a
+	 * situation where a per-thread event is sampled as a global event;
+	 * all !inherit groups are global, and all groups where the sampling
+	 * event is inherit + PERF_SAMPLE_READ will be per-thread. Any event
+	 * that is part of such a group that is inherit but not PERF_SAMPLE_READ
+	 * will be read as per-thread. If such an event can also trigger a
+	 * sample (such as with sample_period > 0) then it will not cause
+	 * `read_format` to be included in its PERF_RECORD_SAMPLE, and
+	 * therefore will not expose the per-thread group members as global.
+	 */
+	union {
+		/*
+		 * Holds total ID period value for PERF_SAMPLE_READ processing
+		 * (when period is not per-thread).
+		 */
+		u64			period;
+		/*
+		 * Holds total ID period value for PERF_SAMPLE_READ processing
+		 * (when period is per-thread).
+		 */
+		struct hlist_head	periods[PERF_SAMPLE_ID__HLIST_SIZE];
+	};
 };
 
 struct perf_evsel {
@@ -58,6 +108,10 @@ struct perf_evsel {
 	u32			 ids;
 	struct perf_evsel	*leader;
 
+	/* For events where the read_format value is per-thread rather than
+	 * global, stores the per-thread cumulative period */
+	struct list_head	per_stream_periods;
+
 	/* parse modifier helper */
 	int			 nr_members;
 	/*
@@ -88,4 +142,9 @@ int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__free_id(struct perf_evsel *evsel);
 
+bool perf_evsel__attr_has_per_thread_sample_period(struct perf_evsel *evsel);
+
+u64 *perf_sample_id__get_period_storage(struct perf_sample_id *sid, u32 tid,
+					bool per_thread);
+
 #endif /* __LIBPERF_INTERNAL_EVSEL_H */
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a10343b9dcd4..3515024986d5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1474,18 +1474,24 @@ static int deliver_sample_value(struct evlist *evlist,
 				union perf_event *event,
 				struct perf_sample *sample,
 				struct sample_read_value *v,
-				struct machine *machine)
+				struct machine *machine,
+				bool per_thread)
 {
 	struct perf_sample_id *sid = evlist__id2sid(evlist, v->id);
 	struct evsel *evsel;
+	u64 *storage = NULL;
 
 	if (sid) {
+		storage = perf_sample_id__get_period_storage(sid, sample->tid, per_thread);
+	}
+
+	if (storage) {
 		sample->id     = v->id;
-		sample->period = v->value - sid->period;
-		sid->period    = v->value;
+		sample->period = v->value - *storage;
+		*storage       = v->value;
 	}
 
-	if (!sid || sid->evsel == NULL) {
+	if (!storage || sid->evsel == NULL) {
 		++evlist->stats.nr_unknown_id;
 		return 0;
 	}
@@ -1506,14 +1512,15 @@ static int deliver_sample_group(struct evlist *evlist,
 				union  perf_event *event,
 				struct perf_sample *sample,
 				struct machine *machine,
-				u64 read_format)
+				u64 read_format,
+				bool per_thread)
 {
 	int ret = -EINVAL;
 	struct sample_read_value *v = sample->read.group.values;
 
 	sample_read_group__for_each(v, sample->read.group.nr, read_format) {
 		ret = deliver_sample_value(evlist, tool, event, sample, v,
-					   machine);
+					   machine, per_thread);
 		if (ret)
 			break;
 	}
@@ -1528,6 +1535,7 @@ static int evlist__deliver_sample(struct evlist *evlist, struct perf_tool *tool,
 	/* We know evsel != NULL. */
 	u64 sample_type = evsel->core.attr.sample_type;
 	u64 read_format = evsel->core.attr.read_format;
+	bool per_thread = perf_evsel__attr_has_per_thread_sample_period(&evsel->core);
 
 	/* Standard sample delivery. */
 	if (!(sample_type & PERF_SAMPLE_READ))
@@ -1536,10 +1544,11 @@ static int evlist__deliver_sample(struct evlist *evlist, struct perf_tool *tool,
 	/* For PERF_SAMPLE_READ we have either single or group mode. */
 	if (read_format & PERF_FORMAT_GROUP)
 		return deliver_sample_group(evlist, tool, event, sample,
-					    machine, read_format);
+					    machine, read_format, per_thread);
 	else
 		return deliver_sample_value(evlist, tool, event, sample,
-					    &sample->read.one, machine);
+					    &sample->read.one, machine,
+					    per_thread);
 }
 
 static int machines__deliver_event(struct machines *machines,
-- 
2.45.2

