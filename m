From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/21] perf tools: Store compression id into struct dso
Date: Mon, 20 Aug 2018 13:15:52 -0300
Message-ID: <20180820161602.6830-12-acme@kernel.org>
References: <20180820161602.6830-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180820161602.6830-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Michael Petlan <mpetlan@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add comp to 'struct dso' to hold the compression index.  It will be used
in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-8-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c     | 5 ++++-
 tools/perf/util/dso.h     | 1 +
 tools/perf/util/machine.c | 4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index d34e47bb09d9..d875e6956a3e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -417,8 +417,10 @@ void dso__set_module_info(struct dso *dso, struct kmod_path *m,
 		dso->symtab_type = DSO_BINARY_TYPE__GUEST_KMODULE;
 
 	/* _KMODULE_COMP should be next to _KMODULE */
-	if (m->kmod && m->comp)
+	if (m->kmod && m->comp) {
 		dso->symtab_type++;
+		dso->comp = m->comp;
+	}
 
 	dso__set_short_name(dso, strdup(m->name), true);
 }
@@ -1224,6 +1226,7 @@ struct dso *dso__new(const char *name)
 		dso->a2l_fails = 1;
 		dso->kernel = DSO_TYPE_USER;
 		dso->needs_swap = DSO_SWAP__UNSET;
+		dso->comp = COMP_ID__NONE;
 		RB_CLEAR_NODE(&dso->rb_node);
 		dso->root = NULL;
 		INIT_LIST_HEAD(&dso->node);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 7bde23f6e5a9..a6c7af52115f 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -175,6 +175,7 @@ struct dso {
 	u16		 short_name_len;
 	void		*dwfl;			/* DWARF debug info */
 	struct auxtrace_cache *auxtrace_cache;
+	int		 comp;
 
 	/* dso data file */
 	struct {
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index b300a3973448..c4acd2001db0 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1212,8 +1212,10 @@ static int map_groups__set_module_path(struct map_groups *mg, const char *path,
 	 * Full name could reveal us kmod compression, so
 	 * we need to update the symtab_type if needed.
 	 */
-	if (m->comp && is_kmod_dso(map->dso))
+	if (m->comp && is_kmod_dso(map->dso)) {
 		map->dso->symtab_type++;
+		map->dso->comp = m->comp;
+	}
 
 	return 0;
 }
-- 
2.14.4
