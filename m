Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F00198A33;
	Fri, 16 Aug 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723805925; cv=none; b=TWtvkVlFq125Hv5FYIO1rm/wp+Tz9bL6oZ6eu+y94ALfTXiWesINUhqe/1uSRi9j170ElxhNDaSl9q6bjSXTsn2vo4+ZHBmKqAYMC2rxcRJtoUYcd9ofC5SmNu+/YgTkFL0KJmYt6AzBFCe2IUhTO5LHZVYpypw0nouJ9Y5aFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723805925; c=relaxed/simple;
	bh=lA8sWheSHSHoYVlwjTpOll49BLvcZs4jAVi8F76x7Ko=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9n6ic7Q9Ae57Hbrft2aMFqbJDhA2SJcFLS1fEkj065zKZ/PooSxiXP5aUvnPogqqdqXG6DcZlhZcwnTQGROp1pL3x4rQCK6wuF2z2I4+8ScZKxx/BW5+2/oLny+tMgkkXvlPzHZGBhtNAjG6izZsWx6tawfFrsPZhy330lTnS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wlf9D107Tz1T7Vq;
	Fri, 16 Aug 2024 18:58:08 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EC5C180100;
	Fri, 16 Aug 2024 18:58:40 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 16 Aug 2024 18:58:38 +0800
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
Subject: [PATCH v6 4/8] perf: symbol: generalize vmlinux path searching
Date: Fri, 16 Aug 2024 18:58:07 +0800
Message-ID: <20240816105811.1812897-5-changbin.du@huawei.com>
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

This generalizes the vmlinux path searching logic. Later we will add
another instance for vdso.

The search pattern is described by struct dso_filename_pattern, and the
formatted paths are hold in struct dso_filename_paths.

Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/util/machine.c |   4 +-
 tools/perf/util/symbol.c  | 112 +++++++++++++++++++++-----------------
 tools/perf/util/symbol.h  |   8 ++-
 3 files changed, 70 insertions(+), 54 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 8477edefc299..68315520f15b 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -896,9 +896,9 @@ size_t machine__fprintf_vmlinux_path(struct machine *machine, FILE *fp)
 			printed += fprintf(fp, "[0] %s\n", filename);
 	}
 
-	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
+	for (i = 0; i < vmlinux_paths.nr_entries; ++i) {
 		printed += fprintf(fp, "[%d] %s\n", i + dso__has_build_id(kdso),
-				   vmlinux_path[i]);
+				   vmlinux_paths.paths[i]);
 	}
 	return printed;
 }
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index ad3b7b929e94..6bf75c98e1f2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -48,8 +48,7 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map);
 static int dso__load_vdso_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
 
-int vmlinux_path__nr_entries;
-char **vmlinux_path;
+struct dso_filename_paths vmlinux_paths;
 
 struct symbol_conf symbol_conf = {
 	.nanosecs		= false,
@@ -2042,10 +2041,10 @@ int dso__load_vmlinux_path(struct dso *dso, struct map *map)
 	char *filename = NULL;
 
 	pr_debug("Looking at the vmlinux_path (%d entries long)\n",
-		 vmlinux_path__nr_entries + 1);
+		 vmlinux_paths.nr_entries + 1);
 
-	for (i = 0; i < vmlinux_path__nr_entries; ++i) {
-		err = dso__load_vmlinux(dso, map, vmlinux_path[i], false);
+	for (i = 0; i < vmlinux_paths.nr_entries; ++i) {
+		err = dso__load_vmlinux(dso, map, vmlinux_paths.paths[i], false);
 		if (err > 0)
 			goto out;
 	}
@@ -2209,7 +2208,7 @@ static int dso__load_kernel_sym(struct dso *dso, struct map *map)
 			return err;
 	}
 
