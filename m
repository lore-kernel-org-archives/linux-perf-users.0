From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/19] perf script: Use pr_debug where appropriate
Date: Fri,  3 Nov 2017 10:54:46 -0300
Message-ID: <20171103135503.4921-3-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We have facilities for reporting unexpected, unlikely errors, use them.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: yuzhoujian <yuzhoujian@didichuxing.com>
Link: http://lkml.kernel.org/n/tip-c7j22xfjf1j773g7ufp607q0@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index db4ff1510dc5..af0267072d43 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -769,27 +769,26 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	 * but the exit is not. Let the caller patch it up.
 	 */
 	if (kernel != machine__kernel_ip(machine, end)) {
-		printf("\tblock %" PRIx64 "-%" PRIx64 " transfers between kernel and user\n",
-				start, end);
+		pr_debug("\tblock %" PRIx64 "-%" PRIx64 " transfers between kernel and user\n", start, end);
 		return -ENXIO;
 	}
 
 	memset(&al, 0, sizeof(al));
 	if (end - start > MAXBB - MAXINSN) {
 		if (last)
-			printf("\tbrstack does not reach to final jump (%" PRIx64 "-%" PRIx64 ")\n", start, end);
+			pr_debug("\tbrstack does not reach to final jump (%" PRIx64 "-%" PRIx64 ")\n", start, end);
 		else
-			printf("\tblock %" PRIx64 "-%" PRIx64 " (%" PRIu64 ") too long to dump\n", start, end, end - start);
+			pr_debug("\tblock %" PRIx64 "-%" PRIx64 " (%" PRIu64 ") too long to dump\n", start, end, end - start);
 		return 0;
 	}
 
 	thread__find_addr_map(thread, *cpumode, MAP__FUNCTION, start, &al);
 	if (!al.map || !al.map->dso) {
-		printf("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
+		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
 	if (al.map->dso->data.status == DSO_DATA_STATUS_ERROR) {
-		printf("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
+		pr_debug("\tcannot resolve %" PRIx64 "-%" PRIx64 "\n", start, end);
 		return 0;
 	}
 
@@ -802,7 +801,7 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 
 	*is64bit = al.map->dso->is_64_bit;
 	if (len <= 0)
-		printf("\tcannot fetch code for block at %" PRIx64 "-%" PRIx64 "\n",
+		pr_debug("\tcannot fetch code for block at %" PRIx64 "-%" PRIx64 "\n",
 			start, end);
 	return len;
 }
-- 
2.13.6
