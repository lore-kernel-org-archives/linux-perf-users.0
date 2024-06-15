Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14892E62C;
	Sat, 15 Jun 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718443247; cv=none; b=HIwAZUTOiFv8LBIiFAUDT1uFYItCKorM6/lU8XGcdYR6+x6Q6Woagjv2Su+c54lVuMYqyMbHqN+4npOtNA7tSaloMNZBqx2Ytp0ofLMLWUNzERlNKS706AyEdPfftpaXQlHVpjtRI9iS9SxNcdyTcDi+jsl9/vnovX/IublVy1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718443247; c=relaxed/simple;
	bh=JrKS3CyUqPxaMZBI/KWBgU6EbAGxygnzOr3+O9jwQdo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUr7m8146xzTkjswAQcfUHm/KKauYY+CxE68vEr5vZpjGNQLyL2+mrA9TVKTqQKWmw2Fn2cWK0Fot0lS/laxwwGAcHFN++f0TMxrLks4P2yw+thipziTR/MLvj6qK3K/gVVoj3vI7aOBgcEa4J9pwSEEmzG0DshscuC9Whba6DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4W1Vvj3q5Pz1xsSb;
	Sat, 15 Jun 2024 17:19:13 +0800 (CST)
Received: from kwepemd100011.china.huawei.com (unknown [7.221.188.204])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D83E140381;
	Sat, 15 Jun 2024 17:20:38 +0800 (CST)
