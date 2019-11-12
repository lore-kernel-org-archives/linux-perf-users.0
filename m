From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/15] perf tools: Add map_groups to 'struct addr_location'
Date: Tue, 12 Nov 2019 15:37:46 -0300
Message-ID: <20191112183757.28660-5-acme@kernel.org>
References: <20191112183757.28660-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112183757.28660-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

From there we can get al->mg->machine, so replace that field with the
more useful 'struct map_groups' that for now we're obtaining from
al->map->groups, and that is one thing getting into the way of maps
being fully shareable.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-4qdducrm32tgrjupcp0kjh1e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c                          |  6 +++---
 tools/perf/util/db-export.c                          | 12 ++++++------
 tools/perf/util/event.c                              |  6 +++---
 .../perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/symbol.h                             |  2 +-
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 9a9b56ed3f0a..89faa644b0bc 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1119,8 +1119,8 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			goto out;
 	}
 
-	if (al->map->groups == &al->machine->kmaps) {
-		if (machine__is_host(al->machine)) {
+	if (al->mg == &al->mg->machine->kmaps) {
+		if (machine__is_host(al->mg->machine)) {
 			al->cpumode = PERF_RECORD_MISC_KERNEL;
 			al->level = 'k';
 		} else {
@@ -1128,7 +1128,7 @@ int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *
 			al->level = 'g';
 		}
 	} else {
-		if (machine__is_host(al->machine)) {
+		if (machine__is_host(al->mg->machine)) {
 			al->cpumode = PERF_RECORD_MISC_USER;
 			al->level = '.';
 		} else if (perf_guest) {
diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 752227b265e7..44b465c0a343 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -181,7 +181,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
 	if (al->map) {
 		struct dso *dso = al->map->dso;
 
-		err = db_export__dso(dbe, dso, al->machine);
+		err = db_export__dso(dbe, dso, al->mg->machine);
 		if (err)
 			return err;
 		*dso_db_id = dso->db_id;
@@ -251,7 +251,7 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
 		 */
 		al.sym = node->sym;
 		al.map = node->map;
-		al.machine = machine;
+		al.mg  = thread->mg;
 		al.addr = node->ip;
 
 		if (al.map && !al.sym)
@@ -360,13 +360,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	if (err)
 		return err;
 
-	err = db_export__machine(dbe, al->machine);
+	err = db_export__machine(dbe, al->mg->machine);
 	if (err)
 		return err;
 
-	main_thread = thread__main_thread(al->machine, thread);
+	main_thread = thread__main_thread(al->mg->machine, thread);
 
-	err = db_export__threads(dbe, thread, main_thread, al->machine, &comm);
+	err = db_export__threads(dbe, thread, main_thread, al->mg->machine, &comm);
 	if (err)
 		goto out_put;
 
@@ -380,7 +380,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (dbe->cpr) {
-		struct call_path *cp = call_path_from_sample(dbe, al->machine,
+		struct call_path *cp = call_path_from_sample(dbe, al->mg->machine,
 							     thread, sample,
 							     evsel);
 		if (cp) {
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index fc1e5a991008..0141b26bae47 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -461,7 +461,7 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 	struct machine *machine = mg->machine;
 	bool load_map = false;
 
-	al->machine = machine;
+	al->mg = mg;
 	al->thread = thread;
 	al->addr = addr;
 	al->cpumode = cpumode;
@@ -474,13 +474,13 @@ struct map *thread__find_map(struct thread *thread, u8 cpumode, u64 addr,
 
 	if (cpumode == PERF_RECORD_MISC_KERNEL && perf_host) {
 		al->level = 'k';
-		mg = &machine->kmaps;
+		al->mg = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_USER && perf_host) {
 		al->level = '.';
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_KERNEL && perf_guest) {
 		al->level = 'g';
-		mg = &machine->kmaps;
+		al->mg = mg = &machine->kmaps;
 		load_map = true;
 	} else if (cpumode == PERF_RECORD_MISC_GUEST_USER && perf_guest) {
 		al->level = 'u';
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 93c03b39cd9c..9e0582717f5f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1127,7 +1127,7 @@ static void python_export_sample_table(struct db_export *dbe,
 
 	tuple_set_u64(t, 0, es->db_id);
 	tuple_set_u64(t, 1, es->evsel->db_id);
-	tuple_set_u64(t, 2, es->al->machine->db_id);
+	tuple_set_u64(t, 2, es->al->mg->machine->db_id);
 	tuple_set_u64(t, 3, es->al->thread->db_id);
 	tuple_set_u64(t, 4, es->comm_db_id);
 	tuple_set_u64(t, 5, es->dso_db_id);
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index c3bd16d75d5d..0b718cc9fb28 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -107,8 +107,8 @@ struct ref_reloc_sym {
 };
 
 struct addr_location {
-	struct machine *machine;
 	struct thread *thread;
+	struct map_groups *mg;
 	struct map    *map;
 	struct symbol *sym;
 	const char    *srcline;
-- 
2.21.0
