From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/41] perf record: Put new line after target override warning
Date: Fri, 16 Feb 2018 16:17:06 -0300
Message-ID: <20180216191746.11095-2-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no new-line after target-override warning, now:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

with patch:

  $ perf record -a --per-thread
  Warning:
  SYSTEM/CPU switch overriding PER-THREAD
  ^C[ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.705 MB perf.data (2939 samples) ]

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 16ad2ffb822c ("perf tools: Introduce perf_target__strerror()")
Link: http://lkml.kernel.org/r/20180206181813.10943-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bf4ca749d1ac..907267206973 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1803,7 +1803,7 @@ int cmd_record(int argc, const char **argv)
 	err = target__validate(&rec->opts.target);
 	if (err) {
 		target__strerror(&rec->opts.target, err, errbuf, BUFSIZ);
-		ui__warning("%s", errbuf);
+		ui__warning("%s\n", errbuf);
 	}
 
 	err = target__parse_uid(&rec->opts.target);
-- 
2.14.3
