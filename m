From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 28/36] perf mmap: Remove overwrite from arguments list of perf_mmap__push
Date: Wed,  6 Dec 2017 11:41:07 -0300
Message-ID: <20171206144115.15097-29-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

'overwrite' argument is always 'false'. Remove it from arguments list of
perf_mmap__push().

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: http://lkml.kernel.org/r/20171203020044.81680-5-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/util/mmap.c      | 6 +++---
 tools/perf/util/mmap.h      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 3bc6ceeae1f9..26b8571d0fdb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -500,7 +500,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], false, backward, rec, record__pushfn) != 0) {
+			if (perf_mmap__push(&maps[i], backward, rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 9fe5f9c7d577..703ed41a9269 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -299,7 +299,7 @@ static int rb_find_range(void *data, int mask, u64 head, u64 old,
 	return backward_rb_find_range(data, mask, head, start, end);
 }
 
-int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
+int perf_mmap__push(struct perf_mmap *md, bool backward,
 		    void *to, int push(void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
@@ -321,7 +321,7 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
 		WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
 
 		md->prev = head;
-		perf_mmap__consume(md, overwrite || backward);
+		perf_mmap__consume(md, backward);
 		return 0;
 	}
 
@@ -346,7 +346,7 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
 	}
 
 	md->prev = head;
-	perf_mmap__consume(md, overwrite || backward);
+	perf_mmap__consume(md, backward);
 out:
 	return rc;
 }
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index efd78b827b05..2c3d291785de 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -89,7 +89,7 @@ static inline void perf_mmap__write_tail(struct perf_mmap *md, u64 tail)
 union perf_event *perf_mmap__read_forward(struct perf_mmap *map, bool check_messup);
 union perf_event *perf_mmap__read_backward(struct perf_mmap *map);
 
-int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
+int perf_mmap__push(struct perf_mmap *md, bool backward,
 		    void *to, int push(void *to, void *buf, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
-- 
2.13.6
