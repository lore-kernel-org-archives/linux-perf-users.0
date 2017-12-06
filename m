From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/36] perf evlist: Remove 'overwrite' parameter from perf_evlist__mmap
Date: Wed,  6 Dec 2017 11:41:04 -0300
Message-ID: <20171206144115.15097-26-acme@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171206144115.15097-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Wang Nan <wangnan0@huawei.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Wang Nan <wangnan0@huawei.com>

Now all perf_evlist__mmap's users doesn't set 'overwrite'. Remove it
from arguments list.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: http://lkml.kernel.org/r/20171203020044.81680-2-wangnan0@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/perf-time-to-tsc.c | 2 +-
 tools/perf/builtin-kvm.c                     | 2 +-
 tools/perf/builtin-top.c                     | 2 +-
 tools/perf/builtin-trace.c                   | 2 +-
 tools/perf/tests/backward-ring-buffer.c      | 2 +-
 tools/perf/tests/bpf.c                       | 2 +-
 tools/perf/tests/code-reading.c              | 2 +-
 tools/perf/tests/keep-tracking.c             | 2 +-
 tools/perf/tests/mmap-basic.c                | 2 +-
 tools/perf/tests/openat-syscall-tp-fields.c  | 2 +-
 tools/perf/tests/perf-record.c               | 2 +-
 tools/perf/tests/sw-clock.c                  | 2 +-
 tools/perf/tests/switch-tracking.c           | 2 +-
 tools/perf/tests/task-exit.c                 | 2 +-
 tools/perf/util/evlist.c                     | 5 ++---
 tools/perf/util/evlist.h                     | 3 +--
 tools/perf/util/python.c                     | 2 +-
 17 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/x86/tests/perf-time-to-tsc.c b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
index b59678e8c1e2..06abe8108b33 100644
--- a/tools/perf/arch/x86/tests/perf-time-to-tsc.c
+++ b/tools/perf/arch/x86/tests/perf-time-to-tsc.c
@@ -84,7 +84,7 @@ int test__perf_time_to_tsc(struct test *test __maybe_unused, int subtest __maybe
 
 	CHECK__(perf_evlist__open(evlist));
 
-	CHECK__(perf_evlist__mmap(evlist, UINT_MAX, false));
+	CHECK__(perf_evlist__mmap(evlist, UINT_MAX));
 
 	pc = evlist->mmap[0].base;
 	ret = perf_read_tsc_conversion(pc, &tc);
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index 597c7de9bec9..98853162eae9 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -1044,7 +1044,7 @@ static int kvm_live_open_events(struct perf_kvm_stat *kvm)
 		goto out;
 	}
 
-	if (perf_evlist__mmap(evlist, kvm->opts.mmap_pages, false) < 0) {
+	if (perf_evlist__mmap(evlist, kvm->opts.mmap_pages) < 0) {
 		ui__error("Failed to mmap the events: %s\n",
 			  str_error_r(errno, sbuf, sizeof(sbuf)));
 		perf_evlist__close(evlist);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0077724fb24f..540461f5e345 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -907,7 +907,7 @@ static int perf_top__start_counters(struct perf_top *top)
 		}
 	}
 
