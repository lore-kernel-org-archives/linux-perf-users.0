From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/86] perf buildid-cache: Support binary objects from other namespaces
Date: Wed, 19 Jul 2017 11:29:01 -0300
Message-ID: <20170719142950.3747-38-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Krister Johansen <kjlx@templeofstupid.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

Teach buildid-cache how to add, remove, and update binary objects from
other mount namespaces.  Allow probe events tracing binaries in
different namespaces to add their objects to the probe and build-id
caches too.  As a handy side effect, this also lets us access SDT probes
in binaries from alternate mount namespaces.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Tested-by: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1499305693-1599-5-git-send-email-kjlx@templeofstupid.com
[ Add util/namespaces.c to tools/perf/util/python-ext-sources, to fix the python binding 'perf test' ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-buildid-cache.txt |  5 +++
 tools/perf/Documentation/perf-probe.txt         |  5 +++
 tools/perf/builtin-buildid-cache.c              | 52 ++++++++++++++++++-------
 tools/perf/builtin-probe.c                      |  2 +-
 tools/perf/tests/sdt.c                          |  4 +-
 tools/perf/util/build-id.c                      | 47 ++++++++++++++--------
 tools/perf/util/build-id.h                      |  9 +++--
 tools/perf/util/dso.c                           | 12 +++++-
 tools/perf/util/parse-events.c                  |  2 +-
 tools/perf/util/probe-event.c                   |  6 +--
 tools/perf/util/probe-file.c                    | 19 +++++----
 tools/perf/util/probe-file.h                    |  4 +-
 tools/perf/util/python-ext-sources              |  1 +
 tools/perf/util/symbol.c                        | 19 ++++++---
 tools/perf/util/util.c                          | 34 +++++++++++++---
 tools/perf/util/util.h                          |  2 +
 16 files changed, 160 insertions(+), 63 deletions(-)

diff --git a/tools/perf/Documentation/perf-buildid-cache.txt b/tools/perf/Documentation/perf-buildid-cache.txt
index 058064db39d2..84681007f80f 100644
--- a/tools/perf/Documentation/perf-buildid-cache.txt
+++ b/tools/perf/Documentation/perf-buildid-cache.txt
@@ -61,6 +61,11 @@ OPTIONS
 --verbose::
 	Be more verbose.
 
+--target-ns=PID:
+	Obtain mount namespace information from the target pid.  This is
+	used when creating a uprobe for a process that resides in a
+	different mount namespace from the perf(1) utility.
+
 SEE ALSO
 --------
 linkperf:perf-record[1], linkperf:perf-report[1], linkperf:perf-buildid-list[1]
diff --git a/tools/perf/Documentation/perf-probe.txt b/tools/perf/Documentation/perf-probe.txt
index a42aabc2b082..d7e4869905f1 100644
--- a/tools/perf/Documentation/perf-probe.txt
+++ b/tools/perf/Documentation/perf-probe.txt
@@ -273,6 +273,11 @@ Add a uprobe to a target process running in a different mount namespace
 
  ./perf probe --target-ns <target pid> -x /lib64/libc.so.6 malloc
 
+Add a USDT probe to a target process running in a different mount namespace
+
+ ./perf probe --target-ns <target pid> -x /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.121-0.b13.el7_3.x86_64/jre/lib/amd64/server/libjvm.so %sdt_hotspot:thread__sleep__end
+
+
 SEE ALSO
 --------
 linkperf:perf-trace[1], linkperf:perf-record[1], linkperf:perf-buildid-cache[1]
diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 9eba7f1add1f..d65bd86bee99 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -14,6 +14,7 @@
 #include <unistd.h>
 #include "builtin.h"
 #include "perf.h"
+#include "namespaces.h"
 #include "util/cache.h"
 #include "util/debug.h"
 #include "util/header.h"
@@ -165,33 +166,41 @@ static int build_id_cache__add_kcore(const char *filename, bool force)
 	return 0;
 }
 
