From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 48/63] perf machine: Add kernel_dso() method
Date: Thu,  7 Nov 2019 15:59:56 -0300
Message-ID: <20191107190011.23924-49-acme@kernel.org>
References: <20191107190011.23924-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191107190011.23924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce boilerplate in some places.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-9s1bgoxxhlnu037e1nqx0tw3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 24d9e284daad..e768ef24633f 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -42,6 +42,11 @@
 
 static void __machine__remove_thread(struct machine *machine, struct thread *th, bool lock);
 
+static struct dso *machine__kernel_dso(struct machine *machine)
+{
+	return machine->vmlinux_map->dso;
+}
+
 static void dsos__init(struct dsos *dsos)
 {
 	INIT_LIST_HEAD(&dsos->head);
@@ -861,7 +866,7 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 {
 	int i;
 	size_t printed = 0;
-	struct dso *kdso = machine__kernel_map(machine)->dso;
+	struct dso *kdso = machine__kernel_dso(machine);
 
 	if (kdso->has_build_id) {
 		char filename[PATH_MAX];
@@ -1543,8 +1548,7 @@ static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
 static int machine__process_extra_kernel_map(struct machine *machine,
 					     union perf_event *event)
 {
-	struct map *kernel_map = machine__kernel_map(machine);
-	struct dso *kernel = kernel_map ? kernel_map->dso : NULL;
+	struct dso *kernel = machine__kernel_dso(machine);
 	struct extra_kernel_map xm = {
 		.start = event->mmap.start,
 		.end   = event->mmap.start + event->mmap.len,
-- 
2.21.0
