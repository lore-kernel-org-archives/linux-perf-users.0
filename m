From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/28] perf test: Switch to new perf_mmap__read_event() interface for perf-record
Date: Mon,  5 Mar 2018 11:29:27 -0300
Message-ID: <20180305142932.16921-24-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The perf test 'perf-record' still use the legacy interface.

No functional change.

Committer notes:

Testing it:

  # perf test PERF_RECORD
   8: PERF_RECORD_* events & perf_sample fields             : Ok
  #

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1519945751-37786-9-git-send-email-kan.liang@linux.intel.com
[ Changed bool parameters from 0 to 'false', as per Jiri comment ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/perf-record.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 0afafab85238..31f3f70adca6 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -164,8 +164,14 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 
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
 				const char *name = perf_event__name(type);
 
@@ -266,8 +272,9 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 					++errs;
 				}
 
-				perf_evlist__mmap_consume(evlist, i);
+				perf_mmap__consume(md, false);
 			}
+			perf_mmap__read_done(md);
 		}
 
 		/*
-- 
2.14.3
