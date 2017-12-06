From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 26/36] perf evlist: Remove 'overwrite' parameter from perf_evlist__mmap_ex
Date: Wed,  6 Dec 2017 11:41:05 -0300
Message-ID: <20171206144115.15097-27-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

All users of perf_evlist__mmap_ex set !overwrite. Remove it from its
arguments list.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: http://lkml.kernel.org/r/20171203020044.81680-3-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 tools/perf/util/evlist.c    | 8 ++++----
 tools/perf/util/evlist.h    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e304bc47fe9b..08070f87d489 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -301,7 +301,7 @@ static int record__mmap_evlist(struct record *rec,
 	struct record_opts *opts = &rec->opts;
 	char msg[512];
 
-	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages, false,
+	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
 				 opts->auxtrace_snapshot_mode) < 0) {
 		if (errno == EPERM) {
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 3c1778b500e0..93272d932407 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1052,14 +1052,14 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  * Return: %0 on success, negative error code otherwise.
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
-			 bool overwrite, unsigned int auxtrace_pages,
+			 unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
 	const struct thread_map *threads = evlist->threads;
 	struct mmap_params mp = {
-		.prot = PROT_READ | (overwrite ? 0 : PROT_WRITE),
+		.prot = PROT_READ | PROT_WRITE,
 	};
 
 	if (!evlist->mmap)
@@ -1070,7 +1070,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	evlist->overwrite = overwrite;
+	evlist->overwrite = false;
 	evlist->mmap_len = perf_evlist__mmap_size(pages);
 	pr_debug("mmap size %zuB\n", evlist->mmap_len);
 	mp.mask = evlist->mmap_len - page_size - 1;
@@ -1093,7 +1093,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, false, 0, false);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index f0f2c8b2504b..424a3d6015af 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -169,7 +169,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt,
 unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
-			 bool overwrite, unsigned int auxtrace_pages,
+			 unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
-- 
2.13.6
