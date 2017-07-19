From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/86] perf maps: Lookup maps in both intitial mountns and inner mountns.
Date: Wed, 19 Jul 2017 11:28:59 -0300
Message-ID: <20170719142950.3747-36-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Krister Johansen <kjlx@templeofstupid.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

If a process is in a mountns and has symbols in /tmp/perf-<pid>.map,
look first in the namespace using the tgid for the pidns that the
process might be in.  If the map isn't found there, try looking in the
mountns where perf is running, and use the tgid that's appropriate for
perf's pid namespace.  If all else fails, use the original pid.

This allows us to locate a symbol map file in the mount namespace, if it
was generated there.  However, we also try the tool's /tmp in case it's
there instead.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Tested-by: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1499305693-1599-3-git-send-email-kjlx@templeofstupid.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c    |  4 +--
 tools/perf/util/map.c        | 23 +++++++++---
 tools/perf/util/map.h        |  2 +-
 tools/perf/util/namespaces.c | 83 ++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/namespaces.h |  5 ++-
 tools/perf/util/symbol.c     | 70 ++++++++++++++++++++++++++++++-------
 6 files changed, 160 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 2e9eb6aa3ce2..246b441110a1 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1392,7 +1392,7 @@ int machine__process_mmap2_event(struct machine *machine,
 
 	map = map__new(machine, event->mmap2.start,
 			event->mmap2.len, event->mmap2.pgoff,
-			event->mmap2.pid, event->mmap2.maj,
+			event->mmap2.maj,
 			event->mmap2.min, event->mmap2.ino,
 			event->mmap2.ino_generation,
 			event->mmap2.prot,
@@ -1450,7 +1450,7 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 
 	map = map__new(machine, event->mmap.start,
 			event->mmap.len, event->mmap.pgoff,
-			event->mmap.pid, 0, 0, 0, 0, 0, 0,
+			0, 0, 0, 0, 0, 0,
 			event->mmap.filename,
 			type, thread);
 
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 5dc60ca5a294..bdaa0a4edc17 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -146,11 +146,13 @@ void map__init(struct map *map, enum map_type type,
 }
 
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, u32 pid, u32 d_maj, u32 d_min, u64 ino,
+		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
 		     u64 ino_gen, u32 prot, u32 flags, char *filename,
 		     enum map_type type, struct thread *thread)
 {
 	struct map *map = malloc(sizeof(*map));
+	struct nsinfo *nsi = NULL;
+	struct nsinfo *nnsi;
 
 	if (map != NULL) {
 		char newfilename[PATH_MAX];
@@ -168,9 +170,11 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		map->ino_generation = ino_gen;
 		map->prot = prot;
 		map->flags = flags;
+		nsi = nsinfo__get(thread->nsinfo);
 
-		if ((anon || no_dso) && type == MAP__FUNCTION) {
-			snprintf(newfilename, sizeof(newfilename), "/tmp/perf-%d.map", pid);
+		if ((anon || no_dso) && nsi && type == MAP__FUNCTION) {
+			snprintf(newfilename, sizeof(newfilename),
+				 "/tmp/perf-%d.map", nsi->pid);
 			filename = newfilename;
 		}
 
@@ -180,6 +184,16 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 		}
 
 		if (vdso) {
+			/* The vdso maps are always on the host and not the
+			 * container.  Ensure that we don't use setns to look
+			 * them up.
+			 */
+			nnsi = nsinfo__copy(nsi);
+			if (nnsi) {
+				nsinfo__put(nsi);
+				nnsi->need_setns = false;
+				nsi = nnsi;
+			}
 			pgoff = 0;
 			dso = machine__findnew_vdso(machine, thread);
 		} else
@@ -201,11 +215,12 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
 			if (type != MAP__FUNCTION)
 				dso__set_loaded(dso, map->type);
 		}
-		dso->nsinfo = nsinfo__get(thread->nsinfo);
+		dso->nsinfo = nsi;
 		dso__put(dso);
 	}
 	return map;
 out_delete:
+	nsinfo__put(nsi);
 	free(map);
 	return NULL;
 }
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f9e8ac8a52cd..73aacf7a7dc4 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -141,7 +141,7 @@ struct thread;
 void map__init(struct map *map, enum map_type type,
 	       u64 start, u64 end, u64 pgoff, struct dso *dso);
 struct map *map__new(struct machine *machine, u64 start, u64 len,
-		     u64 pgoff, u32 pid, u32 d_maj, u32 d_min, u64 ino,
+		     u64 pgoff, u32 d_maj, u32 d_min, u64 ino,
 		     u64 ino_gen, u32 prot, u32 flags,
 		     char *filename, enum map_type type, struct thread *thread);
 struct map *map__new2(u64 start, struct dso *dso, enum map_type type);
diff --git a/tools/perf/util/namespaces.c b/tools/perf/util/namespaces.c
index bcc6bb19cf10..fc5f398779a4 100644
--- a/tools/perf/util/namespaces.c
+++ b/tools/perf/util/namespaces.c
@@ -40,18 +40,23 @@ void namespaces__free(struct namespaces *namespaces)
 	free(namespaces);
 }
 
