From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 7/7] perf script: mark inlined frames and do not print DSO for them
Date: Thu, 18 May 2017 21:34:11 +0200
Message-ID: <20170518193411.22380-8-milian.wolff@kdab.com>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518193411.22380-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Instead of showing the (repeated) DSO name of the non-inlined
frame, we now show the "(inlined)" suffix instead.

Before:
                   214f7 __hypot_finite (/usr/lib/libm-2.25.so)
                    ace3 hypot (/usr/lib/libm-2.25.so)
                         std::__complex_abs (/home/milian/projects/src/perf-tests/inlining)
                         std::abs<double> (/home/milian/projects/src/perf-tests/inlining)
                         std::_Norm_helper<true>::_S_do_it<double> (/home/milian/projects/src/perf-tests/inlining)
                         std::norm<double> (/home/milian/projects/src/perf-tests/inlining)
                     a4a main (/home/milian/projects/src/perf-tests/inlining)
                   20510 __libc_start_main (/usr/lib/libc-2.25.so)
                     bd9 _start (/home/milian/projects/src/perf-tests/inlining)

After:
                   214f7 __hypot_finite (/usr/lib/libm-2.25.so)
                    ace3 hypot (/usr/lib/libm-2.25.so)
                         std::__complex_abs (inlined)
                         std::abs<double> (inlined)
                         std::_Norm_helper<true>::_S_do_it<double> (inlined)
                         std::norm<double> (inlined)
                     a4a main (/home/milian/projects/src/perf-tests/inlining)
                   20510 __libc_start_main (/usr/lib/libc-2.25.so)
                     bd9 _start (/home/milian/projects/src/perf-tests/inlining)

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
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
2.13.0
