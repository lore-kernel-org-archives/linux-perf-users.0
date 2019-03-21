From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/44] perf list: Don't forget to drop the reference to the allocated thread_map
Date: Thu, 21 Mar 2019 15:51:09 -0300
Message-ID: <20190321185142.11441-12-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Changbin Du <changbin.du@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

Detected via gcc's ASan:

  Direct leak of 2048 byte(s) in 64 object(s) allocated from:
    6     #0 0x7f606512e370 in __interceptor_realloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee370)
    7     #1 0x556b0f1d7ddd in thread_map__realloc util/thread_map.c:43
    8     #2 0x556b0f1d84c7 in thread_map__new_by_tid util/thread_map.c:85
    9     #3 0x556b0f0e045e in is_event_supported util/parse-events.c:2250
   10     #4 0x556b0f0e1aa1 in print_hwcache_events util/parse-events.c:2382
   11     #5 0x556b0f0e3231 in print_events util/parse-events.c:2514
   12     #6 0x556b0ee0a66e in cmd_list /home/changbin/work/linux/tools/perf/builtin-list.c:58
   13     #7 0x556b0f01e0ae in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
   14     #8 0x556b0f01e859 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
   15     #9 0x556b0f01edc8 in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
   16     #10 0x556b0f01f71f in main /home/changbin/work/linux/tools/perf/perf.c:520
   17     #11 0x7f6062ccf09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 89896051f8da ("perf tools: Do not put a variable sized type not at the end of a struct")
Link: http://lkml.kernel.org/r/20190316080556.3075-3-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 4dcc01b2532c..2e9035c4c252 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2271,6 +2271,7 @@ static bool is_event_supported(u8 type, unsigned config)
 		perf_evsel__delete(evsel);
 	}
 
+	thread_map__put(tmap);
 	return ret;
 }
 
-- 
2.20.1
