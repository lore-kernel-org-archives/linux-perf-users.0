From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/66] libperf: Move 'pollfd' from 'struct evlist' to 'struct perf_evlist'
Date: Wed, 25 Sep 2019 21:32:13 -0300
Message-ID: <20190926003244.13962-36-acme@kernel.org>
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

Moving 'pollfd' from 'struct evlist' to 'struct perf_evlist' it will be
used in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-23-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c                 |  2 +-
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 | 18 +++++++++---------
 tools/perf/util/evlist.h                 |  1 -
 tools/perf/util/python.c                 |  6 +++---
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index e2b42efc86fa..710a2898ed6c 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -981,7 +981,7 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 	evlist__enable(kvm->evlist);
 
 	while (!done) {
-		struct fdarray *fda = &kvm->evlist->pollfd;
+		struct fdarray *fda = &kvm->evlist->core.pollfd;
 		int rc;
 
 		rc = perf_kvm__mmap_read(kvm);
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 01b813616440..8a4eb66fbf3a 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_INTERNAL_EVLIST_H
 
 #include <linux/list.h>
+#include <api/fd/array.h>
 
 struct perf_cpu_map;
 struct perf_thread_map;
@@ -15,6 +16,7 @@ struct perf_evlist {
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
 	size_t			 mmap_len;
+	struct fdarray		 pollfd;
 };
 
 /**
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 4d8cde099e10..13595e8e6b4b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -61,7 +61,7 @@ void evlist__init(struct evlist *evlist, struct perf_cpu_map *cpus,
 		INIT_HLIST_HEAD(&evlist->heads[i]);
 	perf_evlist__init(&evlist->core);
 	perf_evlist__set_maps(&evlist->core, cpus, threads);
-	fdarray__init(&evlist->pollfd, 64);
+	fdarray__init(&evlist->core.pollfd, 64);
 	evlist->workload.pid = -1;
 	evlist->bkw_mmap_state = BKW_MMAP_NOTREADY;
 }
@@ -142,7 +142,7 @@ void evlist__exit(struct evlist *evlist)
 {
 	zfree(&evlist->mmap);
 	zfree(&evlist->overwrite_mmap);
-	fdarray__exit(&evlist->pollfd);
+	fdarray__exit(&evlist->core.pollfd);
 }
 
 void evlist__delete(struct evlist *evlist)
@@ -416,8 +416,8 @@ int perf_evlist__alloc_pollfd(struct evlist *evlist)
 			nfds += nr_cpus * nr_threads;
 	}
 
-	if (fdarray__available_entries(&evlist->pollfd) < nfds &&
-	    fdarray__grow(&evlist->pollfd, nfds) < 0)
+	if (fdarray__available_entries(&evlist->core.pollfd) < nfds &&
+	    fdarray__grow(&evlist->core.pollfd, nfds) < 0)
 		return -ENOMEM;
 
 	return 0;
@@ -426,13 +426,13 @@ int perf_evlist__alloc_pollfd(struct evlist *evlist)
 static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
 				     struct mmap *map, short revent)
 {
-	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+	int pos = fdarray__add(&evlist->core.pollfd, fd, revent | POLLERR | POLLHUP);
 	/*
 	 * Save the idx so that when we filter out fds POLLHUP'ed we can
 	 * close the associated evlist->mmap[] entry.
 	 */
 	if (pos >= 0) {
-		evlist->pollfd.priv[pos].ptr = map;
+		evlist->core.pollfd.priv[pos].ptr = map;
 
 		fcntl(fd, F_SETFL, O_NONBLOCK);
 	}
@@ -456,13 +456,13 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 
 int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 {
-	return fdarray__filter(&evlist->pollfd, revents_and_mask,
+	return fdarray__filter(&evlist->core.pollfd, revents_and_mask,
 			       perf_evlist__munmap_filtered, NULL);
 }
 
 int perf_evlist__poll(struct evlist *evlist, int timeout)
 {
-	return fdarray__poll(&evlist->pollfd, timeout);
+	return fdarray__poll(&evlist->core.pollfd, timeout);
 }
 
 static void perf_evlist__id_hash(struct evlist *evlist,
@@ -1009,7 +1009,7 @@ int evlist__mmap_ex(struct evlist *evlist, unsigned int pages,
 	if (!evlist->mmap)
 		return -ENOMEM;
 
-	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
+	if (evlist->core.pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
 	evlist->core.mmap_len = evlist__mmap_size(pages);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 765cee8bced1..4fcdf93eb19c 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -64,7 +64,6 @@ struct evlist {
 		int	cork_fd;
 		pid_t	pid;
 	} workload;
-	struct fdarray	 pollfd;
 	struct mmap *mmap;
 	struct mmap *overwrite_mmap;
 	struct evsel *selected;
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 62144b97e17b..fcbafb1e8d9d 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -935,17 +935,17 @@ static PyObject *pyrf_evlist__get_pollfd(struct pyrf_evlist *pevlist,
         PyObject *list = PyList_New(0);
 	int i;
 
-	for (i = 0; i < evlist->pollfd.nr; ++i) {
+	for (i = 0; i < evlist->core.pollfd.nr; ++i) {
 		PyObject *file;
 #if PY_MAJOR_VERSION < 3
-		FILE *fp = fdopen(evlist->pollfd.entries[i].fd, "r");
+		FILE *fp = fdopen(evlist->core.pollfd.entries[i].fd, "r");
 
 		if (fp == NULL)
 			goto free_list;
 
 		file = PyFile_FromFile(fp, "perf", "r", NULL);
 #else
-		file = PyFile_FromFd(evlist->pollfd.entries[i].fd, "perf", "r", -1,
+		file = PyFile_FromFd(evlist->core.pollfd.entries[i].fd, "perf", "r", -1,
 				     NULL, NULL, NULL, 0);
 #endif
 		if (file == NULL)
-- 
2.21.0
