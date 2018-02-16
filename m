From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/41] perf tests: Use arch__compare_symbol_names to compare symbols
Date: Fri, 16 Feb 2018 16:17:24 -0300
Message-ID: <20180216191746.11095-20-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The symbol search called by machine__find_kernel_symbol_by_name is using
internally arch__compare_symbol_names function to compare 2 symbol
names, because different archs have different ways of comparing symbols.
Mostly for skipping '.' prefixes and similar.

In test 1 when we try to find matching symbols in kallsyms and vmlinux,
by address and by symbol name. When either is found we compare the pair
symbol names  by simple strcmp, which is not good enough for reasons
explained in previous paragraph.

On powerpc this can cause lockup, because even thought we found the
pair, the compared names are different and don't match simple strcmp.
Following code path is executed, that leads to lockup:

   - we find the pair in kallsyms by sym->start
next_pair:
   - we compare the names and it fails
   - we find the pair by sym->name
   - the pair addresses match so we call goto next_pair
     because we assume the names match in this case

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 031b84c407c3 ("perf probe ppc: Enable matching against dot symbols automatically")
Link: http://lkml.kernel.org/r/20180215122635.24029-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/vmlinux-kallsyms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/vmlinux-kallsyms.c b/tools/perf/tests/vmlinux-kallsyms.c
index 58349297f9fb..1e5adb65632a 100644
--- a/tools/perf/tests/vmlinux-kallsyms.c
+++ b/tools/perf/tests/vmlinux-kallsyms.c
@@ -125,7 +125,7 @@ int test__vmlinux_matches_kallsyms(struct test *test __maybe_unused, int subtest
 
 		if (pair && UM(pair->start) == mem_start) {
 next_pair:
-			if (strcmp(sym->name, pair->name) == 0) {
+			if (arch__compare_symbol_names(sym->name, pair->name) == 0) {
 				/*
 				 * kallsyms don't have the symbol end, so we
 				 * set that by using the next symbol start - 1,
-- 
2.14.3
