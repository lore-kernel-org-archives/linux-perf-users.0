From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/15] perf evsel: Fix buffer overflow while freeing events
Date: Wed, 23 Aug 2017 16:36:01 -0300
Message-ID: <20170823193614.20394-3-acme@kernel.org>
References: <20170823193614.20394-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170823193614.20394-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Fix buffer overflow for:

  % perf stat -e msr/tsc/,cstate_core/c7-residency/ true

that causes glibc free list corruption. For some reason it doesn't
trigger in valgrind, but it is visible in AS:

  =================================================================
  ==32681==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x603000003f5c at pc 0x0000005671ef bp 0x7ffdaaac9ac0 sp 0x7ffdaaac9ab0
  READ of size 4 at 0x603000003f5c thread T0
    #0 0x5671ee in perf_evsel__close_fd util/evsel.c:1196
    #1 0x56c57a in perf_evsel__close util/evsel.c:1717
    #2 0x55ed5f in perf_evlist__close util/evlist.c:1631
    #3 0x4647e1 in __run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:749
    #4 0x4648e3 in run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:767
    #5 0x46e1bc in cmd_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:2785
    #6 0x52f83d in run_builtin /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:296
    #7 0x52fd49 in handle_internal_command /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:348
    #8 0x5300de in run_argv /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:392
    #9 0x5308f3 in main /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:530
    #10 0x7f0672d13400 in __libc_start_main (/lib64/libc.so.6+0x20400)
    #11 0x428419 in _start (/home/ak/hle/obj-perf/perf+0x428419)

  0x603000003f5c is located 0 bytes to the right of 28-byte region [0x603000003f40,0x603000003f5c)
  allocated by thread T0 here:
    #0 0x7f0675139020 in calloc (/lib64/libasan.so.3+0xc7020)
    #1 0x648a2d in zalloc util/util.h:23
    #2 0x648a88 in xyarray__new util/xyarray.c:9
    #3 0x566419 in perf_evsel__alloc_fd util/evsel.c:1039
    #4 0x56b427 in perf_evsel__open util/evsel.c:1529
    #5 0x56c620 in perf_evsel__open_per_thread util/evsel.c:1730
    #6 0x461dea in create_perf_stat_counter /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:263
    #7 0x4637d7 in __run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:600
    #8 0x4648e3 in run_perf_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:767
    #9 0x46e1bc in cmd_stat /home/ak/hle/linux-hle-2.6/tools/perf/builtin-stat.c:2785
    #10 0x52f83d in run_builtin /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:296
    #11 0x52fd49 in handle_internal_command /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:348
    #12 0x5300de in run_argv /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:392
    #13 0x5308f3 in main /home/ak/hle/linux-hle-2.6/tools/perf/perf.c:530
    #14 0x7f0672d13400 in __libc_start_main (/lib64/libc.so.6+0x20400)

The event is allocated with cpus == 1, but freed with cpus == real number
When the evsel close function walks the file descriptors it exceeds the
fd xyarray boundaries and reads random memory.

v2:

Now that xyarrays save their original dimensions we can use these to
iterate the two dimensional fd arrays. Fix some users (close, ioctl) in
evsel.c to use these fields directly. This allows simplifying the code
and dropping quite a few function arguments. Adjust all callers by
removing the unneeded arguments.

