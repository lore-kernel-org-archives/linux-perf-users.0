From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/36] perf tools: Rename 'backward' to 'overwrite' in evlist, mmap and record
Date: Wed,  6 Dec 2017 11:41:15 -0300
Message-ID: <20171206144115.15097-37-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753011AbdLFOnx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Dec 2017 09:43:53 -0500
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Mengting Zhang <zhangmengting@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Wang Nan <wangnan0@huawei.com>

Remove the backward/forward concept to make it uniform with user
interface (the '--overwrite' option).

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Mengting Zhang <zhangmengting@huawei.com>
Link: http://lkml.kernel.org/r/20171204165107.95327-4-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c             | 14 +++++++-------
 tools/perf/tests/backward-ring-buffer.c |  4 ++--
 tools/perf/util/evlist.c                | 30 +++++++++++++++---------------
 tools/perf/util/evlist.h                |  2 +-
 tools/perf/util/mmap.c                  | 22 +++++++++++-----------
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 26b8571d0fdb..0a5749ef8b94 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -479,7 +479,7 @@ static struct perf_event_header finished_round_event = {
 };
 
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
-				    bool backward)
+				    bool overwrite)
 {
 	u64 bytes_written = rec->bytes_written;
 	int i;
@@ -489,18 +489,18 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	if (!evlist)
 		return 0;
 
-	maps = backward ? evlist->backward_mmap : evlist->mmap;
+	maps = overwrite ? evlist->overwrite_mmap : evlist->mmap;
 	if (!maps)
 		return 0;
 
-	if (backward && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
+	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
 		return 0;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], backward, rec, record__pushfn) != 0) {
+			if (perf_mmap__push(&maps[i], overwrite, rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
@@ -520,7 +520,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	if (bytes_written != rec->bytes_written)
 		rc = record__write(rec, &finished_round_event, sizeof(finished_round_event));
 
-	if (backward)
+	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
 out:
 	return rc;
@@ -692,8 +692,8 @@ perf_evlist__pick_pc(struct perf_evlist *evlist)
 	if (evlist) {
 		if (evlist->mmap && evlist->mmap[0].base)
 			return evlist->mmap[0].base;
-		if (evlist->backward_mmap && evlist->backward_mmap[0].base)
-			return evlist->backward_mmap[0].base;
+		if (evlist->overwrite_mmap && evlist->overwrite_mmap[0].base)
+			return evlist->overwrite_mmap[0].base;
 	}
 	return NULL;
 }
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index cf37e43c42f3..4035d43523c3 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -33,8 +33,8 @@ static int count_samples(struct perf_evlist *evlist, int *sample_count,
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		union perf_event *event;
 
-		perf_mmap__read_catchup(&evlist->backward_mmap[i]);
-		while ((event = perf_mmap__read_backward(&evlist->backward_mmap[i])) != NULL) {
+		perf_mmap__read_catchup(&evlist->overwrite_mmap[i]);
+		while ((event = perf_mmap__read_backward(&evlist->overwrite_mmap[i])) != NULL) {
 			const u32 type = event->header.type;
 
 			switch (type) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b1cea711232b..3570355bcf39 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -125,7 +125,7 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	zfree(&evlist->mmap);
-	zfree(&evlist->backward_mmap);
+	zfree(&evlist->overwrite_mmap);
 	fdarray__exit(&evlist->pollfd);
 }
 
@@ -675,11 +675,11 @@ static int perf_evlist__set_paused(struct perf_evlist *evlist, bool value)
 {
 	int i;
 
-	if (!evlist->backward_mmap)
+	if (!evlist->overwrite_mmap)
 		return 0;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		int fd = evlist->backward_mmap[i].fd;
+		int fd = evlist->overwrite_mmap[i].fd;
 		int err;
 
 		if (fd < 0)
@@ -749,16 +749,16 @@ static void perf_evlist__munmap_nofree(struct perf_evlist *evlist)
 		for (i = 0; i < evlist->nr_mmaps; i++)
 			perf_mmap__munmap(&evlist->mmap[i]);
 
-	if (evlist->backward_mmap)
+	if (evlist->overwrite_mmap)
 		for (i = 0; i < evlist->nr_mmaps; i++)
-			perf_mmap__munmap(&evlist->backward_mmap[i]);
+			perf_mmap__munmap(&evlist->overwrite_mmap[i]);
 }
 
 void perf_evlist__munmap(struct perf_evlist *evlist)
 {
 	perf_evlist__munmap_nofree(evlist);
 	zfree(&evlist->mmap);
-	zfree(&evlist->backward_mmap);
+	zfree(&evlist->overwrite_mmap);
 }
 
 static struct perf_mmap *perf_evlist__alloc_mmap(struct perf_evlist *evlist)
@@ -800,7 +800,7 @@ perf_evlist__should_poll(struct perf_evlist *evlist __maybe_unused,
 
 static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 				       struct mmap_params *mp, int cpu_idx,
-				       int thread, int *_output, int *_output_backward)
+				       int thread, int *_output, int *_output_overwrite)
 {
 	struct perf_evsel *evsel;
 	int revent;
@@ -814,14 +814,14 @@ static int perf_evlist__mmap_per_evsel(struct perf_evlist *evlist, int idx,
 
 		mp->prot = PROT_READ | PROT_WRITE;
 		if (evsel->attr.write_backward) {
-			output = _output_backward;
-			maps = evlist->backward_mmap;
+			output = _output_overwrite;
+			maps = evlist->overwrite_mmap;
 
 			if (!maps) {
 				maps = perf_evlist__alloc_mmap(evlist);
 				if (!maps)
 					return -1;
-				evlist->backward_mmap = maps;
+				evlist->overwrite_mmap = maps;
 				if (evlist->bkw_mmap_state == BKW_MMAP_NOTREADY)
 					perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
 			}
@@ -886,14 +886,14 @@ static int perf_evlist__mmap_per_cpu(struct perf_evlist *evlist,
 	pr_debug2("perf event ring buffer mmapped per cpu\n");
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		int output = -1;
-		int output_backward = -1;
+		int output_overwrite = -1;
 
 		auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, cpu,
 					      true);
 
 		for (thread = 0; thread < nr_threads; thread++) {
 			if (perf_evlist__mmap_per_evsel(evlist, cpu, mp, cpu,
-							thread, &output, &output_backward))
+							thread, &output, &output_overwrite))
 				goto out_unmap;
 		}
 	}
@@ -914,13 +914,13 @@ static int perf_evlist__mmap_per_thread(struct perf_evlist *evlist,
 	pr_debug2("perf event ring buffer mmapped per thread\n");
 	for (thread = 0; thread < nr_threads; thread++) {
 		int output = -1;
-		int output_backward = -1;
+		int output_overwrite = -1;
 
 		auxtrace_mmap_params__set_idx(&mp->auxtrace_mp, evlist, thread,
 					      false);
 
 		if (perf_evlist__mmap_per_evsel(evlist, thread, mp, 0, thread,
-						&output, &output_backward))
+						&output, &output_overwrite))
 			goto out_unmap;
 	}
 
@@ -1753,7 +1753,7 @@ void perf_evlist__toggle_bkw_mmap(struct perf_evlist *evlist,
 		RESUME,
 	} action = NONE;
 
-	if (!evlist->backward_mmap)
+	if (!evlist->overwrite_mmap)
 		return;
 
 	switch (old_state) {
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index eec33770b8e6..75160666d305 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -44,7 +44,7 @@ struct perf_evlist {
 	} workload;
 	struct fdarray	 pollfd;
 	struct perf_mmap *mmap;
-	struct perf_mmap *backward_mmap;
+	struct perf_mmap *overwrite_mmap;
 	struct thread_map *threads;
 	struct cpu_map	  *cpus;
 	struct perf_evsel *selected;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5f8cb1583e53..05076e683938 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -234,18 +234,18 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 	return 0;
 }
 
-static int backward_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
+static int overwrite_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64 *end)
 {
 	struct perf_event_header *pheader;
 	u64 evt_head = head;
 	int size = mask + 1;
 
-	pr_debug2("backward_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
+	pr_debug2("overwrite_rb_find_range: buf=%p, head=%"PRIx64"\n", buf, head);
 	pheader = (struct perf_event_header *)(buf + (head & mask));
 	*start = head;
 	while (true) {
 		if (evt_head - head >= (unsigned int)size) {
-			pr_debug("Finished reading backward ring buffer: rewind\n");
+			pr_debug("Finished reading overwrite ring buffer: rewind\n");
 			if (evt_head - head > (unsigned int)size)
 				evt_head -= pheader->size;
 			*end = evt_head;
@@ -255,7 +255,7 @@ static int backward_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64
 		pheader = (struct perf_event_header *)(buf + (evt_head & mask));
 
 		if (pheader->size == 0) {
-			pr_debug("Finished reading backward ring buffer: get start\n");
+			pr_debug("Finished reading overwrite ring buffer: get start\n");
 			*end = evt_head;
 			return 0;
 		}
@@ -267,7 +267,7 @@ static int backward_rb_find_range(void *buf, int mask, u64 head, u64 *start, u64
 	return -1;
 }
 
-int perf_mmap__push(struct perf_mmap *md, bool backward,
+int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 		    void *to, int push(void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
@@ -278,19 +278,19 @@ int perf_mmap__push(struct perf_mmap *md, bool backward,
 	void *buf;
 	int rc = 0;
 
-	start = backward ? head : old;
-	end = backward ? old : head;
+	start = overwrite ? head : old;
+	end = overwrite ? old : head;
 
 	if (start == end)
 		return 0;
 
 	size = end - start;
 	if (size > (unsigned long)(md->mask) + 1) {
-		if (!backward) {
+		if (!overwrite) {
 			WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 			md->prev = head;
-			perf_mmap__consume(md, backward);
+			perf_mmap__consume(md, overwrite);
 			return 0;
 		}
 
@@ -298,7 +298,7 @@ int perf_mmap__push(struct perf_mmap *md, bool backward,
 		 * Backward ring buffer is full. We still have a chance to read
 		 * most of data from it.
 		 */
-		if (backward_rb_find_range(data, md->mask, head, &start, &end))
+		if (overwrite_rb_find_range(data, md->mask, head, &start, &end))
 			return -1;
 	}
 
@@ -323,7 +323,7 @@ int perf_mmap__push(struct perf_mmap *md, bool backward,
 	}
 
 	md->prev = head;
-	perf_mmap__consume(md, backward);
+	perf_mmap__consume(md, overwrite);
 out:
 	return rc;
 }
-- 
2.13.6
