From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: [PATCH perf/core 21/22] perf: Fix machine.vmlinux_maps to make sure
 to clear the old one
Date: Wed, 09 Dec 2015 11:11:33 +0900
Message-ID: <20151209021133.10245.93730.stgit@localhost.localdomain>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209021047.10245.8918.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Fix machine.vmlinux_maps to make sure to clear the old one
if it is renewal. This can leak the previous maps on the
vmlinux_maps because those are just overwritten.

Signed-off-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 tools/perf/util/machine.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index bfc289c..3172aa5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -44,6 +44,8 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	machine->comm_exec = false;
 	machine->kernel_start = 0;
 
+	memset(machine->vmlinux_maps, 0, sizeof(struct map *) * MAP__NR_TYPES);
+
 	machine->root_dir = strdup(root_dir);
 	if (machine->root_dir == NULL)
 		return -ENOMEM;
@@ -770,6 +772,9 @@ int __machine__create_kernel_maps(struct machine *machine, struct dso *kernel)
 	enum map_type type;
 	u64 start = machine__get_running_kernel_start(machine, NULL);
 
+	/* In case of renewal the kernel map, destroy previous one */
+	machine__destroy_kernel_maps(machine);
+
 	for (type = 0; type < MAP__NR_TYPES; ++type) {
 		struct kmap *kmap;
 		struct map *map;
