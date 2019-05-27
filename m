From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/44] perf machine: Read also the end of the kernel
Date: Mon, 27 May 2019 19:37:21 -0300
Message-ID: <20190527223730.11474-36-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Stanislav Fomichev <sdf@google.com>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

We mark the end of kernel based on the first module, but that could
cover some bpf program maps. Reading _etext symbol if it's present to
get precise kernel map end.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 28a9541c4835..dc7aafe45a2b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -924,7 +924,8 @@ const char *ref_reloc_sym_names[] = {"_text", "_stext", NULL};
  * symbol_name if it's not that important.
  */
 static int machine__get_running_kernel_start(struct machine *machine,
-					     const char **symbol_name, u64 *start)
+					     const char **symbol_name,
+					     u64 *start, u64 *end)
 {
 	char filename[PATH_MAX];
 	int i, err = -1;
@@ -949,6 +950,11 @@ static int machine__get_running_kernel_start(struct machine *machine,
 		*symbol_name = name;
 
 	*start = addr;
+
+	err = kallsyms__get_function_start(filename, "_etext", &addr);
+	if (!err)
+		*end = addr;
+
 	return 0;
 }
 
@@ -1441,7 +1447,7 @@ int machine__create_kernel_maps(struct machine *machine)
 	struct dso *kernel = machine__get_kernel(machine);
 	const char *name = NULL;
 	struct map *map;
-	u64 addr = 0;
+	u64 start = 0, end = ~0ULL;
 	int ret;
 
 	if (kernel == NULL)
@@ -1460,9 +1466,9 @@ int machine__create_kernel_maps(struct machine *machine)
 				 "continuing anyway...\n", machine->pid);
 	}
 
-	if (!machine__get_running_kernel_start(machine, &name, &addr)) {
+	if (!machine__get_running_kernel_start(machine, &name, &start, &end)) {
 		if (name &&
-		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, addr)) {
+		    map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map, name, start)) {
 			machine__destroy_kernel_maps(machine);
 			ret = -1;
 			goto out_put;
@@ -1472,16 +1478,19 @@ int machine__create_kernel_maps(struct machine *machine)
 		 * we have a real start address now, so re-order the kmaps
 		 * assume it's the last in the kmaps
 		 */
-		machine__update_kernel_mmap(machine, addr, ~0ULL);
+		machine__update_kernel_mmap(machine, start, end);
 	}
 
 	if (machine__create_extra_kernel_maps(machine, kernel))
 		pr_debug("Problems creating extra kernel maps, continuing anyway...\n");
 
-	/* update end address of the kernel map using adjacent module address */
-	map = map__next(machine__kernel_map(machine));
-	if (map)
-		machine__set_kernel_mmap(machine, addr, map->start);
+	if (end == ~0ULL) {
+		/* update end address of the kernel map using adjacent module address */
+		map = map__next(machine__kernel_map(machine));
+		if (map)
+			machine__set_kernel_mmap(machine, start, map->start);
+	}
+
 out_put:
 	dso__put(kernel);
 	return ret;
-- 
2.20.1
