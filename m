From: David Ahern <daahern@cisco.com>
Subject: [PATCH] perf tools: Add symfs option for off-box analysis using specified tree
Date: Mon, 22 Nov 2010 07:45:58 -0700
Message-ID: <1290437158-5954-1-git-send-email-daahern@cisco.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from sj-iport-6.cisco.com ([171.71.176.117]:44186 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587Ab0KVOqH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 22 Nov 2010 09:46:07 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: David Ahern <daahern@cisco.com>

The symfs argument allows analysis of perf.data file using a locally
accessible filesystem tree with debug symbols - e.g., loop mounted
KVM disk images, NFS, USB keys, initrds, etc. Anything with an OS tree
can be analyzed from anywhere without the need to populate a local
data store with build-ids.

Signed-off-by: David Ahern <daahern@cisco.com>
---
 tools/perf/builtin-annotate.c  |   16 +++++--
 tools/perf/builtin-diff.c      |    2 +
 tools/perf/builtin-report.c    |    2 +
 tools/perf/builtin-timechart.c |    2 +
 tools/perf/util/hist.c         |   14 +++++-
 tools/perf/util/symbol.c       |   82 +++++++++++++++++++++++++---------------
 tools/perf/util/symbol.h       |    1 +
 7 files changed, 80 insertions(+), 39 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6d5604d8d..1db38da 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -280,7 +280,8 @@ static int hist_entry__tty_annotate(struct hist_entry *he)
 	struct map *map = he->ms.map;
 	struct dso *dso = map->dso;
 	struct symbol *sym = he->ms.sym;
-	const char *filename = dso->long_name, *d_filename;
+	const char *filename = dso->long_name;
+	char d_filename[PATH_MAX];
 	u64 len;
 	LIST_HEAD(head);
 	struct objdump_line *pos, *n;
@@ -288,10 +289,13 @@ static int hist_entry__tty_annotate(struct hist_entry *he)
 	if (hist_entry__annotate(he, &head, 0) < 0)
 		return -1;
 
-	if (full_paths)
-		d_filename = filename;
-	else
-		d_filename = basename(filename);
+	if (full_paths) {
+		snprintf(d_filename, sizeof(d_filename), "%s%s",
+			 symbol_conf.symfs, filename);
+	} else {
+		snprintf(d_filename, sizeof(d_filename), "%s/%s",
+			 symbol_conf.symfs, basename(filename));
+	}
 
 	len = sym->end - sym->start;
 
@@ -437,6 +441,8 @@ static const struct option options[] = {
 		    "print matching source lines (may be slow)"),
 	OPT_BOOLEAN('P', "full-paths", &full_paths,
 		    "Don't shorten the displayed pathnames"),
+	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
+		    "Look for files with symbols relative to this directory"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index fca1d44..85a8179 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -191,6 +191,8 @@ static const struct option options[] = {
 	OPT_STRING('t', "field-separator", &symbol_conf.field_sep, "separator",
 		   "separator for columns, no spaces will be added between "
 		   "columns '.' is reserved."),
+	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
+		    "Look for files with symbols relative to this directory"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 5de405d..9d552da 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -478,6 +478,8 @@ static const struct option options[] = {
 		   "columns '.' is reserved."),
 	OPT_BOOLEAN('U', "hide-unresolved", &hide_unresolved,
 		    "Only display entries resolved to a symbol"),
+	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
+		    "Look for files with symbols relative to this directory"),
 	OPT_END()
 };
 
diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
index 9bcc38f..fa07ece 100644
--- a/tools/perf/builtin-timechart.c
+++ b/tools/perf/builtin-timechart.c
@@ -1018,6 +1018,8 @@ static const struct option options[] = {
 	OPT_CALLBACK('p', "process", NULL, "process",
 		      "process selector. Pass a pid or process name.",
 		       parse_process),
+	OPT_STRING(0, "symfs", &symbol_conf.symfs, "directory",
+		    "Look for files with symbols relative to this directory"),
 	OPT_END()
 };
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 2022e87..b24ae53 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -1092,6 +1092,12 @@ int hist_entry__annotate(struct hist_entry *self, struct list_head *head,
 	FILE *file;
 	int err = 0;
 	u64 len;
+	char symfs_filename[PATH_MAX];
+
+	if (filename) {
+		snprintf(symfs_filename, sizeof(symfs_filename), "%s%s",
+		 symbol_conf.symfs, filename);
+	}
 
 	if (filename == NULL) {
 		if (dso->has_build_id) {
@@ -1100,9 +1106,9 @@ int hist_entry__annotate(struct hist_entry *self, struct list_head *head,
 			return -ENOMEM;
 		}
 		goto fallback;
-	} else if (readlink(filename, command, sizeof(command)) < 0 ||
+	} else if (readlink(symfs_filename, command, sizeof(command)) < 0 ||
 		   strstr(command, "[kernel.kallsyms]") ||
-		   access(filename, R_OK)) {
+		   access(symfs_filename, R_OK)) {
 		free(filename);
 fallback:
 		/*
@@ -1111,6 +1117,8 @@ fallback:
 		 * DSO is the same as when 'perf record' ran.
 		 */
 		filename = dso->long_name;
+		snprintf(symfs_filename, sizeof(symfs_filename), "%s%s",
+		 symbol_conf.symfs, filename);
 		free_filename = false;
 	}
 
@@ -1137,7 +1145,7 @@ fallback:
 		 "objdump --start-address=0x%016Lx --stop-address=0x%016Lx -dS -C %s|grep -v %s|expand",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
-		 filename, filename);
+		 symfs_filename, filename);
 
 	pr_debug("Executing: %s\n", command);
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 861be8b..3503f1c 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -41,6 +41,7 @@ struct symbol_conf symbol_conf = {
 	.exclude_other	  = true,
 	.use_modules	  = true,
 	.try_vmlinux_path = true,
+	.symfs           = "",
 };
 
 int dso__name_len(const struct dso *self)
@@ -831,8 +832,11 @@ static int dso__synthesize_plt_symbols(struct  dso *self, struct map *map,
 	char sympltname[1024];
 	Elf *elf;
 	int nr = 0, symidx, fd, err = 0;
+	char name[PATH_MAX];
 
-	fd = open(self->long_name, O_RDONLY);
+	snprintf(name, sizeof(name), "%s%s",
+		 symbol_conf.symfs, self->long_name);
+	fd = open(name, O_RDONLY);
 	if (fd < 0)
 		goto out;
 
@@ -1444,16 +1448,19 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 	     self->origin++) {
 		switch (self->origin) {
 		case DSO__ORIG_BUILD_ID_CACHE:
-			if (dso__build_id_filename(self, name, size) == NULL)
+			/* skip the locally configured cache if a symfs is given */
+			if ((strlen(symbol_conf.symfs) != 0) ||
+			    (dso__build_id_filename(self, name, size) == NULL)) {
 				continue;
+			}
 			break;
 		case DSO__ORIG_FEDORA:
-			snprintf(name, size, "/usr/lib/debug%s.debug",
-				 self->long_name);
+			snprintf(name, size, "%s/usr/lib/debug%s.debug",
+				 symbol_conf.symfs, self->long_name);
 			break;
 		case DSO__ORIG_UBUNTU:
-			snprintf(name, size, "/usr/lib/debug%s",
-				 self->long_name);
+			snprintf(name, size, "%s/usr/lib/debug%s",
+				 symbol_conf.symfs, self->long_name);
 			break;
 		case DSO__ORIG_BUILDID: {
 			char build_id_hex[BUILD_ID_SIZE * 2 + 1];
@@ -1465,12 +1472,13 @@ int dso__load(struct dso *self, struct map *map, symbol_filter_t filter)
 					  sizeof(self->build_id),
 					  build_id_hex);
 			snprintf(name, size,
-				 "/usr/lib/debug/.build-id/%.2s/%s.debug",
-				 build_id_hex, build_id_hex + 2);
+				 "%s/usr/lib/debug/.build-id/%.2s/%s.debug",
+				 symbol_conf.symfs, build_id_hex, build_id_hex + 2);
 			}
 			break;
 		case DSO__ORIG_DSO:
