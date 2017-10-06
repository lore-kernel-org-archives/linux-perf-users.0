From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 1/1] perf script: Add missing separator for "-F ip,brstack" (and brstackoff)
Date: Fri,  6 Oct 2017 10:02:10 -0300
Message-ID: <20171006130210.10533-2-acme@kernel.org>
References: <20171006130210.10533-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171006130210.10533-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mark Santaniello <marksan@fb.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, "4 . 13+" <stable@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mark Santaniello <marksan@fb.com>

Prior to commit 55b9b50811ca ("perf script: Support -F brstack,dso and
brstacksym,dso"), we were printing a space before the brstack data. It
seems that this space was important.  Without it, parsing is difficult.

Very sorry for the mistake.

Notice here how the "ip" and "brstack" run together:

$ perf script -F ip,brstack | head -n 1
          22e18c40x22e19e2/0x22e190b/P/-/-/0 0x22e19a1/0x22e19d0/P/-/-/0 0x22e195d/0x22e1990/P/-/-/0 0x22e18e9/0x22e1943/P/-/-/0 0x22e1a69/0x22e18c0/P/-/-/0 0x22e19f7/0x22e1a20/P/-/-/0 0x22e1910/0x22e19ee/P/-/-/0 0x22e19e2/0x22e190b/P/-/-/0 0x22e19a1/0x22e19d0/P/-/-/0 0x22e195d/0x22e1990/P/-/-/0 0x22e18e9/0x22e1943/P/-/-/0 0x22e1a69/0x22e18c0/P/-/-/0 0x22e19f7/0x22e1a20/P/-/-/0 0x22e1910/0x22e19ee/P/-/-/0 0x22e19e2/0x22e190b/P/-/-/0 0x22e19a1/0x22e19d0/P/-/-/0

After this diff, sanity is restored:

$ perf script -F ip,brstack | head -n 1
          22e18c4 0x22e19e2/0x22e190b/P/-/-/0  0x22e19a1/0x22e19d0/P/-/-/0  0x22e195d/0x22e1990/P/-/-/0  0x22e18e9/0x22e1943/P/-/-/0  0x22e1a69/0x22e18c0/P/-/-/0  0x22e19f7/0x22e1a20/P/-/-/0  0x22e1910/0x22e19ee/P/-/-/0  0x22e19e2/0x22e190b/P/-/-/0  0x22e19a1/0x22e19d0/P/-/-/0  0x22e195d/0x22e1990/P/-/-/0  0x22e18e9/0x22e1943/P/-/-/0  0x22e1a69/0x22e18c0/P/-/-/0  0x22e19f7/0x22e1a20/P/-/-/0  0x22e1910/0x22e19ee/P/-/-/0  0x22e19e2/0x22e190b/P/-/-/0  0x22e19a1/0x22e19d0/P/-/-/0

Signed-off-by: Mark Santaniello <marksan@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: 4.13+ <stable@vger.kernel.org>
Fixes: 55b9b50811ca ("perf script: Support -F brstack,dso and brstacksym,dso")
Link: http://lkml.kernel.org/r/20171006080722.3442046-1-marksan@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3d4c3b5e1868..0c977b6e0f8b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -586,7 +586,7 @@ static void print_sample_brstack(struct perf_sample *sample,
 			thread__find_addr_map(thread, sample->cpumode, MAP__FUNCTION, to, &alt);
 		}
 
-		printf("0x%"PRIx64, from);
+		printf(" 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
 			map__fprintf_dsoname(alf.map, stdout);
@@ -681,7 +681,7 @@ static void print_sample_brstackoff(struct perf_sample *sample,
 		if (alt.map && !alt.map->dso->adjust_symbols)
 			to = map__map_ip(alt.map, to);
 
-		printf("0x%"PRIx64, from);
+		printf(" 0x%"PRIx64, from);
 		if (PRINT_FIELD(DSO)) {
 			printf("(");
 			map__fprintf_dsoname(alf.map, stdout);
-- 
2.13.6
