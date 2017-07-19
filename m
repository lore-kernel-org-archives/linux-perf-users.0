From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/86] perf buildid-cache: Cache debuginfo
Date: Wed, 19 Jul 2017 11:29:02 -0300
Message-ID: <20170719142950.3747-39-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Krister Johansen <kjlx@templeofstupid.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Krister Johansen <kjlx@templeofstupid.com>

If a stripped binary is placed in the cache, the user is in a situation
where there's a cached elf file present, but it doesn't have any symtab
to use for name resolution.  Grab the debuginfo for binaries that don't
end in .ko.  This yields a better chance of resolving symbols from older
traces.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/1499305693-1599-7-git-send-email-kjlx@templeofstupid.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-buildid-cache.c |  2 +-
 tools/perf/util/annotate.c         |  2 +-
 tools/perf/util/build-id.c         | 72 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/build-id.h         |  3 +-
 tools/perf/util/dso.c              |  8 ++++-
 tools/perf/util/dso.h              |  1 +
 tools/perf/util/machine.c          |  3 +-
 tools/perf/util/symbol.c           | 12 +++++--
 8 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index d65bd86bee99..e3eb6240ced0 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -243,7 +243,7 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	char filename[PATH_MAX];
 	u8 build_id[BUILD_ID_SIZE];
 
-	if (dso__build_id_filename(dso, filename, sizeof(filename)) &&
+	if (dso__build_id_filename(dso, filename, sizeof(filename), false) &&
 	    filename__read_build_id(filename, build_id,
 				    sizeof(build_id)) != sizeof(build_id)) {
 		if (errno == ENOENT)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ef434b53d849..1742510f0120 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1347,7 +1347,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 	    !dso__is_kcore(dso))
 		return SYMBOL_ANNOTATE_ERRNO__NO_VMLINUX;
 
-	build_id_filename = dso__build_id_filename(dso, NULL, 0);
+	build_id_filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (build_id_filename) {
 		__symbol__join_symfs(filename, filename_size, build_id_filename);
 		free(build_id_filename);
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index f7bfd90a7388..e9665150e9b1 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -243,12 +243,15 @@ static bool build_id_cache__valid_id(char *sbuild_id)
 	return result;
 }
 
-static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso)
+static const char *build_id_cache__basename(bool is_kallsyms, bool is_vdso,
+					    bool is_debug)
 {
-	return is_kallsyms ? "kallsyms" : (is_vdso ? "vdso" : "elf");
+	return is_kallsyms ? "kallsyms" : (is_vdso ? "vdso" : (is_debug ?
+	    "debug" : "elf"));
 }
 
-char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size)
+char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
+			     bool is_debug)
 {
 	bool is_kallsyms = dso__is_kallsyms((struct dso *)dso);
 	bool is_vdso = dso__is_vdso((struct dso *)dso);
@@ -270,7 +273,8 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size)
 		ret = asnprintf(&bf, size, "%s", linkname);
 	else
 		ret = asnprintf(&bf, size, "%s/%s", linkname,
-			 build_id_cache__basename(is_kallsyms, is_vdso));
+			 build_id_cache__basename(is_kallsyms, is_vdso,
+						  is_debug));
 	if (ret < 0 || (!alloc && size < (unsigned int)ret))
 		bf = NULL;
 	free(linkname);
@@ -603,12 +607,40 @@ static int build_id_cache__add_sdt_cache(const char *sbuild_id,
 #define build_id_cache__add_sdt_cache(sbuild_id, realname, nsi) (0)
 #endif
 
+static char *build_id_cache__find_debug(const char *sbuild_id,
+					struct nsinfo *nsi)
+{
+	char *realname = NULL;
+	char *debugfile;
+	struct nscookie nsc;
+	size_t len = 0;
+
+	debugfile = calloc(1, PATH_MAX);
+	if (!debugfile)
+		goto out;
+
+	len = __symbol__join_symfs(debugfile, PATH_MAX,
+				   "/usr/lib/debug/.build-id/");
+	snprintf(debugfile + len, PATH_MAX - len, "%.2s/%s.debug", sbuild_id,
+		 sbuild_id + 2);
+
+	nsinfo__mountns_enter(nsi, &nsc);
+	realname = realpath(debugfile, NULL);
+	if (realname && access(realname, R_OK))
+		zfree(&realname);
+	nsinfo__mountns_exit(&nsc);
+out:
+	free(debugfile);
+	return realname;
+}
+
 int build_id_cache__add_s(const char *sbuild_id, const char *name,
 			  struct nsinfo *nsi, bool is_kallsyms, bool is_vdso)
 {
 	const size_t size = PATH_MAX;
 	char *realname = NULL, *filename = NULL, *dir_name = NULL,
 	     *linkname = zalloc(size), *tmp;
+	char *debugfile = NULL;
 	int err = -1;
 
 	if (!is_kallsyms) {
@@ -635,7 +667,8 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 
 	/* Save the allocated buildid dirname */
 	if (asprintf(&filename, "%s/%s", dir_name,
-		     build_id_cache__basename(is_kallsyms, is_vdso)) < 0) {
+		     build_id_cache__basename(is_kallsyms, is_vdso,
+		     false)) < 0) {
 		filename = NULL;
 		goto out_free;
 	}
@@ -652,6 +685,34 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 			goto out_free;
 	}
 
+	/* Some binaries are stripped, but have .debug files with their symbol
+	 * table.  Check to see if we can locate one of those, since the elf
+	 * file itself may not be very useful to users of our tools without a
+	 * symtab.
+	 */
+	if (!is_kallsyms && !is_vdso &&
+	    strncmp(".ko", name + strlen(name) - 3, 3)) {
+		debugfile = build_id_cache__find_debug(sbuild_id, nsi);
+		if (debugfile) {
+			zfree(&filename);
+			if (asprintf(&filename, "%s/%s", dir_name,
+			    build_id_cache__basename(false, false, true)) < 0) {
+				filename = NULL;
+				goto out_free;
+			}
+			if (access(filename, F_OK)) {
+				if (nsi && nsi->need_setns) {
+					if (copyfile_ns(debugfile, filename,
+							nsi))
+						goto out_free;
+				} else if (link(debugfile, filename) &&
+						errno != EEXIST &&
+						copyfile(debugfile, filename))
+					goto out_free;
+			}
+		}
+	}
+
 	if (!build_id_cache__linkname(sbuild_id, linkname, size))
 		goto out_free;
 	tmp = strrchr(linkname, '/');
@@ -676,6 +737,7 @@ int build_id_cache__add_s(const char *sbuild_id, const char *name,
 	if (!is_kallsyms)
 		free(realname);
 	free(filename);
+	free(debugfile);
 	free(dir_name);
 	free(linkname);
 	return err;
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index 23970847d4c4..113dc0615c57 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -17,7 +17,8 @@ int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
 char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
 				    size_t size);
 
-char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size);
+char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
+			     bool is_debug);
 
 int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
 			   struct perf_sample *sample, struct perf_evsel *evsel,
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index dc9b49533a8f..b9e087fb8247 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -32,6 +32,7 @@ char dso__symtab_origin(const struct dso *dso)
 		[DSO_BINARY_TYPE__JAVA_JIT]			= 'j',
 		[DSO_BINARY_TYPE__DEBUGLINK]			= 'l',
 		[DSO_BINARY_TYPE__BUILD_ID_CACHE]		= 'B',