-static int build_id_cache__add_file(const char *filename)
+static int build_id_cache__add_file(const char *filename, struct nsinfo *nsi)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 	u8 build_id[BUILD_ID_SIZE];
 	int err;
+	struct nscookie nsc;
 
-	if (filename__read_build_id(filename, &build_id, sizeof(build_id)) < 0) {
+	nsinfo__mountns_enter(nsi, &nsc);
+	err = filename__read_build_id(filename, &build_id, sizeof(build_id));
+	nsinfo__mountns_exit(&nsc);
+	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
 		return -1;
 	}
 
 	build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
-	err = build_id_cache__add_s(sbuild_id, filename,
+	err = build_id_cache__add_s(sbuild_id, filename, nsi,
 				    false, false);
 	pr_debug("Adding %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");
 	return err;
 }
 
-static int build_id_cache__remove_file(const char *filename)
+static int build_id_cache__remove_file(const char *filename, struct nsinfo *nsi)
 {
 	u8 build_id[BUILD_ID_SIZE];
 	char sbuild_id[SBUILD_ID_SIZE];
+	struct nscookie nsc;
 
 	int err;
 
-	if (filename__read_build_id(filename, &build_id, sizeof(build_id)) < 0) {
+	nsinfo__mountns_enter(nsi, &nsc);
+	err = filename__read_build_id(filename, &build_id, sizeof(build_id));
+	nsinfo__mountns_exit(&nsc);
+	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
 		return -1;
 	}
@@ -204,13 +213,13 @@ static int build_id_cache__remove_file(const char *filename)
 	return err;
 }
 
