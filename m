From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/28] perf test: Switch to new perf_mmap__read_event() interface for tp fields
Date: Mon,  5 Mar 2018 11:29:26 -0300
Message-ID: <20180305142932.16921-23-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'syscalls:sys_enter_openat event fields' still use the
legacy interface.

No functional change.

Committer notes:

Testing it:

  # perf test sys_enter_openat
  15: syscalls:sys_enter_openat event fields                : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-8-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/openat-syscall-tp-fields.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 43519267b93b..620b21023f72 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -86,8 +86,14 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 		for (i = 0; i < evlist->nr_mmaps; i++) {
 			union perf_event *event;
+			struct perf_mmap *md;
+			u64 end, start;
 
-			while ((event = perf_evlist__mmap_read(evlist, i)) != NULL) {
+			md = &evlist->mmap[i];
+			if (perf_mmap__read_init(md, false, &start, &end) < 0)
+				continue;
+
+			while ((event = perf_mmap__read_event(md, false, &start, end)) != NULL) {
 				const u32 type = event->header.type;
 				int tp_flags;
 				struct perf_sample sample;
@@ -95,7 +101,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 				++nr_events;
 
 				if (type != PERF_RECORD_SAMPLE) {
-					perf_evlist__mmap_consume(evlist, i);
+					perf_mmap__consume(md, false);
 					continue;
 				}
 
@@ -115,6 +121,7 @@ int test__syscall_openat_tp_fields(struct test *test __maybe_unused, int subtest
 
 				goto out_ok;
 			}
+			perf_mmap__read_done(md);
 		}
 
 		if (nr_events == before)
-- 
2.14.3