-void nsinfo__init(struct nsinfo *nsi)
+int nsinfo__init(struct nsinfo *nsi)
 {
 	char oldns[PATH_MAX];
+	char spath[PATH_MAX];
 	char *newns = NULL;
+	char *statln = NULL;
 	struct stat old_stat;
 	struct stat new_stat;
+	FILE *f = NULL;
+	size_t linesz = 0;
+	int rv = -1;
 
 	if (snprintf(oldns, PATH_MAX, "/proc/self/ns/mnt") >= PATH_MAX)
-		return;
+		return rv;
 
 	if (asprintf(&newns, "/proc/%d/ns/mnt", nsi->pid) == -1)
-		return;
+		return rv;
 
 	if (stat(oldns, &old_stat) < 0)
 		goto out;
@@ -68,24 +73,89 @@ void nsinfo__init(struct nsinfo *nsi)
 		newns = NULL;
 	}
 
+	/* If we're dealing with a process that is in a different PID namespace,
+	 * attempt to work out the innermost tgid for the process.
+	 */
+	if (snprintf(spath, PATH_MAX, "/proc/%d/status", nsi->pid) >= PATH_MAX)
+		goto out;
+
+	f = fopen(spath, "r");
+	if (f == NULL)
+		goto out;
+
+	while (getline(&statln, &linesz, f) != -1) {
+		/* Use tgid if CONFIG_PID_NS is not defined. */
+		if (strstr(statln, "Tgid:") != NULL) {
+			nsi->tgid = (pid_t)strtol(strrchr(statln, '\t'),
+						     NULL, 10);
+			nsi->nstgid = nsi->tgid;
+		}
+
+		if (strstr(statln, "NStgid:") != NULL) {
+			nsi->nstgid = (pid_t)strtol(strrchr(statln, '\t'),
+						     NULL, 10);
+			break;
+		}
+	}
+	rv = 0;
+
 out:
+	if (f != NULL)
+		(void) fclose(f);
+	free(statln);
 	free(newns);
+	return rv;
 }
 
 struct nsinfo *nsinfo__new(pid_t pid)
 {
-	struct nsinfo *nsi = calloc(1, sizeof(*nsi));
+	struct nsinfo *nsi;
 
+	if (pid == 0)
+		return NULL;
+
+	nsi = calloc(1, sizeof(*nsi));
 	if (nsi != NULL) {
 		nsi->pid = pid;
+		nsi->tgid = pid;
+		nsi->nstgid = pid;
 		nsi->need_setns = false;
-		nsinfo__init(nsi);
+		/* Init may fail if the process exits while we're trying to look
+		 * at its proc information.  In that case, save the pid but
+		 * don't try to enter the namespace.
+		 */
+		if (nsinfo__init(nsi) == -1)
+			nsi->need_setns = false;
+
 		refcount_set(&nsi->refcnt, 1);
 	}
 
 	return nsi;
 }
 
+struct nsinfo *nsinfo__copy(struct nsinfo *nsi)
+{
+	struct nsinfo *nnsi;
+
+	nnsi = calloc(1, sizeof(*nnsi));
+	if (nnsi != NULL) {
+		nnsi->pid = nsi->pid;
+		nnsi->tgid = nsi->tgid;
+		nnsi->nstgid = nsi->nstgid;
+		nnsi->need_setns = nsi->need_setns;
+		if (nsi->mntns_path) {
+			nnsi->mntns_path = strdup(nsi->mntns_path);
+			if (!nnsi->mntns_path) {
+				free(nnsi);
+				return NULL;
+			}
+		}
+		refcount_set(&nnsi->refcnt, 1);
+	}
+
+	return nnsi;
+}
+
 void nsinfo__delete(struct nsinfo *nsi)
 {
 	zfree(&nsi->mntns_path);
@@ -105,7 +175,8 @@ void nsinfo__put(struct nsinfo *nsi)
 		nsinfo__delete(nsi);
 }
 
