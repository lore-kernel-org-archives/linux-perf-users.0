From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/21] perf tools: Get rid of dso__needs_decompress() call in read_object_code()
Date: Mon, 20 Aug 2018 13:15:46 -0300
Message-ID: <20180820161602.6830-6-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

There's no need to call dso__needs_decompress() twice in the function.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/code-reading.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 4892bd2dc33e..6b049f3f5cf4 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -232,6 +232,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	u64 objdump_addr;
 	const char *objdump_name;
 	char decomp_name[KMOD_DECOMP_LEN];
+	bool decomp = false;
 	int ret;
 
 	pr_debug("Reading object code for memory address: %#"PRIx64"\n", addr);
@@ -305,6 +306,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 			return -1;
 		}
 
+		decomp = true;
 		objdump_name = decomp_name;
 	}
 
@@ -312,7 +314,7 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 	objdump_addr = map__rip_2objdump(al.map, al.addr);
 	ret = read_via_objdump(objdump_name, objdump_addr, buf2, len);
 
-	if (dso__needs_decompress(al.map->dso))
+	if (decomp)
 		unlink(objdump_name);
 
 	if (ret > 0) {
-- 
2.14.4