-	if (perf_evlist__mmap(evlist, opts->mmap_pages, false) < 0) {
+	if (perf_evlist__mmap(evlist, opts->mmap_pages) < 0) {
 		ui__error("Failed to mmap with %d (%s)\n",
 			    errno, str_error_r(errno, msg, sizeof(msg)));
 		goto out_err;
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 84debdbad327..7c57898095ea 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2437,7 +2437,7 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	if (err < 0)
 		goto out_error_apply_filters;
 
-	err = perf_evlist__mmap(evlist, trace->opts.mmap_pages, false);
+	err = perf_evlist__mmap(evlist, trace->opts.mmap_pages);
 	if (err < 0)
 		goto out_error_mmap;
 
diff --git a/tools/perf/tests/backward-ring-buffer.c b/tools/perf/tests/backward-ring-buffer.c
index 43a8c6ac4070..cf37e43c42f3 100644
--- a/tools/perf/tests/backward-ring-buffer.c
+++ b/tools/perf/tests/backward-ring-buffer.c
@@ -59,7 +59,7 @@ static int do_test(struct perf_evlist *evlist, int mmap_pages,
 	int err;
 	char sbuf[STRERR_BUFSIZE];
 
-	err = perf_evlist__mmap(evlist, mmap_pages, false);
+	err = perf_evlist__mmap(evlist, mmap_pages);
 	if (err < 0) {
 		pr_debug("perf_evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
index 34c22cdf4d5d..c433dd30975a 100644
--- a/tools/perf/tests/bpf.c
+++ b/tools/perf/tests/bpf.c
@@ -167,7 +167,7 @@ static int do_test(struct bpf_object *obj, int (*func)(void),
 		goto out_delete_evlist;
 	}
 
-	err = perf_evlist__mmap(evlist, opts.mmap_pages, false);
+	err = perf_evlist__mmap(evlist, opts.mmap_pages);
 	if (err < 0) {
 		pr_debug("perf_evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index fcc8984bc329..3bf7b145b826 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -639,7 +639,7 @@ static int do_test_code_reading(bool try_kcore)
 		break;
 	}
 
-	ret = perf_evlist__mmap(evlist, UINT_MAX, false);
+	ret = perf_evlist__mmap(evlist, UINT_MAX);
 	if (ret < 0) {
 		pr_debug("perf_evlist__mmap failed\n");
 		goto out_put;
diff --git a/tools/perf/tests/keep-tracking.c b/tools/perf/tests/keep-tracking.c
index 842d33637a18..c46530918938 100644
--- a/tools/perf/tests/keep-tracking.c
+++ b/tools/perf/tests/keep-tracking.c
@@ -95,7 +95,7 @@ int test__keep_tracking(struct test *test __maybe_unused, int subtest __maybe_un
 		goto out_err;
 	}
 
-	CHECK__(perf_evlist__mmap(evlist, UINT_MAX, false));
+	CHECK__(perf_evlist__mmap(evlist, UINT_MAX));
 
 	/*
 	 * First, test that a 'comm' event can be found when the event is
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 91f10d6d9ae2..c0e971da965c 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -94,7 +94,7 @@ int test__basic_mmap(struct test *test __maybe_unused, int subtest __maybe_unuse
 		expected_nr_events[i] = 1 + rand() % 127;
 	}
 
-	if (perf_evlist__mmap(evlist, 128, false) < 0) {
+	if (perf_evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index d9619d265314..97c9407d02a0 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -64,7 +64,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 		goto out_delete_evlist;
 	}
 
-	err = perf_evlist__mmap(evlist, UINT_MAX, false);
+	err = perf_evlist__mmap(evlist, UINT_MAX);
 	if (err < 0) {
 		pr_debug("perf_evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index c34904d37705..0afafab85238 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -141,7 +141,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 	 * fds in the same CPU to be injected in the same mmap ring buffer
 	 * (using ioctl(PERF_EVENT_IOC_SET_OUTPUT)).
 	 */
-	err = perf_evlist__mmap(evlist, opts.mmap_pages, false);
+	err = perf_evlist__mmap(evlist, opts.mmap_pages);
 	if (err < 0) {
 		pr_debug("perf_evlist__mmap: %s\n",
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/sw-clock.c b/tools/perf/tests/sw-clock.c
index c6937ed12e6b..f6c72f915d48 100644
--- a/tools/perf/tests/sw-clock.c
+++ b/tools/perf/tests/sw-clock.c
@@ -78,7 +78,7 @@ static int __test__sw_clock_freq(enum perf_sw_ids clock_id)
 		goto out_delete_evlist;
 	}
 
-	err = perf_evlist__mmap(evlist, 128, false);
+	err = perf_evlist__mmap(evlist, 128);
 	if (err < 0) {
 		pr_debug("failed to mmap event: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
index 7d3f4bf9534f..33e00295a972 100644
--- a/tools/perf/tests/switch-tracking.c
+++ b/tools/perf/tests/switch-tracking.c
@@ -449,7 +449,7 @@ int test__switch_tracking(struct test *test __maybe_unused, int subtest __maybe_
 		goto out;
 	}
 
-	err = perf_evlist__mmap(evlist, UINT_MAX, false);
+	err = perf_evlist__mmap(evlist, UINT_MAX);
 	if (err) {
 		pr_debug("perf_evlist__mmap failed!\n");
 		goto out_err;
diff --git a/tools/perf/tests/task-exit.c b/tools/perf/tests/task-exit.c
index 5d06ac81f7f1..01b62b81751b 100644
--- a/tools/perf/tests/task-exit.c
+++ b/tools/perf/tests/task-exit.c
@@ -101,7 +101,7 @@ int test__task_exit(struct test *test __maybe_unused, int subtest __maybe_unused
 		goto out_delete_evlist;
 	}
 
-	if (perf_evlist__mmap(evlist, 128, false) < 0) {
+	if (perf_evlist__mmap(evlist, 128) < 0) {
 		pr_debug("failed to mmap events: %d (%s)\n", errno,
 			 str_error_r(errno, sbuf, sizeof(sbuf)));
 		goto out_delete_evlist;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 199bb82efbcd..3c1778b500e0 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1091,10 +1091,9 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	return perf_evlist__mmap_per_cpu(evlist, &mp);
 }
 
-int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages,
-		      bool overwrite)
+int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, overwrite, 0, false);
+	return perf_evlist__mmap_ex(evlist, pages, false, 0, false);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 4e8131dacbd7..f0f2c8b2504b 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -171,8 +171,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 bool overwrite, unsigned int auxtrace_pages,
 			 bool auxtrace_overwrite);
-int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages,
-		      bool overwrite);
+int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
 size_t perf_evlist__mmap_size(unsigned long pages);
diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 8e49d9cafcfc..b1e999bd21ef 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -864,7 +864,7 @@ static PyObject *pyrf_evlist__mmap(struct pyrf_evlist *pevlist,
 					 &pages, &overwrite))
 		return NULL;
 
-	if (perf_evlist__mmap(evlist, pages, overwrite) < 0) {
+	if (perf_evlist__mmap(evlist, pages) < 0) {
 		PyErr_SetFromErrno(PyExc_OSError);
 		return NULL;
 	}
-- 
2.13.6
