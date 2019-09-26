From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 53/66] libperf: Add perf_evlist__add_pollfd() function
Date: Wed, 25 Sep 2019 21:32:31 -0300
Message-ID: <20190926003244.13962-54-acme@kernel.org>
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

Move perf_evlist__add_pollfd() from tools/perf to libperf, it will be
used in the following patches.

Also rename perf's perf_evlist__add_pollfd()/perf_evlist__filter_pollfd()
to evlist__add_pollfd()/evlist__filter_pollfd().

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lore.kernel.org/lkml/20190913132355.21634-38-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-kvm.c                 |  4 ++--
 tools/perf/builtin-record.c              |  2 +-
 tools/perf/builtin-trace.c               |  2 +-
 tools/perf/lib/evlist.c                  | 16 +++++++++++++++
 tools/perf/lib/include/internal/evlist.h |  2 ++
 tools/perf/util/evlist.c                 | 25 ++++--------------------
 tools/perf/util/evlist.h                 |  4 ++--
 7 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 710a2898ed6c..2227e2f42c09 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -967,10 +967,10 @@ static int kvm_events_live_report(struct perf_kvm_stat *kvm)
 		goto out;
 	}
 
-	if (perf_evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
+	if (evlist__add_pollfd(kvm->evlist, kvm->timerfd) < 0)
 		goto out;
 
-	nr_stdin = perf_evlist__add_pollfd(kvm->evlist, fileno(stdin));
+	nr_stdin = evlist__add_pollfd(kvm->evlist, fileno(stdin));
 	if (nr_stdin < 0)
 		goto out;
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 48600c90cc7e..d6daaad348b5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1624,7 +1624,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				err = 0;
 			waking++;
 
-			if (perf_evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
+			if (evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
 				draining = true;
 		}
 
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 97667287f573..8d9784b5d028 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3475,7 +3475,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		int timeout = done ? 100 : -1;
 
 		if (!draining && perf_evlist__poll(evlist, timeout) > 0) {
-			if (perf_evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
+			if (evlist__filter_pollfd(evlist, POLLERR | POLLHUP | POLLNVAL) == 0)
 				draining = true;
 
 			goto again;
diff --git a/tools/perf/lib/evlist.c b/tools/perf/lib/evlist.c
index 3c3b97f40be0..e4d8b3b7b8fc 100644
--- a/tools/perf/lib/evlist.c
+++ b/tools/perf/lib/evlist.c
@@ -12,6 +12,9 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <poll.h>
 #include <perf/cpumap.h>
 #include <perf/threadmap.h>
 #include <api/fd/array.h>
@@ -260,3 +263,16 @@ int perf_evlist__alloc_pollfd(struct perf_evlist *evlist)
 
 	return 0;
 }
+
+int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
+			    void *ptr, short revent)
+{
+	int pos = fdarray__add(&evlist->pollfd, fd, revent | POLLERR | POLLHUP);
+
+	if (pos >= 0) {
+		evlist->pollfd.priv[pos].ptr = ptr;
+		fcntl(fd, F_SETFL, O_NONBLOCK);
+	}
+
+	return pos;
+}
diff --git a/tools/perf/lib/include/internal/evlist.h b/tools/perf/lib/include/internal/evlist.h
index 88c0dfaf0ddc..9f440ab12b76 100644
--- a/tools/perf/lib/include/internal/evlist.h
+++ b/tools/perf/lib/include/internal/evlist.h
@@ -25,6 +25,8 @@ struct perf_evlist {
 };
 
 int perf_evlist__alloc_pollfd(struct perf_evlist *evlist);
+int perf_evlist__add_pollfd(struct perf_evlist *evlist, int fd,
+			    void *ptr, short revent);
 
 /**
  * __perf_evlist__for_each_entry - iterate thru all the evsels
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index c47f23e7f3c8..051be9a31db9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -398,26 +398,9 @@ int perf_evlist__enable_event_idx(struct evlist *evlist,
 		return perf_evlist__enable_event_thread(evlist, evsel, idx);
 }
 
-static int __perf_evlist__add_pollfd(struct evlist *evlist, int fd,
-				     struct mmap *map, short revent)
+int evlist__add_pollfd(struct evlist *evlist, int fd)
 {
-	int pos = fdarray__add(&evlist->core.pollfd, fd, revent | POLLERR | POLLHUP);
-	/*
-	 * Save the idx so that when we filter out fds POLLHUP'ed we can
-	 * close the associated evlist->mmap[] entry.
-	 */
-	if (pos >= 0) {
-		evlist->core.pollfd.priv[pos].ptr = map;
-
-		fcntl(fd, F_SETFL, O_NONBLOCK);
-	}
-
-	return pos;
-}
-
-int perf_evlist__add_pollfd(struct evlist *evlist, int fd)
-{
-	return __perf_evlist__add_pollfd(evlist, fd, NULL, POLLIN);
+	return perf_evlist__add_pollfd(&evlist->core, fd, NULL, POLLIN);
 }
 
 static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
@@ -429,7 +412,7 @@ static void perf_evlist__munmap_filtered(struct fdarray *fda, int fd,
 		perf_mmap__put(map);
 }
 
-int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
+int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask)
 {
 	return fdarray__filter(&evlist->core.pollfd, revents_and_mask,
 			       perf_evlist__munmap_filtered, NULL);
@@ -708,7 +691,7 @@ static int evlist__mmap_per_evsel(struct evlist *evlist, int idx,
 		 * Therefore don't add it for polling.
 		 */
 		if (!evsel->core.system_wide &&
-		    __perf_evlist__add_pollfd(evlist, fd, &maps[idx], revent) < 0) {
+		     perf_evlist__add_pollfd(&evlist->core, fd, &maps[idx], revent) < 0) {
 			perf_mmap__put(&maps[idx]);
 			return -1;
 		}
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index bebbaa9b6325..2eac8aab24a3 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -141,8 +141,8 @@ struct evsel *
 perf_evlist__find_tracepoint_by_name(struct evlist *evlist,
 				     const char *name);
 
-int perf_evlist__add_pollfd(struct evlist *evlist, int fd);
-int perf_evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
+int evlist__add_pollfd(struct evlist *evlist, int fd);
+int evlist__filter_pollfd(struct evlist *evlist, short revents_and_mask);
 
 int perf_evlist__poll(struct evlist *evlist, int timeout);
 
-- 
2.21.0
