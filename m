From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 13/41] perf machine: Free root_dir in machine__init() error path
Date: Fri, 16 Feb 2018 16:17:18 -0300
Message-ID: <20180216191746.11095-14-acme@kernel.org>
References: <20180216191746.11095-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180216191746.11095-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Free root_dir in machine__init() error path.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180215122635.24029-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b05a67464c03..c976384f9022 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -50,6 +50,8 @@ static void machine__threads_init(struct machine *machine)
 
 int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 {
+	int err = -ENOMEM;
+
 	memset(machine, 0, sizeof(*machine));
 	map_groups__init(&machine->kmaps, machine);
 	RB_CLEAR_NODE(&machine->rb_node);
@@ -79,7 +81,7 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 		char comm[64];
 
 		if (thread == NULL)
-			return -ENOMEM;
+			goto out;
 
 		snprintf(comm, sizeof(comm), "[guest/%d]", pid);
 		thread__set_comm(thread, comm, 0);
@@ -87,7 +89,11 @@ int machine__init(struct machine *machine, const char *root_dir, pid_t pid)
 	}
 
 	machine->current_tid = NULL;
+	err = 0;
 
+out:
+	if (err)
+		zfree(&machine->root_dir);
 	return 0;
 }
 
-- 
2.14.3