The actual perf event reading still uses the original values from the
evsel list.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170811232634.30465-2-andi@firstfloor.org
[ Fix up xy_max_[xy]() -> xyarray__max_[xy]() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c |  2 +-
 tools/perf/tests/openat-syscall.c          |  2 +-
 tools/perf/util/evlist.c                   | 12 +++-------
 tools/perf/util/evsel.c                    | 37 ++++++++++--------------------
 tools/perf/util/evsel.h                    |  7 +++---
 5 files changed, 20 insertions(+), 40 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 87265117fd7f..9cf1c35f2ad0 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -115,7 +115,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 
 	perf_evsel__free_counts(evsel);
 out_close_fd:
-	perf_evsel__close_fd(evsel, 1, threads->nr);
+	perf_evsel__close_fd(evsel);
 out_evsel_delete:
 	perf_evsel__delete(evsel);
 out_thread_map_delete:
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index 85bb6729d303..9dc5c5d37553 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -56,7 +56,7 @@ int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __m
 
 	err = 0;
 out_close_fd:
-	perf_evsel__close_fd(evsel, 1, threads->nr);
+	perf_evsel__close_fd(evsel);
 out_evsel_delete:
 	perf_evsel__delete(evsel);
 out_thread_map_delete:
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 078b58511595..6a0d7ffbeba0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1419,8 +1419,6 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
 {
 	struct perf_evsel *evsel;
 	int err = 0;
-	const int ncpus = cpu_map__nr(evlist->cpus),
-		  nthreads = thread_map__nr(evlist->threads);
 
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->filter == NULL)
@@ -1430,7 +1428,7 @@ int perf_evlist__apply_filters(struct perf_evlist *evlist, struct perf_evsel **e
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
 		 */
-		err = perf_evsel__apply_filter(evsel, ncpus, nthreads, evsel->filter);
+		err = perf_evsel__apply_filter(evsel, evsel->filter);
 		if (err) {
 			*err_evsel = evsel;
 			break;
@@ -1623,13 +1621,9 @@ void perf_evlist__set_selected(struct perf_evlist *evlist,
 void perf_evlist__close(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
-	int ncpus = cpu_map__nr(evlist->cpus);
-	int nthreads = thread_map__nr(evlist->threads);
 
-	evlist__for_each_entry_reverse(evlist, evsel) {
-		int n = evsel->cpus ? evsel->cpus->nr : ncpus;
-		perf_evsel__close(evsel, n, nthreads);
-	}
+	evlist__for_each_entry_reverse(evlist, evsel)
+		perf_evsel__close(evsel);
 }
 
 static int perf_evlist__create_syswide_maps(struct perf_evlist *evlist)
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3735c9e0080d..5dfb8bc4db89 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1051,16 +1051,13 @@ static int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthread
 	return evsel->fd != NULL ? 0 : -ENOMEM;
 }
 
-static int perf_evsel__run_ioctl(struct perf_evsel *evsel, int ncpus, int nthreads,
+static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
 			  int ioc,  void *arg)
 {
 	int cpu, thread;
 
-	if (evsel->system_wide)
-		nthreads = 1;
-
-	for (cpu = 0; cpu < ncpus; cpu++) {
-		for (thread = 0; thread < nthreads; thread++) {
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int fd = FD(evsel, cpu, thread),
 			    err = ioctl(fd, ioc, arg);
 
@@ -1072,10 +1069,9 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel, int ncpus, int nthrea
 	return 0;
 }
 
-int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
-			     const char *filter)
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter)
 {
-	return perf_evsel__run_ioctl(evsel, ncpus, nthreads,
+	return perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
 				     (void *)filter);
 }
@@ -1122,20 +1118,14 @@ int perf_evsel__append_addr_filter(struct perf_evsel *evsel, const char *filter)
 
 int perf_evsel__enable(struct perf_evsel *evsel)
 {
-	int nthreads = thread_map__nr(evsel->threads);
-	int ncpus = cpu_map__nr(evsel->cpus);
-
-	return perf_evsel__run_ioctl(evsel, ncpus, nthreads,
+	return perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_ENABLE,
 				     0);
 }
 
 int perf_evsel__disable(struct perf_evsel *evsel)
 {
-	int nthreads = thread_map__nr(evsel->threads);
-	int ncpus = cpu_map__nr(evsel->cpus);
-
-	return perf_evsel__run_ioctl(evsel, ncpus, nthreads,
+	return perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_DISABLE,
 				     0);
 }
@@ -1185,15 +1175,12 @@ static void perf_evsel__free_config_terms(struct perf_evsel *evsel)
 	}
 }
 
-void perf_evsel__close_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
+void perf_evsel__close_fd(struct perf_evsel *evsel)
 {
 	int cpu, thread;
 
-	if (evsel->system_wide)
-		nthreads = 1;
-
-	for (cpu = 0; cpu < ncpus; cpu++)
-		for (thread = 0; thread < nthreads; ++thread) {
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
 			close(FD(evsel, cpu, thread));
 			FD(evsel, cpu, thread) = -1;
 		}
@@ -1854,12 +1841,12 @@ int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 	return err;
 }
 
-void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads)
+void perf_evsel__close(struct perf_evsel *evsel)
 {
 	if (evsel->fd == NULL)
 		return;
 
-	perf_evsel__close_fd(evsel, ncpus, nthreads);
+	perf_evsel__close_fd(evsel);
 	perf_evsel__free_fd(evsel);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index de03c18daaf0..351d3b2d8887 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -226,7 +226,7 @@ const char *perf_evsel__group_name(struct perf_evsel *evsel);
 int perf_evsel__group_desc(struct perf_evsel *evsel, char *buf, size_t size);
 
 int perf_evsel__alloc_id(struct perf_evsel *evsel, int ncpus, int nthreads);
-void perf_evsel__close_fd(struct perf_evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__close_fd(struct perf_evsel *evsel);
 
 void __perf_evsel__set_sample_bit(struct perf_evsel *evsel,
 				  enum perf_event_sample_format bit);
@@ -246,8 +246,7 @@ int perf_evsel__set_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct perf_evsel *evsel,
 				   const char *filter);
-int perf_evsel__apply_filter(struct perf_evsel *evsel, int ncpus, int nthreads,
-			     const char *filter);
+int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filter);
 int perf_evsel__enable(struct perf_evsel *evsel);
 int perf_evsel__disable(struct perf_evsel *evsel);
 
@@ -257,7 +256,7 @@ int perf_evsel__open_per_thread(struct perf_evsel *evsel,
 				struct thread_map *threads);
 int perf_evsel__open(struct perf_evsel *evsel, struct cpu_map *cpus,
 		     struct thread_map *threads);
-void perf_evsel__close(struct perf_evsel *evsel, int ncpus, int nthreads);
+void perf_evsel__close(struct perf_evsel *evsel);
 
 struct perf_sample;
 
-- 
2.13.5
