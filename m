From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/66] libperf: Move 'mmap_len' from 'struct evlist' to 'struct perf_evlist'
Date: Wed, 25 Sep 2019 21:32:12 -0300
Message-ID: <20190926003244.13962-35-acme@kernel.org>
References: <20190926003244.13962-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926003244.13962-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Moving 'mmap_len' from 'struct evlist' to 'struct perf_evlist' it will
be used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/lib/include/internal/evlist.h |  1 +
 tools/perf/util/evlist.c                 | 10 +++++-----
 tools/perf/util/evlist.h                 |  1 -
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8577bf33a556..94997144547d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1412,7 +1412,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		err = -1;
 		goto out_child;
 	}
-	session->header.env.comp_mmap_len = session->evlist->mmap_len;
+	session->header.env.comp_mmap_len = session->evlist->core.mmap_len;
 
 	err = bpf__apply_obj_config();
 	if (err) {
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 035c1e1cc324..01b813616440 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -14,6 +14,7 @@ struct perf_evlist {
 	struct perf_cpu_map	*cpus;
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
+	size_t			 mmap_len;
 };
 
 /**
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index d147834fbe60..4d8cde099e10 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1012,11 +1012,11 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
-	evlist->mmap_len = evlist__mmap_size(pages);
-	pr_debug("mmap size %zuB\n", evlist->mmap_len);
-	mp.mask = evlist->mmap_len - page_size - 1;
+	evlist->core.mmap_len = evlist__mmap_size(pages);
+	pr_debug("mmap size %zuB\n", evlist->core.mmap_len);
+	mp.mask = evlist->core.mmap_len - page_size - 1;
 
-	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->mmap_len,
+	auxtrace_mmap_params__init(&mp.auxtrace_mp, evlist->core.mmap_len,
 				   auxtrace_pages, auxtrace_overwrite);
 
 	evlist__for_each_entry(evlist, evsel) {
@@ -1600,7 +1600,7 @@ int perf_evlist__strerror_open(struct evlist *evlist,
 int perf_evlist__strerror_mmap(struct evlist *evlist, int err, char *buf, size_t size)
 {
 	char sbuf[STRERR_BUFSIZE], *emsg = str_error_r(err, sbuf, sizeof(sbuf));
-	int pages_attempted = evlist->mmap_len / 1024, pages_max_per_user, printed = 0;
+	int pages_attempted = evlist->core.mmap_len / 1024, pages_max_per_user, printed = 0;
 
 	switch (err) {
 	case EPERM:
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 816b72a2b1e5..765cee8bced1 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -56,7 +56,6 @@ struct evlist {
 	struct hlist_head heads[PERF_EVLIST__HLIST_SIZE];
 	int		 nr_groups;
 	bool		 enabled;
-	size_t		 mmap_len;
 	int		 id_pos;
 	int		 is_pos;
 	u64		 combined_sample_type;
-- 
2.21.0