-static int build_id_cache__purge_path(const char *pathname)
+static int build_id_cache__purge_path(const char *pathname, struct nsinfo *nsi)
 {
 	struct strlist *list;
 	struct str_node *pos;
 	int err;
 
-	err = build_id_cache__list_build_ids(pathname, &list);
+	err = build_id_cache__list_build_ids(pathname, nsi, &list);
 	if (err)
 		goto out;
 
@@ -256,24 +265,30 @@ static int build_id_cache__fprintf_missing(struct perf_session *session, FILE *f
 	return 0;
 }
 
-static int build_id_cache__update_file(const char *filename)
+static int build_id_cache__update_file(const char *filename, struct nsinfo *nsi)
 {
 	u8 build_id[BUILD_ID_SIZE];
 	char sbuild_id[SBUILD_ID_SIZE];
+	struct nscookie nsc;
 
-	int err = 0;
+	int err;
 
-	if (filename__read_build_id(filename, &build_id, sizeof(build_id)) < 0) {
+	nsinfo__mountns_enter(nsi, &nsc);
+	err = filename__read_build_id(filename, &build_id, sizeof(build_id));
+	nsinfo__mountns_exit(&nsc);
+	if (err < 0) {
 		pr_debug("Couldn't read a build-id in %s\n", filename);
 		return -1;
 	}
+	err = 0;
 
 	build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
 	if (build_id_cache__cached(sbuild_id))
 		err = build_id_cache__remove_s(sbuild_id);
 
 	if (!err)
-		err = build_id_cache__add_s(sbuild_id, filename, false, false);
+		err = build_id_cache__add_s(sbuild_id, filename, nsi, false,
+					    false);
 
 	pr_debug("Updating %s %s: %s\n", sbuild_id, filename,
 		 err ? "FAIL" : "Ok");
@@ -286,6 +301,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 	struct strlist *list;
 	struct str_node *pos;
 	int ret = 0;
+	int ns_id = -1;
 	bool force = false;
 	char const *add_name_list_str = NULL,
 		   *remove_name_list_str = NULL,
@@ -299,6 +315,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		.mode  = PERF_DATA_MODE_READ,
 	};
 	struct perf_session *session = NULL;
+	struct nsinfo *nsi = NULL;
 
 	const struct option buildid_cache_options[] = {
 	OPT_STRING('a', "add", &add_name_list_str,
@@ -315,6 +332,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 	OPT_STRING('u', "update", &update_name_list_str, "file list",
 		    "file(s) to update"),
 	OPT_INCR('v', "verbose", &verbose, "be more verbose"),
+	OPT_INTEGER(0, "target-ns", &ns_id, "target pid for namespace context"),
 	OPT_END()
 	};
 	const char * const buildid_cache_usage[] = {
@@ -330,6 +348,9 @@ int cmd_buildid_cache(int argc, const char **argv)
 		     !missing_filename && !update_name_list_str))
 		usage_with_options(buildid_cache_usage, buildid_cache_options);
 
+	if (ns_id > 0)
+		nsi = nsinfo__new(ns_id);
+
 	if (missing_filename) {
 		file.path = missing_filename;
 		file.force = force;
@@ -348,7 +369,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		list = strlist__new(add_name_list_str, NULL);
 		if (list) {
 			strlist__for_each_entry(pos, list)
-				if (build_id_cache__add_file(pos->s)) {
+				if (build_id_cache__add_file(pos->s, nsi)) {
 					if (errno == EEXIST) {
 						pr_debug("%s already in the cache\n",
 							 pos->s);
@@ -366,7 +387,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		list = strlist__new(remove_name_list_str, NULL);
 		if (list) {
 			strlist__for_each_entry(pos, list)
-				if (build_id_cache__remove_file(pos->s)) {
+				if (build_id_cache__remove_file(pos->s, nsi)) {
 					if (errno == ENOENT) {
 						pr_debug("%s wasn't in the cache\n",
 							 pos->s);
@@ -384,7 +405,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		list = strlist__new(purge_name_list_str, NULL);
 		if (list) {
 			strlist__for_each_entry(pos, list)
-				if (build_id_cache__purge_path(pos->s)) {
+				if (build_id_cache__purge_path(pos->s, nsi)) {
 					if (errno == ENOENT) {
 						pr_debug("%s wasn't in the cache\n",
 							 pos->s);
@@ -405,7 +426,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 		list = strlist__new(update_name_list_str, NULL);
 		if (list) {
 			strlist__for_each_entry(pos, list)
-				if (build_id_cache__update_file(pos->s)) {
+				if (build_id_cache__update_file(pos->s, nsi)) {
 					if (errno == ENOENT) {
 						pr_debug("%s wasn't in the cache\n",
 							 pos->s);
@@ -424,6 +445,7 @@ int cmd_buildid_cache(int argc, const char **argv)
 
 out:
 	perf_session__delete(session);
+	nsinfo__zput(nsi);
 
 	return ret;
 }
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 3fb98d59cd27..c0065923a525 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -416,7 +416,7 @@ static int del_perf_probe_caches(struct strfilter *filter)
 	}
 
 	strlist__for_each_entry(nd, bidlist) {
-		cache = probe_cache__new(nd->s);
+		cache = probe_cache__new(nd->s, NULL);
 		if (!cache)
 			continue;
 		if (probe_cache__filter_purge(cache, filter) < 0 ||
diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 06eda675ae2c..5abe8cea54e6 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -33,7 +33,7 @@ static int build_id_cache__add_file(const char *filename)
 	}
 
 	build_id__sprintf(build_id, sizeof(build_id), sbuild_id);
-	err = build_id_cache__add_s(sbuild_id, filename, false, false);
+	err = build_id_cache__add_s(sbuild_id, filename, NULL, false, false);
 	if (err < 0)
 		pr_debug("Failed to add build id cache of %s\n", filename);
 	return err;
@@ -54,7 +54,7 @@ static char *get_self_path(void)
 static int search_cached_probe(const char *target,
 			       const char *group, const char *event)
 {
-	struct probe_cache *cache = probe_cache__new(target);
+	struct probe_cache *cache = probe_cache__new(target, NULL);
 	int ret = 0;
 
 	if (!cache) {
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index e0148b081bdf..f7bfd90a7388 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -534,13 +534,14 @@ char *build_id_cache__complement(const char *incomplete_sbuild_id)
 }
 
 char *build_id_cache__cachedir(const char *sbuild_id, const char *name,
-			       bool is_kallsyms, bool is_vdso)
+			       struct nsinfo *nsi, bool is_kallsyms,
+			       bool is_vdso)
 {
 	char *realname = (char *)name, *filename;
 	bool slash = is_kallsyms || is_vdso;
 
 	if (!slash) {
-		realname = realpath(name, NULL);
+		realname = nsinfo__realpath(name, nsi);
 		if (!realname)
 			return NULL;
 	}
@@ -556,13 +557,13 @@ char *build_id_cache__cachedir(const char *sbuild_id, const char *name,
 	return filename;
 }
 
-int build_id_cache__list_build_ids(const char *pathname,
+int build_id_cache__list_build_ids(const char *pathname, struct nsinfo *nsi,
 				   struct strlist **result)
 {
 	char *dir_name;
 	int ret = 0;
 
-	dir_name = build_id_cache__cachedir(NULL, pathname, false, false);
+	dir_name = build_id_cache__cachedir(NULL, pathname, nsi, false, false);
 	if (!dir_name)
 		return -ENOMEM;
 
@@ -576,16 +577,20 @@ int build_id_cache__list_build_ids(const char *pathname,
 
 #if defined(HAVE_LIBELF_SUPPORT) && defined(HAVE_GELF_GETNOTE_SUPPORT)
 static int build_id_cache__add_sdt_cache(const char *sbuild_id,
-					  const char *realname)
+					  const char *realname,
+					  struct nsinfo *nsi)
 {
 	struct probe_cache *cache;
 	int ret;
+	struct nscookie nsc;
 
-	cache = probe_cache__new(sbuild_id);
+	cache = probe_cache__new(sbuild_id, nsi);
 	if (!cache)
 		return -1;
 
+	nsinfo__mountns_enter(nsi, &nsc);
 	ret = probe_cache__scan_sdt(cache, realname);
+	nsinfo__mountns_exit(&nsc);
 	if (ret >= 0) {
 		pr_debug4("Found %d SDTs in %s\n", ret, realname);
 		if (probe_cache__commit(cache) < 0)
@@ -595,11 +600,11 @@ static int build_id_cache__add_sdt_cache(const char *sbuild_id,
 	return ret;
 }
 #else
-#define build_id_cache__add_sdt_cache(sbuild_id, realname) (0)
+#define build_id_cache__add_sdt_cache(sbuild_id, realname, nsi) (0)
 #endif
 
 int build_id_cache__add_s(const char *sbuild_id, const char *name,
-			  bool is_kallsyms, bool is_vdso)
+			  struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
 {
 	const size_t size = PATH_MAX;
 	char *realname = NULL, *filename = NULL, *dir_name = NULL,
@@ -607,13 +612,16 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 	int err = -1;
 
 	if (!is_kallsyms) {
-		realname = realpath(name, NULL);
+		if (!is_vdso)
+			realname = nsinfo__realpath(name, nsi);
+		else
+			realname = realpath(name, NULL);
 		if (!realname)
 			goto out_free;
 	}
 
-	dir_name = build_id_cache__cachedir(sbuild_id, name,
-					    is_kallsyms, is_vdso);
+	dir_name = build_id_cache__cachedir(sbuild_id, name, nsi, is_kallsyms,
+					    is_vdso);
 	if (!dir_name)
 		goto out_free;
 
@@ -634,7 +642,10 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 
 	if (access(filename, F_OK)) {
 		if (is_kallsyms) {
-			 if (copyfile("/proc/kallsyms", filename))
+			if (copyfile("/proc/kallsyms", filename))
+				goto out_free;
+		} else if (nsi && nsi->need_setns) {
+			if (copyfile_ns(name, filename, nsi))
 				goto out_free;
 		} else if (link(realname, filename) && errno != EEXIST &&
 				copyfile(name, filename))
@@ -657,7 +668,8 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 		err = 0;
 
 	/* Update SDT cache : error is just warned */
-	if (realname && build_id_cache__add_sdt_cache(sbuild_id, realname) < 0)
+	if (realname &&
+	    build_id_cache__add_sdt_cache(sbuild_id, realname, nsi) < 0)
 		pr_debug4("Failed to update/scan SDT cache for %s\n", realname);
 
 out_free:
@@ -670,14 +682,15 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 }
 
 static int build_id_cache__add_b(const u8 *build_id, size_t build_id_size,
-				 const char *name, bool is_kallsyms,
-				 bool is_vdso)
+				 const char *name, struct nsinfo *nsi,
+				 bool is_kallsyms, bool is_vdso)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
 	build_id__sprintf(build_id, build_id_size, sbuild_id);
 
-	return build_id_cache__add_s(sbuild_id, name, is_kallsyms, is_vdso);
+	return build_id_cache__add_s(sbuild_id, name, nsi, is_kallsyms,
+				     is_vdso);
 }
 
 bool build_id_cache__cached(const char *sbuild_id)
@@ -743,7 +756,7 @@ static int dso__cache_build_id(struct dso *dso, struct machine *machine)
 		name = nm;
 	}
 	return build_id_cache__add_b(dso->build_id, sizeof(dso->build_id), name,
-				     is_kallsyms, is_vdso);
+				     dso->nsinfo, is_kallsyms, is_vdso);
 }
 
 static int __dsos__cache_build_ids(struct list_head *head,
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 96690a55c62c..23970847d4c4 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -5,6 +5,7 @@
 #define SBUILD_ID_SIZE	(BUILD_ID_SIZE * 2 + 1)
 
 #include "tool.h"
+#include "namespaces.h"
 #include <linux/types.h>
 
 extern struct perf_tool build_id__mark_dso_hit_ops;
@@ -31,17 +32,19 @@ int perf_session__cache_build_ids(struct perf_session *session);
 char *build_id_cache__origname(const char *sbuild_id);
 char *build_id_cache__linkname(const char *sbuild_id, char *bf, size_t size);
 char *build_id_cache__cachedir(const char *sbuild_id, const char *name,
-			       bool is_kallsyms, bool is_vdso);
+			       struct nsinfo *nsi, bool is_kallsyms,
+			       bool is_vdso);
 
 struct strlist;
 
 struct strlist *build_id_cache__list_all(bool validonly);
 char *build_id_cache__complement(const char *incomplete_sbuild_id);
-int build_id_cache__list_build_ids(const char *pathname,
+int build_id_cache__list_build_ids(const char *pathname, struct nsinfo *nsi,
 				   struct strlist **result);
 bool build_id_cache__cached(const char *sbuild_id);
 int build_id_cache__add_s(const char *sbuild_id,
-			  const char *name, bool is_kallsyms, bool is_vdso);
+			  const char *name, struct nsinfo *nsi,
+			  bool is_kallsyms, bool is_vdso);
 int build_id_cache__remove_s(const char *sbuild_id);
 
 extern char buildid_dir[];
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index beda40ed63b0..dc9b49533a8f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -504,7 +504,14 @@ static void check_data_close(void);
  */
 static int open_dso(struct dso *dso, struct machine *machine)
 {
-	int fd = __open_dso(dso, machine);
+	int fd;
+	struct nscookie nsc;
+
+	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+		nsinfo__mountns_enter(dso->nsinfo, &nsc);
+	fd = __open_dso(dso, machine);
+	if (dso->binary_type != DSO_BINARY_TYPE__BUILD_ID_CACHE)
+		nsinfo__mountns_exit(&nsc);
 
 	if (fd >= 0) {
 		dso__list_add(dso);
@@ -1302,6 +1309,7 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 {
 	bool have_build_id = false;
 	struct dso *pos;
+	struct nscookie nsc;
 
 	list_for_each_entry(pos, head, node) {
 		if (with_hits && !pos->hit && !dso__is_vdso(pos))
@@ -1310,11 +1318,13 @@ bool __dsos__read_build_ids(struct list_head *head, bool with_hits)
 			have_build_id = true;
 			continue;
 		}
+		nsinfo__mountns_enter(pos->nsinfo, &nsc);
 		if (filename__read_build_id(pos->long_name, pos->build_id,
 					    sizeof(pos->build_id)) > 0) {
 			have_build_id	  = true;
 			pos->has_build_id = true;
 		}
+		nsinfo__mountns_exit(&nsc);
 	}
 
 	return have_build_id;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 01e779b91c8e..84e301073885 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2124,7 +2124,7 @@ void print_sdt_events(const char *subsys_glob, const char *event_glob,
 		return;
 	}
 	strlist__for_each_entry(nd, bidlist) {
-		pcache = probe_cache__new(nd->s);
+		pcache = probe_cache__new(nd->s, NULL);
 		if (!pcache)
 			continue;
 		list_for_each_entry(ent, &pcache->entries, node) {
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index a80895a7e611..d7cd1142f4c6 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2769,7 +2769,7 @@ static int __add_probe_trace_events(struct perf_probe_event *pev,
 	if (ret == -EINVAL && pev->uprobes)
 		warn_uprobe_event_compat(tev);
 	if (ret == 0 && probe_conf.cache) {
-		cache = probe_cache__new(pev->target);
+		cache = probe_cache__new(pev->target, pev->nsi);
 		if (!cache ||
 		    probe_cache__add_entry(cache, pev, tevs, ntevs) < 0 ||
 		    probe_cache__commit(cache) < 0)
@@ -3119,7 +3119,7 @@ static int find_cached_events(struct perf_probe_event *pev,
 	int ntevs = 0;
 	int ret = 0;
 
-	cache = probe_cache__new(target);
+	cache = probe_cache__new(target, pev->nsi);
 	/* Return 0 ("not found") if the target has no probe cache. */
 	if (!cache)
 		return 0;
@@ -3209,7 +3209,7 @@ static int find_probe_trace_events_from_cache(struct perf_probe_event *pev,
 		else
 			return find_cached_events(pev, tevs, pev->target);
 	}
-	cache = probe_cache__new(pev->target);
+	cache = probe_cache__new(pev->target, pev->nsi);
 	if (!cache)
 		return 0;
 
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index d679389e627c..cdf8d83a484c 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -412,13 +412,15 @@ int probe_cache_entry__get_event(struct probe_cache_entry *entry,
 }
 
 /* For the kernel probe caches, pass target = NULL or DSO__NAME_KALLSYMS */
-static int probe_cache__open(struct probe_cache *pcache, const char *target)
+static int probe_cache__open(struct probe_cache *pcache, const char *target,
+			     struct nsinfo *nsi)
 {
 	char cpath[PATH_MAX];
 	char sbuildid[SBUILD_ID_SIZE];
 	char *dir_name = NULL;
 	bool is_kallsyms = false;
 	int ret, fd;
+	struct nscookie nsc;
 
 	if (target && build_id_cache__cached(target)) {
 		/* This is a cached buildid */
@@ -431,8 +433,11 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target)
 		target = DSO__NAME_KALLSYMS;
 		is_kallsyms = true;
 		ret = sysfs__sprintf_build_id("/", sbuildid);
-	} else
+	} else {
+		nsinfo__mountns_enter(nsi, &nsc);
 		ret = filename__sprintf_build_id(target, sbuildid);
+		nsinfo__mountns_exit(&nsc);
+	}
 
 	if (ret < 0) {
 		pr_debug("Failed to get build-id from %s.\n", target);
@@ -441,7 +446,7 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target)
 
 	/* If we have no buildid cache, make it */
 	if (!build_id_cache__cached(sbuildid)) {
-		ret = build_id_cache__add_s(sbuildid, target,
+		ret = build_id_cache__add_s(sbuildid, target, nsi,
 					    is_kallsyms, NULL);
 		if (ret < 0) {
 			pr_debug("Failed to add build-id cache: %s\n", target);
@@ -449,7 +454,7 @@ static int probe_cache__open(struct probe_cache *pcache, const char *target)
 		}
 	}
 
-	dir_name = build_id_cache__cachedir(sbuildid, target, is_kallsyms,
+	dir_name = build_id_cache__cachedir(sbuildid, target, nsi, is_kallsyms,
 					    false);
 found:
 	if (!dir_name) {
@@ -554,7 +559,7 @@ void probe_cache__delete(struct probe_cache *pcache)
 	free(pcache);
 }
 
-struct probe_cache *probe_cache__new(const char *target)
+struct probe_cache *probe_cache__new(const char *target, struct nsinfo *nsi)
 {
 	struct probe_cache *pcache = probe_cache__alloc();
 	int ret;
@@ -562,7 +567,7 @@ struct probe_cache *probe_cache__new(const char *target)
 	if (!pcache)
 		return NULL;
 
-	ret = probe_cache__open(pcache, target);
+	ret = probe_cache__open(pcache, target, nsi);
 	if (ret < 0) {
 		pr_debug("Cache open error: %d\n", ret);
 		goto out_err;
@@ -974,7 +979,7 @@ int probe_cache__show_all_caches(struct strfilter *filter)
 		return -EINVAL;
 	}
 	strlist__for_each_entry(nd, bidlist) {
-		pcache = probe_cache__new(nd->s);
+		pcache = probe_cache__new(nd->s, NULL);
 		if (!pcache)
 			continue;
 		if (!list_empty(&pcache->entries)) {
diff --git a/tools/perf/util/probe-file.h b/tools/perf/util/probe-file.h
index 5ecc9d3925db..2ca4163abafe 100644
--- a/tools/perf/util/probe-file.h
+++ b/tools/perf/util/probe-file.h
@@ -51,7 +51,7 @@ int probe_file__del_strlist(int fd, struct strlist *namelist);
 int probe_cache_entry__get_event(struct probe_cache_entry *entry,
 				 struct probe_trace_event **tevs);
 
-struct probe_cache *probe_cache__new(const char *target);
+struct probe_cache *probe_cache__new(const char *target, struct nsinfo *nsi);
 int probe_cache__add_entry(struct probe_cache *pcache,
 			   struct perf_probe_event *pev,
 			   struct probe_trace_event *tevs, int ntevs);
@@ -69,7 +69,7 @@ int probe_cache__show_all_caches(struct strfilter *filter);
 bool probe_type_is_available(enum probe_type type);
 bool kretprobe_offset_is_supported(void);
 #else	/* ! HAVE_LIBELF_SUPPORT */
-static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused)
+static inline struct probe_cache *probe_cache__new(const char *tgt __maybe_unused, struct nsinfo *nsi __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 9f3b0d9754a8..e66dc495809a 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -10,6 +10,7 @@ util/ctype.c
 util/evlist.c
 util/evsel.c
 util/cpumap.c
+util/namespaces.c
 ../lib/bitmap.c
 ../lib/find_bit.c
 ../lib/hweight.c
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 21c97cc41cfc..8c7bae545617 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1464,7 +1464,6 @@ static int dso__find_perf_map(char *filebuf, size_t bufsz,
 	return rc;
 }
 
-
 int dso__load(struct dso *dso, struct map *map)
 {
 	char *name;
@@ -1565,6 +1564,8 @@ int dso__load(struct dso *dso, struct map *map)
 	for (i = 0; i < DSO_BINARY_TYPE__SYMTAB_CNT; i++) {
 		struct symsrc *ss = &ss_[ss_pos];
 		bool next_slot = false;
+		bool is_reg;
+		int sirc;
 
 		enum dso_binary_type symtab_type = binary_type_symtab[i];
 
@@ -1575,12 +1576,20 @@ int dso__load(struct dso *dso, struct map *map)
 						   root_dir, name, PATH_MAX))
 			continue;
 
-		if (!is_regular_file(name))
-			continue;
+		if (symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE)
+			nsinfo__mountns_exit(&nsc);
+
+		is_reg = is_regular_file(name);
+		sirc = symsrc__init(ss, dso, name, symtab_type);
 
-		/* Name is now the name of the next image to try */
-		if (symsrc__init(ss, dso, name, symtab_type) < 0)
+		if (symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE)
+			nsinfo__mountns_enter(dso->nsinfo, &nsc);
+
+		if (!is_reg || sirc < 0) {
+			if (sirc >= 0)
+				symsrc__destroy(ss);
 			continue;
+		}
 
 		if (!syms_ss && symsrc__has_symtab(ss)) {
 			syms_ss = ss;
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 988111e0bab5..9e4ea852f636 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -143,13 +143,17 @@ struct strlist *lsdir(const char *name,
 	return list;
 }
 
-static int slow_copyfile(const char *from, const char *to)
+static int slow_copyfile(const char *from, const char *to, struct nsinfo *nsi)
 {
 	int err = -1;
 	char *line = NULL;
 	size_t n;
-	FILE *from_fp = fopen(from, "r"), *to_fp;
+	FILE *from_fp, *to_fp;
+	struct nscookie nsc;
 
+	nsinfo__mountns_enter(nsi, &nsc);
+	from_fp = fopen(from, "r");
+	nsinfo__mountns_exit(&nsc);
 	if (from_fp == NULL)
 		goto out;
 
@@ -198,15 +202,21 @@ int copyfile_offset(int ifd, loff_t off_in, int ofd, loff_t off_out, u64 size)
 	return size ? -1 : 0;
 }
 
-int copyfile_mode(const char *from, const char *to, mode_t mode)
+static int copyfile_mode_ns(const char *from, const char *to, mode_t mode,
+			    struct nsinfo *nsi)
 {
 	int fromfd, tofd;
 	struct stat st;
-	int err = -1;
+	int err;
 	char *tmp = NULL, *ptr = NULL;
+	struct nscookie nsc;
 
-	if (stat(from, &st))
+	nsinfo__mountns_enter(nsi, &nsc);
+	err = stat(from, &st);
+	nsinfo__mountns_exit(&nsc);
+	if (err)
 		goto out;
+	err = -1;
 
 	/* extra 'x' at the end is to reserve space for '.' */
 	if (asprintf(&tmp, "%s.XXXXXXx", to) < 0) {
@@ -227,11 +237,13 @@ int copyfile_mode(const char *from, const char *to, mode_t mode)
 		goto out_close_to;
 
 	if (st.st_size == 0) { /* /proc? do it slowly... */
-		err = slow_copyfile(from, tmp);
+		err = slow_copyfile(from, tmp, nsi);
 		goto out_close_to;
 	}
 
+	nsinfo__mountns_enter(nsi, &nsc);
 	fromfd = open(from, O_RDONLY);
+	nsinfo__mountns_exit(&nsc);
 	if (fromfd < 0)
 		goto out_close_to;
 
@@ -248,6 +260,16 @@ int copyfile_mode(const char *from, const char *to, mode_t mode)
 	return err;
 }
 
+int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi)
+{
+	return copyfile_mode_ns(from, to, 0755, nsi);
+}
+
+int copyfile_mode(const char *from, const char *to, mode_t mode)
+{
+	return copyfile_mode_ns(from, to, mode, NULL);
+}
+
 int copyfile(const char *from, const char *to)
 {
 	return copyfile_mode(from, to, 0755);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 1e5fe1d9ec32..062dd20437f7 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -12,6 +12,7 @@
 #include <stdarg.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include "namespaces.h"
 
 /* General helper functions */
 void usage(const char *err) __noreturn;
@@ -33,6 +34,7 @@ struct strlist *lsdir(const char *name, bool (*filter)(const char *, struct dire
 bool lsdir_no_dot_filter(const char *name, struct dirent *d);
 int copyfile(const char *from, const char *to);
 int copyfile_mode(const char *from, const char *to, mode_t mode);
+int copyfile_ns(const char *from, const char *to, struct nsinfo *nsi);
 int copyfile_offset(int fromfd, loff_t from_ofs, int tofd, loff_t to_ofs, u64 size);
 
 ssize_t readn(int fd, void *buf, size_t n);
-- 
2.9.4