-void nsinfo__mountns_enter(struct nsinfo *nsi, struct nscookie *nc)
+void nsinfo__mountns_enter(struct nsinfo *nsi,
+				  struct nscookie *nc)
 {
 	char curpath[PATH_MAX];
 	int oldns = -1;
diff --git a/tools/perf/util/namespaces.h b/tools/perf/util/namespaces.h
index b20f6ead7b2d..f19aa41119ae 100644
--- a/tools/perf/util/namespaces.h
+++ b/tools/perf/util/namespaces.h
@@ -26,6 +26,8 @@ void namespaces__free(struct namespaces *namespaces);
 
 struct nsinfo {
 	pid_t			pid;
+	pid_t			tgid;
+	pid_t			nstgid;
 	bool			need_setns;
 	char			*mntns_path;
 	refcount_t		refcnt;
@@ -36,8 +38,9 @@ struct nscookie {
 	int			newns;
 };
 
-void nsinfo__init(struct nsinfo *nsi);
+int nsinfo__init(struct nsinfo *nsi);
 struct nsinfo *nsinfo__new(pid_t pid);
+struct nsinfo *nsinfo__copy(struct nsinfo *nsi);
 void nsinfo__delete(struct nsinfo *nsi);
 
 struct nsinfo *nsinfo__get(struct nsinfo *nsi);
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 60a9eaa372ef..21c97cc41cfc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -19,7 +19,6 @@
 #include "strlist.h"
 #include "intlist.h"
 #include "namespaces.h"
-#include "vdso.h"
 #include "header.h"
 #include "path.h"
 #include "sane_ctype.h"
@@ -1327,14 +1326,15 @@ int dso__load_kallsyms(struct dso *dso, const char *filename,
 	return __dso__load_kallsyms(dso, filename, map, false);
 }
 
-static int dso__load_perf_map(struct dso *dso, struct map *map)
+static int dso__load_perf_map(const char *map_path, struct dso *dso,
+			      struct map *map)
 {
 	char *line = NULL;
 	size_t n;
 	FILE *file;
 	int nr_syms = 0;
 
-	file = fopen(dso->long_name, "r");
+	file = fopen(map_path, "r");
 	if (file == NULL)
 		goto out_failure;
 
@@ -1426,6 +1426,45 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 	}
 }
 
+/* Checks for the existence of the perf-<pid>.map file in two different
+ * locations.  First, if the process is a separate mount namespace, check in
+ * that namespace using the pid of the innermost pid namespace.  If's not in a
+ * namespace, or the file can't be found there, try in the mount namespace of
+ * the tracing process using our view of its pid.
+ */
+static int dso__find_perf_map(char *filebuf, size_t bufsz,
+			      struct nsinfo **nsip)
+{
+	struct nscookie nsc;
+	struct nsinfo *nsi;
+	struct nsinfo *nnsi;
+	int rc = -1;
+
+	nsi = *nsip;
+
+	if (nsi->need_setns) {
+		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nsi->nstgid);
+		nsinfo__mountns_enter(nsi, &nsc);
+		rc = access(filebuf, R_OK);
+		nsinfo__mountns_exit(&nsc);
+		if (rc == 0)
+			return rc;
+	}
+
+	nnsi = nsinfo__copy(nsi);
+	if (nnsi) {
+		nsinfo__put(nsi);
+
+		nnsi->need_setns = false;
+		snprintf(filebuf, bufsz, "/tmp/perf-%d.map", nnsi->tgid);
+		*nsip = nnsi;
+		rc = 0;
+	}
+
+	return rc;
+}
+
+
 int dso__load(struct dso *dso, struct map *map)
 {
 	char *name;
@@ -1437,18 +1476,23 @@ int dso__load(struct dso *dso, struct map *map)
 	struct symsrc ss_[2];
 	struct symsrc *syms_ss = NULL, *runtime_ss = NULL;
 	bool kmod;
+	bool perfmap;
 	unsigned char build_id[BUILD_ID_SIZE];
 	struct nscookie nsc;
+	char newmapname[PATH_MAX];
+	const char *map_path = dso->long_name;
+
+	perfmap = strncmp(dso->name, "/tmp/perf-", 10) == 0;
+	if (perfmap) {
+		if (dso->nsinfo && (dso__find_perf_map(newmapname,
+		    sizeof(newmapname), &dso->nsinfo) == 0)) {
+			map_path = newmapname;
+		}
+	}
 
 	nsinfo__mountns_enter(dso->nsinfo, &nsc);
 	pthread_mutex_lock(&dso->lock);
 
-	/* The vdso files always live in the host container, so don't go looking
-	 * for them in the container's mount namespace.
-	 */
-	if (dso__is_vdso(dso))
-		nsinfo__mountns_exit(&nsc);
-
 	/* check again under the dso->lock */
 	if (dso__loaded(dso, map->type)) {
 		ret = 1;
@@ -1471,19 +1515,19 @@ int dso__load(struct dso *dso, struct map *map)
 
 	dso->adjust_symbols = 0;
 
-	if (strncmp(dso->name, "/tmp/perf-", 10) == 0) {
+	if (perfmap) {
 		struct stat st;
 
-		if (lstat(dso->name, &st) < 0)
+		if (lstat(map_path, &st) < 0)
 			goto out;
 
 		if (!symbol_conf.force && st.st_uid && (st.st_uid != geteuid())) {
 			pr_warning("File %s not owned by current user or root, "
-				   "ignoring it (use -f to override).\n", dso->name);
+				   "ignoring it (use -f to override).\n", map_path);
 			goto out;
 		}
 
-		ret = dso__load_perf_map(dso, map);
+		ret = dso__load_perf_map(map_path, dso, map);
 		dso->symtab_type = ret > 0 ? DSO_BINARY_TYPE__JAVA_JIT :
 					     DSO_BINARY_TYPE__NOT_FOUND;
 		goto out;
-- 
2.9.4