-	if (!symbol_conf.ignore_vmlinux && vmlinux_path != NULL) {
+	if (!symbol_conf.ignore_vmlinux && vmlinux_paths.paths != NULL) {
 		err = dso__load_vmlinux_path(dso, map);
 		if (err > 0)
 			return err;
@@ -2284,57 +2283,55 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 	return err;
 }
 
-static void vmlinux_path__exit(void)
-{
-	while (--vmlinux_path__nr_entries >= 0)
-		zfree(&vmlinux_path[vmlinux_path__nr_entries]);
-	vmlinux_path__nr_entries = 0;
-
-	zfree(&vmlinux_path);
-}
-
-static const char * const vmlinux_paths[] = {
-	"vmlinux",
-	"/boot/vmlinux"
+struct dso_filename_pattern {
+	const char *pattern;
+	/*
+	 * 0 for matching directly,
+	 * 1 for matching by kernel_version,
+	 * 2 for matching by kernel_version + arch.
+	 */
+	int match_type;
 };
 
-static const char * const vmlinux_paths_upd[] = {
-	"/boot/vmlinux-%s",
-	"/usr/lib/debug/boot/vmlinux-%s",
-	"/lib/modules/%s/build/vmlinux",
-	"/usr/lib/debug/lib/modules/%s/vmlinux",
-	"/usr/lib/debug/boot/vmlinux-%s.debug"
+struct dso_filename_pattern vmlinux_patterns[] = {
+	{"vmlinux", 0},
+	{"/boot/vmlinux", 0},
+	{"/boot/vmlinux-%s", 1},
+	{"/usr/lib/debug/boot/vmlinux-%s", 1},
+	{"/lib/modules/%s/build/vmlinux", 1},
+	{"/usr/lib/debug/lib/modules/%s/vmlinux", 1},
+	{"/usr/lib/debug/boot/vmlinux-%s.debug", 1},
 };
 
-static int vmlinux_path__add(const char *new_entry)
+static int dso_filename_path__add(struct dso_filename_paths *paths, const char *new_entry)
 {
-	vmlinux_path[vmlinux_path__nr_entries] = strdup(new_entry);
-	if (vmlinux_path[vmlinux_path__nr_entries] == NULL)
+	paths->paths[paths->nr_entries] = strdup(new_entry);
+	if (paths->paths[paths->nr_entries] == NULL)
 		return -1;
-	++vmlinux_path__nr_entries;
+	++paths->nr_entries;
 
 	return 0;
 }
 
-static int vmlinux_path__init(struct perf_env *env)
+static void dso_filename_path__exit(struct dso_filename_paths *paths)
 {
-	struct utsname uts;
-	char bf[PATH_MAX];
-	char *kernel_version;
-	unsigned int i;
+	while (--paths->nr_entries >= 0)
+		zfree(&paths->paths[paths->nr_entries]);
+	paths->nr_entries = 0;
 
-	vmlinux_path = malloc(sizeof(char *) * (ARRAY_SIZE(vmlinux_paths) +
-			      ARRAY_SIZE(vmlinux_paths_upd)));
-	if (vmlinux_path == NULL)
-		return -1;
-
-	for (i = 0; i < ARRAY_SIZE(vmlinux_paths); i++)
-		if (vmlinux_path__add(vmlinux_paths[i]) < 0)
-			goto out_fail;
+	zfree(&paths->paths);
+}
 
-	/* only try kernel version if no symfs was given */
-	if (symbol_conf.symfs[0] != 0)
-		return 0;
+static int dso_filename_path__init(struct dso_filename_paths *paths,
+				   struct dso_filename_pattern *patterns,
+				   int nr_patterns,
+				   struct perf_env *env)
+{
+	struct utsname uts;
+	char bf[PATH_MAX];
+	const char *kernel_version;
+	const char *arch = perf_env__arch(env);
+	int i;
 
 	if (env) {
 		kernel_version = env->os_release;
@@ -2345,16 +2342,28 @@ static int vmlinux_path__init(struct perf_env *env)
 		kernel_version = uts.release;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(vmlinux_paths_upd); i++) {
-		snprintf(bf, sizeof(bf), vmlinux_paths_upd[i], kernel_version);
-		if (vmlinux_path__add(bf) < 0)
+	paths->paths = malloc(sizeof(char *) * nr_patterns);
+	if (paths->paths == NULL)
+		return -1;
+
+	for (i = 0; i < nr_patterns; i++) {
+		if (patterns[i].match_type == 0)
+			strlcpy(bf, patterns[i].pattern, sizeof(bf));
+		else if (symbol_conf.symfs[0] == 0) {
+			/* only try kernel version if no symfs was given */
+			if (patterns[i].match_type == 1)
+				snprintf(bf, sizeof(bf), patterns[i].pattern, kernel_version);
+			else if (patterns[i].match_type == 2)
+				snprintf(bf, sizeof(bf), patterns[i].pattern, kernel_version, arch);
+		}
+		if (dso_filename_path__add(paths, bf) < 0)
 			goto out_fail;
 	}
 
 	return 0;
 
 out_fail:
-	vmlinux_path__exit();
+	dso_filename_path__exit(paths);
 	return -1;
 }
 
@@ -2550,8 +2559,11 @@ int symbol__init(struct perf_env *env)
 
 	symbol__elf_init();
 
-	if (symbol_conf.try_vmlinux_path && vmlinux_path__init(env) < 0)
+	if (symbol_conf.try_vmlinux_path &&
+	    dso_filename_path__init(&vmlinux_paths, vmlinux_patterns,
+				    ARRAY_SIZE(vmlinux_patterns), env) < 0) {
 		return -1;
+	}
 
 	if (symbol_conf.field_sep && *symbol_conf.field_sep == '.') {
 		pr_err("'.' is the only non valid --field-separator argument\n");
@@ -2628,7 +2640,7 @@ void symbol__exit(void)
 	intlist__delete(symbol_conf.tid_list);
 	intlist__delete(symbol_conf.pid_list);
 	intlist__delete(symbol_conf.addr_list);
-	vmlinux_path__exit();
+	dso_filename_path__exit(&vmlinux_paths);
 	symbol_conf.sym_list = symbol_conf.dso_list = symbol_conf.comm_list = NULL;
 	symbol_conf.bt_stop_list = NULL;
 	symbol_conf.initialized = false;
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 3fb5d146d9b1..30056884945b 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -101,8 +101,12 @@ static inline int __symbol__join_symfs(char *bf, size_t size, const char *path)
 
 #define symbol__join_symfs(bf, path) __symbol__join_symfs(bf, sizeof(bf), path)
 
-extern int vmlinux_path__nr_entries;
-extern char **vmlinux_path;
+struct dso_filename_paths {
+	int nr_entries;
+	char **paths;
+};
+
+extern struct dso_filename_paths vmlinux_paths;
 
 static inline void *symbol__priv(struct symbol *sym)
 {
-- 
2.34.1

