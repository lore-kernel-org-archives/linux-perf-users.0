Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478261B1417;
	Fri, 16 Aug 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805927; cv=none; b=sQ/hP6YNJqXcqHhILTdAnW5hW6bzHcVRiE3UJTxll+zo+0PFCwQ0Hq5+Wn96VslY+mPuS6fvRmPksaK9D8xl+bFKILH4RHcFOP8tLskqmYabr0CNt7Mg2aLNdQmQKmPjM1nXXnErwwpFlDWuapeKgk1OMTFj1PtgfUK3nGYCv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805927; c=relaxed/simple;
	bh=Unwa8PWdSt7NQ3kAJRMtIfYRWFj1X0rFsL/N3Zn++4g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6WO69wPku6N3KfeI8kTDmGWCklsKKCY6ewraqWzn3GXPAqVHTfV6T8wA63sGJTsJe+veZvnpxHFSmkLD1Tm/E9m8U8xjgvg1iBjhUpK0GfnCczd5IEQDG/Pl01n/mg5u/BoHjx7N4Tr+1l39onnrVthQKzp2nve67X17mmKU9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wlf9G6M4lz1T7Vy;
	Fri, 16 Aug 2024 18:58:10 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 42D9F180100;
	Fri, 16 Aug 2024 18:58:43 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 16 Aug 2024 18:58:41 +0800
From: Changbin Du <changbin.du@huawei.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
	<namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Ian
 Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, "Liang,
 Kan" <kan.liang@linux.intel.com>, Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>, Hui Wang <hw.huiwang@huawei.com>, Changbin Du
	<changbin.du@huawei.com>
Subject: [PATCH v6 6/8] perf: build-id: extend build_id_cache__find_debug() to find local debugging vdso
Date: Fri, 16 Aug 2024 18:58:09 +0800
Message-ID: <20240816105811.1812897-7-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240816105811.1812897-1-changbin.du@huawei.com>
References: <20240816105811.1812897-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100011.china.huawei.com (7.221.188.204)

Just like vmlinux, try to search vdso in predefined paths when collecting
build-ids. The searched paths usually have debugging info.

For example, the vdso can be found in
/lib/modules/<version>/build/arch/x86/entry/vdso/vdso*.so.dbg for local
build on x86.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>

---
v3:
  - continue to try build_id_cache__find_debug_normal() if
    build_id_cache__find_debug_vdso() failed.
v2:
  - Searching the vdso in record stage instead of report. So the debugging
    vdso will be in build-id cache. This is friendly for cross-machine
    analysis.
