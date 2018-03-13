From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/31] perf machine: Fix mmap name setup
Date: Tue, 13 Mar 2018 09:05:07 -0300
Message-ID: <20180313120508.29327-31-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Leo reported broken -k option behavior. The reason is that we used
symbol_conf.vmlinux_name as a source for mmap event name, but in fact
it's a vmlinux path.

Moving the symbol_conf.vmlinux_name check for both host and guest to the
proper place and out of the machine__set_mmap_name function.

Reported-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: commit ("8c7f1bb37b29 perf machine: Move kernel mmap name into struct machine")
Link: http://lkml.kernel.org/r/20180312152406.10141-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 43fbbee409ec..2eca8478e24f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -50,21 +50,13 @@ static void machine__threads_init(struct machine *machine)
 
 static int machine__set_mmap_name(struct machine *machine)
 {
-	if (machine__is_host(machine)) {
-		if (symbol_conf.vmlinux_name)
-			machine->mmap_name = strdup(symbol_conf.vmlinux_name);
-		else
-			machine->mmap_name = strdup("[kernel.kallsyms]");
-	} else if (machine__is_default_guest(machine)) {
-		if (symbol_conf.default_guest_vmlinux_name)
-			machine->mmap_name = strdup(symbol_conf.default_guest_vmlinux_name);
-		else
-			machine->mmap_name = strdup("[guest.kernel.kallsyms]");
-	} else {
-		if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
-			 machine->pid) < 0)
-			machine->mmap_name = NULL;
-	}
+	if (machine__is_host(machine))
+		machine->mmap_name = strdup("[kernel.kallsyms]");
+	else if (machine__is_default_guest(machine))
+		machine->mmap_name = strdup("[guest.kernel.kallsyms]");
+	else if (asprintf(&machine->mmap_name, "[guest.kernel.kallsyms.%d]",
+			  machine->pid) < 0)
+		machine->mmap_name = NULL;
 
 	return machine->mmap_name ? 0 : -ENOMEM;
 }
@@ -794,9 +786,15 @@ static struct dso *machine__get_kernel(struct machine *machine)
 	struct dso *kernel;
 
 	if (machine__is_host(machine)) {
+		if (symbol_conf.vmlinux_name)
+			vmlinux_name = symbol_conf.vmlinux_name;
+
 		kernel = machine__findnew_kernel(machine, vmlinux_name,
 						 "[kernel]", DSO_TYPE_KERNEL);
 	} else {
+		if (symbol_conf.default_guest_vmlinux_name)
+			vmlinux_name = symbol_conf.default_guest_vmlinux_name;
+
 		kernel = machine__findnew_kernel(machine, vmlinux_name,
 						 "[guest.kernel]",
 						 DSO_TYPE_GUEST_KERNEL);
-- 
2.14.3
