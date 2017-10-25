From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/15] perf script: Mark inlined frames and do not print DSO for them
Date: Wed, 25 Oct 2017 13:00:06 -0300
Message-ID: <20171025160013.11136-9-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932330AbdJYQAw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 12:00:52 -0400
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Milian Wolff <milian.wolff@kdab.com>

Instead of showing the (repeated) DSO name of the non-inlined frame, we
now show the "(inlined)" suffix instead.

Before:
                   214f7 __hypot_finite (/usr/lib/libm-2.25.so)
                    ace3 hypot (/usr/lib/libm-2.25.so)
                     a4a std::__complex_abs (/home/milian/projects/src/perf-tests/inlining)
                     a4a std::abs<double> (/home/milian/projects/src/perf-tests/inlining)
                     a4a std::_Norm_helper<true>::_S_do_it<double> (/home/milian/projects/src/perf-tests/inlining)
                     a4a std::norm<double> (/home/milian/projects/src/perf-tests/inlining)
                     a4a main (/home/milian/projects/src/perf-tests/inlining)
                   20510 __libc_start_main (/usr/lib/libc-2.25.so)
                     bd9 _start (/home/milian/projects/src/perf-tests/inlining)

After:
                   214f7 __hypot_finite (/usr/lib/libm-2.25.so)
                    ace3 hypot (/usr/lib/libm-2.25.so)
                     a4a std::__complex_abs (inlined)
                     a4a std::abs<double> (inlined)
                     a4a std::_Norm_helper<true>::_S_do_it<double> (inlined)
                     a4a std::norm<double> (inlined)
                     a4a main (/home/milian/projects/src/perf-tests/inlining)
                   20510 __libc_start_main (/usr/lib/libc-2.25.so)
                     bd9 _start (/home/milian/projects/src/perf-tests/inlining)

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-9-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel_fprintf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index f2c6c5ee11e8..5b9e89257aa7 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -157,7 +157,7 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 				}
 			}
 
-			if (print_dso) {
+			if (print_dso && (!node->sym || !node->sym->inlined)) {
 				printed += fprintf(fp, " (");
 				printed += map__fprintf_dsoname(node->map, fp);
 				printed += fprintf(fp, ")");
@@ -166,6 +166,9 @@ int sample__fprintf_callchain(struct perf_sample *sample, int left_alignment,
 			if (print_srcline)
 				printed += map__fprintf_srcline(node->map, addr, "\n  ", fp);
 
+			if (node->sym && node->sym->inlined)
+				printed += fprintf(fp, " (inlined)");
+
 			if (!print_oneline)
 				printed += fprintf(fp, "\n");
 
-- 
2.13.6
