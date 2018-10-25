From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/37] perf script: Flush output stream after events in verbose mode
Date: Thu, 25 Oct 2018 08:10:08 -0300
Message-ID: <20181025111031.3440-15-acme@kernel.org>
References: <20181025111031.3440-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181025111031.3440-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

When the perf script output is written to a terminal stream, the normal
output of `perf script` would get buffered, but its debug output would
be written directly. This made it quite hard to figure out where a given
debug output is coming from.

We can improve on this by flushing the output buffer after processing an
event. To see the value, compare the following output for a `perf script
-v` run:

Before this patch:
```
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
... lots and lots of verbose debug output
cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)

cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
...
```

After this patch:
```
...
unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
cpp-inlining 24617 90229.122036534:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)

unwind: reg 16, val 7faf7dfdc000
unwind: reg 7, val 7ffc80811e30
unwind: find_proc_info dso /usr/lib/ld-2.28.so
unwind: reg 6, val 0
unwind: _start:ip = 0x7faf7dfdc000 (0x2000)
cpp-inlining 24617 90229.122043974:          1 cycles:uppp:
            7faf7dfdc000 _start+0x0 (/usr/lib/ld-2.28.so)
...
```

This new output format makes it much easier to use perf script output
for debugging purposes, e.g. to investigate broken dwarf unwinding.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181021191424.16183-2-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index bd468b90801b..ca09b7d2adb7 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1737,6 +1737,9 @@ static void process_event(struct perf_script *script,
 
 	if (PRINT_FIELD(METRIC))
 		perf_sample__fprint_metric(script, thread, evsel, sample, fp);
+
+	if (verbose)
+		fflush(fp);
 }
 
 static struct scripting_ops	*scripting_ops;
-- 
2.14.4