+		[DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO]	= 'D',
 		[DSO_BINARY_TYPE__FEDORA_DEBUGINFO]		= 'f',
 		[DSO_BINARY_TYPE__UBUNTU_DEBUGINFO]		= 'u',
 		[DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO]	= 'o',
@@ -97,7 +98,12 @@ int dso__read_binary_type_filename(const struct dso *dso,
 		break;
 	}
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
-		if (dso__build_id_filename(dso, filename, size) == NULL)
+		if (dso__build_id_filename(dso, filename, size, false) == NULL)
+			ret = -1;
+		break;
+
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+		if (dso__build_id_filename(dso, filename, size, true) == NULL)
 			ret = -1;
 		break;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 78ec637fc68b..f886141678eb 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -21,6 +21,7 @@ enum dso_binary_type {
 	DSO_BINARY_TYPE__JAVA_JIT,
 	DSO_BINARY_TYPE__DEBUGLINK,
 	DSO_BINARY_TYPE__BUILD_ID_CACHE,
+	DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
 	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 246b441110a1..a54a2be5eda4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -705,7 +705,8 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 
 	if (kdso->has_build_id) {
 		char filename[PATH_MAX];
-		if (dso__build_id_filename(kdso, filename, sizeof(filename)))
+		if (dso__build_id_filename(kdso, filename, sizeof(filename),
+					   false))
 			printed += fprintf(fp, "[0] %s\n", filename);
 	}
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 8c7bae545617..971b990557b4 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -53,6 +53,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 	DSO_BINARY_TYPE__JAVA_JIT,
 	DSO_BINARY_TYPE__DEBUGLINK,
 	DSO_BINARY_TYPE__BUILD_ID_CACHE,
+	DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO,
 	DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
 	DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
 	DSO_BINARY_TYPE__BUILDID_DEBUGINFO,
@@ -1418,6 +1419,7 @@ static bool dso__is_compatible_symtab_type(struct dso *dso, bool kmod,
 		return kmod && dso->symtab_type == type;
 
 	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
 		return true;
 
 	case DSO_BINARY_TYPE__NOT_FOUND:
@@ -1565,10 +1567,14 @@ int dso__load(struct dso *dso, struct map *map)
 		struct symsrc *ss = &ss_[ss_pos];
 		bool next_slot = false;
 		bool is_reg;
+		bool nsexit;
 		int sirc;
 
 		enum dso_binary_type symtab_type = binary_type_symtab[i];
 
+		nsexit = (symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE ||
+		    symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO);
+
 		if (!dso__is_compatible_symtab_type(dso, kmod, symtab_type))
 			continue;
 
@@ -1576,13 +1582,13 @@ int dso__load(struct dso *dso, struct map *map)
 						   root_dir, name, PATH_MAX))
 			continue;
 
-		if (symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE)
+		if (nsexit)
 			nsinfo__mountns_exit(&nsc);
 
 		is_reg = is_regular_file(name);
 		sirc = symsrc__init(ss, dso, name, symtab_type);
 
-		if (symtab_type == DSO_BINARY_TYPE__BUILD_ID_CACHE)
+		if (nsexit)
 			nsinfo__mountns_enter(dso->nsinfo, &nsc);
 
 		if (!is_reg || sirc < 0) {
@@ -1724,7 +1730,7 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map)
 	}
 
 	if (!symbol_conf.ignore_vmlinux_buildid)
-		filename = dso__build_id_filename(dso, NULL, 0);
+		filename = dso__build_id_filename(dso, NULL, 0, false);
 	if (filename != NULL) {
 		err = dso__load_vmlinux(dso, map, filename, true);
 		if (err > 0)
-- 
2.9.4
