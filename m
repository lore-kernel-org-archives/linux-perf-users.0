From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 15/44] perf build-id: Fix memory leak in print_sdt_events()
Date: Thu, 21 Mar 2019 15:51:13 -0300
Message-ID: <20190321185142.11441-16-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Detected with gcc's ASan:

  Direct leak of 4356 byte(s) in 120 object(s) allocated from:
      #0 0x7ff1a2b5a070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x55719aef4814 in build_id_cache__origname util/build-id.c:215
      #2 0x55719af649b6 in print_sdt_events util/parse-events.c:2339
      #3 0x55719af66272 in print_events util/parse-events.c:2542
      #4 0x55719ad1ecaa in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
      #5 0x55719aec745d in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #6 0x55719aec7d1a in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #7 0x55719aec8184 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #8 0x55719aeca41a in main /home/changbin/work/linux/tools/perf/perf.c:520
      #9 0x7ff1a07ae09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 40218daea1db ("perf list: Show SDT and pre-cached events")
Link: http://lkml.kernel.org/r/20190316080556.3075-7-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/build-id.c     | 1 +
 tools/perf/util/parse-events.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index bff0d17920ed..0c5517a8d0b7 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -185,6 +185,7 @@ char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size)
 	return bf;
 }
 
+/* The caller is responsible to free the returned buffer. */
 char *build_id_cache__origname(const char *sbuild_id)
 {
 	char *linkname;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2e9035c4c252..5ef4939408f2 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2342,6 +2342,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 				printf("  %-50s [%s]\n", buf, "SDT event");
 				free(buf);
 			}
+			free(path);
 		} else
 			printf("  %-50s [%s]\n", nd->s, "SDT event");
 		if (nd2) {
-- 
2.20.1
