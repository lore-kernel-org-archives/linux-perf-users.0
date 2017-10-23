From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/24] perf record: Make record__mmap_read generic
Date: Mon, 23 Oct 2017 20:47:24 -0300
Message-ID: <20171023234736.5335-13-acme@kernel.org>
References: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171023234736.5335-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It becomes a perf_mmap method, "push", that build reads from a mmap and
"pushes" it to a consumer, that in the initial case, for 'perf record',
just writes it to the perf.data file descriptor, but may be used by
'top', etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-u4l1qjbi6l76r2k0nv99220n@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 234fdf4734f6..47a761133aed 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -176,9 +176,16 @@ rb_find_range(void *data, int mask, u64 head, u64 old,
 	return backward_rb_find_range(data, mask, head, start, end);
 }
 
-static int
-record__mmap_read(struct record *rec, struct perf_mmap *md,
-		  bool overwrite, bool backward)
+static int record__pushfn(void *to, void *bf, size_t size)
+{
+	struct record *rec = to;
+
+	rec->samples++;
+	return record__write(rec, bf, size);
+}
+
+static int perf_mmap__push(struct perf_mmap *md, bool overwrite, bool backward,
+			   void *to, int push(void *to, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
@@ -195,8 +202,6 @@ record__mmap_read(struct record *rec, struct perf_mmap *md,
 	if (start == end)
 		return 0;
 
-	rec->samples++;
-
 	size = end - start;
 	if (size > (unsigned long)(md->mask) + 1) {
 		WARN_ONCE(1, "failed to keep up with mmap data. (warn only once)\n");
@@ -211,7 +216,7 @@ record__mmap_read(struct record *rec, struct perf_mmap *md,
 		size = md->mask + 1 - (start & md->mask);
 		start += size;
 
-		if (record__write(rec, buf, size) < 0) {
+		if (push(to, buf, size) < 0) {
 			rc = -1;
 			goto out;
 		}
@@ -221,7 +226,7 @@ record__mmap_read(struct record *rec, struct perf_mmap *md,
 	size = end - start;
 	start += size;
 
-	if (record__write(rec, buf, size) < 0) {
+	if (push(to, buf, size) < 0) {
 		rc = -1;
 		goto out;
 	}
@@ -576,8 +581,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (record__mmap_read(rec, &maps[i],
-					      evlist->overwrite, backward) != 0) {
+			if (perf_mmap__push(&maps[i], evlist->overwrite, backward, rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
-- 
2.13.6