Received: from M910t.huawei.com (10.110.54.157) by
 kwepemd100011.china.huawei.com (7.221.188.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 15 Jun 2024 17:20:36 +0800
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
	<llvm@lists.linux.dev>, Changbin Du <changbin.du@huawei.com>
Subject: [PATCH v2 4/4] perf: symbol: try to seach vdso path if not given by user
Date: Sat, 15 Jun 2024 17:20:15 +0800
Message-ID: <20240615092015.1820362-5-changbin.du@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240615092015.1820362-1-changbin.du@huawei.com>
References: <20240615092015.1820362-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd100011.china.huawei.com (7.221.188.204)

Just like vmlinux, try to search vdso in predefined path if it's not given
by user. The searched path usually has debugging info.

For example, the vdso can be found in
/lib/modules/<version>/build/arch/x86/entry/vdso/vdso*.so.dbg for local
build on x86.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
---
 tools/perf/builtin-annotate.c   |  1 +
 tools/perf/builtin-kallsyms.c   |  2 ++
 tools/perf/builtin-probe.c      |  2 ++
 tools/perf/builtin-top.c        |  2 ++
 tools/perf/tests/builtin-test.c |  3 ++-
 tools/perf/util/symbol.c        | 40 +++++++++++++++++++++++++++++++++
 tools/perf/util/symbol.h        |  1 +
 tools/perf/util/symbol_conf.h   |  1 +
 8 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ff466882065d..6c5019c39068 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -883,6 +883,7 @@ int cmd_annotate(int argc, const char **argv)
 		goto out_delete;
 
 	symbol_conf.try_vmlinux_path = true;
+	symbol_conf.try_vdso_path = true;
 
 	ret = symbol__init(&annotate.session->header.env);
 	if (ret < 0)
diff --git a/tools/perf/builtin-kallsyms.c b/tools/perf/builtin-kallsyms.c
index a3c2ffdc1af8..d049025a4959 100644
--- a/tools/perf/builtin-kallsyms.c
+++ b/tools/perf/builtin-kallsyms.c
@@ -63,6 +63,8 @@ int cmd_kallsyms(int argc, const char **argv)
 		usage_with_options(kallsyms_usage, options);
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
+	symbol_conf.try_vdso_path = (symbol_conf.vdso_name[0] == NULL &&
+				     symbol_conf.vdso_name[1] == NULL);
 	if (symbol__init(NULL) < 0)
 		return -1;
 
diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 003a3bcebfdf..91770eda37c0 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -667,6 +667,8 @@ __cmd_probe(int argc, const char **argv)
 	 * Only consider the user's kernel image path if given.
 	 */
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
+	symbol_conf.try_vdso_path = (symbol_conf.vdso_name[0] == NULL &&
+				     symbol_conf.vdso_name[1] == NULL);
 
 	/*
 	 * Except for --list, --del and --add, other command doesn't depend
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index a3cce4e76eb9..5a2dc7a0dbb8 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1792,6 +1792,8 @@ int cmd_top(int argc, const char **argv)
 	annotation_config__init();
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
+	symbol_conf.try_vdso_path = (symbol_conf.vdso_name[0] == NULL &&
+				     symbol_conf.vdso_name[1] == NULL);
 	status = symbol__init(NULL);
 	if (status < 0)
 		goto out_delete_evlist;
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index c3d84b67ca8e..176196e3c183 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -575,7 +575,8 @@ int cmd_test(int argc, const char **argv)
 
 	symbol_conf.priv_size = sizeof(int);
 	symbol_conf.try_vmlinux_path = true;
-
+	symbol_conf.try_vdso_path = (symbol_conf.vdso_name[0] == NULL &&
+				     symbol_conf.vdso_name[1] == NULL);
 	if (symbol__init(NULL) < 0)
 		return -1;
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 83e5c3807a2c..93bdaf213d1e 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -49,11 +49,13 @@ static int dso__load_vdso_sym(struct dso *dso, struct map *map);
 static bool symbol__is_idle(const char *name);
 
 struct dso_filename_paths vmlinux_paths;
+struct dso_filename_paths vdso_paths;
 
 struct symbol_conf symbol_conf = {
 	.nanosecs		= false,
 	.use_modules		= true,
 	.try_vmlinux_path	= true,
+	.try_vdso_path		= true,
 	.demangle		= true,
 	.demangle_kernel	= false,
 	.cumulate_callchain	= true,
@@ -2304,6 +2306,15 @@ struct dso_filename_pattern vmlinux_patterns[] = {
 	{"/usr/lib/debug/boot/vmlinux-%s.debug", 1},
 };
 
+struct dso_filename_pattern vdso_patterns[] = {
+	{"/lib/modules/%s/vdso/vdso64.so", 1},
+	{"/lib/modules/%s/vdso/vdso32.so", 1},
+	{"/lib/modules/%s/build/arch/%s/entry/vdso/vdso32.so.dbg", 2},
+	{"/lib/modules/%s/build/arch/%s/entry/vdso/vdso64.so.dbg", 2},
+	{"/lib/modules/%s/build/arch/%s/kernel/vdso/vdso.so.dbg", 2},
+	{"/lib/modules/%s/build/arch/%s/vdso/vdso.so.dbg", 2},
+};
+
 static int dso_filename_path__add(struct dso_filename_paths *paths, const char *new_entry)
 {
 	paths->paths[paths->nr_entries] = strdup(new_entry);
@@ -2418,6 +2429,22 @@ static int dso__load_vdso(struct dso *dso, struct map *map,
 	return err;
 }
 
+static int dso__load_vdso_path(struct dso *dso, struct map *map)
+{
+	int i, ret = 0;
+
+	pr_debug("Looking at the vdso_path (%d entries long)\n",
+		 vdso_paths.nr_entries + 1);
+
+	for (i = 0; i < vdso_paths.nr_entries; ++i) {
+		ret = dso__load_vdso(dso, map, vdso_paths.paths[i]);
+		if (ret > 0)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int dso__load_vdso_sym(struct dso *dso, struct map *map)
 {
 	int ret;
@@ -2433,6 +2460,12 @@ static int dso__load_vdso_sym(struct dso *dso, struct map *map)
 		}
 	}
 
+	if (vdso_paths.paths != NULL) {
+		ret = dso__load_vdso_path(dso, map);
+		if (ret > 0)
+			return ret;
+	}
+
 	return -1;
 }
 
@@ -2566,6 +2599,12 @@ int symbol__init(struct perf_env *env)
 		return -1;
 	}
 
+	if (symbol_conf.try_vdso_path &&
+	    dso_filename_path__init(&vdso_paths, vdso_patterns,
+				    ARRAY_SIZE(vdso_patterns), env) < 0) {
+		return -1;
+	}
+
 	if (symbol_conf.field_sep && *symbol_conf.field_sep == '.') {
 		pr_err("'.' is the only non valid --field-separator argument\n");
 		return -1;
@@ -2642,6 +2681,7 @@ void symbol__exit(void)
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
diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_conf.h
index 108356e3c981..58c4c4358ece 100644
--- a/tools/perf/util/symbol_conf.h
+++ b/tools/perf/util/symbol_conf.h
@@ -12,6 +12,7 @@ struct symbol_conf {
 	bool		nanosecs;
 	unsigned short	priv_size;
 	bool		try_vmlinux_path,
+			try_vdso_path,
 			init_annotation,
 			force,
 			ignore_vmlinux,
-- 
2.34.1