-			snprintf(name, size, "%s", self->long_name);
+			snprintf(name, size, "%s%s",
+			     symbol_conf.symfs, self->long_name);
 			break;
 		case DSO__ORIG_GUEST_KMODULE:
 			if (!map->groups || !map->groups->machine)
@@ -1776,17 +1784,20 @@ static int dso__load_vmlinux(struct dso *self, struct map *map,
 			     const char *vmlinux, symbol_filter_t filter)
 {
 	int err = -1, fd;
+	char symfs_vmlinux[PATH_MAX];
 
-	fd = open(vmlinux, O_RDONLY);
+	snprintf(symfs_vmlinux, sizeof(symfs_vmlinux), "%s/%s",
+		 symbol_conf.symfs, vmlinux);
+	fd = open(symfs_vmlinux, O_RDONLY);
 	if (fd < 0)
 		return -1;
 
 	dso__set_loaded(self, map->type);
-	err = dso__load_sym(self, map, vmlinux, fd, filter, 0, 0);
+	err = dso__load_sym(self, map, symfs_vmlinux, fd, filter, 0, 0);
 	close(fd);
 
 	if (err > 0)
-		pr_debug("Using %s for symbols\n", vmlinux);
+		pr_debug("Using %s for symbols\n", symfs_vmlinux);
 
 	return err;
 }
@@ -1859,6 +1870,10 @@ static int dso__load_kernel_sym(struct dso *self, struct map *map,
 			goto out_fixup;
 	}
 
+	/* do not try local files if a symfs was given */
+	if (strlen(symbol_conf.symfs) != 0)
+		return -1;
+
 	/*
 	 * Say the kernel DSO was created when processing the build-id header table,
 	 * we have a build-id, so check if it is the same as the running kernel,
@@ -2208,9 +2223,6 @@ static int vmlinux_path__init(void)
 	struct utsname uts;
 	char bf[PATH_MAX];
 
-	if (uname(&uts) < 0)
-		return -1;
-
 	vmlinux_path = malloc(sizeof(char *) * 5);
 	if (vmlinux_path == NULL)
 		return -1;
@@ -2223,22 +2235,30 @@ static int vmlinux_path__init(void)
 	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
 		goto out_fail;
 	++vmlinux_path__nr_entries;
-	snprintf(bf, sizeof(bf), "/boot/vmlinux-%s", uts.release);
-	vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
-	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
-		goto out_fail;
-	++vmlinux_path__nr_entries;
-	snprintf(bf, sizeof(bf), "/lib/modules/%s/build/vmlinux", uts.release);
-	vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
-	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
-		goto out_fail;
-	++vmlinux_path__nr_entries;
-	snprintf(bf, sizeof(bf), "/usr/lib/debug/lib/modules/%s/vmlinux",
-		 uts.release);
-	vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
-	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
-		goto out_fail;
-	++vmlinux_path__nr_entries;
+
+	/* if no symfs has been given try running kernel version too */
+	if (strlen(symbol_conf.symfs) == 0) {
+		if (uname(&uts) < 0)
+			return -1;
+
+		snprintf(bf, sizeof(bf), "/boot/vmlinux-%s", uts.release);
+		vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
+		if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
+			goto out_fail;
+		++vmlinux_path__nr_entries;
+		snprintf(bf, sizeof(bf), "/lib/modules/%s/build/vmlinux",
+			 uts.release);
+		vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
+		if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
+			goto out_fail;
+		++vmlinux_path__nr_entries;
+		snprintf(bf, sizeof(bf), "/usr/lib/debug/lib/modules/%s/vmlinux",
+			 uts.release);
+		vmlinux_path[vmlinux_path__nr_entries] = strdup(bf);
+		if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
+			goto out_fail;
+		++vmlinux_path__nr_entries;
+	}
 
 	return 0;
 
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 038f220..bbe90d1 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -85,6 +85,7 @@ struct symbol_conf {
        struct strlist	*dso_list,
 			*comm_list,
 			*sym_list;
+	const char	*symfs;
 };
 
 extern struct symbol_conf symbol_conf;
-- 
1.7.2.3