---
 tools/perf/util/build-id.c | 48 ++++++++++++++++++++++++++++++++++----
 tools/perf/util/symbol.c   | 17 ++++++++++++++
 tools/perf/util/symbol.h   |  1 +
 3 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 5bda47de5cf2..67f88b492279 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -593,9 +593,8 @@ static int build_id_cache__add_sdt_cache(const char *sbuild_id,
 #define build_id_cache__add_sdt_cache(sbuild_id, realname, nsi) (0)
 #endif
 
-static char *build_id_cache__find_debug(const char *sbuild_id,
-					struct nsinfo *nsi,
-					const char *root_dir)
+static char *build_id_cache__find_debug_normal(const char *sbuild_id,
+				struct nsinfo *nsi, const char *root_dir)
 {
 	const char *dirname = "/usr/lib/debug/.build-id/";
 	char *realname = NULL;
@@ -646,6 +645,47 @@ static char *build_id_cache__find_debug(const char *sbuild_id,
 	return realname;
 }
 
+static char *build_id_cache__find_debug_vdso(const char *sbuild_id)
+{
+	char sbuild_id_tmp[SBUILD_ID_SIZE];
+	struct build_id bid;
+	int i, ret = 0;
+
+	if (!vdso_paths.paths)
+		return NULL;
+
+	pr_debug("Looking at the vdso_path (%d entries long)\n",
+		 vdso_paths.nr_entries + 1);
+
+	for (i = 0; i < vdso_paths.nr_entries; ++i) {
+		ret = filename__read_build_id(vdso_paths.paths[i], &bid);
+		if (ret < 0)
+			continue;
+
+		build_id__sprintf(&bid, sbuild_id_tmp);
+		if (!strcmp(sbuild_id, sbuild_id_tmp)) {
+			pr_debug("Found debugging vdso %s\n", vdso_paths.paths[i]);
+			return strdup(vdso_paths.paths[i]);
+		}
+	}
+
+	return NULL;
+}
+
+static char *build_id_cache__find_debug(const char *sbuild_id,
+					struct nsinfo *nsi,
+					bool is_vdso,
+					const char *root_dir)
+{
+	char *name = NULL;
+
+	if (is_vdso)
+		name = build_id_cache__find_debug_vdso(sbuild_id);
+	if (!name)
+		name = build_id_cache__find_debug_normal(sbuild_id, nsi, root_dir);
+	return name;
+}
+
 int
 build_id_cache__add(const char *sbuild_id, const char *name, const char *realname,
 		    struct nsinfo *nsi, bool is_kallsyms, bool is_vdso,
@@ -702,7 +742,7 @@ build_id_cache__add(const char *sbuild_id, const char *name, const char *realnam
 	 * symtab.
 	 */
 	if (!is_kallsyms && strncmp(".ko", name + strlen(name) - 3, 3)) {
-		debugfile = build_id_cache__find_debug(sbuild_id, nsi, root_dir);
+		debugfile = build_id_cache__find_debug(sbuild_id, nsi, is_vdso, root_dir);
 		if (debugfile) {
 			zfree(&filename);
 			if (asprintf(&filename, "%s/%s", dir_name,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 6bf75c98e1f2..8e982e68b717 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -49,6 +49,7 @@ static int dso__load_vdso_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
 
 struct dso_filename_paths vmlinux_paths;
+struct dso_filename_paths vdso_paths;
 
 struct symbol_conf symbol_conf = {
 	.nanosecs		= false,
@@ -2303,6 +2304,16 @@ struct dso_filename_pattern vmlinux_patterns[] = {
 	{"/usr/lib/debug/boot/vmlinux-%s.debug", 1},
 };
 
+struct dso_filename_pattern vdso_patterns[] = {
+	{"/lib/modules/%s/vdso/vdso.so", 1},
+	{"/lib/modules/%s/vdso/vdso64.so", 1},
+	{"/lib/modules/%s/vdso/vdso32.so", 1},
+	{"/lib/modules/%s/build/arch/%s/vdso/vdso.so.dbg", 2},
+	{"/lib/modules/%s/build/arch/%s/kernel/vdso/vdso.so.dbg", 2},
+	{"/lib/modules/%s/build/arch/%s/entry/vdso/vdso32.so.dbg", 2},
+	{"/lib/modules/%s/build/arch/%s/entry/vdso/vdso64.so.dbg", 2},
+};
+
 static int dso_filename_path__add(struct dso_filename_paths *paths, const char *new_entry)
 {
 	paths->paths[paths->nr_entries] = strdup(new_entry);
@@ -2565,6 +2576,11 @@ int symbol__init(struct perf_env *env)
 		return -1;
 	}
 
+	if (dso_filename_path__init(&vdso_paths, vdso_patterns,
+				    ARRAY_SIZE(vdso_patterns), env) < 0) {
+		return -1;
+	}
+
 	if (symbol_conf.field_sep && *symbol_conf.field_sep == '.') {
 		pr_err("'.' is the only non valid --field-separator argument\n");
 		return -1;
@@ -2641,6 +2657,7 @@ void symbol__exit(void)
 	intlist__delete(symbol_conf.pid_list);
 	intlist__delete(symbol_conf.addr_list);
 	dso_filename_path__exit(&vmlinux_paths);
+	dso_filename_path__exit(&vdso_paths);
 	symbol_conf.sym_list = symbol_conf.dso_list = symbol_conf.comm_list = NULL;
 	symbol_conf.bt_stop_list = NULL;
 	symbol_conf.initialized = false;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 30056884945b..08c339594d4e 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -107,6 +107,7 @@ struct dso_filename_paths {
 };
 
 extern struct dso_filename_paths vmlinux_paths;
+extern struct dso_filename_paths vdso_paths;
 
 static inline void *symbol__priv(struct symbol *sym)
 {
-- 
2.34.1

