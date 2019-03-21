From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 22/44] perf evsel: Free evsel->counts in perf_evsel__exit()
Date: Thu, 21 Mar 2019 15:51:20 -0300
Message-ID: <20190321185142.11441-23-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Changbin Du <changbin.du@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Using gcc's ASan, Changbin reports:

  =================================================================
  ==7494==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 48 byte(s) in 1 object(s) allocated from:
      #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
      #1 0x5625e5330a5e in zalloc util/util.h:23
      #2 0x5625e5330a9b in perf_counts__new util/counts.c:10
      #3 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
      #4 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505
      #5 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
      #6 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
      #7 0x5625e51528e6 in run_test tests/builtin-test.c:358
      #8 0x5625e5152baf in test_and_print tests/builtin-test.c:388
      #9 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
      #10 0x5625e515572f in cmd_test tests/builtin-test.c:722
      #11 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #12 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #13 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #14 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #15 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

  Indirect leak of 72 byte(s) in 1 object(s) allocated from:
      #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
      #1 0x5625e532560d in zalloc util/util.h:23
      #2 0x5625e532566b in xyarray__new util/xyarray.c:10
      #3 0x5625e5330aba in perf_counts__new util/counts.c:15
      #4 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
      #5 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505
      #6 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
      #7 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
      #8 0x5625e51528e6 in run_test tests/builtin-test.c:358
      #9 0x5625e5152baf in test_and_print tests/builtin-test.c:388
      #10 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
      #11 0x5625e515572f in cmd_test tests/builtin-test.c:722
      #12 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #13 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #14 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #15 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #16 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

His patch took care of evsel->prev_raw_counts, but the above backtraces
are about evsel->counts, so fix that instead.

Reported-by: Changbin Du <changbin.du@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/n/tip-hd1x13g59f0nuhe4anxhsmfp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 16f02b83b23f..1a2023da5d9c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1292,6 +1292,7 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 {
 	assert(list_empty(&evsel->node));
 	assert(evsel->evlist == NULL);
+	perf_evsel__free_counts(evsel);
 	perf_evsel__free_fd(evsel);
 	perf_evsel__free_id(evsel);
 	perf_evsel__free_config_terms(evsel);
-- 
2.20.1
